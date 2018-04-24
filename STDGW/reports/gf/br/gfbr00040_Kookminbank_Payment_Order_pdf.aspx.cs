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

public partial class gfbr00040_Kookminbank_Payment_Order_pdf : System.Web.UI.Page
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
    string p_D_Phone = "";
	string p_C_Phone = "";
    string p_TaxCode = "";
	string p_D_Branch = "";
    string p_Branch_Benefi = "";    
		
        string TemplateFile = "gfbr00040_Kookminbank_Payment_Order_pdf.xls";
        string TempFile = "../../../system/temp/gfbr00040_Kookminbank_Payment_Order_pdf_" + Session["User_ID"].ToString() + ".xls";
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
        p_C_Add = dt.Rows[0]["address_credit"].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][13].ToString();
        p_So = dt.Rows[0][11].ToString();
        p_D_Phone = dt.Rows[0][23].ToString();
        p_TaxCode = dt.Rows[0][28].ToString();
		p_D_Branch = dt.Rows[0][21].ToString();
		p_C_Phone = dt.Rows[0]["C_PHONE_NO"].ToString();
		p_Branch_Benefi = dt.Rows[0]["branch"].ToString();
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
		 // Response.Write(p_So);
         // Response.End();
		exSheet.Cells["X5"].Value = p_Date;
		exSheet.Cells["G7"].Value = p_D_Acc_Nm;				
		exSheet.Cells["I8"].Value = p_D_Phone;
		exSheet.Cells["H11"].Value = p_Amt+" "+p_Ccy;
		exSheet.Cells["G12"].Value = Inword;
		exSheet.Cells["G15"].Value = p_C_Acc_Nm;
		exSheet.Cells["I16"].Value = p_C_Phone;
		exSheet.Cells["H17"].Value = p_C_Add;
		exSheet.Cells["J20"].Value = p_C_Bank;
		exSheet.Cells["K21"].Value = p_C_Acc_No;
		exSheet.Cells["H22"].Value = p_Branch_Benefi;
		exSheet.Cells["J27"].Value = p_Remark;
		
		p_D_Acc_No = p_D_Acc_No.Replace("-","");
		p_D_Acc_No = p_D_Acc_No.Replace(".","");
		if(p_D_Acc_No.Length >=1)
		{
			exSheet.Cells["E34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 1];
		}
		if(p_D_Acc_No.Length >=2)
		{
			exSheet.Cells["F34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 2];
		}
		if(p_D_Acc_No.Length >=3)
		{
			exSheet.Cells["G34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 3];
		}
		if(p_D_Acc_No.Length >=4)
		{
			exSheet.Cells["H34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 4];
		}
		if(p_D_Acc_No.Length >=5)
		{
			exSheet.Cells["J34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 5];
		}
		if(p_D_Acc_No.Length >=6)
		{
			exSheet.Cells["K34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 6];
		}
		if(p_D_Acc_No.Length >=7)
		{
			exSheet.Cells["M34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 7];
		}
		if(p_D_Acc_No.Length >=8)
		{
			exSheet.Cells["O34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 8];
		}
		if(p_D_Acc_No.Length >=9)
		{
			exSheet.Cells["P34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 9];
		}
		if(p_D_Acc_No.Length >=10)
		{
			exSheet.Cells["Q34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 10];
		}
		if(p_D_Acc_No.Length >=11)
		{
			exSheet.Cells["R34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 11];
		}
		if(p_D_Acc_No.Length >=12)
		{
			exSheet.Cells["S34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 12];
		}
		if(p_D_Acc_No.Length >=13)
		{
			exSheet.Cells["T34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 13];
		}
		if(p_D_Acc_No.Length >=14)
		{
			exSheet.Cells["U34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 14];
		}
		if(p_D_Acc_No.Length >=15)
		{
			exSheet.Cells["V34"].Value = p_D_Acc_No[p_D_Acc_No.Length - 15];
		}
		
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        range = exSheet.Range["A1"];
        // hide row A5 
       // range.Rows.Hidden = true;
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