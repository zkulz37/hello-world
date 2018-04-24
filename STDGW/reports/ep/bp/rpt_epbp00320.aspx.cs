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

public partial class rpt_epbp00320 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("sale");
        string l_from_date = Request["from_date"];
        string l_to_date = Request["to_date"];
        string l_po_type = Request["po_type"];

        string l_parameter = "'" + l_from_date + "','" + l_to_date + "','" + l_po_type + "'";

        string TemplateFile = "rpt_epbp00320.xls";
        string TempFile = "../../../system/temp/rpt_epbp00320_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_epbp00320_sw", l_parameter);

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }

        //header
        exSheet.Range["A1"].Value = "Print Date: " + DateTime.Now.ToString();
        exSheet.Range["A1"].Locked = true;
        exSheet.Range["H3"].Value = System.DateTime.ParseExact(l_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy") + "~" + System.DateTime.ParseExact(l_to_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy");
        exSheet.Range["O4"].Value = "Print Date: " + DateTime.Now.ToString();
        //end header

        // title
        int SEQ = 0,
            ITEM = 1,
            COUNTRY = 2,
            BRAND = 3,
            CONTRACT_NO = 4,
            CONTRACT_DATE = 5,
            CTN_NO = 6,
            WEIGHT_QTY = 7,
            UNIT_PRICE = 8,
            PO_AMT = 9,
            AGENT = 10,
            ETD_FROM = 11,
            ETD_TO = 12,
            ETA_SW = 13,
            BL_NO = 14,
            DOC_DATE = 15;
        // end title

        // loop detail not percent
        double total_weight = 0, total_amt = 0;
        for (int l_row = 1; l_row <= dtDetail.Rows.Count; l_row++)
        {
            for (int col = SEQ; col <= DOC_DATE; col++)
            {
                if (col == SEQ)
                {
                    exSheet.Cells[6 + l_row, col + 1].Value = l_row;
                }
                else if (col >= CTN_NO && col <= PO_AMT)
                {
                    if (col == WEIGHT_QTY)
                    {
                        total_weight += float.Parse(string.IsNullOrEmpty(dtDetail.Rows[l_row - 1][col].ToString()) ? "0" : dtDetail.Rows[l_row - 1][col].ToString());
                    }
                    else if (col == PO_AMT)
                    {
                        total_amt += float.Parse(string.IsNullOrEmpty(dtDetail.Rows[l_row - 1][col].ToString()) ? "0" : dtDetail.Rows[l_row - 1][col].ToString());
                    }
                    exSheet.Cells[6 + l_row, col + 1].Value = float.Parse(string.IsNullOrEmpty(dtDetail.Rows[l_row - 1][col].ToString()) ? "0" : dtDetail.Rows[l_row - 1][col].ToString());
                }
                else
                {
                    exSheet.Cells[6 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1][col].ToString();
                }
            }
        }
        // end loop detail percent

        // total
        exSheet.Cells[7 + dtDetail.Rows.Count, WEIGHT_QTY + 1].Value = total_weight;
        exSheet.Cells[7 + dtDetail.Rows.Count, PO_AMT + 1].Value = total_amt;

        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }

        // hide row firts 
        range = exSheet.Range["A1"];
        // hide row A5 
        range.Rows.Hidden = true;
        range.Value = string.Empty;
        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

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
