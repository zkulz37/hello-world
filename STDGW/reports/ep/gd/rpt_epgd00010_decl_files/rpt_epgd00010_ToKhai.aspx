<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% ESysLib.SetUser("imex");%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string SQL, company = "", company_pk = "", pk="", curr_book="";
    string com_name = "", com_addr = "", com_tax = "", com_phone="";
    string cust_name = "", chicuchaiquan="" ,decl_no = "", decl_dt = "", annex = "", lisence ="", lisence_dt ="", lisence_exp ="";
    string ctrl_no = "", ctrl_dt="", ctrl_exp="", inv_no="", inv_dt ="", vessel ="", arrival_dt="";
    string bill_no = "", bill_dt="", exp_country_nm = "", exp_country_cd ="", loading_place ="", loading_cd ="";
    string discharge = "", discharge_cd = "", trade_terms = "", tr_ccy = "", ex_rate = "", pay_meth ="";
    string partnerID2 = "", partnerNm2 = "", addr2 = "", partnerID3 = "", partnerNm3 = "", addr3 ="";
    string  partnerID4 = "", partnerNm4 = "", addr4 = "";
    string tot_net_tr_amt="", tot_im_tax_amt="", tot_exc_amt ="", tot_ot_tax_amt ="", tot_tax_amt ="";
    string[] arrTax = new string[11]; 
    
    pk = Request.QueryString["pk"];  
    company_pk = Request.QueryString["company_pk"];

    SQL = " select  a.partner_name, a.addr1, a.tax_code, a.phone_no ";
    SQL = SQL + " from    comm.tco_company a  ";
    SQL = SQL + " where pk='" + company_pk + "'";
    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    { 
        com_name = (string)dt.Rows[0][0].ToString();
        com_addr = (string)dt.Rows[0][1].ToString();
        com_tax = (string)dt.Rows[0][2].ToString();
        com_phone = (string)dt.Rows[0][3].ToString();
    }

    for (int i = 0; i < com_tax.Length; i++)
        arrTax[i] =(string) com_tax[i].ToString();

    SQL = " select a.decl_no, to_char(to_date(a.decl_date,'yyyymmdd'),'dd/mm/yy') decl_date   " + 
        "       , a.annex, a.license  " +
        "       , to_char(to_date(a.license_date,'yyyymmdd'),'dd/mm/yy') license_date      " +
        "       , to_char(to_date(a.license_expdate,'yyyymmdd'),'dd/mm/yy') license_expdate    " +
        "       , nvl(a.CONTR_NO, h.contr_no) CONTR_NO " +
        "       , to_char(to_date(nvl(a.contr_date,h.contr_date),'yyyymmdd'),'dd/mm/yy') contr_date    " +
        "       , to_char(to_date(nvl(a.CONTR_EXP_DATE,h.exp_date),'yyyymmdd'),'dd/mm/yy') ctrl_exp_date   " +
        "       , nvl(INVOICE_NO, b.co_invoice_no) INVOICE_NO   " +
        "       , to_char(to_date(nvl(INVOICE_DATE, b.co_invoice_date),'yyyymmdd'),'dd/mm/yy') inv_date   " +
        "       , i.vessel_flt_name  " +
        "       , to_char(to_date(i.arrival_date,'yyyymmdd'),'dd/mm/yy') arrival_date  " +
        "       , i.bill_no   " +
        "       , to_char(to_date(i.bill_date,'yyyymmdd'),'dd/mm/yy')  bill_date    " +
        "       , j.country_cd2, j.country_nm   " +
        "       , p1.port_nm, p1.port_cd, p2.port_nm, p2.port_cd  " +
        "       , a.trade_terms, a.tr_ccy , to_char(a.ex_rate,'999,999') ex_rate   " +
        "       , method.code_nm pay_meth  " +
        "       , c.PARTNER_id partnerID2 , c.PARTNER_name partnerNm2  " +
        "       , c.addr1  addr2  " +
        "       , d.PARTNER_id partnerID3 , d.PARTNER_name partnerNm3  " +
        "       , d.addr1 addr3  " +
        "       , e.PARTNER_id partnerID4 , e.PARTNER_name partnerNm4  " +
        "       , e.addr1 addr4  " +
        "       , decode(a.tr_ccy,'VND',to_char(a.tot_net_tr_amt,'999,999,999,999'),to_char(a.tot_net_tr_amt,'999,999,990.99')) tot_net_tr_amt     " +
        "       , decode(a.tr_ccy,'VND',to_char(a.tot_im_tax_amt,'999,999,999,999'),to_char(a.tot_im_tax_amt,'999,999,990.99')) tot_im_tax_amt     " +
        "       , decode(a.tr_ccy,'VND',to_char(decode(nvl(a.tot_exc_amt,0),0,nvl(a.tot_vat_amt,0),nvl(a.tot_exc_amt,0)),'999,999,999,999'),to_char(decode(nvl(a.tot_exc_amt,0),0,a.tot_vat_amt),'999,999,990.99')) tot_exc_amt    " +
        "       , decode(a.tr_ccy,'VND',to_char(a.tot_ot_tax_amt,'999,999,999,999'),to_char(a.tot_ot_tax_amt,'999,999,990.99')) tot_ot_tax_amt            " +
        "       , decode(a.tr_ccy,'VND',to_char(nvl(tot_im_tax_amt,0)+nvl(tot_exc_amt,0)+nvl(tot_vat_amt,0)+nvl(tot_ot_tax_amt,0),'999,999,999'),to_char(nvl(tot_im_tax_amt,0)+nvl(tot_exc_amt,0)+nvl(tot_vat_amt,0)+nvl(tot_ot_tax_amt,0),'999,999,990.99')) tot_tax_amt  " +
        "       , f.PARTNER_id partnerIDCust , f.PARTNER_name partnerNmCust   " +
        " from  imex.tim_decl_mst a, imex.tim_cinv_mst_a b, imex.tim_contr_mst h   " +
        "        , imex.tie_bl_mst i, imex.tie_country j, imex.tie_port p1, imex.tie_port p2   " +
        "        , comm.tco_buspartner  c, comm.tco_buspartner  d, comm.tco_buspartner  e, comm.tco_buspartner  f  " +
        "        ,  (select a.CODE,  a.CODE_NM from comm.TCO_ABCODE a, comm.TCO_ABCODEGRP b   " +
        "      where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140'   " +
        "           and a.del_if=0 and b.del_if=0 order by a.CODE) method  " +
        " where a.tim_cinv_mst_a_pk = b.pk(+)  " +
        "        and b.contract_pk = h.pk(+)  " +
        "        and a.tie_bl_mst_pk = i.pk(+)  " +
        "        and a.tie_country_pk = j.pk(+)  " +
        "        and upper(a.plc_loading) = upper(p1.port_cd(+))  " +
        "        and upper(a.plc_discharge) = upper(p2.port_cd(+))  " +
        "        and a.TCO_BUSPARTNER_PK1 =c.pk(+)     " +
        "        and a.TCO_BUSPARTNER_PK2 =d.pk(+)     " +
        "        and a.TCO_BUSPARTNER_PK3 =e.pk(+)   " +
        "        and a.TCO_BUSPARTNER_PK4 =f.pk(+)   " +
        "        and upper(a.pay_meth) = upper(method.code(+))  " +
        "        and a.del_if=0  and  a.pk ='" + pk + "'";
    dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    { 
        cust_name = (string)dt.Rows[0][40].ToString(); 
        decl_no =  (string)dt.Rows[0][0].ToString(); 
        decl_dt =  (string)dt.Rows[0][1].ToString(); 
        annex   =  (string)dt.Rows[0][2].ToString(); 
        lisence =  (string)dt.Rows[0][3].ToString(); 
        lisence_dt  = (string)dt.Rows[0][4].ToString(); 
        lisence_exp = (string)dt.Rows[0][5].ToString();
        ctrl_no     = (string)dt.Rows[0][6].ToString(); 
        ctrl_dt     = (string)dt.Rows[0][7].ToString(); 
        ctrl_exp    = (string)dt.Rows[0][8].ToString(); 
        inv_no      = (string)dt.Rows[0][9].ToString(); 
        inv_dt      = (string)dt.Rows[0][10].ToString(); 
        vessel      = (string)dt.Rows[0][11].ToString(); 
        arrival_dt  = (string)dt.Rows[0][12].ToString();
        bill_no     = (string)dt.Rows[0][13].ToString(); 
        bill_dt     = (string)dt.Rows[0][14].ToString();
        exp_country_cd = (string)dt.Rows[0][15].ToString(); 
        exp_country_nm = (string)dt.Rows[0][16].ToString(); 
        loading_place  = (string)dt.Rows[0][17].ToString(); 
        loading_cd   =  (string)dt.Rows[0][18].ToString();
        discharge    =  (string)dt.Rows[0][19].ToString(); 
        discharge_cd =  (string)dt.Rows[0][20].ToString(); 
        trade_terms  =  (string)dt.Rows[0][21].ToString(); 
        tr_ccy     =  (string)dt.Rows[0][22].ToString(); 
        ex_rate    =  (string)dt.Rows[0][23].ToString(); 
        pay_meth   =  (string)dt.Rows[0][24].ToString();
        partnerID2 =  (string)dt.Rows[0][25].ToString(); 
        partnerNm2 =  (string)dt.Rows[0][26].ToString(); 
        addr2      =  (string)dt.Rows[0][27].ToString(); 
        partnerID3 =  (string)dt.Rows[0][28].ToString(); 
        partnerNm3 =  (string)dt.Rows[0][29].ToString(); 
        addr3      =  (string)dt.Rows[0][30].ToString();
        partnerID4 =  (string)dt.Rows[0][31].ToString(); 
        partnerNm4 =  (string)dt.Rows[0][32].ToString(); 
        addr4      =  (string)dt.Rows[0][33].ToString();
        tot_net_tr_amt  = (string)dt.Rows[0][34].ToString(); 
        tot_im_tax_amt  = (string)dt.Rows[0][35].ToString(); 
        tot_exc_amt     = (string)dt.Rows[0][36].ToString(); 
        tot_ot_tax_amt  = (string)dt.Rows[0][37].ToString(); 
        tot_tax_amt     = (string)dt.Rows[0][38].ToString();
    }
    
    SQL = "select  v5.grp_nm, v5.grp_cd, v.item_name, v4.hs_code, v2.country_nm " +
        "     , comm.sf_get_item_attribute(a.tco_item_pk )     " +
        "     , to_char(a.qty,'999,999,999') qty, v3.uom_nm     " +
        "     , decode(v1.tr_ccy,'VND',to_char(a.u_price,'999,999,999,999'),to_char(a.u_price,'999,999,999,990.99')) u_price     " +
        "     , decode(v1.tr_ccy,'VND',to_char(a.ext_price ,'999,999,999,999'),to_char(a.ext_price ,'999,999,999,990.99')) ext_amt      " +
        "     , decode(v1.tr_ccy,'VND',to_char(nvl(im_tax_calc_amt,0)+ nvl(re_im_tax_calc_amt,0),'999,999,999,999,999'),to_char(nvl(im_tax_calc_amt,0)+ nvl(re_im_tax_calc_amt,0),'999,999,999,990.99')) tr_amt      " +
        "     , to_char(a.im_tax_rate,'999,999,999,990.99') im_tax_rate     " +
        "     , decode(v1.tr_ccy,'VND',to_char(a.im_tax_amt,'999,999,999,999'),to_char(a.im_tax_amt,'999,999,990.99')) tax_amt      " +
        "     , decode(v1.tr_ccy,'VND',to_char(nvl(a.exc_amt, nvl(a.vat_amt,0) ),'999,999,999,999,999'),to_char(nvl(a.exc_amt, nvl(a.vat_amt,0) ),'999,999,999,990.99')) exc_tr_amt     " +
        "     , to_char(nvl(a.exc_rate,a.vat_rate),'999,999,999,990.99') exc_tax_rate   " +
        "     , decode(v1.tr_ccy,'VND',to_char(nvl(a.exc_amt, nvl(a.vat_amt,0) )*nvl(a.exc_rate,nvl(a.vat_rate,0))/100,'999,999,999,999'),to_char(nvl(a.exc_amt,nvl(a.vat_amt,0))*nvl(a.exc_rate, nvl(a.vat_rate,0) )/100,'999,999,990.99')) exc_amt     " +
        "     , to_char(a.ot_tax_rate,'999,999,999,990.99') ot_tax_rate     " +
        "     , decode(v1.tr_ccy,'VND',to_char(nvl(a.ot_tax_calc_amt,0)*nvl(a.ot_tax_rate,0)/100,'999,999,999,999'),to_char(nvl(a.ot_tax_calc_amt,0)*nvl(a.ot_tax_rate,0)/100,'999,999,990.99')) ot_amt     " +
        "     , nvl(v.trans_fee_yn,'N'), a.pk  , decode(nvl(v3.cnv_ratio,1),1,'',to_char(v3.cnv_ratio,'9,999,999')) || v3.uom_nm unit_cd " +
        "     , a.unit_packing, nvl(a.qty_packing,0), a.unit_weight, nvl(a.net_weight,0), nvl(a.gross_weight,0), v.item_code  " +
        " from imex.tim_decl_dtl a, comm.tco_item v, imex.tim_decl_mst v1   " +
        "       , imex.tie_country v2, comm.tco_uom v3 " +
        "       , comm.tco_hscode v4, comm.tco_itemgrp v5 " +
        " where a.del_if = 0   " +
        "        and  a.tco_item_pk = v.pk  " +
        "        and  a.tim_decl_mst_pk=v1.pk     " +
        "        and  upper(a.item_origin) = upper(v2.country_cd2(+))  " +
        "        and  upper(a.unit_cd) = upper(v3.uom_code(+))  " +
        "        and  v.tco_hscode_pk = v4.pk(+)   " +
        "        and  v.tco_itemgrp_pk = v5.pk " +
        "        and  a.tim_decl_mst_pk='" + pk + "'" +
        " order by  v.trans_fee_yn, a.pk    ";
    dt = ESysLib.TableReadOpen(SQL);

    SQL = "select   to_char(sum(nvl(a.qty,0)),'999,999.99') qty, v3.uom_nm " +
        "        , to_char(sum(nvl(a.qty_packing,0)),'999,999.99') qty_packing, a.unit_packing " +
        "        , a.unit_weight, to_char(sum(nvl(a.net_weight,0)),'999,999.99') net_wt  " +
        "        , to_char(sum(nvl(a.gross_weight,0)),'999,999.99') gross_wt         " +
        " from imex.tim_decl_dtl a, comm.tco_item v, imex.tim_decl_mst v1   " +
        "       , imex.tie_country v2, comm.tco_uom v3 " +
        "       , comm.tco_hscode v4, comm.tco_itemgrp v5 " +
        " where a.del_if = 0   " +
        "        and  a.tco_item_pk = v.pk  " +
        "        and  a.tim_decl_mst_pk=v1.pk     " +
        "        and  upper(a.item_origin) = upper(v2.country_cd2(+))  " +
        "        and  upper(a.unit_cd) = upper(v3.uom_code(+))  " +
        "        and  v.tco_hscode_pk = v4.pk(+)   " +
        "        and  v.tco_itemgrp_pk = v5.pk " +
        "        and  nvl(v.trans_fee_yn,'N') = 'N' " +
        "        and  a.tim_decl_mst_pk='" + pk + "'" +
        " group by  v3.uom_nm,  a.unit_packing, a.unit_weight, v.trans_fee_yn  ";
    DataTable dtSum = ESysLib.TableReadOpen(SQL);   

