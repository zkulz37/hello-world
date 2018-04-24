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

public partial class rpt_60120120_rpt_pl3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string com = Request["com"];
		string From = Request["From"];
		string To = Request["To"];
		
        string TemplateFile = "rpt_60120120_rpt_pl3.xls";
        string TempFile = "../../../system/temp/rpt_60120120_rpt_pl3_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
        string para = "";
		string chr0="",chr1="",chr2="",chr3="",chr4="",chr5="",chr6="",chr7="",chr8="",chr9="",chr10="";
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
		  string l_month = From.Substring(3,2);
		  string l_year = From.Substring(6,4);
		  
		  chr0 = l_tax_code.Substring(0,1);
		  chr1  = l_tax_code.Substring(1,1);
		  chr2  = l_tax_code.Substring(2,1);
		  chr3  = l_tax_code.Substring(3,1);
		  chr4  = l_tax_code.Substring(4,1);
		  chr5  = l_tax_code.Substring(5,1);
		  chr6  = l_tax_code.Substring(6,1);
		  chr7  = l_tax_code.Substring(7,1);
		  chr8  = l_tax_code.Substring(8,1);
		  chr9  = l_tax_code.Substring(9,1);
		  chr10  = l_tax_code.Substring(10,1);
		/******************Master*********************/
		if (l_count <=0)
			exSheet.Cells["G4"].Value  = "There is no data";
		else
		{
			exSheet.Cells["A3"].Value  ="[01] Kỳ tính thuế: tháng "+ l_month +" năm "+ l_year +" hoặc quý....năm....";
			exSheet.Cells["G4"].Value  = l_name;
			//tax code
			exSheet.Cells["H5"].Value  = chr0;
			exSheet.Cells["I5"].Value  = chr1;
			exSheet.Cells["J5"].Value  = chr2;
			exSheet.Cells["K5"].Value  = chr3;
			exSheet.Cells["L5"].Value  = chr4;
			exSheet.Cells["M5"].Value  = chr5;
			exSheet.Cells["N5"].Value  = chr6;
			exSheet.Cells["O5"].Value  = chr7;
			
			exSheet.Cells["Q5"].Value  = chr8;
			exSheet.Cells["R5"].Value  = chr9;
			exSheet.Cells["S5"].Value  = chr10;
		}
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
			exSheet.Cells["G"+(pos+i)].Value  =dt.Rows[i]["ctr_due_date"];
			exSheet.Cells["H"+(pos+i)].Value  =dt.Rows[i]["decl_no"];
			exSheet.Cells["I"+(pos+i)].Value  =dt.Rows[i]["decl_date"];
			exSheet.Cells["J"+(pos+i)].Value  =dt.Rows[i]["decl_famt"];
			exSheet.Cells["K"+(pos+i)].Value  =dt.Rows[i]["decl_amt"];
			exSheet.Cells["L"+(pos+i)].Value  =dt.Rows[i]["inv_no"];
			exSheet.Cells["M"+(pos+i)].Value  =dt.Rows[i]["inv_date"];
			exSheet.Cells["N"+(pos+i)].Value  =dt.Rows[i]["inv_famt"];
			exSheet.Cells["O"+(pos+i)].Value  =dt.Rows[i]["inv_amt"];
			exSheet.Cells["P"+(pos+i)].Value  =dt.Rows[i]["recv_no"];
			exSheet.Cells["Q"+(pos+i)].Value  =dt.Rows[i]["recv_date"];
			exSheet.Cells["R"+(pos+i)].Value  =dt.Rows[i]["recv_famt"];
			exSheet.Cells["S"+(pos+i)].Value  =dt.Rows[i]["recv_amt"];
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