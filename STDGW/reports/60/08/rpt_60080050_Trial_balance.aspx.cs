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

public partial class rpt_60080050_Trial_balance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());  
        string TemplateFile = "rpt_60080050_Trial_balance.xls";
        string TempFile = "../../../system/temp/rpt_60080050_Trial_balance_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string p_tco_company_pk = ""+Request["p_tco_company_pk"];
		string p_lang = ""+Request["p_lang"];
		string p_date_fr= ""+Request["p_date_fr"];
		string p_date_to = ""+Request["p_date_to"];
		string p_status = ""+Request["p_status"];
		string p_level = ""+Request["p_level"];
		string p_possum = ""+Request["p_possum"];	
		string p_accd = ""+Request["p_accd"];
		string p_pacctype = ""+Request["p_pacctype"];		
		
		int i = 0;
		string para="'" + p_tco_company_pk + "','" + p_lang  + "','" + p_date_fr + "','" + p_date_to + "','" + p_status + "','" + p_level + "','" + p_possum + "','" + p_accd + "','" + p_pacctype + "'";
		DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60080050_detail",para);
		DataTable dtMST = ESysLib.TableReadOpenCursor("ac_sel_company_info",p_tco_company_pk);	
		DataTable dtTotal = ESysLib.TableReadOpenCursor("ac_sel_60080050_sum",para);
       //ac_rpt_60080050_detail
		if (dtMST.Rows.Count >0)
		{
			exSheet.Cells[1,1].Value = dtMST.Rows[0]["partner_lname"].ToString(); 
			exSheet.Cells[2,1].Value = dtMST.Rows[0]["addr2"].ToString(); 
			exSheet.Cells[3,1].Value = "Tax Code/MST :"+ dtMST.Rows[0]["tax_code"].ToString(); 
		}
		//	exSheet.Cells[5,1].Value = dtMST.Rows[0]["date_para"].ToString();	
		exSheet.Cells[5,1].Value = "From date "+p_date_fr.Substring(6,2)+"/"+p_date_fr.Substring(4,2)+"/"+p_date_fr.Substring(0,4)+" ~ "+p_date_to.Substring(6,2)+"/"+p_date_to.Substring(4,2)+"/"+p_date_to.Substring(0,4);
		string l_Bold = "";	
		string p_bookccy = "";
		string p_xls_ccy_format ="";
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
		if(dtTotal.Rows.Count>0)
		{
			exSheet.Cells[10,6].Value = decimal.Parse(dtTotal.Rows[1]["dr_op"].ToString());	
			exSheet.Cells[10,6].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[10,7].Value = decimal.Parse(dtTotal.Rows[1]["cr_op"].ToString());
			exSheet.Cells[10,7].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[10,8].Value = decimal.Parse(dtTotal.Rows[1]["dr_ps"].ToString());
			exSheet.Cells[10,8].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[10,9].Value = decimal.Parse(dtTotal.Rows[1]["cr_ps"].ToString());
			exSheet.Cells[10,9].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[10,10].Value = decimal.Parse(dtTotal.Rows[1]["dr_acc"].ToString());
			exSheet.Cells[10,10].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[10,11].Value = decimal.Parse(dtTotal.Rows[1]["cr_acc"].ToString());
			exSheet.Cells[10,11].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[10,12].Value = decimal.Parse(dtTotal.Rows[1]["dr_bl"].ToString());
			exSheet.Cells[10,12].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[10,13].Value = decimal.Parse(dtTotal.Rows[1]["cr_bl"].ToString());			
			exSheet.Cells[10,13].NumberFormat = p_xls_ccy_format;
		}	
		
		for (int l_addrow = 2; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A10"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		if(p_lang=="ENG")
		{
			range = exSheet.Range["C1:D1"];
			range.Columns.Hidden = true;
		}
		else if(p_lang=="ENG-KOR")
		{
			range = exSheet.Range["C1"];
			range.Columns.Hidden = true;
		}
		else if(p_lang=="ENG-VIE")
		{
			range = exSheet.Range["D1"];
			range.Columns.Hidden = true;
		}
		else if(p_lang=="ENG-VIE-KOR")
		{
			
		}
		else if(p_lang=="KOR")
		{
			range = exSheet.Range["B1:C1"];
			range.Columns.Hidden = true;
		}
		else if(p_lang=="KOR-VIE")
		{
			range = exSheet.Range["B1"];
			range.Columns.Hidden = true;
		}
		else if(p_lang=="VIE")
		{
			range = exSheet.Range["B1"];
			range.Columns.Hidden = true;
			range = exSheet.Range["D1"];
			range.Columns.Hidden = true;
		}
        
		
        for (int l_row = 2; l_row <= dt.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 12; col++)
			{
				if( col==0)
                {					
						exSheet.Cells[7 + l_row, col + 1].Value = dt.Rows[l_row - 1]["ac_cd"].ToString();
				}
				if( col==1)
                {
					exSheet.Cells[7+ l_row, col + 1].Value =dt.Rows[l_row - 1]["ac_nm"].ToString();	//ac_nm1				
				}
				if( col==2)
                {
					exSheet.Cells[7+ l_row, col + 1].Value =dt.Rows[l_row - 1]["local_nm"].ToString();	//ac_nm1				
				}
				if( col==3)
                {
					exSheet.Cells[7+ l_row, col + 1].Value =dt.Rows[l_row - 1]["kor_nm"].ToString();	//ac_nm1				
				}
				if( col==4)
                {	
					if(dt.Rows[l_row - 1]["ac_level"].ToString()!="")
					{
						exSheet.Cells[7 + l_row, col + 1].Value = dt.Rows[l_row - 1]["ac_level"].ToString();
					}
				}
				if( col==5)
                {	
					if(dt.Rows[l_row - 1]["dr_op"].ToString()!="")
					{
						exSheet.Cells[7 + l_row, col + 1].Value = decimal.Parse(dt.Rows[l_row - 1]["dr_op"].ToString());
						exSheet.Cells[7 + l_row, col + 1].NumberFormat = p_xls_ccy_format;
					}
				}
				if( col==6)
                {	
					if(dt.Rows[l_row - 1]["cr_op"].ToString()!="")
					{
						exSheet.Cells[7 + l_row, col + 1].Value = decimal.Parse(dt.Rows[l_row - 1]["cr_op"].ToString());
						exSheet.Cells[7 + l_row, col + 1].NumberFormat = p_xls_ccy_format;
					}
				}
				
				
				if( col==7)
                {	
					if(dt.Rows[l_row - 1]["dr_ps"].ToString()!="")
					{
						exSheet.Cells[7 + l_row, col + 1].Value = decimal.Parse(dt.Rows[l_row - 1]["dr_ps"].ToString());
						exSheet.Cells[7 + l_row, col + 1].NumberFormat = p_xls_ccy_format;
					}
				}
				if( col==8)
                {	
					if(dt.Rows[l_row - 1]["cr_ps"].ToString()!="")
					{
						exSheet.Cells[7 + l_row, col + 1].Value = decimal.Parse(dt.Rows[l_row - 1]["cr_ps"].ToString());
						exSheet.Cells[7 + l_row, col + 1].NumberFormat = p_xls_ccy_format;
					}
				}
				
				
				if( col==9)
                {	
					if(dt.Rows[l_row - 1]["dr_acc"].ToString()!="")
					{
						exSheet.Cells[7 + l_row, col + 1].Value = decimal.Parse(dt.Rows[l_row - 1]["dr_acc"].ToString());
						exSheet.Cells[7 + l_row, col + 1].NumberFormat = p_xls_ccy_format;
					}
				}
				if( col==10)
                {	
					if(dt.Rows[l_row - 1]["cr_acc"].ToString()!="")
					{
						exSheet.Cells[7 + l_row, col + 1].Value = decimal.Parse(dt.Rows[l_row - 1]["cr_acc"].ToString());
						exSheet.Cells[7 + l_row, col + 1].NumberFormat = p_xls_ccy_format;
					}
				}
				
				if( col==11)
                {	
					if(dt.Rows[l_row - 1]["dr_bl"].ToString()!="")
					{
						exSheet.Cells[7 + l_row, col + 1].Value = decimal.Parse(dt.Rows[l_row - 1]["dr_bl"].ToString());
						exSheet.Cells[7 + l_row, col + 1].NumberFormat = p_xls_ccy_format;
					}
				}
				if( col==12)
                {	
					if(dt.Rows[l_row - 1]["cr_bl"].ToString()!="")
					{
						exSheet.Cells[7 + l_row, col + 1].Value = decimal.Parse(dt.Rows[l_row - 1]["cr_bl"].ToString());
						exSheet.Cells[7 + l_row, col + 1].NumberFormat = p_xls_ccy_format;
					}
				}
				string l_Color = "";
				l_Bold = dt.Rows[l_row - 1]["bold_yn"].ToString();
				l_Color = "0X" + dt.Rows[l_row - 1]["color"].ToString().Substring(6,2) + dt.Rows[l_row - 1]["color"].ToString().Substring(4,2) + dt.Rows[l_row - 1]["color"].ToString().Substring(2,2);
				//0X00FFFF
				// Response.Write(l_Color);
				// Response.End();
				if(l_Bold=="B")
				{
					exSheet.Cells[7 + l_row, col + 1].Font.Bold = true;
				}
				Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
				exSheet.Cells[7 + l_row, col + 1].Interior.Color = colorValueFrmHex;
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
