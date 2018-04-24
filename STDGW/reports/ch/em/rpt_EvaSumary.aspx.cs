using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class rpt_EvaSumary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
	   string TemplateFile = "rpt_EvaSumary.xls";
        string TempFile = "../../../system/temp/rpt_EvaSumary_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
	   
	   
	    //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        // exBook.Names = "Báo cáo OT Nhân Viên";
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
	   
	 string p_Org_Code,p_Grp_Code,p_Searchby,p_Search,p_EvaMaster,p_Eva_Group,p_Status;	
	 
	 p_Org_Code = Request["p_Org_Code"].ToString();
	 p_Grp_Code = Request["p_Grp_Code"].ToString();
	 p_Searchby = Request["p_Searchby"].ToString();
	 p_Search = Request["p_Search"].ToString();
	 p_EvaMaster = Request["p_EvaMaster"].ToString();
	 p_Eva_Group = Request["p_Eva_Group"].ToString();
	 p_Status =  Request["p_Status"].ToString();
	 
	 int irow_emp,icol_emp;
	
	string SQL
	=   " SELECT ROWNUM, " + 
        "         E.ORG_NM AS ORG_NM,  f.workgroup_nm, " +
        "      (SELECT EVA_YYYY ||'-'|| EVA_SEQ FROM THR_EVA_MASTER MS WHERE MS.PK = B.THR_EVA_MASTER_PK) EvaTerm , " +
        "     ( SELECT GP.GROUP_NM FROM THR_EVA_GROUP_V2 GP  WHERE GP.PK =   B.THR_EVA_GROUP_PK) EvaGroup, " +
		  "       A.EMP_ID, " +
        "       A.FULL_NAME, " +
        "     (select v.CODE_NM from vhr_hr_code v where id='HR0103' AND  v.code = B.EVA_EMP_STATUS) EvaStatus, " +
        "       B.HR_SCORE " +
        //"       B.THR_EVA_EMP_PK " +
        " FROM  THR_EMPLOYEE A,  " +
        "	(  " +
		"  SELECT   A.THR_EVA_EMP_PK ,A.THR_EMP_PK ,A.FACTOR_TYPE " + 
        "             ,A.THR_EVA_MASTER_PK , A.THR_EVA_GROUP_PK  " +
        "             ,A.HR_STATUS,B.HR_SCORE  ,B.FINAL_SCORE,A.EVA_EMP_STATUS " +
        "    FROM  " +
        "          ( SELECT       A.PK AS THR_EVA_EMP_PK ,A.THR_EMP_PK ,C.FACTOR_TYPE ,A.THR_EVA_MASTER_PK " +
        "                         ,C.THR_EVA_GROUP_PK ,A.EVA_EMP_STATUS ,MAX(D.HR_STATUS)HR_STATUS " +
        "             FROM THR_EVA_EMP_V2 A , THR_EVA_GROUP_V2 B, " +
        "          (SELECT G.THR_EVA_GROUP_PK,G.FACTOR_TYPE " +
        "            FROM  THR_EVA_FACTOR_V2 G " +
        "            WHERE G.DEL_IF=0 AND G.FACTOR_TYPE ='03' " +
        "            )C,  (  SELECT  A.THR_EVA_EMP_PK, A.FACTOR_TYPE " +
        "                       ,MAX( A.EVA_STATUS)  HR_STATUS " +
        "               FROM THR_EVA_STATUS A " +
        "               WHERE  A.DEL_IF=0 AND A.FACTOR_TYPE= '03' " +
        "                 GROUP BY  A.THR_EVA_EMP_PK, A.FACTOR_TYPE " +
        "           )D " +
        "   WHERE A.DEL_IF=0 AND B.DEL_IF=0  " +
        "               AND A.THR_EVA_GROUP_PK=B.PK " +
        "                AND C.THR_EVA_GROUP_PK=B.PK " +
        "                 AND  A.PK = D.THR_EVA_EMP_PK(+) " +
        "            GROUP BY A.PK,A.THR_EMP_PK,C.FACTOR_TYPE,A.THR_EVA_MASTER_PK,A.EVA_EMP_STATUS,C.THR_EVA_GROUP_PK " +
        "            ) A,  " +
        "          (  SELECT E.THR_EVA_EMP_PK  ,E.FACTOR_TYPE  " +
        "                        ,SUM( E.HR_SCORE) HR_SCORE " +
        "                         ,SUM(E.FINAL_SCORE) FINAL_SCORE " +
        "             FROM THR_EVA_SCORE_V2 E " +
        "         WHERE E.DEL_IF=0  AND E.FACTOR_TYPE ='03' " +
        "         GROUP BY E.THR_EVA_EMP_PK,E.FACTOR_TYPE   " +
        "         )B " +
        "    WHERE A.THR_EVA_EMP_PK = B.THR_EVA_EMP_PK(+) AND " +
        "                 A.FACTOR_TYPE =  B.FACTOR_TYPE(+)   " +
        "	) B  " +
        "  ,TCO_ORG E,THR_WORK_GROUP F  " +
        " WHERE A.DEL_IF =0  AND  E.DEL_IF =0 AND F.DEL_IF = 0 " +
        " AND  A.TCO_ORG_PK=E.PK " +
        " AND A.THR_WG_PK=F.PK " +
        " AND A.PK = B.THR_EMP_PK " +
       
        " AND (CASE WHEN '"+p_Grp_Code+"'='ALL' THEN '"+p_Grp_Code+"' ELSE TO_CHAR(F.PK) END)='"+p_Grp_Code+"' " +
        " AND (   A.TCO_ORG_PK IN ( " +
        "                              SELECT     G.PK " +
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                             START WITH G.PK =                                          " +
        "                                (CASE WHEN '"+p_Org_Code+"'='ALL' THEN  G.PK ELSE TO_NUMBER( '"+p_Org_Code+"' ) END) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "     ) " +
        " AND (CASE WHEN '"+p_Searchby+"' = '1' THEN UPPER(A.EMP_ID)  " +
        "            WHEN '"+p_Searchby+"'  = '2' THEN UPPER(A.FULL_FNAME)             " +
        "              WHEN '"+p_Searchby+"'  = '3' THEN UPPER(A.ID_NUM)  " +
        "           WHEN '"+p_Searchby+"'  = '4' THEN UPPER(A.PERSON_ID)  " +
        "            WHEN '"+p_Searchby+"'  = '5' THEN UPPER(A.OLD_ID)  " +
        "             END ) LIKE '%' || UPPER('"+p_Search+"' )|| '%' " +
        "              " +
        " AND (CASE WHEN   '"+p_EvaMaster+"' ='ALL' THEN  '"+p_EvaMaster+"' ELSE  TO_CHAR(B.THR_EVA_MASTER_PK)END) = '"+p_EvaMaster+"' " +
        " AND (CASE WHEN  '"+p_Eva_Group+"' ='ALL' THEN '"+p_Eva_Group+"' ELSE TO_CHAR(B.THR_EVA_GROUP_PK) END) = '"+p_Eva_Group+"' " +
        //" AND (CASE WHEN '"+p_Status+"' ='ALL' THEN '"+p_Status+"' ELSE TO_CHAR(B.EVA_STATUS)END) = '"+p_Status+"' " 
        " AND NVL(B.EVA_EMP_STATUS,'10')=(CASE WHEN '" + p_Status + "'='ALL' THEN NVL(B.EVA_EMP_STATUS,'10') ELSE '" + p_Status + "' END) "
        ;

	//	Response.Write(SQL);
       // Response.End();
		
		DataTable dt_emp = ESysLib.TableReadOpen(SQL);	
		
       
		irow_emp = dt_emp.Rows.Count;
		icol_emp=dt_emp.Columns.Count;
		int spos = 7;
        if (dt_emp.Rows.Count == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }				
		
		exSheet.Cells["C2"].Value = Session["User_ID"].ToString();
        exSheet.Cells["C3"].Value = DateTime.Today.ToString("dd/MM/yyyy");
		
		for (int i = 1; i < irow_emp; i++)
        {
            exSheet.Range[spos + i, 1].Rows.EntireRow.Insert();
        }
		
		
		
		
        for (int i = 0; i < irow_emp; i++)
        {					
			
            for (int j = 0; j < icol_emp; j++)
            {		         		
					if (j==8 && dt_emp.Rows[i][j].ToString()!="")
					{
						exSheet.Cells[spos+i, j +1].Value = double.Parse(dt_emp.Rows[i][j].ToString());		
					}
					else
					{
						exSheet.Cells[spos+i, j +1].Value = dt_emp.Rows[i][j].ToString();			
					}
					
            }
        }
		
					
		
		
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        //range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;
        
        exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        //string pdfFilePath = TempFile.Replace(".xls", ".pdf");

        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        //System.IO.FileInfo file = new System.IO.FileInfo(pdfFilePath);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Response.ContentType = "application/pdf";
        //Send file string to client 
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();
    }
    
  
}