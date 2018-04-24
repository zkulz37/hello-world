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

public partial class rpt_60080060_TSocai_Viet : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        string TemplateFile = "rpt_60080060_TSocai_Viet.xls";
        string TempFile = "../../../system/temp/rpt_60080060_TSocai_Viet_" + Session["User_ID"].ToString() + ".xls";
       TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
       
		string p_company_pk = ""+Request["p_company_pk"];
		string p_account_pk = ""+Request["p_account_pk"];
		string p_dtbFrom= ""+Request["p_dtbFrom"];
		string p_dtbTo = ""+Request["p_dtbTo"];
		//string p_ccy = ""+Request["p_ccy"];
		string p_status = ""+Request["p_status"];
		string p_bookccy = ""+Request["p_bookccy"];	
		
		string para="'" + p_company_pk + "','" + p_account_pk  + "','" + p_dtbFrom + "','" + p_dtbTo + "','" + p_status + "','" + p_bookccy + "'";
		
		// Response.Write(para);
		// Response.End();	
		DataTable dt = ESysLib.TableReadOpenCursor("ac_rpt_60080060_tsocai",para);
		
    		if (dt.Rows.Count > 0)
       {
			
			
			exSheet.Cells[1,1].Value = dt.Rows[0]["cmp_name"].ToString();
			exSheet.Cells[2,1].Value = dt.Rows[0]["cmp_add"].ToString();		
			exSheet.Cells[3,1].Value ="Tax Code/MST :"+ dt.Rows[0]["cmp_taxcode"].ToString();
			exSheet.Cells[6,2].Value = dt.Rows[0]["acc_code"].ToString(); 
		exSheet.Cells[6,4].Value =dt.Rows[0]["acc_name"].ToString(); 
			
			exSheet.Cells[5,1].Value = dt.Rows[0]["paradate"].ToString(); 
			exSheet.Cells[15,4].Value ="ngày : " +dt.Rows[0]["todate"].ToString(); 
		}		
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A12"].Rows.EntireRow.Insert();//insert row new of sheet

        }
		   double tt_book_amt=0;
		 int l_cnt = dt.Rows.Count;
		
        for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 10; col++)
			{              
				if( col==1)
                {
					exSheet.Cells[10 + l_row, 1].Value = dt.Rows[l_row - 1]["ac_nm"].ToString();
					
				}
				if( col==2)
                {
					exSheet.Cells[10 + l_row,2].Value = dt.Rows[l_row - 1]["ac_knm"].ToString();
						}
				if( col==3)
                {
					exSheet.Cells[10 + l_row,3].Value = dt.Rows[l_row - 1]["ac_lnm"].ToString();
				}
				
				if( col==7)
                {
					exSheet.Cells[10 + l_row, 4].Value = dt.Rows[l_row - 1]["ac_cd"].ToString();
					}
				if( col==3)
                {
					exSheet.Cells[10 + l_row,5].Value = dt.Rows[l_row - 1]["debit_amt"].ToString();
						}
				
				if( col==7)
                {
					exSheet.Cells[10 + l_row, 6].Value = dt.Rows[l_row - 1]["credit_amt"].ToString();
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
