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

public partial class reports_rpt_epbp00160 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ESysLib.SetUser("sale");

        string TemplateFile = "rpt_epbp00160.xls";
        string TempFile = "../../../system/temp/rpt_epbp00160_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        string p_dt_from   = Request.QueryString["p_dt_from"];
        string p_dt_to     = Request.QueryString["p_dt_to"];
        string p_item      = Request.QueryString["p_item"];
        string p_partner   = Request.QueryString["p_partner"];
        string p_last_time = Request.QueryString["p_last_time"];
	string p_group_pk  = Request.QueryString["p_group_pk"];


        string para = "'" + p_dt_from + "','" + p_dt_to + "','" + p_item + "','" + p_partner + "'";
        DataTable dtMaster = ESysLib.TableReadOpenCursor("lg_rpt_epbp00160_1", para);
        para = "'" + p_dt_from + "','" + p_dt_to + "','" + p_group_pk + "','" + p_item + "','" + p_partner + "','" + p_last_time + "'";
        DataTable dtDetail = ESysLib.TableReadOpenCursor("lg_rpt_epbp00160", para);

        // MASTER
        if (dtMaster.Rows.Count > 0)
        {
            exSheet.Cells["C1"].Value = dtMaster.Rows[0]["partner_name"].ToString();
            exSheet.Cells["C2"].Value = dtMaster.Rows[0]["addr1"].ToString();
            exSheet.Cells["C3"].Value = "Tax code: " + dtMaster.Rows[0]["tax_code"].ToString();

            exSheet.Cells["H1"].Value = "Tel: " + dtMaster.Rows[0]["phone_no"].ToString();
            exSheet.Cells["H2"].Value = "Fax: " + dtMaster.Rows[0]["fax_no"].ToString();
            exSheet.Cells["H3"].Value = "Print Date: " + DateTime.Now.ToString("dd/MM/yyyy HH:mm");

            exSheet.Cells["H5"].Value = dtMaster.Rows[0]["from_date"].ToString() + " - " + dtMaster.Rows[0]["to_date"].ToString();
        }
        // END MASTER

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }

        // DETAIL
        int pos = 7, col = 0;
        for (int l_row = 0; l_row < dtDetail.Rows.Count; l_row++)
        {
            exSheet.Cells[pos + l_row, col + 1].Value = l_row + 1;
            exSheet.Cells[pos + l_row, col + 2].Value = dtDetail.Rows[l_row]["grp_nm"];
            exSheet.Cells[pos + l_row, col + 3].Value = dtDetail.Rows[l_row]["item_code"];
            exSheet.Cells[pos + l_row, col + 4].Value = dtDetail.Rows[l_row]["item_name"] + Environment.NewLine + dtDetail.Rows[l_row]["item_fname"];
            exSheet.Cells[pos + l_row, col + 5].Value = dtDetail.Rows[l_row]["uom"];
            exSheet.Cells[pos + l_row, col + 6].Value = dtDetail.Rows[l_row]["partner"];
            exSheet.Cells[pos + l_row, col + 7].Value = dtDetail.Rows[l_row]["price_date"];
            exSheet.Cells[pos + l_row, col + 8].Value = dtDetail.Rows[l_row]["price_qty"];
            exSheet.Cells[pos + l_row, col + 9].Value = dtDetail.Rows[l_row]["unit_price"];
            exSheet.Cells[pos + l_row, col + 10].Value = dtDetail.Rows[l_row]["ccy"];
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