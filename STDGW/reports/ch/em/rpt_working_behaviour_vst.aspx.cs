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

public partial class rpt_working_behaviour_vst : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //ESysLib.SetUser(Session["APP_DBUSER"].ToString());
     //  ESysLib.SetUser(Session["APP_DBUSER"].ToString());	   
	 //  string P_COST_KIND       = Request["P_COST_KIND"].ToString();
	 //  string P_TAC_ABPL_PK     = Request["P_TAC_ABPL_PK"].ToString();
	 string p_thr_eva_master_pk,P_SEARCH_BY,P_SEARCH_TEMP,P_TCO_ORG_PK,p_userpk,p_work_group;	
	 p_thr_eva_master_pk = Request["p_thr_eva_master_pk"].ToString();
	 P_TCO_ORG_PK = Request["P_TCO_ORG_PK"].ToString();
	 P_SEARCH_BY = Request["P_SEARCH_BY"].ToString();
	 P_SEARCH_TEMP = Request["P_SEARCH_TEMP"].ToString();
	 p_userpk = Request["p_userpk"].ToString();
	 p_work_group = Request["p_work_group"].ToString();
	 int irow_emp,icol_emp;
	
	string SQL
    = "SELECT  " + 
        "O.ORG_NM,E.EMP_ID,E.FULL_NAME,(select v.code_nm from vhr_hr_code v where v.id='HR0008' and v.code=e.pos_type) Position " +
        ",(select v.code_nm from vhr_hr_code v where v.id='HR0010' and v.code=e.job_type) JobNM " +
        ",decode ( length(E.JOIN_DT),8,to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy'),6,to_char(to_date(E.JOIN_DT,'yyyymm'),'mm/yyyy'),E.JOIN_DT) JoinDt " +
        ",NVL((select NVL(EV.POINT,0) from thr_eva_emp_other ev where ev.del_if =0 and EV.GROUP_TYPE ='HR0170' and EV.POINT_TYPE ='01'AND EV.THR_EVA_EMP_PK = A.PK),0) as TC01 " +
        ",NVL((select NVL(EV.POINT,0) from thr_eva_emp_other ev where ev.del_if =0  and EV.GROUP_TYPE ='HR0170' and EV.POINT_TYPE ='02'AND EV.THR_EVA_EMP_PK = A.PK),0) as TC02 " +
        ",NVL((select NVL(EV.POINT,0) from thr_eva_emp_other ev where ev.del_if =0  and EV.GROUP_TYPE ='HR0170' and EV.POINT_TYPE ='03'AND EV.THR_EVA_EMP_PK = A.PK),0) as TC03 " +
      //  ",NVL((select NVL(EV.POINT,0) from thr_eva_emp_other ev where ev.del_if =0  and EV.GROUP_TYPE ='HR0171' and EV.POINT_TYPE ='04' AND EV.THR_EVA_EMP_PK = A.PK),0) as TC04 " +
	  //",NVL((select NVL(EV.POINT,0) from thr_eva_emp_other ev where ev.del_if =0  and EV.GROUP_TYPE ='HR0171' and EV.POINT_TYPE ='05' AND EV.THR_EVA_EMP_PK = A.PK),0) as TC05 " +
        ",nvl(A.OTHER_SCORE1,0) OTHER_SCORE1 " +
        "FROM thr_eva_emp a,thr_employee e,TCO_ORG o,THR_EVA_EMP_REVIEWER b, THR_EVA_REVIEWER c,THR_WORK_GROUP w " +
        "where  e.del_if =0 and o.del_if =0  AND A.DEL_IF =0 and b.del_if = 0 and c.del_if =0 AND w.DEL_IF=0 AND e.THR_WG_PK=w.PK  AND DECODE('" + p_work_group + "','ALL','ALL',w.PK)= '" + p_work_group + "'   " +
        " and o.pk = E.TCO_ORG_PK " +
		" and B.THR_EVA_REVIEWER_PK=c.pk "+
		" and B.REVIEWER_LEVEL=2 "+
		" and B.THR_EVA_EMP_PK=a.pk "+
		" and c.THR_EMPLOYEE_PK ='"+ p_userpk +"' "+	
		" and C.THR_EVA_MASTER_PK = '" + p_thr_eva_master_pk + "'"+
		" and DECODE('" + p_thr_eva_master_pk + "','ALL','ALL',A.THR_EVA_MASTER_PK ) =  '" + p_thr_eva_master_pk + "' "+	
		"AND (('"+ P_SEARCH_BY +"'='1' AND UPPER(e.FULL_NAME) LIKE  '%' || UPPER('"+ P_SEARCH_TEMP +"')|| '%') " + 
        "         OR ('"+ P_SEARCH_BY +"'='2' AND UPPER(e.EMP_ID) LIKE  '%' || UPPER('"+ P_SEARCH_TEMP +"')|| '%') " +
        "         OR ('"+ P_SEARCH_BY +"'='3' AND UPPER(e.ID_NUM) LIKE  '%' || UPPER('"+ P_SEARCH_TEMP +"')|| '%' ) " +
        "         OR ('"+ P_SEARCH_BY +"'='4' AND UPPER(e.PERSON_ID ) LIKE  '%' || UPPER('"+ P_SEARCH_TEMP +"')|| '%') " +
        "         )  " +
		" AND (   e.TCO_ORG_PK IN ( " + 
        "                              SELECT     G.PK " +
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +        
        "                              START WITH G.PK = " +
        "                                            DECODE ('"+ P_TCO_ORG_PK +"', " +
        "                                                    'ALL', 0, " +
        "                                                    '"+ P_TCO_ORG_PK +"' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '"+ P_TCO_ORG_PK +"' = 'ALL')     " +
        "AND A.THR_EMPLOYEE_PK = E.PK " ;
		
		//Response.Write(SQL);
        //Response.End();
		
		DataTable dt_emp = ESysLib.TableReadOpen(SQL);	
		string TemplateFile = "rpt_working_behaviour_vst.xls";
        string TempFile = "../../../system/temp/rpt_working_behaviour_vst_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
		
		string SQL_PTYPE;
		SQL_PTYPE = 
		" select V.Code_nm from vhr_hr_code v " +
		" where v.id ='HR0170' " +
		" UNION all  " + 
        " SELECT 'Sum Point' as Code_nm " +
        " from dual ";
		
		DataTable dt_colums = ESysLib.TableReadOpen(SQL_PTYPE);
		int coltype ;
		coltype = dt_colums.Rows.Count;
		if (coltype == 0)
		{
			Response.Write("There is no colums show");
            Response.End();
		}
		
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;		
		irow_emp = dt_emp.Rows.Count;
		icol_emp=dt_emp.Columns.Count;
        if (dt_emp.Rows.Count == 0)
        {
            Response.Write("There is no data");
            Response.End();
        }				
		int spos = 6;       
        int inumber_col=1;
		for (int i = 1; i < irow_emp; i++)
        {
            exSheet.Range[spos + i, 1].Rows.EntireRow.Insert();
        }
		
		for( int i = 0 ; i< coltype ;i++)
		{
			exSheet.Range["H5:H5"].Copy(exSheet.Range[5,8,5,8+i], XlPasteType.xlPasteAll);		
			for(int j = 0 ; j<icol_emp ;j++)
			{
				exSheet.Range["H6:H6"].Copy(exSheet.Range[6,8,5+irow_emp,8+i], XlPasteType.xlPasteAll);	
			}				
		}
		for( int i = 0 ; i< coltype ;i++)
		{			
			exSheet.Cells[5, 8+i].Value = dt_colums.Rows[i][0].ToString();	
		}
		
         for (int i = 0; i < irow_emp; i++)
        {					
			
            for (int j = 0; j < icol_emp; j++)
            {		         		
					if (j>5)
					{
						exSheet.Cells[spos+i, j +2].Value = double.Parse(dt_emp.Rows[i][j].ToString());		
					}
					else
					{
						exSheet.Cells[spos+i, j +2].Value = dt_emp.Rows[i][j].ToString();			
					}
					
            }
			exSheet.Cells[spos+i, 1].Value = i+1;
        }
		
					
		exSheet.Cells[4, 2].Value = "Report Date: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm");
		
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