%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link id=Main-File rel=Main-File href="../rpt_epgd00010_decl.htm">
<link rel=File-List href=filelist.xml>
<link rel=Edit-Time-Data href=editdata.mso>
<link rel=Stylesheet href=stylesheet.css>
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.53in .28in 0in .22in;
	mso-header-margin:.42in;
	mso-footer-margin:0in;}
-->
</style>
<![if !supportTabStrip]><script language="JavaScript">
<!--
function fnUpdateTabs()
 {
  if (parent.window.g_iIEVer>=4) {
   if (parent.document.readyState=="complete"
    && parent.frames['frTabs'].document.readyState=="complete")
   parent.fnSetActiveSheet(0);
  else
   window.setTimeout("fnUpdateTabs();",150);
 }
}

if (window.name!="frSheet")
 window.location.replace("../rpt_epgd00010_decl.htm");
else
 fnUpdateTabs();
//-->
</script>
<![endif]><!--[if gte mso 9]><xml>
 <x:WorksheetOptions>
  <x:DefaultRowHeight>210</x:DefaultRowHeight>
  <x:FitToPage/>
  <x:FitToPage/>
  <x:Print>
   <x:FitHeight>0</x:FitHeight>
   <x:ValidPrinterInfo/>
   <x:PaperSizeIndex>5</x:PaperSizeIndex>
   <x:Scale>99</x:Scale>
   <x:HorizontalResolution>300</x:HorizontalResolution>
   <x:VerticalResolution>300</x:VerticalResolution>
  </x:Print>
  <x:Panes>
   <x:Pane>
    <x:Number>3</x:Number>
    <x:ActiveRow>1</x:ActiveRow>
   </x:Pane>
  </x:Panes>
  <x:ProtectContents>False</x:ProtectContents>
  <x:ProtectObjects>False</x:ProtectObjects>
  <x:ProtectScenarios>False</x:ProtectScenarios>
 </x:WorksheetOptions>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl29>

