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

public partial class rpt_60080040_SoCai_VND_center : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

           ESysLib.SetUser(Session["APP_DBUSER"].ToString());  
        string TemplateFile = "rpt_60080040_SoCai_VND_center.xls";
        string TempFile = "../../../system/temp/rpt_60080040_SoCai_VND_center_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string company_pk = ""+Request["company_pk"];
		string account_pk = ""+Request["account_pk"];
		string dtbFrom= ""+Request["dtbFrom"];
		string dtbTo = ""+Request["dtbTo"];
		string ccy = ""+Request["ccy"];
		string status = ""+Request["status"];
		string bookccy = ""+Request["bookccy"];	
		string rptOption = Request["rptOption"];
		
		
		string p_cmp_name = "";
		string p_cmp_add = "";
		string p_cmp_taxcode = "";
		string p_acc_code ="";
		string p_acc_name ="";
		string p_dt_from ="";
		string p_dt_to ="";
		string p_total_book_amt = "0";
        int i = 0;
		
		string para="'" + company_pk + "','" + account_pk  + "','" + dtbFrom + "','" + dtbTo + "' ,'" + ccy + "','" + status + "','" + bookccy + "','"+rptOption+"'";
		//Response.Write(para);
		//Response.End();
		DataTable dt = ESysLib.TableReadOpenCursor("AC_rpt_60080040_So_cai_VND",para);	
		
	
		
        if (dt.Rows.Count > 0)
        {
			p_acc_code = dt.Rows[0]["acc_code"].ToString();
			p_acc_name = dt.Rows[0]["acc_name"].ToString();
			//p_dt_from = dt.Rows[0]["dt_from"].ToString();
		//	p_dt_to = dt.Rows[0]["dt_to"].ToString();
			//p_total_book_amt = dt.Rows[0]["total_book_amt"].ToString();	
					
        } 
			
		string SQL = "SELECT PARTNER_NAME, ADDR1, TAX_CODE " + 
        "     FROM TCO_COMPANY " +
        "    WHERE PK = '"+company_pk+"' " ;
			DataTable dt_comp = ESysLib.TableReadOpen(SQL);
			if (dt_comp.Rows.Count > 0)
			{
				p_cmp_name = dt_comp.Rows[0]["PARTNER_NAME"].ToString();
				p_cmp_add = dt_comp.Rows[0]["ADDR1"].ToString();
				p_cmp_taxcode = dt_comp.Rows[0]["TAX_CODE"].ToString();	
			}	
			exSheet.Cells[1,1].Value = p_cmp_name; 
			exSheet.Cells[2,1].Value = p_cmp_add;			
			exSheet.Cells[3,1].Value ="Tax Code/MST :"+p_cmp_taxcode; 
			exSheet.Cells[7,3].Value = p_acc_code;		
			exSheet.Cells[7,4].Value = p_acc_name;
			exSheet.Cells[6,1].Value =dt.Rows[0]["para_date"].ToString();			
			exSheet.Cells[16,6].Value =dt.Rows[0]["todate"].ToString(); 
			exSheet.Cells[14,6].Value =dt.Rows[0]["closingbalance"].ToString();  
			exSheet.Cells[14,8].Value =dt.Rows[0]["closingbalance"].ToString(); 
			//exSheet.Cells[14,9].Value = tt_PS_CREDIT;//dt.Rows[0][""].ToString();	
			//exSheet.Cells[14,8].Value = ;//dt.Rows[0][""].ToString()	; 
			
			
			DataTable dt1 = ESysLib.TableReadOpenCursor("AC_rpt_60080040_NKthu_news", company_pk);      
			String e1 = "";
			String e2 = "";
			String e3 = "";
			String e4 = "";
			String e5 = "";
			String e6 = "";
			String v1 = "";
			String v2 = "";
			String v3 = "";
			String v4 = "";
			String v5 = "";
			String v6 = "";
			String g1 = "";
			String g2 = "";
			String g3 = "";
			String g4 = "";
			String g5 = "";
			String g6 = "";
			String n1 = "";
			String n2 = "";
			String n3 = "";
			String n4 = "";
			String n5 = "";
			String n6 = "";

		for (int k = 0; k < dt1.Rows.Count; k++)
		{

			string strTmp = dt1.Rows[k][0].ToString();
			if (strTmp == "ENG")
			{
				e1 = "" + dt1.Rows[k][1].ToString();
				e2 = "" + dt1.Rows[k][2].ToString();
				e3 = "" + dt1.Rows[k][3].ToString();
				e4 = "" + dt1.Rows[k][4].ToString();
				e5 = "" + dt1.Rows[k][5].ToString();
				e6 = "" + dt1.Rows[k][6].ToString();
			}

			if (strTmp == "VIE")
			{
				v1 = dt1.Rows[k][1].ToString();
				v2 = dt1.Rows[k][2].ToString();
				v3 = dt1.Rows[k][3].ToString();
				v4 = dt1.Rows[k][4].ToString();
				v5 = dt1.Rows[k][5].ToString();
				v6 = dt1.Rows[k][6].ToString();
			}
			if (strTmp == "SIG")
			{
				g1 = dt1.Rows[k][1].ToString();
				g2 = dt1.Rows[k][2].ToString();
				g3 = dt1.Rows[k][3].ToString();
				g4 = dt1.Rows[k][4].ToString();
				g5 = dt1.Rows[k][5].ToString();
				g6 = dt1.Rows[k][6].ToString();
			}

			if (strTmp == "NAM")
			{
				n1 = dt1.Rows[k][1].ToString();
				n2 = dt1.Rows[k][2].ToString();
				n3 = dt1.Rows[k][3].ToString();
				n4 = dt1.Rows[k][4].ToString();
				n5 = dt1.Rows[k][5].ToString();
				n6 = dt1.Rows[k][6].ToString();
			}
		}
		
		
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A13"].Rows.EntireRow.Insert();//insert row new of sheet

        }
		
         int l_cnt = dt.Rows.Count;
		 double tt_debit_amt=0,tt_credit_amt=0,tt_debit_tramt=0,tt_credit_tramt=0;
		
        for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 11; col++)
			{              
				if( col==0)
                {
					exSheet.Cells[11 + l_row, 1].Value = dt.Rows[l_row - 1]["TR_DATE_FMT"].ToString();
					
				}
				if( col==1)
                {
					exSheet.Cells[11 + l_row, 2].Value = dt.Rows[l_row - 1]["voucherno"].ToString();
					
				}
				if( col==2)
                {
					exSheet.Cells[11 + l_row,3].Value = dt.Rows[l_row - 1]["TR_DATE_FMT"].ToString();
					
				}
				if( col==3)
                {
					exSheet.Cells[11 + l_row, 4].Value = dt.Rows[l_row - 1]["REMARK2"].ToString();
					
				}
				
				if( col==4)
                {
					exSheet.Cells[11 + l_row, 5].Value = dt.Rows[l_row - 1]["ACC_CODE"].ToString();
					
				}
				if( col==5)
                {	if(dt.Rows[l_row - 1]["debit_amt"].ToString()!="")
				{
					exSheet.Cells[11 + l_row, 6].Value = double.Parse(dt.Rows[l_row - 1]["debit_amt"].ToString());
					tt_debit_amt=tt_debit_amt+double.Parse(dt.Rows[l_row - 1]["debit_amt"].ToString());
				}	
				}
			if( col==6)
                { if(dt.Rows[l_row - 1]["credit_amt"].ToString()!="")
					{
					exSheet.Cells[11 + l_row,7].Value = double.Parse(dt.Rows[l_row - 1]["credit_amt"].ToString());
					tt_credit_amt=tt_credit_amt+double.Parse(dt.Rows[l_row - 1]["credit_amt"].ToString());
					}
				}
				if( col==9)
				{
					if(dt.Rows[l_row - 1]["debit_tramt"].ToString()!=""){
					exSheet.Cells[11 + l_row, 8].Value =double.Parse(dt.Rows[l_row - 1]["debit_tramt"].ToString());
					tt_debit_tramt=tt_debit_tramt+double.Parse(dt.Rows[l_row - 1]["debit_tramt"].ToString());
					}
									
				}
				if( col==10)
               {
					if(dt.Rows[l_row - 1]["credit_tramt"].ToString()!=""){
					exSheet.Cells[11 + l_row,9].Value =double.Parse(dt.Rows[l_row - 1]["credit_tramt"].ToString());
					tt_credit_tramt=tt_credit_tramt+double.Parse(dt.Rows[l_row - 1]["credit_tramt"].ToString());
					}
							
				}
						
				if( col==11)
                {
					exSheet.Cells[11 + l_row, 10].Value = dt.Rows[l_row - 1]["pl_cd"].ToString();
					
				}
				if( col==7)
                {
					exSheet.Cells[11 + l_row,11].Value = dt.Rows[l_row - 1]["pk"].ToString();
					
				}
				if(col==0)
				{
					if (l_row < dt.Rows.Count)
					{
						if(col==0)
						{
							if(dt.Rows[l_row-1][col].ToString() == dt.Rows[l_row][col].ToString())
							{
								exSheet.Range[l_row+11, 1,l_row+12, 1].Merge();
								//l_long_term=l_long_term+1;
							}
						}
						
					}
				}
				
			}		
		}
		
			exSheet.Cells[12 + l_cnt, 6].Value=tt_debit_amt;
			exSheet.Cells[12 + l_cnt, 7].Value=tt_credit_amt;
			exSheet.Cells[12 + l_cnt, 8].Value=tt_debit_tramt;
			exSheet.Cells[12 + l_cnt, 9].Value=tt_credit_tramt;
		
			DataTable dt_detail = ESysLib.TableReadOpenCursor("AC_rpt_60080040_NKthu_news",company_pk);
			string strDate = "";
			string strDate_Dsp = "";	
			//int i=0;
			if (dt_detail.Rows.Count >0)
			{
				for (i=0;i<dt_detail.Rows.Count;i++)
				{
					if (strDate!= dt_detail.Rows[i][1].ToString())
					{
						strDate_Dsp = dt_detail.Rows[i][1].ToString();
						strDate = dt_detail.Rows[i][1].ToString();
					}
					else
					{
						strDate_Dsp = "";
					}
					
					if (i < dt_detail.Rows.Count)
					{
					}
					else
					{
					}
				}
			}
			//height=21 style='height:15.75pt'
			
		
		
		
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        exBook.SaveAs(TempFile);
      //  ESysLib.ExcelToPdf(TempFile);
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
