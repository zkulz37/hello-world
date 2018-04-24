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

public partial class rpt_60120120_rpt_import_VAT_out_119 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		 ESysLib.SetUser(Session["APP_DBUSER"].ToString()); 
		 string p_com = "" + Request["com"];
		string p_month = "" + Request["yyyymm"];
		string p_status = "" + Request["status"];
		string p_vat_rate = "" + Request["vat_rate"];
		string p_ccy = "" + Request["ccy"];
		string p_cust_pk = "" + Request["cust_pk"];
		string p_acc_pk = "" + Request["acc_pk"];
		string p_From = "" + Request["From"];
		string p_To = "" + Request["To"];
		string month = p_month.Substring(4,2);
		string year = p_month.Substring(0,4);
		string p_voucher_type = "" + Request["voucher_type"];
		string p_Biz_Place = "" + Request["Biz_Place"];
		string l_month = p_month.Substring(4,2);
		string l_year = p_month.Substring(0,4);
		string l_lname ="";
		string l_name ="";
		string l_tax_code ="";
		string l_address ="";
		
		
        string TemplateFile = "rpt_60120120_rpt_import_VAT_out_119.xls";
        string TempFile = "../../../system/temp/rpt_60120120_rpt_import_VAT_out_119_" + Session["User_ID"].ToString() + ".xls";
		
	   TemplateFile = Server.MapPath(TemplateFile);
       TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
        //Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;
		
		string p_xls_ccy_format ="";
		string p_bookccy = "";
	    string SQL = "SELECT AC_GET_BOOKCCY_ACNT('ACBG0040') FROM DUAL " ;
		DataTable dt_bookccy = ESysLib.TableReadOpen(SQL);
		if (dt_bookccy.Rows.Count >0)
		{	
			p_bookccy = dt_bookccy.Rows[0][0].ToString();
		}
		if (p_bookccy == "VND")
		{
			p_xls_ccy_format = "#,##0";
		}
		else
		{
			p_xls_ccy_format = "#,##0.00";
		}
		
		SQL = " SELECT pk, partner_name, partner_lname, addr1 ||addr2||addr3 address, tax_code ";
		SQL += "  FROM tco_company ";
		SQL += " WHERE del_if = 0 AND pk = '" + p_com + "'";
		DataTable dtCom = ESysLib.TableReadOpen(SQL);
		if (dtCom.Rows.Count >0)
		{
			l_name  = dtCom.Rows[0][1].ToString();
			l_lname = dtCom.Rows[0][2].ToString();
			l_address = dtCom.Rows[0][3].ToString();
			l_tax_code = dtCom.Rows[0][4].ToString();
		}
		
		exSheet.Cells["A7"].Value  = "[01] Kỳ tính thuế: tháng.."+l_month+"..năm .."+l_year+".. hoặc quý.....năm....";
		exSheet.Cells["C8"].Value  = l_lname;
		exSheet.Cells["C9"].Value  = l_tax_code;
        //bind data to excel file
		// Muc (1)
		string VAT_YN = "";
		SQL	= "select code  " + 
        "      from tac_commcode_master a, tac_commcode_detail b " +
        "     where     a.pk = b.tac_commcode_master_pk " +
        "           and a.id = 'ACBG0188' " +
        "           and a.del_if = 0 " +
        "           and b.del_if = 0 " +
        "           and def_yn = 'Y' " ;
		DataTable dtVAT_YN = ESysLib.TableReadOpen(SQL);
		if (dtVAT_YN.Rows.Count >0)
		{
			VAT_YN =  dtVAT_YN.Rows[0][0].ToString();
		}
		
        string l_parameter = "'" + p_com + "','" + p_status + "','"+p_acc_pk+"','"+p_From+"','"+p_To+"','"+p_voucher_type+"','"+VAT_YN+"','2','"+p_Biz_Place+"'";
		// Response.Write(l_parameter);
		// Response.End();
