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

public partial class rpt_60240100_Allotment_Occupancy_Details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

       ESysLib.SetUser(Session["APP_DBUSER"].ToString());

        string l_dtfrm = Request["p_dtfrom"]; 
		string l_dtto = Request["p_dtto"];
		

        string TemplateFile = "rpt_60240100_Allotment_Occupancy_Details.xls";
        string TempFile = "../../../system/temp/rpt_60240100_Allotment_Occupancy_Details_" + Session["User_ID"].ToString() + ".xls";
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

        para = "'" + l_dtfrm + "','" + l_dtto + "'";
		
        dt = ESysLib.TableReadOpenCursor("ht_rpt_60240100_allotment_occ", para); 
        //-----header---   

        //---end--header---
        //--set-----DataBind--in---Master---
        if (dt.Rows.Count == 0)
        {
            exSheet.Cells[2, 3].Value = "There is not data!";

        }
        if (dt.Rows.Count > 0)   
        {
			exSheet.Cells[2, 7].Value = dt.Rows[0]["print_time"].ToString();
            exSheet.Cells[2, 1].Value = dt.Rows[0]["para_date"].ToString();
			
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
            exSheet.Range["A5"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent
		double l_total_vnd=0;
		float l_total_usd=0;
        int l_cnt = dt.Rows.Count;
        for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 9; col++)
            {
                if (col == 5 ||col == 7 || col == 8 || col == 9)
                {
                    if(dt.Rows[l_row - 1][col].ToString()=="")
					{
						exSheet.Cells[3 + l_row, col + 1].Value = dt.Rows[l_row - 1][col].ToString();
					}
					else
					{
						exSheet.Cells[3 + l_row, col + 1].Value = double.Parse(dt.Rows[l_row - 1][col].ToString());
						exSheet.Cells[3, col + 1, l_row + 3, col + 1].NumberFormat = "#,##0";
						exSheet.Cells[l_row + 3, col + 1].HorizontalAlignment = XlHAlign.xlHAlignRight;
					}
					
                }
                else
                {
					exSheet.Cells[3 + l_row, col + 1].Value = dt.Rows[l_row - 1][col].ToString();
                    exSheet.Cells[l_row + 3, col + 1].HorizontalAlignment = XlHAlign.xlHAlignLeft;
                }
				if(dt.Rows[l_row - 1][0].ToString() !="" && dt.Rows[l_row - 1][1].ToString() =="")
				{
					exSheet.Cells[l_row + 3,1, l_row + 3,10].Interior.Color =Color.Silver;
				}
				if(dt.Rows[l_row - 1][0].ToString() =="" && dt.Rows[l_row - 1][1].ToString() =="")
				{
					exSheet.Cells[l_row + 3,1, l_row + 3,10].Interior.Color =Color.Orange;
				}
            }
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