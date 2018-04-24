﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% ESysLib.SetUser("imex");%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string l_contract_pk, com_pk, SQL, buyer_name = "", buyer_addr="";
    string contr_no="", contr_date="", seller = "", seller_add = "", seller_tel = "", seller_fax = "", seller_tax = "";
    string reciever = "", reciever_add = "", reciever_tel = "", reciever_fax = "", reciever_tax = "";
    string tradeterm = "", payment = "", curr = "", curr_en = "", curr_vn = "", bank = "", bank_add = "", bank_ac = "", exp_date = "";
           
    l_contract_pk = Request.QueryString["contract_pk"];	
    com_pk = Request.QueryString["com_pk"];

    SQL = "select partner_name, addr1, phone_no ,fax_no, tax_code " +
        "        from tco_company " +
        "        where pk= '" + com_pk + "'";
    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        seller = (string)dt.Rows[0][0].ToString();
        seller_add  = (string)dt.Rows[0][1].ToString();
        seller_tel  = (string)dt.Rows[0][2].ToString();
        seller_fax = (string)dt.Rows[0][3].ToString();
        seller_tax = (string)dt.Rows[0][4].ToString();
    }

    SQL = " select contr_no, to_char(to_date(contr_date,'yyyymmdd'),'Mon dd, yyyy') as contr_date     " +
        "       , vendor.partner_name seller_name, v.addr_nm2 seller_add " +
        "       , vendor.phone_no seller_tel, vendor.fax_no seller_fax, vendor.tax_code seller_tax  " +
        "       , nvl(ship.partner_name,comp.partner_name) receiver_name, v.addr_nm1 receiver_add  " +
        "       , nvl(ship.phone_no ,comp.phone_no) receiver_tel " +
        "       , nvl(ship.fax_no ,comp.fax_no) receiver_tel " +
        "       , nvl(ship.tax_code ,comp.tax_code) receiver_tax " +
        "       , upper(trade_terms) tradeterm, s1.code_nm pay_method, tr_ccy, initcap(curr_en), initcap(curr_vn)  " +
        "       , bank.partner_name bank, bank.addr1 bank_add, v.bank_account  " +
        "       , to_char(to_date(exp_date,'yyyymmdd'),'Mon dd, yyyy') as exp_date " +
        " from imex.tex_contr_mst v, comm.tco_buspartner ship, tco_company comp    " +
        "       , comm.tco_buspartner vendor, comm.tco_buspartner paid      " +
        "       , comm.tco_buspartner bank  " +
        "       ,(  select code, code_nm       " +
        "         from comm.tco_abcode a, comm.tco_abcodegrp b       " +
        "         where a.tco_abcodegrp_pk = b.pk  and b.id = 'ACCR0020'      " +
        "               and a.use_if = 1 and a.del_if = 0 and b.del_if = 0      " +
        "        ) s1    " +
        "       ,( select code, code_nm       " +
        "          from comm.tco_abcode a, comm.tco_abcodegrp b       " +
        "          where a.tco_abcodegrp_pk = b.pk  and b.id = 'IEAB0010'      " +
        "               and a.use_if = 1 and a.del_if = 0 and b.del_if = 0      " +
        "        ) s2    " +
        "       ,( select code, a.code_nm curr_en, a.code_lnm curr_vn       " +
        "          from comm.tco_abcode a, comm.tco_abcodegrp b       " +
        "          where a.tco_abcodegrp_pk = b.pk  and b.id = 'ACAB0110'      " +
        "               and a.use_if = 1 and a.del_if = 0 and b.del_if = 0   " +
        "       )s3       " +
        " where v.del_if=0      " +
        "    and tco_buspartner_pk1 = ship.pk(+)     " +
        "    and tco_buspartner_pk = vendor.pk      " +
        "    and tco_buspartner_pk2 = paid.pk(+)    " +
        "    and tco_buspartner_pk1 = comp.pk(+)    " +
        "    and tco_buspartner_pk4 = bank.pk(+)   " +
        "    and upper(pay_term) = upper(s1.code(+))   " +
        "    and upper(trade_terms) = upper(s2.code(+))   " +
        "    and upper(tr_ccy) = upper(s3.code(+))  " +
        "    and v.pk= '" + l_contract_pk + "' ";

    dt= ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        contr_no = (string)dt.Rows[0][0].ToString();
        contr_date = (string)dt.Rows[0][1].ToString();
        buyer_name = (string)dt.Rows[0][2].ToString();
        buyer_addr = (string)dt.Rows[0][3].ToString();
        //seller_tel = (string)dt.Rows[0][4].ToString();
        //seller_fax = (string)dt.Rows[0][5].ToString();
        //seller_tax = (string)dt.Rows[0][6].ToString();
        reciever = (string)dt.Rows[0][7].ToString();
        reciever_add = (string)dt.Rows[0][8].ToString();
        reciever_tel = (string)dt.Rows[0][9].ToString();
        reciever_fax = (string)dt.Rows[0][10].ToString();
        reciever_tax = (string)dt.Rows[0][11].ToString();
        tradeterm = (string)dt.Rows[0][12].ToString();
        payment = (string)dt.Rows[0][13].ToString();
        curr = (string)dt.Rows[0][14].ToString();
        curr_en = (string)dt.Rows[0][15].ToString();
        curr_vn = (string)dt.Rows[0][16].ToString();
        bank = (string)dt.Rows[0][17].ToString();
        bank_add = (string)dt.Rows[0][18].ToString();
        bank_ac = (string)dt.Rows[0][19].ToString();
        exp_date = (string)dt.Rows[0][20].ToString();
    }

    SQL = " select v4.GRP_NM || ' '|| item_code item " +
        "   , v3.uom_nm, to_char(nvl(v.qty,0),'999,999,990.99') qty " +
        "   , decode('" + curr + "','VND',to_char(nvl(v.u_price,0),'999,999,999'), to_char(nvl(v.u_price,0),'999,999,990.99')) price" +
        "   , decode('" + curr + "','VND',to_char(nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1),'999,999,999'), to_char(nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1),'999,999,990.99')) amt" +
        "   , decode(nvl(v3.CNV_RATIO,1),1,'',to_char(nvl(v3.CNV_RATIO,1),'9,999')) || ' ' || v3.UOM_NM p_unit  " +        
        "   ,  COMM.sf_get_item_attribute(v2.pk) item_attribute " +
        "   , v.qty , nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1) " +
        "  from imex.tex_contr_dtl v, comm.tco_item v2 " +
        "        , comm.tco_uom v3, comm.tco_itemgrp v4   " +
        "  where v.del_if=0    " +
        "  and v.tco_item_pk=v2.pk   " +
        "  and v.unit_cd = v3.uom_code(+)  " +
        "  and v2.TCO_ITEMGRP_PK = v4.pk " +
        "  and v.tex_contr_mst_pk = '" + l_contract_pk + "' " +
        "  order by v.pk   ";
    dt = ESysLib.TableReadOpen(SQL);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link id=Main-File rel=Main-File href="../rpt_epac00030_3part_E_V.htm">
