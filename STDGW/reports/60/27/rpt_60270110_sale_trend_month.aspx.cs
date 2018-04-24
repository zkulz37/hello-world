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

public partial class rpt_60270110_sale_trend_month : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
 
        string l_month = Request["p_month"]; 
        string l_location = Request["p_location"];
		string l_item = Request["p_item"];
		string l_customer_type= Request["p_customer_type"];
		
        string TemplateFile = "rpt_60270110_sale_trend_month.xls";
        string TempFile = "../../../system/temp/rpt_60270110_sale_trend_month_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        string para = "";
        DataTable dt, dtSum;

        para = "'" + l_month + "','" + l_location + "','" + l_item + "','" + l_customer_type + "'";
        dt = ESysLib.TableReadOpenCursor("rpt_60270110_sale_trend_month", para);
        //-----header---   

        //---end--header---
        //--set-----DataBind--in---Master---
        if (dt.Rows.Count == 0)
        {
            exSheet.Cells[3, 8].Value = "There is not data!";

        }
        if (dt.Rows.Count > 0) 
        {
			exSheet.Cells[3, 1].Value = dt.Rows[0]["monthly"].ToString();
			exSheet.Cells[3, 3].Value = dt.Rows[0]["location_name"].ToString();
			exSheet.Cells[3, 12].Value = dt.Rows[0]["customer_type"].ToString();
			exSheet.Cells[3, 31].Value = dt.Rows[0]["print_time"].ToString();
        }

        //----------------------
        ////end-set-----DataBind--in---Master---

        for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A6"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent
		int l_total_room=0,l_total_guest=0,l_total_row=0;
		l_total_row=dt.Rows.Count;
		
		if(dt.Rows.Count > 0)
		{
			int l_cnt = dt.Rows.Count;
			for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
			{
				for (int col = 0; col <= 35; col++)
				{
					if(col==0||col==1||col==2||col==3)	
					{
						exSheet.Cells[4 + l_row, col + 1].Value = dt.Rows[l_row - 1][col].ToString();
						exSheet.Cells[l_row + 4, col + 1].HorizontalAlignment = XlHAlign.xlHAlignLeft;
					}
					else
					{
						exSheet.Cells[4 + l_row, col + 1].Value = double.Parse(dt.Rows[l_row - 1][col].ToString());
						exSheet.Cells[4, col + 1, l_row + 4, col + 1].NumberFormat = "#,##0";
                        exSheet.Cells[l_row + 4, col + 1].HorizontalAlignment = XlHAlign.xlHAlignRight;

                        if (double.Parse(dt.Rows[l_row - 1][col].ToString())== 0)
                        {
                            exSheet.Cells[4 + l_row, col + 1].Value = "";
                        }
					}
					if (dt.Rows[l_row - 1][1].ToString()== "")
					{
						exSheet.Cells[4 + l_row, 4].Value = "Sub Total";
						exSheet.Cells[l_row + 4,1, l_row + 4,36].Interior.Color =Color.Silver;
					}
					
				}
			}
			exSheet.Cells[4 + l_total_row, 4].Value = "Total";
			exSheet.Cells[4 + l_total_row,1, 4 + l_total_row,36].Interior.Color =Color.Orange;
		}
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        range = exSheet.Range["A1"];
        // hide row A5 
        range.Rows.Hidden = true;

        // font bold header

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
        Response.WriteFile(TempFile);
        //Response.WriteFile(pdfFilePath);
        //Stop execute  
        Response.End();

    }
}