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

public partial class rpt_fppr00080_fose01 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        ESysLib.SetUser(Session["APP_DBUSER"].ToString());
		//ESysLib.SetUser("SALE");

        string TemplateFile = "rpt_fppr00080_fose01.xls";
        string TempFile = "../../../system/temp/rpt_fppr00080_fose01_" + Session["User_ID"].ToString() + ".xls";
        TemplateFile = Server.MapPath(TemplateFile);
        TempFile = Server.MapPath(TempFile);

        //Create a new workbook
        IWorkbook exBook = NativeExcel.Factory.OpenWorkbook(TemplateFile);

        //Add worksheet
        IWorksheet exSheet = exBook.Worksheets[1];

        IRange range;

        //bind data to excel file
		 
        string     p_month = Request["p_month"];
		string     p_wh = Request["p_wh"];
         
        string para = "'" + p_wh + "','" + p_month + "'";		
		DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080", para);		  
		
		//string p_tlg_in_warehouse_pk =Request["p_tlg_in_warehouse_pk"];
        //string p_month1 = Request["p_month1"];
		
		//string para1 = "'" + p_tlg_in_warehouse_pk + "','" + p_month1 + "'";		
		DataTable dt1 = ESysLib.TableReadOpenCursor("lg_rpt_fppr00080_week", para);
        // MASTER  
		if(dt.Rows.Count > 0)
		{
			exSheet.Cells["BO5"].Value = dt.Rows[0]["mor_price_kor"];
			exSheet.Cells["BP5"].Value = dt.Rows[0]["mor_price"];
			exSheet.Cells["BS5"].Value = dt.Rows[0]["lun_price_kor"];
			exSheet.Cells["BT5"].Value = dt.Rows[0]["lun_price"];
			exSheet.Cells["BW5"].Value = dt.Rows[0]["din_price_kor"];
			exSheet.Cells["BX5"].Value = dt.Rows[0]["din_price"];
			exSheet.Cells["CA5"].Value = dt.Rows[0]["nig_price_kor"];
			exSheet.Cells["CB5"].Value = dt.Rows[0]["nig_price"];
       }
		//if( dt.Rows.Count >0)
		//{
			// exSheet.Cells["h6"].Value =dt.Rows[0]["slip_no"];
			// //exSheet.Cells["h7"].Value = "No/dr ";//+dt.Rows[0]["req_date"];
			// //exSheet.Cells["h8"].Value = "Co/cr";//;+dt.Rows[0]["dept_name"];
			// exSheet.Cells["e8"].Value =dt.Rows[0]["dd"];
			// exSheet.Cells["f8"].Value =dt.Rows[0]["mm"];
			// exSheet.Cells["h8"].Value =dt.Rows[0]["yy"];
			// exSheet.Cells["e9"].Value =dt.Rows[0]["partner_name"];
			// exSheet.Cells["e10"].Value =dt.Rows[0]["ref_no"];
			// exSheet.Cells["d11"].Value =dt.Rows[0]["in_date"];
			// exSheet.Cells["e12"].Value =dt.Rows[0]["wh_nm"];
			
			
		//}
		
		// INSERT ROWS
		 
		for (int l_addrow = 0; l_addrow < dt.Rows.Count-1; l_addrow++)
		{
         exSheet.Range["A7"].Rows.EntireRow.Insert();//insert row new of sheet
		}
						
		// SET DATA
		int pos = 6;
		int i   = 0  ;		  			
	
		for (i = 0; i < dt.Rows.Count; i++)
        {	
			exSheet.Cells[pos + i, 1 ].Value = dt.Rows[i]["prod_date"];
			exSheet.Cells[pos + i, 2 ].Value = dt.Rows[i]["hq_sang"]; 
			exSheet.Cells[pos + i, 3 ].Value = dt.Rows[i]["lon_sang"];	
			exSheet.Cells[pos + i, 4].Value = dt.Rows[i]["bo_sang"];			
			exSheet.Cells[pos + i, 5].Value = dt.Rows[i]["ga_sang"]; 
			exSheet.Cells[pos + i, 6].Value = dt.Rows[i]["ca_sang"]; 
			exSheet.Cells[pos + i, 7].Value = dt.Rows[i]["bp_sang"]; 
			exSheet.Cells[pos + i, 8].Value = dt.Rows[i]["cr_sang"]; 
			exSheet.Cells[pos + i, 9].Value = dt.Rows[i]["chao_sang"]; 
			exSheet.Cells[pos + i, 10].Value = dt.Rows[i]["banh_sang"]; 
			exSheet.Cells[pos + i, 11].Value = dt.Rows[i]["trung_sang"]; 
			exSheet.Cells[pos + i,12].Value = dt.Rows[i]["tiec_sang"]; 
			exSheet.Cells[pos + i,13].Value = dt.Rows[i]["total_sang"]; 
			
			exSheet.Cells[pos + i,14].Value = dt.Rows[i]["hq_trua"]; 
			exSheet.Cells[pos + i,15].Value = dt.Rows[i]["lon_trua"]; 
			exSheet.Cells[pos + i,16].Value = dt.Rows[i]["bo_trua"]; 
			exSheet.Cells[pos + i,17].Value = dt.Rows[i]["ga_trua"]; 
			exSheet.Cells[pos + i,18].Value = dt.Rows[i]["ca_trua"]; 
			exSheet.Cells[pos + i,19].Value = dt.Rows[i]["bp_trua"]; 
			exSheet.Cells[pos + i,20].Value = dt.Rows[i]["cr_trua"]; 
			exSheet.Cells[pos + i,21].Value = dt.Rows[i]["chao_trua"]; 
			exSheet.Cells[pos + i,22].Value = dt.Rows[i]["banh_trua"]; 
			exSheet.Cells[pos + i,23].Value = dt.Rows[i]["trung_trua"]; 
			exSheet.Cells[pos + i,24].Value = dt.Rows[i]["tiec_trua"]; 
			exSheet.Cells[pos + i,25].Value = dt.Rows[i]["total_trua"];
			
			exSheet.Cells[pos + i,26].Value = dt.Rows[i]["hq_chieu"]; 
			exSheet.Cells[pos + i,27].Value = dt.Rows[i]["lon_chieu"]; 
			exSheet.Cells[pos + i,28].Value = dt.Rows[i]["bo_chieu"]; 
			exSheet.Cells[pos + i,29].Value = dt.Rows[i]["ga_chieu"]; 
			exSheet.Cells[pos + i,30].Value = dt.Rows[i]["ca_chieu"]; 
			exSheet.Cells[pos + i,31].Value = dt.Rows[i]["bp_chieu"]; 
			exSheet.Cells[pos + i,32].Value = dt.Rows[i]["cr_chieu"]; 
			exSheet.Cells[pos + i,33].Value = dt.Rows[i]["chao_chieu"]; 
			exSheet.Cells[pos + i,34].Value = dt.Rows[i]["banh_chieu"]; 
			exSheet.Cells[pos + i,35].Value = dt.Rows[i]["trung_chieu"]; 
			exSheet.Cells[pos + i,36].Value = dt.Rows[i]["tiec_chieu"]; 
			exSheet.Cells[pos + i,37].Value = dt.Rows[i]["total_chieu"];
			
			exSheet.Cells[pos + i,38].Value = dt.Rows[i]["hq_toi"]; 
			exSheet.Cells[pos + i,39].Value = dt.Rows[i]["lon_toi"]; 
			exSheet.Cells[pos + i,40].Value = dt.Rows[i]["bo_toi"]; 
			exSheet.Cells[pos + i,41].Value = dt.Rows[i]["ga_toi"]; 
			exSheet.Cells[pos + i,42].Value = dt.Rows[i]["ca_toi"]; 
			exSheet.Cells[pos + i,43].Value = dt.Rows[i]["bp_toi"];
			exSheet.Cells[pos + i,44].Value = dt.Rows[i]["cr_toi"]; 
			exSheet.Cells[pos + i,45].Value = dt.Rows[i]["chao_toi"]; 
			exSheet.Cells[pos + i,46].Value = dt.Rows[i]["banh_toi"]; 
			exSheet.Cells[pos + i,47].Value = dt.Rows[i]["trung_toi"]; 
			exSheet.Cells[pos + i,48].Value = dt.Rows[i]["tiec_toi"]; 
			exSheet.Cells[pos + i,49].Value = dt.Rows[i]["total_toi"]; 
			
			exSheet.Cells[pos + i,50].Value = dt.Rows[i]["hq_total"]; 
			exSheet.Cells[pos + i,51].Value = dt.Rows[i]["lon_total"]; 
			exSheet.Cells[pos + i,52].Value = dt.Rows[i]["bo_total"]; 
			exSheet.Cells[pos + i,53].Value = dt.Rows[i]["ga_total"]; 
			exSheet.Cells[pos + i,54].Value = dt.Rows[i]["ca_total"]; 
			exSheet.Cells[pos + i,55].Value = dt.Rows[i]["bp_total"]; 
			exSheet.Cells[pos + i,56].Value = dt.Rows[i]["cr_total"]; 
			exSheet.Cells[pos + i,57].Value = dt.Rows[i]["chao_total"];
			exSheet.Cells[pos + i,58].Value = dt.Rows[i]["banh_total"]; 
			exSheet.Cells[pos + i,59].Value = dt.Rows[i]["trung_total"]; 
			exSheet.Cells[pos + i,64].Value = dt.Rows[i]["tiec_total"];
			exSheet.Cells[pos + i,65].Value = "=SUM(AX"+(pos+i)+":BG"+(pos+i)+")";
			
			
			
			//revenue sum formula
			exSheet.Cells[ pos + i, 67 ].Value = "=(B"+(pos+i)+"*BO5)";
			exSheet.Cells[ pos + i, 68 ].Value = "=SUM(C"+(pos+i)+":K"+(pos+i)+")*BP5";
			exSheet.Cells[ pos + i, 69 ].Value = "=L"+(pos+i)+"*BQ5";
			exSheet.Cells[ pos + i, 70 ].Value = "=SUM(BO"+(pos+i)+":BQ"+(pos+i)+")";
			exSheet.Cells[ pos + i, 71 ].Value = "=(N"+(pos+i)+"*BS5)";
			exSheet.Cells[ pos + i, 72 ].Value = "=SUM(O"+(pos+i)+":W"+(pos+i)+")*BT5";
			exSheet.Cells[ pos + i, 73 ].Value = "=X"+(pos+i)+"*BU5";
			exSheet.Cells[ pos + i, 74 ].Value = "=SUM(BS"+(pos+i)+":BU"+(pos+i)+")";
			exSheet.Cells[ pos + i, 75 ].Value = "=Z"+(pos+i)+"*BW5";
			exSheet.Cells[ pos + i, 76 ].Value = "=SUM(AA"+(pos+i)+":AI"+(pos+i)+")*BX5";
			exSheet.Cells[ pos + i, 77 ].Value = "=AJ"+(pos+i)+"*BY5";
			exSheet.Cells[ pos + i, 78 ].Value = "=SUM(BW"+(pos+i)+":BY"+(pos+i)+")";
			exSheet.Cells[ pos + i, 79 ].Value = "=AL"+(pos+i)+"*CA5";
			exSheet.Cells[ pos + i, 80 ].Value = "=SUM(AM"+(pos+i)+":AU"+(pos+i)+")*CB5";
			exSheet.Cells[ pos + i, 81 ].Value = "=AV"+(pos+i)+"*CC5";
			exSheet.Cells[ pos + i, 82 ].Value = "=SUM(CA"+(pos+i)+":CC"+(pos+i)+")";
			exSheet.Cells[ pos + i, 83 ].Value = "=SUM(BO"+(pos+i)+"+BS"+(pos+i)+"+BW"+(pos+i)+"+CA"+(pos+i)+")";
			exSheet.Cells[ pos + i, 84 ].Value = "=SUM(BP"+(pos+i)+"+BT"+(pos+i)+"+CB"+(pos+i)+")";
			
			
			// Tong tiec
			exSheet.Cells[ pos + i, 89 ].Value =  "=SUM(BQ"+(pos+i)+",BU"+(pos+i)+",BY"+(pos+i)+",CC"+(pos+i)+")";
			exSheet.Cells[ pos + i, 89 ].Value = "=SUM(CK"+(pos+i)+":CK"+(pos+i)+")";
			
			
			
			
        }
		
	
		 
		int l_tt_dt=dt.Rows.Count;
		if(l_tt_dt > 0)
		{
				//tong bua sang
		         exSheet.Cells[ l_tt_dt + pos, 2 ].Value = "=SUM(B"+(pos)+":B"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 3 ].Value = "=SUM(C"+(pos)+":C"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 4 ].Value = "=SUM(D"+(pos)+":D"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 5 ].Value = "=SUM(E"+(pos)+":E"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 6 ].Value = "=SUM(F"+(pos)+":F"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 7 ].Value = "=SUM(G"+(pos)+":G"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 8 ].Value = "=SUM(H"+(pos)+":H"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 9 ].Value = "=SUM(I"+(pos)+":I"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 10 ].Value = "=SUM(J"+(pos)+":J"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 11 ].Value = "=SUM(K"+(pos)+":K"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 12 ].Value = "=SUM(L"+(pos)+":L"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 13 ].Value = "=SUM(M"+(pos)+":M"+(l_tt_dt+pos-1)+")";
				 //tong bua trua
				 exSheet.Cells[ l_tt_dt + pos, 14 ].Value = "=SUM(N"+(pos)+":N"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 15 ].Value = "=SUM(O"+(pos)+":O"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 16 ].Value = "=SUM(P"+(pos)+":P"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 17 ].Value = "=SUM(Q"+(pos)+":Q"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 18 ].Value = "=SUM(R"+(pos)+":R"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 19 ].Value = "=SUM(S"+(pos)+":S"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 20 ].Value = "=SUM(T"+(pos)+":T"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 21 ].Value = "=SUM(U"+(pos)+":U"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 22 ].Value = "=SUM(V"+(pos)+":V"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 23 ].Value = "=SUM(W"+(pos)+":W"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 24 ].Value = "=SUM(X"+(pos)+":X"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 25 ].Value = "=SUM(Y"+(pos)+":Y"+(l_tt_dt+pos-1)+")";
				 //tong bua toi
				 exSheet.Cells[ l_tt_dt + pos, 27 ].Value = "=SUM(AA"+(pos)+":AA"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 28 ].Value = "=SUM(AB"+(pos)+":AB"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 29 ].Value = "=SUM(AC"+(pos)+":AC"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 30 ].Value = "=SUM(AD"+(pos)+":AD"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 31 ].Value = "=SUM(AE"+(pos)+":AE"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 32 ].Value = "=SUM(AF"+(pos)+":AF"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 33 ].Value = "=SUM(AG"+(pos)+":AG"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 34 ].Value = "=SUM(AH"+(pos)+":AH"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 35 ].Value = "=SUM(AI"+(pos)+":AI"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 36 ].Value = "=SUM(AJ"+(pos)+":AJ"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 37 ].Value = "=SUM(AK"+(pos)+":AK"+(l_tt_dt+pos-1)+")";
				 //tong bua dem
				 exSheet.Cells[ l_tt_dt + pos, 38 ].Value = "=SUM(AL"+(pos)+":AL"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 39 ].Value = "=SUM(AM"+(pos)+":AM"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 40 ].Value = "=SUM(AN"+(pos)+":AN"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 41 ].Value = "=SUM(AO"+(pos)+":AO"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 42 ].Value = "=SUM(AP"+(pos)+":AP"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 43 ].Value = "=SUM(AQ"+(pos)+":AQ"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 44 ].Value = "=SUM(AR"+(pos)+":AR"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 45 ].Value = "=SUM(AS"+(pos)+":AS"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 46 ].Value = "=SUM(AT"+(pos)+":AT"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 47 ].Value = "=SUM(AU"+(pos)+":AU"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 48 ].Value = "=SUM(AV"+(pos)+":AV"+(l_tt_dt+pos-1)+")";
				 exSheet.Cells[ l_tt_dt + pos, 49 ].Value = "=SUM(AW"+(pos)+":AW"+(l_tt_dt+pos-1)+")";
				 
				 
				 //tong cong
					//tong HQ
					 exSheet.Cells[ l_tt_dt + pos, 50 ].Value = "=SUM(B"+(pos)+",N"+(pos)+",Z"+(pos)+",AL"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 50 ].Value = "=SUM(AX"+(pos)+":AX"+(l_tt_dt+pos-1)+")";	
					//tong LON
					 exSheet.Cells[ l_tt_dt + pos, 51 ].Value = "=SUM(C"+(pos)+",O"+(pos)+",AA"+(pos)+",AM"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 51 ].Value = "=SUM(AY"+(pos)+":AY"+(l_tt_dt+pos-1)+")";
					 //tong BO
					 exSheet.Cells[ l_tt_dt + pos, 52 ].Value = "=SUM(D"+(pos)+",P"+(pos)+",AB"+(pos)+",AN"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 52 ].Value = "=SUM(AZ"+(pos)+":AZ"+(l_tt_dt+pos-1)+")";
					 //tong GA
					 exSheet.Cells[ l_tt_dt + pos, 53 ].Value = "=SUM(E"+(pos)+",Q"+(pos)+",AC"+(pos)+",AO"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 53].Value = "=SUM(BA"+(pos)+":BA"+(l_tt_dt+pos-1)+")";
					 //tong CA
					 exSheet.Cells[ l_tt_dt + pos, 54].Value = "=SUM(F"+(pos)+",R"+(pos)+",AD"+(pos)+",AP"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 54 ].Value = "=SUM(BB"+(pos)+":BB"+(l_tt_dt+pos-1)+")";
					 //tong BUN/PHO
					 exSheet.Cells[ l_tt_dt + pos, 55].Value = "=SUM(G"+(pos)+",S"+(pos)+",AE"+(pos)+",AQ"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 55 ].Value = "=SUM(BC"+(pos)+":BC"+(l_tt_dt+pos-1)+")";
					 //tong COM RANG
					 exSheet.Cells[ l_tt_dt + pos, 56 ].Value = "=SUM(H"+(pos)+",T"+(pos)+",AF"+(pos)+",AR"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 56 ].Value = "=SUM(BD"+(pos)+":BD"+(l_tt_dt+pos-1)+")";
					 //tong CHAO
					 exSheet.Cells[ l_tt_dt + pos, 57 ].Value = "=SUM(I"+(pos)+",U"+(pos)+",AG"+(pos)+",AS"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 57 ].Value = "=SUM(BE"+(pos)+":BE"+(l_tt_dt+pos-1)+")";
					 //tong BANH
					 exSheet.Cells[ l_tt_dt + pos, 58 ].Value = "=SUM(J"+(pos)+",V"+(pos)+",AH"+(pos)+",AT"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 58 ].Value = "=SUM(BF"+(pos)+":BF"+(l_tt_dt+pos-1)+")";
					 //tong TRUNG
					 exSheet.Cells[ l_tt_dt + pos, 59 ].Value = "=SUM(K"+(pos)+",W"+(pos)+",AI"+(pos)+",AU"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 59 ].Value = "=SUM(BG"+(pos)+":BG"+(l_tt_dt+pos-1)+")";
					 //tong TIEC
					 exSheet.Cells[ l_tt_dt + pos, 64 ].Value = "=SUM(L"+(pos)+",X"+(pos)+",AJ"+(pos)+",AV"+(pos)+")";
					 exSheet.Cells[ l_tt_dt + pos, 64 ].Value = "=SUM(BL"+(pos)+":BL"+(l_tt_dt+pos-1)+")";
					 exSheet.Cells[ l_tt_dt+pos, 65 ].Value = "=SUM(BM"+(pos)+":BM"+(l_tt_dt+pos-1)+")";
					 
					 //Tong doanh thu bua sang
						exSheet.Cells[ l_tt_dt + pos, 67].Value = "=SUM(BO"+(pos)+":BO"+(l_tt_dt+pos-1)+")";
						exSheet.Cells[ l_tt_dt + pos, 68].Value = "=SUM(BP"+(pos)+":BP"+(l_tt_dt+pos-1)+")";
						exSheet.Cells[ l_tt_dt + pos, 70].Value = "=SUM(BR"+(pos)+":BR"+(l_tt_dt+pos-1)+")";
					//Tong doanh thu bua trua
						exSheet.Cells[ l_tt_dt + pos, 71].Value = "=SUM(BS"+(pos)+":BS"+(l_tt_dt+pos-1)+")";
						exSheet.Cells[ l_tt_dt + pos, 72].Value = "=SUM(BT"+(pos)+":BT"+(l_tt_dt+pos-1)+")";
						exSheet.Cells[ l_tt_dt + pos, 74].Value = "=SUM(BV"+(pos)+":BV"+(l_tt_dt+pos-1)+")";
					//Tong doanh thu bua toi
						exSheet.Cells[ l_tt_dt + pos, 75].Value = "=SUM(BW"+(pos)+":BW"+(l_tt_dt+pos-1)+")";
						exSheet.Cells[ l_tt_dt + pos, 76].Value = "=SUM(BX"+(pos)+":BX"+(l_tt_dt+pos-1)+")";
						exSheet.Cells[ l_tt_dt + pos, 78].Value = "=SUM(BZ"+(pos)+":BZ"+(l_tt_dt+pos-1)+")";
					//Tong doanh thu bua dem
						exSheet.Cells[ l_tt_dt + pos, 79].Value = "=SUM(CA"+(pos)+":CA"+(l_tt_dt+pos-1)+")";
						exSheet.Cells[ l_tt_dt + pos, 80].Value = "=SUM(CB"+(pos)+":CB"+(l_tt_dt+pos-1)+")";
						exSheet.Cells[ l_tt_dt + pos, 82].Value = "=SUM(CD"+(pos)+":CD"+(l_tt_dt+pos-1)+")";
					//Tong doanh thu tong
						exSheet.Cells[ l_tt_dt + pos, 83].Value = "=SUM(CE"+(pos)+":CE"+(l_tt_dt+pos-1)+")";
						exSheet.Cells[ l_tt_dt + pos, 84].Value = "=SUM(CF"+(pos)+":CF"+(l_tt_dt+pos-1)+")";
					//Tong doanh thu tong All
						exSheet.Cells[ l_tt_dt + pos, 90].Value = "=SUM(CL"+(pos)+":CL"+(l_tt_dt+pos-1)+")";
		}			
	  
	    
				 
		
		
		for (int l_add = 1; l_add < dt1.Rows.Count; l_add++)
        {
            
            exSheet.Range[l_add + l_tt_dt + 8, 1, l_add + l_tt_dt + 8, 71].Rows.EntireRow.Insert();
		}
		
				
		// SET DATA week
		int pos_w=8;
		for (int k=0; k <dt1.Rows.Count; k++)
        {
			exSheet.Cells[pos_w+k+l_tt_dt, 1 ].Value = dt1.Rows[k]["week"];
			exSheet.Cells[pos_w+k+l_tt_dt, 2 ].Value = dt1.Rows[k]["hq_sang"]; 
			exSheet.Cells[pos_w+k+l_tt_dt, 3 ].Value = dt1.Rows[k]["lon_sang"];	
			exSheet.Cells[pos_w+k+l_tt_dt, 4].Value = dt1.Rows[k]["bo_sang"];			
			exSheet.Cells[pos_w+k+l_tt_dt,5].Value = dt1.Rows[k]["ga_sang"]; 
			exSheet.Cells[pos_w+k+l_tt_dt, 6].Value = dt1.Rows[k]["ca_sang"]; 
			exSheet.Cells[pos_w+k+l_tt_dt, 7].Value = dt1.Rows[k]["bp_sang"]; 
			exSheet.Cells[pos_w+k+l_tt_dt, 8].Value = dt1.Rows[k]["cr_sang"]; 
			exSheet.Cells[pos_w+k+l_tt_dt, 9].Value = dt1.Rows[k]["chao_sang"]; 
			exSheet.Cells[pos_w+k+l_tt_dt, 10].Value = dt1.Rows[k]["banh_sang"]; 
			exSheet.Cells[pos_w+k+l_tt_dt, 11].Value = dt1.Rows[k]["trung_sang"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,12].Value = dt1.Rows[k]["tiec_sang"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,13].Value = dt1.Rows[k]["total_sang"]; 
			
			exSheet.Cells[pos_w+k+l_tt_dt,14].Value = dt1.Rows[k]["hq_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,15].Value = dt1.Rows[k]["lon_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,16].Value = dt1.Rows[k]["bo_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,17].Value = dt1.Rows[k]["ga_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,18].Value = dt1.Rows[k]["ca_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,19].Value = dt1.Rows[k]["bp_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,20].Value = dt1.Rows[k]["cr_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,21].Value = dt1.Rows[k]["chao_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,22].Value = dt1.Rows[k]["banh_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,23].Value = dt1.Rows[k]["trung_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,24].Value = dt1.Rows[k]["tiec_trua"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,25].Value = dt1.Rows[k]["total_trua"];
			
			exSheet.Cells[pos_w+k+l_tt_dt,26].Value = dt1.Rows[k]["hq_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,27].Value = dt1.Rows[k]["lon_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,28].Value = dt1.Rows[k]["bo_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,29].Value = dt1.Rows[k]["ga_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,30].Value = dt1.Rows[k]["ca_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,31].Value = dt1.Rows[k]["bp_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,32].Value = dt1.Rows[k]["cr_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,33].Value = dt1.Rows[k]["chao_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,34].Value = dt1.Rows[k]["banh_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,35].Value = dt1.Rows[k]["trung_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,36].Value = dt1.Rows[k]["tiec_chieu"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,37].Value = dt1.Rows[k]["total_chieu"];
			
			exSheet.Cells[pos_w+k+l_tt_dt,38].Value = dt1.Rows[k]["hq_toi"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,39].Value = dt1.Rows[k]["lon_toi"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,40].Value = dt1.Rows[k]["bo_toi"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,41].Value = dt1.Rows[k]["ga_toi"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,42].Value = dt1.Rows[k]["ca_toi"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,43].Value = dt1.Rows[k]["bp_toi"];
			exSheet.Cells[pos_w+k+l_tt_dt,44].Value = dt1.Rows[k]["cr_toi"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,45].Value = dt1.Rows[k]["chao_toi"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,46].Value = dt1.Rows[k]["banh_toi"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,47].Value = dt1.Rows[k]["trung_toi"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,48].Value = dt1.Rows[k]["tiec_toi"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,49].Value = dt1.Rows[k]["total_toi"]; 
			
			exSheet.Cells[pos_w+k+l_tt_dt,50].Value = dt1.Rows[k]["hq_total"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,51].Value = dt1.Rows[k]["lon_total"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,52].Value = dt1.Rows[k]["bo_total"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,53].Value = dt1.Rows[k]["ga_total"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,54].Value = dt1.Rows[k]["ca_total"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,55].Value = dt1.Rows[k]["bp_total"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,56].Value = dt1.Rows[k]["cr_total"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,57].Value = dt1.Rows[k]["chao_total"];
			exSheet.Cells[pos_w+k+l_tt_dt,58].Value = dt1.Rows[k]["banh_total"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,59].Value = dt1.Rows[k]["trung_total"]; 
			exSheet.Cells[pos_w+k+l_tt_dt,64].Value = dt1.Rows[k]["tiec_total"];
			
			//revenue sum formula
			exSheet.Cells[ pos_w+k+l_tt_dt, 67 ].Value = "=(B"+(pos_w+k+l_tt_dt)+"*BO5)";
			exSheet.Cells[ pos_w+k+l_tt_dt, 68 ].Value = "=SUM(C"+(pos_w+k+l_tt_dt)+":K"+(pos_w+k+l_tt_dt)+")*BP5";
			exSheet.Cells[ pos_w+k+l_tt_dt, 69 ].Value = "=L"+(pos_w+k+l_tt_dt)+"*BQ5";
			exSheet.Cells[ pos_w+k+l_tt_dt, 70 ].Value = "=SUM(BO"+(pos_w+k+l_tt_dt)+":BQ"+(pos_w+k+l_tt_dt)+")";
			exSheet.Cells[ pos_w+k+l_tt_dt, 71 ].Value = "=(N"+(pos_w+k+l_tt_dt)+"*BS5)";
			exSheet.Cells[ pos_w+k+l_tt_dt, 72 ].Value = "=SUM(O"+(pos_w+k+l_tt_dt)+":W"+(pos_w+k+l_tt_dt)+")*BT5";
			exSheet.Cells[ pos_w+k+l_tt_dt, 73 ].Value = "=X"+(pos_w+k+l_tt_dt)+"*BU5";
			exSheet.Cells[ pos_w+k+l_tt_dt, 74 ].Value = "=SUM(BS"+(pos_w+k+l_tt_dt)+":BU"+(pos_w+k+l_tt_dt)+")";
			exSheet.Cells[ pos_w+k+l_tt_dt, 75 ].Value = "=Z"+(pos_w+k+l_tt_dt)+"*BW5";
			exSheet.Cells[ pos_w+k+l_tt_dt, 76 ].Value = "=SUM(AA"+(pos_w+k+l_tt_dt)+":AI"+(pos_w+k+l_tt_dt)+")*BX5";
			exSheet.Cells[ pos_w+k+l_tt_dt, 77 ].Value = "=AJ"+(pos_w+k+l_tt_dt)+"*BY5";
			exSheet.Cells[ pos_w+k+l_tt_dt, 78 ].Value = "=SUM(BW"+(pos_w+k+l_tt_dt)+":BY"+(pos_w+k+l_tt_dt)+")";
			exSheet.Cells[ pos_w+k+l_tt_dt, 79 ].Value = "=AL"+(pos_w+k+l_tt_dt)+"*CA5";
			exSheet.Cells[ pos_w+k+l_tt_dt, 80 ].Value = "=SUM(AM"+(pos_w+k+l_tt_dt)+":AU"+(pos_w+k+l_tt_dt)+")*CB5";
			exSheet.Cells[ pos_w+k+l_tt_dt, 81 ].Value = "=AV"+(pos_w+k+l_tt_dt)+"*CC5";
			exSheet.Cells[ pos_w+k+l_tt_dt, 82 ].Value = "=SUM(CA"+(pos_w+k+l_tt_dt)+":CC"+(pos_w+k+l_tt_dt)+")";
			exSheet.Cells[ pos_w+k+l_tt_dt, 83 ].Value = "=SUM(BO"+(pos_w+k+l_tt_dt)+"+BS"+(pos_w+k+l_tt_dt)+"+BW"+(pos_w+k+l_tt_dt)+"+CA"+(pos_w+k+l_tt_dt)+")";
			exSheet.Cells[ pos_w+k+l_tt_dt, 84 ].Value = "=SUM(BP"+(pos_w+k+l_tt_dt)+"+BT"+(pos_w+k+l_tt_dt)+"+CB"+(pos_w+k+l_tt_dt)+")";
			
			
		}
	
        if (File.Exists(TempFile))
        {
            File.Delete(TempFile);
        }
        // hide row firts 
       // range = exSheet.Range["A1"];
        // hide row A5 
        // range.Rows.Hidden = true;
        // font bold header
        /*range = exSheet.Range["A1:AC1"];
        range.Rows[4].Font.Bold = true;*/

        exBook.SaveAs(TempFile);
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
        //Response.WriteFile(pdfFilePath);
        Response.WriteFile(TempFile);
        //Stop execute  
        Response.End();

    }

   
}