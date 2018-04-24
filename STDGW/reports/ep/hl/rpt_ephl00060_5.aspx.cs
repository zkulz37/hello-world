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

public partial class rpt_ephl00060_5 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());  
        string TemplateFile = "rpt_ephl00060_5.xls";
        string TempFile = "../../../system/temp/rpt_ephl00060_5_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string p_cus_code = ""+Request["p_cus_code"];
		string p_liquidation_seq = ""+Request["p_liquidation_seq"];
		string p_com_code= ""+Request["p_com_code"];
		
		int i = 0;
		string para="'" + p_cus_code + "','" + p_liquidation_seq  + "','" + p_com_code+ "'";
		DataTable dt = ESysLib.TableReadOpenCursor("LG_SEL_EPHL00060_10500",para);		  
      // DataTable dt_co = ESysLib.TableReadOpenCursor("ac_rpt_60080050_detail");	
			// exSheet.Cells[1,1].Value = dt_co.Rows[0]["partner_fname"].ToString(); 
			exSheet.Cells[4,1].Value = "Ma hải quan: "+dt.Rows[0]["MA_HQ"].ToString(); 
			exSheet.Cells[5,1].Value = "Mã dịch vụ: "+dt.Rows[0]["MA_DV"].ToString(); 
			exSheet.Cells[6,1].Value = "Lần Thanh lý: "+dt.Rows[0]["LAN_TL"].ToString();	
			
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A13"].Rows.EntireRow.Insert();//insert row new of sheet
        }
        
        for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 22; col++)
			{
				exSheet.Cells[11 + l_row, 1].Value = dt.Rows[l_row - 1]["STT"].ToString();								
				exSheet.Cells[11 + l_row, 2].Value = dt.Rows[l_row - 1]["TEN_NPL"].ToString();	
				exSheet.Cells[11 + l_row, 3].Value = dt.Rows[l_row - 1]["SOTK"].ToString();								
				 exSheet.Cells[11 + l_row, 4].Value = dt.Rows[l_row - 1]["NGAY_DK"].ToString();
				 exSheet.Cells[11 + l_row, 5].Value = dt.Rows[l_row - 1]["NGAY_THN"].ToString();
				 if(dt.Rows[l_row - 1]["NHAP"].ToString()!="")
				 {
				 exSheet.Cells[11 + l_row, 6].Value = double.Parse(dt.Rows[l_row - 1]["NHAP"].ToString());								
				}
				 exSheet.Cells[11 + l_row, 7].Value = dt.Rows[l_row - 1]["DVT_NPL"].ToString();	
				  if(dt.Rows[l_row - 1]["LUONG_SD"].ToString()!="")
				 {
					exSheet.Cells[11 + l_row, 8].Value = double.Parse(dt.Rows[l_row - 1]["LUONG_SD"].ToString());
				}
				 if(dt.Rows[l_row - 1]["LUONG_TX"].ToString()!="")
				 {
					exSheet.Cells[11 + l_row, 9].Value = double.Parse(dt.Rows[l_row - 1]["LUONG_TX"].ToString());	
				}
				
				if(dt.Rows[l_row - 1]["LUONG_XH"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 10].Value =double.Parse(dt.Rows[l_row - 1]["LUONG_XH"].ToString());
				}
				
				
				if(dt.Rows[l_row - 1]["LUONG_NT"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 11].Value = double.Parse(dt.Rows[l_row - 1]["LUONG_NT"].ToString());
				}
				if(dt.Rows[l_row - 1]["TON"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 12].Value = double.Parse(dt.Rows[l_row - 1]["TON"].ToString());
				}
				
				}
		}
        
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        exBook.SaveAs(TempFile);
      // ESysLib.ExcelToPdf(TempFile);
       // string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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
