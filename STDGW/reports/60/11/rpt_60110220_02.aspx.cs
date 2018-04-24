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

public partial class rpt_60110220_02 : System.Web.UI.Page
{
    
	protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        //ESysLib.SetUser("acnt");
        string l_company_pk = Request["tco_company_pk"];
		string l_from_dt = Request["tr_date_fr"];
        string l_to_dt = Request["tr_date_to"];
        string l_partner_pk = Request["tco_buspartner_pk"];
        string l_bank_pk = Request["bank_pk"];
        string l_balance_yn = Request["balance_yn"];

        string TemplateFile = "rpt_60110220_02.xls";
        string TempFile = "../../../system/temp/rpt_60110220_02_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
		//IWorksheet exSheet2 = exBook.Worksheets[2];

        //bind data to excel file
        string para = "";
        DataTable dt,dt_info;
        para = "'" + l_company_pk + "','" + l_partner_pk + "','" + l_from_dt + "','" + l_to_dt + "','" + l_bank_pk + "','" + l_balance_yn + "'";
        dt = ESysLib.TableReadOpenCursor("ac_rpt_60110220_02", para);
        para = "'" + l_company_pk + "','" + l_partner_pk + "','" + l_bank_pk + "','" + l_from_dt + "','" + l_to_dt + "'";
        dt_info = ESysLib.TableReadOpenCursor("ac_rpt_60110220_01_mst", para);

        if (dt.Rows.Count - 1 > 0)
        {
            if (dt_info.Rows.Count > 0)
            {
                exSheet.Cells[1, 1].Value = dt_info.Rows[0]["comp_name"].ToString();
                exSheet.Cells[2, 1].Value = dt_info.Rows[0]["comp_addr"].ToString();
                exSheet.Cells[4, 1].Value = dt_info.Rows[0]["debit_date"].ToString();
                exSheet.Cells[6, 1].Value = dt_info.Rows[0]["partner_nm"].ToString();
                exSheet.Cells[7, 1].Value = dt_info.Rows[0]["partner_addr"].ToString();

            }

            Int32 start_row = 11;
            Int32 end_row = 11;
            for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
            {
                exSheet.Range["A12"].Rows.EntireRow.Insert();//insert row new of sheet
            }

            for (int i = 0; i < dt.Rows.Count ; i++)
            {
                exSheet.Cells[start_row + i, 1].Value = dt.Rows[i]["serial_no"].ToString();
                exSheet.Cells[start_row + i, 2].Value = dt.Rows[i]["invoice_no"].ToString();
                exSheet.Cells[start_row + i, 3].Value = dt.Rows[i]["invoice_date"].ToString();
                exSheet.Cells[start_row + i, 4].Value = dt.Rows[i]["due_date"].ToString();
                exSheet.Cells[start_row + i, 5].Value = dt.Rows[i]["ar_amt"].ToString();
                exSheet.Cells[start_row + i, 6].Value = dt.Rows[i]["paid_date"];
                exSheet.Cells[start_row + i, 7].Value = dt.Rows[i]["paid_amt"];

                exSheet.Cells[start_row + i, 8].Value = dt.Rows[i]["rtn_no"];
                exSheet.Cells[start_row + i, 9].Value = dt.Rows[i]["rtn_dt"];
                exSheet.Cells[start_row + i, 10].Value = dt.Rows[i]["rtn_amt"];
                exSheet.Cells[start_row + i, 11].Value = dt.Rows[i]["balance_amt"];
                exSheet.Cells[start_row + i, 12].Value = dt.Rows[i]["remark"];
            }
            end_row = start_row + dt.Rows.Count;

            exSheet.Cells[end_row, 5].Formula = "=Sum(E" + start_row + ":E" + (end_row-1) + ")";
            exSheet.Cells[end_row, 7].Formula = "=Sum(G" + start_row + ":G" + (end_row - 1) + ")";
            exSheet.Cells[end_row, 10].Formula = "=Sum(J" + start_row + ":J" + (end_row - 1) + ")";

            exSheet.Cells[end_row, 11].Formula = "=Sum(E" + end_row + "-G" + end_row + "-J" + end_row + ")";

            end_row = end_row + 3;
            exSheet.Cells[end_row, 4].Value = dt_info.Rows[0]["comp_name"].ToString();
            end_row = end_row + 1;
            exSheet.Cells[end_row, 3].Value = dt_info.Rows[0]["bank_nm"].ToString() + ":" + dt_info.Rows[0]["bank_id"].ToString();
        }
        else
        {
            Response.Write("Nodata found");
        }

      
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }

        //range = exSheet.Range["A1"];
        // hide row A5 
        //range.Rows.Hidden = true;

        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

        exBook.SaveAs(TempFile);
		ESysLib.ExcelToPdf(TempFile);
        string pdfFilePath = TempFile.Replace(".xls", ".pdf");
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
		//Response.WriteFile(pdfFilePath);
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }
}
