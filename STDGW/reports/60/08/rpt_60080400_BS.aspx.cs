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

public partial class rpt_60080400_BS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string l_status  = Request["p_status"];
		string l_company = Request["p_tco_company_pk"];
		string l_date_f  = Request["p_date_fr"];
		string l_date    = Request["p_date_to"];
		string l_kind    = Request["p_kind"];
		string l_crt_by  = Request["p_crt_by"];
		string l_scale   = Request["p_Scale"];
		string l_ccy 	 = Request["p_ccy"];
		string l_lang 	 = Request["p_lang"]; 	
		string l_AmountType 	 = Request["p_AmountType"]; 	
		
		string fr_dt = "";
		string to_dt = "";
		string l_cmp_name = "";
		string l_cmp_add = "";
		string l_cmp_taxcode = "";
		string to_dt_e = "";
		string quater = "";
		string curr_date = "";
		string last_Date = "";
		
        string TemplateFile = "rpt_60080400_BS.xls";
        string TempFile = "../../../system/temp/rpt_60080400_BS_" + Session["User_ID"].ToString() + ".xls";
     
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
		para = "'" + l_company +"','" +l_date_f+ "','"+l_date+"','"+l_status+ "','"+l_scale+"'";
		// Response.Write(para);
			// Response.End();
		DataTable dt_detail = ESysLib.TableReadOpenCursor("ac_sel_60080400_bs_usd", para);
		
		if (dt_detail.Rows.Count == 0)
        {
			Response.Write("No data!!");
			Response.End();
        }
		
		string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE " +
        ",to_char(to_date('" + l_date_f + "','yyyymmdd'),'dd/mm/yyyy') fr_dt,to_char(to_date('" + l_date + "','yyyymmdd'),'dd/mm/yyyy') to_dt" +
		  ",to_char(to_date('" + l_date + "','yyyymmdd'),'dd-Mon-yyyy') sign_dt" +
		  ",to_char(to_date('" + l_date + "','yyyymmdd'),'MM/yyyy') curr_date" +
		  "  FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
		DataTable dt = ESysLib.TableReadOpen(SQL1);
		if (dt.Rows.Count > 0)
		{
			l_cmp_name = dt.Rows[0][0].ToString();
			l_cmp_add = dt.Rows[0][1].ToString();
			l_cmp_taxcode = dt.Rows[0][3].ToString();
			fr_dt = dt.Rows[0][4].ToString();
			to_dt = dt.Rows[0][5].ToString();
			to_dt_e = dt.Rows[0][6].ToString();
		
			exSheet.Cells[1, 1].Value  = l_cmp_name;
			exSheet.Cells[2, 1].Value  = "Address/địa chỉ/주소: "+ l_cmp_add;
			exSheet.Cells[6, 1].Value  = "As at/tại ngày/현재 : "+ to_dt;
			exSheet.Cells[7, 6].Value  = "(Unit/đơn vị/단위 : "+ l_ccy+")";
			exSheet.Cells[7, 9].Value  = "(Unit/đơn vị/단위 : "+ l_ccy+")";
			exSheet.Cells[7, 11].Value  = "(Unit/đơn vị/단위 : "+ l_ccy+")";
			exSheet.Cells[27, 9].Value  = "As at/tại ngày/현재 : "+ to_dt;
        }
		
		if(l_lang=="ENG")
		{
			range = exSheet.Range["B1:C1"];
			range.Columns.Hidden = true;
		}
		else if(l_lang=="ENG-KOR")
		{
			range = exSheet.Range["B1"];
			range.Columns.Hidden = true;
		}
		else if(l_lang=="ENG-VIE")
		{
			range = exSheet.Range["C1"];
			range.Columns.Hidden = true;
		}
		else if(l_lang=="KOR")
		{
			range = exSheet.Range["A1:B1"];
			range.Columns.Hidden = true;
		}
		else if(l_lang=="KOR-VIE")
		{
			range = exSheet.Range["A1"];
			range.Columns.Hidden = true;
		}
		else if(l_lang=="VIE")
		{
			range = exSheet.Range["A1"];
			range.Columns.Hidden = true;
			range = exSheet.Range["C1"];
			range.Columns.Hidden = true;
		}
		//===============================================================
		if(l_AmountType=="01")//Book
		{
			range = exSheet.Range["H1:K1"];
			range.Columns.Hidden = true;
		}
		else if(l_AmountType=="02")//book & usd
		{
			range = exSheet.Range["J1:K1"];
			range.Columns.Hidden = true;
			exSheet.Cells[7, 6].Value  = "";
		}
		else if(l_AmountType=="03")//book & won
		{
			range = exSheet.Range["H1:I1"];
			range.Columns.Hidden = true;
			exSheet.Cells[7, 6].Value  = "";
		}
		else if(l_AmountType=="04")//usd
		{
			range = exSheet.Range["F1:G1"];
			range.Columns.Hidden = true;
			range = exSheet.Range["J1:K1"];
			range.Columns.Hidden = true;
		}
		else if(l_AmountType=="05")//won
		{
			range = exSheet.Range["F1:I1"];
			range.Columns.Hidden = true;
		}
		else if(l_AmountType=="06")//
		{
			exSheet.Cells[7, 6].Value  = "";
			exSheet.Cells[7, 8].Value  = "";
		}
		//==============================================================================================================================================
		int i;
		for (int l_addrow =94; l_addrow < dt_detail.Rows.Count; l_addrow++)
        {
            exSheet.Range["A24"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		if (dt_detail.Rows.Count > 0)
		{
			int j=0;
			for (i = 91; i < dt_detail.Rows.Count; i++)
			{
				j=j+1;
				 exSheet.Cells[22 + j, 1].Value = dt_detail.Rows[i]["prn_acnm"].ToString();
				 exSheet.Cells[22 + j, 2].Value = dt_detail.Rows[i]["prn_lacnm"].ToString();
				 exSheet.Cells[22 + j, 3].Value = dt_detail.Rows[i]["prn_kacnm"].ToString();
				 exSheet.Cells[22 + j, 4].Value = dt_detail.Rows[i]["code"].ToString();
				 exSheet.Cells[22 + j, 5].Value = dt_detail.Rows[i]["header"].ToString();
				 exSheet.Cells[22 + j, 6].Value = Decimal.Parse(dt_detail.Rows[i]["closing"].ToString());
				 exSheet.Cells[22 + j, 7].Value = Decimal.Parse(dt_detail.Rows[i]["openning"].ToString());
				 exSheet.Cells[22 + j, 8].Value = Decimal.Parse(dt_detail.Rows[i]["closing_usd"].ToString());
				 exSheet.Cells[22 + j, 9].Value = Decimal.Parse(dt_detail.Rows[i]["openning_usd"].ToString());
				 exSheet.Cells[22 + j, 10].Value = Decimal.Parse(dt_detail.Rows[i]["closing_won"].ToString());
				 exSheet.Cells[22 + j, 11].Value = Decimal.Parse(dt_detail.Rows[i]["openning_won"].ToString());
				
				string l_Color = "";
				string l_Bold = "";
				l_Bold = dt_detail.Rows[i]["font_stype"].ToString();
				l_Color = "0X" + dt_detail.Rows[i]["prn_color"].ToString().Substring(6,2) + dt_detail.Rows[i]["prn_color"].ToString().Substring(4,2) + dt_detail.Rows[i]["prn_color"].ToString().Substring(2,2);
				Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
				for (int col = 0; col <= 10; col++)
				{
					if(l_Bold=="B")
					{
						exSheet.Cells[22 + j, col + 1].Font.Bold = true;
					}
					else if(l_Bold=="I")
					{
						exSheet.Cells[22 + j, col + 1].Font.Italic = true;
					}
					exSheet.Cells[22 + j, col + 1].Interior.Color = colorValueFrmHex;
				}
			}
        }
		//==============================================================================================================================================
		for (int l_addrow =54; l_addrow < 89 ; l_addrow++)
        {
            exSheet.Range["A17"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		if (dt_detail.Rows.Count > 0)
		{
			int j=0;
			for (i = 53; i < 91; i++)
			{
				j=j+1;
				 exSheet.Cells[15 + j, 1].Value = dt_detail.Rows[i]["prn_acnm"].ToString();
				 exSheet.Cells[15 + j, 2].Value = dt_detail.Rows[i]["prn_lacnm"].ToString();
				 exSheet.Cells[15 + j, 3].Value = dt_detail.Rows[i]["prn_kacnm"].ToString();
				 exSheet.Cells[15 + j, 4].Value = dt_detail.Rows[i]["code"].ToString();
				 exSheet.Cells[15 + j, 5].Value = dt_detail.Rows[i]["header"].ToString();
				 exSheet.Cells[15 + j, 6].Value = Decimal.Parse(dt_detail.Rows[i]["closing"].ToString());
				 exSheet.Cells[15 + j, 7].Value = Decimal.Parse(dt_detail.Rows[i]["openning"].ToString());
				 exSheet.Cells[15 + j, 8].Value = Decimal.Parse(dt_detail.Rows[i]["closing_usd"].ToString());
				 exSheet.Cells[15 + j, 9].Value = Decimal.Parse(dt_detail.Rows[i]["openning_usd"].ToString());
				 exSheet.Cells[15 + j, 10].Value = Decimal.Parse(dt_detail.Rows[i]["closing_won"].ToString());
				 exSheet.Cells[15 + j, 11].Value = Decimal.Parse(dt_detail.Rows[i]["openning_won"].ToString());
				
				string l_Color = "";
				string l_Bold = "";
				l_Bold = dt_detail.Rows[i]["font_stype"].ToString();
				l_Color = "0X" + dt_detail.Rows[i]["prn_color"].ToString().Substring(6,2) + dt_detail.Rows[i]["prn_color"].ToString().Substring(4,2) + dt_detail.Rows[i]["prn_color"].ToString().Substring(2,2);
				Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
				for (int col = 0; col <= 10; col++)
				{
					if(l_Bold=="B")
					{
						exSheet.Cells[15 + j, col + 1].Font.Bold = true;
					}
					else if(l_Bold=="I")
					{
						exSheet.Cells[15 + j, col + 1].Font.Italic = true;
					}
					exSheet.Cells[15 + j, col + 1].Interior.Color = colorValueFrmHex;
				}
			}
        }
		//===================================================================================================================================
        for (int l_addrow =1; l_addrow < 51 ; l_addrow++)
        {
            exSheet.Range["A12"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		if (dt_detail.Rows.Count > 0)
		{
			for (i = 0; i < 53; i++)
			{
				 exSheet.Cells[10 + i, 1].Value = dt_detail.Rows[i]["prn_acnm"].ToString();
				 exSheet.Cells[10 + i, 2].Value = dt_detail.Rows[i]["prn_lacnm"].ToString();
				 exSheet.Cells[10 + i, 3].Value = dt_detail.Rows[i]["prn_kacnm"].ToString();
				 exSheet.Cells[10 + i, 4].Value = dt_detail.Rows[i]["code"].ToString();
				 exSheet.Cells[10 + i, 5].Value = dt_detail.Rows[i]["header"].ToString();
				 exSheet.Cells[10 + i, 6].Value = Decimal.Parse(dt_detail.Rows[i]["closing"].ToString());
				 exSheet.Cells[10 + i, 7].Value = Decimal.Parse(dt_detail.Rows[i]["openning"].ToString());
				 exSheet.Cells[10 + i, 8].Value = Decimal.Parse(dt_detail.Rows[i]["closing_usd"].ToString());
				 exSheet.Cells[10 + i, 9].Value = Decimal.Parse(dt_detail.Rows[i]["openning_usd"].ToString());
				 exSheet.Cells[10 + i, 10].Value = Decimal.Parse(dt_detail.Rows[i]["closing_won"].ToString());
				 exSheet.Cells[10 + i, 11].Value = Decimal.Parse(dt_detail.Rows[i]["openning_won"].ToString());
				 
				string l_Color = "";
				string l_Bold = "";
				l_Bold = dt_detail.Rows[i]["font_stype"].ToString();
				l_Color = "0X" + dt_detail.Rows[i]["prn_color"].ToString().Substring(6,2) + dt_detail.Rows[i]["prn_color"].ToString().Substring(4,2) + dt_detail.Rows[i]["prn_color"].ToString().Substring(2,2);
				Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
				for (int col = 0; col <= 10; col++)
				{
					if(l_Bold=="B")
					{
						exSheet.Cells[10 + i, col + 1].Font.Bold = true;
					}
					else if(l_Bold=="I")
					{
						exSheet.Cells[10 + i, col + 1].Font.Italic = true;
					}
					exSheet.Cells[10 + i, col + 1].Interior.Color = colorValueFrmHex;
				}
			}
        }
		//=====================================================================================================================================
		
		
		
		
		
		
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