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

public partial class rpt_60090190_AgedPay : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser("acnt");;  
        string TemplateFile = "rpt_60090190_AgedPay_Over_DueDate.xls";
        string TempFile = "../../../system/temp/rpt_60090190_AgedPay_Over_DueDate_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string p_comp_pk = ""+Request["p_com_pk"];	
		
		string p_from_date = ""+Request["p_from_date"];	
		
		string p_to_date = ""+Request["p_to_date"];
		
		string p_acc_pk = ""+Request["p_acc_pk"];
		
		string p_tco_buspartner_pk = ""+Request["p_tco_buspartner_pk"];
		
		string SQL = "" ;

		// Format number in report
		string p_xls_ccy_format = "" ;
		
		// variables for details information about payable amount
		decimal l_due_30 = 0, l_due_60 = 0, l_due_90 = 0, l_over_due_90 = 0, l_amount_due = 0;
		
		// variables for sub total pyable amount by customer
		decimal l_tot_due_30 = 0, l_tot_due_60 = 0, l_tot_due_90 = 0, l_tot_over_due_90 = 0 ;
		
		// company info
		string v_comp_name = "", v_date_report = "" ;

		// Counter for loop
		int i = 0, n = 0, _row = 0, j = 0 ;
		
		// Customer PK
		decimal l_customer_pk = 0 ;
		
		SQL = "select partner_name, to_char(to_date('" + p_to_date + "', 'YYYYMMDD'), 'MON DD, YYYY') date_report from tco_company where del_if = 0 and pk = '" + p_comp_pk + "'" ;	
		
		DataTable dtComp = ESysLib.TableReadOpen(SQL);
		
		if(dtComp.Rows.Count > 0)
		{
			v_comp_name = dtComp.Rows[0][0].ToString();
			v_date_report = dtComp.Rows[0][1].ToString();
		}
		// parameter for store 		
		SQL = "'" + p_comp_pk + "', '" + p_from_date + "', '" + p_to_date + "', '" + p_acc_pk + "', '" + p_tco_buspartner_pk + "'" ;
		
		DataTable dtDtl = ESysLib.TableReadOpenCursor("ac_sel_rpt_60090190_AgedPay", SQL);		
		
		DataTable dtMst = ESysLib.TableReadOpenCursor("ac_sel_rpt_60090190_AgedPay_2", SQL);
		
		DataTable dtSum = ESysLib.TableReadOpenCursor("ac_sel_rpt_60090190_AgedPay_3", SQL);
			
		// Company Name		
		exSheet.Cells[1, 2].Value = v_comp_name ;
		// Report Title
		exSheet.Cells[3, 1].Value = "Aged Payables As of " + v_date_report ;

		j = int.Parse(dtMst.Rows[0]["count_partner"].ToString()) ;
		
		for (int l_addrow = 1; l_addrow < dtDtl.Rows.Count + j; l_addrow++)
        {
            exSheet.Range["A8"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		// store customer_pk to compare when writing new record
		l_customer_pk = -1 ;
		_row = 7 ;
		
        for (i = 0; i < dtDtl.Rows.Count; i++)
        {			
			if(l_customer_pk > -1 && l_customer_pk != decimal.Parse(dtDtl.Rows[i]["pk"].ToString()) )
			{
				for(j = 1; j <= 11; j++)
				{
					exSheet.Cells[_row, j].Font.Bold = true;				
				}	
				
				exSheet.Cells[_row, 2].Value = "" ;
									
				exSheet.Cells[_row , 7].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row , 8].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row , 9].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row , 10].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row , 11].NumberFormat = p_xls_ccy_format;
				
				exSheet.Cells[_row, 7].Value = l_tot_due_30 ;
				
				exSheet.Cells[_row, 8].Value = l_tot_due_60 ;
				
				exSheet.Cells[_row, 9].Value = l_tot_due_90 ;
				
				exSheet.Cells[_row, 10].Value = l_tot_over_due_90 ;
				
				l_tot_due_30 = 0 ;
				l_tot_due_60 = 0 ;
				l_tot_due_90 = 0 ;
				l_tot_over_due_90 = 0 ;
				
				l_customer_pk = decimal.Parse(dtDtl.Rows[i]["pk"].ToString()) ;
				
				_row += 1;
			}			
		
			exSheet.Cells[_row , 1].Value = i + 1; // No
			
			exSheet.Cells[_row , 2].Value = dtDtl.Rows[i]["partner_id"].ToString(); // Vendor ID
			
			exSheet.Cells[_row , 3].Value = dtDtl.Rows[i]["partner_name"].ToString(); // Vendor Name
			
			exSheet.Cells[_row , 4].Value = dtDtl.Rows[i]["serial_no"].ToString(); // Serial No
			
			exSheet.Cells[_row , 5].Value = dtDtl.Rows[i]["invoice_no"].ToString(); // Invoice No
			
			exSheet.Cells[_row , 6].Value = dtDtl.Rows[i]["tr_ccy"].ToString(); // Transaction currency

			if(dtDtl.Rows[i]["tr_ccy"].ToString() == "VND")
			{
				p_xls_ccy_format = "#,##0" ;										
			}
			else
			{
				p_xls_ccy_format = "#,##0.00" ;
			}
			
			if(dtDtl.Rows[i]["due_30"].ToString() != "")
			{
				l_due_30 = decimal.Parse(dtDtl.Rows[i]["due_30"].ToString());
				
				exSheet.Cells[_row , 7].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row , 7].Value = l_due_30 ; // Payable amount over due <= 30 days
				l_tot_due_30 += l_due_30 ;
			}
			else
			{
				l_due_30 = 0 ;
			}
			
			if(dtDtl.Rows[i]["due_60"].ToString() != "")
			{
				l_due_60 = decimal.Parse(dtDtl.Rows[i]["due_60"].ToString());
				
				exSheet.Cells[_row , 8].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row , 8].Value = l_due_60 ; // Payable amount over due <= 60 days
				
				l_tot_due_60 += l_due_60 ;
			}
			else
			{
				l_due_60 = 0 ;
			}

			if(dtDtl.Rows[i]["due_90"].ToString() != "")
			{
				l_due_90 = decimal.Parse(dtDtl.Rows[i]["due_90"].ToString());
				
				exSheet.Cells[_row , 9].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row , 9].Value = l_due_90 ; // Payable amount over due <= 90 days
				
				l_tot_due_90 += l_due_90 ;
			}
			else
			{
				l_due_90 = 0 ;
			}
			
			if(dtDtl.Rows[i]["over_due_90"].ToString() != "")
			{
				l_over_due_90 = decimal.Parse(dtDtl.Rows[i]["over_due_90"].ToString());
				
				exSheet.Cells[_row , 10].NumberFormat = p_xls_ccy_format;
				exSheet.Cells[_row , 10].Value = l_over_due_90 ; // Payable amount over due 90 days
				
				l_tot_over_due_90 += l_over_due_90 ;
			}
			else
			{
				l_over_due_90 = 0 ;
			}
			
			exSheet.Cells[_row , 11].NumberFormat = p_xls_ccy_format;
			
			l_amount_due = l_due_30 + l_due_60 + l_due_90 + l_over_due_90 ;
			
			exSheet.Cells[_row , 11].Value = l_amount_due ;
			
			l_customer_pk = decimal.Parse(dtDtl.Rows[i]["pk"].ToString()) ;			
			
			_row += 1 ;
		}

		for(j = 1; j <= 11; j++)
		{
			exSheet.Cells[_row, j].Font.Bold = true;				
		}				
							
		exSheet.Cells[_row , 7].NumberFormat = p_xls_ccy_format;
		exSheet.Cells[_row , 8].NumberFormat = p_xls_ccy_format;
		exSheet.Cells[_row , 9].NumberFormat = p_xls_ccy_format;
		exSheet.Cells[_row , 10].NumberFormat = p_xls_ccy_format;
		exSheet.Cells[_row , 11].NumberFormat = p_xls_ccy_format;
		
		exSheet.Cells[_row, 7].Value = l_tot_due_30 ;
		
		exSheet.Cells[_row, 8].Value = l_tot_due_60 ;
		
		exSheet.Cells[_row, 9].Value = l_tot_due_90 ;
		
		exSheet.Cells[_row, 10].Value = l_tot_over_due_90 ;
		
		_row += 1 ;					
		
		for(i = 0; i < dtSum.Rows.Count; i++)
		{
			
			if(dtSum.Rows[i]["tr_ccy"].ToString() == "VND")
			{
				p_xls_ccy_format = "#,##0";										
			}
			else
			{
				p_xls_ccy_format = "#,##0.00" ;
			}

			for(j = 1; j <= 11; j++)
			{
				exSheet.Cells[_row, j].Font.Bold = true;				
			}	
			
			for(j = 7; j <= 11; j++)
			{
				exSheet.Cells[_row , j].NumberFormat = p_xls_ccy_format;
			}
			
			exSheet.Cells[ _row, 6].Value = dtSum.Rows[i]["tr_ccy"].ToString() ;
			
			// Total Amount 			
			if(dtSum.Rows[i]["due_30"].ToString() != "")
			{
				exSheet.Cells[ _row, 7].Value = decimal.Parse(dtSum.Rows[i]["due_30"].ToString()) ; // Total Due 30
			}
			else
			{
				exSheet.Cells[ _row, 7].Value = 0 ;
			}
			
			if(dtSum.Rows[i]["due_60"].ToString() != "")
			{
				exSheet.Cells[ _row, 8].Value = decimal.Parse(dtSum.Rows[i]["due_60"].ToString()) ; // Total Due 60
			}
			else
			{
				exSheet.Cells[ _row, 8].Value = 0 ;
			}
			
			if(dtSum.Rows[i]["due_90"].ToString() != "")
			{
				exSheet.Cells[ _row, 9].Value = decimal.Parse(dtSum.Rows[i]["due_90"].ToString()) ; // Total Due 90
			}
			else
			{
				exSheet.Cells[ _row, 9].Value = 0 ;
			}	
			
			if(dtSum.Rows[i]["over_due_90"].ToString() != "")
			{
				exSheet.Cells[ _row, 10].Value = decimal.Parse(dtSum.Rows[i]["over_due_90"].ToString()) ; // Total Over Due 90
			}
			else
			{
				exSheet.Cells[ _row, 10].Value = 0 ;
			}
			
			_row += 1 ;	
			
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