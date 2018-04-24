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
public partial class gfbr00040_HSBC_bank_UNC_EXCEL : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string TemplateFile = "gfbr00040_HSBC_bank_UNC_EXCEL.xls";
        string TempFile = "../../../system/temp/gfbr00040_HSBC_bank_UNC_EXCEL_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
        
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

			string p_Seq = Request["p_Seq"];
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
			string p_barcode ="";
		
		DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
		if (dt.Rows.Count == 0)
		{
			Response.Write("There is not data !!");
			Response.End();
		}
		else
		{
			p_Date = dt.Rows[0][15].ToString();
			p_Month = dt.Rows[0][16].ToString();
			p_Year = dt.Rows[0][17].ToString();
			p_D_Acc_No = dt.Rows[0][24].ToString();
			//p_D_Acc_No = dt.Rows[0][8].ToString();
			p_D_Acc_Nm = dt.Rows[0][12].ToString();
			p_D_Add = dt.Rows[0][25].ToString();
			p_D_Bank = dt.Rows[0][9].ToString();
			p_C_Acc_No = dt.Rows[0][0].ToString();
			p_C_Acc_Nm = dt.Rows[0][19].ToString();
			//p_C_Add = dt.Rows[0][26].ToString();
			p_C_Bank = dt.Rows[0][1].ToString();
			p_Remark = dt.Rows[0][14].ToString();
			p_So = dt.Rows[0][11].ToString();
			p_barcode = dt.Rows[0]["bar_code"].ToString();
		}		
			string p_Amt = "";
			string p_Ccy = "";
			string Inword = "";
			string _str_Amt = "";
			string p_Amt1 = "";
			DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
			if (dt_Amount.Rows.Count > 0)
		{
			p_Amt = dt_Amount.Rows[0][11].ToString();
			p_Ccy = dt_Amount.Rows[0][3].ToString();
			p_Amt1 = dt_Amount.Rows[0][15].ToString();
			Inword = CommondLib.Num2VNText(dt_Amount.Rows[0][9].ToString(), p_Ccy);			
			string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
			DataTable dt_t = ESysLib.TableReadOpen(SQL3);
        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();        }
        }		
			exSheet.Cells[6, 17].Value = p_Date+"/"+p_Month+"/"+p_Year;
			exSheet.Cells[81, 3].Value = p_D_Acc_Nm;
			exSheet.Cells[11, 5].Value = p_D_Acc_No;
			exSheet.Cells[32, 4].Value = p_D_Bank;
			exSheet.Cells[34, 4].Value = p_D_Add;	
			
			exSheet.Cells[28, 13].Value = p_C_Acc_Nm;
			exSheet.Cells[27, 14].Value = p_C_Acc_No;
			exSheet.Cells[37, 13].Value = p_C_Bank;
			exSheet.Cells[32, 13].Value = p_D_Add;		
			
			exSheet.Cells[19, 4].Value = Inword;
			exSheet.Cells[17, 12].Value = p_Amt1;
			exSheet.Cells[17, 4].Value = p_Ccy;
			exSheet.Cells[11, 3].Value = p_Remark;		
			
			exSheet.Cells[22, 6].Value = p_Date+"/"+p_Month+"/"+p_Year;
			exSheet.Cells["F2"].Value = p_barcode;
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        exBook.SaveAs(TempFile);
		ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
        System.IO.FileInfo file = new System.IO.FileInfo(TempFile);
        Response.Clear();
        Response.Charset = "UTF-8";
        Response.ContentEncoding = System.Text.Encoding.UTF8;
        Response.AddHeader("Content-Disposition", "attachment; filename=" + Server.UrlEncode(file.Name));
        Response.AddHeader("Content-Length", file.Length.ToString());
		Response.ContentType = "application/ms-exSheet";
        Response.WriteFile(TempFile);
        Response.End();

    }
}
