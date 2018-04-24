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

public partial class rpt_fpfa00360 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        string TemplateFile = "rpt_fpfa00360.xls";
        string TempFile = "../../../system/temp/rpt_fpfa00360_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        string p_project_pk = Request.QueryString["p_project_pk"];
        string p_project_code = Request.QueryString["p_project_code"];
        string p_project_nm = Request.QueryString["p_project_nm"];
        string p_from_date = Request.QueryString["p_from_date"];
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file

        string para = "'" + p_from_date + "','" + p_project_code + "'";
        DataTable dtMaster = ESysLib.TableReadOpenCursor("LG_RPT_FPFA00360", para);
        para = "'" + p_from_date + "','" + p_project_pk + "'";
        DataTable dtDetail = ESysLib.TableReadOpenCursor("LG_RPT_FPFA00360_1", para);

        //--set-----DataBind--in---Info---
        exSheet.Cells["A4"].Value = "Project Name: " + p_project_nm;
        exSheet.Cells["B7"].Value = System.DateTime.ParseExact(p_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy");
        // yesterday
        exSheet.Cells["C12"].Value = dtMaster.Rows[0]["engineer"].ToString();
        exSheet.Cells["D12"].Value = dtMaster.Rows[0]["cnc1_foreman"].ToString();
        exSheet.Cells["E12"].Value = dtMaster.Rows[0]["cnc1_chief_of_worker"].ToString();
        exSheet.Cells["F12"].Value = dtMaster.Rows[0]["cnc1_operator"].ToString();
        exSheet.Cells["G12"].Value = dtMaster.Rows[0]["cnc1_helper"].ToString();
        exSheet.Cells["H12"].Value = dtMaster.Rows[0]["cnc2_foreman"].ToString();
        exSheet.Cells["I12"].Value = dtMaster.Rows[0]["cnc2_chief_of_worker"].ToString();
        exSheet.Cells["J12"].Value = dtMaster.Rows[0]["cnc2_operator"].ToString();
        exSheet.Cells["K12"].Value = dtMaster.Rows[0]["cnc2_helper"].ToString();
        exSheet.Cells["L12"].Value = "=SUM(C12:K12)";
        // today
        exSheet.Cells["C13"].Value = dtMaster.Rows[1]["engineer"].ToString();
        exSheet.Cells["D13"].Value = dtMaster.Rows[1]["cnc1_foreman"].ToString();
        exSheet.Cells["E13"].Value = dtMaster.Rows[1]["cnc1_chief_of_worker"].ToString();
        exSheet.Cells["F13"].Value = dtMaster.Rows[1]["cnc1_operator"].ToString();
        exSheet.Cells["G13"].Value = dtMaster.Rows[1]["cnc1_helper"].ToString();
        exSheet.Cells["H13"].Value = dtMaster.Rows[1]["cnc2_foreman"].ToString();
        exSheet.Cells["I13"].Value = dtMaster.Rows[1]["cnc2_chief_of_worker"].ToString();
        exSheet.Cells["J13"].Value = dtMaster.Rows[1]["cnc2_operator"].ToString();
        exSheet.Cells["K13"].Value = dtMaster.Rows[1]["cnc2_helper"].ToString();
        exSheet.Cells["L13"].Value = "=SUM(C13:K13)";
        // night
        exSheet.Cells["C14"].Value = dtMaster.Rows[2]["engineer"].ToString();
        exSheet.Cells["D14"].Value = dtMaster.Rows[2]["cnc1_foreman"].ToString();
        exSheet.Cells["E14"].Value = dtMaster.Rows[2]["cnc1_chief_of_worker"].ToString();
        exSheet.Cells["F14"].Value = dtMaster.Rows[2]["cnc1_operator"].ToString();
        exSheet.Cells["G14"].Value = dtMaster.Rows[2]["cnc1_helper"].ToString();
        exSheet.Cells["H14"].Value = dtMaster.Rows[2]["cnc2_foreman"].ToString();
        exSheet.Cells["I14"].Value = dtMaster.Rows[2]["cnc2_chief_of_worker"].ToString();
        exSheet.Cells["J14"].Value = dtMaster.Rows[2]["cnc2_operator"].ToString();
        exSheet.Cells["K14"].Value = dtMaster.Rows[2]["cnc2_helper"].ToString();
        exSheet.Cells["L14"].Value = "=SUM(C14:K14)";
        ////end-set-----DataBind--in---Info---
        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count * 2; l_addrow++)
        {
            exSheet.Range["A21"].Rows.EntireRow.Insert();//insert row new of sheet
        }
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        int pos = 20, col = 1;
        exSheet.Cells[pos, 1, pos + dtDetail.Rows.Count + 1, 1].Merge();
        for (int l_row = 0; l_row < dtDetail.Rows.Count * 2; l_row++)
        {
            if (l_row % 2 == 0)
            {
                exSheet.Cells[pos + l_row, col + 1].Value = dtDetail.Rows[l_row]["item_name"].ToString();
                exSheet.Cells[pos + l_row, col + 1, pos + l_row + 1, col + 1].Merge();

                exSheet.Cells[pos + l_row, col + 3].Value = dtDetail.Rows[l_row]["shape_design_qty"].ToString();
                exSheet.Cells[pos + l_row, col + 4].Value = dtDetail.Rows[l_row]["shape_design_we"].ToString();
                exSheet.Cells[pos + l_row, col + 5].Value = dtDetail.Rows[l_row]["shape_yesterday_qty"].ToString();
                exSheet.Cells[pos + l_row, col + 6].Value = dtDetail.Rows[l_row]["shape_yesterday_we"].ToString();
                exSheet.Cells[pos + l_row, col + 7].Value = dtDetail.Rows[l_row]["shape_today_qty"].ToString();
                exSheet.Cells[pos + l_row, col + 8].Value = dtDetail.Rows[l_row]["shape_today_we"].ToString();

                exSheet.Cells[pos + l_row, col + 9].Value = dtDetail.Rows[l_row]["shape_sum_qty"].ToString();
                exSheet.Cells[pos + l_row, col + 10].Value = dtDetail.Rows[l_row]["shape_sum_we"].ToString();
            }
            else
            {
                exSheet.Cells[pos + l_row, col + 2].Value = "Plate";

                exSheet.Cells[pos + l_row, col + 3].Value = dtDetail.Rows[l_row - 1]["plate_design_qty"].ToString();
                exSheet.Cells[pos + l_row, col + 4].Value = dtDetail.Rows[l_row - 1]["plate_design_we"].ToString();
                exSheet.Cells[pos + l_row, col + 5].Value = dtDetail.Rows[l_row - 1]["plate_yesterday_qty"].ToString();
                exSheet.Cells[pos + l_row, col + 6].Value = dtDetail.Rows[l_row - 1]["plate_yesterday_we"].ToString();
                exSheet.Cells[pos + l_row, col + 7].Value = dtDetail.Rows[l_row - 1]["plate_today_qty"].ToString();
                exSheet.Cells[pos + l_row, col + 8].Value = dtDetail.Rows[l_row - 1]["plate_today_we"].ToString();

                exSheet.Cells[pos + l_row, col + 9].Value = dtDetail.Rows[l_row - 1]["plate_sum_qty"].ToString();
                exSheet.Cells[pos + l_row, col + 10].Value = dtDetail.Rows[l_row - 1]["plate_sum_we"].ToString();
            }
        }
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        // hide row firts 

        //range = exSheet.Range["A1"];
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