//============================================================================================================================================================				
		DataTable dt_4 = ESysLib.TableReadOpenCursor("ac_rpt_60120120_imp_out_4", l_parameter);
		
		for (int l_addrow4 = 0; l_addrow4 < dt_4.Rows.Count-1; l_addrow4++)
        {
            exSheet.Range[26+l_addrow4+1,1].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		int _row4 = 26;
		int stt4 = 0;
		decimal NetAmt_Total_4 = 0;
		decimal TaxAmt_Total_4 = 0;
		for (int i = 0; i < dt_4.Rows.Count;i++)
		{
			stt4 += 1;
			exSheet.Cells[_row4 + i, 1].Value = stt4;
			exSheet.Cells[_row4 + i, 2].Value = dt_4.Rows[i]["invoice_no"].ToString();
			exSheet.Cells[_row4 + i, 3].Value = dt_4.Rows[i]["invoice_date"].ToString();
			exSheet.Cells[_row4 + i, 4].Value = dt_4.Rows[i]["partner_name"].ToString();
			exSheet.Cells[_row4 + i, 5].Value = dt_4.Rows[i]["tax_code"].ToString();
			exSheet.Cells[_row4 + i, 6].Value = decimal.Parse(dt_4.Rows[i]["net_amt"].ToString());
			exSheet.Cells[_row4 + i, 7].Value = decimal.Parse(dt_4.Rows[i]["tax_amt"].ToString());
			exSheet.Cells[_row4 + i, 8].Value = dt_4.Rows[i]["note"].ToString();
			
			if(dt_4.Rows[i]["net_amt"].ToString().Trim()!="")
			{
				NetAmt_Total_4 += decimal.Parse(dt_4.Rows[i]["net_amt"].ToString());
			}
			else
			{
				NetAmt_Total_4 = 0;
			}
			if(dt_4.Rows[i]["tax_amt"].ToString().Trim()!="")
			{
				TaxAmt_Total_4 += decimal.Parse(dt_4.Rows[i]["tax_amt"].ToString());
			}
			else
			{
				TaxAmt_Total_4 = 0;
			}
			exSheet.Cells[27 + i, 6].Value = NetAmt_Total_4;
			exSheet.Cells[27 + i, 7].Value = TaxAmt_Total_4;
		} 		
//============================================================================================================================================================				
		DataTable dt_3 = ESysLib.TableReadOpenCursor("ac_rpt_60120120_imp_out_3", l_parameter);
		
		for (int l_addrow3 = 0; l_addrow3 < dt_3.Rows.Count-1; l_addrow3++)
        {
            exSheet.Range[23+l_addrow3+1,1].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		int _row3 = 23;
		int stt3 = 0;
		decimal NetAmt_Total_3 = 0;
		decimal TaxAmt_Total_3 = 0;
		for (int i = 0; i < dt_3.Rows.Count;i++)
		{
			stt3 += 1;
			exSheet.Cells[_row3 + i, 1].Value = stt3;
			exSheet.Cells[_row3 + i, 2].Value = dt_3.Rows[i]["invoice_no"].ToString();
			exSheet.Cells[_row3 + i, 3].Value = dt_3.Rows[i]["invoice_date"].ToString();
			exSheet.Cells[_row3 + i, 4].Value = dt_3.Rows[i]["partner_name"].ToString();
			exSheet.Cells[_row3 + i, 5].Value = dt_3.Rows[i]["tax_code"].ToString();
			exSheet.Cells[_row3 + i, 6].Value = decimal.Parse(dt_3.Rows[i]["net_amt"].ToString());
			exSheet.Cells[_row3 + i, 7].Value = decimal.Parse(dt_3.Rows[i]["tax_amt"].ToString());
			exSheet.Cells[_row3 + i, 8].Value = dt_3.Rows[i]["note"].ToString();
			
			if(dt_3.Rows[i]["net_amt"].ToString().Trim()!="")
			{
				NetAmt_Total_3 += decimal.Parse(dt_3.Rows[i]["net_amt"].ToString());
			}
			else
			{
				NetAmt_Total_3 = 0;
			}
			if(dt_3.Rows[i]["tax_amt"].ToString().Trim()!="")
			{
				TaxAmt_Total_3 += decimal.Parse(dt_3.Rows[i]["tax_amt"].ToString());
			}
			else
			{
				TaxAmt_Total_3 = 0;
			}
			exSheet.Cells[24 + i, 6].Value = NetAmt_Total_3;
			exSheet.Cells[24 + i, 7].Value = TaxAmt_Total_3;
		} 
//============================================================================================================================================================		
		DataTable dt_2 = ESysLib.TableReadOpenCursor("ac_rpt_60120120_imp_out_2", l_parameter);
		
		for (int l_addrow2 = 0; l_addrow2 < dt_2.Rows.Count-1; l_addrow2++)
        {
            exSheet.Range[20+l_addrow2+1,1].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		int _row2 = 20;
		int stt2 = 0;
		decimal NetAmt_Total_2 = 0;
		decimal TaxAmt_Total_2 = 0;
		for (int i = 0; i < dt_2.Rows.Count;i++)
		{
			stt2 += 1;
			exSheet.Cells[_row2 + i, 1].Value = stt2;
			exSheet.Cells[_row2 + i, 2].Value = dt_2.Rows[i]["invoice_no"].ToString();
			exSheet.Cells[_row2 + i, 3].Value = dt_2.Rows[i]["invoice_date"].ToString();
			exSheet.Cells[_row2 + i, 4].Value = dt_2.Rows[i]["partner_name"].ToString();
			exSheet.Cells[_row2 + i, 5].Value = dt_2.Rows[i]["tax_code"].ToString();
			exSheet.Cells[_row2 + i, 6].Value = decimal.Parse(dt_2.Rows[i]["net_amt"].ToString());
			exSheet.Cells[_row2 + i, 7].Value = decimal.Parse(dt_2.Rows[i]["tax_amt"].ToString());
			exSheet.Cells[_row2 + i, 8].Value = dt_2.Rows[i]["note"].ToString();
			
			if(dt_2.Rows[i]["net_amt"].ToString().Trim()!="")
			{
				NetAmt_Total_2 += decimal.Parse(dt_2.Rows[i]["net_amt"].ToString());
			}
			else
			{
				NetAmt_Total_2 = 0;
			}
			if(dt_2.Rows[i]["tax_amt"].ToString().Trim()!="")
			{
				TaxAmt_Total_2 += decimal.Parse(dt_2.Rows[i]["tax_amt"].ToString());
			}
			else
			{
				TaxAmt_Total_2 = 0;
			}
			exSheet.Cells[21 + i, 6].Value = NetAmt_Total_2;
			exSheet.Cells[21 + i, 7].Value = TaxAmt_Total_2;
		} 
		
//===============================================================================================================================================================		
        DataTable dt = ESysLib.TableReadOpenCursor("ac_rpt_60120120_imp_out_1", l_parameter);
		
		for (int l_addrow = 0; l_addrow < dt.Rows.Count-1; l_addrow++)
        {
            exSheet.Range[17+l_addrow+1,1].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		int _row = 17;
		int stt = 0;
		decimal NetAmt_Total_1 = 0;
		decimal TaxAmt_Total_1 = 0;
		for (int i = 0; i < dt.Rows.Count;i++)
		{
			stt += 1;
			exSheet.Cells[_row + i, 1].Value = stt;
			exSheet.Cells[_row + i, 2].Value = dt.Rows[i]["invoice_no"].ToString();
			exSheet.Cells[_row + i, 3].Value = dt.Rows[i]["invoice_date"].ToString();
			exSheet.Cells[_row + i, 4].Value = dt.Rows[i]["partner_name"].ToString();
			exSheet.Cells[_row + i, 5].Value = dt.Rows[i]["tax_code"].ToString();
			exSheet.Cells[_row + i, 6].Value = decimal.Parse(dt.Rows[i]["net_amt"].ToString());
			exSheet.Cells[_row + i, 7].Value = decimal.Parse(dt.Rows[i]["tax_amt"].ToString());
			exSheet.Cells[_row + i, 8].Value = dt.Rows[i]["note"].ToString();
			
			if(dt.Rows[i]["net_amt"].ToString().Trim()!="")
			{
				NetAmt_Total_1 += decimal.Parse(dt.Rows[i]["net_amt"].ToString());
			}
			else
			{
				NetAmt_Total_1 = 0;
			}
			if(dt.Rows[i]["tax_amt"].ToString().Trim()!="")
			{
				TaxAmt_Total_1 += decimal.Parse(dt.Rows[i]["tax_amt"].ToString());
			}
			else
			{
				TaxAmt_Total_1 = 0;
			}
			exSheet.Cells[18 + i, 6].Value = NetAmt_Total_1;
			exSheet.Cells[18 + i, 7].Value = TaxAmt_Total_1;
		} 	
		
		int Mot = 0, Hai = 0, Ba = 0, Bon = 0;
		Mot = dt.Rows.Count;
		Hai = dt_2.Rows.Count;
		Ba = dt_3.Rows.Count;
		Bon = dt_4.Rows.Count;
		if(Mot>1)
		{
			Mot = Mot-1;
		}
		else
		{
			Mot = 0;
		}
		if(Hai>1)
		{
			Hai = Hai-1;
		}
		else
		{
			Hai = 0;
		}
		if(Ba>1)
		{
			Ba = Ba-1;
		}
		else
		{
			Ba = 0;
		}
		if(Bon>1)
		{
			Bon = Bon-1;
		}
		else
		{
			Bon = 0;
		}
		if(Mot>1||Hai>1||Ba>1||Bon>1)
		{
			exSheet.Cells[29 + Mot + Hai + Ba + Bon, 6].Value = NetAmt_Total_1 + NetAmt_Total_2 + NetAmt_Total_3 + NetAmt_Total_4;
			exSheet.Cells[30 + Mot + Hai + Ba + Bon, 6].Value = TaxAmt_Total_1 + TaxAmt_Total_2 + TaxAmt_Total_3 + TaxAmt_Total_4;
		}
		else
		{
			exSheet.Cells[29, 6].Value = NetAmt_Total_1 + NetAmt_Total_2 + NetAmt_Total_3 + NetAmt_Total_4;
			exSheet.Cells[30, 6].Value = TaxAmt_Total_1 + TaxAmt_Total_2 + TaxAmt_Total_3 + TaxAmt_Total_4;
		}
		/**/
		//exSheet.UsedRange.Rows.Autofit();
	
		
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