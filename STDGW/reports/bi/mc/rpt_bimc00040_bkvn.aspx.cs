using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Drawing;
using NativeExcel;

public partial class reports_bi_sc_rpt_bisc00010_bkvn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser("INV");
        string p_date_from = Request["p_from_date"];
        string p_date_to = Request["p_to_date"];
        string p_item = Request["p_item"];
        string p_wh_pk = Request["p_tin_warehouse_pk"];
        string p_item_grp_pk = Request["p_item_grp_pk"];

        string date_from = p_date_from.Substring(6, 2) + "/" + p_date_from.Substring(4, 2) + "/" + p_date_from.Substring(0, 4);
        string date_to = p_date_to.Substring(6, 2) + "/" + p_date_to.Substring(4, 2) + "/" + p_date_to.Substring(0, 4);


        string TemplateFile = "rpt_bisc00010_bkvn.xls";
        string TempFile = "../../../system/temp/rpt_bisc00010_bkvn_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        //Left header of order
        IRange range;
        string para = "'" + p_date_from + "','" + p_date_to + "','" + p_wh_pk + "','" + p_item_grp_pk + "','" + p_item + "'";
        DataTable dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_bisc00010_bkvina", para);

        exSheet.Cells[3, 1].Value =date_from + " - " + date_to;
        for (int l_addrow = 0; l_addrow < dt.Rows.Count-1; l_addrow++)
        {
            exSheet.Range["A6"].Rows.EntireRow.Insert();//insert row new of sheet
        }
        double to1 = 0, to2 = 0, to3 = 0, to4 = 0, to5 = 0, to6 = 0, to7 = 0, to8 = 0, to9 = 0, to10 = 0, to11 = 0;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            exSheet.Cells[5 + i, 1].Value = dt.Rows[i]["item_code"];
            exSheet.Cells[5 + i, 2].Value = dt.Rows[i]["spec_nm"];
            exSheet.Cells[5 + i, 3].Value = dt.Rows[i]["begin_qty"];
            to1 = to1 + CommondLib.ConvertToDbl(dt.Rows[i]["begin_qty"]);
            exSheet.Cells[5 + i, 4].Value = dt.Rows[i]["prod_qty"];
            to2 = to2 + CommondLib.ConvertToDbl(dt.Rows[i]["prod_qty"]);
            exSheet.Cells[5 + i, 5].Value = dt.Rows[i]["ex_in_qty"];
            to3 = to3 + CommondLib.ConvertToDbl(dt.Rows[i]["ex_in_qty"]);
            exSheet.Cells[5 + i, 6].Value = dt.Rows[i]["total_in"];
            to4 = to4 + CommondLib.ConvertToDbl(dt.Rows[i]["total_in"]);
            exSheet.Cells[5 + i, 7].Value = dt.Rows[i]["ex_out_qty"];
            to5 = to5 + CommondLib.ConvertToDbl(dt.Rows[i]["ex_out_qty"]);
            exSheet.Cells[5 + i, 8].Value = dt.Rows[i]["exchang_to"];
            exSheet.Cells[5 + i, 9].Value = dt.Rows[i]["defect_qty"];
            to6 = to6 + CommondLib.ConvertToDbl(dt.Rows[i]["defect_qty"]);
            exSheet.Cells[5 + i, 10].Value = dt.Rows[i]["deli_qty"];
            to7 = to7 + CommondLib.ConvertToDbl(dt.Rows[i]["deli_qty"]);
            exSheet.Cells[5 + i, 11].Value = dt.Rows[i]["total_out"];
            to8 = to8 + CommondLib.ConvertToDbl(dt.Rows[i]["total_out"]);
            exSheet.Cells[5 + i, 12].Value = dt.Rows[i]["stock_qty"];
            to9 = to9 + CommondLib.ConvertToDbl(dt.Rows[i]["stock_qty"]);
            exSheet.Cells[5 + i, 13].Value = dt.Rows[i]["diff_qty"];
            to10 = to10 + CommondLib.ConvertToDbl(dt.Rows[i]["diff_qty"]);
            exSheet.Cells[5 + i, 14].Value = dt.Rows[i]["end_qty"];
            to11 = to11 + CommondLib.ConvertToDbl(dt.Rows[i]["end_qty"]);
        }

        exSheet.Cells[6 + dt.Rows.Count - 1, 3].Value = to1;
        exSheet.Cells[6 + dt.Rows.Count - 1, 4].Value = to2;
        exSheet.Cells[6 + dt.Rows.Count - 1, 5].Value = to3;
        exSheet.Cells[6 + dt.Rows.Count - 1, 6].Value = to4;
        exSheet.Cells[6 + dt.Rows.Count - 1, 7].Value = to5;
        exSheet.Cells[6 + dt.Rows.Count - 1, 9].Value = to6;
        exSheet.Cells[6 + dt.Rows.Count - 1, 10].Value = to7;
        exSheet.Cells[6 + dt.Rows.Count - 1, 11].Value = to8;
        exSheet.Cells[6 + dt.Rows.Count - 1, 12].Value = to9;
        exSheet.Cells[6 + dt.Rows.Count - 1, 13].Value = to10;
        exSheet.Cells[6 + dt.Rows.Count - 1, 14].Value = to11;

        //range = exSheet.Range["A6"];
        //range.Rows.Hidden = true;
        range = exSheet.Range["A1"];
        range.Rows.Hidden = true;

        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }

        exBook.SaveAs(TempFile);
        //write out to client broswer
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        //Add header, give a default file name for "File Download/Store as"
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        //Add header, set file size to enable browser display download progress
        Response.AddHeader("Content-Length", file.Length.ToString());
        //Set the return string is unavailable reading for client, and must be downloaded
        Response.ContentType = "application/ms-exSheet";
        //Send file string to client 
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }
}
