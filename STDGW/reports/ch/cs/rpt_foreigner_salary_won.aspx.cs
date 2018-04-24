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

public partial class reports_ch_cs_rpt_foreigner_salary_won : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string p_dept, p_emp_id, p_work_mon, p_nation;


        p_dept = Request["p_tco_org_pk"].ToString();
        p_work_mon = Request["p_work_mon"].ToString();
        p_nation = Request["p_nation"].ToString();
        p_emp_id = Request["p_emp_id"].ToString();


        string TemplateFile = "rpt_foreigner_salary_won.xls";
        string TempFile = "../../../system/temp/rpt_foreigner_salary_won_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];      

        IRange range;

        string SQL
        = "SELECT A.EXC_RATE_WON, " +
        "       A.EXCHANGE_RATE, " +
        "       A.EMP_ID, " +
        "       A.FULL_NAME, " +
        "       '', " +
        "       A.TOTAL_SALARY_YEAR, " +
        "       12, " +
        "       ROUND (A.SALARY_LEVEL2,3), " +
        "       A.WT_L2, " +
        "       ROUND(NVL (A.WT_L2_AMT, 0),3), " +
        "       ROUND(NVL (A.INCENTIVE_02, 0),3), " +
        "       ROUND(NVL (A.GROSS_WON, 0),3), " +
        "       ROUND(NVL (A.GROSS_USD, 0),3), " +
        "       ROUND(NVL (A.GROSS_AMT, 0),3), " +
        "       ROUND(NVL (A.ADVANCE_NO_PIT, 0),3), " +
        "       ROUND(NVL (A.NET_VND, 0),3) " +
        "  FROM thr_month_salary a " +
        " WHERE     a.del_if = 0 " +
        "       AND a.work_mon = '" + p_work_mon + "' " +
        "       AND a.nation = '" + p_nation + "' " +
        "       AND NVL (A.NET_VND, 0) > 0 " +
        "   order by a.emp_id ";


        //Response.Write(SQL);
        //Response.End();
        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        int irow_emp, icol_emp;
        irow_emp = dt_emp.Rows.Count;
        icol_emp = dt_emp.Columns.Count;
        if (irow_emp == 0)
        {
            Response.Write("There is no data of salary");
            Response.End();
        }


        SQL
        = "SELECT COUNT (*) AS l_day_in_month,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON, yyyy'),to_char(to_date('" + p_work_mon + "','yyyymm'),'yyyy.mm') " +
         "  FROM THR_CALENDAR A " +
         " WHERE     A.DEL_IF = 0 " +
         "       AND NVL (A.HOL_TYPE, ' ') <> 'SUN' " +
         "       AND A.DAY_TYPE <> '7' " +
         "       AND SUBSTR (A.CAR_DATE, 1, 6) = '" + p_work_mon + "' " +
         "       AND NVL(A.TCO_COMPANY_PK, " + p_dept + ") in " +
         "              (SELECT G.TCO_COMPANY_PK " +
         "                 FROM TCO_ORG G " +
         "                WHERE G.DEL_IF = 0 AND G.PK = CASE WHEN '" + p_dept + "'='ALL' THEN G.PK ELSE TO_NUMBER('" + p_dept + "') END) ";


        DataTable dt_info = ESysLib.TableReadOpen(SQL);

        //Khai bao bien
        int pos = 6, i, j, k;
        int total_col = 11;
        double[] total = new double[total_col];


        for (k = 0; k < total_col; k++)
        {
            total[k] = 0;
        }
        //Insert new row

        for (i = 0; i < irow_emp - 1; i++)
        {
            exSheet.Range[pos + 1, 1].Rows.EntireRow.Insert();
        }

        exSheet.Cells["A1"].Value = "베트남 주재원 " + dt_info.Rows[0][2].ToString() + "월 현지급여";
        exSheet.Cells["L4"].Value = double.Parse(dt_emp.Rows[0][0].ToString());
        exSheet.Cells["M4"].Value = double.Parse(dt_emp.Rows[0][1].ToString());    
        //Show data
        for (i = 0; i < irow_emp; i++)
        {
            for (k = 0; k < total_col; k++)
                total[k] = total[k] + double.Parse(dt_emp.Rows[i][k + 5].ToString());
            
            exSheet.Cells[pos + i, 1].Value = i + 1;
            for (j = 2; j < icol_emp ; j++)
            {
                if (j < 5 )
                    exSheet.Cells[pos + i, j].Value = dt_emp.Rows[i][j].ToString();
                else
                    exSheet.Cells[pos + i, j].Value = double.Parse(dt_emp.Rows[i][j].ToString());
            }
        }

        for (k = 0; k < total_col; k++)
        {
            if (k == 1 || k == 3)
                continue;
            exSheet.Cells[pos + irow_emp, k + 5].Value = total[k];
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
        Response.End();/**/
    }
}