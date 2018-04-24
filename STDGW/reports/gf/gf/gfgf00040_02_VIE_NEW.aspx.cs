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

public partial class gfgf00040_02_VIE_NEW : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //ESysLib.SetUser(Session["APP_DBUSER"].ToString()); 
		ESysLib.SetUser("acnt");	
        string TemplateFile = "gfgf00040_02_VIE_NEW.xls";
        string TempFile = "../../../system/temp/gfgf00040_02_VIE_NEW_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
		//DataTable dt = ESysLib.TableReadOpenCursor("AC_rpt_60080040_T_socai_viet",para);
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
		
        IWorksheet exSheet_1 = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
		string dtFrom = ""+Request["dtFrom"];
		string dtTo = ""+Request["dtTo"];
		string company_pk= ""+Request["company_pk"];
		string KindCode = ""+Request["KindCode"];
		string lstDEPT = ""+Request["DeptPK"];
		string Status = ""+Request["Status"];
		string Asset_Type = ""+Request["Asset_Type"];
		string AssetAccCode_form = ""+Request["AssetAccCode"];//para nay null thi print nhieu tai khoan,nguoc lai chi print 1 tai khoan	
		string not_para="";
		string acc_code = "";
		DataTable dtDetail;
		string para="";
		string SQL="";
		//SQL nay de xuat name cua tung group kind code
		SQL = " SELECT CODE, CODE_NM  FROM TCO_ABCODE A, TCO_ABCODEGRP B";
		SQL += "  WHERE A.TCO_ABCODEGRP_PK =b.pk and b.id ='ACDF0010'";
		SQL += " and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 order by a.DEF_YN desc , ord ";
		DataTable dtKindGroupName = ESysLib.TableReadOpen(SQL);
	//end SQL nay de xuat name cua tung group kind code
	//   
			para="'" + dtFrom + "','" + dtTo  + "','" + company_pk + "','" + KindCode + "' ,'" + lstDEPT + "','" + Status + "','" + Asset_Type + "','" + AssetAccCode_form + "'";
			//exSheet_1.Cells[5, 1].Value =para;
			// Response.Write(para);
			// Response.End();
			dtDetail = ESysLib.TableReadOpenCursor("ac_sel_gfgf00040_02_vie_new_bk",para);
			
			for (int l_addrow_1 = 0; l_addrow_1 < dtDetail.Rows.Count-1; l_addrow_1++)//add row show with data of table
			{           
				exSheet_1.Range[9+l_addrow_1+1,1].Rows.EntireRow.Insert();//insert row new of sheet
			}
			if(dtDetail.Rows.Count > 0)//set data vao sheet 1(luon isert date vao sau cung vi ta co' copy sheet 1 cho nhung sheet tao moi. nen phai xua ly' nhu vay)
			{					
					
				//exSheet_1.Name=dtTK.Rows[0]["AC_CODE"].ToString();;
				//exSheet_1.Cells[5, 1].Value = dtDetail.Rows[0]["month_from_to"].ToString();
				
				/*exSheet_1.Cells[6, 2].Value = dtTK.Rows[0]["ac_cd"].ToString();
				exSheet_1.Cells[6, 5].Value = dtTK.Rows[0]["ac_nm"].ToString();
				
				exSheet_1.Cells[7, 10].Value = p_ccy;*/
				exSheet_1.Cells[5, 1].Value = dtDetail.Rows[0]["print_month"].ToString();
				exSheet_1.Cells[1, 1].Value =dtDetail.Rows[0]["partner_name"].ToString();
				exSheet_1.Cells[2, 1].Value =dtDetail.Rows[0]["addr1"].ToString();
				exSheet_1.Cells[3, 1].Value = "Mã số thuế: "+dtDetail.Rows[0]["tax_code"].ToString();
				exSheet_1.Cells[7, 12].Value = "Số đầu kỳ ("+dtFrom.Substring(4, 2)+"/"+dtFrom.Substring(0, 4)+")";
				int row_num=0;
				for (int l_row1 =0 ; l_row1 < dtDetail.Rows.Count ; l_row1++)
				{
					if(dtDetail.Rows[l_row1]["fa_cd"].ToString()!="")
					{
						row_num=row_num+1;
					}
					int l_first1=9;
					exSheet_1.Cells[l_row1+l_first1, 1].Value = dtDetail.Rows[l_row1]["depr_yn"].ToString();
					exSheet_1.Cells[l_row1+l_first1, 2].Value = row_num;//l_row1+1;
					exSheet_1.Cells[l_row1+l_first1, 3].Value = dtDetail.Rows[l_row1]["fa_cd"].ToString();
					exSheet_1.Cells[l_row1+l_first1, 4].Value = dtDetail.Rows[l_row1]["fa_nm"].ToString();
					if(dtDetail.Rows[l_row1]["qty"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 5].Value = double.Parse(dtDetail.Rows[l_row1]["qty"].ToString());
					}
					//exSheet_1.Cells[l_row1+l_first1, 5].Value = dtDetail.Rows[l_row1]["FA_LNM"].ToString();
					exSheet_1.Cells[l_row1+l_first1, 7].Value = dtDetail.Rows[l_row1]["place"].ToString();
					exSheet_1.Cells[l_row1+l_first1, 8].Value = (dtDetail.Rows[l_row1]["LOCATION"].ToString());
					exSheet_1.Cells[l_row1+l_first1, 9].Value = (dtDetail.Rows[l_row1]["fa_use_date"].ToString());
					exSheet_1.Cells[l_row1+l_first1, 10].Value = (dtDetail.Rows[l_row1]["fa_depr_date"].ToString());
					if(dtDetail.Rows[l_row1]["months"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 11].Value = double.Parse(dtDetail.Rows[l_row1]["months"].ToString());
					}
					if(dtDetail.Rows[l_row1]["origin_amt"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 12].Value = double.Parse(dtDetail.Rows[l_row1]["origin_amt"].ToString());
					}
					if(dtDetail.Rows[l_row1]["begin_acc_amt"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 13].Value = double.Parse(dtDetail.Rows[l_row1]["begin_acc_amt"].ToString());
					}
					if(dtDetail.Rows[l_row1]["begin_remain_amt"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 14].Value = double.Parse(dtDetail.Rows[l_row1]["begin_remain_amt"].ToString());
					}
					if(dtDetail.Rows[l_row1]["new_pur_amt"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 15].Value = double.Parse(dtDetail.Rows[l_row1]["new_pur_amt"].ToString());
					}
					if(dtDetail.Rows[l_row1]["sub_acc_amt"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 16].Value = double.Parse(dtDetail.Rows[l_row1]["sub_acc_amt"].ToString()); 
					}
					if(dtDetail.Rows[l_row1]["dis_org_amt"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 17].Value = double.Parse(dtDetail.Rows[l_row1]["dis_org_amt"].ToString());
					}
					if(dtDetail.Rows[l_row1]["dis_acc_amt"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 18].Value = double.Parse(dtDetail.Rows[l_row1]["dis_acc_amt"].ToString());
					}
					if(dtDetail.Rows[l_row1]["depr_period_amt"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 19].Value = double.Parse(dtDetail.Rows[l_row1]["depr_period_amt"].ToString());
					}
					if(dtDetail.Rows[l_row1]["end_org_amt"].ToString()!="")  
					{
						exSheet_1.Cells[l_row1+l_first1, 20].Value = double.Parse(dtDetail.Rows[l_row1]["end_org_amt"].ToString());
					}
					if(dtDetail.Rows[l_row1]["end_acc_amt"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 21].Value = double.Parse(dtDetail.Rows[l_row1]["end_acc_amt"].ToString());
					}
					if(dtDetail.Rows[l_row1]["end_remain_amt"].ToString()!="") 
					{
						exSheet_1.Cells[l_row1+l_first1, 22].Value = double.Parse(dtDetail.Rows[l_row1]["end_remain_amt"].ToString());
					}							
					exSheet_1.Cells[l_row1+l_first1, 23].Value = (dtDetail.Rows[l_row1]["depr_acc_cd"].ToString());
					if(dtDetail.Rows[l_row1]["depr_month_amt"].ToString()!="")
					{
						exSheet_1.Cells[l_row1+l_first1, 24].Value = double.Parse(dtDetail.Rows[l_row1]["depr_month_amt"].ToString());
					}
					exSheet_1.Cells[l_row1+l_first1, 25].Value = dtDetail.Rows[l_row1]["exp_acc_cd"].ToString();
					//exSheet_1.Cells[l_row1+l_first1, 25].Value = dtDetail.Rows[l_row1]["depreciated_enddate"].ToString();
					//set color row Total and Sub Total.
					if(dtDetail.Rows[l_row1]["ord"].ToString()=="" && dtDetail.Rows[l_row1]["depr_yn"].ToString()=="" && dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()=="" && dtDetail.Rows[l_row1]["fa_cd"].ToString()=="")
					{
						string l_Color="0XFF66CC";//0XC0C0C0
						Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
						exSheet_1.Cells[l_row1+l_first1, 1,l_row1+l_first1, 26].Interior.Color = colorValueFrmHex;//set color grand total
						exSheet_1.Cells[l_row1+l_first1,2].Value="";//ko xuat hien row num
						exSheet_1.Cells[l_row1+l_first1,3].Value="Grand total:";
						exSheet_1.Cells[l_row1+l_first1,11].Value="";
					}
					if(dtDetail.Rows[l_row1]["ord"].ToString()=="" && dtDetail.Rows[l_row1]["depr_yn"].ToString()!="" && dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()=="" && dtDetail.Rows[l_row1]["fa_cd"].ToString()=="")
					{
						string l_Color1="0XFFCC00";
						Color colorValueFrmHex1 = ColorTranslator.FromHtml(l_Color1);
						exSheet_1.Cells[l_row1+l_first1, 1,l_row1+l_first1, 26].Interior.Color = colorValueFrmHex1;//set color  total
						exSheet_1.Cells[l_row1+l_first1,2].Value="";//ko xuat hien row num
						exSheet_1.Cells[l_row1+l_first1,3].Value="Total:";
						exSheet_1.Cells[l_row1+l_first1,11].Value="";
					}
					if(dtDetail.Rows[l_row1]["ord"].ToString()!="" && dtDetail.Rows[l_row1]["depr_yn"].ToString()!="" && dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()!="" && dtDetail.Rows[l_row1]["fa_cd"].ToString()=="")
					{
						string l_Color3="0X99CCFF";
						Color colorValueFrmHex3 = ColorTranslator.FromHtml(l_Color3);
						exSheet_1.Cells[l_row1+l_first1, 1,l_row1+l_first1, 26].Interior.Color = colorValueFrmHex3;//set color sub total
						exSheet_1.Cells[l_row1+l_first1,2].Value="";//ko xuat hien row num
						exSheet_1.Cells[l_row1+l_first1,3].Value="Sub total:";
						exSheet_1.Cells[l_row1+l_first1,11].Value="";
						for (int l_grp_nm =0 ; l_grp_nm < dtKindGroupName.Rows.Count ; l_grp_nm++)
							{
								string l_code_grp_kind=dtKindGroupName.Rows[l_grp_nm]["CODE"].ToString();
								string l_name_grp_kind=dtKindGroupName.Rows[l_grp_nm]["CODE_NM"].ToString();
								if(dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()==l_code_grp_kind)
								{
									exSheet_1.Cells[l_row1+l_first1,4].Value=l_name_grp_kind;
								}
							}
					}
					
					
				}
				/*string l_Color2="0XFFCC00 ";
				Color colorValueFrmHex2 = ColorTranslator.FromHtml(l_Color2);
				exSheet_1.Cells[9, 1,9, 26].Interior.Color = colorValueFrmHex2;//set color total*/	
			}
		
		//page setup :xlLandscape and count page in footer,Margin left,right.. and repeat header
		
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