<table x:str border=0 cellpadding=0 cellspacing=0 width=939 style='border-collapse:
 collapse;table-layout:fixed;width:704pt'>
 <col class=xl29 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col class=xl29 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col class=xl29 width=20 style='mso-width-source:userset;mso-width-alt:731;
 width:15pt'>
 <col class=xl29 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl29 width=22 style='mso-width-source:userset;mso-width-alt:804;
 width:17pt'>
 <col class=xl29 width=18 style='mso-width-source:userset;mso-width-alt:658;
 width:14pt'>
 <col class=xl29 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl29 width=18 style='mso-width-source:userset;mso-width-alt:658;
 width:14pt'>
 <col class=xl29 width=19 span=8 style='mso-width-source:userset;mso-width-alt:
 694;width:14pt'>
 <col class=xl29 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl29 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl29 width=1 style='mso-width-source:userset;mso-width-alt:36;
 width:1pt'>
 <col class=xl29 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl29 width=23 span=3 style='mso-width-source:userset;mso-width-alt:
 841;width:17pt'>
 <col class=xl29 width=5 style='mso-width-source:userset;mso-width-alt:182;
 width:4pt'>
 <col class=xl29 width=23 span=2 style='mso-width-source:userset;mso-width-alt:
 841;width:17pt'>
 <col class=xl29 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl29 width=22 style='mso-width-source:userset;mso-width-alt:804;
 width:17pt'>
 <col class=xl29 width=28 style='mso-width-source:userset;mso-width-alt:1024;
 width:21pt'>
 <col class=xl29 width=1 style='mso-width-source:userset;mso-width-alt:36;
 width:1pt'>
 <col class=xl29 width=23 span=3 style='mso-width-source:userset;mso-width-alt:
 841;width:17pt'>
 <col class=xl29 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl29 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl29 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2340'>
 <col class=xl29 width=3 style='mso-width-source:userset;mso-width-alt:109;
 width:2pt'>
 <col class=xl29 width=64 span=2 style='width:48pt'>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl28 width=26 style='height:10.5pt;width:20pt'></td>
  <td class=xl28 width=23 style='width:17pt'></td>
  <td colspan=4 class=xl28 width=79 style='width:60pt'></td>
  <td class=xl28 width=17 style='width:13pt'></td>
  <td class=xl28 width=18 style='width:14pt'></td>
  <td class=xl28 width=19 style='width:14pt'></td>
  <td class=xl28 width=19 style='width:14pt'></td>
  <td class=xl28 width=19 style='width:14pt'></td>
  <td class=xl28 width=19 style='width:14pt'></td>
  <td class=xl28 width=19 style='width:14pt'></td>
  <td class=xl28 width=19 style='width:14pt'></td>
  <td class=xl28 width=19 style='width:14pt'></td>
  <td class=xl28 width=19 style='width:14pt'></td>
  <td class=xl28 width=38 style='width:29pt'></td>
  <td class=xl28 width=21 style='width:16pt'></td>
  <td class=xl28 width=1 style='width:1pt'></td>
  <td class=xl28 width=50 style='width:38pt'></td>
  <td class=xl28 width=23 style='width:17pt'></td>
  <td class=xl28 width=23 style='width:17pt'></td>
  <td class=xl28 width=23 style='width:17pt'></td>
  <td class=xl28 width=5 style='width:4pt'></td>
  <td class=xl28 width=23 style='width:17pt'></td>
  <td class=xl28 width=23 style='width:17pt'></td>
  <td class=xl28 width=21 style='width:16pt'></td>
  <td class=xl28 width=22 style='width:17pt'></td>
  <td class=xl28 width=28 style='width:21pt'></td>
  <td class=xl28 width=1 style='width:1pt'></td>
  <td class=xl28 width=23 style='width:17pt'></td>
  <td class=xl28 width=23 style='width:17pt'></td>
  <td class=xl28 width=23 style='width:17pt'></td>
  <td class=xl28 width=39 style='width:29pt'></td>
  <td class=xl29 width=83 style='width:62pt'></td>
  <td class=xl29 width=0></td>
  <td class=xl29 width=3 style='width:2pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=17 class=xl28 style='height:20.1pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl28 width=146 style='width:110pt'><%=decl_no  %></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 rowspan=2 class=xl30 width=108 style='width:80pt'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl31 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=10 class=xl186 width=189 style='width:142pt'><%=cust_name  %></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl34 width=96 style='width:72pt'><%=decl_dt  %></td>
  <td class=xl31></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 colspan=2 class=xl31 style='height:21.75pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl187 width=228 style='width:171pt'><%=chicuchaiquan %></td>
  <td class=xl33></td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 width=73 style='width:55pt'><%=annex %></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=34 height=34 class=xl28 width=725 style='height:25.5pt;
  width:544pt'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl36 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=205 style='width:13pt'>
  <%--<%=com_tax %>--%></td>
  <td class=xl28 width=17 style='width:13pt'><%=arrTax[0] %></td>
  <td class=xl28 width=18 style='width:14pt'><%=arrTax[1] %></td>
  <td class=xl28 width=19 style='width:14pt'><%=arrTax[2] %></td>
  <td class=xl28 width=19 style='width:14pt'><%=arrTax[3] %></td>
  <td class=xl28 width=19 style='width:14pt'><%=arrTax[4] %></td>
  <td class=xl28 width=19 style='width:14pt'><%=arrTax[5] %></td>
  <td class=xl28 width=19 style='width:14pt'><%=arrTax[6] %></td>
  <td class=xl28 width=19 style='width:14pt'><%=arrTax[7] %></td>
  <td class=xl28 width=19 style='width:14pt'><%=arrTax[8] %></td>
  <td class=xl28 width=19 style='width:14pt'><%=arrTax[9] %></td>
  <td class=xl39></td>
  <td class=xl36></td>
  <td class=xl33></td>
  <td class=xl36></td>
  <td colspan=9 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=4 rowspan=2 class=xl188 width=108 style='width:80pt'><%=ctrl_no  %></td>
  <td colspan=5 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl36 style='height:14.1pt'></td>
  <td colspan=17 class=xl189 width=348 style='width:261pt'><%=com_name  %></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl41 width=94 style='width:71pt'></td>
  <td class=xl41></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
 </tr>
 <tr class=xl40 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl36 style='height:14.1pt'></td>
  <td colspan=17 class=xl190 width=348 style='width:261pt'><%=com_addr  %></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl44 width=74 style='width:55pt'></td>
  <td class=xl44></td>
  <td colspan=4 class=xl45 width=94 style='width:71pt'></td>
  <td class=xl45></td>
  <td colspan=4 class=xl191 width=108 style='width:80pt'><%=ctrl_dt %></td>
  <td colspan=4 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl31 style='height:14.1pt'></td>
  <td colspan=17 class=xl190 width=348 style='width:261pt'><%=com_phone %></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl46 width=74 style='width:55pt'></td>
  <td class=xl46></td>
  <td colspan=5 class=xl47 width=95 style='width:72pt'></td>
  <td colspan=4 class=xl192 width=108 style='width:80pt'><%=ctrl_exp %></td>
  <td colspan=5 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl31 style='height:20.25pt'></td>
  <td class=xl43></td>
  <td colspan=4 class=xl49 style='mso-ignore:colspan'></td>
  <td colspan=14 class=xl50 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl46 width=74 style='width:55pt'></td>
  <td class=xl46></td>
  <td colspan=5 class=xl51 width=95 style='width:72pt'></td>
  <td colspan=4 class=xl52 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl31 style='height:20.25pt'></td>
  <td colspan=17 class=xl178 width=348 style='width:261pt'><%=partnerNm2  %></td>
  <td colspan=6 class=xl51 width=125 style='width:94pt'><%=inv_no  %></td>
  <td colspan=5 rowspan=2 class=xl50 width=117 style='width:88pt'><%=vessel  %></td>
  <td class=xl49></td>
  <td colspan=4 rowspan=2 class=xl179 width=108 style='width:80pt'><%=bill_no  %></td>
  <td class=xl54></td>
  <td class=xl29></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td colspan=17 rowspan=2 class=xl190 width=348 style='width:261pt'><%=addr2  %></td>
  <td colspan=2 class=xl51 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl51 width=74 style='width:55pt'></td>
  <td class=xl49></td>
  <td class=xl29></td>
  <td class=xl54></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl31 style='height:19.5pt'></td>
  <td colspan=6 class=xl180 width=125 style='width:94pt'><span
  style='mso-spacerun:yes'>      </span><%=inv_dt  %></td>
  <td colspan=5 class=xl53 width=117 style='width:88pt'><%=arrival_dt  %></td>
  <td class=xl49></td>
  <td colspan=4 class=xl181 width=108 style='width:80pt'><%=bill_dt  %></td>
  <td colspan=4 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl31 style='height:20.25pt'></td>
  <td class=xl55></td>
  <td colspan=17 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=4 class=xl28 width=74 style='width:55pt'></td>
  <td class=xl28></td>
  <td class=xl31></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl31 style='height:19.5pt'></td>
  <td colspan=17 class=xl182 width=348 style='width:261pt'><%=partnerNm3  %></td>
  <td class=xl28></td>
  <td colspan=5 rowspan=2 class=xl37 width=124 style='width:93pt'><%=exp_country_nm %></td>
  <td colspan=5 rowspan=2 class=xl183 width=117 style='width:88pt'><%=loading_place  %></td>
  <td class=xl28></td>
  <td colspan=4 rowspan=2 class=xl41 width=108 style='width:80pt'><%=discharge  %></td>
  <td class=xl56></td>
  <td class=xl29></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'></td>
  <td colspan=17 rowspan=2 class=xl182 width=348 style='width:261pt'><%=addr3  %></td>
  <td class=xl28></td>
  <td class=xl28></td>
  <td class=xl56></td>
  <td class=xl29></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl57 style='mso-ignore:colspan'></td>
  <td class=xl57 width=23 style='width:17pt'><% string st; st = exp_country_cd.Length >0 ? exp_country_cd.Substring(0, 1) : ""; %><%=st %></td>
  <td class=xl57 width=23 style='width:17pt'><% st = exp_country_cd.Length >1 ? exp_country_cd.Substring(1, 1) : "";%><%=st %></td>
  <td class=xl57></td>
  <td class=xl28></td>
  <td colspan=3 class=xl58 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl59 width=23 style='width:17pt'><% st = discharge_cd.Length > 0 ? discharge_cd.Substring(0, 1) : "";%><%=st %></td>
  <td class=xl59 width=23 style='width:17pt'><% st = discharge_cd.Length > 1 ? discharge_cd.Substring(1, 1) : "";%><%=st %></td>
  <td class=xl59 width=23 style='width:17pt'><% st = discharge_cd.Length > 2 ? discharge_cd.Substring(2, 1) : "";%><%=st %></td>
  <td class=xl59 width=39 style='width:29pt'><% st = discharge_cd.Length > 3 ? discharge_cd.Substring(3, 1) : "";%><%=st %></td>
  <td class=xl60></td>
  <td class=xl29></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 colspan=2 class=xl31 style='height:24.75pt;mso-ignore:colspan'></td>
  <td colspan=14 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl38 width=23 style='width:17pt'><% st = tr_ccy.Length > 0 ? tr_ccy.Substring(0, 1) : "";%><%=st %></td>
  <td class=xl38 width=21 style='width:16pt'><% st = tr_ccy.Length > 1 ? tr_ccy.Substring(1, 1) : "";%><%=st %></td>
  <td class=xl38 width=22 style='width:17pt'><% st = tr_ccy.Length > 2 ? tr_ccy.Substring(2, 1) : "";%><%=st %></td>
  <td class=xl33></td>
  <td colspan=5 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl31 style='height:14.25pt'></td>
  <td colspan=17 class=xl189 width=348 style='width:261pt'><%=partnerNm4 %></td>
  <td class=xl63></td>
  <td colspan=4 rowspan=2 class=xl184 width=119 style='width:89pt'><%=trade_terms %></td>
  <td class=xl28></td>
  <td class=xl31></td>
  <td colspan=5 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=4 rowspan=2 class=xl185 width=108 style='width:80pt'><%=pay_meth %></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl31 style='height:12.0pt'></td>
  <td colspan=17 class=xl189 width=348 style='width:261pt'><%=addr4 %></td>
  <td class=xl63></td>
  <td class=xl28></td>
  <td colspan=5 class=xl185 width=117 style='width:88pt'><%=ex_rate %></td>
  <td class=xl36></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl31 style='height:13.5pt'></td>
  <td class=xl30></td>
  <td colspan=7 class=xl63 width=133 style='width:101pt'></td>
  <td class=xl30></td>
  <td colspan=6 class=xl64 width=114 style='width:84pt'></td>
  <td colspan=3 class=xl63 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=2 class=xl28 style='height:14.1pt;mso-ignore:colspan'></td>
  <td colspan=13 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=19 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <% if (dt.Rows.Count ==1) 
    {       
 %> 
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl28 style='height:14.1pt'></td>
  <td colspan=13 class=xl114 width=251 style='width:188pt'><%=dt.Rows[0][0] %></td>
  <td class=xl66></td>
  <td colspan=19 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl49 style='height:22.5pt'></td>
  <td colspan=13 rowspan=2 class=xl84 width=251 style='width:188pt'><%=dt.Rows[0][5] %>-
  <%=dt.Rows[0][26] %> <br>
  <%=dt.Rows[0][2] %>/ <%=dt.Rows[0][1] %></td>
  <td colspan=3 class=xl179 width=76 style='width:57pt'><%=dt.Rows[0][3] %></td>
  <td colspan=3 class=xl179 width=72 style='width:55pt'><%=dt.Rows[0][4] %></td>
  <td colspan=3 class=xl61 width=69 style='width:51pt'><%=dt.Rows[0][6] %></td>
  <td colspan=3 class=xl62 width=51 style='width:38pt'><%=dt.Rows[0][7] %></td>
  <td colspan=3 class=xl34 width=71 style='width:54pt'><%=dt.Rows[0][8] %></td>
  <td class=xl53></td>
  <td colspan=4 class=xl85 width=108 style='width:80pt'><%=dt.Rows[0][9] %></td>
  <td class=xl67></td>
  <td class=xl29></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
<%
    } 
    else
    {
%>
  <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl28 style='height:14.1pt'></td>
  <td colspan=13 class=xl114 width=251 style='width:188pt'> </td>
  <td class=xl66></td>
  <td colspan=19 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl49 style='height:22.5pt'></td>
  <td colspan=13 rowspan=2 class=xl84 width=251 style='width:188pt'> </td>
  <td colspan=3 class=xl179 width=76 style='width:57pt'> </td>
  <td colspan=3 class=xl179 width=72 style='width:55pt'> </td>
  <td colspan=3 class=xl61 width=69 style='width:51pt'> </td>
  <td colspan=3 class=xl62 width=51 style='width:38pt'> </td>
  <td colspan=3 class=xl34 width=71 style='width:54pt'> </td>
  <td class=xl53></td>
  <td colspan=4 class=xl85 width=108 style='width:80pt'> </td>
  <td class=xl67></td>
  <td class=xl29></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
  <%} %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl49 style='height:19.5pt'></td>
  <td class=xl68></td>
  <td colspan=3 class=xl86 width=78 style='width:59pt'></td>
  <td colspan=2 class=xl52 width=51 style='width:39pt'></td>
  <td colspan=3 class=xl61 width=69 style='width:51pt'></td>
  <td colspan=3 class=xl62 width=51 style='width:38pt'></td>
  <td colspan=3 class=xl34 width=71 style='width:54pt'></td>
  <td class=xl53></td>
  <td colspan=4 class=xl85 width=108 style='width:80pt'></td>
  <td class=xl67></td>
  <td class=xl29></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl49 style='height:21.75pt'></td>
  <td class=xl69></td>
  <td colspan=13 class=xl45 width=247 style='width:185pt'></td>
  <td colspan=3 class=xl86 width=78 style='width:59pt'></td>
  <td colspan=2 class=xl52 width=51 style='width:39pt'></td>
  <td colspan=3 class=xl61 width=69 style='width:51pt'></td>
  <td colspan=3 class=xl62 width=51 style='width:38pt'></td>
  <td colspan=3 class=xl34 width=71 style='width:54pt'></td>
  <td class=xl53></td>
  <td colspan=4 class=xl85 width=108 style='width:80pt'></td>
  <td class=xl67></td>
  <td class=xl29></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl70 style='height:16.5pt'></td>
  <td colspan=19 rowspan=2 class=xl34 width=399 style='width:300pt'>
  <%
    if(dtSum.Rows.Count==1)
    {
  %>
  Tổng cộng: 
  <%=dtSum.Rows[0][2] %><%=dtSum.Rows[0][3] %>=<%=dtSum.Rows[0][0] %><%=dtSum.Rows[0][1] %>
  =<%=dtSum.Rows[0][5] %><%=dtSum.Rows[0][4] %>=<%=dtSum.Rows[0][6] %><%=dtSum.Rows[0][4] %>
  <%
    } 
  %>
  </td>
  <td colspan=8 rowspan=2 class=xl193 width=163 style='width:122pt'></td>
  <td colspan=6 rowspan=2 class=xl61 width=137 style='width:102pt'><%=tot_net_tr_amt %></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl70 style='height:11.25pt'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=2 class=xl31 style='height:14.1pt;mso-ignore:colspan'></td>
  <td colspan=13 rowspan=3 class=xl28 width=247 style='width:185pt'></td>
  <td colspan=12 rowspan=3 class=xl28 width=270 style='width:203pt'></td>
  <td colspan=7 rowspan=3 class=xl38 width=159 style='width:119pt'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl31 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 colspan=2 class=xl31 style='height:27.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
 <% 
     if (dt.Rows.Count > 0)
     {    
 %>
  <td height=27 class=xl31 style='height:20.25pt'></td>
  <td colspan=5 class=xl194 width=102 style='width:77pt'><%=dt.Rows[0][10] %></td>
  <td colspan=2 class=xl195 width=35 style='width:27pt'><%=dt.Rows[0][11] %></td>
  <td colspan=6 class=xl194 width=114 style='width:84pt'><%=dt.Rows[0][12] %></td>
  <td class=xl71></td>
 <%}
     else
     { 
 %>
  <td height=27 class=xl31 style='height:20.25pt'></td>
  <td colspan=5 class=xl194 width=102 style='width:77pt'></td>
  <td colspan=2 class=xl195 width=35 style='width:27pt'></td>
  <td colspan=6 class=xl194 width=114 style='width:84pt'></td>
  <td class=xl71></td>    
 <%} %>
  <td colspan=14 rowspan=3 class=xl196 width=320 style='width:241pt'>Hàng
  thu&#7897;c &#273;&#7889;i t&#432;&#7907;ng không ch&#7883;u thu&#7871; GTGT
  theo &#273;i&#7875;m 1.22, m&#7909;c II, Ph&#7847;n A Thông t&#432;
  32/07/IT-BTC ngày 09/04/07</td>
  <td class=xl35></td>
  <td colspan=4 class=xl72 width=108 style='width:80pt'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl31 style='height:20.25pt'></td>
  <td colspan=5 class=xl72 width=102 style='width:77pt'></td>
  <td colspan=2 class=xl35 width=35 style='width:27pt'></td>
  <td colspan=6 class=xl72 width=114 style='width:84pt'></td>
  <td class=xl71></td>
  <td class=xl35></td>
  <td colspan=4 class=xl72 width=108 style='width:80pt'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl31 style='height:21.75pt'></td>
  <td colspan=5 class=xl72 width=102 style='width:77pt'></td>
  <td colspan=2 class=xl35 width=35 style='width:27pt'></td>
  <td colspan=6 class=xl72 width=114 style='width:84pt'></td>
  <td class=xl71></td>
  <td class=xl35></td>
  <td colspan=4 class=xl72 width=108 style='width:80pt'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl31 style='height:19.5pt'></td>
  <td class=xl63></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl63></td>
  <td colspan=6 class=xl194 width=114 style='width:84pt'><%=tot_im_tax_amt %></td>
  <td class=xl72></td>
  <td colspan=7 class=xl28 width=175 style='width:132pt'></td>
  <td colspan=5 class=xl36 width=95 style='width:71pt'></td>
  <td colspan=7 class=xl36 width=159 style='width:119pt'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=7 class=xl31 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=19 class=xl197 width=429 style='width:322pt'><%=tot_tax_amt %></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=6 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <%     
      string strWord = tot_tax_amt.Trim() != "" ? CommondLib.Num2VNText(tot_tax_amt.Trim(), tr_ccy) : "";
   %>
  <td colspan=28 class=xl184 width=597 style='width:447pt'><%=strWord%></td>  
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=2 class=xl28 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=27 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl31 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=7 class=xl31 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl31 width=21 style='width:16pt'><% st = decl_dt.Length > 2 ? decl_dt.Substring(0, 2) : "";%><%=st %></td>
  <td class=xl31></td>
  <td class=xl31 width=28 style='width:21pt'><% st = decl_dt.Length > 4 ? decl_dt.Substring(3, 2) : "";%><%=st %></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 width=46 style='width:34pt'>20<% st = decl_dt.Length > 9 ? decl_dt.Substring(6, 2) : "";%><%=st %></td>
  <td class=xl31></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=5 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl38></td>
  <td class=xl73></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl47 width=46 style='width:34pt'></td>
  <td class=xl31></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=5 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 width=85 style='width:63pt'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td colspan=7 class=xl28 width=137 style='width:104pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl38></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl64 width=85 style='width:63pt'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td colspan=7 class=xl28 width=137 style='width:104pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl38></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td colspan=7 class=xl28 width=137 style='width:104pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl54></td>
  <td class=xl54><span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl38 width=19 style='width:14pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl76 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=2 class=xl31 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl58 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl57 width=116 style='width:87pt'></td>
  <td colspan=16 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 colspan=39 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 class=xl29></td>
  <td class=xl75></td>
  <td colspan=37 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 colspan=39 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=26 style='width:20pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=17 style='width:13pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=1 style='width:1pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=5 style='width:4pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=1 style='width:1pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=0></td>
  <td width=3 style='width:2pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
