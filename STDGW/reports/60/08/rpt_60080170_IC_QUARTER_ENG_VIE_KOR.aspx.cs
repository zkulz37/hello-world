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

public partial class rpt_60080170_IC_QUARTER_ENG_VIE_KOR : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

         ESysLib.SetUser(Session["APP_DBUSER"].ToString());      
        string TemplateFile = "rpt_60080170_IC_QUARTER_ENG_VIE_KOR.xls";
        string TempFile = "../../../system/temp/rpt_60080170_IC_QUARTER_ENG_VIE_KOR_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);        
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];
        IRange range;
        //bind data to excel file
//=========================================================================================================================================================		
		string l_kind=Request["p_kind"];  
		string l_status=Request["p_status"];
		string l_tco_company_pk=Request["p_tco_company_pk"];
		string l_date_fr=Request["p_date_fr"];
		string l_date_to=Request["p_date_to"];
		string l_date_type=Request["p_date_type"];
		string l_quarter = Request["p_quarter"];
		string l_Scale = Request["p_Scale"];
		string l_ccy = Request["p_ccy"];
		string l_rate = Request["p_rate"];
		string l_month = Request["p_month"];
		string l_lang = Request["p_lang"];
		string l_Color = "";
		string l_Bold = "";	
		
		string l_Scale1 = "";
		if (l_Scale != "1")
		{
			l_Scale1 = Request["p_Scale"];
		}     
		
		 string l_fr_dt="", l_to_dt="", l_cmp_name="", l_cmp_add="", l_cmp_taxcode="", l_to_dt_e="", l_quater="", l_curr_date="", l_last_Date="";
//=========================================================================================================================================================		
		string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE " +
		",to_char(to_date('" + l_date_fr + "','yyyymmdd'),'dd/mm/yyyy') fr_dt,to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd/mm/yyyy') to_dt" +
		",to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd-Mon-yyyy') sign_dt" +
		",decode('" + l_quarter + "','1','I','2','II','3','III','IV')" +
		",to_char(to_date('" + l_date_to + "','yyyymmdd'),'yyyy') curr_date" +
		",TO_CHAR (ADD_MONTHS (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), -12), 'yyyy') last_yyyy" +
		" FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "' ";

		DataTable dt_f = ESysLib.TableReadOpen(SQL1);
		if (dt_f.Rows.Count > 0)
		{
			l_cmp_name = dt_f.Rows[0][0].ToString();
			l_cmp_add = dt_f.Rows[0][1].ToString();
			l_cmp_taxcode = dt_f.Rows[0][3].ToString();
			l_fr_dt = dt_f.Rows[0][4].ToString();
			l_to_dt = dt_f.Rows[0][5].ToString();
			l_to_dt_e = dt_f.Rows[0][6].ToString();
			l_quater = dt_f.Rows[0][7].ToString();
			l_curr_date = dt_f.Rows[0][8].ToString();
			l_last_Date = dt_f.Rows[0][9].ToString();
		}
		
		exSheet.Cells[1,1].Value = l_cmp_name; 
		exSheet.Cells[2,1].Value = l_cmp_add; 
