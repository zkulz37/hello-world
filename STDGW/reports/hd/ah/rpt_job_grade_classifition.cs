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

public partial class rpt_job_grade_classifition : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser("hr");

        string TemplateFile = "rpt_job_grade_classifition.xls";
        string TempFile = "../../../system/temp/rpt_job_grade_classifition_"+ DateTime.Now.ToString("hhmmss") + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;
			
        string p_nation = "01";// Request["p_nation"].ToString();
        //string p_org_pk = Request["l_org"].ToString();
        string  p_fromdt  = Request["p_fromdt"].ToString();
       	
		string SQL
	= 
		"select * from ( "+
		" SELECT  " + 
        "        '1' as STT,  " +
		"		 'Maternity' branch,	"+
        "        'Maternity' as ORG_TYPE, " +
        "        nvl(max(sum(case  when e.pos_type ='05' then 1 else 0 end )),0) AS GENERAL, " +
        "        nvl(max(sum(case  when e.pos_type ='01' then 1 else 0 end )),0) AS DEPUTY_GEN, " +
        "        nvl(max(sum(case  when e.pos_type ='06' then 1 else 0 end )),0) AS GENERAL_MANA, " +
        "        nvl(max(sum(case  when e.pos_type ='04' then 1 else 0 end )),0) AS DIRECTOR, " +
        "        nvl(max(sum(case  when e.pos_type ='02' then 1 else 0 end )),0) AS DEPUTY_GENER, " +
        "        nvl(max(sum(case  when e.pos_type ='14' then 1 else 0 end )),0) AS DEPUTY_DIREC, " +
        "        nvl(max(sum(case  when e.pos_type ='09' then 1 else 0 end )),0) AS SENIOR_MANA, " +
        "        nvl(max(sum(case  when e.pos_type ='07' then 1 else 0 end )),0) AS MANAGER_, " +
        "        nvl(max(sum(case  when e.pos_type ='03' then 1 else 0 end )),0) AS DEPUTY_MANA, " +
        "        nvl(max(sum(case  when e.pos_type ='11' then 1 else 0 end )),0) AS SENIOR_SUPER, " +
        "        nvl(max(sum(case  when e.pos_type ='13' then 1 else 0 end )),0) AS SUPER_VISI, " +
        "        nvl(max(sum(case  when e.pos_type ='10' then 1 else 0 end )),0) AS SENIOR_OFF, " +
        "        nvl(max(sum(case  when e.pos_type ='08' then 1 else 0 end )),0) AS OFFICER, " +
        "        nvl(max(sum(case  when e.pos_type ='12' then 1 else 0 end )),0) AS STAFF, " +
        "        nvl(max(sum(1)),0) AS TOTAL, 1 seq " +
        "        from thr_employee e ,thr_absence b " +
        "        where e.del_if = 0  " +
        "        and b.del_if = 0  " +
        "        and e.pk = B.THR_EMP_PK  " +
        "        and b.absence_type ='04'  " +
        "        and (E.LEFT_DT is null or E.LEFT_DT >= '"+ p_fromdt +"')  " +
        "        and b.absence_dt ='"+ p_fromdt +"' " +
        "        group by e.pk " +
        "        union all " +
        "        select  " +
        "        '2' as STT, " +
		"        F_GET_ORG_LEVEL2(E.TCO_ORG_PK2,'01','NAME') as branch , " +
        "        F_GET_ORG_LEVEL2(E.TCO_ORG_PK2,'02','NAME') as ORG_TYPE , " +
        "        sum(case  when e.pos_type ='05' then 1 else 0 end ) AS GENERAL, " +
        "        sum(case  when e.pos_type ='01' then 1 else 0 end ) AS DEPUTY_GEN, " +
        "        sum(case  when e.pos_type ='06' then 1 else 0 end ) AS GENERAL_MANA, " +
        "        sum(case  when e.pos_type ='04' then 1 else 0 end ) AS DIRECTOR, " +
        "        sum(case  when e.pos_type ='02' then 1 else 0 end ) AS DEPUTY_GENER, " +
        "        sum(case  when e.pos_type ='14' then 1 else 0 end ) AS DEPUTY_DIREC, " +
        "        sum(case  when e.pos_type ='09' then 1 else 0 end ) AS SENIOR_MANA, " +
        "        sum(case  when e.pos_type ='07' then 1 else 0 end ) AS MANAGER_, " +
        "        sum(case  when e.pos_type ='03' then 1 else 0 end ) AS DEPUTY_MANA, " +
        "        sum(case  when e.pos_type ='11' then 1 else 0 end ) AS SENIOR_SUPER, " +
        "        sum(case  when e.pos_type ='13' then 1 else 0 end ) AS SUPER_VISI, " +
        "        sum(case  when e.pos_type ='10' then 1 else 0 end ) AS SENIOR_OFF, " +
        "        sum(case  when e.pos_type ='08' then 1 else 0 end ) AS OFFICER, " +
        "        sum(case  when e.pos_type ='12' then 1 else 0 end )  AS STAFF, " +
        "        sum(1) AS TOTAL, 2 seq " +
        "        from thr_employee e  " +
        "        where e.del_if = 0 " +
        "        and (E.LEFT_DT is null or E.LEFT_DT >= '"+ p_fromdt +"')  " +
        "        group by F_GET_ORG_LEVEL2(E.TCO_ORG_PK2,'01','NAME'), F_GET_ORG_LEVEL2(E.TCO_ORG_PK2,'02','PK'),F_GET_ORG_LEVEL2(E.TCO_ORG_PK2,'02','NAME')                 " +
        "        UNION ALL " +
        "        SELECT  " +
        "        '3' as STT,  " +
		"        'MALE' as branch , " +
        "        'MALE' as ORG_TYPE, " +
        "        sum(case  when e.pos_type ='05' then 1 else 0 end ) AS GENERAL, " +
        "        sum(case  when e.pos_type ='01' then 1 else 0 end ) AS DEPUTY_GEN, " +
        "        sum(case  when e.pos_type ='06' then 1 else 0 end ) AS GENERAL_MANA, " +
        "        sum(case  when e.pos_type ='04' then 1 else 0 end ) AS DIRECTOR, " +
        "        sum(case  when e.pos_type ='02' then 1 else 0 end ) AS DEPUTY_GENER, " +
        "        sum(case  when e.pos_type ='14' then 1 else 0 end ) AS DEPUTY_DIREC, " +
        "        sum(case  when e.pos_type ='09' then 1 else 0 end ) AS SENIOR_MANA, " +
        "        sum(case  when e.pos_type ='07' then 1 else 0 end ) AS MANAGER_, " +
        "        sum(case  when e.pos_type ='03' then 1 else 0 end ) AS DEPUTY_MANA, " +
        "        sum(case  when e.pos_type ='11' then 1 else 0 end ) AS SENIOR_SUPER, " +
        "        sum(case  when e.pos_type ='13' then 1 else 0 end ) AS SUPER_VISI, " +
        "        sum(case  when e.pos_type ='10' then 1 else 0 end ) AS SENIOR_OFF, " +
        "        sum(case  when e.pos_type ='08' then 1 else 0 end ) AS OFFICER, " +
        "        sum(case  when e.pos_type ='12' then 1 else 0 end )  AS STAFF, " +
        "        sum(1) AS TOTAL, 3 seq " +
        "        from thr_employee e  " +
        "        where e.del_if = 0  " +
        "        and (E.LEFT_DT is null or E.LEFT_DT >= '"+ p_fromdt +"')  " +
        "        and E.SEX = 'M' " +
        "        UNION ALL " +
        "        SELECT  " +
        "        '4' as STT,  " +
		"        'FEMALE' as branch, " +
        "        'FEMALE' as ORG_TYPE, " +
        "        sum(case  when e.pos_type ='05' then 1 else 0 end ) AS GENERAL, " +
        "        sum(case  when e.pos_type ='01' then 1 else 0 end ) AS DEPUTY_GEN, " +
        "        sum(case  when e.pos_type ='06' then 1 else 0 end ) AS GENERAL_MANA, " +
        "        sum(case  when e.pos_type ='04' then 1 else 0 end ) AS DIRECTOR, " +
        "        sum(case  when e.pos_type ='02' then 1 else 0 end ) AS DEPUTY_GENER, " +
        "        sum(case  when e.pos_type ='14' then 1 else 0 end ) AS DEPUTY_DIREC, " +
        "        sum(case  when e.pos_type ='09' then 1 else 0 end ) AS SENIOR_MANA, " +
        "        sum(case  when e.pos_type ='07' then 1 else 0 end ) AS MANAGER_, " +
        "        sum(case  when e.pos_type ='03' then 1 else 0 end ) AS DEPUTY_MANA, " +
        "        sum(case  when e.pos_type ='11' then 1 else 0 end ) AS SENIOR_SUPER, " +
        "        sum(case  when e.pos_type ='13' then 1 else 0 end ) AS SUPER_VISI, " +
        "        sum(case  when e.pos_type ='10' then 1 else 0 end ) AS SENIOR_OFF, " +
        "        sum(case  when e.pos_type ='08' then 1 else 0 end ) AS OFFICER, " +
        "        sum(case  when e.pos_type ='12' then 1 else 0 end )  AS STAFF, " +
        "        sum(1) AS TOTAL, 4 seq " +
        "        from thr_employee e  " +
        "        where e.del_if = 0  " +
        "        and (E.LEFT_DT is null or E.LEFT_DT >= '"+ p_fromdt +"')  " +
        "        and E.SEX = 'F' )" +
		"order by stt,seq,2,3,4 " ;        


		// Response.Write(SQL);
        // Response.End();   

		DataTable dt_emp = new DataTable();
        dt_emp = ESysLib.TableReadOpen(SQL);
		int irow_emp = dt_emp.Rows.Count;
        int icol_emp = dt_emp.Columns.Count;

        //Response.Write(SQL);
        //Response.End();   

        int l_row = 3,l_col = 0, n_dept=0, flag;
        int irow, icol;
        irow = dt_emp.Rows.Count;
        icol = dt_emp.Columns.Count;
		double[] grp_total = new double[icol_emp];
		
		int row_temp = 0 ,col_temp = 0 ;
		int i=0,j = 0 ;
		
		for (i = 0; i < dt_emp.Rows.Count - 1; i++)
        {
            if (dt_emp.Rows[i]["branch"].ToString() != dt_emp.Rows[i + 1]["branch"].ToString())
                n_dept++;
        }
		
		for (i= 0 ;i<dt_emp.Rows.Count-1 + n_dept +1;i++)
		{
			exSheet.Range[l_row + i + 1, 1].Rows.EntireRow.Insert();	
		}			
		
		for ( i = 0 ;i < irow ; i++ )
		{		
			if ((i == irow_emp - 1) || (dt_emp.Rows[i]["branch"].ToString() != dt_emp.Rows[i + 1]["branch"].ToString()))
                flag = 0;
            else
                flag = 1;
			for (j=1;j<dt_emp.Columns.Count;j++)
			{
				exSheet.Cells[l_row , 1 + j ].Value = dt_emp.Rows[i][j].ToString();
				if (j>2)
				{
					exSheet.Cells[l_row, 1+ j ].Value = double.Parse(dt_emp.Rows[i][j].ToString());	
					grp_total[j] += double.Parse(dt_emp.Rows[i][j].ToString());
				}
				
			}
			if (flag == 0)
            {
                exSheet.Cells[l_row + 1, 2].Value = "TOTAL OF " + dt_emp.Rows[i]["branch"].ToString();
				exSheet.Range[l_row + 1, 2, l_row + 1, 18].Interior.Color = Color.Yellow;

                for (int k = 3; k < icol_emp-1; k++)
                {
                    exSheet.Cells[l_row + 1, k+1].Value = grp_total[k];
                    grp_total[k] = 0;
                }
				l_row++;
            }						
			l_row++;	
		}      


        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


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
    public static bool IsNumeric(string strNum)
    {
        try
        {
            double tmp = double.Parse(strNum);
            return true;
        }
        catch
        {
            return false;
        }
    }
}