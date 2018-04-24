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

public partial class rpt_kbpr00080 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("genuwin");
        string p_master_pk = Request["p_master_pk"];
        string p_date = Request["p_date"];

        string TemplateFile = "rpt_kbpr00080.xls";
        string TempFile = "../../../system/temp/rpt_kbpr00080_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
        string para = "'" + p_date + "'";

        DataTable dtMaster_01 = ESysLib.TableReadOpenCursor("LG_RPT_KBPR00080", para);
        para = "'" + p_master_pk + "','" + p_date + "'";
        DataTable dtDetail = ESysLib.TableReadOpenCursor("LG_RPT_KBPR00080_1", para);

        exSheet.Cells["A2"].Value = p_date.Substring(0, 4) + "-" + p_date.Substring(4, 2) + "-" + p_date.Substring(6, 2);
        // Shift A - Working Hours
        exSheet.Cells["C8"].Value = dtMaster_01.Rows[0]["c1"];
        exSheet.Cells["D8"].Value = dtMaster_01.Rows[0]["c1"];
        // Shift B - Working Hours
        exSheet.Cells["E8"].Value = dtMaster_01.Rows[0]["c2"];
        exSheet.Cells["F8"].Value = dtMaster_01.Rows[0]["c2"];
        // Shift C - Working Hours
        exSheet.Cells["G8"].Value = dtMaster_01.Rows[0]["c3"];
        exSheet.Cells["H8"].Value = dtMaster_01.Rows[0]["c3"];

        exSheet.Cells["K8"].Value = dtMaster_01.Rows[0]["operation_hours"];
        exSheet.Cells["L8"].Value = dtMaster_01.Rows[0]["operation_hours"];

        
        int row_count = 1;
        //-----------
        double c1 = 0, c2 = 0, c4 = 0, c5 = 0, c6 = 0, c7 = 0, c8 = 0, c9 = 0, c10 = 0, c11 = 0, c12 = 0;
        for (int i = 0; i < dtDetail.Rows.Count; i++)
        {
            if (dtDetail.Rows[i]["item_code"].ToString() == "CM30" || dtDetail.Rows[i]["item_code"].ToString() == "WCM30")
            {
                c4 += Convert.ToDouble(dtDetail.Rows[i]["prod_today_qty"]);
                c5 += Convert.ToDouble(dtDetail.Rows[i]["prod_accum_qty"]);
            }
            else
            {
                row_count++;
                exSheet.Range["A14"].Rows.EntireRow.Insert();//insert row new of sheet
            }
        }
        //-----------
        int pos = 13, col = 0;
        for (int l_row = 0; l_row < dtDetail.Rows.Count; l_row++)
        {
            if (dtDetail.Rows[l_row]["item_code"].ToString() != "WCM30")
            {
                exSheet.Cells[pos + l_row, col + 1].Value = dtDetail.Rows[l_row]["grp_cd"].ToString();
                exSheet.Cells[pos + l_row, col + 2].Value = dtDetail.Rows[l_row]["item_code"].ToString();
                exSheet.Cells[pos + l_row, col + 3].Value = dtDetail.Rows[l_row]["item_count"];
                exSheet.Cells[pos + l_row, col + 4].Value = dtDetail.Rows[l_row]["item_code"].ToString() == "CM30" ? c4 : dtDetail.Rows[l_row]["prod_today_qty"];
                exSheet.Cells[pos + l_row, col + 5].Value = dtDetail.Rows[l_row]["item_code"].ToString() == "CM30" ? c5 : dtDetail.Rows[l_row]["prod_accum_qty"]; //Accum Incoming Qty
                exSheet.Cells[pos + l_row, col + 6].Value = dtDetail.Rows[l_row]["product_qty"];
                exSheet.Cells[pos + l_row, col + 7].Value = dtDetail.Rows[l_row]["accum_product_qty"]; ;// accum result
                exSheet.Cells[pos + l_row, col + 8].Value = dtDetail.Rows[l_row]["convert_qty"];
                exSheet.Cells[pos + l_row, col + 9].Value = dtDetail.Rows[l_row]["accum_convert_qty"]; // accum qty
                exSheet.Cells[pos + l_row, col + 10].Value = dtDetail.Rows[l_row]["no_of_operating_line"];
                exSheet.Cells[pos + l_row, col + 11].Value = dtDetail.Rows[l_row]["daily_spinning_capacity"];
                exSheet.Cells[pos + l_row, col + 12].Value = dtDetail.Rows[l_row]["line_capacity"];

                c1 += (Convert.ToDouble(dtDetail.Rows[l_row]["item_count"]) * Convert.ToDouble(dtDetail.Rows[l_row]["product_qty"]));
                c2 += (Convert.ToDouble(dtDetail.Rows[l_row]["item_count"]) * Convert.ToDouble(dtDetail.Rows[l_row]["accum_product_qty"]));
            }
            else
            {
                pos = pos - 1;
            }
        }
        exSheet.Cells[row_count + 13, 4].Value = "=SUM(D13:D" + (row_count + 12) + ")";
        exSheet.Cells[row_count + 13, 5].Value = "=SUM(E13:E" + (row_count + 12) + ")";
        exSheet.Cells[row_count + 13, 6].Value = "=SUM(F13:F" + (row_count + 12) + ")";
        exSheet.Cells[row_count + 13, 7].Value = "=SUM(G13:G" + (row_count + 12) + ")";
        exSheet.Cells[row_count + 13, 8].Value = "=SUM(H13:H" + (row_count + 12) + ")";
        exSheet.Cells[row_count + 13, 9].Value = "=SUM(I13:I" + (row_count + 12) + ")";
        exSheet.Cells[row_count + 13, 10].Value = "=SUM(J13:J" + (row_count + 12) + ")";
        exSheet.Cells[row_count + 13, 11].Value = "=SUM(K13:K" + (row_count + 12) + ")";

        exSheet.Cells["C10"].Value = "=" + c1 + "/F" + (row_count + 13);
        exSheet.Cells["F10"].Value = "=" + c2 + "/G" + (row_count + 13);
        exSheet.Cells["K9"].Value = "=K" + (row_count + 13);
        exSheet.Cells["K10"].Value = "=I" + (row_count + 13) + "/58320/L8*8000";
        ////exSheet.Cells[dtDetail.Rows.Count + 21, 10].Value = "=SUM(J21:J" + (dtDetail.Rows.Count + 20) + ")";
        ////exSheet.Cells[dtDetail.Rows.Count + 21, 13].Value = "=SUM(M21:M" + (dtDetail.Rows.Count + 20) + ")";

        ////exSheet.Cells[dtDetail.Rows.Count + 22, 13].Value = "=SUM(M21:M" + (dtDetail.Rows.Count + 20) + ")*10%";
        //exSheet.Cells[dtDetail.Rows.Count + 23, 13].Value = "=SUM(M21:M" + (dtDetail.Rows.Count + 20) + ")+ (SUM(M21:M" + (dtDetail.Rows.Count + 20) + ")*10%)";
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