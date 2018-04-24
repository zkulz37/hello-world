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

public partial class rpt_60081341_01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		string l_company_pk = Request["company_pk"];
		string l_acc_pk = Request["acc_pk"];
		string l_plc_pk = Request["plc_pk"];
		string l_pl_pk = Request["pl_pk"];
		string l_month = Request["month"];  
		string l_status = Request["status"];
		string l_fs = Request["fs"];
		string l_report = Request["report"];  
		
        string TemplateFile = "rpt_60081341_01.xls";
        string TempFile = "../../../system/temp/rpt_60081341_01_" + Session["User_ID"].ToString() + ".xls";
		
	   TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
        //Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;
		
        //bind data to excel file
        string para = "";
		string para1 = "";
        DataTable dt,dt_mst;
		para= "'" + l_company_pk +"','"+l_acc_pk+"','"+l_plc_pk+"','"+l_pl_pk+"','"+l_month+"','"+l_status+"','"+l_fs+"','"+l_report+"'"; 
		// Response.Write(para);
		// Response.End();
		dt = ESysLib.TableReadOpenCursor("ac_sel_60081341", para);
		
		string p_xls_ccy_format ="";
		string p_bookccy = "";
	    string SQL = "SELECT AC_GET_BOOKCCY_ACNT('ACBG0040') FROM DUAL " ;
		DataTable dt_bookccy = ESysLib.TableReadOpen(SQL);

		if (dt_bookccy.Rows.Count >0)
		{	
			p_bookccy = dt_bookccy.Rows[0][0].ToString();
		}
		if (p_bookccy == "VND")
		{
			p_xls_ccy_format = "#,##0";
		}
		else
		{
			p_xls_ccy_format = "#,##0.00";
		}
		
		
		exSheet.Cells[1, 2].Value = "▣ "+l_month.Substring(0,4)+" Cost -Details (Golf)";
		exSheet.Cells[3, 3].Value = l_month.Substring(0,4)+" FY";
		int _row = 3;
		string l_Color = "";
		string l_Bold = "";	
		for (int l_addrow = 0; l_addrow < dt.Rows.Count-1; l_addrow++)
        {
            exSheet.Range[3+l_addrow+1,1].Rows.EntireRow.Insert();//insert row new of sheet
        }
		decimal jan_this = 0, feb_this = 0, mar_this = 0, apr_this = 0, may_this = 0, jun_this = 0, jul_this = 0, aug_this = 0, sep_this = 0, oct_this = 0, nov_this = 0, dec_this = 0, acc_this = 0;
		for (int i = 2; i < dt.Rows.Count;i++)
		{
			for(int col=1;col<=14;col++)
			{
				exSheet.Cells[_row + i, 2].Value = dt.Rows[i]["prn_acnm"].ToString();
				exSheet.Cells[_row + i, 3].Value = decimal.Parse(dt.Rows[i]["jan_this"].ToString());
				exSheet.Cells[_row + i, 3].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 4].Value = decimal.Parse(dt.Rows[i]["feb_this"].ToString());
				exSheet.Cells[_row + i, 4].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 5].Value = decimal.Parse(dt.Rows[i]["mar_this"].ToString());
				exSheet.Cells[_row + i, 5].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 6].Value = decimal.Parse(dt.Rows[i]["apr_this"].ToString());
				exSheet.Cells[_row + i, 6].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 7].Value = decimal.Parse(dt.Rows[i]["may_this"].ToString());
				exSheet.Cells[_row + i, 7].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 8].Value = decimal.Parse(dt.Rows[i]["jun_this"].ToString());
				exSheet.Cells[_row + i, 8].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 9].Value = decimal.Parse(dt.Rows[i]["jul_this"].ToString());
				exSheet.Cells[_row + i, 9].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 10].Value = decimal.Parse(dt.Rows[i]["aug_this"].ToString());
				exSheet.Cells[_row + i, 10].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 11].Value = decimal.Parse(dt.Rows[i]["sep_this"].ToString());
				exSheet.Cells[_row + i, 11].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 12].Value = decimal.Parse(dt.Rows[i]["oct_this"].ToString());
				exSheet.Cells[_row + i, 12].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 13].Value = decimal.Parse(dt.Rows[i]["nov_this"].ToString());
				exSheet.Cells[_row + i, 13].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 14].Value = decimal.Parse(dt.Rows[i]["dec_this"].ToString());
				exSheet.Cells[_row + i, 14].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row + i, 15].Value = decimal.Parse(dt.Rows[i]["acc_this"].ToString());
				exSheet.Cells[_row + i, 15].NumberFormat = p_xls_ccy_format;
			
				l_Bold = dt.Rows[i]["font_stype"].ToString();
				l_Color = "0X" + dt.Rows[i]["prn_color"].ToString().Substring(6,2) + dt.Rows[i]["prn_color"].ToString().Substring(4,2) + dt.Rows[i]["prn_color"].ToString().Substring(2,2);
				
				if(l_Bold=="B")
				{
					exSheet.Cells[_row + i, col + 1].Font.Bold = true;
				}
				Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
				exSheet.Cells[_row + i, col + 1].Interior.Color = colorValueFrmHex;
			}
			
			/*jan_this += decimal.Parse(dt.Rows[i]["jan_this"].ToString()); 	
			feb_this += decimal.Parse(dt.Rows[i]["feb_this"].ToString());
			mar_this += decimal.Parse(dt.Rows[i]["mar_this"].ToString());
			apr_this += decimal.Parse(dt.Rows[i]["apr_this"].ToString());
			may_this += decimal.Parse(dt.Rows[i]["may_this"].ToString());
			jun_this += decimal.Parse(dt.Rows[i]["jun_this"].ToString());
			jul_this += decimal.Parse(dt.Rows[i]["jul_this"].ToString());
			aug_this += decimal.Parse(dt.Rows[i]["aug_this"].ToString());
			sep_this += decimal.Parse(dt.Rows[i]["sep_this"].ToString());
			oct_this += decimal.Parse(dt.Rows[i]["oct_this"].ToString());
			nov_this += decimal.Parse(dt.Rows[i]["nov_this"].ToString());
			dec_this += decimal.Parse(dt.Rows[i]["dec_this"].ToString());
			acc_this += decimal.Parse(dt.Rows[i]["acc_this"].ToString());
			*/
		}	
		/**/
		//exSheet.UsedRange.Rows.Autofit();
	
		
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


        // hide row firts 

        //range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;

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