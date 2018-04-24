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

public partial class rpt_60081341_02 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		string l_company_pk = Request["company_pk"];
		string l_acc_pk = Request["acc_pk"];
		string l_plc_pk = Request["plc_pk"];
		string l_pl_pk = Request["pl_pk"];
		string l_month = Request["month"];  
		string l_status = Request["status"];
		string l_fs = Request["fs"];
		string l_report = Request["report"];
		string l_lang = Request["lang"];		
		string l_cmp_name = "";
		string l_title = "";
		string l_ccy = "";
        string TemplateFile = "rpt_60081341_02.xls";
        string TempFile = "../../../system/temp/rpt_60081341_02_" + Session["User_ID"].ToString() + ".xls";
		
	   TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
        //Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;
	   
	   if(l_lang=="ENG")
	   {
			range = exSheet.Range["C1:D1"];
			range.Columns.Hidden = true;
	   }
	   else if(l_lang=="VIE")
	   {
			range = exSheet.Range["B1"];
			range.Columns.Hidden = true;
			range = exSheet.Range["D1"];
			range.Columns.Hidden = true;
	   }
	   if(l_lang=="KOR")
	   {
			range = exSheet.Range["B1:C1"];
			range.Columns.Hidden = true;
	   }
	   
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
	   
		SQL = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE from tco_company where del_if = 0 and pk = '"+l_company_pk+"' " ;
		DataTable dt_company = ESysLib.TableReadOpen(SQL);
		if (dt_company.Rows.Count > 0)
		{
			l_cmp_name = dt_company.Rows[0][0].ToString();
		}
		
		SQL = "SELECT CODE_NM FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0020' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.code = '"+l_fs+"' and code like 'C%'";
		DataTable dt_fs = ESysLib.TableReadOpen(SQL);
		if (dt_fs.Rows.Count > 0)
		{
			l_title = dt_fs.Rows[0][0].ToString();
		}
		
		DateTime  dateAndTime = DateTime.Now; 
		int sysday = dateAndTime.Day;
		
		SQL	= "SELECT trim(to_char(ttm_rate,'999,999')) FROM tac_abexrates WHERE del_if = 0 and ccy = '"+p_bookccy+"' AND tco_company_pk = '"+l_company_pk+"' AND std_ymd = '"+l_month+sysday+"' " ;
		DataTable dt_ccy = ESysLib.TableReadOpen(SQL);
		if (dt_ccy.Rows.Count > 0)
		{
			l_ccy = dt_ccy.Rows[0][0].ToString();
		}
		
		exSheet.Cells["A1"].Value = l_cmp_name; 
		exSheet.Cells["E1"].Value = l_title; 
		exSheet.Cells["A2"].Value = "Period: "+l_month.Substring(4,2)+"/"+l_month.Substring(0,4);
		exSheet.Cells["A3"].Value = "Ex: "+ l_ccy;
		exSheet.Name = l_title;
        //bind data to excel file
        string para = "";
		string para1 = "";
        DataTable dt,dt_mst;
		para= "'" + l_company_pk +"','"+l_acc_pk+"','"+l_plc_pk+"','"+l_pl_pk+"','"+l_month+"','"+l_status+"','"+l_fs+"','"+l_report+"'"; 
		// Response.Write(para);
		// Response.End();
        dt = ESysLib.TableReadOpenCursor("ac_sel_60081341_1", para);
		
		
       int _row = 5;
        string l_Color = "";
        string l_Bold = "";	
	
		for (int l_addrow = 0; l_addrow < dt.Rows.Count-1; l_addrow++)
        {
            exSheet.Range[5+l_addrow+1,1].Rows.EntireRow.Insert();//insert row new of sheet
        }
		
		 for (int i = 2; i < dt.Rows.Count;i++)
		{
			
			for(int col=0;col<=81;col++)
			{
				exSheet.Cells[_row + i, 1].Value = dt.Rows[i]["ac_cd"].ToString();
				exSheet.Cells[_row + i, 2].Value = dt.Rows[i]["prn_acnm"].ToString();
				exSheet.Cells[_row + i, 3].Value = dt.Rows[i]["ac_lnm"].ToString();
				exSheet.Cells[_row + i, 4].Value = dt.Rows[i]["ac_fnm"].ToString();
				if (dt.Rows[i]["jan_last"].ToString() != "")
				{
					exSheet.Cells[_row + i, 5].Value = decimal.Parse(dt.Rows[i]["jan_last"].ToString());
					exSheet.Cells[_row + i, 5].NumberFormat = p_xls_ccy_format;
				}	
				if (dt.Rows[i]["jan_last_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 6].Value = decimal.Parse(dt.Rows[i]["jan_last_ratio"].ToString());
				}	
				if (dt.Rows[i]["jan_this"].ToString() != "")
				{
					exSheet.Cells[_row + i, 7].Value = decimal.Parse(dt.Rows[i]["jan_this"].ToString());
					exSheet.Cells[_row + i, 7].NumberFormat = p_xls_ccy_format;
				}	
				if (dt.Rows[i]["jan_this_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 8].Value = decimal.Parse(dt.Rows[i]["jan_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["jan_bud"].ToString() != "")
				{
					exSheet.Cells[_row + i, 9].Value = decimal.Parse(dt.Rows[i]["jan_bud"].ToString());
					exSheet.Cells[_row + i, 9].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["jan_bud_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 10].Value = decimal.Parse(dt.Rows[i]["jan_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 10].NumberFormat = p_xls_ccy_format;
				}	
				if (dt.Rows[i]["feb_last"].ToString() != "")
				{
					exSheet.Cells[_row + i, 11].Value = decimal.Parse(dt.Rows[i]["feb_last"].ToString());
					exSheet.Cells[_row + i, 11].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["feb_last_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 12].Value = decimal.Parse(dt.Rows[i]["feb_last_ratio"].ToString());
				}
				if (dt.Rows[i]["feb_this"].ToString() != "")
				{
					exSheet.Cells[_row + i, 13].Value = decimal.Parse(dt.Rows[i]["feb_this"].ToString());
					exSheet.Cells[_row + i, 13].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["feb_this_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 14].Value = decimal.Parse(dt.Rows[i]["feb_this_ratio"].ToString())+"%";
				}
				if(dt.Rows[i]["feb_bud"].ToString() != "")
				{
					exSheet.Cells[_row + i, 15].Value = decimal.Parse(dt.Rows[i]["feb_bud"].ToString());
					exSheet.Cells[_row + i, 15].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["feb_bud_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 16].Value = decimal.Parse(dt.Rows[i]["feb_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 16].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["mar_last"].ToString() != "")
				{
					exSheet.Cells[_row + i, 17].Value = decimal.Parse(dt.Rows[i]["mar_last"].ToString());
					exSheet.Cells[_row + i, 17].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["mar_last_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 18].Value = decimal.Parse(dt.Rows[i]["mar_last_ratio"].ToString());
				}
				if (dt.Rows[i]["mar_this"].ToString() != "")
				{
					exSheet.Cells[_row + i, 19].Value = decimal.Parse(dt.Rows[i]["mar_this"].ToString());
					exSheet.Cells[_row + i, 19].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["mar_this_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 20].Value = decimal.Parse(dt.Rows[i]["mar_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["mar_bud"].ToString() != "")
				{
					exSheet.Cells[_row + i, 21].Value = decimal.Parse(dt.Rows[i]["mar_bud"].ToString());
					exSheet.Cells[_row + i, 21].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["mar_bud_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 22].Value = decimal.Parse(dt.Rows[i]["mar_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 22].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["apr_last"].ToString() != "")
				{
					exSheet.Cells[_row + i, 23].Value = decimal.Parse(dt.Rows[i]["apr_last"].ToString());
					exSheet.Cells[_row + i, 23].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["apr_last_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 24].Value = decimal.Parse(dt.Rows[i]["apr_last_ratio"].ToString());
				}
				if (dt.Rows[i]["apr_this"].ToString() != "")
				{
					exSheet.Cells[_row + i, 25].Value = decimal.Parse(dt.Rows[i]["apr_this"].ToString());
					exSheet.Cells[_row + i, 25].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["apr_this_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 26].Value = decimal.Parse(dt.Rows[i]["apr_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["apr_bud"].ToString() != "")
				{
					exSheet.Cells[_row + i, 27].Value = decimal.Parse(dt.Rows[i]["apr_bud"].ToString());
					exSheet.Cells[_row + i, 27].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["apr_bud_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 28].Value = decimal.Parse(dt.Rows[i]["apr_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 28].NumberFormat = p_xls_ccy_format;
				}
				if(dt.Rows[i]["may_last"].ToString() != "")
				{
					exSheet.Cells[_row + i, 29].Value = decimal.Parse(dt.Rows[i]["may_last"].ToString());
					exSheet.Cells[_row + i, 29].NumberFormat = p_xls_ccy_format;
				}
                if (dt.Rows[i]["may_last_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 30].Value = decimal.Parse(dt.Rows[i]["may_last_ratio"].ToString());
				}	
				if (dt.Rows[i]["may_this"].ToString() != "")
				{
					exSheet.Cells[_row + i, 31].Value = decimal.Parse(dt.Rows[i]["may_this"].ToString());
					exSheet.Cells[_row + i, 31].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["may_this_ratio"].ToString() != "" )
				{
					exSheet.Cells[_row + i, 32].Value = decimal.Parse(dt.Rows[i]["may_this_ratio"].ToString())+"%";
				}
				if(dt.Rows[i]["may_bud"].ToString()  != "")
				{
					exSheet.Cells[_row + i, 33].Value = decimal.Parse(dt.Rows[i]["may_bud"].ToString());
					exSheet.Cells[_row + i, 33].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["may_bud_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 34].Value = decimal.Parse(dt.Rows[i]["may_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 34].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["jun_last"].ToString() != "")
				{
					exSheet.Cells[_row + i, 35].Value = decimal.Parse(dt.Rows[i]["jun_last"].ToString());
					exSheet.Cells[_row + i, 35].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["jun_last_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 36].Value = decimal.Parse(dt.Rows[i]["jun_last_ratio"].ToString());
				}	
				if (dt.Rows[i]["jun_this"].ToString() !="")
				{
					exSheet.Cells[_row + i, 37].Value = decimal.Parse(dt.Rows[i]["jun_this"].ToString());
					exSheet.Cells[_row + i, 37].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["jun_this_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 38].Value = decimal.Parse(dt.Rows[i]["jun_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["jun_bud"].ToString() != "")
				{
					exSheet.Cells[_row + i, 39].Value = decimal.Parse(dt.Rows[i]["jun_bud"].ToString());
					exSheet.Cells[_row + i, 39].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["jun_bud_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 40].Value = decimal.Parse(dt.Rows[i]["jun_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 40].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["jul_last"].ToString() !="" )
				{
					exSheet.Cells[_row + i, 41].Value = decimal.Parse(dt.Rows[i]["jul_last"].ToString());
					exSheet.Cells[_row + i, 41].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["jul_last_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 42].Value = decimal.Parse(dt.Rows[i]["jul_last_ratio"].ToString());
				}
				if (dt.Rows[i]["jul_this"].ToString() != "")
				{
					exSheet.Cells[_row + i, 43].Value = decimal.Parse(dt.Rows[i]["jul_this"].ToString());
					exSheet.Cells[_row + i, 43].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["jul_this_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 44].Value = decimal.Parse(dt.Rows[i]["jul_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["jul_bud"].ToString() !="")
				{
					exSheet.Cells[_row + i, 45].Value = decimal.Parse(dt.Rows[i]["jul_bud"].ToString());
					exSheet.Cells[_row + i, 45].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["jul_bud_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 46].Value = decimal.Parse(dt.Rows[i]["jul_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 46].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["aug_last"].ToString() !="")
				{
					exSheet.Cells[_row + i, 47].Value = decimal.Parse(dt.Rows[i]["aug_last"].ToString());
					exSheet.Cells[_row + i, 47].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["aug_last_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 48].Value = decimal.Parse(dt.Rows[i]["aug_last_ratio"].ToString());
				}
				if (dt.Rows[i]["aug_this"].ToString() != "")
				{
					exSheet.Cells[_row + i, 49].Value = decimal.Parse(dt.Rows[i]["aug_this"].ToString());
					exSheet.Cells[_row + i, 49].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["aug_this_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 50].Value = decimal.Parse(dt.Rows[i]["aug_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["aug_bud"].ToString() != "")
				{
					exSheet.Cells[_row + i, 51].Value = decimal.Parse(dt.Rows[i]["aug_bud"].ToString());
					exSheet.Cells[_row + i, 51].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["aug_bud_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 52].Value = decimal.Parse(dt.Rows[i]["aug_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 52].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["sep_last"].ToString() != "")
				{
					exSheet.Cells[_row + i, 53].Value = decimal.Parse(dt.Rows[i]["sep_last"].ToString());
					exSheet.Cells[_row + i, 53].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["sep_last_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 54].Value = decimal.Parse(dt.Rows[i]["sep_last_ratio"].ToString());
				}
				if (dt.Rows[i]["sep_this"].ToString() != "")
				{
					exSheet.Cells[_row + i, 55].Value = decimal.Parse(dt.Rows[i]["sep_this"].ToString());
					exSheet.Cells[_row + i, 55].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["sep_this_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 56].Value = decimal.Parse(dt.Rows[i]["sep_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["sep_bud"].ToString() != "")
				{
					exSheet.Cells[_row + i, 57].Value = decimal.Parse(dt.Rows[i]["sep_bud"].ToString());
					exSheet.Cells[_row + i, 57].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["sep_bud_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 58].Value = decimal.Parse(dt.Rows[i]["sep_bud_ratio"].ToString());
				}
				if (dt.Rows[i]["oct_last"].ToString() !="")
				{
					exSheet.Cells[_row + i, 59].Value = decimal.Parse(dt.Rows[i]["oct_last"].ToString());
					exSheet.Cells[_row + i, 59].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["oct_last_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 60].Value = decimal.Parse(dt.Rows[i]["oct_last_ratio"].ToString());
				}
				if (dt.Rows[i]["oct_this"].ToString() !="")
				{
					exSheet.Cells[_row + i, 61].Value = decimal.Parse(dt.Rows[i]["oct_this"].ToString());
					exSheet.Cells[_row + i, 61].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["oct_this_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 62].Value = decimal.Parse(dt.Rows[i]["oct_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["oct_bud"].ToString() != "")
				{
					exSheet.Cells[_row + i, 63].Value = decimal.Parse(dt.Rows[i]["oct_bud"].ToString());
					exSheet.Cells[_row + i, 63].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["oct_bud_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 64].Value = decimal.Parse(dt.Rows[i]["oct_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 64].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["nov_last"].ToString() != "")
				{
					exSheet.Cells[_row + i, 65].Value = decimal.Parse(dt.Rows[i]["nov_last"].ToString());
					exSheet.Cells[_row + i, 65].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["nov_last_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 66].Value = decimal.Parse(dt.Rows[i]["nov_last_ratio"].ToString());
				}
				if (dt.Rows[i]["nov_this"].ToString() !="")
				{
					exSheet.Cells[_row + i, 67].Value = decimal.Parse(dt.Rows[i]["nov_this"].ToString());
					exSheet.Cells[_row + i, 67].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["nov_this_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 68].Value = decimal.Parse(dt.Rows[i]["nov_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["nov_bud"].ToString() !="")
				{
					exSheet.Cells[_row + i, 69].Value = decimal.Parse(dt.Rows[i]["nov_bud"].ToString());
					exSheet.Cells[_row + i, 69].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["nov_bud_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 70].Value = decimal.Parse(dt.Rows[i]["nov_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 70].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["dec_last"].ToString() !="")
				{
					exSheet.Cells[_row + i, 71].Value = decimal.Parse(dt.Rows[i]["dec_last"].ToString());
				}
				if (dt.Rows[i]["dec_last_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 72].Value = decimal.Parse(dt.Rows[i]["dec_last_ratio"].ToString());
					exSheet.Cells[_row + i, 72].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["dec_this"].ToString() !="")
				{
					exSheet.Cells[_row + i, 73].Value = decimal.Parse(dt.Rows[i]["dec_this"].ToString());
					exSheet.Cells[_row + i, 73].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["dec_this_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 74].Value = decimal.Parse(dt.Rows[i]["dec_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["dec_bud"].ToString() !="")
				{
					exSheet.Cells[_row + i, 75].Value = decimal.Parse(dt.Rows[i]["dec_bud"].ToString());
					exSheet.Cells[_row + i, 75].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["dec_bud_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 76].Value = decimal.Parse(dt.Rows[i]["dec_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 76].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["acc_last"].ToString() !="")
				{
					exSheet.Cells[_row + i, 77].Value = decimal.Parse(dt.Rows[i]["acc_last"].ToString());
					exSheet.Cells[_row + i, 77].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["acc_last_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 78].Value = decimal.Parse(dt.Rows[i]["acc_last_ratio"].ToString());
				}
				if (dt.Rows[i]["acc_this"].ToString() !="")
				{
					exSheet.Cells[_row + i, 79].Value = decimal.Parse(dt.Rows[i]["acc_this"].ToString());
					exSheet.Cells[_row + i, 79].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["acc_this_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 80].Value = dt.Rows[i]["acc_this_ratio"].ToString() ;//decimal.Parse(dt.Rows[i]["acc_this_ratio"].ToString())+"%";
				}
				if (dt.Rows[i]["acc_bud"].ToString() !="")
				{
					exSheet.Cells[_row + i, 81].Value = decimal.Parse(dt.Rows[i]["acc_bud"].ToString());
					exSheet.Cells[_row + i, 81].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["acc_bud_ratio"].ToString() !="")
				{
					exSheet.Cells[_row + i, 82].Value = decimal.Parse(dt.Rows[i]["acc_bud_ratio"].ToString());
					exSheet.Cells[_row + i, 82].NumberFormat = p_xls_ccy_format;
				}
				l_Bold = dt.Rows[i]["font_stype"].ToString();
				if(dt.Rows[i]["prn_color"].ToString()!="")
				{
					l_Color = "0X" + dt.Rows[i]["prn_color"].ToString().Substring(6,2) + dt.Rows[i]["prn_color"].ToString().Substring(4,2) + dt.Rows[i]["prn_color"].ToString().Substring(2,2);
				}
				if(l_Bold=="B")
				{
					exSheet.Cells[_row + i, col + 1].Font.Bold = true;
				}
				Color colorValueFrmHex = ColorTranslator.FromHtml(l_Color);
				exSheet.Cells[_row + i, col + 1].Interior.Color = colorValueFrmHex;
			}
			

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