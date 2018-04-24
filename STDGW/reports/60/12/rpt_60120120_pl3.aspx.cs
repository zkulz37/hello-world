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

public partial class rpt_60120120_pl3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string com = Request["com"];
		string From = Request["From"];
		string To = Request["To"];
		
        string TemplateFile = "rpt_60120120_pl3.xls";
        string TempFile = "../../../system/temp/rpt_60120120_pl3_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        string para = "";
		
		string l_name ="",l_lname="",l_address="",l_tax_code="";
        DataTable dt;

        para = "'" + com + "','"+ From +"','"+ To +"'";
		
        dt = ESysLib.TableReadOpenCursor("ac_rpt_60120120_pl3", para);
		int l_count = dt.Rows.Count;
		string SQL = " SELECT pk, partner_name, partner_lname, addr1 ||addr2||addr3 address, tax_code ";
		  SQL += "  FROM tco_company ";
		  SQL += " WHERE del_if = 0 AND pk = '" + com + "'";
		  DataTable dtCom = ESysLib.TableReadOpen(SQL);
		  if (dtCom.Rows.Count >0)
		  {
		   l_name  = dtCom.Rows[0][1].ToString();
		   l_lname = dtCom.Rows[0][2].ToString();
		   l_address = dtCom.Rows[0][3].ToString();
		   l_tax_code = dtCom.Rows[0][4].ToString();
		  }
		  l_tax_code = l_tax_code.Trim();
		  char[] arr = new char[11];
		  string l_month ="",l_year ="";
		  
		  l_month = From.Substring(4,2);
		  l_year = From.Substring(0,4);
		  for(int j=0;j<l_tax_code.Length;j++)
			arr[j]=Convert.ToChar(l_tax_code.Substring(j,1));
		  
		/******************Master*********************/
		if (l_count ==0)
		{
			Response.Write("There is no data");
			Response.End();
		}	
		
			exSheet.Cells["U3"].Value  ="[01] Kỳ tính thuế: tháng "+ l_month +" năm "+ l_year +" hoặc quý....năm....";
			exSheet.Cells["E4"].Value  = l_name;
			//tax code
			exSheet.Cells["G5"].Value  = arr[0].ToString();
			exSheet.Cells["I5"].Value  = arr[1].ToString();
			exSheet.Cells["K5"].Value  = arr[2].ToString();
			exSheet.Cells["M5"].Value  = arr[3].ToString();
			exSheet.Cells["O5"].Value  = arr[4].ToString();
			exSheet.Cells["R5"].Value  = arr[5].ToString();
			exSheet.Cells["T5"].Value  = arr[6].ToString();
			exSheet.Cells["V5"].Value  = arr[7].ToString();
			
			exSheet.Cells["Z5"].Value  = arr[8].ToString();
			exSheet.Cells["AB5"].Value  = arr[9].ToString();
			exSheet.Cells["AD5"].Value  = arr[10].ToString();
		
		/******************End Master*********************/
		
		/******************Detail*********************/
		// INSERT ROWS
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A15"].Rows.EntireRow.Insert();//insert row new of sheet
        }
		// SET DATA
		int pos = 14 ;
		int i   = 0  ;		  						
		for (i = 0; i < dt.Rows.Count; i++)
		{
			exSheet.Cells["A"+(pos+i)].Value  = i+1;
			exSheet.Cells["B"+(pos+i)].Value  =dt.Rows[i]["ctr_no"];
			exSheet.Cells["C"+(pos+i)].Value  =dt.Rows[i]["ctr_date"];
			exSheet.Cells["D"+(pos+i)].Value  =dt.Rows[i]["ctr_famt"];
			exSheet.Cells["E"+(pos+i)].Value  =dt.Rows[i]["ctr_amt"];
			exSheet.Cells["F"+(pos+i)].Value  =dt.Rows[i]["ctr_method"];
			exSheet.Cells["I"+(pos+i)].Value  =dt.Rows[i]["ctr_due_date"];
			exSheet.Cells["P"+(pos+i)].Value  =dt.Rows[i]["decl_no"];
			exSheet.Cells["T"+(pos+i)].Value  =dt.Rows[i]["decl_date"];
			exSheet.Cells["X"+(pos+i)].Value  =dt.Rows[i]["decl_famt"];
			exSheet.Cells["AB"+(pos+i)].Value  =dt.Rows[i]["decl_amt"];
			exSheet.Cells["AF"+(pos+i)].Value  =dt.Rows[i]["inv_no"];
			exSheet.Cells["AH"+(pos+i)].Value  =dt.Rows[i]["inv_date"];
			exSheet.Cells["AJ"+(pos+i)].Value  =dt.Rows[i]["inv_famt"];
			exSheet.Cells["AL"+(pos+i)].Value  =dt.Rows[i]["inv_amt"];
			exSheet.Cells["AN"+(pos+i)].Value  =dt.Rows[i]["recv_no"];
			exSheet.Cells["AO"+(pos+i)].Value  =dt.Rows[i]["recv_date"];
			exSheet.Cells["AP"+(pos+i)].Value  =dt.Rows[i]["recv_famt"];
			exSheet.Cells["AQ"+(pos+i)].Value  =dt.Rows[i]["recv_amt"];
			//exSheet.Cells["T"+(pos+i)].Value  =dt.Rows[i]["partner_lname"];
		}
		/******************End Detail*********************/	
		//exSheet.Range["A"+(i_row*l_page+1)].Select();	
			
		if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
       

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