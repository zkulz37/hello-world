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

public partial class rpt_ephl00080_1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("sale");

        string TemplateFile = "rpt_ephl00080_1.xls";
        string TempFile = "../../../system/temp/rpt_ephl00080_1_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
        string p_date = Request["p_date"];
        string p_wh = Request["p_wh"];

        exSheet.Cells["B3"].Value = "Date: " + System.DateTime.ParseExact(p_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy");
        exSheet.Cells["E3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm");

        string para = "'" + p_date + "','" + p_wh + "'";

        DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_ephl00080", para);
        for (int r = 0; r < dt.Rows.Count; r++)
        {
            if (r < dt.Rows.Count - 1)
            {
                exSheet.Range["A" + (6 + r)].Rows.EntireRow.Insert();
            }
            for (int c = 0; c < dt.Columns.Count; c++)
            {
                exSheet.Cells[5 + r, c + 1].Value = dt.Rows[r][c];
            }
        }
        if (dt.Rows.Count > 0)
        {
			exSheet.Cells["D" + (5 + dt.Rows.Count)].Value = "=SUM(D5:D" + (4 + dt.Rows.Count) + ")";
			exSheet.Cells["E" + (5 + dt.Rows.Count)].Value = "=SUM(E5:E" + (4 + dt.Rows.Count) + ")";
            exSheet.Cells["F" + (5 + dt.Rows.Count)].Value = "=SUM(F5:F" + (4 + dt.Rows.Count) + ")";
        }
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        range = exSheet.Range["A1"];
        // hide row A5 
        range.Rows.Hidden = true;

        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

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