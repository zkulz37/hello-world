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

public partial class rpt_gfbr00040_Standard_chartered_PaymentOrder: System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser(Session["APP_DBUSER"].ToString());

	string l_Seq = Request["p_Seq"];
    string p_Date = "";
    string p_Month = "";
    string p_Year = "";
    string p_D_Acc_No = "";
    string p_D_Acc_Nm = "";
    string p_D_Add = "";
    string p_D_Bank = "";
    string p_C_Acc_No = "";
    string p_C_Acc_Nm = "";
    string p_C_Add = "";
    string p_C_Bank = "";
    string p_Remark = "";
    string p_So = "";
        
		
        string TemplateFile = "rpt_gfbr00040_Standard_chartered_PaymentOrder.xls";
        string TempFile = "../../../system/temp/rpt_gfbr00040_Standard_chartered_PaymentOrder_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
        string para = "";
		//string p_Amt = "";
		string p_Amt = "";
        string p_Ccy = "";
        string Inword = "";
        DataTable dt, dtSum;
        para = "'" + l_Seq +"'";
		  dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", para); 
		
        if (dt.Rows.Count == 0)
        {
            Response.Write("There is not data !!");
            Response.End();
        }
        else
        {    
			p_Date = dt.Rows[0][10].ToString();
			p_Month = dt.Rows[0][16].ToString();
			p_Year = dt.Rows[0][17].ToString();
			p_D_Acc_No = dt.Rows[0][24].ToString();
			//p_D_Acc_No = dt.Rows[0][8].ToString();
			p_D_Acc_Nm = dt.Rows[0][12].ToString();
			p_D_Add = dt.Rows[0][25].ToString();
			p_D_Bank = dt.Rows[0][9].ToString();
			p_C_Acc_No = dt.Rows[0][0].ToString();
			p_C_Acc_Nm = dt.Rows[0][19].ToString();
			p_C_Add = dt.Rows[0][26].ToString();
			p_C_Bank = dt.Rows[0][1].ToString();
			p_Remark = dt.Rows[0][14].ToString();
			p_So = dt.Rows[0][11].ToString();
        }
		 DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", para);
		if (dt_Amount.Rows.Count > 0)
        {
            p_Amt = dt_Amount.Rows[0][13].ToString();
            p_Ccy = dt_Amount.Rows[0][3].ToString();
                Inword = CommondLib.Num2VNText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
            
            string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
            DataTable dt_t = ESysLib.TableReadOpen(SQL3);

            if (dt_t.Rows.Count > 0)
            {
                Inword = dt_t.Rows[0][0].ToString();
            }
        }
      if (dt.Rows.Count > 0)   
       {	exSheet.Cells[8,6].Value = p_C_Add;
			exSheet.Cells[9,28].Value =p_Date;	
			exSheet.Cells[41,12].Value =p_Date;	
			exSheet.Cells[12,6].Value = p_D_Acc_Nm;	//p_D_Acc_Nm
			exSheet.Cells[15,6].Value =p_D_Add;
			exSheet.Cells[29,6].Value = p_Ccy;
			exSheet.Cells[29,11].Value = p_C_Acc_No ;
			exSheet.Cells[34,6].Value = p_Ccy;
			exSheet.Cells[34,11].Value = p_C_Acc_No ;
			exSheet.Cells[29,24].Value = p_Ccy;
			exSheet.Cells[29,29].Value =p_Amt;
			exSheet.Cells[31,24].Value =Inword;
			exSheet.Cells[65,26].Value = p_D_Acc_No; 
			exSheet.Cells[52,12].Value = p_C_Bank;	
			//exSheet.Cells[62,12].Value =p_D_Add;
			exSheet.Cells[70,9].Value =p_Remark;
		}     
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        range = exSheet.Range["A1"];
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