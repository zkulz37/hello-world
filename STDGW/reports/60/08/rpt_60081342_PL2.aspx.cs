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

public partial class rpt_60081342_PL2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
		string l_company_pk = Request["company_pk"];
		string l_acc_pk = Request["acc_pk"];
		string l_plc_pk = Request["plc_pk"];
		string l_pl_pk = Request["pl_pk"];
		string l_month = Request["month"];  
		string l_status = Request["status"];
		string l_fs = Request["fs"];
		string l_report = Request["report"];  
		string l_year = "";
		string l_exrate = Request["p_exrate"];
		
        string TemplateFile = "rpt_60081342_PL2.xls";
        string TempFile = "../../../system/temp/rpt_60081342_PL2_" + Session["User_ID"].ToString() + ".xls";
		
	   TemplateFile = Server.MapPath(TemplateFile);
       TempFile = Server.MapPath(TempFile);
	
        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);
		
        //Add worksheet
		IWorksheet exSheet = exBook.Worksheets[1];

       IRange range;
		
        //bind data to excel file
        string para = "";
		string para1 = "";
		string l_date ="";
        DataTable dt,dt_mst;
		para= "'" + l_company_pk +"','"+l_acc_pk+"','"+l_plc_pk+"','"+l_pl_pk+"','"+l_month+"','"+l_status+"','"+l_fs+"','"+l_report+"'"; 
		// Response.Write(para);
		// Response.End();
        dt = ESysLib.TableReadOpenCursor("ac_sel_60081342_dpl", para);
		DataTable dtMST  = ESysLib.TableReadOpenCursor("ac_sel_60081342_2","'" + l_company_pk +"','"+l_month+"'");	
		if (dtMST.Rows.Count >0)
		{
			exSheet.Cells[1,1].Value = dtMST.Rows[0]["partner_lname"].ToString(); 
			exSheet.Cells[2,1].Value = dtMST.Rows[0]["addr2"].ToString() + "\n Tax Code/MST :"+ dtMST.Rows[0]["tax_code"].ToString(); 
			l_date = dtMST.Rows[0]["last_day_"].ToString() ; 
			exSheet.Cells[6,2].Value = dtMST.Rows[0]["this_month"].ToString() ; 
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
       int _row = 6;
        string l_Color = "";
        string l_Bold = "";	
	
		for (int l_addrow = 0; l_addrow < dt.Rows.Count-1; l_addrow++)
        {
            exSheet.Range[6+l_addrow+1,1].Rows.EntireRow.Insert();//insert row new of sheet
        }
		if (l_exrate != "")
		{
			exSheet.Cells[5, 6].Value  = decimal.Parse(l_exrate );
			exSheet.Cells[5, 6].NumberFormat =  "#,##0";
			exSheet.Cells[5, 1].Value  = l_date ;
			
		}
		
		range = exSheet.Range["D1:E1"];
		if (dt.Rows[0]["name1"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 4].Value = dt.Rows[0]["name1"].ToString();
		}
		range = exSheet.Range["F1:G1"];
		if (dt.Rows[0]["name2"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 6].Value = dt.Rows[0]["name2"].ToString();
		}	
		range = exSheet.Range["H1:I1"];
		if (dt.Rows[0]["name3"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 8].Value = dt.Rows[0]["name3"].ToString();
		}
		range = exSheet.Range["J1:K1"];
		if (dt.Rows[0]["name4"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 10].Value = dt.Rows[0]["name4"].ToString();
		}
		range = exSheet.Range["L1:M1"];
		if (dt.Rows[0]["name5"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 12].Value = dt.Rows[0]["name5"].ToString();
		}
		range = exSheet.Range["N1:O1"];
		if (dt.Rows[0]["name6"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 14].Value = dt.Rows[0]["name6"].ToString();
		}
		range = exSheet.Range["P1:Q1"];
		if (dt.Rows[0]["name7"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 16].Value = dt.Rows[0]["name7"].ToString();
		}
		range = exSheet.Range["R1:S1"];
		if (dt.Rows[0]["name8"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 18].Value = dt.Rows[0]["name8"].ToString();
		}
		range = exSheet.Range["T1:U1"];
		if (dt.Rows[0]["name9"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 20].Value = dt.Rows[0]["name9"].ToString();
		}
		range = exSheet.Range["V1:W1"];
		if (dt.Rows[0]["name10"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 22].Value = dt.Rows[0]["name10"].ToString();
		}
		range = exSheet.Range["X1:Y1"];
		if (dt.Rows[0]["name11"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 24].Value = dt.Rows[0]["name11"].ToString();
		}
		range = exSheet.Range["Z1:AA1"];
		if (dt.Rows[0]["name12"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 26].Value = dt.Rows[0]["name12"].ToString();
		}
		range = exSheet.Range["AB1:AC1"];
		if (dt.Rows[0]["name13"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 28].Value = dt.Rows[0]["name13"].ToString();
		}
		range = exSheet.Range["AD1:AE1"];
		if (dt.Rows[0]["name14"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 30].Value = dt.Rows[0]["name14"].ToString();
		}
		range = exSheet.Range["AF1:AG1"];
		if (dt.Rows[0]["name15"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 32].Value = dt.Rows[0]["name15"].ToString();
		}
		range = exSheet.Range["AH1:AI1"];
		if (dt.Rows[0]["name16"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 34].Value = dt.Rows[0]["name16"].ToString();
		}
		range = exSheet.Range["AJ1:AK1"];
		if (dt.Rows[0]["name17"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 36].Value = dt.Rows[0]["name17"].ToString();
		}
		range = exSheet.Range["AL1:AM1"];
		if (dt.Rows[0]["name18"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 38].Value = dt.Rows[0]["name18"].ToString();
		}
		range = exSheet.Range["AN1:AO1"];
		if (dt.Rows[0]["name19"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 40].Value = dt.Rows[0]["name19"].ToString();
		}
		range = exSheet.Range["AP1:AQ1"];
		if (dt.Rows[0]["name20"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 42].Value = dt.Rows[0]["name20"].ToString();
		}
		range = exSheet.Range["AR1:AS1"];
		if (dt.Rows[0]["name21"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 44].Value = dt.Rows[0]["name21"].ToString();
		}
		range = exSheet.Range["AT1:AU1"];
		if (dt.Rows[0]["name22"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 46].Value = dt.Rows[0]["name22"].ToString();
		}
		range = exSheet.Range["AV1:AW1"];
		if (dt.Rows[0]["name23"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 48].Value = dt.Rows[0]["name23"].ToString();
		}
		range = exSheet.Range["AX1:AY1"];
		if (dt.Rows[0]["name24"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 50].Value = dt.Rows[0]["name24"].ToString();
		}
		range = exSheet.Range["AZ1:BA1"];
		if (dt.Rows[0]["name25"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 52].Value = dt.Rows[0]["name25"].ToString();
		}
		range = exSheet.Range["BB1:BC1"];
		if (dt.Rows[0]["name26"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 54].Value = dt.Rows[0]["name26"].ToString();
		}
		range = exSheet.Range["BD1:BE1"];
		if (dt.Rows[0]["name27"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 56].Value = dt.Rows[0]["name27"].ToString();
		}
		range = exSheet.Range["BF1:BG1"];
		if (dt.Rows[0]["name28"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 58].Value = dt.Rows[0]["name28"].ToString();
		}
		range = exSheet.Range["BH1:BI1"];
		if (dt.Rows[0]["name29"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 60].Value = dt.Rows[0]["name29"].ToString();
		}
		range = exSheet.Range["BJ1:BK1"];
		if (dt.Rows[0]["name30"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 62].Value = dt.Rows[0]["name30"].ToString();
		}
		range = exSheet.Range["BL1:BM1"];
		if (dt.Rows[0]["name31"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 64].Value = dt.Rows[0]["name31"].ToString();
		}
		range = exSheet.Range["BN1:BO1"];
		if (dt.Rows[0]["name32"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 66].Value = dt.Rows[0]["name32"].ToString();
		}
		range = exSheet.Range["BP1:BQ1"];
		if (dt.Rows[0]["name33"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 68].Value = dt.Rows[0]["name33"].ToString();
		}
		range = exSheet.Range["BR1:BS1"];
		if (dt.Rows[0]["name34"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 70].Value = dt.Rows[0]["name34"].ToString();
		}
		range = exSheet.Range["BT1:BU1"];
		if (dt.Rows[0]["name35"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 72].Value = dt.Rows[0]["name35"].ToString();
		}
		range = exSheet.Range["BV1:BW1"];
		if (dt.Rows[0]["name36"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 74].Value = dt.Rows[0]["name36"].ToString();
		}
		range = exSheet.Range["BX1:BY1"];
		if (dt.Rows[0]["name37"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 76].Value = dt.Rows[0]["name37"].ToString();
		}
		range = exSheet.Range["BZ1:CA1"];
		if (dt.Rows[0]["name38"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 78].Value = dt.Rows[0]["name38"].ToString();
		}
		range = exSheet.Range["CB1:CC1"];
		if (dt.Rows[0]["name39"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 80].Value = dt.Rows[0]["name39"].ToString();
		}
		range = exSheet.Range["CD1:CE1"];
		if (dt.Rows[0]["name40"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 82].Value = dt.Rows[0]["name40"].ToString();
		}
		range = exSheet.Range["CF1:CG1"];
		if (dt.Rows[0]["name41"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 84].Value = dt.Rows[0]["name41"].ToString();
		}
		range = exSheet.Range["CH1:CI1"];
		if (dt.Rows[0]["name42"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 86].Value = dt.Rows[0]["name42"].ToString();
		}
		range = exSheet.Range["CJ1:CK1"];
		if (dt.Rows[0]["name43"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 88].Value = dt.Rows[0]["name43"].ToString();
		}
		range = exSheet.Range["CL1:CM1"];
		if (dt.Rows[0]["name44"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 90].Value = dt.Rows[0]["name44"].ToString();
		}
		range = exSheet.Range["CN1:CO1"];
		if (dt.Rows[0]["name45"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 92].Value = dt.Rows[0]["name45"].ToString();
		}
		range = exSheet.Range["CP1:CQ1"];
		if (dt.Rows[0]["name46"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 94].Value = dt.Rows[0]["name46"].ToString();
		}
		range = exSheet.Range["CR1:CS1"];
		if (dt.Rows[0]["name47"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 96].Value = dt.Rows[0]["name47"].ToString();
		}
		range = exSheet.Range["CT1:CU1"];
		if (dt.Rows[0]["name48"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 98].Value = dt.Rows[0]["name48"].ToString();
		}
		range = exSheet.Range["CV1:CW1"];
		if (dt.Rows[0]["name49"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 100].Value = dt.Rows[0]["name49"].ToString();
		}
		range = exSheet.Range["CX1:CY1"];
		if (dt.Rows[0]["name50"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 102].Value = dt.Rows[0]["name50"].ToString();
		}
		range = exSheet.Range["CZ1:DA1"];
		if (dt.Rows[0]["name51"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 104].Value = dt.Rows[0]["name51"].ToString();
		}
		range = exSheet.Range["DB1:DC1"];
		if (dt.Rows[0]["name52"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 106].Value = dt.Rows[0]["name52"].ToString();
		}
		range = exSheet.Range["DD1:DE1"];
		if (dt.Rows[0]["name53"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 108].Value = dt.Rows[0]["name53"].ToString();
		}
		range = exSheet.Range["DF1:DG1"];
		if (dt.Rows[0]["name54"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 110].Value = dt.Rows[0]["name54"].ToString();
		}
		range = exSheet.Range["DH1:DI1"];
		if (dt.Rows[0]["name55"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 112].Value = dt.Rows[0]["name55"].ToString();
		}
		range = exSheet.Range["DJ1:DK1"];
		if (dt.Rows[0]["name56"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 114].Value = dt.Rows[0]["name56"].ToString();
		}
		range = exSheet.Range["DL1:DM1"];
		if (dt.Rows[0]["name57"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 116].Value = dt.Rows[0]["name57"].ToString();
		}
		range = exSheet.Range["DN1:DO1"];
		if (dt.Rows[0]["name58"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 118].Value = dt.Rows[0]["name58"].ToString();
		}
		range = exSheet.Range["DP1:DQ1"];
		if (dt.Rows[0]["name59"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 120].Value = dt.Rows[0]["name59"].ToString();
		}
		range = exSheet.Range["DR1:DS1"];
		if (dt.Rows[0]["name60"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 122].Value = dt.Rows[0]["name60"].ToString();
		}
		range = exSheet.Range["DT1:DU1"];
		if (dt.Rows[0]["name61"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 124].Value = dt.Rows[0]["name61"].ToString();
		}
		range = exSheet.Range["DV1:DW1"];
		if (dt.Rows[0]["name62"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 126].Value = dt.Rows[0]["name62"].ToString();
		}
		range = exSheet.Range["DX1:DY1"];
		if (dt.Rows[0]["name63"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 128].Value = dt.Rows[0]["name63"].ToString();
		}
		range = exSheet.Range["DZ1:EA1"];
		if (dt.Rows[0]["name64"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 130].Value = dt.Rows[0]["name64"].ToString();
		}
		range = exSheet.Range["EB1:EC1"];
		if (dt.Rows[0]["name65"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 132].Value = dt.Rows[0]["name65"].ToString();
		}
		range = exSheet.Range["ED1:EE1"];
		if (dt.Rows[0]["name66"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 134].Value = dt.Rows[0]["name66"].ToString();
		}
		range = exSheet.Range["EF1:EG1"];
		if (dt.Rows[0]["name67"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 136].Value = dt.Rows[0]["name67"].ToString();
		}
		range = exSheet.Range["EH1:EI1"];
		if (dt.Rows[0]["name68"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 138].Value = dt.Rows[0]["name68"].ToString();
		}
		range = exSheet.Range["EJ1:EK1"];
		if (dt.Rows[0]["name69"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 140].Value = dt.Rows[0]["name69"].ToString();
		}
		range = exSheet.Range["EL1:EM1"];
		if (dt.Rows[0]["name70"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 142].Value = dt.Rows[0]["name70"].ToString();
		}
		range = exSheet.Range["EN1:EO1"];
		if (dt.Rows[0]["name71"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 144].Value = dt.Rows[0]["name71"].ToString();
		}
		range = exSheet.Range["EP1:EQ1"];
		if (dt.Rows[0]["name72"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 146].Value = dt.Rows[0]["name72"].ToString();
		}
		range = exSheet.Range["ER1:ES1"];
		if (dt.Rows[0]["name73"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 148].Value = dt.Rows[0]["name73"].ToString();
		}
		range = exSheet.Range["ET1:EU1"];
		if (dt.Rows[0]["name74"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 150].Value = dt.Rows[0]["name74"].ToString();
		}
		range = exSheet.Range["EV1:EW1"];
		if (dt.Rows[0]["name75"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 152].Value = dt.Rows[0]["name75"].ToString();
		}
		range = exSheet.Range["EX1:EY1"];
		if (dt.Rows[0]["name76"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 154].Value = dt.Rows[0]["name76"].ToString();
		}
		range = exSheet.Range["EZ1:FA1"];
		if (dt.Rows[0]["name77"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 156].Value = dt.Rows[0]["name77"].ToString();
		}
		range = exSheet.Range["FB1:FC1"];
		if (dt.Rows[0]["name78"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 158].Value = dt.Rows[0]["name78"].ToString();
		}
		range = exSheet.Range["FD1:FE1"];
		if (dt.Rows[0]["name79"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 160].Value = dt.Rows[0]["name79"].ToString();
		}
		range = exSheet.Range["FF1:FG1"];
		if (dt.Rows[0]["name80"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 162].Value = dt.Rows[0]["name80"].ToString();
		}
		range = exSheet.Range["FH1:FI1"];
		if (dt.Rows[0]["name81"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 164].Value = dt.Rows[0]["name81"].ToString();
		}
		range = exSheet.Range["FJ1:FK1"];
		if (dt.Rows[0]["name82"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 166].Value = dt.Rows[0]["name82"].ToString();
		}
		range = exSheet.Range["FL1:FM1"];
		if (dt.Rows[0]["name83"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 168].Value = dt.Rows[0]["name83"].ToString();
		}
		range = exSheet.Range["FN1:FO1"];
		if (dt.Rows[0]["name84"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 170].Value = dt.Rows[0]["name84"].ToString();
		}
		range = exSheet.Range["FP1:FQ1"];
		if (dt.Rows[0]["name85"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 172].Value = dt.Rows[0]["name85"].ToString();
		}
		range = exSheet.Range["FR1:FS1"];
		if (dt.Rows[0]["name86"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 174].Value = dt.Rows[0]["name86"].ToString();
		}
		range = exSheet.Range["FT1:FU1"];
		if (dt.Rows[0]["name87"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 176].Value = dt.Rows[0]["name87"].ToString();
		}
		range = exSheet.Range["FV1:FW1"];
		if (dt.Rows[0]["name88"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 178].Value = dt.Rows[0]["name88"].ToString();
		}
		range = exSheet.Range["FX1:FY1"];
		if (dt.Rows[0]["name89"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 180].Value = dt.Rows[0]["name89"].ToString();
		}
		range = exSheet.Range["FZ1:GA1"];
		if (dt.Rows[0]["name90"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 182].Value = dt.Rows[0]["name90"].ToString();
		}
		range = exSheet.Range["GB1:GC1"];
		if (dt.Rows[0]["name91"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 184].Value = dt.Rows[0]["name91"].ToString();
		}
		range = exSheet.Range["GD1:GE1"];
		if (dt.Rows[0]["name92"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 186].Value = dt.Rows[0]["name92"].ToString();
		}
		range = exSheet.Range["GF1:GG1"];
		if (dt.Rows[0]["name93"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 188].Value = dt.Rows[0]["name93"].ToString();
		}
		range = exSheet.Range["GH1:GI1"];
		if (dt.Rows[0]["name94"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 190].Value = dt.Rows[0]["name94"].ToString();
		}
		range = exSheet.Range["GJ1:GK1"];
		if (dt.Rows[0]["name95"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 192].Value = dt.Rows[0]["name95"].ToString();
		}
		range = exSheet.Range["GL1:GM1"];
		if (dt.Rows[0]["name96"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 194].Value = dt.Rows[0]["name96"].ToString();
		}
		range = exSheet.Range["GN1:GO1"];
		if (dt.Rows[0]["name97"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 196].Value = dt.Rows[0]["name97"].ToString();
		}
		range = exSheet.Range["GP1:GQ1"];
		if (dt.Rows[0]["name98"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 198].Value = dt.Rows[0]["name98"].ToString();
		}
		range = exSheet.Range["GR1:GS1"];
		if (dt.Rows[0]["name99"].ToString() == "")
		{
			range.Columns.Hidden = true;
		}else{
			exSheet.Cells[6, 200].Value = dt.Rows[0]["name99"].ToString();
		}
		decimal jan_this = 0, feb_this = 0, mar_this = 0, apr_this = 0, may_this = 0, jun_this = 0, jul_this = 0, aug_this = 0, sep_this = 0, oct_this = 0, nov_this = 0, dec_this = 0, acc_this = 0;
		 for (int i = 1; i < dt.Rows.Count;i++)
		 {
			for(int col=0;col<=200;col++)
			{
				exSheet.Cells[_row + i, 1].Value = dt.Rows[i]["prn_acnm"].ToString();
				if (dt.Rows[i]["jan_this"].ToString() != "")
				{
					exSheet.Cells[_row + i, 2].Value = decimal.Parse(dt.Rows[i]["jan_this"].ToString());
					exSheet.Cells[_row + i, 2].NumberFormat = p_xls_ccy_format;
				}	
				if (dt.Rows[i]["jan_this_ratio"].ToString() != "")
				{
					exSheet.Cells[_row + i, 3].Value = decimal.Parse(dt.Rows[i]["jan_this_ratio"].ToString());
				}
				if (dt.Rows[i]["ratio1"].ToString() != "")
				{
					exSheet.Cells[_row + i, 5].Value = decimal.Parse(dt.Rows[i]["ratio1"].ToString());
				}
				if (dt.Rows[i]["ratio2"].ToString() != "")
				{
					exSheet.Cells[_row + i, 7].Value = decimal.Parse(dt.Rows[i]["ratio2"].ToString());
				}	
				if (dt.Rows[i]["ratio3"].ToString() != "")
				{
					exSheet.Cells[_row + i, 9].Value = decimal.Parse(dt.Rows[i]["ratio3"].ToString());
				}
				if (dt.Rows[i]["ratio4"].ToString() != "")
				{
					exSheet.Cells[_row + i, 11].Value = decimal.Parse(dt.Rows[i]["ratio4"].ToString());
				}
				if (dt.Rows[i]["ratio5"].ToString() != "")
				{
					exSheet.Cells[_row + i, 13].Value = decimal.Parse(dt.Rows[i]["ratio5"].ToString());
				}
				if (dt.Rows[i]["ratio6"].ToString() != "")
				{
					exSheet.Cells[_row + i, 15].Value = decimal.Parse(dt.Rows[i]["ratio6"].ToString());
				}
				if (dt.Rows[i]["ratio7"].ToString() != "")
				{
					exSheet.Cells[_row + i, 17].Value = decimal.Parse(dt.Rows[i]["ratio7"].ToString());
				}
				if (dt.Rows[i]["ratio8"].ToString() != "")
				{
					exSheet.Cells[_row + i, 19].Value = decimal.Parse(dt.Rows[i]["ratio8"].ToString());
				}
				if (dt.Rows[i]["ratio9"].ToString() != "")
				{
					exSheet.Cells[_row + i, 21].Value = decimal.Parse(dt.Rows[i]["ratio9"].ToString());
				}
				if (dt.Rows[i]["ratio10"].ToString() != "")
				{
					exSheet.Cells[_row + i, 23].Value = decimal.Parse(dt.Rows[i]["ratio10"].ToString());
				}
				if (dt.Rows[i]["ratio11"].ToString() != "")
				{
					exSheet.Cells[_row + i, 25].Value = decimal.Parse(dt.Rows[i]["ratio11"].ToString());
				}
				if (dt.Rows[i]["ratio12"].ToString() != "")
				{
					exSheet.Cells[_row + i, 27].Value = decimal.Parse(dt.Rows[i]["ratio12"].ToString());
				}
				if (dt.Rows[i]["ratio13"].ToString() != "")
				{
					exSheet.Cells[_row + i, 29].Value = decimal.Parse(dt.Rows[i]["ratio13"].ToString());
				}
				if (dt.Rows[i]["ratio14"].ToString() != "")
				{
					exSheet.Cells[_row + i, 31].Value = decimal.Parse(dt.Rows[i]["ratio14"].ToString());
				}
				if (dt.Rows[i]["ratio15"].ToString() != "")
				{
					exSheet.Cells[_row + i, 33].Value = decimal.Parse(dt.Rows[i]["ratio15"].ToString());
				}
				if (dt.Rows[i]["ratio16"].ToString() != "")
				{
					exSheet.Cells[_row + i, 35].Value = decimal.Parse(dt.Rows[i]["ratio16"].ToString());
				}
				if (dt.Rows[i]["ratio17"].ToString() != "")
				{
					exSheet.Cells[_row + i, 37].Value = decimal.Parse(dt.Rows[i]["ratio17"].ToString());
				}
				if (dt.Rows[i]["ratio18"].ToString() != "")
				{
					exSheet.Cells[_row + i, 39].Value = decimal.Parse(dt.Rows[i]["ratio18"].ToString());
				}
				if (dt.Rows[i]["ratio19"].ToString() != "")
				{
					exSheet.Cells[_row + i,41 ].Value = decimal.Parse(dt.Rows[i]["ratio19"].ToString());
				}
				if (dt.Rows[i]["ratio20"].ToString() != "")
				{
					exSheet.Cells[_row + i, 43].Value = decimal.Parse(dt.Rows[i]["ratio20"].ToString());
				}
				if (dt.Rows[i]["ratio21"].ToString() != "")
				{
					exSheet.Cells[_row + i,45 ].Value = decimal.Parse(dt.Rows[i]["ratio21"].ToString());
				}
				if (dt.Rows[i]["ratio22"].ToString() != "")
				{
					exSheet.Cells[_row + i, 47].Value = decimal.Parse(dt.Rows[i]["ratio22"].ToString());
				}
				if (dt.Rows[i]["ratio23"].ToString() != "")
				{
					exSheet.Cells[_row + i, 49].Value = decimal.Parse(dt.Rows[i]["ratio23"].ToString());
				}
				if (dt.Rows[i]["ratio24"].ToString() != "")
				{
					exSheet.Cells[_row + i, 51].Value = decimal.Parse(dt.Rows[i]["ratio24"].ToString());
				}
				if (dt.Rows[i]["ratio25"].ToString() != "")
				{
					exSheet.Cells[_row + i, 53].Value = decimal.Parse(dt.Rows[i]["ratio25"].ToString());
				}
				if (dt.Rows[i]["ratio26"].ToString() != "")
				{
					exSheet.Cells[_row + i, 55].Value = decimal.Parse(dt.Rows[i]["ratio26"].ToString());
				}
				if (dt.Rows[i]["ratio27"].ToString() != "")
				{
					exSheet.Cells[_row + i,57 ].Value = decimal.Parse(dt.Rows[i]["ratio27"].ToString());
				}
				if (dt.Rows[i]["ratio28"].ToString() != "")
				{
					exSheet.Cells[_row + i,59 ].Value = decimal.Parse(dt.Rows[i]["ratio28"].ToString());
				}
				if (dt.Rows[i]["ratio29"].ToString() != "")
				{
					exSheet.Cells[_row + i,61 ].Value = decimal.Parse(dt.Rows[i]["ratio29"].ToString());
				}
				if (dt.Rows[i]["ratio30"].ToString() != "")
				{
					exSheet.Cells[_row + i,63 ].Value = decimal.Parse(dt.Rows[i]["ratio30"].ToString());
				}
				if (dt.Rows[i]["ratio31"].ToString() != "")
				{
					exSheet.Cells[_row + i,65 ].Value = decimal.Parse(dt.Rows[i]["ratio31"].ToString());
				}
				if (dt.Rows[i]["ratio32"].ToString() != "")
				{
					exSheet.Cells[_row + i, 67].Value = decimal.Parse(dt.Rows[i]["ratio32"].ToString());
				}
				if (dt.Rows[i]["ratio33"].ToString() != "")
				{
					exSheet.Cells[_row + i, 69].Value = decimal.Parse(dt.Rows[i]["ratio33"].ToString());
				}
				if (dt.Rows[i]["ratio34"].ToString() != "")
				{
					exSheet.Cells[_row + i,71 ].Value = decimal.Parse(dt.Rows[i]["ratio34"].ToString());
				}
				if (dt.Rows[i]["ratio35"].ToString() != "")
				{
					exSheet.Cells[_row + i,73 ].Value = decimal.Parse(dt.Rows[i]["ratio35"].ToString());
				}
				if (dt.Rows[i]["ratio36"].ToString() != "")
				{
					exSheet.Cells[_row + i,75 ].Value = decimal.Parse(dt.Rows[i]["ratio36"].ToString());
				}
				if (dt.Rows[i]["ratio37"].ToString() != "")
				{
					exSheet.Cells[_row + i,77 ].Value = decimal.Parse(dt.Rows[i]["ratio37"].ToString());
				}
				if (dt.Rows[i]["ratio38"].ToString() != "")
				{
					exSheet.Cells[_row + i, 79].Value = decimal.Parse(dt.Rows[i]["ratio38"].ToString());
				}
				if (dt.Rows[i]["ratio39"].ToString() != "")
				{
					exSheet.Cells[_row + i, 81].Value = decimal.Parse(dt.Rows[i]["ratio39"].ToString());
				}
				if (dt.Rows[i]["ratio40"].ToString() != "")
				{
					exSheet.Cells[_row + i,83 ].Value = decimal.Parse(dt.Rows[i]["ratio40"].ToString());
				}
				if (dt.Rows[i]["ratio41"].ToString() != "")
				{
					exSheet.Cells[_row + i,85 ].Value = decimal.Parse(dt.Rows[i]["ratio41"].ToString());
				}
				if (dt.Rows[i]["ratio42"].ToString() != "")
				{
					exSheet.Cells[_row + i,87 ].Value = decimal.Parse(dt.Rows[i]["ratio42"].ToString());
				}
				if (dt.Rows[i]["ratio43"].ToString() != "")
				{
					exSheet.Cells[_row + i,89 ].Value = decimal.Parse(dt.Rows[i]["ratio43"].ToString());
				}
				if (dt.Rows[i]["ratio44"].ToString() != "")
				{
					exSheet.Cells[_row + i,91 ].Value = decimal.Parse(dt.Rows[i]["ratio44"].ToString());
				}
				if (dt.Rows[i]["ratio45"].ToString() != "")
				{
					exSheet.Cells[_row + i,93 ].Value = decimal.Parse(dt.Rows[i]["ratio45"].ToString());
				}
				if (dt.Rows[i]["ratio46"].ToString() != "")
				{
					exSheet.Cells[_row + i,95 ].Value = decimal.Parse(dt.Rows[i]["ratio46"].ToString());
				}
				if (dt.Rows[i]["ratio47"].ToString() != "")
				{
					exSheet.Cells[_row + i,97 ].Value = decimal.Parse(dt.Rows[i]["ratio47"].ToString());
				}
				if (dt.Rows[i]["ratio48"].ToString() != "")
				{
					exSheet.Cells[_row + i,99 ].Value = decimal.Parse(dt.Rows[i]["ratio48"].ToString());
				}
				if (dt.Rows[i]["ratio49"].ToString() != "")
				{
					exSheet.Cells[_row + i, 101].Value = decimal.Parse(dt.Rows[i]["ratio49"].ToString());
				}
				if (dt.Rows[i]["ratio50"].ToString() != "")
				{
					exSheet.Cells[_row + i,103 ].Value = decimal.Parse(dt.Rows[i]["ratio50"].ToString());
				}
				if (dt.Rows[i]["ratio51"].ToString() != "")
				{
					exSheet.Cells[_row + i,105 ].Value = decimal.Parse(dt.Rows[i]["ratio51"].ToString());
				}
				if (dt.Rows[i]["ratio52"].ToString() != "")
				{
					exSheet.Cells[_row + i, 107].Value = decimal.Parse(dt.Rows[i]["ratio52"].ToString());
				}
				if (dt.Rows[i]["ratio53"].ToString() != "")
				{
					exSheet.Cells[_row + i,109 ].Value = decimal.Parse(dt.Rows[i]["ratio53"].ToString());
				}
				if (dt.Rows[i]["ratio54"].ToString() != "")
				{
					exSheet.Cells[_row + i,111].Value = decimal.Parse(dt.Rows[i]["ratio54"].ToString());
				}
				if (dt.Rows[i]["ratio55"].ToString() != "")
				{
					exSheet.Cells[_row + i,113 ].Value = decimal.Parse(dt.Rows[i]["ratio55"].ToString());
				}
				if (dt.Rows[i]["ratio56"].ToString() != "")
				{
					exSheet.Cells[_row + i,115 ].Value = decimal.Parse(dt.Rows[i]["ratio56"].ToString());
				}
				if (dt.Rows[i]["ratio57"].ToString() != "")
				{
					exSheet.Cells[_row + i,117 ].Value = decimal.Parse(dt.Rows[i]["ratio57"].ToString());
				}
				if (dt.Rows[i]["ratio58"].ToString() != "")
				{
					exSheet.Cells[_row + i,119 ].Value = decimal.Parse(dt.Rows[i]["ratio58"].ToString());
				}
				if (dt.Rows[i]["ratio59"].ToString() != "")
				{
					exSheet.Cells[_row + i,121 ].Value = decimal.Parse(dt.Rows[i]["ratio59"].ToString());
				}
				if (dt.Rows[i]["ratio60"].ToString() != "")
				{
					exSheet.Cells[_row + i,123 ].Value = decimal.Parse(dt.Rows[i]["ratio60"].ToString());
				}
				if (dt.Rows[i]["ratio61"].ToString() != "")
				{
					exSheet.Cells[_row + i, 125].Value = decimal.Parse(dt.Rows[i]["ratio61"].ToString());
				}
				if (dt.Rows[i]["ratio62"].ToString() != "")
				{
					exSheet.Cells[_row + i, 127].Value = decimal.Parse(dt.Rows[i]["ratio62"].ToString());
				}
				if (dt.Rows[i]["ratio63"].ToString() != "")
				{
					exSheet.Cells[_row + i,129 ].Value = decimal.Parse(dt.Rows[i]["ratio63"].ToString());
				}
				if (dt.Rows[i]["ratio64"].ToString() != "")
				{
					exSheet.Cells[_row + i,131 ].Value = decimal.Parse(dt.Rows[i]["ratio64"].ToString());
				}
				if (dt.Rows[i]["ratio65"].ToString() != "")
				{
					exSheet.Cells[_row + i,133 ].Value = decimal.Parse(dt.Rows[i]["ratio65"].ToString());
				}
				if (dt.Rows[i]["ratio66"].ToString() != "")
				{
					exSheet.Cells[_row + i,135 ].Value = decimal.Parse(dt.Rows[i]["ratio66"].ToString());
				}
				if (dt.Rows[i]["ratio67"].ToString() != "")
				{
					exSheet.Cells[_row + i,137 ].Value = decimal.Parse(dt.Rows[i]["ratio67"].ToString());
				}
				if (dt.Rows[i]["ratio68"].ToString() != "")
				{
					exSheet.Cells[_row + i,139 ].Value = decimal.Parse(dt.Rows[i]["ratio68"].ToString());
				}
				if (dt.Rows[i]["ratio69"].ToString() != "")
				{
					exSheet.Cells[_row + i,141 ].Value = decimal.Parse(dt.Rows[i]["ratio69"].ToString());
				}
				if (dt.Rows[i]["ratio70"].ToString() != "")
				{
					exSheet.Cells[_row + i,143 ].Value = decimal.Parse(dt.Rows[i]["ratio70"].ToString());
				}
				if (dt.Rows[i]["ratio71"].ToString() != "")
				{
					exSheet.Cells[_row + i,145 ].Value = decimal.Parse(dt.Rows[i]["ratio71"].ToString());
				}
				if (dt.Rows[i]["ratio72"].ToString() != "")
				{
					exSheet.Cells[_row + i,147 ].Value = decimal.Parse(dt.Rows[i]["ratio72"].ToString());
				}
				if (dt.Rows[i]["ratio73"].ToString() != "")
				{
					exSheet.Cells[_row + i,149 ].Value = decimal.Parse(dt.Rows[i]["ratio73"].ToString());
				}
				if (dt.Rows[i]["ratio74"].ToString() != "")
				{
					exSheet.Cells[_row + i,151 ].Value = decimal.Parse(dt.Rows[i]["ratio74"].ToString());
				}
				if (dt.Rows[i]["ratio75"].ToString() != "")
				{
					exSheet.Cells[_row + i, 153].Value = decimal.Parse(dt.Rows[i]["ratio75"].ToString());
				}
				if (dt.Rows[i]["ratio76"].ToString() != "")
				{
					exSheet.Cells[_row + i, 155].Value = decimal.Parse(dt.Rows[i]["ratio76"].ToString());
				}
				if (dt.Rows[i]["ratio77"].ToString() != "")
				{
					exSheet.Cells[_row + i,157 ].Value = decimal.Parse(dt.Rows[i]["ratio77"].ToString());
				}
				if (dt.Rows[i]["ratio78"].ToString() != "")
				{
					exSheet.Cells[_row + i, 159].Value = decimal.Parse(dt.Rows[i]["ratio78"].ToString());
				}
				if (dt.Rows[i]["ratio79"].ToString() != "")
				{
					exSheet.Cells[_row + i,161 ].Value = decimal.Parse(dt.Rows[i]["ratio79"].ToString());
				}
				if (dt.Rows[i]["ratio80"].ToString() != "")
				{
					exSheet.Cells[_row + i, 163].Value = decimal.Parse(dt.Rows[i]["ratio80"].ToString());
				}
				if (dt.Rows[i]["ratio81"].ToString() != "")
				{
					exSheet.Cells[_row + i,165 ].Value = decimal.Parse(dt.Rows[i]["ratio81"].ToString());
				}
				if (dt.Rows[i]["ratio82"].ToString() != "")
				{
					exSheet.Cells[_row + i,167 ].Value = decimal.Parse(dt.Rows[i]["ratio82"].ToString());
				}
				if (dt.Rows[i]["ratio83"].ToString() != "")
				{
					exSheet.Cells[_row + i,169 ].Value = decimal.Parse(dt.Rows[i]["ratio83"].ToString());
				}
				if (dt.Rows[i]["ratio84"].ToString() != "")
				{
					exSheet.Cells[_row + i,171 ].Value = decimal.Parse(dt.Rows[i]["ratio84"].ToString());
				}
				if (dt.Rows[i]["ratio85"].ToString() != "")
				{
					exSheet.Cells[_row + i, 173].Value = decimal.Parse(dt.Rows[i]["ratio85"].ToString());
				}
				if (dt.Rows[i]["ratio86"].ToString() != "")
				{
					exSheet.Cells[_row + i,175 ].Value = decimal.Parse(dt.Rows[i]["ratio86"].ToString());
				}
				if (dt.Rows[i]["ratio87"].ToString() != "")
				{
					exSheet.Cells[_row + i,177].Value = decimal.Parse(dt.Rows[i]["ratio87"].ToString());
				}
				if (dt.Rows[i]["ratio88"].ToString() != "")
				{
					exSheet.Cells[_row + i, 179].Value = decimal.Parse(dt.Rows[i]["ratio88"].ToString());
				}
				if (dt.Rows[i]["ratio89"].ToString() != "")
				{
					exSheet.Cells[_row + i, 181].Value = decimal.Parse(dt.Rows[i]["ratio89"].ToString());
				}
				if (dt.Rows[i]["ratio90"].ToString() != "")
				{
					exSheet.Cells[_row + i,183 ].Value = decimal.Parse(dt.Rows[i]["ratio90"].ToString());
				}
				if (dt.Rows[i]["ratio91"].ToString() != "")
				{
					exSheet.Cells[_row + i,185 ].Value = decimal.Parse(dt.Rows[i]["ratio91"].ToString());
				}
				if (dt.Rows[i]["ratio92"].ToString() != "")
				{
					exSheet.Cells[_row + i,187 ].Value = decimal.Parse(dt.Rows[i]["ratio92"].ToString());
				}
				if (dt.Rows[i]["ratio93"].ToString() != "")
				{
					exSheet.Cells[_row + i,189 ].Value = decimal.Parse(dt.Rows[i]["ratio93"].ToString());
				}
				if (dt.Rows[i]["ratio94"].ToString() != "")
				{
					exSheet.Cells[_row + i,191 ].Value = decimal.Parse(dt.Rows[i]["ratio94"].ToString());
				}
				if (dt.Rows[i]["ratio95"].ToString() != "")
				{
					exSheet.Cells[_row + i,193 ].Value = decimal.Parse(dt.Rows[i]["ratio95"].ToString());
				}
				if (dt.Rows[i]["ratio96"].ToString() != "")
				{
					exSheet.Cells[_row + i,195 ].Value = decimal.Parse(dt.Rows[i]["ratio96"].ToString());
				}
				if (dt.Rows[i]["ratio97"].ToString() != "")
				{
					exSheet.Cells[_row + i,197 ].Value = decimal.Parse(dt.Rows[i]["ratio97"].ToString());
				}
				if (dt.Rows[i]["ratio98"].ToString() != "")
				{
					exSheet.Cells[_row + i,199 ].Value = decimal.Parse(dt.Rows[i]["ratio98"].ToString());
				}
				if (dt.Rows[i]["ratio99"].ToString() != "")
				{
					exSheet.Cells[_row + i, 201].Value = decimal.Parse(dt.Rows[i]["ratio99"].ToString());
				}
				if (dt.Rows[i]["num1"].ToString() != "")
				{
					exSheet.Cells[_row + i, 4].Value = decimal.Parse(dt.Rows[i]["num1"].ToString());
					exSheet.Cells[_row + i,4].NumberFormat = p_xls_ccy_format;
				}
				
				if (dt.Rows[i]["num2"].ToString() != "")
				{
					exSheet.Cells[_row + i, 6].Value = decimal.Parse(dt.Rows[i]["num2"].ToString());
					exSheet.Cells[_row + i,6].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num3"].ToString() != "")
				{
					exSheet.Cells[_row + i, 8].Value = decimal.Parse(dt.Rows[i]["num3"].ToString());
					exSheet.Cells[_row + i,8].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num4"].ToString() != "")
				{
					exSheet.Cells[_row + i,10].Value = decimal.Parse(dt.Rows[i]["num4"].ToString());
					exSheet.Cells[_row + i,10].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num5"].ToString() != "")
				{
					exSheet.Cells[_row + i,12].Value = decimal.Parse(dt.Rows[i]["num5"].ToString());
					exSheet.Cells[_row + i,12].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num6"].ToString() != "")
				{
					exSheet.Cells[_row + i,14].Value = decimal.Parse(dt.Rows[i]["num6"].ToString());
					exSheet.Cells[_row + i,14].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num7"].ToString() != "")
				{
					exSheet.Cells[_row + i,16].Value = decimal.Parse(dt.Rows[i]["num7"].ToString());
					exSheet.Cells[_row + i,16].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num8"].ToString() != "")
				{
					exSheet.Cells[_row + i,18].Value = decimal.Parse(dt.Rows[i]["num8"].ToString());
					exSheet.Cells[_row + i,18].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num9"].ToString() != "")
				{
					exSheet.Cells[_row + i,20].Value = decimal.Parse(dt.Rows[i]["num9"].ToString());
					exSheet.Cells[_row + i,20].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num10"].ToString() != "")
				{
					exSheet.Cells[_row + i,22].Value = decimal.Parse(dt.Rows[i]["num10"].ToString());
					exSheet.Cells[_row + i,22].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num11"].ToString() != "")
				{
					exSheet.Cells[_row + i,24].Value = decimal.Parse(dt.Rows[i]["num11"].ToString());
					exSheet.Cells[_row + i,24].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num12"].ToString() != "")
				{
					exSheet.Cells[_row + i,26].Value = decimal.Parse(dt.Rows[i]["num12"].ToString());
					exSheet.Cells[_row + i,26].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num12"].ToString() != "")
				{
					exSheet.Cells[_row + i,28].Value = decimal.Parse(dt.Rows[i]["num12"].ToString());
					exSheet.Cells[_row + i,28].NumberFormat = p_xls_ccy_format;
				}
				
				if (dt.Rows[i]["num13"].ToString() != "")
				{
					exSheet.Cells[_row + i,30].Value = decimal.Parse(dt.Rows[i]["num13"].ToString());
					exSheet.Cells[_row + i,30].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num14"].ToString() != "")
				{
					exSheet.Cells[_row + i,32].Value = decimal.Parse(dt.Rows[i]["num14"].ToString());
					exSheet.Cells[_row + i,32].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num15"].ToString() != "")
				{
					exSheet.Cells[_row + i,34].Value = decimal.Parse(dt.Rows[i]["num15"].ToString());
					exSheet.Cells[_row + i,34].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num16"].ToString() != "")
				{
					exSheet.Cells[_row + i,36].Value = decimal.Parse(dt.Rows[i]["num16"].ToString());
					exSheet.Cells[_row + i,36].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num17"].ToString() != "")
				{
					exSheet.Cells[_row + i,38].Value = decimal.Parse(dt.Rows[i]["num17"].ToString());
					exSheet.Cells[_row + i,38].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num18"].ToString() != "")
				{
					exSheet.Cells[_row + i,40].Value = decimal.Parse(dt.Rows[i]["num18"].ToString());
					exSheet.Cells[_row + i,40].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num19"].ToString() != "")
				{
					exSheet.Cells[_row + i,42].Value = decimal.Parse(dt.Rows[i]["num19"].ToString());
					exSheet.Cells[_row + i,42].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num20"].ToString() != "")
				{
					exSheet.Cells[_row + i,44].Value = decimal.Parse(dt.Rows[i]["num20"].ToString());
					exSheet.Cells[_row + i,44].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num22"].ToString() != "")
				{
					exSheet.Cells[_row + i,46].Value = decimal.Parse(dt.Rows[i]["num22"].ToString());
					exSheet.Cells[_row + i,46].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num23"].ToString() != "")
				{
					exSheet.Cells[_row + i,48].Value = decimal.Parse(dt.Rows[i]["num23"].ToString());
					exSheet.Cells[_row + i,48].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num24"].ToString() != "")
				{
					exSheet.Cells[_row + i,50].Value = decimal.Parse(dt.Rows[i]["num24"].ToString());
					exSheet.Cells[_row + i,50].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num25"].ToString() != "")
				{
					exSheet.Cells[_row + i,52].Value = decimal.Parse(dt.Rows[i]["num25"].ToString());
					exSheet.Cells[_row + i,52].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num26"].ToString() != "")
				{
					exSheet.Cells[_row + i,54].Value = decimal.Parse(dt.Rows[i]["num26"].ToString());
					exSheet.Cells[_row + i,54].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num27"].ToString() != "")
				{
					exSheet.Cells[_row + i,56].Value = decimal.Parse(dt.Rows[i]["num27"].ToString());
					exSheet.Cells[_row + i,56].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num28"].ToString() != "")
				{
					exSheet.Cells[_row + i,58].Value = decimal.Parse(dt.Rows[i]["num28"].ToString());
					exSheet.Cells[_row + i,58].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num29"].ToString() != "")
				{
					exSheet.Cells[_row + i,60].Value = decimal.Parse(dt.Rows[i]["num29"].ToString());
					exSheet.Cells[_row + i,60].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num30"].ToString() != "")
				{
					exSheet.Cells[_row + i,62].Value = decimal.Parse(dt.Rows[i]["num30"].ToString());
					exSheet.Cells[_row + i,62].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num31"].ToString() != "")
				{
					exSheet.Cells[_row + i,64].Value = decimal.Parse(dt.Rows[i]["num31"].ToString());
					exSheet.Cells[_row + i,64].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num32"].ToString() != "")
				{
					exSheet.Cells[_row + i,66].Value = decimal.Parse(dt.Rows[i]["num32"].ToString());
					exSheet.Cells[_row + i,66].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num33"].ToString() != "")
				{
					exSheet.Cells[_row + i,68].Value = decimal.Parse(dt.Rows[i]["num33"].ToString());
					exSheet.Cells[_row + i,68].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num34"].ToString() != "")
				{
					exSheet.Cells[_row + i,70].Value = decimal.Parse(dt.Rows[i]["num34"].ToString());
					exSheet.Cells[_row + i,70].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num35"].ToString() != "")
				{
					exSheet.Cells[_row + i,72].Value = decimal.Parse(dt.Rows[i]["num35"].ToString());
					exSheet.Cells[_row + i,72].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num36"].ToString() != "")
				{
					exSheet.Cells[_row + i,74].Value = decimal.Parse(dt.Rows[i]["num36"].ToString());
					exSheet.Cells[_row + i,74].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num37"].ToString() != "")
				{
					exSheet.Cells[_row + i,76].Value = decimal.Parse(dt.Rows[i]["num37"].ToString());
					exSheet.Cells[_row + i,76].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num38"].ToString() != "")
				{
					exSheet.Cells[_row + i,78].Value = decimal.Parse(dt.Rows[i]["num38"].ToString());
					exSheet.Cells[_row + i,78].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num39"].ToString() != "")
				{
					exSheet.Cells[_row + i,80].Value = decimal.Parse(dt.Rows[i]["num39"].ToString());
					exSheet.Cells[_row + i,80].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num40"].ToString() != "")
				{
					exSheet.Cells[_row + i,82].Value = decimal.Parse(dt.Rows[i]["num40"].ToString());
					exSheet.Cells[_row + i,82].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num41"].ToString() != "")
				{
					exSheet.Cells[_row + i,84].Value = decimal.Parse(dt.Rows[i]["num41"].ToString());
					exSheet.Cells[_row + i,84].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num42"].ToString() != "")
				{
					exSheet.Cells[_row + i,86].Value = decimal.Parse(dt.Rows[i]["num42"].ToString());
					exSheet.Cells[_row + i,86].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num43"].ToString() != "")
				{
					exSheet.Cells[_row + i,88].Value = decimal.Parse(dt.Rows[i]["num43"].ToString());
					exSheet.Cells[_row + i,88].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num44"].ToString() != "")
				{
					exSheet.Cells[_row + i,90].Value = decimal.Parse(dt.Rows[i]["num44"].ToString());
					exSheet.Cells[_row + i,90].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num45"].ToString() != "")
				{
					exSheet.Cells[_row + i,92].Value = decimal.Parse(dt.Rows[i]["num45"].ToString());
					exSheet.Cells[_row + i,92].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num46"].ToString() != "")
				{
					exSheet.Cells[_row + i,94].Value = decimal.Parse(dt.Rows[i]["num46"].ToString());
					exSheet.Cells[_row + i,94].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num47"].ToString() != "")
				{
					exSheet.Cells[_row + i,96].Value = decimal.Parse(dt.Rows[i]["num47"].ToString());
					exSheet.Cells[_row + i,96].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num48"].ToString() != "")
				{
					exSheet.Cells[_row + i,98].Value = decimal.Parse(dt.Rows[i]["num48"].ToString());
					exSheet.Cells[_row + i,98].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num49"].ToString() != "")
				{
					exSheet.Cells[_row + i,100].Value = decimal.Parse(dt.Rows[i]["num49"].ToString());
					exSheet.Cells[_row + i,100].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num50"].ToString() != "")
				{
					exSheet.Cells[_row + i,102].Value = decimal.Parse(dt.Rows[i]["num50"].ToString());
					exSheet.Cells[_row + i,102].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num51"].ToString() != "")
				{
					exSheet.Cells[_row + i,104].Value = decimal.Parse(dt.Rows[i]["num51"].ToString());
					exSheet.Cells[_row + i,104].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num52"].ToString() != "")
				{
					exSheet.Cells[_row + i,106].Value = decimal.Parse(dt.Rows[i]["num52"].ToString());
					exSheet.Cells[_row + i,106].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num53"].ToString() != "")
				{
					exSheet.Cells[_row + i,108].Value = decimal.Parse(dt.Rows[i]["num53"].ToString());
					exSheet.Cells[_row + i,108].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num54"].ToString() != "")
				{
					exSheet.Cells[_row + i,110].Value = decimal.Parse(dt.Rows[i]["num54"].ToString());
					exSheet.Cells[_row + i,110].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num55"].ToString() != "")
				{
					exSheet.Cells[_row + i,112].Value = decimal.Parse(dt.Rows[i]["num55"].ToString());
					exSheet.Cells[_row + i,112].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num56"].ToString() != "")
				{
					exSheet.Cells[_row + i,114].Value = decimal.Parse(dt.Rows[i]["num56"].ToString());
					exSheet.Cells[_row + i,114].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num57"].ToString() != "")
				{
					exSheet.Cells[_row + i,116].Value = decimal.Parse(dt.Rows[i]["num57"].ToString());
					exSheet.Cells[_row + i,116].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num58"].ToString() != "")
				{
					exSheet.Cells[_row + i,118].Value = decimal.Parse(dt.Rows[i]["num58"].ToString());
					exSheet.Cells[_row + i,118].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num59"].ToString() != "")
				{
					exSheet.Cells[_row + i,120].Value = decimal.Parse(dt.Rows[i]["num59"].ToString());
					exSheet.Cells[_row + i,120].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num60"].ToString() != "")
				{
					exSheet.Cells[_row + i,122].Value = decimal.Parse(dt.Rows[i]["num60"].ToString());
					exSheet.Cells[_row + i,122].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num61"].ToString() != "")
				{
					exSheet.Cells[_row + i,124].Value = decimal.Parse(dt.Rows[i]["num61"].ToString());
					exSheet.Cells[_row + i,124].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num62"].ToString() != "")
				{
					exSheet.Cells[_row + i,126].Value = decimal.Parse(dt.Rows[i]["num62"].ToString());
					exSheet.Cells[_row + i,126].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num63"].ToString() != "")
				{
					exSheet.Cells[_row + i,128].Value = decimal.Parse(dt.Rows[i]["num63"].ToString());
					exSheet.Cells[_row + i,128].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num64"].ToString() != "")
				{
					exSheet.Cells[_row + i,130].Value = decimal.Parse(dt.Rows[i]["num64"].ToString());
					exSheet.Cells[_row + i,130].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num65"].ToString() != "")
				{
					exSheet.Cells[_row + i,132].Value = decimal.Parse(dt.Rows[i]["num65"].ToString());
					exSheet.Cells[_row + i,132].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num66"].ToString() != "")
				{
					exSheet.Cells[_row + i,134].Value = decimal.Parse(dt.Rows[i]["num66"].ToString());
					exSheet.Cells[_row + i,134].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num67"].ToString() != "")
				{
					exSheet.Cells[_row + i,136].Value = decimal.Parse(dt.Rows[i]["num67"].ToString());
					exSheet.Cells[_row + i,136].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num68"].ToString() != "")
				{
					exSheet.Cells[_row + i,138].Value = decimal.Parse(dt.Rows[i]["num68"].ToString());
					exSheet.Cells[_row + i,138].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num69"].ToString() != "")
				{
					exSheet.Cells[_row + i,140].Value = decimal.Parse(dt.Rows[i]["num69"].ToString());
					exSheet.Cells[_row + i,140].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num70"].ToString() != "")
				{
					exSheet.Cells[_row + i,142].Value = decimal.Parse(dt.Rows[i]["num70"].ToString());
					exSheet.Cells[_row + i,142].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num71"].ToString() != "")
				{
					exSheet.Cells[_row + i,144].Value = decimal.Parse(dt.Rows[i]["num71"].ToString());
					exSheet.Cells[_row + i,144].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num72"].ToString() != "")
				{
					exSheet.Cells[_row + i,146].Value = decimal.Parse(dt.Rows[i]["num72"].ToString());
					exSheet.Cells[_row + i,146].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num73"].ToString() != "")
				{
					exSheet.Cells[_row + i,148].Value = decimal.Parse(dt.Rows[i]["num73"].ToString());
					exSheet.Cells[_row + i,148].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num74"].ToString() != "")
				{
					exSheet.Cells[_row + i,150].Value = decimal.Parse(dt.Rows[i]["num74"].ToString());
					exSheet.Cells[_row + i,150].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num75"].ToString() != "")
				{
					exSheet.Cells[_row + i,152].Value = decimal.Parse(dt.Rows[i]["num75"].ToString());
					exSheet.Cells[_row + i,152].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num76"].ToString() != "")
				{
					exSheet.Cells[_row + i,154].Value = decimal.Parse(dt.Rows[i]["num76"].ToString());
					exSheet.Cells[_row + i,154].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num77"].ToString() != "")
				{
					exSheet.Cells[_row + i,156].Value = decimal.Parse(dt.Rows[i]["num77"].ToString());
					exSheet.Cells[_row + i,156].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num78"].ToString() != "")
				{
					exSheet.Cells[_row + i,158].Value = decimal.Parse(dt.Rows[i]["num78"].ToString());
					exSheet.Cells[_row + i,158].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num79"].ToString() != "")
				{
					exSheet.Cells[_row + i,160].Value = decimal.Parse(dt.Rows[i]["num79"].ToString());
					exSheet.Cells[_row + i,160].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num80"].ToString() != "")
				{
					exSheet.Cells[_row + i,162].Value = decimal.Parse(dt.Rows[i]["num80"].ToString());
					exSheet.Cells[_row + i,162].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num81"].ToString() != "")
				{
					exSheet.Cells[_row + i,164].Value = decimal.Parse(dt.Rows[i]["num81"].ToString());
					exSheet.Cells[_row + i,164].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num82"].ToString() != "")
				{
					exSheet.Cells[_row + i,166].Value = decimal.Parse(dt.Rows[i]["num82"].ToString());
					exSheet.Cells[_row + i,166].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num83"].ToString() != "")
				{
					exSheet.Cells[_row + i,168].Value = decimal.Parse(dt.Rows[i]["num83"].ToString());
					exSheet.Cells[_row + i,168].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num84"].ToString() != "")
				{
					exSheet.Cells[_row + i,170].Value = decimal.Parse(dt.Rows[i]["num84"].ToString());
					exSheet.Cells[_row + i,170].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num85"].ToString() != "")
				{
					exSheet.Cells[_row + i,172].Value = decimal.Parse(dt.Rows[i]["num85"].ToString());
					exSheet.Cells[_row + i,172].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num86"].ToString() != "")
				{
					exSheet.Cells[_row + i,174].Value = decimal.Parse(dt.Rows[i]["num86"].ToString());
					exSheet.Cells[_row + i,174].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num87"].ToString() != "")
				{
					exSheet.Cells[_row + i,176].Value = decimal.Parse(dt.Rows[i]["num87"].ToString());
					exSheet.Cells[_row + i,176].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num88"].ToString() != "")
				{
					exSheet.Cells[_row + i,178].Value = decimal.Parse(dt.Rows[i]["num88"].ToString());
					exSheet.Cells[_row + i,178].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num89"].ToString() != "")
				{
					exSheet.Cells[_row + i,180].Value = decimal.Parse(dt.Rows[i]["num89"].ToString());
					exSheet.Cells[_row + i,180].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num90"].ToString() != "")
				{
					exSheet.Cells[_row + i,182].Value = decimal.Parse(dt.Rows[i]["num90"].ToString());
					exSheet.Cells[_row + i,182].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num91"].ToString() != "")
				{
					exSheet.Cells[_row + i,184].Value = decimal.Parse(dt.Rows[i]["num91"].ToString());
					exSheet.Cells[_row + i,184].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num92"].ToString() != "")
				{
					exSheet.Cells[_row + i,186].Value = decimal.Parse(dt.Rows[i]["num92"].ToString());
					exSheet.Cells[_row + i,186].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num93"].ToString() != "")
				{
					exSheet.Cells[_row + i,188].Value = decimal.Parse(dt.Rows[i]["num93"].ToString());
					exSheet.Cells[_row + i,188].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num94"].ToString() != "")
				{
					exSheet.Cells[_row + i,190].Value = decimal.Parse(dt.Rows[i]["num94"].ToString());
					exSheet.Cells[_row + i,190].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num95"].ToString() != "")
				{
					exSheet.Cells[_row + i,192].Value = decimal.Parse(dt.Rows[i]["num95"].ToString());
					exSheet.Cells[_row + i,192].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num96"].ToString() != "")
				{
					exSheet.Cells[_row + i,194].Value = decimal.Parse(dt.Rows[i]["num96"].ToString());
					exSheet.Cells[_row + i,194].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num97"].ToString() != "")
				{
					exSheet.Cells[_row + i,196].Value = decimal.Parse(dt.Rows[i]["num97"].ToString());
					exSheet.Cells[_row + i,196].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num98"].ToString() != "")
				{
					exSheet.Cells[_row + i,198].Value = decimal.Parse(dt.Rows[i]["num98"].ToString());
					exSheet.Cells[_row + i,198].NumberFormat = p_xls_ccy_format;
				}
				if (dt.Rows[i]["num99"].ToString() != "")
				{
					exSheet.Cells[_row + i,200].Value = decimal.Parse(dt.Rows[i]["num99"].ToString());
					exSheet.Cells[_row + i,200].NumberFormat = p_xls_ccy_format;
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