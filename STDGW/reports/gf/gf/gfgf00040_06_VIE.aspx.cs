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

public partial class gfgf00040_06_VIE : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

           ESysLib.SetUser(Session["APP_DBUSER"].ToString());
        string TemplateFile = "gfgf00040_06_VIE.xls";
        string TempFile = "../../../system/temp/gfgf00040_06_VIE_" + Session["User_ID"].ToString() + ".xls";
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
		string Asset_Type = ""+Request["p_asset_type"];
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
		string para_tk="'" + not_para + "'";//
		DataTable dtTK = ESysLib.TableReadOpenCursor("ac_sel_gfgf00040_all_taikhoan",para_tk);	
		if(AssetAccCode_form !="") //chi print 1 tai khoan
		{				
					para="'" + dtFrom + "','" + dtTo  + "','" + company_pk + "','" + KindCode + "' ,'" + lstDEPT + "','" + Status + "','" + Asset_Type + "','" + AssetAccCode_form + "'";
					dtDetail = ESysLib.TableReadOpenCursor("ac_sel_gfgf00040_dtl_taikhoan",para);
					
					if(dtDetail.Rows.Count > 0)
					{
						exSheet_1.Name=AssetAccCode_form;
						exSheet_1.Cells[5, 1].Value = dtDetail.Rows[0]["print_month"].ToString();
						/*
						exSheet_1.Cells[6, 2].Value = dtTK.Rows[0]["ac_cd"].ToString();
						exSheet_1.Cells[6, 5].Value = dtTK.Rows[0]["ac_nm"].ToString();
						
						exSheet_1.Cells[7, 10].Value = p_ccy;
						*/
						exSheet_1.Cells[1, 1].Value =dtDetail.Rows[0]["partner_name"].ToString();
						exSheet_1.Cells[2, 1].Value =dtDetail.Rows[0]["addr1"].ToString();
						exSheet_1.Cells[3, 1].Value = "Mã số thuế: "+dtDetail.Rows[0]["tax_code"].ToString();
						
						double k_1=0;
						for (int l_addrow_1 = 0; l_addrow_1 < dtDetail.Rows.Count-1; l_addrow_1++)//add row show with data of table
						{           
							exSheet_1.Range[9+l_addrow_1+1,1].Rows.EntireRow.Insert();//insert row new of sheet
						}
						int row_num0=0;
						for (int l_row1 =0 ; l_row1 < dtDetail.Rows.Count ; l_row1++)
						{
							int l_first1=9;
							if(dtDetail.Rows[l_row1]["fa_cd"].ToString()!="")
							{
								row_num0=row_num0+1;
							}
							exSheet_1.Cells[l_row1+l_first1, 1].Value = row_num0;
							exSheet_1.Cells[l_row1+l_first1, 2].Value = dtDetail.Rows[l_row1]["fa_cd"].ToString();
							exSheet_1.Cells[l_row1+l_first1, 3].Value = dtDetail.Rows[l_row1]["fa_nm"].ToString();
							if(dtDetail.Rows[l_row1]["qty"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 4].Value = double.Parse(dtDetail.Rows[l_row1]["qty"].ToString());
							}
							exSheet_1.Cells[l_row1+l_first1, 5].Value = dtDetail.Rows[l_row1]["FA_NM"].ToString();
							exSheet_1.Cells[l_row1+l_first1, 6].Value = dtDetail.Rows[l_row1]["place"].ToString();
							exSheet_1.Cells[l_row1+l_first1, 7].Value = (dtDetail.Rows[l_row1]["LOCATION"].ToString());
							exSheet_1.Cells[l_row1+l_first1, 8].Value = (dtDetail.Rows[l_row1]["fa_use_date"].ToString());
							exSheet_1.Cells[l_row1+l_first1, 9].Value = (dtDetail.Rows[l_row1]["fa_depr_date"].ToString());
							if(dtDetail.Rows[l_row1]["months"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 10].Value = double.Parse(dtDetail.Rows[l_row1]["months"].ToString());
							}
							if(dtDetail.Rows[l_row1]["origin_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 11].Value = double.Parse(dtDetail.Rows[l_row1]["origin_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["begin_acc_amt"].ToString()!="")
							{ 
								exSheet_1.Cells[l_row1+l_first1, 12].Value = double.Parse(dtDetail.Rows[l_row1]["begin_acc_amt"].ToString());
							} 
							if(dtDetail.Rows[l_row1]["begin_remain_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 13].Value = double.Parse(dtDetail.Rows[l_row1]["begin_remain_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["new_pur_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 14].Value = double.Parse(dtDetail.Rows[l_row1]["new_pur_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["sub_acc_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 15].Value = double.Parse(dtDetail.Rows[l_row1]["sub_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["dis_org_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 16].Value = double.Parse(dtDetail.Rows[l_row1]["dis_org_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["dis_acc_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 17].Value = double.Parse(dtDetail.Rows[l_row1]["dis_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["depr_period_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 18].Value = double.Parse(dtDetail.Rows[l_row1]["depr_period_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["end_org_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 19].Value = double.Parse(dtDetail.Rows[l_row1]["end_org_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["end_acc_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 20].Value = double.Parse(dtDetail.Rows[l_row1]["end_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["end_remain_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 21].Value = double.Parse(dtDetail.Rows[l_row1]["end_remain_amt"].ToString());
							}							
							exSheet_1.Cells[l_row1+l_first1, 22].Value = (dtDetail.Rows[l_row1]["depr_acc_cd"].ToString());
							if(dtDetail.Rows[l_row1]["depr_month_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 23].Value = double.Parse(dtDetail.Rows[l_row1]["depr_month_amt"].ToString());
							}	
							exSheet_1.Cells[l_row1+l_first1, 24].Value = dtDetail.Rows[l_row1]["exp_acc_cd"].ToString();
							exSheet_1.Cells[l_row1+l_first1, 25].Value = dtDetail.Rows[l_row1]["depreciated_enddate"].ToString();
							//set color row Total and Sub Total and grand total.
							if(dtDetail.Rows[l_row1]["ord"].ToString()=="" && dtDetail.Rows[l_row1]["depr_yn"].ToString()=="" && dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()=="" && dtDetail.Rows[l_row1]["fa_cd"].ToString()=="")
							{
								string l_Color="0XC0C0C0";
								Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
								exSheet_1.Cells[l_row1+l_first1, 1,l_row1+l_first1, 25].Interior.Color = colorValueFrmHex;//set color grand total
								exSheet_1.Cells[l_row1+l_first1,1].Value="";//ko xuat hien row num
								exSheet_1.Cells[l_row1+l_first1,2].Value="Grand total:";
							}
							if(dtDetail.Rows[l_row1]["ord"].ToString()=="" && dtDetail.Rows[l_row1]["depr_yn"].ToString()!="" && dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()=="" && dtDetail.Rows[l_row1]["fa_cd"].ToString()=="")
							{
								string l_Color1="0XD8D8D8";
								Color colorValueFrmHex1 = ColorTranslator.FromHtml(l_Color1);
								exSheet_1.Cells[l_row1+l_first1, 1,l_row1+l_first1, 25].Interior.Color = colorValueFrmHex1;//set color  total
								exSheet_1.Cells[l_row1+l_first1,1].Value="";//ko xuat hien row num
								exSheet_1.Cells[l_row1+l_first1,2].Value="Total:";
							}
							if(dtDetail.Rows[l_row1]["ord"].ToString()!="" && dtDetail.Rows[l_row1]["depr_yn"].ToString()!="" && dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()!="" && dtDetail.Rows[l_row1]["fa_cd"].ToString()=="")
							{
								string l_Color3="0X99CCFF";
								Color colorValueFrmHex3 = ColorTranslator.FromHtml(l_Color3);
								exSheet_1.Cells[l_row1+l_first1, 1,l_row1+l_first1, 25].Interior.Color = colorValueFrmHex3;//set color sub total
								exSheet_1.Cells[l_row1+l_first1,1].Value="";//ko xuat hien row num
								exSheet_1.Cells[l_row1+l_first1,2].Value="Sub total:";
								for (int l_grp_nm =0 ; l_grp_nm < dtKindGroupName.Rows.Count ; l_grp_nm++)
									{
										string l_code_grp_kind=dtKindGroupName.Rows[l_grp_nm]["CODE"].ToString();
										string l_name_grp_kind=dtKindGroupName.Rows[l_grp_nm]["CODE_NM"].ToString();
										if(dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()==l_code_grp_kind)
										{
											exSheet_1.Cells[l_row1+l_first1,3].Value=l_name_grp_kind;
										}
									}
							}
							//end set color row Total and Sub Total and grand total.	
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
		else //print nhieu tai khoan
		{	
			for(int i=1;i<dtTK.Rows.Count;i++)//
			{					
					acc_code=dtTK.Rows[i]["AC_CODE"].ToString();//tham so nay la lay tu store procedure all tai khoan(ac_sel_gfgf00040_all_taikhoan) de truyen xuong store detail (ac_sel_gfgf00040_dtl_taikhoan) voi dkien theo tung tab
					para="'" + dtFrom + "','" + dtTo  + "','" + company_pk + "','" + KindCode + "' ,'" + lstDEPT + "','" + Status + "','" + Asset_Type + "','" + acc_code + "'";
					
					dtDetail = ESysLib.TableReadOpenCursor("ac_sel_gfgf00040_dtl_taikhoan",para);
					if(dtDetail.Rows.Count > 0)
					{
						IWorksheet exSheet = exBook.Worksheets.Add();
						exSheet.Name=dtTK.Rows[i]["AC_CODE"].ToString();;
						exSheet_1.Range[1,1,12,25].Copy(exSheet.Range[1,1,12,25], XlPasteType.xlPasteAll);//cope sheet
						
						exSheet.Cells[5, 1].Value = dtDetail.Rows[0]["print_month"].ToString();
						/*
						exSheet.Cells[6, 2].Value = dtTK.Rows[i]["ac_cd"].ToString();
						exSheet.Cells[6, 5].Value = dtTK.Rows[i]["ac_nm"].ToString();
						
						exSheet.Cells[7, 10].Value = p_ccy;
						*/
						exSheet.Cells[1, 1].Value =dtDetail.Rows[0]["partner_name"].ToString();
						exSheet.Cells[2, 1].Value =dtDetail.Rows[0]["addr1"].ToString();
						exSheet.Cells[3, 1].Value = "Mã số thuế: "+dtDetail.Rows[0]["tax_code"].ToString();
						
						for (int l_addrow = 0; l_addrow < dtDetail.Rows.Count-1; l_addrow++)//add row show with data of table
						{           
							exSheet.Range[9+l_addrow+1,1].Rows.EntireRow.Insert();//insert row new of sheet
						}
						int row_num=0;
						for (int l_row =0 ; l_row < dtDetail.Rows.Count ; l_row++)
						{
							int l_first=9;
							if(dtDetail.Rows[l_row]["fa_cd"].ToString()!="")
							{
								row_num=row_num+1;
							}
							exSheet.Cells[l_row+l_first, 1].Value = row_num;
							exSheet.Cells[l_row+l_first, 2].Value = dtDetail.Rows[l_row]["fa_cd"].ToString();
							exSheet.Cells[l_row+l_first, 3].Value = dtDetail.Rows[l_row]["fa_nm"].ToString();
							if(dtDetail.Rows[l_row]["qty"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 4].Value = double.Parse(dtDetail.Rows[l_row]["qty"].ToString());
							}
							exSheet.Cells[l_row+l_first, 5].Value = dtDetail.Rows[l_row]["FA_NM"].ToString();
							exSheet.Cells[l_row+l_first, 6].Value = dtDetail.Rows[l_row]["place"].ToString();
							exSheet.Cells[l_row+l_first, 7].Value = (dtDetail.Rows[l_row]["LOCATION"].ToString());
							exSheet.Cells[l_row+l_first, 8].Value = (dtDetail.Rows[l_row]["fa_use_date"].ToString());
							exSheet.Cells[l_row+l_first, 9].Value = (dtDetail.Rows[l_row]["fa_depr_date"].ToString());
							if(dtDetail.Rows[l_row]["months"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 10].Value = double.Parse(dtDetail.Rows[l_row]["months"].ToString());
							}
							if(dtDetail.Rows[l_row]["origin_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 11].Value = double.Parse(dtDetail.Rows[l_row]["origin_amt"].ToString());
							}
							if(dtDetail.Rows[l_row]["begin_acc_amt"].ToString()!="") 
							{
								exSheet.Cells[l_row+l_first, 12].Value = double.Parse(dtDetail.Rows[l_row]["begin_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row]["begin_remain_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 13].Value = double.Parse(dtDetail.Rows[l_row]["begin_remain_amt"].ToString());
							}
							if(dtDetail.Rows[l_row]["new_pur_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 14].Value = double.Parse(dtDetail.Rows[l_row]["new_pur_amt"].ToString());
							}
							if(dtDetail.Rows[l_row]["sub_acc_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 15].Value = double.Parse(dtDetail.Rows[l_row]["sub_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row]["dis_org_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 16].Value = double.Parse(dtDetail.Rows[l_row]["dis_org_amt"].ToString());
							}
							if(dtDetail.Rows[l_row]["dis_acc_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 17].Value = double.Parse(dtDetail.Rows[l_row]["dis_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row]["depr_period_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 18].Value = double.Parse(dtDetail.Rows[l_row]["depr_period_amt"].ToString());
							}
							if(dtDetail.Rows[l_row]["end_org_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 19].Value = double.Parse(dtDetail.Rows[l_row]["end_org_amt"].ToString());
							}
							if(dtDetail.Rows[l_row]["end_acc_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 20].Value = double.Parse(dtDetail.Rows[l_row]["end_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row]["end_remain_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 21].Value = double.Parse(dtDetail.Rows[l_row]["end_remain_amt"].ToString());
							}							
							exSheet.Cells[l_row+l_first, 22].Value = (dtDetail.Rows[l_row]["depr_acc_cd"].ToString());
							if(dtDetail.Rows[l_row]["depr_month_amt"].ToString()!="")
							{
								exSheet.Cells[l_row+l_first, 23].Value = double.Parse(dtDetail.Rows[l_row]["depr_month_amt"].ToString());
							}							
							exSheet.Cells[l_row+l_first, 24].Value = dtDetail.Rows[l_row]["exp_acc_cd"].ToString(); 
							exSheet.Cells[l_row+l_first, 25].Value = dtDetail.Rows[l_row]["depreciated_enddate"].ToString();
							//set color row Total and Sub Total and grand total.
							if(dtDetail.Rows[l_row]["ord"].ToString()=="" && dtDetail.Rows[l_row]["depr_yn"].ToString()=="" && dtDetail.Rows[l_row]["fa_kind_cd"].ToString()=="" && dtDetail.Rows[l_row]["fa_cd"].ToString()=="")
							{
								string l_Color="0XC0C0C0";
								Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
								exSheet.Cells[l_row+l_first, 1,l_row+l_first, 25].Interior.Color = colorValueFrmHex;//set color grand total
								exSheet.Cells[l_row+l_first,1].Value="";//ko xuat hien row num
								exSheet.Cells[l_row+l_first,2].Value="Grand total:";
							}
							if(dtDetail.Rows[l_row]["ord"].ToString()=="" && dtDetail.Rows[l_row]["depr_yn"].ToString()!="" && dtDetail.Rows[l_row]["fa_kind_cd"].ToString()=="" && dtDetail.Rows[l_row]["fa_cd"].ToString()=="")
							{
								string l_Color1="0XD8D8D8";
								Color colorValueFrmHex1 = ColorTranslator.FromHtml(l_Color1);
								exSheet.Cells[l_row+l_first, 1,l_row+l_first, 25].Interior.Color = colorValueFrmHex1;//set color  total
								exSheet.Cells[l_row+l_first,1].Value="";//ko xuat hien row num
								exSheet.Cells[l_row+l_first,2].Value="Total:";
							}
							if(dtDetail.Rows[l_row]["ord"].ToString()!="" && dtDetail.Rows[l_row]["depr_yn"].ToString()!="" && dtDetail.Rows[l_row]["fa_kind_cd"].ToString()!="" && dtDetail.Rows[l_row]["fa_cd"].ToString()=="")
							{
								string l_Color3="0X99CCFF";
								Color colorValueFrmHex3 = ColorTranslator.FromHtml(l_Color3);
								exSheet.Cells[l_row+l_first, 1,l_row+l_first, 25].Interior.Color = colorValueFrmHex3;//set color sub total
								exSheet.Cells[l_row+l_first,1].Value="";//ko xuat hien row num
								exSheet.Cells[l_row+l_first,2].Value="Sub total:";
								for (int l_grp_nm =0 ; l_grp_nm < dtKindGroupName.Rows.Count ; l_grp_nm++)
									{
										string l_code_grp_kind=dtKindGroupName.Rows[l_grp_nm]["CODE"].ToString();
										string l_name_grp_kind=dtKindGroupName.Rows[l_grp_nm]["CODE_NM"].ToString();
										if(dtDetail.Rows[l_row]["fa_kind_cd"].ToString()==l_code_grp_kind)
										{
											exSheet.Cells[l_row+l_first,3].Value=l_name_grp_kind;
										}
									}
							}
							//end set color row Total and Sub Total and grand total.
						}
						range = exSheet.Range["E1"];
						range.Columns.Hidden = true;
					}
					
			}
			if(dtTK.Rows.Count > 0)//set data vao sheet 1(luon isert date vao sau cung vi ta co' copy sheet 1 cho nhung sheet tao moi. nen phai xua ly' nhu vay)
			{
					acc_code=dtTK.Rows[0]["AC_CODE"].ToString();//tham so nay la lay tu store procedure all tai khoan(ac_sel_gfgf00040_all_taikhoan) de truyen xuong store detail (ac_sel_gfgf00040_dtl_taikhoan) voi dkien theo tung tab
					para="'" + dtFrom + "','" + dtTo  + "','" + company_pk + "','" + KindCode + "' ,'" + lstDEPT + "','" + Status + "','" + Asset_Type + "','" + acc_code + "'";
					dtDetail = ESysLib.TableReadOpenCursor("ac_sel_gfgf00040_dtl_taikhoan",para);
					
					if(dtDetail.Rows.Count > 0)
					{
						exSheet_1.Name=dtTK.Rows[0]["AC_CODE"].ToString();;
						exSheet_1.Cells[5, 1].Value = dtDetail.Rows[0]["print_month"].ToString();
						
						/*exSheet_1.Cells[6, 2].Value = dtTK.Rows[0]["ac_cd"].ToString();
						exSheet_1.Cells[6, 5].Value = dtTK.Rows[0]["ac_nm"].ToString();
						
						exSheet_1.Cells[7, 10].Value = p_ccy;
						*/
						exSheet_1.Cells[1, 1].Value =dtDetail.Rows[0]["partner_name"].ToString();
						exSheet_1.Cells[2, 1].Value =dtDetail.Rows[0]["addr1"].ToString();
						exSheet_1.Cells[3, 1].Value = "Mã số thuế: "+dtDetail.Rows[0]["tax_code"].ToString();
						
						for (int l_addrow_1 = 0; l_addrow_1 < dtDetail.Rows.Count-1; l_addrow_1++)//add row show with data of table
						{           
							exSheet_1.Range[9+l_addrow_1+1,1].Rows.EntireRow.Insert();//insert row new of sheet
						}
						int row_num2=0;
						for (int l_row1 =0 ; l_row1 < dtDetail.Rows.Count ; l_row1++)
						{
							int l_first1=9;
							if(dtDetail.Rows[l_row1]["fa_cd"].ToString()!="")
							{
								row_num2=row_num2+1;
							}
							exSheet_1.Cells[l_row1+l_first1, 1].Value = row_num2;
							exSheet_1.Cells[l_row1+l_first1, 2].Value = dtDetail.Rows[l_row1]["fa_cd"].ToString();
							exSheet_1.Cells[l_row1+l_first1, 3].Value = dtDetail.Rows[l_row1]["fa_nm"].ToString();
							if(dtDetail.Rows[l_row1]["qty"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 4].Value = double.Parse(dtDetail.Rows[l_row1]["qty"].ToString());
							}
							exSheet_1.Cells[l_row1+l_first1, 5].Value = dtDetail.Rows[l_row1]["FA_NM"].ToString();
							exSheet_1.Cells[l_row1+l_first1, 6].Value = dtDetail.Rows[l_row1]["place"].ToString();
							exSheet_1.Cells[l_row1+l_first1, 7].Value = (dtDetail.Rows[l_row1]["LOCATION"].ToString());
							exSheet_1.Cells[l_row1+l_first1, 8].Value = (dtDetail.Rows[l_row1]["fa_use_date"].ToString());
							exSheet_1.Cells[l_row1+l_first1, 9].Value = (dtDetail.Rows[l_row1]["fa_depr_date"].ToString());
							if(dtDetail.Rows[l_row1]["months"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 10].Value = double.Parse(dtDetail.Rows[l_row1]["months"].ToString());
							}
							if(dtDetail.Rows[l_row1]["origin_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 11].Value = double.Parse(dtDetail.Rows[l_row1]["origin_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["begin_acc_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 12].Value = double.Parse(dtDetail.Rows[l_row1]["begin_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["begin_remain_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 13].Value = double.Parse(dtDetail.Rows[l_row1]["begin_remain_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["new_pur_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 14].Value = double.Parse(dtDetail.Rows[l_row1]["new_pur_amt"].ToString());
							} 
							if(dtDetail.Rows[l_row1]["sub_acc_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 15].Value = double.Parse(dtDetail.Rows[l_row1]["sub_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["dis_org_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 16].Value = double.Parse(dtDetail.Rows[l_row1]["dis_org_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["dis_acc_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 17].Value = double.Parse(dtDetail.Rows[l_row1]["dis_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["depr_period_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 18].Value = double.Parse(dtDetail.Rows[l_row1]["depr_period_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["end_org_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 19].Value = double.Parse(dtDetail.Rows[l_row1]["end_org_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["end_acc_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 20].Value = double.Parse(dtDetail.Rows[l_row1]["end_acc_amt"].ToString());
							}
							if(dtDetail.Rows[l_row1]["end_remain_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 21].Value = double.Parse(dtDetail.Rows[l_row1]["end_remain_amt"].ToString());
							}							
							exSheet_1.Cells[l_row1+l_first1, 22].Value = (dtDetail.Rows[l_row1]["depr_acc_cd"].ToString());
							if(dtDetail.Rows[l_row1]["depr_month_amt"].ToString()!="")
							{
								exSheet_1.Cells[l_row1+l_first1, 23].Value = double.Parse(dtDetail.Rows[l_row1]["depr_month_amt"].ToString());
							}
							exSheet_1.Cells[l_row1+l_first1, 24].Value = dtDetail.Rows[l_row1]["exp_acc_cd"].ToString();
							exSheet_1.Cells[l_row1+l_first1, 25].Value = dtDetail.Rows[l_row1]["depreciated_enddate"].ToString();
							//set color row Total and Sub Total and grand total.
							if(dtDetail.Rows[l_row1]["ord"].ToString()=="" && dtDetail.Rows[l_row1]["depr_yn"].ToString()=="" && dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()=="" && dtDetail.Rows[l_row1]["fa_cd"].ToString()=="")
							{
								string l_Color="0XC0C0C0";
								Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
								exSheet_1.Cells[l_row1+l_first1, 1,l_row1+l_first1, 25].Interior.Color = colorValueFrmHex;//set color grand total
								exSheet_1.Cells[l_row1+l_first1,1].Value="";//ko xuat hien row num
								exSheet_1.Cells[l_row1+l_first1,2].Value="Grand total:";
							}
							if(dtDetail.Rows[l_row1]["ord"].ToString()=="" && dtDetail.Rows[l_row1]["depr_yn"].ToString()!="" && dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()=="" && dtDetail.Rows[l_row1]["fa_cd"].ToString()=="")
							{
								string l_Color1="0XD8D8D8";
								Color colorValueFrmHex1 = ColorTranslator.FromHtml(l_Color1);
								exSheet_1.Cells[l_row1+l_first1, 1,l_row1+l_first1, 25].Interior.Color = colorValueFrmHex1;//set color  total
								exSheet_1.Cells[l_row1+l_first1,1].Value="";//ko xuat hien row num
								exSheet_1.Cells[l_row1+l_first1,2].Value="Total:";
							}
							if(dtDetail.Rows[l_row1]["ord"].ToString()!="" && dtDetail.Rows[l_row1]["depr_yn"].ToString()!="" && dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()!="" && dtDetail.Rows[l_row1]["fa_cd"].ToString()=="")
							{
								string l_Color3="0X99CCFF";
								Color colorValueFrmHex3 = ColorTranslator.FromHtml(l_Color3);
								exSheet_1.Cells[l_row1+l_first1, 1,l_row1+l_first1, 25].Interior.Color = colorValueFrmHex3;//set color sub total
								exSheet_1.Cells[l_row1+l_first1,1].Value="";//ko xuat hien row num
								exSheet_1.Cells[l_row1+l_first1,2].Value="Sub total:";
								for (int l_grp_nm =0 ; l_grp_nm < dtKindGroupName.Rows.Count ; l_grp_nm++)
									{
										string l_code_grp_kind=dtKindGroupName.Rows[l_grp_nm]["CODE"].ToString();
										string l_name_grp_kind=dtKindGroupName.Rows[l_grp_nm]["CODE_NM"].ToString();
										if(dtDetail.Rows[l_row1]["fa_kind_cd"].ToString()==l_code_grp_kind)
										{
											exSheet_1.Cells[l_row1+l_first1,3].Value=l_name_grp_kind;
										}
									}
							}
							//end set color row Total and Sub Total and grand total.
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
		}
		//page setup :xlLandscape and count page in footer,Margin left,right.. and repeat header
		for (int p = 2; p <= exBook.Worksheets.Count; p++) 
				{
					IPageSetup page = exBook.Worksheets[p].PageSetup;
					page.Orientation = XlPageOrientation.xlLandscape;
					page.PaperSize = XlPaperSize.xlPaperA4;
					
					//exBook.Worksheets[p].PageSetup.FitToPagesTall = 1;
					page.CenterFooter = "page &P of &N";//number page
					
					exBook.Worksheets[p].PageSetup.TopMargin = 0.51;
					exBook.Worksheets[p].PageSetup.LeftMargin = 0.17; 
					exBook.Worksheets[p].PageSetup.RightMargin = 0;
					exBook.Worksheets[p].PageSetup.BottomMargin = 0.24;
					exBook.Worksheets[p].PageSetup.HeaderMargin = 0.5;
					exBook.Worksheets[p].PageSetup.FooterMargin = 0.25;
					exBook.Worksheets[p].PageSetup.FitToPagesWide = 1;
					exBook.Worksheets[p].PageSetup.PrintTitleColumns = "$1:$8";//repeat header
					
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