<link rel=File-List href=filelist.xml>
<link rel=Edit-Time-Data href=editdata.mso>
<link rel=Stylesheet href=stylesheet.css>
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in .18in .17in .18in;
	mso-header-margin:.17in;
	mso-footer-margin:.18in;}
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
 window.location.replace("../rpt_epac00030_3part_E_V.htm");
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
   <x:Scale>98</x:Scale>
   <x:HorizontalResolution>600</x:HorizontalResolution>
   <x:VerticalResolution>600</x:VerticalResolution>
  </x:Print>
  <x:Zoom>120</x:Zoom>
  <x:TopRowVisible>11</x:TopRowVisible>
  <x:Panes>
   <x:Pane>
    <x:Number>3</x:Number>
    <x:ActiveRow>25</x:ActiveRow>
    <x:ActiveCol>5</x:ActiveCol>
    <x:RangeSelection>$F$26:$H$27</x:RangeSelection>
   </x:Pane>
  </x:Panes>
  <x:ProtectContents>False</x:ProtectContents>
  <x:ProtectObjects>False</x:ProtectObjects>
  <x:ProtectScenarios>False</x:ProtectScenarios>
 </x:WorksheetOptions>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=785 style='border-collapse:
 collapse;table-layout:fixed;width:591pt'>
 <col class=xl26 width=45 style='mso-width-source:userset;mso-width-alt:1280;
 width:34pt'>
 <col class=xl26 width=134 style='mso-width-source:userset;mso-width-alt:3811;
 width:101pt'>
 <col class=xl26 width=109 style='mso-width-source:userset;mso-width-alt:3100;
 width:82pt'>
 <col class=xl26 width=89 style='mso-width-source:userset;mso-width-alt:2531;
 width:67pt'>
 <col class=xl26 width=76 style='mso-width-source:userset;mso-width-alt:2161;
 width:57pt'>
 <col class=xl26 width=110 style='mso-width-source:userset;mso-width-alt:3128;
 width:83pt'>
 <col class=xl26 width=97 style='mso-width-source:userset;mso-width-alt:2759;
 width:73pt'>
 <col class=xl26 width=125 style='mso-width-source:userset;mso-width-alt:3555;
 width:94pt'>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=8 height=31 class=xl68 width=785 style='height:23.25pt;
  width:591pt'>SALES CONTRACT</td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=8 height=21 class=xl131 width=785 style='height:15.75pt;
  width:591pt'>NO : <%=contr_no %></td>
 </tr>
 <tr class=xl27 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=8 height=19 class=xl132 width=785 style='height:14.25pt;
  width:591pt'>DATE : <%=contr_date %></td>
 </tr>
 <tr class=xl27 height=2 style='mso-height-source:userset;height:1.5pt'>
  <td colspan=7 height=2 class=xl71 style='height:1.5pt'></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td colspan=2 height=15 class=xl28 width=179 style='height:11.25pt;
  width:135pt'>PARTY A (Seller):</td>
  <td colspan=5 class=xl28 width=481 style='width:362pt'><%=seller%></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl27 style='height:11.25pt'></td>
  <td class=xl57 width=134 style='width:101pt' x:str="Address: ">Address:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl31 width=606 style='width:456pt'><%=seller_add %></td>
 </tr>
 <tr class=xl27 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl27 style='height:11.25pt'></td>
  <td class=xl57 width=134 style='width:101pt'>Telephone:</td>
  <td colspan=5 class=xl31 width=481 style='width:362pt'><%=seller_tel %>-Fax : <%=seller_fax %></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl27 style='height:11.25pt'></td>
  <td class=xl57 width=134 style='width:101pt'>Tax code:</td>
  <td colspan=6 class=xl31 width=606 style='width:456pt'><%=seller_tax %></td>
 </tr>
 <tr class=xl27 height=10 style='mso-height-source:userset;height:7.5pt'>
  <td colspan=2 height=10 class=xl28 width=179 style='height:7.5pt;width:135pt'></td>
  <td colspan=5 class=xl28 width=481 style='width:362pt'></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td colspan=2 height=15 class=xl28 width=179 style='height:11.25pt;
  width:135pt'>PARTY B (Buyer):</td>
  <td colspan=5 class=xl28 width=481 style='width:362pt'><%=buyer_name %></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl27 style='height:11.25pt'></td>
  <td class=xl57 width=134 style='width:101pt' x:str="Address: ">Address:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl31 width=606 style='width:456pt'><%=buyer_addr %></td>
 </tr>
 <tr class=xl27 height=7 style='mso-height-source:userset;height:5.25pt'>
  <td colspan=2 height=7 class=xl28 width=179 style='height:5.25pt;width:135pt'></td>
  <td colspan=5 class=xl46 width=481 style='width:362pt'></td>
  <td class=xl47></td>
 </tr>
 <tr class=xl27 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:435'>
  <td colspan=2 class=xl28 width=179 style='width:135pt'>PARTY C (Nominated
  Party for goods delivered):</td>
  <td colspan=5 class=xl28 width=481 style='width:362pt' x:num>0</td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:225'>
  <td height=0 class=xl27></td>
  <td class=xl57 width=134 style='width:101pt' x:str="Address: ">Address:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl31 width=606 style='width:456pt' x:num>0</td>
 </tr>
 <tr class=xl27 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:90'>
  <td height=0 colspan=8 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td colspan=2 height=15 class=xl28 width=179 style='height:11.25pt;
  width:135pt'>PARTY C(Receiver):</td>
  <td colspan=5 class=xl28 width=481 style='width:362pt'><%=reciever %></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl27 style='height:11.25pt'></td>
  <td class=xl57 width=134 style='width:101pt' x:str="Address: ">Address:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl31 width=606 style='width:456pt'><%=reciever_add %></td>
 </tr>
 <tr class=xl27 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl27 style='height:11.25pt'></td>
  <td class=xl57 width=134 style='width:101pt'>Telephone:</td>
  <td colspan=5 class=xl31 width=481 style='width:362pt'><%=reciever_tel %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    FAX : <%=reciever_fax %></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl27 style='height:11.25pt'></td>
  <td class=xl57 width=134 style='width:101pt'>Tax code:</td>
  <td colspan=6 class=xl31 width=606 style='width:456pt'><%=reciever_tax %></td>
 </tr>
 <tr class=xl27 height=5 style='mso-height-source:userset;height:3.75pt'>
  <td colspan=2 height=5 class=xl28 width=179 style='height:3.75pt;width:135pt'></td>
  <td colspan=4 class=xl46 width=384 style='width:289pt'></td>
  <td class=xl46></td>
  <td class=xl48></td>
 </tr>
 <tr class=xl27 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=8 height=17 class=xl31 width=785 style='height:12.75pt;
  width:591pt'>Agreed to sign this contract with the following terms and
  conditions:</td>
 </tr>
 <tr class=xl27 height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=2 class=xl31 style='height:6.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl123 width=481 style='width:362pt'></td>
  <td class=xl49></td>
 </tr>
 <tr class=xl27 height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=7 height=18 class=xl122 style='height:13.5pt'>1. <font
  class="font12">ARTICLE 1: COMMODITIES</font></td>
  <td class=xl48></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl33><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl33><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl33><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl33><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl33><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl33><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl50><%=tradeterm %></td>
 </tr>
 <tr class=xl51 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl34 style='height:23.25pt;border-top:none'>No</td>
  <td colspan=4 class=xl124 style='border-right:.5pt solid black;border-left:
  none'>Description of goods</td>
  <td class=xl34 style='border-top:none;border-left:none'>Quantity </td>
  <td class=xl36 width=97 style='border-top:none;border-left:none;width:73pt'>Unit
  price<br>
    (<%=curr %>)</td>
  <td class=xl37 width=125 style='border-left:none;width:94pt'>Total<br>
    (<%=curr %>)</td>
 </tr> 
 <% 
     double qty = 0, amt = 0;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         qty = qty + Convert.ToDouble(dt.Rows[i][7]);
         amt = amt + Convert.ToDouble(dt.Rows[i][8]);
 %>
 <tr class=xl222 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl116 style='border-bottom:.5pt solid black;
  height:30.0pt;border-top:none' x:num><%=i+1 %></td>
  <td colspan=4 class=xl106 width=408 style='border-right:.5pt solid black;
  border-left:none;width:307pt' x:str><%=dt.Rows[i][0] %></td>
  <td rowspan=2 class=xl66   x:num><%=dt.Rows[i][2] %> &nbsp;<%=dt.Rows[i][1] %> </td>
  <td rowspan=2 class=xl80   x:num><%=dt.Rows[i][3] %></td>
  <td rowspan=2 class=xl78   x:num><%=dt.Rows[i][4] %></td>
 </tr>
 <tr class=xl222 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl72 style='border-right:.5pt solid black;
  height:15.0pt;border-left:none;border-top:none'><%=dt.Rows[i][6] %></td>
 </tr>  
 <%} %>
 <tr class=xl54 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl53 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td colspan=4 class=xl102 style='border-right:.5pt solid black;border-left:
  none'>Total:</td>
  <td class=xl38 style='border-left:none' align="right" x:num><%=qty %></td>
  <td class=xl38 style='border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-left:none' align="right" x:num><%=amt %></td>
 </tr>
 <tr class=xl27 height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 colspan=5 class=xl45 style='height:3.75pt;mso-ignore:colspan'></td>
  <td class=xl55></td>
  <td class=xl27></td>
  <td class=xl56></td>
 </tr>
 <tr class=xl41 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:300'>
  <td colspan=7 class=xl42>SAY TOTAL: US DOLLARS SIXTEEN THOUSAND EIGHTEEN AND
  SIXTY CENTS ONLY.</td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=8 height=17 class=xl122 style='height:12.95pt'>2. <font
  class="font12">ARTICLE 2: DELIVERY TERMS</font></td>
 </tr>
 <tr class=xl41 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:248'>
  <td colspan=8 class=xl42>Delivery time: from the signed of contract to the
  end of Mar 2008.</td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=7 height=16 class=xl42 style='height:12.4pt'>As the agreed on the
  signed of contract between Party A and Party B requested Party A will
  delivery goods to Party C as address:</td>
  <td class=xl42></td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl96 style='height:12.4pt'><%=reciever %></td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl96 style='height:12.4pt'><%=reciever_add %></td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl96 style='height:12.4pt'>Tel:
  <%=reciever_tel %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    FAX :<%=reciever_fax %></td>
 </tr>
 <tr class=xl41 height=6 style='mso-height-source:userset;height:4.5pt'>
  <td colspan=8 height=6 class=xl42 style='height:4.5pt'></td>
 </tr>
 <tr class=xl41 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=8 height=17 class=xl97 style='height:12.95pt'>3. <font
  class="font12">ARTICLE 3: PAYMENT TERMS</font></td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 rowspan=2 height=32 class=xl133 width=785 style='height:24.8pt;
  width:591pt'>Party B pays to Party A by <%=payment %> in <%=curr_en %>, through
  <%=bank %>, <%=bank_add %>, A/C No: <%=bank_ac %></td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
 </tr>
 <tr class=xl41 height=6 style='mso-height-source:userset;height:4.5pt'>
  <td colspan=7 height=6 class=xl97 style='height:4.5pt'></td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=7 height=20 class=xl122 style='height:15.0pt'>4. <font
  class="font12">ARTICLE 4: PARTY A'S RESPONSIBILITY</font></td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl42 style='height:12.4pt'>To assume
  responsibility for the Quantity and Quanlity of Goods, to assume
  responsibility for delivery time of Article 2.</td>
 </tr>
 <tr class=xl41 height=5 style='mso-height-source:userset;height:3.75pt'>
  <td colspan=8 height=5 class=xl42 style='height:3.75pt'></td>
 </tr>
 <tr class=xl41 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=7 height=20 class=xl122 style='height:15.0pt'>5. <font
  class="font12">ARTICLE 4: PARTY B'S RESPONSIBILITY</font></td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl42 style='height:12.4pt'>To assume
  responsibility for Payment in time of Article 3.</td>
 </tr>
 <tr class=xl41 height=7 style='mso-height-source:userset;height:5.25pt'>
  <td colspan=7 height=7 class=xl42 style='height:5.25pt'></td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl87 style='height:12.95pt'>6. ARTICLE 4:
  GENERAL CONDITION</td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl42 style='height:12.4pt'>This contract which
  is vaild for the transaction between Party A and Party B.</td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl96 style='height:12.4pt'
  x:str="Party B is responsible informing its to Party C necessary information in order to CO-ordinate with Party A in fulfilling for delivering and receiving the goods. ">Party
  B is responsible informing its to Party C necessary information in order to
  CO-ordinate with Party A in fulfilling for delivering and receiving the
  goods.<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl42 style='height:12.4pt'>All problems during
  implementation of the contract will be settled upon multi interest any
  admendments to the contract are to be made in writing and it must be</td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl42 style='height:12.4pt'>be confirmed by both
  Parties.</td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl134 style='height:12.4pt'>The contract is
  made 06 ( 03 in English and 03 in Vietnamese ) original of the validity and
  valid till <%=exp_date %></td>
 </tr>
 <tr class=xl41 height=16 style='mso-height-source:userset;height:12.4pt'>
  <td colspan=8 height=16 class=xl42 style='height:12.4pt'>each Party keeps 02
  sets for implemmentation.</td>
 </tr>
 <tr class=xl41 height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=8 height=11 class=xl42 style='height:8.25pt'></td>
 </tr>
 <tr class=xl27 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=2 height=31 class=xl101 width=179 style='height:23.25pt;
  width:135pt'><%=seller %></td>
  <td colspan=4 class=xl101 width=384 style='width:289pt'><%=buyer_name %></td>
  <td colspan=2 class=xl101 width=222 style='width:167pt'><%=reciever %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=45 style='width:34pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=125 style='width:94pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>