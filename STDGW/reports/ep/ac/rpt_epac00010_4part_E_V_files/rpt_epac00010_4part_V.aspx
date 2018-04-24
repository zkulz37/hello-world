<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% ESysLib.SetUser("imex");%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
     string l_contract_pk, com_pk, SQL, buyer_name = "", buyer_addr="";
     string contr_no="", contr_date="", seller = "", seller_add = "", seller_tel = "", seller_fax = "", seller_tax = "";
    string reciever = "", reciever_add = "", reciever_tel = "", reciever_fax = "", reciever_tax = "";
    string tradeterm = "", payment = "", curr = "", curr_en = "", curr_vn = "", bank = "", bank_add = "";
    string  bank_ac = "", exp_date = "", payment_local="", partyC="", partyC_add="";
    
     l_contract_pk = Request.QueryString["contract_pk"];	
    com_pk = Request.QueryString["com_pk"];

    SQL = "select PARTNER_NAME, addr1 " +
        "        from tco_company " +
        "        where pk= '" + com_pk + "'";
    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        buyer_name = (string)dt.Rows[0][0].ToString();
        buyer_addr = (string)dt.Rows[0][1].ToString();
    }

    SQL = "select contr_no, to_char(to_date(contr_date,'yyyymmdd'),'dd/MM/yyyy') as contr_date      " +
        "       , vendor.partner_name seller_name, v.addr_nm2 seller_add  " +
        "       , vendor.phone_no seller_tel, vendor.fax_no seller_fax, vendor.tax_code seller_tax   " +
        "       , nvl(ship.partner_name,comp.partner_name) receiver_name, v.addr_nm1 receiver_add   " +
        "       , nvl(ship.phone_no ,comp.phone_no) receiver_tel  " +
        "       , nvl(ship.fax_no ,comp.fax_no) receiver_tel  " +
        "       , nvl(ship.tax_code ,comp.tax_code) receiver_tax  " +
        "       , upper(trade_terms) tradeterm, initcap(s1.code_nm) pay_method, tr_ccy, initcap(curr_en) curr_en " +
        "       , initcap(curr_vn) curr_vn, bank.partner_name bank, bank.addr1 bank_add, v.bank_account   " +
        "       , to_char(to_date(exp_date,'yyyymmdd'),'dd/MM/yyyy') as exp_date , initcap(payment_local) payment_local " +
        "       , partyC.PARTNEr_name partyC_name, addr_nm5 " +
        " from imex.tim_contr_mst v, comm.tco_buspartner ship, tco_company comp     " +
        "       , comm.tco_buspartner vendor, comm.tco_buspartner paid       " +
        "       , comm.tco_buspartner bank, comm.tco_buspartner partyC    " +
        "       ,(  select code, code_nm, code_lnm payment_local        " +
        "         from comm.tco_abcode a, comm.tco_abcodegrp b        " +
        "         where a.tco_abcodegrp_pk = b.pk  and b.id = 'ACCR0020'       " +
        "               and a.use_if = 1 and a.del_if = 0 and b.del_if = 0       " +
        "        ) s1     " +
        "       ,( select code, code_nm        " +
        "          from comm.tco_abcode a, comm.tco_abcodegrp b        " +
        "          where a.tco_abcodegrp_pk = b.pk  and b.id = 'IEAB0010' " +
        "               and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 " +
        "        ) s2     " +
        "       ,( select code, a.code_nm curr_en, a.code_lnm curr_vn  " +
        "          from comm.tco_abcode a, comm.tco_abcodegrp b  " +
        "          where a.tco_abcodegrp_pk = b.pk  and b.id = 'ACAB0110' " +
        "               and a.use_if = 1 and a.del_if = 0 and b.del_if = 0  " +
        "       )s3        " +
        " where v.del_if=0       " +
        "    and tco_buspartner_pk1 = ship.pk(+)      " +
        "    and tco_buspartner_pk = vendor.pk       " +
        "    and tco_buspartner_pk2 = paid.pk(+)     " +
        "    and tco_buspartner_pk1 = comp.pk(+)     " +
        "    and tco_buspartner_pk4 = bank.pk(+)    " +
        "    and tco_buspartner_pk5 = partyC.pk(+)  " +
        "    and upper(pay_term) = upper(s1.code(+))    " +
        "    and upper(trade_terms) = upper(s2.code(+))    " +
        "    and upper(tr_ccy) = upper(s3.code(+))  " +
        "    and v.pk= '" + l_contract_pk + "' ";

    dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        contr_no = (string)dt.Rows[0][0].ToString();
        contr_date = (string)dt.Rows[0][1].ToString();
        seller = (string)dt.Rows[0][2].ToString();
        seller_add = (string)dt.Rows[0][3].ToString();
        seller_tel = (string)dt.Rows[0][4].ToString();
        seller_fax = (string)dt.Rows[0][5].ToString();
        seller_tax = (string)dt.Rows[0][6].ToString();
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
        payment_local = (string)dt.Rows[0][21].ToString();
        partyC = (string)dt.Rows[0][22].ToString();
        partyC_add = (string)dt.Rows[0][23].ToString();
    }

    SQL = " select v4.GRP_NM || ' '|| item_code item " +
        "   , v3.uom_nm, to_char(nvl(v.qty,0),'999,999,990.99') qty " +
        "   , decode('" + curr + "','VND',to_char(nvl(v.u_price,0),'999,999,999'), to_char(nvl(v.u_price,0),'999,999,990.99')) price" +
        "   , decode('" + curr + "','VND',to_char(nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1),'999,999,999'), to_char(nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1),'999,999,990.99')) amt" +
        "   , decode(nvl(v3.CNV_RATIO,1),1,'',to_char(nvl(v3.CNV_RATIO,1),'9,999')) || ' ' || v3.UOM_NM p_unit  " +
        "   ,  COMM.sf_get_item_attribute(v2.pk) item_attribute " +
        "   , v.qty , nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1) " +
        "  from imex.tim_contr_dtl v, comm.tco_item v2 " +
        "        , comm.tco_uom v3, comm.tco_itemgrp v4   " +
        "  where v.del_if=0    " +
        "  and v.tco_item_pk=v2.pk   " +
        "  and v.unit_cd = v3.uom_code(+)  " +
        "  and v2.TCO_ITEMGRP_PK = v4.pk " +
        "  and v.tim_contr_mst_pk = '" + l_contract_pk + "' " +
        "  order by v.pk   ";
    dt = ESysLib.TableReadOpen(SQL);

    SQL = " select v4.GRP_NM || ' '|| item_code item " +
        "   , v3.uom_nm, to_char(nvl(v.qty,0),'999,999,990.99') qty " +
        "   , decode('" + curr + "','VND',to_char(nvl(v.u_price,0),'999,999,999'), to_char(nvl(v.u_price,0),'999,999,990.99')) price" +
        "   , decode('" + curr + "','VND',to_char(nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1),'999,999,999'), to_char(nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1),'999,999,990.99')) amt" +
        "   , decode(nvl(v3.CNV_RATIO,1),1,'',to_char(nvl(v3.CNV_RATIO,1),'9,999')) || ' ' || v3.UOM_NM p_unit  " +
        "   ,  COMM.sf_get_item_attribute(v2.pk) item_attribute " +
        "   , v.qty , nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1) " +
        "  from imex.tim_contr_dtl v, comm.tco_item v2 " +
        "        , comm.tco_uom v3, comm.tco_itemgrp v4   " +
        "  where v.del_if=0    " +
        "  and v.tco_item_pk=v2.pk   " +
        "  and v.unit_cd = v3.uom_code(+)  " +
        "  and v2.TCO_ITEMGRP_PK = v4.pk " +
        "  and v.tim_contr_mst_pk = '" + l_contract_pk + "' " +
        "  order by v.pk   ";
    dt = ESysLib.TableReadOpen(SQL);
    
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link id=Main-File rel=Main-File href="../rpt_epac00010_4part_E_V.htm">
<link rel=File-List href=filelist.xml>
<link rel=Edit-Time-Data href=editdata.mso>
<link rel=Stylesheet href=stylesheet.css>
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .2in .2in .2in;
	mso-header-margin:.2in;
	mso-footer-margin:.2in;}
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
 window.location.replace("../rpt_epac00010_4part_E_V.htm");
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
   <x:Scale>99</x:Scale>
   <x:HorizontalResolution>600</x:HorizontalResolution>
   <x:VerticalResolution>600</x:VerticalResolution>
  </x:Print>
  <x:Zoom>120</x:Zoom>
  <x:Panes>
   <x:Pane>
    <x:Number>3</x:Number>
    <x:ActiveRow>45</x:ActiveRow>
    <x:RangeSelection>$A$46:$G$46</x:RangeSelection>
   </x:Pane>
  </x:Panes>
  <x:ProtectContents>False</x:ProtectContents>
  <x:ProtectObjects>False</x:ProtectObjects>
  <x:ProtectScenarios>False</x:ProtectScenarios>
 </x:WorksheetOptions>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=783 style='border-collapse:
 collapse;table-layout:fixed;width:589pt'>
 <col class=xl26 width=58 style='mso-width-source:userset;mso-width-alt:1649;
 width:44pt'>
 <col class=xl26 width=146 style='mso-width-source:userset;mso-width-alt:4152;
 width:110pt'>
 <col class=xl26 width=153 style='mso-width-source:userset;mso-width-alt:4352;
 width:115pt'>
 <col class=xl26 width=74 style='mso-width-source:userset;mso-width-alt:2104;
 width:56pt'>
 <col class=xl26 width=121 style='mso-width-source:userset;mso-width-alt:3441;
 width:91pt'>
 <col class=xl26 width=111 style='mso-width-source:userset;mso-width-alt:3157;
 width:83pt'>
 <col class=xl26 width=120 style='mso-width-source:userset;mso-width-alt:3413;
 width:90pt'>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=7 height=31 class=xl72 width=783 style='height:23.25pt;
  width:589pt'>H&#7906;P &#272;&#7890;NG MUA BÁN HÀNG HÓA</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=7 height=21 class=xl73 width=783 style='height:15.75pt;
  width:589pt'>S&#7889; : <%=contr_no  %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=6 height=17 class=xl74 style='height:12.75pt'>Hôm nay, ngày :
  <%=contr_date %> , chúng tôi g&#7891;m:</td>
  <td class=xl27></td>
 </tr>
 <tr height=2 style='mso-height-source:userset;height:1.5pt'>
  <td colspan=6 height=2 class=xl75 style='height:1.5pt'></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=204 style='height:12.75pt;
  width:154pt'>Bên A (Bên bán hàng )</td>
  <td colspan=4 class=xl28 width=459 style='width:345pt'><%=seller  %></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=204 style='height:12.75pt;
  width:154pt'>&#272;&#7883;a ch&#7881;</td>
  <td colspan=4 class=xl28 width=459 style='width:345pt'><%=seller_add %></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=204 style='height:12.75pt;
  width:154pt'>&#272;i&#7879;n tho&#7841;i</td>
  <td colspan=4 class=xl28 width=459 style='width:345pt'><%=seller_tel  %><span
  style='mso-spacerun:yes'>  </span>-<span style='mso-spacerun:yes'> 
  </span>Fax : <%=seller_fax  %></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=204 style='height:12.75pt;
  width:154pt'>Mã s&#7889; thu&#7871;</td>
  <td colspan=4 class=xl28 width=459 style='width:345pt'><%=seller_tax  %></td>
  <td class=xl29></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td colspan=2 height=4 class=xl28 width=204 style='height:3.0pt;width:154pt'></td>
  <td colspan=4 class=xl28 width=459 style='width:345pt'></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=204 style='height:12.75pt;
  width:154pt' x:str="Bên B (Bên mua hàng) ">Bên B (Bên mua hàng)<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl28 width=459 style='width:345pt'><%=buyer_name %></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=204 style='height:12.75pt;
  width:154pt'>&#272;&#7883;a ch&#7881;</td>
  <td colspan=4 class=xl28 width=459 style='width:345pt'><%=buyer_addr  %></td>
  <td class=xl29></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td colspan=2 height=4 class=xl28 width=204 style='height:3.0pt;width:154pt'></td>
  <td colspan=4 class=xl28 width=459 style='width:345pt'></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=204 style='height:12.75pt;
  width:154pt'>BÊN C (Bên ch&#7881; &#273;&#7883;nh nh&#7853;n hàng )</td>
  <td colspan=3 class=xl28 width=348 style='width:262pt'><%=partyC  %></td>
  <td class=xl28></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=204 style='height:12.75pt;
  width:154pt'>&#272;&#7883;a ch&#7881;</td>
  <td colspan=5 class=xl28 width=579 style='width:435pt'><%=partyC_add  %></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=2 class=xl28 style='height:3.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 width=459 style='width:345pt'></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=204 style='height:12.75pt;
  width:154pt' x:str="Bên D ( Bên nh&#7853;n hàng ) ">Bên D ( Bên nh&#7853;n
  hàng )<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl28 width=459 style='width:345pt'><%=reciever  %></td>
  <td class=xl29></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl28 width=58 style='height:12.75pt;width:44pt'
  x:str="&#272;&#7883;a ch&#7881; ">&#272;&#7883;a ch&#7881;<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl28></td>
  <td colspan=5 class=xl76 width=579 style='width:435pt'><%=reciever_add  %></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=204 style='height:12.75pt;
  width:154pt' x:str="&#272;i&#7879;n tho&#7841;i ">&#272;i&#7879;n
  tho&#7841;i<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl28 width=348 style='width:262pt'><%=reciever_tel  %><span
  style='mso-spacerun:yes'>                   </span>FAX : <%=reciever_fax  %></td>
  <td class=xl28></td>
  <td class=xl29></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=2 height=18 class=xl28 width=204 style='height:13.5pt;width:154pt'>Mã
  s&#7889; thu&#7871;</td>
  <td colspan=5 class=xl28 width=579 style='width:435pt'><%=reciever_tax  %></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  15'>
  <td height=0 colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl77></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl30 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=6 height=21 class=xl77 style='height:15.75pt'
  x:str>&#272;&#7891;ng
  ý<span style='mso-spacerun:yes'>  </span>ký k&#7871;t H&#7907;p
  &#273;&#7891;ng S&#7889; : <%=contr_no  %> này theo n&#7897;i dung và các
  &#273;i&#7873;u kho&#7843;n sau :<span style='mso-spacerun:yes'> </span></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 colspan=3 style='height:15.0pt;mso-ignore:colspan'>&#272;I&#7872;U
  1<font class="font14">: CH&#7910;NG LO&#7840;I - S&#7888; L&#431;&#7906;NG –
  GIÁ C&#7842;</font></td>
  <td class=xl33><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl33><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td colspan=2 class=xl78><%=tradeterm  %></td>
 </tr>
 <tr class=xl29 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl34 style='height:26.25pt;border-top:none'>STT</td>
  <td colspan=3 class=xl79 style='border-right:.5pt solid black;border-left:
  none'>MÔ T&#7842; HÀNG HÓA</td>
  <td class=xl35 style='border-top:none;border-left:none' x:str="S&#7888; L&#431;&#7906;NG ">S&#7888;
  L&#431;&#7906;NG<span style='mso-spacerun:yes'> </span></td>
  <td class=xl36 width=111 style='border-top:none;border-left:none;width:83pt'>&#272;&#416;N
  GIÁ<br>
    </td>
  <td class=xl37 width=120 style='border-top:none;border-left:none;width:90pt'>TR&#7882;
  GIÁ<br>
    (<%=curr%>)</td>
 </tr>
 <%
     double qty = 0, amt = 0;
    for(int i=0; i<dt.Rows.Count ;i++)
    {
        qty = qty + Convert.ToDouble(dt.Rows[i][7]);
        amt = amt + Convert.ToDouble(dt.Rows[i][8]);
 %>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=36 class=xl62 style='border-bottom:.5pt solid black;
  height:27.0pt;border-top:.5pt solid black' x:num><%=i+1 %></td>
  <td colspan=3 class=xl64 style='border-right:.5pt solid black;border-left:
  .5pt solid black' x:str><%=dt.Rows[i][0] %><span
  style='mso-spacerun:yes'>       </span></td>
  <td rowspan=2 class=xl56 style='border-bottom:.5pt solid black;'><%=dt.Rows[i][2] %> &nbsp;<%=dt.Rows[i][1] %></td>
  <td rowspan=2 class=xl58 style='border-bottom:.5pt solid black;'><%=dt.Rows[i][3] %> </td>
  <td rowspan=2 class=xl67 style='border-bottom:.5pt solid black;'><%=dt.Rows[i][4] %> <%=curr %>/<%=dt.Rows[i][5] %></td>
 </tr>
 <tr class=xl27 height=16 style='height:12.0pt'>
  <td colspan=3 height=16 class=xl69 style='border-right:.5pt solid black;
  height:12.0pt;border-left:.5pt solid black'><%=dt.Rows[i][6] %></td>
 </tr>
 <%} %>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=4 height=17 class=xl82 style='border-right:.5pt solid black;border-top:.5pt solid black;
  height:12.75pt'>T&#7892;NG C&#7896;NG</td>
  <td class=xl59 style='border-top:.5pt solid black;border-left:none'><%=qty  %></td>
  <td class=xl60 style='border-top:.5pt solid black;border-left:none'>&nbsp;</td>
  <td class=xl61 style='border-top:.5pt solid black;border-left:none'><%=amt %></td>
 </tr>
 <tr class=xl38 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl85 style='height:15.0pt'>&#272;I&#7872;U 2:<font
  class="font14"> &#272;&#7882;A &#272;I&#7874;M GIAO HÀNG: </font><font
  class="font16">(&#273;&#432;&#7907;c phép giao hàng t&#7915;ng ph&#7847;n)</font></td>
  <td class=xl38></td>
 </tr>
 <tr class=xl38 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl39 style='height:12.95pt'
  x:str="Bên B ch&#7881; &#273;&#7883;nh bên A giao hàng cho bên C t&#7841;i &#273;&#7883;a ch&#7881; bên D: ">Bên
  B ch&#7881; &#273;&#7883;nh bên A giao hàng cho bên C t&#7841;i
  &#273;&#7883;a ch&#7881; bên D:<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl38 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl86 style='height:12.95pt'><%=reciever  %></td>
 </tr>
 <tr class=xl38 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl86 style='height:12.95pt'><%=reciever_add  %></td>
 </tr>
 <tr class=xl38 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl86 style='height:12.95pt'>TEL :
  <%=reciever_tel  %><span style='mso-spacerun:yes'>                   </span>FAX :
  <%=reciever_fax  %></td>
 </tr>
 <tr class=xl38 height=8 style='mso-height-source:userset;height:6.0pt'>
  <td colspan=6 height=8 class=xl86 style='height:6.0pt'></td>
  <td class=xl38></td>
 </tr>
 <tr class=xl38 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl87 style='height:15.0pt'><span
  style='mso-spacerun:yes'> </span><font class="font13">&#272;I&#7872;U 3:</font><font
  class="font14"> PH&#431;&#416;NG TH&#7912;C THANH TOÁN :</font></td>
  <td class=xl38></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 rowspan=3 height=51 class=xl89 style='height:38.85pt'
  x:str>Bên
  C thanh toán cho bên B, bên B thanh toán cho bên A theo ph&#432;&#417;ng
  th&#7913;c <%=payment_local %> (<%=payment  %>) b&#7857;ng &#272;&#7891;ng <%=curr_vn %>
  thông qua Ngân hàng <%=bank  %> <%=bank_add  %>, s&#7889; tài kho&#7843;n
  <%=bank_ac  %>(<%=curr  %>)<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
 </tr>
 <tr class=xl38 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 colspan=7 class=xl39 style='height:12.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl88 style='height:15.0pt'>&#272;I&#7872;U 4:<font
  class="font14"> TRÁCH NHI&#7878;M C&#7910;A BÊN A :</font></td>
  <td class=xl38></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl89 style='height:12.95pt'>Ch&#7883;u trách
  nhi&#7879;m v&#7873; s&#7889; l&#432;&#7907;ng và ch&#7845;t l&#432;&#7907;ng
  c&#7911;a hàng hoá s&#7843;n xu&#7845;t và &#273;&#7843;m b&#7843;o
  th&#7901;i gian<span style='mso-spacerun:yes'>  </span>giao hàng &#273;úng
  nh&#432; qui &#273;&#7883;nh.</td>
 </tr>
 <tr class=xl38 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl39 style='height:12.95pt'></td>
 </tr>
 <tr class=xl38 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl88 style='height:15.0pt'>&#272;I&#7872;U 5:<font
  class="font14"> TRÁCH NHI&#7878;M C&#7910;A BÊN B :</font></td>
  <td class=xl38></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=6 height=17 class=xl89 style='height:12.95pt'>&#272;&#7843;m
  b&#7843;o thanh toán &#273;úng h&#7841;n theo qui &#273;&#7883;nh t&#7841;i
  &#272;i&#7873;u 3 c&#7911;a h&#7907;p &#273;&#7891;ng.</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl38 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 colspan=6 class=xl39 style='height:12.95pt;mso-ignore:colspan'></td>
  <td class=xl38></td>
 </tr>
 <tr class=xl38 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl88 style='height:15.0pt'>&#272;I&#7872;U 6:<font
  class="font14"> &#272;I&#7872;U KHO&#7842;N CHUNG :</font></td>
  <td class=xl38></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=6 height=17 class=xl89 style='height:12.95pt'
  x:str="H&#7907;p &#273;&#7891;ng  này có giá tr&#7883; trong vi&#7879;c giao d&#7883;ch gi&#7919;a các bên ">H&#7907;p
  &#273;&#7891;ng<span style='mso-spacerun:yes'>  </span>này có giá tr&#7883;
  trong vi&#7879;c giao d&#7883;ch gi&#7919;a các bên<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl89 style='height:12.95pt'
  x:str="Bên C có trách nhi&#7879;m thông báo cho bên D nh&#7919;ng thông tin c&#7847;n thi&#7871;t và cùng h&#7907;p tác v&#7899;i bên A hoàn thành &#273;&#7847;y &#273;&#7911; các th&#7911; t&#7909;c cho vi&#7879;c giao ">Bên
  C có trách nhi&#7879;m thông báo cho bên D nh&#7919;ng thông tin c&#7847;n
  thi&#7871;t và cùng h&#7907;p tác v&#7899;i bên A hoàn thành &#273;&#7847;y
  &#273;&#7911; các th&#7911; t&#7909;c cho vi&#7879;c giao<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl89 style='height:12.95pt'
  x:str="nh&#7853;n hàng hóa. T&#7845;t c&#7843; nh&#7919;ng v&#7845;n &#273;&#7873; phát sinh trong quá trình th&#7921;c hi&#7879;n h&#7907;p &#273;&#7891;ng  s&#7869; &#273;&#432;&#7907;c gi&#7843;i quy&#7871;t d&#7921;a trên l&#7907;i ích c&#7911;a các bên tham gia.   ">nh&#7853;n
  hàng hóa. T&#7845;t c&#7843; nh&#7919;ng v&#7845;n &#273;&#7873; phát sinh
  trong quá trình th&#7921;c hi&#7879;n h&#7907;p &#273;&#7891;ng<span
  style='mso-spacerun:yes'>  </span>s&#7869; &#273;&#432;&#7907;c gi&#7843;i
  quy&#7871;t d&#7921;a trên l&#7907;i ích c&#7911;a các bên tham gia.<span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl89 style='height:12.95pt'>M&#7885;i s&#7921;
  s&#7917;a &#273;&#7893;i, b&#7893; sung các &#273;i&#7873;u kho&#7843;n
  c&#7911;a h&#7907;p &#273;&#7891;ng<span style='mso-spacerun:yes'> 
  </span>này ph&#7843;i &#273;&#432;&#7907;c l&#7853;p thành v&#259;n b&#7843;n
  và ph&#7843;i có s&#7921; xác nh&#7853;n &#273;&#7891;ng ý gi&#7919;a các
  bên.</td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl40 style='height:12.95pt'>H&#7907;p
  &#273;&#7891;ng này<span style='mso-spacerun:yes'>  </span>này có giá
  tr&#7883; k&#7875; t&#7915; ngày ký<span style='mso-spacerun:yes'> 
  </span>&#273;&#7871;n ngày <%=exp_date  %></td>
 </tr>
 <tr class=xl25 height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 colspan=7 class=xl40 style='height:6.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=2 height=41 class=xl90 width=204 style='height:30.75pt;
  width:154pt'><%=seller  %></td>
  <td class=xl41 width=153 style='width:115pt'><%=buyer_name  %></td>
  <td colspan=2 class=xl90 width=195 style='width:147pt'><%=partyC  %></td>
  <td colspan=2 class=xl90 width=231 style='width:173pt'><%=reciever  %></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=7 class=xl41 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=58 style='width:44pt'></td>
  <td width=146 style='width:110pt'></td>
  <td width=153 style='width:115pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=120 style='width:90pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