//=========================================================================================================================================================		
		string l_eng_1 = "";
		string l_eng_2 = "";
		string l_eng_3 = "";
		string l_eng_sig_1 = "";
		string l_eng_sig_2 = "";
		string l_eng_sig_3 = "";

		string l_kor_1 = "";
		string l_kor_2 = "";
		string l_kor_3 = "";
		string l_kor_sig_1 = "";
		string l_kor_sig_2 = "";
		string l_kor_sig_3 = "";

		string l_vie_1 = "";
		string l_vie_2 = "";
		string l_vie_3 = "";
		string l_vie_sig_1 = "";
		string l_vie_sig_2 = "";
		string l_vie_sig_3 = "";
		
		string l_name_1 = "";
		string l_name_2 = "";
		string l_name_3 = "";

		string SQL2 = "SELECT   char_1, char_2, char_3, code " +
			"    FROM tac_commcode_master a, tac_commcode_detail b " +
			"   WHERE a.pk = b.tac_commcode_master_pk AND a.ID = 'EACAB031' " +
			"         AND a.del_if = 0 AND b.del_if = 0 AND b.use_yn = 'Y' " +
			"ORDER BY code, b.code_nm ";
			
		DataTable dt_s = ESysLib.TableReadOpen(SQL2);
		if (dt_s.Rows.Count > 0)
		{
			l_eng_1 = dt_s.Rows[0][0].ToString();
			l_eng_2 = dt_s.Rows[0][1].ToString();
			l_eng_3 = dt_s.Rows[0][2].ToString();
			l_eng_sig_1 = dt_s.Rows[1][0].ToString();
			l_eng_sig_2 = dt_s.Rows[1][1].ToString();
			l_eng_sig_3 = dt_s.Rows[1][2].ToString();
			
			l_kor_1 = dt_s.Rows[2][0].ToString();
			l_kor_2 = dt_s.Rows[2][1].ToString();
			l_kor_3 = dt_s.Rows[2][2].ToString();
			l_kor_sig_1 = dt_s.Rows[3][0].ToString();
			l_kor_sig_2 = dt_s.Rows[3][1].ToString();
			l_kor_sig_3 = dt_s.Rows[3][2].ToString();
			
			l_vie_1 = dt_s.Rows[5][0].ToString();
			l_vie_2 = dt_s.Rows[5][1].ToString();
			l_vie_3 = dt_s.Rows[5][2].ToString();
			l_vie_sig_1 = dt_s.Rows[6][0].ToString();
			l_vie_sig_2 = dt_s.Rows[6][1].ToString();
			l_vie_sig_3 = dt_s.Rows[6][2].ToString();
			
			l_name_1 = dt_s.Rows[4][0].ToString();
			l_name_2 = dt_s.Rows[4][1].ToString();
			l_name_3 = dt_s.Rows[4][2].ToString();
		}
		
