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
using System.Text;

public partial class rpt_dscd00070_KB_1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("sale");


        string TemplateFile = "rpt_dscd00070_KB_1.xls";
        string TempFile = "../../../system/temp/rpt_dscd00070_KB_1_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        string master_pk = "'" + Request.QueryString["master_pk"] + "'";
        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_dscd00070_kb_01_2", master_pk);
        master_pk = "'" + Request.QueryString["master_pk"] + "','" + Session["User_ID"].ToString() + "'";
        DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_dscd00070_kb_01_1", master_pk);

        // MASTER
        if (dtMaster.Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Số: ");
            sb.Append(dtMaster.Rows[0]["slip_no"].ToString() + " / ");
            sb.Append("Ngày " + dtMaster.Rows[0]["out_dd"].ToString() + " ");
            sb.Append("Tháng " + dtMaster.Rows[0]["out_mm"].ToString() + " ");
            sb.Append("Năm " + dtMaster.Rows[0]["out_yy"].ToString());

            exSheet.Cells["C2"].Value = sb.ToString();
            exSheet.Cells["C4"].Value = dtMaster.Rows[0]["partner_name"].ToString();
            exSheet.Cells["C5"].Value = dtMaster.Rows[0]["addr1"].ToString();
            exSheet.Cells["C6"].Value = dtMaster.Rows[0]["tax_code"].ToString();

            exSheet.Cells["C7"].Value = dtMaster.Rows[0]["phone_no"].ToString();
            exSheet.Cells["F7"].Value = dtMaster.Rows[0]["fax_no"].ToString();

            exSheet.Cells["C8"].Value = dtMaster.Rows[0]["loc_addr"].ToString();
        }
        // END MASTER

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            //exSheet.Range["A13"].Rows.EntireRow.Insert();//insert row new of sheet
        }

        // DETAIL
        string s_item = dtDetail.Rows.Count > 0 ? dtDetail.Rows[0]["item_code"].ToString() : string.Empty;
        int pos = 12, count = 1;
        for (int l_row = 0; l_row < dtDetail.Rows.Count; l_row++)
        {
            if (dtDetail.Rows[l_row]["item_code"].ToString() == s_item && l_row == 0)
            {
                exSheet.Cells["C10"].Value = dtDetail.Rows[l_row]["item_code"];
                exSheet.Cells["E10"].Value = dtDetail.Rows[l_row]["item_nm"];

                /*
                exSheet.Range["A13"].Rows.EntireRow.Insert();

                exSheet.Cells[pos + l_row, 1].Value = l_row + 1;
                exSheet.Cells[pos + l_row, 2].Value = dtDetail.Rows[l_row]["lot_no"];

                exSheet.Cells[pos + l_row, 3].Value = dtDetail.Rows[l_row]["box_seq"];
                exSheet.Cells[pos + l_row, 3, pos + l_row, 4].Merge();

                exSheet.Cells[pos + l_row, 5].Value = dtDetail.Rows[l_row]["weight"];
                exSheet.Cells[pos + l_row, 5, pos + l_row, 6].Merge();

                exSheet.Cells[pos + l_row, 7].Value = dtDetail.Rows[l_row]["coin_num"];
                exSheet.Cells[pos + l_row, 7, pos + l_row, 8].Merge();
                */
                s_item = dtDetail.Rows[l_row]["item_code"].ToString();
            }
            else if (dtDetail.Rows[l_row]["item_code"].ToString() != s_item)
            {
                count++;
                exSheet.Cells["A10:H13"].Copy(exSheet.Cells["A" + (6 + (count * 5)) + ":H" + (9 + (count * 5))]);

                exSheet.Cells["C" + (6 + (count * 5))].Value = dtDetail.Rows[l_row]["item_code"];
                exSheet.Cells["E" + (6 + (count * 5))].Value = dtDetail.Rows[l_row]["item_nm"];

                s_item = dtDetail.Rows[l_row]["item_code"].ToString();
            }
            else
            {

            }
            /*   exSheet.Cells[pos + l_row, 1].Value = l_row + 1;
               exSheet.Cells[pos + l_row, 2].Value = dtDetail.Rows[l_row]["item"];
               exSheet.Cells[pos + l_row, 2, pos + l_row, 4].Merge();
               exSheet.Cells[pos + l_row, 5].Value = dtDetail.Rows[l_row]["out_qty"];
               exSheet.Cells[pos + l_row, 6].Value = dtDetail.Rows[l_row]["unit_price"];
               exSheet.Cells[pos + l_row, 7].Value = "=E" + (pos + l_row) + "*" + "F" + (pos + l_row);
               exSheet.Cells[pos + l_row, 8].Value = dtDetail.Rows[l_row]["description"];*/

            exSheet.Range[2, 1, row, 10].Copy(exSheet.Range[2, 1, row, 10]);
        }
        // END DETAIL

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