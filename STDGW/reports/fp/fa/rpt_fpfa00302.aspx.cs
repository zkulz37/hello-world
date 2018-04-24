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

public partial class reports_rpt_fpfa00302 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("SALE");
        string l_pk = Request["master_pk"];

        string TemplateFile = "rpt_fpfa00302.xls";
        string TempFile = "../../../system/temp/rpt_fpfa00302_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file

        string para = "'" + l_pk + "'";
        DataTable dtMaster = ESysLib.TableReadOpenCursor("LG_RPT_FPFA00300", para);
        DataTable dtDetail = ESysLib.TableReadOpenCursor("LG_RPT_FPFA00300_3", para);

        //--set-----DataBind--in---Info---
        exSheet.Cells["G2"].Value = dtMaster.Rows[0]["slip_no"].ToString();
        exSheet.Cells["J2"].Value = dtMaster.Rows[0]["wi_fr_date"].ToString() + "~" + dtMaster.Rows[0]["wi_to_date"].ToString();
        exSheet.Cells["G3"].Value = dtMaster.Rows[0]["pl_nm"].ToString();
        exSheet.Cells["G4"].Value = dtMaster.Rows[0]["description"].ToString();

        exSheet.Cells["C3"].Value = dtMaster.Rows[0]["doc_date"].ToString();
        exSheet.Cells["C4"].Value = dtMaster.Rows[0]["line_nm"].ToString();

        exSheet.Cells["O3"].Value = "*WI" + dtMaster.Rows[0]["slip_no"].ToString() + "*";

        ////end-set-----DataBind--in---Info---

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        int pos = 7, col = 0;
        for (int l_row = 0; l_row < dtDetail.Rows.Count; l_row++)
        {

            exSheet.Cells[pos + l_row, col + 1].Value = l_row + 1;
            exSheet.Cells[pos + l_row, col + 2].Value = dtDetail.Rows[l_row]["cp_no"].ToString();
            exSheet.Cells[pos + l_row, col + 3].Value = dtDetail.Rows[l_row]["item_name"].ToString();
            exSheet.Cells[pos + l_row, col + 4].Value = dtDetail.Rows[l_row]["mark"].ToString();
            exSheet.Cells[pos + l_row, col + 5].Value = dtDetail.Rows[l_row]["spec_01"].ToString();
            
            exSheet.Cells[pos + l_row, col + 8].Value = dtDetail.Rows[l_row]["length_qty"].ToString();
            exSheet.Cells[pos + l_row, col + 9].Value = dtDetail.Rows[l_row]["wi_qty"].ToString();
            exSheet.Cells[pos + l_row, col + 10].Value = dtDetail.Rows[l_row]["unit_wt"].ToString();
            exSheet.Cells[pos + l_row, col + 11].NumberFormat = "###,###";
            exSheet.Cells[pos + l_row, col + 11].Value = Decimal.Parse(dtDetail.Rows[l_row]["weight_qty"].ToString());
            exSheet.Cells[pos + l_row, col + 12].Value = Decimal.Parse(dtDetail.Rows[l_row]["total_wt"].ToString());
            exSheet.Cells[pos + l_row, col + 13].Value = dtDetail.Rows[l_row]["cutting_rs"].ToString();
            exSheet.Cells[pos + l_row, col + 14].Value = dtDetail.Rows[l_row]["balance"].ToString();
            exSheet.Cells[pos + l_row, col + 15].Value = "*" + dtDetail.Rows[l_row]["item_bc"].ToString() + "*";
            exSheet.Cells[pos + l_row, col + 16].Value = dtDetail.Rows[l_row]["description"].ToString();
        }

        exSheet.Cells[dtDetail.Rows.Count + pos, 11].Value = "=SUM(K7:K" + (dtDetail.Rows.Count + pos - 1) + ")";

        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }

        // hide row firts 

        range = exSheet.Range["A1"];
        // hide row A5 
        // range.Rows.Hidden = true;

        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

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

    public Bitmap ResizeImage(Bitmap d, int w, int h)
    {
        Bitmap q = new Bitmap(w, h);
        float f, g;
        f = (float)w / (float)d.Width;
        g = (float)h / (float)d.Height;
        for (int i = 0; i < w; i++)
        {
            for (int j = 0; j < h; j++)
            {
                Color c;
                c = d.GetPixel((int)(i / f), (int)(j / g));
                q.SetPixel(i, j, c);
            }
        }
        return q;
    }
}