//=========================================================================================================================================================				
		if(l_lang=="ENG")
		{
			range = exSheet.Range["B1:C1"];
			range.Columns.Hidden = true;
			exSheet.Cells[1,9].Value = "Form: B03 - DN";
			exSheet.Cells["D2"].Value = "(Issued with Decision No. 15/2006/QĐ-BTC";
			exSheet.Cells[3,3].Value = "dated March 20, 2006 by Ministry of Finance)";
			exSheet.Cells[4,1].Value = "INCOME STATEMENT";
			exSheet.Cells[5,1].Value = "Quater "+l_quater+ " Year "+l_curr_date;
			exSheet.Cells[6,1].Value = "From "+l_fr_dt+" to "+l_to_dt;
			exSheet.Cells[7,9].Value = "(Unit: "+l_Scale1+" "+l_ccy+")";
			exSheet.Cells[8,1].Value = "Items";
			exSheet.Cells[8,4].Value = "Code";
			exSheet.Cells[8,5].Value = "Notes";
			exSheet.Cells[8,6].Value = "Quater "+l_quater+"/"+l_curr_date;
			exSheet.Cells["F9"].Value = "This year";
			exSheet.Cells["G9"].Value = "Last year";
			exSheet.Cells["H8"].Value = "Accumulate in this quarter";
			exSheet.Cells["H9"].Value = "This year";
			exSheet.Cells["I9"].Value = "Last year";
			exSheet.Cells["A10"].Value = "1";
			exSheet.Cells["D10"].Value = "2";
			exSheet.Cells["E10"].Value = "3";
			exSheet.Cells["F10"].Value = "4";
			exSheet.Cells["G10"].Value = "5";
			exSheet.Cells["H10"].Value = "6";
			exSheet.Cells["I10"].Value = "7";
			exSheet.Cells["H14"].Value = "At dated "+l_to_dt_e;
			exSheet.Cells["A15"].Value = l_eng_1;
			exSheet.Cells["D15"].Value = l_eng_2;
			exSheet.Cells["H15"].Value = l_eng_3;
			exSheet.Cells["A16"].Value = l_eng_sig_1;
			exSheet.Cells["D16"].Value = l_eng_sig_2;
			exSheet.Cells["H16"].Value = l_eng_sig_3;
			exSheet.Cells["A21"].Value = l_name_1;
			exSheet.Cells["D21"].Value = l_name_2;
			exSheet.Cells["H21"].Value = l_name_3;
		}
		else if(l_lang=="ENG-KOR")
		{
			range = exSheet.Range["B1"];
			range.Columns.Hidden = true;
			exSheet.Cells[1,9].Value = "Form: B03 - DN";
			exSheet.Cells["D2"].Value = "(Issued with Decision No. 15/2006/QĐ-BTC";
			exSheet.Cells[3,3].Value = "dated March 20, 2006 by Ministry of Finance)";
			exSheet.Cells[4,1].Value = "INCOME STATEMENT / 손익계산서";
			exSheet.Cells[5,1].Value = "Quater "+l_quater+ " Year "+l_curr_date;
			exSheet.Cells[6,1].Value = "From / 부터 "+l_fr_dt+" to / 까지 "+l_to_dt;
			exSheet.Cells[7,9].Value = "(Unit / 단위: "+l_Scale1+" "+l_ccy+")";
			exSheet.Cells[8,1].Value = "Items";
			exSheet.Cells[8,3].Value = "항목";
			exSheet.Cells[8,4].Value = "Code / 코드";
			exSheet.Cells[8,5].Value = "Notes";
			exSheet.Cells[9,5].Value = "비고";
			exSheet.Cells[8,6].Value = "Quater "+l_quater+"/"+l_curr_date;
			exSheet.Cells["F9"].Value = "This year";
			exSheet.Cells["G9"].Value = "Last year";
			exSheet.Cells["H8"].Value = "Accumulate in this quarter";
			exSheet.Cells["H9"].Value = "This year";
			exSheet.Cells["I9"].Value = "Last year";
			exSheet.Cells["A10"].Value = "1";
			exSheet.Cells["C10"].Value = "2";
			exSheet.Cells["D10"].Value = "3";
			exSheet.Cells["E10"].Value = "4";
			exSheet.Cells["F10"].Value = "5";
			exSheet.Cells["G10"].Value = "6";
			exSheet.Cells["H10"].Value = "7";
			exSheet.Cells["I10"].Value = "8";
			exSheet.Cells["H14"].Value = "At dated / 현재 "+l_to_dt_e;
			exSheet.Cells["A15"].Value = l_eng_1;
			exSheet.Cells["C15"].Value = l_eng_2;
			exSheet.Cells["H15"].Value = l_eng_3;
			exSheet.Cells["A16"].Value = l_eng_sig_1;
			exSheet.Cells["C16"].Value = l_eng_sig_2;
			exSheet.Cells["H16"].Value = l_eng_sig_3;
			exSheet.Cells["C15","G15"].Merge();
			exSheet.Cells["C16","G16"].Merge();
			exSheet.Cells["C21","G21"].Merge();
			exSheet.Cells["A21"].Value = l_name_1;
			exSheet.Cells["C21"].Value = l_name_2;
			exSheet.Cells["H21"].Value = l_name_3;
		}
		else if(l_lang=="ENG-VIE")
		{
			range = exSheet.Range["C1"];
			range.Columns.Hidden = true;
			exSheet.Cells[1,9].Value = "Form: B03 - DN";
			exSheet.Cells["D2"].Value = "(Issued with Decision No. 15/2006/QĐ-BTC";
			exSheet.Cells[3,3].Value = "dated March 20, 2006 by Ministry of Finance)";
			exSheet.Cells[4,1].Value = "INCOME STATEMENT / BÁO CÁO KẾT QUẢ HOẠT ĐỘNG KINH DOANH";
			exSheet.Cells[5,1].Value = "Quater "+l_quater+ " Year "+l_curr_date+"(Quý "+l_quater+" Năm "+l_curr_date+")";
			exSheet.Cells[6,1].Value = "From / Giai đoạn từ ngày "+l_fr_dt+" to / đến "+l_to_dt;
			exSheet.Cells[7,9].Value = "(Unit / Đơn vị tính: "+l_Scale1+" "+l_ccy+")";
			exSheet.Cells[8,1].Value = "Items";
			exSheet.Cells[8,2].Value = "Chỉ tiêu";
			exSheet.Cells[8,4].Value = "Code / Mã số";
			exSheet.Cells[8,5].Value = "Notes";
			exSheet.Cells[9,5].Value = "Ghi chú";
			exSheet.Cells[8,6].Value = "Quater(Quý) "+l_quater+"/"+l_curr_date;
			exSheet.Cells["F9"].Value = "This year / Năm nay";
			exSheet.Cells["G9"].Value = "Last year / Năm trước";
			exSheet.Cells["H8"].Value = "Accumulate in this quarter";
			exSheet.Cells["H9"].Value = "This year";
			exSheet.Cells["I9"].Value = "Last year";
			exSheet.Cells["A10"].Value = "1";
			exSheet.Cells["B10"].Value = "2";
			exSheet.Cells["D10"].Value = "3";
			exSheet.Cells["E10"].Value = "4";
			exSheet.Cells["F10"].Value = "5";
			exSheet.Cells["G10"].Value = "6";
			exSheet.Cells["H10"].Value = "7";
			exSheet.Cells["I10"].Value = "8";
			exSheet.Cells["H14"].Value = "At dated / Tại ngày "+l_to_dt_e;
			exSheet.Cells["A15"].Value = l_eng_1;
			exSheet.Cells["B15"].Value = l_eng_2;
			exSheet.Cells["H15"].Value = l_eng_3;
			exSheet.Cells["A16"].Value = l_eng_sig_1;
			exSheet.Cells["B16"].Value = l_eng_sig_2;
			exSheet.Cells["H16"].Value = l_eng_sig_3;
			exSheet.Cells["B15","G15"].Merge();
			exSheet.Cells["B16","G16"].Merge();
			exSheet.Cells["B21","G21"].Merge();
			exSheet.Cells["A21"].Value = l_name_1;
			exSheet.Cells["B21"].Value = l_name_2;
			exSheet.Cells["H21"].Value = l_name_3;
		}
		else if(l_lang=="ENG-VIE-KOR")
		{
			exSheet.Cells[1,9].Value = "Form: B03 - DN";
			exSheet.Cells["D2"].Value = "(Issued with Decision No. 15/2006/QĐ-BTC";
			exSheet.Cells[3,3].Value = "dated March 20, 2006 by Ministry of Finance)";
			exSheet.Cells[4,1].Value = "INCOME STATEMENT / BÁO CÁO KẾT QUẢ HOẠT ĐỘNG KINH DOANH/손익계산서";
			exSheet.Cells[5,1].Value = "Quater "+l_quater+ " Year "+l_curr_date;
			exSheet.Cells[6,1].Value = "From / Giai đoạn từ ngày / 부터 "+l_fr_dt+" to / đến / 까지 "+l_to_dt;
			exSheet.Cells[7,9].Value = "(Unit / Đơn vị tính / 단위: "+l_Scale1+" "+l_ccy+")";
			exSheet.Cells[8,1].Value = "Items";
			exSheet.Cells[8,2].Value = "Chỉ tiêu";
			exSheet.Cells[8,3].Value = "항목";
			exSheet.Cells[8,4].Value = "Code";
			exSheet.Cells[8,5].Value = "Notes";
			exSheet.Cells[9,5].Value = "Ghi chú";
			exSheet.Cells[8,6].Value = "Quater(Quý) "+l_quater+"/"+l_curr_date;
			exSheet.Cells["F9"].Value = "This year";
			exSheet.Cells["G9"].Value = "Last year";
			exSheet.Cells["H8"].Value = "Accumulate in this quarter";
			exSheet.Cells["H9"].Value = "This year";
			exSheet.Cells["I9"].Value = "Last year";
			exSheet.Cells["H14"].Value = "At dated / 현재 / Tại ngày "+l_to_dt_e;
			exSheet.Cells["A15"].Value = l_eng_1;
			exSheet.Cells["C15"].Value = l_eng_2;
			exSheet.Cells["H15"].Value = l_eng_3;
			exSheet.Cells["A16"].Value = l_eng_sig_1;
			exSheet.Cells["C16"].Value = l_eng_sig_2;
			exSheet.Cells["H16"].Value = l_eng_sig_3;
			exSheet.Cells["A21"].Value = l_name_1;
			exSheet.Cells["C21"].Value = l_name_2;
			exSheet.Cells["H21"].Value = l_name_3;
		}
		else if(l_lang=="KOR")
		{
			range = exSheet.Range["A1:B1"];
			range.Columns.Hidden = true;
			exSheet.Cells[1,9].Value = "Form: B03 - DN";
			exSheet.Cells["D2"].Value = "(Issued with Decision No. 15/2006/QĐ-BTC";
			exSheet.Cells[3,3].Value = "dated March 20, 2006 by Ministry of Finance)";
			exSheet.Cells[4,1].Value = "손익계산서";
			exSheet.Cells[5,1].Value = "Quater "+l_quater+ " Year "+l_curr_date;
			exSheet.Cells[6,1].Value = "부터 "+l_fr_dt+" 까지 "+l_to_dt;
			exSheet.Cells[7,9].Value = "(단위: "+l_Scale1+" "+l_ccy+")";
			exSheet.Cells[8,3].Value = "항목";
			exSheet.Cells[8,4].Value = "코드";
			exSheet.Cells[8,5].Value = "비고";
			exSheet.Cells[8,6].Value = "Quater "+l_quater+"/"+l_curr_date;
			exSheet.Cells["F9"].Value = "This year";
			exSheet.Cells["G9"].Value = "Last year";
			exSheet.Cells["H8"].Value = "Accumulate in this quarter";
			exSheet.Cells["H9"].Value = "This year";
			exSheet.Cells["I9"].Value = "Last year";
			exSheet.Cells["C10"].Value = "1";
			exSheet.Cells["D10"].Value = "2";
			exSheet.Cells["E10"].Value = "3";
			exSheet.Cells["F10"].Value = "4";
			exSheet.Cells["G10"].Value = "5";
			exSheet.Cells["H10"].Value = "6";
			exSheet.Cells["I10"].Value = "7";
			exSheet.Cells["H14"].Value = "현재 "+l_to_dt_e;
			exSheet.Cells["H14"].Value = "현재 "+l_to_dt_e;
			exSheet.Cells["C15"].Value = l_kor_1;
			exSheet.Cells["D15"].Value = l_kor_2;
			exSheet.Cells["H15"].Value = l_kor_3;
			exSheet.Cells["C16"].Value = l_kor_sig_1;
			exSheet.Cells["D16"].Value = l_kor_sig_2;
			exSheet.Cells["H16"].Value = l_kor_sig_3;
			exSheet.Cells["C21"].Value = l_name_1;
			exSheet.Cells["D21"].Value = l_name_2;
			exSheet.Cells["H21"].Value = l_name_3;
		}
		else if(l_lang=="KOR-VIE")
		{
			range = exSheet.Range["A1"];
			range.Columns.Hidden = true;
			exSheet.Cells[1,9].Value = "Mẫu số: B03 - DN";
			exSheet.Cells["D2"].Value = "(Ban hành theo Quyết định số 15/2006/QĐ-BTC";
			exSheet.Cells[3,3].Value = "Ngày 20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)";
			exSheet.Cells[4,1].Value = "손익계산서 / BÁO CÁO KẾT QUẢ HOẠT ĐỘNG KINH DOANH";
			exSheet.Cells[5,1].Value = "Quý "+l_quater+ " năm "+l_curr_date;
			exSheet.Cells[6,1].Value = "부터 / Giai đoạn từ ngày "+l_fr_dt+" 까지 / đến "+l_to_dt;
			exSheet.Cells[7,9].Value = "(단위 / Đơn vị tính: "+l_Scale1+" "+l_ccy+")";
			exSheet.Cells[8,2].Value = "Chỉ tiêu";
			exSheet.Cells[8,3].Value = "항목";
			exSheet.Cells[8,4].Value = "코드 / Mã số";
			exSheet.Cells[8,5].Value = "비고";
			exSheet.Cells[9,5].Value = "Ghi chú";
			exSheet.Cells[8,6].Value = "Quý "+l_quater+"/"+l_curr_date;
			exSheet.Cells["F9"].Value = "Năm nay";
			exSheet.Cells["G9"].Value = "Năm trước";
			exSheet.Cells["H8"].Value = "Lũy kế từ đầu năm đến cuối quý này";
			exSheet.Cells["H9"].Value = "Năm nay";
			exSheet.Cells["I9"].Value = "Năm trước";
			exSheet.Cells["B10"].Value = "1";
			exSheet.Cells["C10"].Value = "2";
			exSheet.Cells["D10"].Value = "3";
			exSheet.Cells["E10"].Value = "4";
			exSheet.Cells["F10"].Value = "5";
			exSheet.Cells["G10"].Value = "6";
			exSheet.Cells["H10"].Value = "7";
			exSheet.Cells["I10"].Value = "8";
			exSheet.Cells["H14"].Value = "현재 / Tại ngày "+l_to_dt_e;
			exSheet.Cells["B15"].Value = l_kor_1;
			exSheet.Cells["C15"].Value = l_kor_2;
			exSheet.Cells["H15"].Value = l_kor_3;
			exSheet.Cells["B16"].Value = l_kor_sig_1;
			exSheet.Cells["C16"].Value = l_kor_sig_2;
			exSheet.Cells["H16"].Value = l_kor_sig_3;
			exSheet.Cells["C15","G15"].Merge();
			exSheet.Cells["C16","G16"].Merge();
			exSheet.Cells["C21","G21"].Merge();
			exSheet.Cells["B21"].Value = l_name_1;
			exSheet.Cells["C21"].Value = l_name_2;
			exSheet.Cells["H21"].Value = l_name_3;
		}
		else if(l_lang=="VIE")
		{
			range = exSheet.Range["A1"];
			range.Columns.Hidden = true;
			range = exSheet.Range["C1"];
			range.Columns.Hidden = true;
			exSheet.Cells[1,9].Value = "Mẫu số: B03 - DN";
			exSheet.Cells["D2"].Value = "(Ban hành theo Quyết định số 15/2006/QĐ-BTC";
			exSheet.Cells[3,3].Value = "Ngày 20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)";
			exSheet.Cells[4,1].Value = "BÁO CÁO KẾT QUẢ HOẠT ĐỘNG KINH DOANH";
			exSheet.Cells[5,1].Value = "Quý "+l_quater+" Năm "+l_curr_date;
			exSheet.Cells[6,1].Value = "Giai đoạn từ ngày "+l_fr_dt+" đến "+l_to_dt;
			exSheet.Cells[7,9].Value = "(Đơn vị tính: "+l_Scale1+" "+l_ccy+")";
			exSheet.Cells[8,2].Value = "Chỉ tiêu";
			exSheet.Cells[8,4].Value = "Mã số";
			exSheet.Cells[8,5].Value = "Ghi chú";
			exSheet.Cells[8,6].Value = "Quý "+l_quater+"/"+l_curr_date;
			exSheet.Cells["F9"].Value = "Năm nay";
			exSheet.Cells["G9"].Value = "Năm trước";
			exSheet.Cells["H8"].Value = "Lũy kế từ đầu năm đến cuối quý này";
			exSheet.Cells["H9"].Value = "Năm nay";
			exSheet.Cells["I9"].Value = "Năm trước";
			exSheet.Cells["B10"].Value = "1";
			exSheet.Cells["D10"].Value = "2";
			exSheet.Cells["E10"].Value = "3";
			exSheet.Cells["F10"].Value = "4";
			exSheet.Cells["G10"].Value = "5";
			exSheet.Cells["H10"].Value = "6";
			exSheet.Cells["I10"].Value = "7";
			exSheet.Cells["H14"].Value = "Tại ngày "+l_to_dt_e;
			exSheet.Cells["B15"].Value = l_vie_1;
			exSheet.Cells["D15"].Value = l_vie_2;
			exSheet.Cells["H15"].Value = l_vie_3;
			exSheet.Cells["B16"].Value = l_vie_sig_1;
			exSheet.Cells["D16"].Value = l_vie_sig_2;
			exSheet.Cells["H16"].Value = l_vie_sig_3;
			exSheet.Cells["B21"].Value = l_name_1;
			exSheet.Cells["D21"].Value = l_name_2;
			exSheet.Cells["H21"].Value = l_name_3;
		}
