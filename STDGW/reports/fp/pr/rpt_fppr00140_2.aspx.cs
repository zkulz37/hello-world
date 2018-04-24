using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
using NativeExcel;

public partial class reports_fp_pr_rpt_fppr00140_2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        //ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_fppr00140_2.xls";
        string TempFile = "../../../system/temp/rpt_fppr00140_2_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;
        
        //bind data to excel file
        string p_wh_pk = Request.QueryString["p_tin_warehouse_pk"];
        string p_from_dt = Request.QueryString["p_from_date"];
        string p_to_dt = Request.QueryString["p_to_date"];
        string p_ref_no_line = Request.QueryString["p_ref_no_pl"];
        string p_item = Request.QueryString["p_item"];

        string SQL
        = "SELECT '','',d.item_code, d.item_name,SUM(NVL(B.IN_QTY,0)), " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 0, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d1, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 1, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d2, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 2, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d3, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 3, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d4, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 4, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d5, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 5, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d6, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 6, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d7, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 7, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d8, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 8, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d9, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 9, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d10, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 10, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d11, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 11, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d12, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 12, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d13, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 13, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d14, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 14, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d15, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 15, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d16, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 16, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d17, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 17, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d18, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 18, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d19, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 19, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d20, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 20, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d21, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 21, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d22, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 22, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d23, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 23, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d24, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 24, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d25, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 25, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d26, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 26, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d27, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 27, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d28, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 28, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d29, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 29, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d30, " +
        "         SUM (CASE WHEN a.prod_date = TO_CHAR (TO_DATE ('" + p_from_dt + "', 'yyyymmdd') + 30, 'yyyymmdd') THEN NVL (b.in_qty, 0) ELSE 0 END) d31 " +
        "    FROM tlg_pr_prod_income_m a, " +
        "         tlg_pr_prod_income_d b, " +
        "         tlg_it_item d, " +
        "         tlg_in_warehouse f, " +
        "         tlg_pb_line g " +
        "   WHERE     a.del_if = 0 " +
        "         AND a.prod_date BETWEEN '" + p_from_dt + "' AND '" + p_to_dt + "' " +
        "         AND b.del_if(+) = 0 " +
        "         AND a.pk = b.tlg_pr_prod_income_m_pk(+) " +
        "         AND (   UPPER (b.ref_no) LIKE '%' || UPPER ('" + p_ref_no_line + "') || '%' " +
        "              OR g.line_id LIKE '%' || UPPER ('" + p_ref_no_line + "') || '%' " +
        "              OR g.line_name LIKE '%' || UPPER ('" + p_ref_no_line + "') || '%' " +
        "              OR '" + p_ref_no_line + "' IS NULL) " +
        "         AND d.del_if(+) = 0 " +
        "         AND b.item_pk = d.pk(+) " +
        "         AND (   UPPER (d.item_code) LIKE '%' || UPPER ('" + p_item + "') || '%' " +
        "              OR UPPER (d.item_name) LIKE '%' || UPPER ('" + p_item + "') || '%' " +
        "              OR '" + p_item + "' IS NULL) " +
        "         AND f.del_if(+) = 0 " +
        "         AND a.tlg_in_warehouse_pk = f.pk(+) " +
        "         AND (a.tlg_in_warehouse_pk = '" + p_wh_pk + "' OR '" + p_wh_pk + "' IS NULL) " +
        "         AND g.del_if(+) = 0 " +
        "         AND a.tlg_pb_line_pk = g.pk(+) " +
        "GROUP BY d.item_code, d.item_name " +
        "ORDER BY ITEM_CODE ";

        //Response.Write(SQL);
        //Response.End();   
        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        
        int irow = dt_emp.Rows.Count;
        int icol = dt_emp.Columns.Count;

        if (irow == 0)
        {
            Response.Write("There is no data.");
            Response.End();
        }

        int iDate_Num;

        //-----------------calendar-----------------
        SQL
        = "SELECT TO_CHAR (TO_DATE (car_date, 'yyyymmdd'), 'dd-Mon') " +
        "    FROM tco_abcalendar " +
        "   WHERE     del_if = 0 " +
        "         AND car_date BETWEEN '" + p_from_dt + "' AND '" + p_to_dt + "' " +
        "ORDER BY car_date ";

        DataTable dt_Cal = ESysLib.TableReadOpen(SQL);
        iDate_Num = dt_Cal.Rows.Count;
        
        
        //Khai bao bien
        int pos = 4;
        int i, j;

        //Show date
        for (j = 1; j <= iDate_Num; j++)
            exSheet.Cells[pos - 1, j + 4].Value = dt_Cal.Rows[j - 1][0].ToString();

        // INSERT ROWS

        for (i = 0; i < irow - 1; i++)
        {
            exSheet.Range[pos + 1, 1].Rows.EntireRow.Insert();
        }

        // Title header

        exSheet.Cells["A2"].Value = dt_Cal.Rows[0][0].ToString() + " ~ " + dt_Cal.Rows[iDate_Num - 1][0].ToString();

        //Data
        for (i = 0; i < irow; i++)
        {
            exSheet.Cells[pos + i, 1].Value = i + 1;
            for (j = 2; j < icol; j++)
            {
                if (j <= 3)
                    exSheet.Cells[pos + i, j].Value = dt_emp.Rows[i][j].ToString();
                else
                    exSheet.Cells[pos + i, j].Value = double.Parse(dt_emp.Rows[i][j].ToString());

            }
        }

        //Delete column
        int ndel = 0, cdel = 0;
        ndel = 31 - iDate_Num;  //so cot can delete
        cdel = iDate_Num + 4;   //vi tri cot delete

        for (i = 0; i < ndel; i++)
        {
            exSheet.Range[1, cdel + 1].Columns.EntireColumn.Delete();
        }
       
        //---------
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        

        exBook.SaveAs(TempFile);
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
        //Response.WriteFile(pdfFilePath);
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();
    }
}