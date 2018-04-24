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

public partial class rpt_salary_event : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {        
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_dept, p_position, p_status, p_search_by, p_search_temp, p_workmonth, p_from_join, p_to_join, p_money_kind, p_type;

        p_dept = Request["org"].ToString();
        p_position = Request["position"].ToString();
        p_status = Request["status"].ToString();
        p_search_by = Request["search_by"].ToString();
        p_search_temp = Request["search_temp"].ToString();
        p_workmonth = Request["workmonth"].ToString();
        p_from_join = Request["from_join"].ToString();
        p_to_join = Request["to_join"].ToString();
        p_money_kind = Request["money_kind"].ToString();
        p_type = Request["l_type"].ToString();

        string TemplateFile = "rpt_salary_event.xls";
        string TempFile = "../../../system/temp/rpt_salary_event_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

         //Create a new workbook
		IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

		//Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];
		IRange range;
		DataTable myDT;
		
		/*
		myDT = new DataTable();
		SQL = "SELECT TO_CHAR(SYSDATE,'dd/mm/yyyy') FROM DUAL";
		myDT = ESysLib.TableReadOpen(SQL);
		exSheet.Cells["A2"].Value = string.Format("(SALARY CYCLE: TO 26/07/2012 25/08/2012)", myDT.Rows[0][0].ToString());
		*/

        
        string p_sql = "";

        if (p_type == "ALL")//all
        {
            p_sql = "           and (NVL(S.ORG_NM,'')<>NVL(S2.ORG_NM,'') " +
               "                OR NVL(S.POS_NM,'')<>NVL(S2.POS_NM,'') " +
               "                OR NVL(S.SALARY_LEVEL2,0)<>NVL(S2.SALARY_LEVEL2,0) " +
               "                OR NVL(S.ALLOW_AMT1,0)<>NVL(S2.ALLOW_AMT1,0) " +
               "               )  ";
        }
        else if (p_type == "01")//sal
        {
            p_sql = " and NVL(S.SALARY_LEVEL2,0)<>NVL(S2.SALARY_LEVEL2,0) ";
        }
        else if (p_type == "02")//org
        {
            p_sql = " and NVL(S.ORG_NM,'')<>NVL(S2.ORG_NM,'') ";
        }
        else if (p_type == "03")//pos
        {
            p_sql = " and NVL(S.POS_NM,'')<>NVL(S2.POS_NM,'') ";
        }
        


		
		myDT = new DataTable();

        string SQL
     = "select g.org_nm C0, " + //0 1
         "    (select code_nm from vhr_hr_code where id='HR0008' and code=e.pos_type) C1, " + //2
         "    e.emp_id c2,e.full_name c3,to_char(to_date(e.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c4, " +  // 3 4 5
         "    to_char(to_date(s.work_mon,'yyyymm'),'mm/yyyy') c5, " + //6
         "    s2.salary_level2 as old_sal,s.SALARY_LEVEL2 as new_sal,to_char(to_date(s.CONFIRM_DT,'yyyymmdd'),'dd/mm/yyyy') c8 " + //7 8 9
         "    ,s2.ORG_NM as old_ORG,s.ORG_NM as new_ORG,to_char(to_date(s.ORG_DT,'yyyymmdd'),'dd/mm/yyyy') " + //7 8 9
         "    ,s2.POS_NM as old_POS,s.POS_NM as new_POS,to_char(to_date(s.POSITION_DT,'yyyymmdd'),'dd/mm/yyyy') c14,s.remark_sal " + //7 8 9
         "    from thr_salary_manage s,thr_employee e,thr_salary_manage s2,tco_org g " +
         "    where s.del_if=0 and e.del_if=0 and g.del_if=0 and s.thr_emp_pk=e.pk  " +
         "    and s2.del_if=0 and s.WORK_MON>=nvl('" + p_workmonth + "',substr(e.JOIN_DT,1,6)) " +
         "    and s2.thr_emp_pk=e.pk and e.tco_org_pk=g.pk " +
         "    and s2.work_mon=to_char(add_months(to_date(s.work_mon,'yyyymm'),-1),'yyyymm')  ";
        SQL += p_sql;
        SQL += "    AND (g.pk IN (SELECT     g.pk " +
         "                                    FROM tco_org g " +
         "                                   WHERE g.del_if = 0 " +
         "                              START WITH g.pk =DECODE ('" + p_dept + "','ALL', 0,'" + p_dept + "') " +
         "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
         "                        OR '" + p_dept + "' = 'ALL') " +
         "   AND DECODE ('" + p_position + "', 'ALL', '" + p_position + "', e.pos_type) = '" + p_position + "' " +
         "   AND DECODE ('" + p_status + "', 'ALL', '" + p_status + "', e.status) = '" + p_status + "' " +
         "   AND UPPER (DECODE (" + p_search_by + ",1, e.full_name,2, e.emp_id,e.id_num)) LIKE '%' || UPPER ('" + p_search_temp + "') || '%' " +
         "   AND ('" + p_from_join + "' IS NULL " +
         "        OR '" + p_to_join + "' IS NULL " +
         "        OR e.join_dt BETWEEN '" + p_from_join + "' AND '" + p_to_join + "' " +
         "       ) " +
         "  AND DECODE('" + p_money_kind + "','ALL','" + p_money_kind + "',e.MONEY_KIND)='" + p_money_kind + "' " +
         "  order by g.org_nm,e.join_dt,s.work_mon ";
        
					
			//Response.Write(SQL);
			//Response.End();
		myDT = ESysLib.TableReadOpen(SQL);
		
			
		if (myDT.Rows.Count == 0)
		{
			Response.Write("There is no data of salary");
			Response.End();
		}


       // string para = "'" + p_dept + "','" + p_work_mon + "'";
       // DataTable dt_com = ESysLib.TableReadOpenCursor("HR_SP_RPT_COMPANY", para);


        int l_row = myDT.Rows.Count;
        int l_col = myDT.Columns.Count;

        double[] grant_total = new double[l_col+1];

        int l_pos = 7;

        for (int k = 0; k < l_col+1; k++)
        {
            grant_total[k] = 0;
        }

        

        for (int i = 0; i < l_row - 1; i++)
        {

            exSheet.Range[l_pos + i + 1, l_col].Rows.EntireRow.Insert();//insert dong moi 
        }

        for (int i = 0; i < l_row; i++)
        {

            exSheet.Cells[l_pos + i, 1].Value = i + 1;
            for (int j = 1; j < l_col+1; j++) 
            {

                if (j == 7 || j == 8)
                {

                    grant_total[j] = grant_total[j] + double.Parse(myDT.Rows[i][j - 1].ToString());

                    exSheet.Cells[l_pos + i, j + 1].Value = double.Parse(myDT.Rows[i][j - 1].ToString());
                }
                else
                    exSheet.Cells[l_pos + i, j + 1].Value = myDT.Rows[i][j - 1].ToString();

            }
         }

		
		//total
        exSheet.Cells[l_pos + l_row, 1].Value = "Total - " + l_row+" Employees";

        for (int j = 1; j < l_col+1; j++)
        {

            if (j == 7 || j == 8)
            {

                exSheet.Cells[l_pos + l_row, j + 1].Value = grant_total[j];
            }
            

        }
        
		
		//exSheet.Cells["F" + (row)].Value = total;
		
		
		exBook.SaveAs(TempFile);
        //ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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
