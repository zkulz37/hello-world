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

public partial class rpt_EvaSumary_Detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
	   string TemplateFile = "rpt_EvaSumary_Detail.xls";
        string TempFile = "../../../system/temp/rpt_EvaSumary_Detail_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
	   
	    //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
		IPageBreaks pbs = exBook.Worksheets[1].HPageBreaks;
        IRange usedrange = exBook.Worksheets[1].UsedRange;
	   
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
	= " SELECT ROWNUM, " + 
        "  E.ORG_NM AS ORG_NM,F.WORKGROUP_NM, " +
        "  (SELECT EVA_YYYY || '-' || EVA_SEQ " +
        "    FROM THR_EVA_MASTER MS " +
        "    WHERE MS.PK = B.THR_EVA_MASTER_PK) EvaTerm, " +
        "   (SELECT GP.GROUP_NM " +
        "     FROM THR_EVA_GROUP_V2 GP " +
        "     WHERE GP.PK = B.THR_EVA_GROUP_PK) EvaGroup,  " +
		"  A.EMP_ID, " +
        "   A.FULL_NAME, " +
        "   (SELECT v.CODE_NM " +
        "   FROM vhr_hr_code v " +
        "   WHERE id = 'HR0103' AND v.code = B.EVA_EMP_STATUS) EvaStatus, " +
		" (SELECT V.CODE_NM "+
        " FROM VHR_HR_CODE V "+
        " WHERE ID = 'HR0102' AND V.CODE = B.HR_STATUS) HR_STATUS,"+
        "           B.FACTOR_NM, " +
        "          nvl(B.WEIGHT,0) WEIGHT, " +
        "           nvl(B.STANDARD_SCORE,0) STANDARD_SCORE, " +
        "          nvl(B.HR_SCORE,0) HR_SCORE , " +
        "          B.HR_OPINION, " +
        "       B.THR_EVA_EMP_PK " +
        "  FROM THR_EMPLOYEE A, " +
        "(  select      " + 
        "          a.thr_eva_emp_pk ,a.thr_emp_pk ,a.factor_type,a.factor_nm " +
        "          ,a.thr_eva_master_pk , a.thr_eva_group_pk ,a.hr_status,b.standard_score " +
        "          ,b.hr_score  ,b.final_score,a.eva_emp_status,a.hr_opinion,a.weight " +
        "  from  ( " +
        "          select     a.pk as thr_eva_emp_pk ,a.thr_emp_pk ,c.factor_type ,a.thr_eva_master_pk " +
        "                         ,c.thr_eva_group_pk ,a.eva_emp_status,c.weight,c.thr_eva_factor_pk " +
        "                         ,d.hr_status,c.factor_nm,d.hr_opinion " +
        "          from thr_eva_emp_v2 a , thr_eva_group_v2 b, " +
        "          (select g.thr_eva_group_pk,g.factor_type,g.factor_nm, g.pk as thr_eva_factor_pk,g.weight " +
        "            from  thr_eva_factor_v2 g " +
        "            where g.del_if=0 and g.factor_type ='03' " +
        "            )c, (  select  a.thr_eva_emp_pk, a.factor_type " +
        "                           ,max( a.eva_status ) hr_status " +
        "                          ,max(a.eva_opinion) hr_opinion " +
        "               from thr_eva_status a " +
        "             where  a.del_if=0 and a.factor_type= '03' " +
        "              group by  a.thr_eva_emp_pk, a.factor_type " +
        "            )d " +
        "          where a.del_if=0 and b.del_if=0  " +
        "                    and a.thr_eva_group_pk=b.pk " +
        "                    and c.thr_eva_group_pk=b.pk " +
        "                     and  a.pk = d.thr_eva_emp_pk(+) " +
        "       ) a,  " +
        "     (  select e.thr_eva_emp_pk, e.factor_nm ,e.thr_eva_factor_pk ,e.factor_type " +
        "          ,e.standard_score ,e.hr_score,e.final_score  " +
       // "           e.hr_opinion  " +
        "           from thr_eva_score_v2 e  " +
        "            where e.del_if=0 and e.factor_type= '03' " +
        "        )b " +
        "  where a.thr_eva_emp_pk = b.thr_eva_emp_pk(+) and a.thr_eva_factor_pk = b.thr_eva_factor_pk(+) " +
        "            and  a.factor_type =  b.factor_type(+)    " +
        "    ) B, " +
        "    TCO_ORG E, " +
        "       THR_WORK_GROUP F " +
        " WHERE A.DEL_IF =0  AND  E.DEL_IF =0 AND F.DEL_IF = 0  " +
        " AND  A.TCO_ORG_PK=E.PK  " +
        " AND A.THR_WG_PK=F.PK  " +
        " AND A.PK = B.THR_EMP_PK  " +
       // " AND C.PK = B.THR_EVA_EMP_PK  "+
        " AND (CASE WHEN '"+p_Grp_Code+"'='ALL' THEN '"+p_Grp_Code+"' ELSE TO_CHAR(F.PK) END)='"+p_Grp_Code+"'  " +
        " AND (   A.TCO_ORG_PK IN (  " +
        "                              SELECT     G.PK  " +
        "                                    FROM TCO_ORG G  " +
        "                                   WHERE G.DEL_IF = 0  " +
        "                             START WITH G.PK =                                           " +
        "                                (CASE WHEN '"+p_Org_Code+"'='ALL' THEN  G.PK ELSE TO_NUMBER( '"+p_Org_Code+"' ) END)  " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK)  " +
        "     )  " +
        " AND (CASE WHEN '"+p_Searchby+"' = '1' THEN UPPER(A.EMP_ID)   " +
        "            WHEN '"+p_Searchby+"'  = '2' THEN UPPER(A.FULL_FNAME)              " +
        "              WHEN '"+p_Searchby+"'  = '3' THEN UPPER(A.ID_NUM)   " +
        "           WHEN '"+p_Searchby+"'  = '4' THEN UPPER(A.PERSON_ID)   " +
        "            WHEN '"+p_Searchby+"'  = '5' THEN UPPER(A.OLD_ID)   " +
        "             END ) LIKE '%' || UPPER('"+p_Search+"' )|| '%'  " +
        "               " +
        " AND (CASE WHEN   '"+p_EvaMaster+"' ='ALL' THEN  '"+p_EvaMaster+"' ELSE  TO_CHAR(B.THR_EVA_MASTER_PK)END) = '"+p_EvaMaster+"'  " +
        " AND (CASE WHEN  '"+p_Eva_Group+"' ='ALL' THEN '"+p_Eva_Group+"' ELSE TO_CHAR(B.THR_EVA_GROUP_PK) END) = '"+p_Eva_Group+"'  " +
        //" AND (CASE WHEN '"+p_Status+"' ='ALL' THEN '"+p_Status+"' ELSE TO_CHAR(B.EVA_STATUS)END) = '"+p_Status+"'  "+
        " AND NVL(B.EVA_EMP_STATUS,'10')=(CASE WHEN '" + p_Status + "'='ALL' THEN NVL(B.EVA_EMP_STATUS,'10') ELSE '" + p_Status + "' END)" +
		"  ORDER BY     B.THR_EVA_EMP_PK  "
		
		;

		
		//Response.Write(SQL);
       // Response.End();
		
		DataTable dt_emp = ESysLib.TableReadOpen(SQL);	
		
       
		irow_emp = dt_emp.Rows.Count;
		icol_emp=dt_emp.Columns.Count;
		int spos = 7;
		int Flag = 0;
		int stt=0;
		int breakpage = 1;
		int rowstart = spos;
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
					if(j>13)
						continue;
					if (j>9 && j<13 && dt_emp.Rows[i][j].ToString()!="")
					{
						exSheet.Cells[spos+i+Flag, j +1].Value = double.Parse(dt_emp.Rows[i][j].ToString());		
					}
					else
					{
						exSheet.Cells[spos+i +Flag, j +1].Value = dt_emp.Rows[i][j].ToString();			
					}
					
            }
			//sum
            if ((i < irow_emp - 1 && float.Parse(dt_emp.Rows[i]["EMP_ID"].ToString()) != float.Parse(dt_emp.Rows[i + 1]["EMP_ID"].ToString())) || i == irow_emp - 1)
            {
                Flag = Flag + 1;
				stt= stt+1;
				//merg row
                exSheet.Range[spos + i + Flag, 1].Rows.EntireRow.Insert();
				exSheet.Range["B" + (spos + i + Flag) + ":J" + (spos + i + Flag)].Merge();
				exSheet.Range["B" + (spos + i + Flag) + ":N" + (spos + i + Flag)].Interior.Color = Color.FromArgb(217, 217, 217);
                exSheet.Range["B" + (spos + i + Flag) + ":N" + (spos + i + Flag)].Font.Bold = true;
				exSheet.Range["B" + (spos + i + Flag) + ":N" + (spos + i + Flag)].HorizontalAlignment = XlHAlign.xlHAlignRight;
                exSheet.Range["B" + (spos + i + Flag) + ":J" + (spos + i + Flag)].Value = "Total";
				
                for ( int j = 11; j < icol_emp -2; j++)
                {
                    object temp = dt_emp.Compute("SUM(" + dt_emp.Columns[j].ColumnName + ")", "EMP_ID=" + dt_emp.Rows[i]["EMP_ID"].ToString());
                    exSheet.Cells[spos + i + Flag, j+1].Value = temp;
                }
				//merg
				exSheet.Range["A" + rowstart + ":A" + (spos + i + Flag)].Merge();
				exSheet.Range["A" + rowstart + ":A" + (spos + i + Flag)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["A" + rowstart + ":A" + (spos + i + Flag)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["A" + rowstart].Value = stt;
				
				//exSheet.Range["A" + rowstart + ":A" + (spos + i + Flag-1)].Merge();
				//exSheet.Range["A" + rowstart].Value = stt;
				
				exSheet.Range["B" + rowstart + ":B" + (spos + i + Flag-1)].Merge();
				exSheet.Range["B" + rowstart + ":B" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["B" + rowstart + ":B" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["B" + rowstart].Value = dt_emp.Rows[i]["ORG_NM"].ToString();
				
				exSheet.Range["C" + rowstart + ":C" + (spos + i + Flag-1)].Merge();
				exSheet.Range["C" + rowstart + ":C" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["C" + rowstart + ":C" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["C" + rowstart].Value = dt_emp.Rows[i]["WORKGROUP_NM"].ToString();
					
				exSheet.Range["D" + rowstart + ":D" + (spos + i + Flag-1)].Merge();
				exSheet.Range["D" + rowstart + ":D" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["D" + rowstart + ":D" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["D" + rowstart].Value = dt_emp.Rows[i]["EvaTerm"].ToString();
					
				exSheet.Range["E" + rowstart + ":E" + (spos + i + Flag-1)].Merge();
				exSheet.Range["E" + rowstart + ":E" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["E" + rowstart + ":E" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["E" + rowstart].Value = dt_emp.Rows[i]["EvaGroup"].ToString();
				
				exSheet.Range["F" + rowstart + ":F" + (spos + i + Flag-1)].Merge();
				exSheet.Range["F" + rowstart + ":F" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["F" + rowstart + ":F" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["F" + rowstart].Value = dt_emp.Rows[i]["EMP_ID"].ToString();
					
				exSheet.Range["G" + rowstart + ":G" + (spos + i + Flag-1)].Merge();
			//	exSheet.Range["G" + rowstart + ":G" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["G" + rowstart + ":G" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["G" + rowstart].Value = dt_emp.Rows[i]["FULL_NAME"].ToString();
					
				exSheet.Range["H" + rowstart + ":H" + (spos + i + Flag-1)].Merge();
				exSheet.Range["H" + rowstart + ":H" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["H" + rowstart + ":H" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["H" + rowstart].Value = dt_emp.Rows[i]["EvaStatus"].ToString();
				
				exSheet.Range["I" + rowstart + ":I" + (spos + i + Flag-1)].Merge();
				exSheet.Range["I" + rowstart + ":I" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["I" + rowstart + ":I" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["I" + rowstart].Value = dt_emp.Rows[i]["HR_STATUS"].ToString();
				
				exSheet.Range["N" + rowstart + ":N" + (spos + i + Flag-1)].Merge();
				exSheet.Range["N" + rowstart + ":N" + (spos + i + Flag-1)].HorizontalAlignment = XlHAlign.xlHAlignCenter;
				exSheet.Range["N" + rowstart + ":n" + (spos + i + Flag-1)].VerticalAlignment = XlVAlign.xlVAlignCenter;
				exSheet.Range["N" + rowstart].Value = dt_emp.Rows[i]["HR_OPINION"].ToString();
				
				rowstart = spos + i + Flag + 1;
				 if(stt==10*breakpage)
				 {
					pbs.Add(usedrange.Rows[i+ 7]);
					breakpage= breakpage+1;
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