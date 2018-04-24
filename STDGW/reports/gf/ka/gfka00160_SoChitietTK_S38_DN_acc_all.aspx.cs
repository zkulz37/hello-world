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

public partial class gfka00160_SoChitietTK_S38_DN_acc_all : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        string TemplateFile = "gfka00160_SoChitietTK_S38_DN_acc_all.xls";
        string TempFile = "../../../system/temp/gfka00160_SoChitietTK_S38_DN_acc_all_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
		//DataTable dt = ESysLib.TableReadOpenCursor("AC_rpt_60080040_T_socai_viet",para);
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
		
        IWorksheet exSheet_1 = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string p_company_pk = ""+Request["company_pk"]; 
		string p_account_code_pk = ""+Request["seq"];
		string p_dtbFrom= ""+Request["dtbFrom"]+"01";
		string p_dtbTo = ""+Request["dtbTo"];
		string p_ccy = ""+Request["ccy"];
		string p_status = ""+Request["status"];
		string p_bookccy = ""+Request["bookccy"];
		string p_transaction =""+Request["transaction"];
		string p_account_pk = "";
		double p_open_dr = 0;
		double p_open_cr=0;
		string acc_code = "";
		DataTable dtDetail;
		string para="";
		string SQL="";
		//---------------ký, họ tên, đóng dấu-------------------
				 SQL = "SELECT   " +
					"    D.CODE, " +
					"    D.CHAR_1,  " +
					"    D.CHAR_2,  " +
					"    D.CHAR_3,  " +
					"    D.CHAR_4,  " +
					"    D.CHAR_5,  " +
					"    D.REMARK " +
					" FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M " +
					" WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK " +
					" AND M.ID='EACAB012' " +
					" order by D.ORD ";
			DataTable dt1 = ESysLib.TableReadOpen(SQL);
			String e1 = "";
			String e2 = "";
			String e3 = "";
			String e4 = "";
			String e5 = "";
			String e6 = "";
			String v1 = "";
			String v2 = "";
			String v3 = "";
			String v4 = "";
			String v5 = "";
			String v6 = "";
			String g1 = "";
			String g2 = "";
			String g3 = "";
			String g4 = "";
			String g5 = "";
			String g6 = "";
			String n1 = "";
			String n2 = "";
			String n3 = "";
			String n4 = "";
			String n5 = "";
			String n6 = "";

			for (int k = 0; k < dt1.Rows.Count; k++)
			{

				string strTmp = dt1.Rows[k][0].ToString();
				if (strTmp == "ENG")
				{
					e1 = "" + dt1.Rows[k][1].ToString();
					e2 = "" + dt1.Rows[k][2].ToString();
					e3 = "" + dt1.Rows[k][3].ToString();
					e4 = "" + dt1.Rows[k][4].ToString();
					e5 = "" + dt1.Rows[k][5].ToString();
					e6 = "" + dt1.Rows[k][6].ToString();
				}

				if (strTmp == "VIE")
				{
					v1 = dt1.Rows[k][1].ToString();
					v2 = dt1.Rows[k][2].ToString();
					v3 = dt1.Rows[k][3].ToString();
					v4 = dt1.Rows[k][4].ToString();
					v5 = dt1.Rows[k][5].ToString();
					v6 = dt1.Rows[k][6].ToString();
				}
				if (strTmp == "SIG")
				{
					g1 = dt1.Rows[k][1].ToString();
					g2 = dt1.Rows[k][2].ToString();
					g3 = dt1.Rows[k][3].ToString();
					g4 = dt1.Rows[k][4].ToString();
					g5 = dt1.Rows[k][5].ToString();
					g6 = dt1.Rows[k][6].ToString();
				}

				if (strTmp == "NAM")
				{
					n1 = dt1.Rows[k][1].ToString();
					n2 = dt1.Rows[k][2].ToString();
					n3 = dt1.Rows[k][3].ToString();
					n4 = dt1.Rows[k][4].ToString();
					n5 = dt1.Rows[k][5].ToString();
					n6 = dt1.Rows[k][6].ToString();
				}
			}
		//----------end---ký, họ tên, đóng dấu---------------------
		string para_tk="'" + p_dtbFrom + "','" + p_dtbTo  + "','"+ p_account_code_pk +"','" + p_ccy + "' ,'BOOK','" + p_status + "','" + p_company_pk + "'";
		//Response.Write(para_tk);
		//Response.End();

		DataTable dtTK = ESysLib.TableReadOpenCursor("ac_sel_gfka00160_accd_all_1",para_tk);	
			
		for(int i=1;i<dtTK.Rows.Count;i++)//
		{		
			
				p_account_pk=dtTK.Rows[i]["pk"].ToString();
				p_open_dr=double.Parse(dtTK.Rows[i]["open_dr"].ToString());
				p_open_cr=double.Parse(dtTK.Rows[i]["open_cr"].ToString());
				
				acc_code=dtTK.Rows[i]["ac_cd"].ToString();
			    para="'" + p_dtbFrom + "','" + p_dtbTo  + "','" + p_account_pk + "','" + p_open_dr + "' ,'" + p_open_cr + "'";
				
				dtDetail = ESysLib.TableReadOpenCursor("ac_sel_gfka00160_dtl_acc_code",para);
				if(p_open_cr !=0 || p_open_dr != 0 || dtDetail.Rows.Count > 0)
				{
					IWorksheet exSheet = exBook.Worksheets.Add();
					exSheet.Name=dtTK.Rows[i]["ac_cd"].ToString();;
					exSheet_1.Range[1,1,25,11].Copy(exSheet.Range[1,1,25,11], XlPasteType.xlPasteAll);//cope sheet
					
					exSheet.Cells[5, 1].Value = dtTK.Rows[i]["dt_para"].ToString();
					
					exSheet.Cells[6, 2].Value = dtTK.Rows[i]["ac_cd"].ToString();
					exSheet.Cells[6, 5].Value = dtTK.Rows[i]["ac_nm"].ToString();
					
					exSheet.Cells[7, 10].Value = p_ccy;
					
					exSheet.Cells[1, 1].Value = dtTK.Rows[i]["partner_name"].ToString();
					exSheet.Cells[2, 1].Value = dtTK.Rows[i]["addr1"].ToString();
					exSheet.Cells[3, 1].Value = "Mã số thuế: "+dtTK.Rows[i]["tax_code"].ToString();
					
					exSheet.Cells[12, 7].Value = double.Parse(dtTK.Rows[i]["open_dr"].ToString());
					exSheet.Cells[12, 8].Value = double.Parse(dtTK.Rows[i]["open_cr"].ToString());
					
					exSheet.Cells[14, 7].Value = double.Parse(dtTK.Rows[i]["ps_dr"].ToString());//total detail 
					exSheet.Cells[14, 8].Value = double.Parse(dtTK.Rows[i]["ps_cr"].ToString());
					
					exSheet.Cells[15, 7].Value = double.Parse(dtTK.Rows[i]["end_dr"].ToString());
					exSheet.Cells[15, 8].Value = double.Parse(dtTK.Rows[i]["end_cr"].ToString());
					//------------ký, họ tên, đóng dấu------------
					exSheet.Cells[19, 1].Value =v1;//lap bieu
					exSheet.Cells[19, 4].Value =v2;//ke toan truong
					exSheet.Cells[19, 7].Value =v3;//tong giam doc
					//exSheet.Cells[19, 7].Value =v4;//Prepared by
					
					exSheet.Cells[20, 1].Value =g1;
					exSheet.Cells[20, 4].Value =g2;
					exSheet.Cells[20, 7].Value =g3;
					//exSheet.Cells[20, 7].Value =g4;
					
					exSheet.Cells[25, 1].Value =n1;
					exSheet.Cells[25, 4].Value =n2;
					exSheet.Cells[25, 7].Value =n3;
					//exSheet.Cells[25, 7].Value =n4;
					
					//--------------------------
					
					for (int l_addrow = 1; l_addrow < dtDetail.Rows.Count; l_addrow++)//add row show with data of table
					{           
						exSheet.Range["A14"].Rows.EntireRow.Insert();//insert row new of sheet
					}
					
					
					for (int l_row =0 ; l_row < dtDetail.Rows.Count ; l_row++)
					{
						int l_first=13;
						exSheet.Cells[l_row+l_first, 1].Value = dtDetail.Rows[l_row]["trans_date"].ToString();
						exSheet.Cells[l_row+l_first, 2].Value = dtDetail.Rows[l_row]["voucherno"].ToString();
						exSheet.Cells[l_row+l_first, 3].Value = dtDetail.Rows[l_row]["trans_date2"].ToString();
						exSheet.Cells[l_row+l_first, 4].Value = dtDetail.Rows[l_row]["remark2"].ToString();
						exSheet.Cells[l_row+l_first, 5].Value = dtDetail.Rows[l_row]["remark"].ToString();
						exSheet.Cells[l_row+l_first, 6].Value = dtDetail.Rows[l_row]["acct_code"].ToString();
						exSheet.Cells[l_row+l_first, 7].Value = double.Parse(dtDetail.Rows[l_row]["ps_debit"].ToString());
						exSheet.Cells[l_row+l_first, 8].Value = double.Parse(dtDetail.Rows[l_row]["ps_credit"].ToString());
						exSheet.Cells[l_row+l_first, 9].Value = double.Parse(dtDetail.Rows[l_row]["total_debit"].ToString());
						exSheet.Cells[l_row+l_first, 10].Value = double.Parse(dtDetail.Rows[l_row]["total_credit"].ToString());
						exSheet.Cells[l_row+l_first, 11].Value = dtDetail.Rows[l_row]["pk"].ToString();
					}
				}
				
		}
		if(dtTK.Rows.Count > 0)//set data vao sheet 1(luon isert date vao sau cung vi ta co' copy sheet 1 cho nhung sheet tao moi. nen phai xua ly' nhu vay)
		{
				p_account_pk=dtTK.Rows[0]["pk"].ToString();
				p_open_dr=double.Parse(dtTK.Rows[0]["open_dr"].ToString());
				p_open_cr=double.Parse(dtTK.Rows[0]["open_cr"].ToString());
				
				acc_code=dtTK.Rows[0]["ac_cd"].ToString();
			    para="'" + p_dtbFrom + "','" + p_dtbTo  + "','" + p_account_pk + "','" + p_open_dr + "' ,'" + p_open_cr + "'";
			    dtDetail = ESysLib.TableReadOpenCursor("ac_sel_gfka00160_dtl_acc_code",para);
				
				if(p_open_cr !=0 || p_open_dr != 0 || dtDetail.Rows.Count > 0)
				{
					exSheet_1.Name=dtTK.Rows[0]["ac_cd"].ToString();;
					//exSheet_1_1.Range[1,1,25,11].Copy(exSheet_1.Range[1,1,25,11], XlPasteType.xlPasteAll);//cope sheet
					exSheet_1.Cells[5, 1].Value = dtTK.Rows[0]["dt_para"].ToString();
					
					exSheet_1.Cells[6, 2].Value = dtTK.Rows[0]["ac_cd"].ToString();
					exSheet_1.Cells[6, 5].Value = dtTK.Rows[0]["ac_nm"].ToString();
					
					exSheet_1.Cells[7, 10].Value = p_ccy;
					
					exSheet_1.Cells[1, 1].Value =dtTK.Rows[0]["partner_name"].ToString();
					exSheet_1.Cells[2, 1].Value =dtTK.Rows[0]["addr1"].ToString();
					exSheet_1.Cells[3, 1].Value = "Mã số thuế: "+dtTK.Rows[0]["tax_code"].ToString();
					
					exSheet_1.Cells[12, 7].Value = double.Parse(dtTK.Rows[0]["open_dr"].ToString());
					exSheet_1.Cells[12, 8].Value = double.Parse(dtTK.Rows[0]["open_cr"].ToString());
					
					exSheet_1.Cells[14, 7].Value = double.Parse(dtTK.Rows[0]["ps_dr"].ToString());//total detail 
					exSheet_1.Cells[14, 8].Value = double.Parse(dtTK.Rows[0]["ps_cr"].ToString());
					
					exSheet_1.Cells[15, 7].Value = double.Parse(dtTK.Rows[0]["end_dr"].ToString());
					exSheet_1.Cells[15, 8].Value = double.Parse(dtTK.Rows[0]["end_cr"].ToString());
					//------------ký, họ tên, đóng dấu------------
					exSheet_1.Cells[19, 1].Value =v1;//lap bieu
					exSheet_1.Cells[19, 4].Value =v2;//ke toan truong
					exSheet_1.Cells[19, 7].Value =v3;//tong giam doc
					//exSheet_1.Cells[19, 7].Value =v4;//Prepared by
					
					exSheet_1.Cells[20, 1].Value =g1;
					exSheet_1.Cells[20, 4].Value =g2;
					exSheet_1.Cells[20, 7].Value =g3;
					//exSheet_1.Cells[20, 7].Value =g4;
					
					exSheet_1.Cells[25, 1].Value =n1;
					exSheet_1.Cells[25, 4].Value =n2;
					exSheet_1.Cells[25, 7].Value =n3;
					//exSheet_1.Cells[25, 7].Value =n4;
					
					//--------------------------
					
					for (int l_addrow_1 = 1; l_addrow_1 < dtDetail.Rows.Count; l_addrow_1++)//add row show with data of table
					{           
						exSheet_1.Range["A14"].Rows.EntireRow.Insert();//insert row new of sheet
					}
					for (int l_row1 =0 ; l_row1 < dtDetail.Rows.Count ; l_row1++)
					{
						int l_first1=13;
						exSheet_1.Cells[l_row1+l_first1, 1].Value = dtDetail.Rows[l_row1]["trans_date"].ToString();
						exSheet_1.Cells[l_row1+l_first1, 2].Value = dtDetail.Rows[l_row1]["voucherno"].ToString();
						exSheet_1.Cells[l_row1+l_first1, 3].Value = dtDetail.Rows[l_row1]["trans_date2"].ToString();
						exSheet_1.Cells[l_row1+l_first1, 4].Value = dtDetail.Rows[l_row1]["remark2"].ToString();
						exSheet_1.Cells[l_row1+l_first1, 5].Value = dtDetail.Rows[l_row1]["remark"].ToString();
						exSheet_1.Cells[l_row1+l_first1, 6].Value = dtDetail.Rows[l_row1]["acct_code"].ToString();
						exSheet_1.Cells[l_row1+l_first1, 7].Value = double.Parse(dtDetail.Rows[l_row1]["ps_debit"].ToString());
						exSheet_1.Cells[l_row1+l_first1, 8].Value = double.Parse(dtDetail.Rows[l_row1]["ps_credit"].ToString());
						exSheet_1.Cells[l_row1+l_first1, 9].Value = double.Parse(dtDetail.Rows[l_row1]["total_debit"].ToString());
						exSheet_1.Cells[l_row1+l_first1, 10].Value = double.Parse(dtDetail.Rows[l_row1]["total_credit"].ToString());
						exSheet_1.Cells[l_row1+l_first1, 11].Value = dtDetail.Rows[l_row1]["pk"].ToString();
					}
				}
				else
				{
					exSheet_1.Cells[4, 1].Value = "No Data!";
					exSheet_1.Cells[6, 2].Value = "Not Account!";
					exSheet_1.Cells[6, 5].Value = "Not Account!";
					exSheet_1.Cells[13, 5].Value = "Not Data!";
				}
		}
		//page setup :xlLandscape and count page in footer,Margin left,right.. and repeat header
		for (int p = 2; p <= exBook.Worksheets.Count; p++) 
				{
					IPageSetup page = exBook.Worksheets[p].PageSetup;
					page.Orientation = XlPageOrientation.xlLandscape;
					page.PaperSize = XlPaperSize.xlPaperA4;
					
					//exBook.Worksheets[p].PageSetup.FitToPagesTall = 1;
					page.CenterFooter = "page &P of &N";//number page
					
					exBook.Worksheets[p].PageSetup.TopMargin = 0.27;
					exBook.Worksheets[p].PageSetup.LeftMargin = 0.17; 
					exBook.Worksheets[p].PageSetup.RightMargin = 0.17;
					exBook.Worksheets[p].PageSetup.BottomMargin = 0.52;
					exBook.Worksheets[p].PageSetup.HeaderMargin = 0.25;
					exBook.Worksheets[p].PageSetup.FooterMargin = 0.5;
					exBook.Worksheets[p].PageSetup.FitToPagesWide = 1;
					exBook.Worksheets[p].PageSetup.PrintTitleColumns = "$1:$12";//repeat header
					
		}
		//end page setup :xlLandscape and count page in footer,Margin left,right.. and repeat header
		//s
		
		
		// Response.Write(para);
		// Response.End();	
		//DataTable dt = ESysLib.TableReadOpenCursor("AC_rpt_60080040_T_socai_viet",para);
		
    		//height=21 style='height:15.75pt'
			
		
		
		
        // end loop detail percent
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        exBook.SaveAs(TempFile);
       // ESysLib.ExcelToPdf(TempFile);
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
