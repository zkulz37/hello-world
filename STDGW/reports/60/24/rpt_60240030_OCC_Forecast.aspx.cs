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

public partial class rpt_60240030_OCC_Forecast : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string l_dtfrm = Request["p_date"];
		string l_days = Request["p_days"];
	       
        string TemplateFile = "rpt_60240030_OCC_Forecast.xls";
        string TempFile = "../../../system/temp/rpt_60240030_OCC_Forecast_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        string para = "";
        DataTable dt;

        para = "'" + l_dtfrm + "','" + l_days + "'"; 
		
        dt = ESysLib.TableReadOpenCursor("rpt_60240030_oc_forecast", para); 
        //-----header---   

        //---end--header---
        //--set-----DataBind--in---Master---
        if (dt.Rows.Count == 0)
        {
            exSheet.Cells[3, 3].Value = "There is not data!";

        }
        if (dt.Rows.Count > 0)   
        {
			exSheet.Cells[3, 1].Value = dt.Rows[0]["date_para"].ToString();
			exSheet.Cells[3, 3].Value = "Days: " + l_days;
            exSheet.Cells[3, 16].Value = dt.Rows[0]["print_time"].ToString();
			
			/*exSheet.Cells[2, 1].Select();
			
			byte[] MyData = new byte[0];
			MyData = (byte[])dt.Rows[0]["logo_lotus"];
			MemoryStream stream = new MemoryStream(MyData);
			exSheet.Shapes.AddPicture(stream);*/
        }

        //----------------------
        ////end-set-----DataBind--in---Master---

        for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A7"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent
		double l_total_OCC=0,l_cancel=0,l_rm_rev_w_o_bf=0;
		float l_OC_percent=0;
        int l_cnt = dt.Rows.Count;
        for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 17; col++)
            {
                if (col == 0)
                {
                    exSheet.Cells[5 + l_row, col + 1].Value = dt.Rows[l_row - 1][col].ToString();
                    exSheet.Cells[l_row + 5, col + 1].HorizontalAlignment = XlHAlign.xlHAlignLeft;
                }
                else
                {
                    if (col == 1||col == 2||col == 3||col == 4||col == 6||col == 7||col == 8||col == 9||col == 10||col == 11||col == 12||col == 13||col == 14||col == 15||col == 16||col == 17)
                    {
                        exSheet.Cells[5 + l_row, col + 1].Value = double.Parse(dt.Rows[l_row - 1][col].ToString());
                        exSheet.Cells[6, col + 1, l_row + 6, col + 1].NumberFormat = "#,##0";
                        exSheet.Cells[l_row + 5, col + 1].HorizontalAlignment = XlHAlign.xlHAlignRight;
						if(col == 3)
						{
							l_total_OCC=l_total_OCC + double.Parse(dt.Rows[l_row - 1][col].ToString());
						}
						if(col == 14)
						{
							l_rm_rev_w_o_bf=l_rm_rev_w_o_bf + double.Parse(dt.Rows[l_row - 1][col].ToString());
						}
						if(col == 17) 
						{
							l_cancel=l_cancel + double.Parse(dt.Rows[l_row - 1][col].ToString());
						}
                        if (double.Parse(dt.Rows[l_row - 1][col].ToString()) == 0)
                        {
                            exSheet.Cells[5 + l_row, col + 1].Value = "";
                        }
						
                    }
                    else
                    {
                       exSheet.Cells[5 + l_row, col + 1].Value = float.Parse(dt.Rows[l_row - 1][col].ToString());
                        exSheet.Cells[6, col + 1, l_row + 6, col + 1].NumberFormat = "#,##0.00";
                        exSheet.Cells[l_row + 6, col + 1].HorizontalAlignment = XlHAlign.xlHAlignRight;
						
						l_OC_percent=l_OC_percent + float.Parse(dt.Rows[l_row - 1][col].ToString());
						
                        if (float.Parse(dt.Rows[l_row - 1][col].ToString()) == 0.00)
                        {
                            exSheet.Cells[5 + l_row, col + 1].Value = "";
                        } 
                    }
                }
            }
			exSheet.Cells[6 + dt.Rows.Count, 4].Value =l_total_OCC;
			exSheet.Cells[6 + dt.Rows.Count, 6].Value =(l_OC_percent/int.Parse(l_days)); 
			exSheet.Cells[6 + dt.Rows.Count, 15].Value =l_rm_rev_w_o_bf;
			exSheet.Cells[6 + dt.Rows.Count, 18].Value =l_cancel;
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