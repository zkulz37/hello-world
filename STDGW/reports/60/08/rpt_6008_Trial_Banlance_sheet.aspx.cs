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

public partial class rpt_6008_Trial_Banlance_sheet : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser("GENUWIN");
		string l_com_pk = Request["p_compk"];
		string l_accd = Request["p_accd"];  
	    string l_level = Request["p_level"];
		string l_formtype = Request["p_formtype"];
		
		

							
        string TemplateFile = "rpt_6008_Trial_Banlance_sheet.xls";
        string TempFile = "../../../system/temp/rpt_6008_Trial_Banlance_sheet_" + Session["User_ID"].ToString() + ".xls";
     
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
		para = "'" + l_com_pk +"','" +l_accd+ "','"+l_level+ "','"+l_formtype+"'";
		//para1 = "'" +l_com_pk +"'";
		dt = ESysLib.TableReadOpenCursor("GENUWIN.ac_rpt_6008_balance_sheet", para);
		dt_mst = ESysLib.TableReadOpenCursor("GENUWIN.ac_rpt_6008_bl_mst", para); 
		 
        //-----header--- 
		
        //---end--header---
        //--set-----DataBind--in---Master---
		
		if (dt_mst.Rows.Count == 0)
        {
            exSheet.Cells[3, 3].Value = "There is not data!";

        }
        if (dt_mst.Rows.Count > 0)   
        {
			exSheet.Cells[1, 1].Value  = dt_mst.Rows[0]["PARTNER_NAME"].ToString();
			exSheet.Cells[2, 1].Value  = dt_mst.Rows[0]["addr1"].ToString();
			exSheet.Cells[2, 7].Value  = dt_mst.Rows[0]["p_formtype"].ToString();
			exSheet.Cells[2, 8].Value  = "Acount Code : "+dt_mst.Rows[0]["p_accd"].ToString();
			exSheet.Cells[2, 10].Value  =dt_mst.Rows[0]["p_level"].ToString();
			
        }
		
		//------------------
		
        for (int l_addrow =0; l_addrow < dt.Rows.Count-1 ; l_addrow++)
        {
            exSheet.Range[5+l_addrow+1,1].Rows.EntireRow.Insert();//insert row new of sheet
        }
		//-------------------------------------------------
		int l_dt_cnt = dt.Rows.Count;
		int j=0;
		double tt_tr_famt = 0,tt_tr_amt = 0, tt_pay_famt = 0,
               tt_pay_amt = 0,tt_balance_famt = 0,tt_balance_amt = 0;
		for (int i = 0; i < dt.Rows.Count;i++)
		{
		
            exSheet.Cells[i+5, 1,i+5, 2].Merge();     
            exSheet.Cells[5 + i, 1].Value =dt.Rows[i]["grp_accd"].ToString();
			exSheet.Cells[5 + i, 3].Value  =  dt.Rows[i]["prn_seq"].ToString();
			exSheet.Cells[5 + i, 4].Value  =  dt.Rows[i]["code"].ToString();
			exSheet.Cells[5 + i, 5].Value  =  dt.Rows[i]["header"].ToString();
			exSheet.Cells[5 + i, 6].Value  = dt.Rows[i]["prn_accode"].ToString();
			exSheet.Cells[5 + i, 7].Value  = dt.Rows[i]["prn_acnm"].ToString();
			
			exSheet.Cells[5 + i, 8].Value  = dt.Rows[i]["prn_lacnm"].ToString();
			exSheet.Cells[5 + i, 9].Value  = dt.Rows[i]["prn_kacnm"].ToString();
			exSheet.Cells[5 + i, 10].Value  = dt.Rows[i]["prn_chk"].ToString();
			//exSheet.Cells[5 + i, 11].Value  = dt.Rows[i]["prn_chk"].ToString();
			exSheet.Cells[5 + i, 12].Value  = dt.Rows[i]["font_stype"].ToString();
			exSheet.Cells[5 + i, 13].Value  = dt.Rows[i]["rem_chk"].ToString();
			exSheet.Cells[5 + i, 14].Value  = dt.Rows[i]["prn_color"].ToString();
			exSheet.Cells[5 + i, 15].Value  = dt.Rows[i]["prn_level"].ToString();
			exSheet.Cells[5 + i, 16].Value  = dt.Rows[i]["formular"].ToString();
			exSheet.Cells[5 + i, 17].Value  = dt.Rows[i]["formular2"].ToString();
			exSheet.Cells[5 + i, 18].Value  = dt.Rows[i]["formular_acc"].ToString();
			exSheet.Cells[5 + i, 19].Value  = dt.Rows[i]["formular_acc2"].ToString();
			
			
		}
		
				
		

		
        //----------------------
        //end-set-----DataBind--in---Master---

        
        //set date title of year
        //exSheet.Cells[2, 1].Value = "Income Statement Year" + " " + l_year;

        //set data to detail.
        // loop detail not percent
     

        // end loop detail percent
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