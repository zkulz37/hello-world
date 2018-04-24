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

public partial class rpt_kbre00200 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        //string l_pk = Request["master_pk"];
        string p_from_date = Request["p_from_date"];
        string p_to_date = Request["p_to_date"];
        string para = "'" + p_from_date + "','" + p_to_date + "'";

        string TemplateFile = "rpt_kbre00200.xls";
        string TempFile = "../../../system/temp/rpt_kbre00200" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file    
        DataTable dtDetail = ESysLib.TableReadOpenCursor("LG_RPT_KBRE00200", para);

        //--set-----DataBind--in---Master---   

        exSheet.Cells[2, 3].Value ="From:" + System.DateTime.ParseExact(p_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")+ "-" + System.DateTime.ParseExact(p_to_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy");
       
        ////end-set-----DataBind--in---Master---

        for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A6"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        
         //loop detail not percent

        for (int l_row = 1; l_row <= dtDetail.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 6; col++)
            {
                if (col == 0) // Item Name
                {
                    exSheet.Cells[4 + l_row, col + 1].Value = dtDetail.Rows[l_row - 1][col].ToString();
                }
                 else
                {
                    if (col >= 1 && col <= 6)
                    {
                        if (!string.IsNullOrEmpty(dtDetail.Rows[l_row - 1][col].ToString()))
                        {
                            exSheet.Cells[4 + l_row, col + 1].Value = Convert.ToDouble(dtDetail.Rows[l_row - 1][col]);
                        }
                        else
                        {
                            exSheet.Cells[4 + l_row, col + 1].Value = string.Empty;
                        }
                    }
                }        
            }
        }
        exSheet.Cells[dtDetail.Rows.Count + 5, 2].Value = "=SUM(B5:B" + (dtDetail.Rows.Count + 4) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 5, 3].Value = "=B" + (dtDetail.Rows.Count + 5) + "/D" + (dtDetail.Rows.Count + 5);
        exSheet.Cells[dtDetail.Rows.Count + 5, 4].Value = "=SUM(D5:D" + (dtDetail.Rows.Count + 4) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 5, 5].Value = "=SUM(E5:E" + (dtDetail.Rows.Count + 4) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 5, 6].Value = "=SUM(F5:F" + (dtDetail.Rows.Count + 4) + ")";
        exSheet.Cells[dtDetail.Rows.Count + 5, 7].Value = "=SUM(G5:G" + (dtDetail.Rows.Count + 4) + ")";

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
        ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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