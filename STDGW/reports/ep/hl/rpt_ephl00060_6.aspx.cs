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

public partial class rpt_ephl00060_6 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());  
        string TemplateFile = "rpt_ephl00060_6.xls";
        string TempFile = "../../../system/temp/rpt_ephl00060_6_" + Session["User_ID"].ToString() + ".xls";
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
		DataTable dt = ESysLib.TableReadOpenCursor("lg_sel_ephl00060_10600",para);		  
      // DataTable dt_co = ESysLib.TableReadOpenCursor("ac_rpt_60080050_detail");	
			// exSheet.Cells[1,1].Value = dt_co.Rows[0]["partner_fname"].ToString(); 
			exSheet.Cells[4,1].Value = dt.Rows[0]["MA_HQN"].ToString(); 
			// exSheet.Cells[3,1].Value = "Tax Code/MST :"+ dt_co.Rows[0]["tax_code"].ToString(); 
			// exSheet.Cells[5,1].Value = dt_co.Rows[0]["date_para"].ToString();	
			
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A13"].Rows.EntireRow.Insert();//insert row new of sheet
        }
        
        for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 22; col++)
			{
				exSheet.Cells[11 + l_row, 1].Value = dt.Rows[l_row - 1]["STT"].ToString();								
				exSheet.Cells[11 + l_row, 2].Value = dt.Rows[l_row - 1]["SOTKN"].ToString();	
				exSheet.Cells[11 + l_row, 3].Value = dt.Rows[l_row - 1]["TEN_NPL"].ToString();								
				exSheet.Cells[11 + l_row, 4].Value = dt.Rows[l_row - 1]["SOTKX"].ToString();
				exSheet.Cells[11 + l_row, 5].Value = dt.Rows[l_row - 1]["NGAY_THX"].ToString();
			 	if(dt.Rows[l_row - 1]["XUAT"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 6].Value = double.Parse(dt.Rows[l_row - 1]["XUAT"].ToString());								
				}
				 exSheet.Cells[11 + l_row, 7].Value = dt.Rows[l_row - 1]["DVT_NPL"].ToString();	
				  if(dt.Rows[l_row - 1]["CIF"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 8].Value = double.Parse(dt.Rows[l_row - 1]["CIF"].ToString());
					}
				if(dt.Rows[l_row - 1]["TY_GIA"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 9].Value = double.Parse(dt.Rows[l_row - 1]["TY_GIA"].ToString());	
				}
				 if(dt.Rows[l_row - 1]["TS_NK"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 10].Value = double.Parse(dt.Rows[l_row - 1]["TS_NK"].ToString());
				}
				 if(dt.Rows[l_row - 1]["TS_VAT"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 11].Value = double.Parse(dt.Rows[l_row - 1]["TS_VAT"].ToString());
				 }
				if(dt.Rows[l_row - 1]["TS_TTDB"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 12].Value =double.Parse(dt.Rows[l_row - 1]["TS_TTDB"].ToString());
				}
				if(dt.Rows[l_row - 1]["TS_CL"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 13].Value = double.Parse(dt.Rows[l_row - 1]["TS_CL"].ToString());	
				}
				if(dt.Rows[l_row - 1]["TT_NK"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 14].Value = double.Parse(dt.Rows[l_row - 1]["TT_NK"].ToString());
				}
				if(dt.Rows[l_row - 1]["TT_VAT"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 15].Value = double.Parse(dt.Rows[l_row - 1]["TT_VAT"].ToString());
				}				
				if(dt.Rows[l_row - 1]["TT_TTDB"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 16].Value = double.Parse(dt.Rows[l_row - 1]["TT_TTDB"].ToString());
				}
				if(dt.Rows[l_row - 1]["TT_CL"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 17].Value = double.Parse(dt.Rows[l_row - 1]["TT_CL"].ToString());
				}
				// string para2="'" + dt.Rows[l_row - 1]["MA_HQ"] + "','" + dt.Rows[l_row - 1]["LAN_TL"]  + "','" + dt.Rows[l_row - 1]["MA_NPL"]+ "','" + dt.Rows[l_row - 1]["SO_TK"]+ "','" + dt.Rows[l_row - 1]["MA_LH"]+"','" +dt.Rows[l_row - 1]["NAM_DK"] + "','" + dt.Rows[l_row - 1]["MA_DV"]+ "'";
				// DataTable dt2 = ESysLib.TableReadOpenCursor("lg_sel_ephl00060_10100_sub",para2);	
				// for (int l_row2 = 0; l_row2 < dt2.Rows.Count; l_row++)
				// {
					// exSheet.Cells[11 + l_row + i, 3].Value= dt2.Rows[l_row - 1]["TEN_NPL"].ToString();
				// }
				
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
