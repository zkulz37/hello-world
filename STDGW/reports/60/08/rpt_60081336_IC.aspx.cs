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

public partial class rpt_60081336_IC : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		
		string l_form_type = Request["p_form_type"]; 
		string l_status = Request["p_status"];
		string l_tco_company_pk = Request["p_tco_company_pk"];
		string l_date_fr = Request["p_date_fr"];  
	    string l_date_to = Request["p_date_to"];
		string l_date_type = Request["p_date_type"];
		string l_scale = Request["p_scale"];
		string l_ccy = Request["p_ccy"]; 
		string l_exrate = Request["p_exrate"]; 
		string l_month = Request["p_month"]; 
		
		string l_date_from_text = Request["p_from_text"];  
		string l_date_to_text = Request["p_to_text"];
		string l_text_ccy = Request["p_text_ccy"];
		string l_lang 	 = Request["p_lang"]; 	
		
	/*
                                                                  
		*/
        string TemplateFile = "rpt_60081336_IC.xls";
        string TempFile = "../../../system/temp/rpt_60081336_IC_" + Session["User_ID"].ToString() + ".xls";
		
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
		
		//para= "'" + l_tco_company_pk +"','"+l_from_month+"','"+l_to_month+"','"+l_status+"','"+l_scale+"'"; 
		para= "'" + l_form_type +"','"+l_status+"','"+l_tco_company_pk+"','"+l_date_fr+"','"+l_date_to+"','"+l_date_type+"','"+l_scale+"','"+l_ccy+"','"+l_exrate+"','"+l_month+"'"; 
		para1= "'" + l_tco_company_pk+"'";
		
		
        dt = ESysLib.TableReadOpenCursor("ac_sel_60081336_ic_consol", para);
		dt_mst = ESysLib.TableReadOpenCursor("ac_sel_company_consolidate", para1);
		
	
		exSheet.Cells[6, 1].Value = "Form Date : "+l_date_from_text + "  ~  " + l_date_to_text;
		exSheet.Cells[7, 8].Value =l_text_ccy;
		
		//-----------01--------books-----------------
		
		if(l_lang=="VIE")
		{
			range = exSheet.Range["B1"];
			range.Columns.Hidden = false;
			
			range = exSheet.Range["A1"];
			range.Columns.Hidden = true;
			
			range = exSheet.Range["C1"];
			range.Columns.Hidden = true;
		}
		if(l_lang=="ENG")
		{
			range = exSheet.Range["B1"];
			range.Columns.Hidden = true;
			
			range = exSheet.Range["A1"];
			range.Columns.Hidden = false;
			
			range = exSheet.Range["C1"];
			range.Columns.Hidden = true;
		}
		if(l_lang=="KOR")
		{
			range = exSheet.Range["B1"];
			range.Columns.Hidden = true;
			
			range = exSheet.Range["A1"];
			range.Columns.Hidden = true;
			
			range = exSheet.Range["C1"];
			range.Columns.Hidden = false;
		}
		
		if(l_lang=="ENG-KOR")
		{
			range = exSheet.Range["B1"];
			range.Columns.Hidden = true;
		}
		if(l_lang=="ENG-VIE")
		{
			range = exSheet.Range["C1"];
			range.Columns.Hidden = true;
		}
		if(l_lang=="KOR-VIE")
		{
			range = exSheet.Range["A1"];
			range.Columns.Hidden = true;
		}
		
		
		
		if (dt_mst.Rows.Count > 0)   
        {
			exSheet.Cells[1, 1].Value   =  dt_mst.Rows[0]["code_nm"].ToString();
			
		}
		 
	//-------------------------------------------------
       for (int l_addrow = 1; l_addrow < dt.Rows.Count ; l_addrow++)
        {
            exSheet.Range["A11"].Rows.EntireRow.Insert();//insert row new of sheet
        }
	//-------------------------------------------------
	
		int l_dt_cnt = dt.Rows.Count;
		int k=0;
		 for (int c = 0; c < dt.Rows.Count;c++)
				{
					
					
								exSheet.Cells[10 + c, 1].Value = dt.Rows[c]["prn_acnm"].ToString();
								exSheet.Cells[10 + c, 2].Value = dt.Rows[c]["prn_lacnm"].ToString();
								exSheet.Cells[10 + c, 3].Value = dt.Rows[c]["prn_kacnm"].ToString();
								exSheet.Cells[10 + c, 4].Value  =  dt.Rows[c]["code"].ToString();//Group
								exSheet.Cells[10 + c, 4].HorizontalAlignment = XlHAlign.xlHAlignCenter;
								exSheet.Cells[10 + c, 5].Value  =  dt.Rows[c]["header"].ToString();//itemcode
							
								exSheet.Cells[10 + c, 5].HorizontalAlignment = XlHAlign.xlHAlignCenter;
								
								if (dt.Rows[c]["month_nn"].ToString() !="")
									{
										
										exSheet.Cells[10 + c, 6].Value  =double.Parse( dt.Rows[c]["month_nn"].ToString());
										exSheet.Cells[10 + c, 6].NumberFormat = "#,##0.00";
										exSheet.Cells[10 + c, 6].HorizontalAlignment = XlHAlign.xlHAlignRight;
									}
								
								if (dt.Rows[c]["f_year"].ToString() !="")
									{
										
										exSheet.Cells[10 + c, 7].Value  =double.Parse( dt.Rows[c]["f_year"].ToString());
										exSheet.Cells[10 + c, 7].NumberFormat = "#,##0.00";
										exSheet.Cells[10 + c, 7].HorizontalAlignment = XlHAlign.xlHAlignRight;
									}
								
								if (dt.Rows[c]["lk_ty"].ToString() !="")
									{
										
										exSheet.Cells[10 + c, 8].Value  =double.Parse( dt.Rows[c]["lk_ty"].ToString());
										exSheet.Cells[10 + c, 8].NumberFormat = "#,##0.00";
										exSheet.Cells[10 + c, 8].HorizontalAlignment = XlHAlign.xlHAlignRight;
									}
												
							
								
								
								if (dt.Rows[c]["font_stype"].ToString() !="")
								{
									if (dt.Rows[c]["font_stype"].ToString() =="B")
									{
										exSheet.Cells[c + 10,1, c + 10,8].Font.Bold = true;
									}
									if (dt.Rows[c]["font_stype"].ToString() =="I")
									{
										exSheet.Cells[c + 10,1, c+ 10,8].Font.Italic = true;
									}	
											//Color colorValueFrmHex = ColorTranslator.FromHtml(dt.Rows[i]["prn_color"].ToString());
											//exSheet.Cells[i + 10,1, i + 10,9].Interior.Color = colorValueFrmHex;
								}
						

					
				}
		
		exSheet.UsedRange.Rows.Autofit();
	
		//---end------detail--quatation------
		
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }


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