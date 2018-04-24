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

public partial class rpt_60081336_kor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string l_tco_company_pk = Request["p_tco_company_pk"];
		string l_from_month = Request["p_from_month"];  
	    string l_to_month = Request["p_to_month"];
		string l_status = Request["p_status"];
		string l_scale = Request["p_scale"];
		string l_date_from_text = Request["p_from_text"];  
		string l_date_to_text = Request["p_to_text"];
		//string l_text_ccy = Request["p_ccy"];
		string l_text_company 	 = Request["p_text_company"]; 	
		
		
		
        string TemplateFile = "rpt_60081336_kor.xls";
        string TempFile = "../../../system/temp/rpt_60081336_kor_" + Session["User_ID"].ToString() + ".xls";
		
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
		para= "'" + l_tco_company_pk +"','"+l_from_month+"','"+l_to_month+"','"+l_status+"','"+l_scale+"'"; 
		para1 = "'" + l_tco_company_pk +"'";
		
		dt = ESysLib.TableReadOpenCursor("ac_sel_60081336_BS_consol", para);
		dt_mst = ESysLib.TableReadOpenCursor("ac_sel_company_consolidate", para1);
		
		
		exSheet.Cells[6, 1].Value =" From Date :  " +  l_date_from_text + "  ~  " + l_date_to_text;
		
		
		if (dt_mst.Rows.Count == 0)
        {
            exSheet.Cells[3, 3].Value = "There is not data!";

        }
        if (dt_mst.Rows.Count > 0)   
        {
			exSheet.Cells[1, 1].Value   =  dt_mst.Rows[0]["code_nm"].ToString();
			
		}
		
		
		int tmp;
	    for (int l_addrow = 1; l_addrow < dt.Rows.Count ; l_addrow++)
		{
			tmp = int.Parse(dt.Rows[l_addrow]["code"].ToString());
		   
			if(tmp >= 500)
			{
				exSheet.Range["A23"].Rows.EntireRow.Insert();//insert row new of sheet
			}
		} 
		
		int tmp1;
	    for (int l_addrow = 1; l_addrow < dt.Rows.Count ; l_addrow++)
		{
			tmp1 = int.Parse(dt.Rows[l_addrow]["code"].ToString());
		   
			if(tmp1 >= 300&& tmp1<500)
			{
				exSheet.Range["A17"].Rows.EntireRow.Insert();//insert row new of sheet
			}
		} 
		
		int tmp2;
	    for (int l_addrow = 1; l_addrow < dt.Rows.Count ; l_addrow++)
		{
			tmp2 = int.Parse(dt.Rows[l_addrow]["code"].ToString());
		   
			if(tmp2 >= 100&& tmp2<300)
			{
				exSheet.Range["A11"].Rows.EntireRow.Insert();//insert row new of sheet
			}
		} 
		int l_dt_cnt1 = dt.Rows.Count;
		for (int i = 0; i < dt.Rows.Count;i++)
				{
					
					int rs = int.Parse(dt.Rows[i]["code"].ToString());
					   if(rs >=500)
						{
								exSheet.Cells[21 + i, 1].Value = dt.Rows[i]["prn_kacnm"].ToString();
								exSheet.Cells[21 + i, 2].Value  =  dt.Rows[i]["code"].ToString();//Group
								exSheet.Cells[21 + i, 2].HorizontalAlignment = XlHAlign.xlHAlignLeft;
								exSheet.Cells[21 + i, 3].Value  =  dt.Rows[i]["header"].ToString();//itemcode
							
								exSheet.Cells[10 + i, 3].HorizontalAlignment = XlHAlign.xlHAlignLeft;
								
								
								if (dt.Rows[i]["closing"].ToString() !="")
									{
										
										exSheet.Cells[21 + i, 4].Value  =double.Parse( dt.Rows[i]["closing"].ToString());
										exSheet.Cells[21 + i, 4].NumberFormat = "#,##0.00";
										exSheet.Cells[21 + i, 4].HorizontalAlignment = XlHAlign.xlHAlignRight;
									}
								if (dt.Rows[i]["openning"].ToString() !="")
									{
										
										exSheet.Cells[21 + i, 5].Value  =double.Parse( dt.Rows[i]["openning"].ToString());
										exSheet.Cells[21 + i, 5].NumberFormat = "#,##0.00";
										exSheet.Cells[21 + i, 5].HorizontalAlignment = XlHAlign.xlHAlignRight;
									}
								if (dt.Rows[i]["font_stype"].ToString() !="")
								{
									if (dt.Rows[i]["font_stype"].ToString() =="B")
									{
										exSheet.Cells[i + 21,1, i + 21,9].Font.Bold = true;
									}
									if (dt.Rows[i]["font_stype"].ToString() =="I")
									{
										exSheet.Cells[i + 21,1, i + 21,9].Font.Italic = true;
									}	
											//Color colorValueFrmHex = ColorTranslator.FromHtml(dt.Rows[i]["prn_color"].ToString());
											//exSheet.Cells[i + 10,1, i + 10,9].Interior.Color = colorValueFrmHex;
								}
						

					}
				}	
				for (int j = 0; j < dt.Rows.Count;j++)
				{
					
					int rs1 = int.Parse(dt.Rows[j]["code"].ToString());
					   if(rs1 >=300&& rs1<500)
						{
								exSheet.Cells[15 + j, 1].Value = dt.Rows[j]["prn_kacnm"].ToString();
								exSheet.Cells[15 + j, 2].Value  =  dt.Rows[j]["code"].ToString();//Group
								exSheet.Cells[15 + j, 2].HorizontalAlignment = XlHAlign.xlHAlignLeft;
								exSheet.Cells[15 + j, 3].Value  =  dt.Rows[j]["header"].ToString();//itemcode
							
								exSheet.Cells[15 + j, 3].HorizontalAlignment = XlHAlign.xlHAlignLeft;
								
								
								if (dt.Rows[j]["closing"].ToString() !="")
									{
										
										exSheet.Cells[15 + j, 4].Value  =double.Parse( dt.Rows[j]["closing"].ToString());
										exSheet.Cells[15 + j, 4].NumberFormat = "#,##0.00";
										exSheet.Cells[17 + j, 4].HorizontalAlignment = XlHAlign.xlHAlignRight;
									}
								if (dt.Rows[j]["openning"].ToString() !="")
									{
										
										exSheet.Cells[15 + j, 5].Value  =double.Parse( dt.Rows[j]["openning"].ToString());
										exSheet.Cells[15 + j, 5].NumberFormat = "#,##0.00";
										exSheet.Cells[15 + j, 5].HorizontalAlignment = XlHAlign.xlHAlignRight;
									}
									
									
									
								
								
								
								if (dt.Rows[j]["font_stype"].ToString() !="")
								{
									if (dt.Rows[j]["font_stype"].ToString() =="B")
									{
										exSheet.Cells[j + 15,1, j + 15,9].Font.Bold = true;
									}
									if (dt.Rows[j]["font_stype"].ToString() =="I")
									{
										exSheet.Cells[j + 15,1, j + 15,9].Font.Italic = true;
									}	
											//Color colorValueFrmHex = ColorTranslator.FromHtml(dt.Rows[i]["prn_color"].ToString());
											//exSheet.Cells[i + 10,1, i + 10,9].Interior.Color = colorValueFrmHex;
								}
						

					}
				}

				

			     for (int c = 0; c < dt.Rows.Count;c++)
				{
					
					int rs2 = int.Parse(dt.Rows[c]["code"].ToString());
					   if(rs2 >=100&& rs2 <300)
						{
								exSheet.Cells[10 + c, 1].Value = dt.Rows[c]["prn_kacnm"].ToString();
								exSheet.Cells[10 + c, 2].Value  =  dt.Rows[c]["code"].ToString();//Group
								exSheet.Cells[10 + c, 2].HorizontalAlignment = XlHAlign.xlHAlignLeft;
								exSheet.Cells[10 + c, 3].Value  =  dt.Rows[c]["header"].ToString();//itemcode
							
								exSheet.Cells[10 + c, 3].HorizontalAlignment = XlHAlign.xlHAlignLeft;
								
								
								if (dt.Rows[c]["closing"].ToString() !="")
									{
										
										exSheet.Cells[10 + c, 4].Value  =double.Parse( dt.Rows[c]["closing"].ToString());
										exSheet.Cells[10 + c, 4].NumberFormat = "#,##0.00";
										exSheet.Cells[10 + c, 4].HorizontalAlignment = XlHAlign.xlHAlignRight;
									}
								if (dt.Rows[c]["openning"].ToString() !="")
									{
										
										exSheet.Cells[10 + c, 5].Value  =double.Parse( dt.Rows[c]["openning"].ToString());
										exSheet.Cells[10 + c, 5].NumberFormat = "#,##0.00";
										exSheet.Cells[10 + c, 5].HorizontalAlignment = XlHAlign.xlHAlignRight;
									}
									
									
									
								
								
								
								if (dt.Rows[c]["font_stype"].ToString() !="")
								{
									if (dt.Rows[c]["font_stype"].ToString() =="B")
									{
										exSheet.Cells[c + 10,1, c + 10,9].Font.Bold = true;
									}
									if (dt.Rows[c]["font_stype"].ToString() =="I")
									{
										exSheet.Cells[c + 10,1, c+ 10,9].Font.Italic = true;
									}	
											//Color colorValueFrmHex = ColorTranslator.FromHtml(dt.Rows[i]["prn_color"].ToString());
											//exSheet.Cells[i + 10,1, i + 10,9].Interior.Color = colorValueFrmHex;
								}
						

					}
				}
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