//=========================================================================================================================================================		
		string p_bookccy = "";
		string p_xls_ccy_format ="";
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
//=========================================================================================================================================================		
		string l_parameter = "'" + l_kind + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_Scale + "','" + l_ccy + "','" + l_rate + "','" + l_month + "'";
		
		DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60080240_income",l_parameter);
		  
        // Response.Write(dt.Rows.Count);
		// Response.End();
		for (int l_addrow = 1; l_addrow < dt.Rows.Count; l_addrow++)
        {
            exSheet.Range["A12"].Rows.EntireRow.Insert();//insert row new of sheet

        }
		int _row = 11;
        for (int i = 0; i < dt.Rows.Count; i++)
        {
			exSheet.Cells[_row + i, 1].Value = dt.Rows[i]["prn_acnm"].ToString();
			exSheet.Cells[_row + i, 2].Value = dt.Rows[i]["prn_lacnm"].ToString();
			exSheet.Cells[_row + i, 3].Value = dt.Rows[i]["prn_kacnm"].ToString();
			exSheet.Cells[_row + i, 4].Value = dt.Rows[i]["code"].ToString();
			exSheet.Cells[_row + i, 5].Value = dt.Rows[i]["header"].ToString();
			exSheet.Cells[_row + i, 6].Value = decimal.Parse(dt.Rows[i][9].ToString());
			exSheet.Cells[_row + i, 6].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[_row + i, 7].Value = decimal.Parse(dt.Rows[i][10].ToString());
			exSheet.Cells[_row + i, 7].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[_row + i, 8].Value = decimal.Parse(dt.Rows[i][11].ToString());
			exSheet.Cells[_row + i, 8].NumberFormat = p_xls_ccy_format;
			exSheet.Cells[_row + i, 9].Value = decimal.Parse(dt.Rows[i][12].ToString());
			exSheet.Cells[_row + i, 9].NumberFormat = p_xls_ccy_format;
			
			l_Bold = dt.Rows[i]["font_stype"].ToString();
			l_Color = "0X" + dt.Rows[i]["prn_color"].ToString().Substring(6,2) + dt.Rows[i]["prn_color"].ToString().Substring(4,2) + dt.Rows[i]["prn_color"].ToString().Substring(2,2);
			for(int col=0;col<9;col++)
			{
				if(l_Bold=="B")
				{
					exSheet.Cells[_row + i, col + 1].Font.Bold = true;
				}
				Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
				exSheet.Cells[_row + i, col + 1].Interior.Color = colorValueFrmHex;
			}
		}
//=========================================================================================================================================================		
        
		
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
