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

public partial class rpt_60170320_3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser("acnt");
         string TemplateFile = "RPT_60170320_3.xls";
        string TempFile = "../../../system/temp/RPT_FMGF00110_3_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string p_comp_pk = ""+Request["comp_pk"];	
		
		string p_from_dt = ""+Request["from_dt"];	
		
		string p_to_dt = ""+Request["to_dt"];	
		
		string p_item_pk = ""+Request["item_pk"];	
		
		string p_pl_pk = ""+Request["pl_pk"];	
		
		string p_wh_pk = ""+Request["wh_pk"];	
		
		string p_ac_pk = "" + Request["ac_pk"] ;
		
		// Counter for loop
		int i = 0;
		
		string para="'" + p_comp_pk + "', '" + p_from_dt + "', '" + p_to_dt + "', '" + p_ac_pk + "', '" + p_item_pk + "','" + p_pl_pk + "', '" + p_wh_pk + "'" ;

        DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60170320_3", para);		  
		// Variables to get qty and amount
		decimal v_begin_qty = 0 , v_begin_amt = 0 , v_input_qty = 0 , v_input_amt = 0 ;
		
		decimal v_output_qty = 0 , v_output_amt = 0 , v_end_qty = 0 , v_end_amt = 0 ;
		
		decimal v_sum_begin_qty = 0 , v_sum_begin_amt = 0 , v_sum_input_qty = 0 , v_sum_input_amt = 0 ;
		
		decimal v_sum_output_qty = 0 , v_sum_output_amt = 0 , v_sum_end_qty = 0 , v_sum_end_amt = 0 ;
		
		// Company Information
		string v_comp_name = "" ;
		
		// Account Code Name
		string v_acc_nm = "" ;
		
		// SQL select statement
		string SQL = "" ;
		
		//	DataTable dtMST = ESysLib.TableReadOpenCursor("acnt.ac_rpt_60080050_detail",para);		  
       
			//exSheet.Cells[1,1].Value = dtMST.Rows[0]["partner_lname"].ToString(); 
			//exSheet.Cells[2,1].Value = dtMST.Rows[0]["addr2"].ToString(); 
			//exSheet.Cells[3,1].Value = "Tax Code/MST :"+ dtMST.Rows[0]["tax_code"].ToString(); 
			
			//exSheet.Cells[6,7].Value = dt.Rows[0]["TR_DATE"].ToString();	
			
		SQL = "select partner_name from tco_company where pk = " + p_comp_pk  + " and del_if = 0" ;
		
		DataTable dtComp = ESysLib.TableReadOpen(SQL);
		
		if(dtComp.Rows.Count > 0)
		{
			v_comp_name = dtComp.Rows[0][0].ToString();
		}
		
		SQL = "select ac_cd || ' - ' || ac_nm from tac_abacctcode where pk like '" + p_ac_pk + "' " ;
		
		DataTable dtAcc = ESysLib.TableReadOpen(SQL);
		
		if(dtAcc.Rows.Count > 0)
		{
			v_acc_nm = dtAcc.Rows[0][0].ToString() ;
		}
		
		exSheet.Cells[1, 1].Value = v_comp_name ;
		
		exSheet.Cells[4, 1].Value = v_acc_nm ;
		
		exSheet.Cells[3, 5].Value = p_from_dt.Substring(6, 2) + "/" + p_from_dt.Substring(4, 2) + "/" + p_from_dt.Substring(0, 4) + " to " + p_to_dt.Substring(6, 2) + "/" + p_to_dt.Substring(4, 2) + "/" + p_to_dt.Substring(0, 4);
		
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A7"].Rows.EntireRow.Insert();//insert row new of sheet
        }
        
        for (i = 0; i < dt.Rows.Count; i++)
        {
			
			exSheet.Cells[6 + i, 1].Value = dt.Rows[i]["item_code"].ToString();
			
			exSheet.Cells[6 + i, 2].Value = dt.Rows[i]["item_name"].ToString();
			
			if(dt.Rows[i]["last_qty"].ToString() != "")
			{
				v_begin_qty = decimal.Parse(dt.Rows[i]["last_qty"].ToString());
				exSheet.Cells[6 + i, 3].Value = v_begin_qty ;
				v_sum_begin_qty += v_begin_qty ;
			}
			else
			{
				exSheet.Cells[6 + i, 3].Value = 0 ;
			}
			
			if(dt.Rows[i]["last_amt"].ToString() != "")
			{
				v_begin_amt = decimal.Parse(dt.Rows[i]["last_amt"].ToString());
				exSheet.Cells[6 + i, 4].Value = v_begin_amt ;
				v_sum_begin_amt += v_begin_amt ;
			}
			else
			{
				exSheet.Cells[6 + i, 4].Value = 0 ;
			}

			if(dt.Rows[i]["input_qty"].ToString() != "")
			{
				v_input_qty = decimal.Parse(dt.Rows[i]["input_qty"].ToString());
				exSheet.Cells[6 + i, 5].Value = v_input_qty ;
				v_sum_input_qty += v_input_qty ;
			}
			else
			{
				exSheet.Cells[6 + i, 5].Value = 0 ;
			}

			if(dt.Rows[i]["input_amt"].ToString() != "")
			{
				v_input_amt = decimal.Parse(dt.Rows[i]["input_amt"].ToString());
				exSheet.Cells[6 + i, 6].Value = v_input_amt ;
				v_sum_input_amt += v_input_amt ;
			}
			else
			{
				exSheet.Cells[6 + i, 6].Value = 0 ;
			}

			if(dt.Rows[i]["output_qty"].ToString() != "")
			{
				v_output_qty = decimal.Parse(dt.Rows[i]["output_qty"].ToString());
				exSheet.Cells[6 + i, 7].Value = v_output_qty ;
				v_sum_output_qty += v_output_qty ;
			}
			else
			{
				exSheet.Cells[6 + i, 7].Value = 0 ;
			}

			if(dt.Rows[i]["output_amt"].ToString() != "")
			{
				v_output_amt = decimal.Parse(dt.Rows[i]["output_amt"].ToString());
				exSheet.Cells[6 + i, 8].Value = v_output_amt ;
				v_sum_output_amt += v_output_amt ;
			}
			else
			{
				exSheet.Cells[6 + i, 8].Value = 0 ;
			}

			if(dt.Rows[i]["this_qtybal"].ToString() != "")
			{
				v_end_qty = decimal.Parse(dt.Rows[i]["this_qtybal"].ToString());
				exSheet.Cells[6 + i, 9].Value = v_end_qty ;
				v_sum_end_qty += v_end_qty ;
			}
			else
			{
				exSheet.Cells[6 + i, 9].Value = 0 ;
			}

			if(dt.Rows[i]["this_amtbal"].ToString() != "")
			{
				v_end_amt = decimal.Parse(dt.Rows[i]["this_amtbal"].ToString());
				exSheet.Cells[6 + i, 10].Value = v_end_amt ;
				v_sum_end_amt += v_end_amt ;
			}
			else
			{
				exSheet.Cells[6 + i, 10].Value = 0 ;
			}
			
			if(dt.Rows[i]["unit_price"].ToString() != "")
			{			
				exSheet.Cells[6 + i, 11].Value = decimal.Parse(dt.Rows[i]["unit_price"].ToString());				
			}
			else
			{
				exSheet.Cells[6 + i, 11].Value = 0 ;
			}
			
		}
		
		exSheet.Cells[ 6 + dt.Rows.Count, 3].Value = v_sum_begin_qty ;
		
        exSheet.Cells[ 6 + dt.Rows.Count, 4].Value = v_sum_begin_amt ;
		
		exSheet.Cells[ 6 + dt.Rows.Count, 5].Value = v_sum_input_qty ;
		
		exSheet.Cells[ 6 + dt.Rows.Count, 6].Value = v_sum_input_amt ;
		
		exSheet.Cells[ 6 + dt.Rows.Count, 7].Value = v_sum_output_qty ;
		
		exSheet.Cells[ 6 + dt.Rows.Count, 8].Value = v_sum_output_amt ;
		
		exSheet.Cells[ 6 + dt.Rows.Count, 9].Value = v_sum_end_qty ;
		
		exSheet.Cells[ 6 + dt.Rows.Count, 10].Value = v_sum_end_amt ;
		
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        exBook.SaveAs(TempFile);
      // ESysLib.ExcelToPdf(TempFile);
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