<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% ESysLib.SetUser("imex");%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">


<%
    string SQL, company = "", company_pk = "", pk="", curr_book="";    
    string cust_name = "", decl_no = "", decl_dt = "", annex = "";    
    string tot_net_tr_amt="", tot_im_tax_amt="", tot_exc_amt ="", tot_ot_tax_amt ="", tot_tax_amt ="";
    
    pk = Request.QueryString["pk"];  
    company_pk = Request.QueryString["company_pk"];

    SQL = " select a.decl_no, to_char(to_date(a.decl_date,'yyyymmdd'),'dd/mm/yy') decl_date  " +
        "       , a.annex, a.license " +
        "       , to_char(to_date(a.license_date,'yyyymmdd'),'dd/mm/yy') license_date     " +
        "       , to_char(to_date(a.license_expdate,'yyyymmdd'),'dd/mm/yy') license_expdate   " +
        "       , h.contr_no " +
        "       , to_char(to_date(h.contr_date,'yyyymmdd'),'dd/mm/yy') contr_date   " +
        "       , to_char(to_date(h.exp_date,'yyyymmdd'),'dd/mm/yy') ctrl_exp_date  " +
        "       , b.co_invoice_no  " +
        "       , to_char(to_date(b.co_invoice_date,'yyyymmdd'),'dd/mm/yy') inv_date  " +
        "       , i.vessel_flt_name " +
        "       , to_char(to_date(i.arrival_date,'yyyymmdd'),'dd/mm/yy') arrival_date " +
        "       , i.bill_no  " +
        "       , to_char(to_date(i.bill_date,'yyyymmdd'),'dd/mm/yy')  bill_date   " +
        "       , j.country_cd2, j.country_nm  " +
        "       , p1.port_nm, p1.port_cd, p2.port_nm, p2.port_cd " +
        "       , a.trade_terms, a.tr_ccy , to_char(a.ex_rate,'999,999') ex_rate  " +
        "       , method.code_nm pay_meth " +
        "       , c.PARTNER_id partnerID2 , c.PARTNER_name partnerNm2 " +
        "       , c.addr1  addr2 " +
        "       , d.PARTNER_id partnerID3 , d.PARTNER_name partnerNm3 " +
        "       , d.addr1 addr3 " +
        "       , e.PARTNER_id partnerID4 , e.PARTNER_name partnerNm4 " +
        "       , e.addr1 addr4 " +  
        "       , decode(a.tr_ccy,'VND',to_char(a.tot_net_tr_amt,'999,999,999,999'),to_char(a.tot_net_tr_amt,'999,999,990.99')) tot_net_tr_amt    " +
        "       , decode(a.tr_ccy,'VND',to_char(a.tot_im_tax_amt,'999,999,999,999'),to_char(a.tot_im_tax_amt,'999,999,990.99')) tot_im_tax_amt    " +
        "       , decode(a.tr_ccy,'VND',to_char(decode(nvl(a.tot_exc_amt,0),0,nvl(a.tot_vat_amt,0),nvl(a.tot_exc_amt,0)),'999,999,999,999'),to_char(decode(nvl(a.tot_exc_amt,0),0,a.tot_vat_amt),'999,999,990.99')) tot_exc_amt   " +
        "       , decode(a.tr_ccy,'VND',to_char(a.tot_ot_tax_amt,'999,999,999,999'),to_char(a.tot_ot_tax_amt,'999,999,990.99')) tot_ot_tax_amt           " +
        "       , decode(a.tr_ccy,'VND',to_char(nvl(tot_im_tax_amt,0)+nvl(tot_exc_amt,0)+nvl(tot_vat_amt,0)+nvl(tot_ot_tax_amt,0),'999,999,999'),to_char(nvl(tot_im_tax_amt,0)+nvl(tot_exc_amt,0)+nvl(tot_vat_amt,0)+nvl(tot_ot_tax_amt,0),'999,999,990.99')) tot_tax_amt " +
        "       , f.PARTNER_id partnerIDCust , f.PARTNER_name partnerNmCust  " +
        " from  tim_decl_mst a, tim_cinv_mst_a b, tim_contr_mst h  " +
        "        , tie_bl_mst i, tie_country j, tie_port p1, tie_port p2  " +
        "        , tco_buspartner  c, tco_buspartner  d, tco_buspartner  e, tco_buspartner  f " +
        "        ,  (select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  " +  
        "      where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140'  " +  
        "           and a.del_if=0 and b.del_if=0 order by a.CODE) method " +
        " where a.tim_cinv_mst_a_pk = b.pk " +
        "        and b.contract_pk = h.pk(+) " +
        "        and a.tie_bl_mst_pk = i.pk(+) " +
        "        and a.tie_country_pk = j.pk(+) " +
        "        and upper(a.plc_loading) = upper(p1.port_cd(+)) " +
        "        and upper(a.plc_discharge) = upper(p2.port_cd(+)) " +
        "        and a.TCO_BUSPARTNER_PK1 =c.pk(+)    " +
        "        and a.TCO_BUSPARTNER_PK2 =d.pk(+)    " +
        "        and a.TCO_BUSPARTNER_PK3 =e.pk(+)  " +
        "        and a.TCO_BUSPARTNER_PK4 =f.pk(+)  " +
        "        and upper(a.pay_meth) = upper(method.code(+)) " +
        "        and a.del_if=0  and  a.pk ='" + pk + "'";
    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    { 
        cust_name = (string)dt.Rows[0][40].ToString(); 
        decl_no =  (string)dt.Rows[0][0].ToString(); 
        decl_dt =  (string)dt.Rows[0][1].ToString(); 
        annex   =  (string)dt.Rows[0][2].ToString();         
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
        "     , to_char(a.ot_tax_rate,'999,999,999,990.99') ot_tax_rate     " +
        "     , decode(v1.tr_ccy,'VND',to_char(nvl(a.ot_tax_calc_amt,0)*nvl(a.ot_tax_rate,0)/100,'999,999,999,999'),to_char(nvl(a.ot_tax_calc_amt,0)*nvl(a.ot_tax_rate,0)/100,'999,999,990.99')) ot_amt     " +
        "     , nvl(v.trans_fee_yn,'N'), a.pk  , decode(nvl(v3.cnv_ratio,1),1,'',to_char(v3.cnv_ratio,'9,999,999')) || v3.uom_nm unit_cd " +
        "     , a.unit_packing, nvl(a.qty_packing,0), a.unit_weight, nvl(a.net_weight,0), nvl(a.gross_weight,0), v.item_code  " +
        " from tim_decl_dtl a, tco_item v, tim_decl_mst v1   " +
        "       , tie_country v2, comm.tco_uom v3 " +
        "       , tco_hscode v4, tco_itemgrp v5 " +
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
        " from tim_decl_dtl a, tco_item v, tim_decl_mst v1   " +
        "       , tie_country v2, comm.tco_uom v3 " +
        "       , tco_hscode v4, tco_itemgrp v5 " +
        " where a.del_if = 0   " +
        "        and  a.tco_item_pk = v.pk  " +
        "        and  a.tim_decl_mst_pk=v1.pk     " +
        "        and  upper(a.item_origin) = upper(v2.country_cd2(+))  " +
        "        and  upper(a.unit_cd) = upper(v3.uom_code(+))  " +
        "        and  v.tco_hscode_pk = v4.pk(+)   " +
        "        and  v.tco_itemgrp_pk = v5.pk " +
        "        and  nvl(v.trans_fee_yn,'N') = 'N' " +
        "        and  a.tim_decl_mst_pk='" + pk + "'" +
        "group by  v3.uom_nm,  a.unit_packing, a.unit_weight, v.trans_fee_yn  ";
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
	{margin:.4in 0in 0in 0in;
	mso-header-margin:.22in;
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
   parent.fnSetActiveSheet(1);
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
  <x:FitToPage/>
  <x:FitToPage/>
  <x:Print>
   <x:FitHeight>0</x:FitHeight>
   <x:ValidPrinterInfo/>
   <x:PaperSizeIndex>9</x:PaperSizeIndex>
   <x:Scale>93</x:Scale>
   <x:HorizontalResolution>600</x:HorizontalResolution>
   <x:VerticalResolution>600</x:VerticalResolution>
  </x:Print>
  <x:Selected/>
  <x:TopRowVisible>15</x:TopRowVisible>
  <x:Panes>
   <x:Pane>
    <x:Number>3</x:Number>
    <x:ActiveRow>24</x:ActiveRow>
    <x:ActiveCol>1</x:ActiveCol>
   </x:Pane>
  </x:Panes>
  <x:ProtectContents>False</x:ProtectContents>
  <x:ProtectObjects>False</x:ProtectObjects>
  <x:ProtectScenarios>False</x:ProtectScenarios>
 </x:WorksheetOptions>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl173>

<table x:str border=0 cellpadding=0 cellspacing=0 width=758 style='border-collapse:
 collapse;table-layout:fixed;width:570pt'>
 <col class=xl172 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl173 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl173 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl174 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl173 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl173 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl173 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl173 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl175 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl173 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <tr class=xl77 height=21 style='height:15.75pt'>
  <td colspan=10 height=21 class=xl198 width=758 style='height:15.75pt;
  width:570pt'>PH&#7908; L&#7908;C T&#7900; KHAI HÀNG HÓA NH&#7852;P KH&#7848;U</td>
 </tr>
 <tr class=xl77 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=10 height=17 class=xl199 style='height:12.75pt'
  x:str="'(B&#7843;n l&#432;u ng&#432;&#7901;i khai H&#7843;i quan)">(B&#7843;n
  l&#432;u ng&#432;&#7901;i khai H&#7843;i quan)</td>
 </tr>
 <tr class=xl77 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl78 style='height:15.75pt'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td class=xl80>Ph&#7909; l&#7909;c s&#7889;</td>
  <td class=xl81 x:str="': 01">: <font class="font18">01</font></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td class=xl82></td>
 </tr>
 <tr class=xl77 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl78 style='height:15.0pt'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td class=xl80>Kèm t&#7901; khai s&#7889;</td>
  <td class=xl81 colspan=2 style='mso-ignore:colspan'
  x:str>: <%=decl_no %>…./NK/SXXK/LT</td>
  <td class=xl82></td>
  <td class=xl83></td>
  <td class=xl82></td>
 </tr>
 <tr class=xl77 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl78 style='height:15.75pt'></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td class=xl80>Ngày &#273;&#259;ng ký</td>
  <td class=xl82 colspan=4 style='mso-ignore:colspan'>:
  <%=decl_dt %>……………………………………………………………………..</td>
  <td class=xl77></td>
 </tr>
 <tr class=xl77 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=10 height=26 class=xl200 style='border-right:.5pt solid black;
  height:19.5pt'>A- PH&#7846;N DÀNH CHO NG&#431;&#7900;I KHAI H&#7842;I QUAN KÊ
  KHAI VÀ TÍNH THU&#7870;</td>
 </tr>
 <tr class=xl90 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl87 width=33 style='height:32.25pt;border-top:none;
  width:25pt'>S&#7888;<br>
    TT</td>
  <td colspan=3 class=xl87 width=266 style='border-left:none;width:200pt'>17.
  TÊN HÀNG <br>
    QUY CÁCH PH&#7848;M CH&#7844;T HÀNG HÓA</td>
  <td class=xl87 width=85 style='border-top:none;border-left:none;width:64pt'>18.
  MÃ S&#7888;<br>
    HÀNG HÓA</td>
  <td class=xl87 width=67 style='border-top:none;border-left:none;width:50pt'>19.XU&#7844;T<br>
    <span style='mso-spacerun:yes'> </span>X&#7912;</td>
  <td class=xl88 style='border-top:none'>20. L&#431;&#7906;NG</td>
  <td class=xl87 width=62 style='border-top:none;border-left:none;width:47pt'>21.&#272;&#416;N<br>
    V&#7882; TÍNH</td>
  <td class=xl89 width=80 style='border-top:none;border-left:none;width:60pt'>22.&#272;&#416;N
  GIÁ<br>
    NGUYÊN T&#7878;</td>
  <td class=xl87 width=86 style='border-top:none;border-left:none;width:65pt'>23.
  TR&#7882; GIÁ<br>
    NGUYÊN T&#7878;</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count;i++ )
     {
 %>
 <tr class=xl97 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl98 style='height:32.25pt;border-top:none' x:num><%=i+1 %></td>
  <td colspan=3 class=xl204 width=266 style='border-left:none;width:200pt'><%=dt.Rows[i][0] %><br>
  (<%=dt.Rows[i][2] %>)/<%=dt.Rows[i][1] %></td>
  <td class=xl99 style='border-top:none;border-left:none'><%=dt.Rows[i][3] %></td>
  <td class=xl98 style='border-top:none;border-left:none'><%=dt.Rows[i][4] %></td>
  <td class=xl100 width=79 style='border-top:none;border-left:none;width:59pt'><%=dt.Rows[i][6] %></td>
  <td class=xl101 style='border-top:none;border-left:none'><%=dt.Rows[i][7] %></td>
  <td class=xl102 style='border-top:none;border-left:none'><%=dt.Rows[i][8] %></td>
  <td class=xl103 style='border-top:none;border-left:none'><%=dt.Rows[i][9] %></td>
 </tr>
 <% 
     }       
 %>
 <%
     for (int i = dt.Rows.Count; i < 10; i++)
     {    
 %>
 <tr class=xl111 height=40 style='mso-height-source:userset;height:30.2pt'>
  <td height=40 class=xl98 style='height:30.2pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl105 style='border-top:none'>&nbsp;</td>
  <td class=xl106 style='border-top:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl100 width=79 style='border-top:none;border-left:none;width:59pt'>&nbsp;</td>
  <td class=xl108 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl109 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl110 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
     }        
 %>
 <tr class=xl129 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl122 style='height:18.0pt'>&nbsp;</td>
  <td class=xl123 style='border-left:none'>&nbsp;</td>
  <td class=xl124>&nbsp;</td>
  <td class=xl125>&nbsp;</td>
  <td class=xl126 style='border-left:none'>&nbsp;</td>
  <td class=xl126 style='border-left:none'>&nbsp;</td>
  <td class=xl126 style='border-left:none'>&nbsp;</td>
  <td class=xl126 style='border-left:none'>&nbsp;</td>
  <td class=xl127 style='border-left:none'>&nbsp;</td>
  <td class=xl128 style='border-left:none' x:str><span
  style='mso-spacerun:yes'> </span><%=tot_net_tr_amt %><span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl82 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td  class=xl130 width=33 style='width:25pt;border-bottom:none;border-right:.5pt solid windowtext;vertical-align:bottom;'>SỐ
    </td>
  <td colspan=3 class=xl131 style='border-left:none;border-left:.5pt solid windowtext'>24. TIỀN THUẾ NHẬP KHẨU</td>
  <td colspan=4 class=xl131 style='border-left:none'>25. TIỀN THUẾ GTGT (TTĐB)</td>
  <td colspan=2 class=xl131 style='border-left:none'>26. THU KHÁC</td>
 </tr>
 <tr class=xl90 height=36 style='height:27.0pt'>
    <td  class=xl130 width=33 style='width:25pt;border-top:none;border-right:.5pt solid windowtext;vertical-align:top;'>
    TT</td>
  <td height=36 class=xl130 width=101 style='height:27.0pt;border-top:none;
  border-left:none;width:76pt;border-left:.5pt solid windowtext'>Trị giá tính thuế<br>
    (VNĐ)</td>
  <td class=xl132 width=70 style='border-top:none;border-left:none;width:53pt'>Tỷ lệ<br>
    (%)</td>
  <td class=xl133 style='border-top:none;border-left:none'>Tiền thuế</td>
  <td class=xl131 style='border-top:none;border-left:none'>Trị giá tính thuế</td>
  <td class=xl132 width=67 style='border-top:none;border-left:none;width:50pt'>Tỷ lệ<br>
    (%)</td>
  <td class=xl133 style='border-top:none;border-left:none'>Tiền thuế</td>
  <td class=xl130 width=62 style='border-top:none;border-left:none;width:47pt'>Trị giá tính thuế</td>
  <td class=xl132 width=80 style='border-top:none;border-left:none;width:60pt'>Tỷ lệ<br>
    (%)</td>
  <td class=xl131 style='border-top:none;border-left:none'>Số tiền</td>
 </tr>
 <%
    for(int i=0; i<dt.Rows.Count ;i++)
    {
  %>
 <tr class=xl82 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl134 style='height:22.5pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl146 style='border-top:none;border-left:none'><%=dt.Rows[i][10] %></td>
  <td class=xl143 style='border-top:none;border-left:none'><%=dt.Rows[i][11] %></td>
  <td class=xl147 style='border-top:none;border-left:none'><%=dt.Rows[i][12] %></td>
  <td class=xl148 style='border-top:none;border-left:none'><%=dt.Rows[i][13] %></td>
  <td class=xl134 style='border-top:none;border-left:none'><%=dt.Rows[i][14] %></td>
  <td class=xl148 style='border-top:none;border-left:none'><%=dt.Rows[i][15] %></td>
  <td class=xl148 style='border-top:none;border-left:none'><%=dt.Rows[i][16] %></td>
  <td class=xl134 style='border-top:none;border-left:none'><%=dt.Rows[i][17] %></td>
  <td class=xl134 style='border-top:none;border-left:none'><%=dt.Rows[i][18] %></td>
 </tr>
 <%
    }
 %>
 <%
    for(int i= dt.Rows.Count ; i<10; i++)
    {
  %>
 <tr class=xl82 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl134 style='height:22.5pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl142 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl143 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl144 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl145 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl145 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl145 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl145 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl145 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl145 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
  }
  %>
 <tr class=xl167 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl160 style='height:16.5pt'>cộng:</td>
  <td class=xl160 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl161 style='border-top:none;border-left:none'
  x:num><span
  style='mso-spacerun:yes'> </span><%=tot_im_tax_amt %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl162 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl163 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl164 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=tot_exc_amt %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl162 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl165 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl166 style='border-top:none;border-left:none' x:num><%=tot_ot_tax_amt %></td>
 </tr>
 <tr class=xl82 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=10 height=41 class=xl205 style='border-right:.5pt solid black;
  height:30.75pt'>29. Tôi xin cam &#273;oan, ch&#7883;u trách nhi&#7879;m
  tr&#432;&#7899;c pháp lu&#7853;t v&#7873; nh&#7919;ng n&#7897;i dung khai báo
  trên ph&#7909; l&#7909;c t&#7901; khai này</td>
 </tr>
 <tr class=xl82 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl168 style='height:18.0pt'>&nbsp;</td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
  <td colspan=4 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl170 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>T&#7893;ng
  giám &#273;&#7889;c</td>
 </tr>
 <tr class=xl82 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl168 style='height:16.5pt'>&nbsp;</td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
  <td colspan=4 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td class=xl171>&nbsp;</td>
 </tr>
 <tr class=xl82 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl168 style='height:20.25pt'>&nbsp;</td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
  <td colspan=4 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td class=xl171>&nbsp;</td>
 </tr>
 <tr class=xl82 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl168 style='height:18.0pt'>&nbsp;</td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl169></td>
  <td colspan=4 class=xl82 style='mso-ignore:colspan'></td>
  <td class=xl83></td>
  <td class=xl171>&nbsp;</td>
 </tr>
 <tr class=xl82 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=10 height=17 class=xl208 style='border-right:.5pt solid black;
  height:12.75pt'>Ng&#432;&#7901;i khai ký, &#273;óng d&#7845;u, ghi rõ
  h&#7885; tên, ch&#7913;c danh</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl172 style='height:12.75pt'></td>
  <td colspan=2 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl174></td>
  <td colspan=4 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl175></td>
  <td class=xl173></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl172 style='height:15.75pt'></td>
  <td colspan=2 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl174></td>
  <td colspan=2 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl176></td>
  <td class=xl173></td>
  <td class=xl175></td>
  <td class=xl173></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl172 style='height:12.75pt'></td>
  <td colspan=2 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl174></td>
  <td colspan=4 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl175></td>
  <td class=xl173></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl172 style='height:12.75pt'></td>
  <td colspan=2 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl174></td>
  <td colspan=4 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl175></td>
  <td class=xl173></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl172 style='height:12.75pt'></td>
  <td colspan=2 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl174></td>
  <td colspan=4 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl175></td>
  <td class=xl173></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl172 style='height:12.75pt'></td>
  <td class=xl177></td>
  <td class=xl173></td>
  <td class=xl174></td>
  <td colspan=4 class=xl173 style='mso-ignore:colspan'></td>
  <td class=xl175></td>
  <td class=xl173></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=86 style='width:65pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
