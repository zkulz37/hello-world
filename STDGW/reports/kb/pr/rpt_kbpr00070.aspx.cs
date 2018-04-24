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

public partial class rpt_kbpr00070 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("genuwin");

        string p_master_pk = Request["p_master_pk"];

        string TemplateFile = "rpt_kbpr00070.xls";
        string TempFile = "../../../system/temp/rpt_kbpr00070_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;


        string para = "'" + p_master_pk + "'";
        DataTable dtMaster = ESysLib.TableReadOpenCursor("LG_RPT_KBPR00070", para);
        DataTable dtDetail = ESysLib.TableReadOpenCursor("LG_RPT_KBPR00070_1", para);

        if (dtMaster.Rows.Count == 0)
        {
            Response.Write("No Data"); Response.End();
        }

        exSheet.Cells["A2"].Value = "Month: " + dtMaster.Rows[0]["dt_month"];
        exSheet.Cells["E2"].Value = dtMaster.Rows[0]["full_name"];
        exSheet.Cells["B4"].Value = dtMaster.Rows[0]["working_day"];
        exSheet.Cells["E4"].Value = dtMaster.Rows[0]["expectation_yield"] + "%";

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }

        int pos = 7;
        for (int l_row = 0; l_row < dtDetail.Rows.Count; l_row++)
        {
            exSheet.Cells[pos + l_row, 1].Value = dtDetail.Rows[l_row]["null"];
            exSheet.Cells[pos + l_row, 2].Value = dtDetail.Rows[l_row]["item_group"];
            exSheet.Cells[pos + l_row, 3].Value = dtDetail.Rows[l_row]["item_name"];
            exSheet.Cells[pos + l_row, 4].Value = dtDetail.Rows[l_row]["count"];
            exSheet.Cells[pos + l_row, 5].Value = dtDetail.Rows[l_row]["capacity"];
            exSheet.Cells[pos + l_row, 6].Value = dtDetail.Rows[l_row]["last_month"];
            exSheet.Cells[pos + l_row, 7].Value = dtDetail.Rows[l_row]["this_month"];
            exSheet.Cells[pos + l_row, 8].Value = dtDetail.Rows[l_row]["daily_plan"];
            exSheet.Cells[pos + l_row, 9].Value = dtDetail.Rows[l_row]["monthly_plan"];
            exSheet.Cells[pos + l_row, 10].Value = dtDetail.Rows[l_row]["daily_expect"];
            exSheet.Cells[pos + l_row, 11].Value = dtDetail.Rows[l_row]["monthly_expect"];
            exSheet.Cells[pos + l_row, 12].Value = dtDetail.Rows[l_row]["avg_yarn_count"];
        }
        int row = 6;
        exSheet.Cells[dtDetail.Rows.Count + row, 6].Value  = "=SUM(F4:F" + (dtDetail.Rows.Count + 6) + ")";
        exSheet.Cells[dtDetail.Rows.Count + row, 7].Value  = "=SUM(G4:G" + (dtDetail.Rows.Count + 6) + ")";
        exSheet.Cells[dtDetail.Rows.Count + row, 8].Value  = "=SUM(H4:H" + (dtDetail.Rows.Count + 6) + ")";
        exSheet.Cells[dtDetail.Rows.Count + row, 9].Value  = "=SUM(I4:I" + (dtDetail.Rows.Count + 6) + ")";
        exSheet.Cells[dtDetail.Rows.Count + row, 10].Value = "=SUM(J4:J" + (dtDetail.Rows.Count + 6) + ")";
        exSheet.Cells[dtDetail.Rows.Count + row, 11].Value = "=SUM(K4:K" + (dtDetail.Rows.Count + 6) + ")";
        exSheet.Cells[dtDetail.Rows.Count + row, 12].Value = "=SUM(L4:L" + (dtDetail.Rows.Count + 6) + ")";

        // end loop detail not percent

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