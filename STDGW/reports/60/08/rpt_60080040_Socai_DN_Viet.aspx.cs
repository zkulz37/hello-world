﻿using System;
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

public partial class rpt_60080040_Socai_DN_Viet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        string TemplateFile = "rpt_60080040_Socai_DN_Viet.xls";
        string TempFile = "../../../system/temp/rpt_60080040_Socai_DN_Viet_" + Session["User_ID"].ToString() + ".xls";
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
		string p_ccy = ""+Request["ccy"];
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
		string para="'" + p_company_pk + "','" + p_account_pk  + "','" + p_dtbFrom + "','" + p_dtbTo + "' ,'" + p_ccy + "','" + p_status + "','" + p_bookccy + "'";
		string para2="'" + p_company_pk + "'";
		DataTable dt = ESysLib.TableReadOpenCursor("AC_rpt_60080040_socai_viet",para);
		
        if (dt.Rows.Count > 0)
        {
			
			p_cmp_name = dt.Rows[0]["cmp_name"].ToString();
			p_cmp_add = dt.Rows[0]["cmp_add"].ToString();
			p_cmp_taxcode = dt.Rows[0]["cmp_taxcode"].ToString();	 
			p_acc_code = dt.Rows[0]["acc_code"].ToString();
			p_acc_name = dt.Rows[0]["acc_name"].ToString();
			p_dt_from = dt.Rows[0]["dt_from"].ToString();
			p_dt_to = dt.Rows[0]["dt_to"].ToString();
			p_total_book_amt = dt.Rows[0]["total_book_amt"].ToString();	
					
        } 
			
			
			exSheet.Cells[1,1].Value = p_cmp_name; 
			exSheet.Cells[2,1].Value = p_cmp_add;			
			exSheet.Cells[3,1].Value ="Tax Code/MST :"+p_cmp_taxcode; 
			exSheet.Cells[6,2].Value = p_acc_code;		
			exSheet.Cells[6,4].Value = p_acc_name;
			exSheet.Cells[5,1].Value = "Từ Ngày  : "+p_dt_from+" đến "+p_dt_to;
			exSheet.Cells[16,6].Value =dt.Rows[0]["todate"].ToString(); 
			exSheet.Cells[11,8].Value = p_total_book_amt;
		//////////////////////////////////	
		

		DataTable dt1 = ESysLib.TableReadOpenCursor("AC_rpt_60080040_NKthu_news",para2); 
		//Response.Write("err");
		//Response.End();	
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
		exSheet.Cells[17,2].Value = v1; 
		exSheet.Cells[17,4].Value = v2;
		exSheet.Cells[17,6].Value = v3;
		
		//exSheet.Cells[22,1].Value = n1; 
		//exSheet.Cells[22,4].Value = n2;
		//exSheet.Cells[22,6].Value = n3;
		//exSheet.Cells[17,1].Value = g1; 
		//exSheet.Cells[17,4].Value = g2;
		//exSheet.Cells[17,6].Value = g3;	
			
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A11"].Rows.EntireRow.Insert();//insert row new of sheet

        }
        
        for (int l_row = 1; l_row <= dt.Rows.Count; l_row++)
        {
            for (int col = 0; col <= 10; col++)
			{              
				if( col==0)
                {
					exSheet.Cells[9 + l_row, col + 1].Value = dt.Rows[l_row - 1]["tr_dateS"].ToString();
					
				}
				if( col==1)
                {
					exSheet.Cells[9 + l_row, col + 1].Value = dt.Rows[l_row - 1]["voucherno"].ToString();
					
				}
				if( col==2)
                {
					exSheet.Cells[9 + l_row, col + 1].Value = dt.Rows[l_row - 1]["tr_date"].ToString();
					
				}
				
				if( col==3)
                {
					exSheet.Cells[9 + l_row, col + 1].Value = dt.Rows[l_row - 1]["remark"].ToString();
					
				}
				if( col==4)
                {
					exSheet.Cells[9 + l_row, col + 1].Value = dt.Rows[l_row - 1]["remark2"].ToString();
					
				}
				if( col==5)
                {
					exSheet.Cells[9 + l_row, col + 1].Value = dt.Rows[l_row - 1]["dr_code"].ToString();
					
				}
				if( col==6)
				{
					exSheet.Cells[9 + l_row, col + 1].Value = dt.Rows[l_row - 1]["cr_code"].ToString();				
				}
				if( col==7)
                {
					exSheet.Cells[9 + l_row, col + 1].Value = dt.Rows[l_row - 1]["book_amt"].ToString();
					
				}
				if( col==8)
                {
					exSheet.Cells[9 + l_row, col + 1].Value = dt.Rows[l_row - 1]["pk"].ToString();
					
				}
				
			}		
		}
			DataTable dt_detail = ESysLib.TableReadOpenCursor("AC_rpt_60080040_NKthu_news",para2);
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
