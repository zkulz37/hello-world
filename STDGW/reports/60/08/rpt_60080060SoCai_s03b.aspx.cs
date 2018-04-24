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

public partial class rpt_60080060SoCai_s03b : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser(Session["APP_DBUSER"].ToString());      
        string TemplateFile = "rpt_60080060SoCai_s03b.xls";
        string TempFile = "../../../system/temp/rpt_60080060SoCai_s03b_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string p_company_pk = ""+Request["company_pk"];	
		string p_account_pk = ""+Request["account_pk"];	
		string p_dtbFrom= ""+Request["dtbFrom"];
		string p_dtbTo = ""+Request["dtbTo"];
		string p_voucher = Request["Voucher"];
		string p_seq = Request["Seq"];
		string p_status = ""+Request["status"];
		string p_bookccy = ""+Request["bookccy"];	
		
		
		string p_cmp_name = "";
		string p_cmp_add = "";
		string p_cmp_taxcode = "";
		string p_acc_code ="";
		string p_acc_name ="";
		string p_dt_from ="";
		string p_dt_to ="";
		string p_total_book_amt = "0";
        int i = 0;
		string para="'" + p_company_pk + "','" + p_account_pk + "','" + p_dtbFrom + "','" + p_dtbTo + "','" + p_status+ "','" +p_bookccy + "'";
		//Response.Write(para);
		//Response.End();
		DataTable dt = ESysLib.TableReadOpenCursor("ac_rpt_60080060_socai_s03b",para);
		  
        if (dt.Rows.Count > 0)
        {
			
			p_cmp_name = dt.Rows[0]["cmp_name"].ToString();
			p_cmp_add = dt.Rows[0]["cmp_add"].ToString();
			p_cmp_taxcode = dt.Rows[0]["cmp_taxcode"].ToString();	
			
        } 
			
			
		exSheet.Cells[1,1].Value = p_cmp_name; 
		exSheet.Cells[2,1].Value = p_cmp_add;			
		exSheet.Cells[3,1].Value ="Tax Code/MST :"+p_cmp_taxcode; 
		exSheet.Cells[6,3].Value = dt.Rows[0]["acc_code"].ToString(); 
		exSheet.Cells[6,4].Value =dt.Rows[0]["acc_name"].ToString(); 
			
		exSheet.Cells[5,1].Value = dt.Rows[0]["paradate"].ToString(); 
		exSheet.Cells[17,6].Value ="ngày : " +dt.Rows[0]["todate"].ToString(); 
		
		//////////////////////////////////	
		
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A12"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        double tt_book_amt=0,tt_debit_amt=0 ,tt_cuoiky=tt_book_amt-tt_debit_amt;
		 int l_cnt = dt.Rows.Count;
		
        for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 10; col++)
			{              
				if( col==1)
                {
					exSheet.Cells[10 + l_row, 1].Value = dt.Rows[l_row - 1]["tr_date_fmt"].ToString();
				}
				if( col==2)
                {
					exSheet.Cells[10 + l_row,2].Value = dt.Rows[l_row - 1]["voucherno"].ToString();
				}
				if( col==3)
                {
					exSheet.Cells[10 + l_row,3].Value = dt.Rows[l_row - 1]["tr_date_fmt"].ToString();
				}
				
				if( col==7)
                {
					exSheet.Cells[10 + l_row, 4].Value = dt.Rows[l_row - 1]["remark2"].ToString();
				}
				if( col==8)
                {
					exSheet.Cells[10 + l_row, 5].Value = dt.Rows[l_row - 1]["remark"].ToString();
				}
				if( col==4)
                {
					exSheet.Cells[10 + l_row, 6].Value = dt.Rows[l_row - 1]["acc_code"].ToString();
				}
				if( col==5)
				{	if( dt.Rows[l_row - 1]["debit_amt"].ToString()!="")
				{
					exSheet.Cells[10 + l_row, 7].Value = double.Parse(dt.Rows[l_row - 1]["debit_amt"].ToString());	
						tt_debit_amt=tt_debit_amt+double.Parse(dt.Rows[l_row - 1]["debit_amt"].ToString());	
				}
				}
				if( col==6)
                {	if(dt.Rows[l_row - 1]["credit_amt"].ToString()!="")
					{
						exSheet.Cells[10 + l_row,8].Value = double.Parse(dt.Rows[l_row - 1]["credit_amt"].ToString());
						tt_book_amt=tt_book_amt+double.Parse(dt.Rows[l_row - 1]["credit_amt"].ToString());
					}
				}
				if( col==0)
                {
					exSheet.Cells[10 + l_row, 9].Value = dt.Rows[l_row - 1]["pk"].ToString();
				}
				if(col==1)
				{
					if (l_row < dt.Rows.Count)
					{
						if(col==1)
						{
							if(dt.Rows[l_row-1][col].ToString() == dt.Rows[l_row][col].ToString())
							{
								exSheet.Range[l_row+9, 1,l_row+10, 1].Merge();
								//l_long_term=l_long_term+1;
							}
						}
						
					}
				}
				
			}	exSheet.Cells[11 + l_cnt,8].Value=tt_book_amt;
			exSheet.Cells[11 + l_cnt,7].Value=tt_debit_amt;
			exSheet.Cells[12 + l_cnt,7].Value=tt_cuoiky;
				
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
