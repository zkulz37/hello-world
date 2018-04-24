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

public partial class rpt_60080200_expense_monthly : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		
		string p_compk = ""+Request["p_compk"];
		string p_from = ""+Request["p_from"];
		string p_to= ""+Request["p_to"];
		string p_acc_pk = ""+Request["p_acc_pk"];
		string p_plcenter = ""+Request["p_plcenter"];
		string p_plunit = ""+Request["p_plunit"];
		string p_status = ""+Request["p_status"];	
		string p_ccy = ""+Request["p_ccy"];	
		
		string p_cmp_name = "";
		string p_Add = "";
		string p_Taxcode = "";
	
        string TemplateFile = "rpt_60080200_expense_monthly.xls";
        string TempFile = "../../../system/temp/rpt_60080200_expense_monthly_" + Session["User_ID"].ToString() + ".xls";
		
	   TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
        //Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;
		string SQL = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE from tco_company where del_if = 0 and pk = '"+p_compk+"' " ;
		DataTable dt_company = ESysLib.TableReadOpen(SQL);
		if (dt_company.Rows.Count > 0)
		{
			p_cmp_name = dt_company.Rows[0][0].ToString();
			p_Add = dt_company.Rows[0][1].ToString();
			p_Taxcode = dt_company.Rows[0][3].ToString();
		}
		
		exSheet.Cells["A1"].Value   =  p_cmp_name;
		exSheet.Cells["A2"].Value   =  p_Add;
		exSheet.Cells["A3"].Value   =  p_Taxcode;
		exSheet.Cells["A6"].Value   =  "From date "+p_from.Substring(6,2)+"/"+p_from.Substring(4,2)+"/"+p_from.Substring(0,4)+" ~ "+p_to.Substring(6,2)+"/"+p_to.Substring(4,2)+"/"+p_to.Substring(0,4);
        //bind data to excel file
        string para = "'" + p_compk +"','"+p_from+"','"+p_to+"','"+p_acc_pk+"','"+p_plcenter+"','"+p_plunit+"','"+p_status+"','"+p_ccy+"'"; 
		// Response.Write("aa");
		// Response.End();
       DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60080200_rpt_pl", para);
	//-------------------------------------------------
       for (int l_addrow = 1; l_addrow < dt.Rows.Count ; l_addrow++)
        {
            exSheet.Range["A10"].Rows.EntireRow.Insert();//insert row new of sheet
        }
	//-------------------------------------------------
		
		int _row = 9;
		for (int i = 0; i < dt.Rows.Count;i++)
		{
			for(int col=1;col<=9;col++)
			{
				exSheet.Cells[_row + i, 1].Value = dt.Rows[i]["plc_cd"].ToString();
				exSheet.Cells[_row + i, 2].Value = dt.Rows[i]["pl_cd"].ToString();
				exSheet.Cells[_row + i, 3].Value = dt.Rows[i]["voucherno"].ToString();
				exSheet.Cells[_row + i, 4].Value = dt.Rows[i]["std_ymd"].ToString();
				exSheet.Cells[_row + i, 5].Value = dt.Rows[i]["remark"].ToString();
				exSheet.Cells[_row + i, 6].Value = dt.Rows[i]["ac_cd"].ToString();
				exSheet.Cells[_row + i, 7].Value = decimal.Parse(dt.Rows[i]["amount_dr"].ToString());
				exSheet.Cells[_row + i, 8].Value = decimal.Parse(dt.Rows[i]["amount_cr"].ToString());
				if(dt.Rows[i]["voucherno"].ToString()!="" && dt.Rows[i]["std_ymd"].ToString()!="" && dt.Rows[i]["remark"].ToString()!="")
				{
					exSheet.Cells[_row + i, 9].Value = dt.Rows[i]["seq"].ToString();
				}
				
				if(dt.Rows[i]["voucherno"].ToString()=="" && dt.Rows[i]["std_ymd"].ToString()=="" && dt.Rows[i]["remark"].ToString()=="")
				{
					// exSheet.Cells[_row + i, 2].Value = dt.Rows[i]["pl_cd"].ToString();
					Color colorValueFrmHex = ColorTranslator.FromHtml("0X2ECCFA");
					exSheet.Cells[_row + i, col].Interior.Color = colorValueFrmHex;
					exSheet.Cells[_row + i, col].Font.Bold = true;
				}
				if(dt.Rows[i]["pl_cd"].ToString()=="" && dt.Rows[i]["voucherno"].ToString()=="" && dt.Rows[i]["std_ymd"].ToString()=="" && dt.Rows[i]["remark"].ToString()=="")
				{
					// exSheet.Cells[_row + i, 1].Value = dt.Rows[i]["plc_cd"].ToString();
					Color colorValueFrmHex = ColorTranslator.FromHtml("0XF3F781");
					exSheet.Cells[_row + i, col].Interior.Color = colorValueFrmHex;
					exSheet.Cells[_row + i, col].Font.Bold = true;
				}
				if(dt.Rows[i]["plc_cd"].ToString()=="" && dt.Rows[i]["pl_cd"].ToString()=="" && dt.Rows[i]["voucherno"].ToString()=="" && dt.Rows[i]["std_ymd"].ToString()=="" && dt.Rows[i]["remark"].ToString()=="")
				{
					Color colorValueFrmHex = ColorTranslator.FromHtml("0XFE2E2E");
					exSheet.Cells[_row + i, col].Interior.Color = colorValueFrmHex;
					exSheet.Cells[_row + i, col].Font.Bold = true;
					exSheet.Cells[_row + i, 1].Value = "TOTAL";
				}
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