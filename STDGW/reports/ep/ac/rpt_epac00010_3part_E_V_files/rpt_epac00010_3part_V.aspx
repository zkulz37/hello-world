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
    string tradeterm = "", payment = "", curr = "", curr_en = "", curr_vn = "", bank = "", bank_add = "", bank_ac = "", exp_date = "", payment_local="";
           
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
        " from imex.tim_contr_mst v, comm.tco_buspartner ship, tco_company comp     " +
        "       , comm.tco_buspartner vendor, comm.tco_buspartner paid       " +
        "       , comm.tco_buspartner bank   " +
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
        "    and upper(pay_term) = upper(s1.code(+))    " +
        "    and upper(trade_terms) = upper(s2.code(+))    " +
        "    and upper(tr_ccy) = upper(s3.code(+))  " +
        "    and v.pk= '" + l_contract_pk + "' ";

    dt= ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        contr_no = (string) dt.Rows[0][0].ToString() ; 
        contr_date = (string) dt.Rows[0][1].ToString() ; 
        seller = (string) dt.Rows[0][2].ToString() ; 
        seller_add = (string) dt.Rows[0][3].ToString() ; 
        seller_tel = (string) dt.Rows[0][4].ToString() ; 
        seller_fax = (string) dt.Rows[0][5].ToString() ; 
        seller_tax = (string) dt.Rows[0][6].ToString() ;
        reciever = (string) dt.Rows[0][7].ToString() ; 
        reciever_add = (string) dt.Rows[0][8].ToString() ; 
        reciever_tel = (string) dt.Rows[0][9].ToString() ; 
        reciever_fax = (string) dt.Rows[0][10].ToString() ; 
        reciever_tax = (string) dt.Rows[0][11].ToString() ;
        tradeterm = (string) dt.Rows[0][12].ToString() ; 
        payment = (string) dt.Rows[0][13].ToString() ; 
        curr = (string) dt.Rows[0][14].ToString() ; 
        curr_en = (string) dt.Rows[0][15].ToString() ; 
        curr_vn = (string) dt.Rows[0][16].ToString() ; 
        bank = (string) dt.Rows[0][17].ToString() ; 
        bank_add = (string) dt.Rows[0][18].ToString() ; 
        bank_ac = (string) dt.Rows[0][19].ToString() ; 
        exp_date = (string) dt.Rows[0][20].ToString() ;
        payment_local= (string) dt.Rows[0][21].ToString() ;
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
    
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link id=Main-File rel=Main-File href="../rpt_epac00010_3part_E_V.htm">
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
 window.location.replace("../rpt_epac00010_3part_E_V.htm");
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
   <x:Scale>89</x:Scale>
   <x:HorizontalResolution>600</x:HorizontalResolution>
   <x:VerticalResolution>600</x:VerticalResolution>
  </x:Print>
  <x:Zoom>120</x:Zoom>
  <x:Selected/>
  <x:TopRowVisible>21</x:TopRowVisible>
  <x:Panes>
   <x:Pane>
    <x:Number>3</x:Number>
    <x:ActiveRow>24</x:ActiveRow>
    <x:ActiveCol>1</x:ActiveCol>
    <x:RangeSelection>$B$25:$D$25</x:RangeSelection>
   </x:Pane>
  </x:Panes>
  <x:ProtectContents>False</x:ProtectContents>
  <x:ProtectObjects>False</x:ProtectObjects>
  <x:ProtectScenarios>False</x:ProtectScenarios>
 </x:WorksheetOptions>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=865 style='border-collapse:
 collapse;table-layout:fixed;width:650pt'>
 <col class=xl26 width=58 style='mso-width-source:userset;mso-width-alt:1649;
 width:44pt'>
 <col class=xl26 width=184 style='mso-width-source:userset;mso-width-alt:5233;
 width:138pt'>
 <col class=xl26 width=120 style='mso-width-source:userset;mso-width-alt:3413;
 width:90pt'>
 <col class=xl26 width=74 style='mso-width-source:userset;mso-width-alt:2104;
 width:56pt'>
 <col class=xl26 width=113 style='mso-width-source:userset;mso-width-alt:3214;
 width:85pt'>
 <col class=xl26 width=108 style='mso-width-source:userset;mso-width-alt:3072;
 width:81pt'>
 <col class=xl26 width=128 style='mso-width-source:userset;mso-width-alt:3640;
 width:96pt'>
 <col class=xl26 width=80 style='width:60pt'>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=7 height=31 class=xl68 width=785 style='height:23.25pt;
  width:590pt'>H&#7906;P &#272;&#7890;NG MUA BÁN HÀNG HÓA</td>
  <td class=xl26 width=80 style='width:60pt'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=7 height=21 class=xl69 width=785 style='height:15.75pt;
  width:590pt'>S&#7889; :<span style='mso-spacerun:yes'>  </span><%=contr_no %></td>
  <td class=xl26></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=6 height=17 class=xl70 style='height:12.75pt'>Hôm nay, ngày :
  <%=contr_date %> , chúng tôi g&#7891;m:</td>
  <td class=xl27></td>
  <td class=xl26></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=6 height=17 class=xl71 style='height:12.75pt'></td>
  <td class=xl27></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=242 style='height:12.75pt;
  width:182pt'>Bên A (Bên bán hàng )</td>
  <td colspan=5 class=xl28 width=543 style='width:408pt'><%=seller %></td>
  <td class=xl27></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl31 width=242 style='height:12.75pt;
  width:182pt'>&#272;&#7883;a ch&#7881;</td>
  <td colspan=6 class=xl31 width=623 style='width:468pt'><%=seller_add %></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl31 width=242 style='height:12.75pt;
  width:182pt'>&#272;i&#7879;n tho&#7841;i</td>
  <td colspan=5 class=xl31 width=543 style='width:408pt'><%=seller_tel %><span
  style='mso-spacerun:yes'>  </span>-<span style='mso-spacerun:yes'> 
  </span>Fax : <%=seller_fax %></td>
  <td class=xl27></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl31 width=242 style='height:12.75pt;
  width:182pt'>Mã s&#7889; thu&#7871;</td>
  <td colspan=6 class=xl31 width=623 style='width:468pt'><%=seller_tax %></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=242 style='height:12.75pt;
  width:182pt'></td>
  <td colspan=4 class=xl28 width=415 style='width:312pt'></td>
  <td class=xl29></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=242 style='height:12.75pt;
  width:182pt' x:str="Bên B (Bên mua hàng/ch&#7881; &#273;&#7883;nh giao hàng) ">Bên
  B (Bên mua hàng/ch&#7881; &#273;&#7883;nh giao hàng)<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl28 width=543 style='width:408pt'><%=buyer_name %></td>
  <td class=xl27></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl31 width=242 style='height:12.75pt;
  width:182pt'>&#272;&#7883;a ch&#7881;</td>
  <td colspan=6 class=xl31 width=623 style='width:468pt'><%=buyer_addr %></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=242 style='height:12.75pt;
  width:182pt'></td>
  <td colspan=4 class=xl28 width=415 style='width:312pt'></td>
  <td class=xl29></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl30 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:255'>
  <td colspan=2 class=xl28 width=242 style='width:182pt'>BÊN C (Bên ch&#7881;
  &#273;&#7883;nh nh&#7853;n hàng )</td>
  <td colspan=3 class=xl28 width=307 style='width:231pt'></td>
  <td class=xl28></td>
  <td class=xl29></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl30 height=0 style='display:none;mso-height-source:userset;
  mso-height-alt:255'>
  <td colspan=2 class=xl28 width=242 style='width:182pt'>&#272;&#7883;a
  ch&#7881;</td>
  <td colspan=5 class=xl28 width=543 style='width:408pt'></td>
  <td class=xl30></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  60'>
  <td height=0 colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 width=415 style='width:312pt'></td>
  <td class=xl29></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl30 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl28 width=242 style='height:12.75pt;
  width:182pt' x:str="Bên C ( Bên nh&#7853;n hàng ) ">Bên C ( Bên nh&#7853;n
  hàng )<span style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl28 width=543 style='width:408pt'><%=reciever %></td>
  <td class=xl27></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl31 width=58 style='height:12.75pt;width:44pt'
  x:str="&#272;&#7883;a ch&#7881; ">&#272;&#7883;a ch&#7881;<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl31></td>
  <td colspan=6 class=xl31 width=623 style='width:468pt'><%=reciever_add %></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl31 width=242 style='height:12.75pt;
  width:182pt' x:str="&#272;i&#7879;n tho&#7841;i ">&#272;i&#7879;n
  tho&#7841;i<span style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl31 width=543 style='width:408pt'><%=reciever_tel %><span
  style='mso-spacerun:yes'>                  </span>FAX : <%=reciever_fax %></td>
  <td class=xl27></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=2 height=18 class=xl31 width=242 style='height:13.5pt;width:182pt'>Mã
  s&#7889; thu&#7871;</td>
  <td colspan=6 class=xl31 width=623 style='width:468pt'><%=reciever_tax %></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  15'>
  <td height=0 colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl60></td>
  <td class=xl27></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl30 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=6 height=21 class=xl60 style='height:15.75pt'
  x:str>&#272;&#7891;ng
  ý<span style='mso-spacerun:yes'>  </span>ký k&#7871;t H&#7907;p
  &#273;&#7891;ng S&#7889; : <%=contr_no %> này theo n&#7897;i dung và các
  &#273;i&#7873;u kho&#7843;n sau :<span style='mso-spacerun:yes'> </span></td>
  <td class=xl27></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 colspan=3 style='height:15.0pt;mso-ignore:colspan'>&#272;I&#7872;U
  1<font class="font13">: CH&#7910;NG LO&#7840;I - S&#7888; L&#431;&#7906;NG –
  GIÁ C&#7842;</font></td>
  <td class=xl33><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl33><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td colspan=2 class=xl61><%=tradeterm %></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl29 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl34 style='height:26.25pt;border-top:none'>STT</td>
  <td colspan=3 class=xl62 style='border-left:none'>MÔ T&#7842; HÀNG HÓA</td>
  <td class=xl35 style='border-top:none;border-left:none'>S&#7888;
  L&#431;&#7906;NG </td>
  <td class=xl36 width=108 valign="middle" style='border-top:none;border-left:none;width:81pt'>&#272;&#416;N
  GIÁ<br>
    (<%=curr %>)</td>
  <td class=xl37 width=128 style='border-top:none;border-left:none;width:96pt'>TR&#7882;
  GIÁ<br>
    (<%=curr %>)</td>
  <td class=xl29></td>
 </tr>
 <%
     double qty = 0, amt = 0;
    for(int i=0; i<dt.Rows.Count ; i++)
    {
        qty = qty + Convert.ToDouble(dt.Rows[i][7]);
        amt = amt + Convert.ToDouble(dt.Rows[i][8]);
 %>
 <tr class=xl222 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl64 style='border-bottom:.5pt solid black;
  height:30.0pt' x:num><%=i+1 %></td>
  <td colspan=3 class=xl72 width=408 style='border-right:.5pt solid black;
  width:307pt'><%=dt.Rows[i][0] %></td>
  <td rowspan=2 class=xl80 x:num><%=dt.Rows[i][2] %> &nbsp;<%=dt.Rows[i][1] %></td>
  <td rowspan=2 class=xl78  x:num><%=dt.Rows[i][3] %></td>
  <td rowspan=2 class=xl78 style='border-left:.5pt solid black' x:num><%=dt.Rows[i][4] %></td>
 </tr>
 <tr class=xl222 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl72 style='border-right:.5pt solid black;
  height:15.0pt;border-left:.5pt solid black;border-top:none'> <%=dt.Rows[i][6] %></td>
 </tr> 
 <%} %>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=4 height=17 class=xl84 style='border-right:.5pt solid black;
  height:12.75pt'>T&#7892;NG C&#7896;NG</td>
  <td class=xl38 style='border-left:none' x:num><%=qty %></td>
  <td class=xl39 style='border-left:none'></td>
  <td class=xl38 style='border-left:none' x:num><%=amt %></td>
  <td class=xl26></td>
 </tr>
 <tr class=xl41 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl87 style='height:15.0pt'>&#272;I&#7872;U 2:<font
  class="font13"> &#272;&#7882;A &#272;I&#7874;M GIAO HÀNG: </font><font
  class="font15">(&#273;&#432;&#7907;c phép giao hàng t&#7915;ng ph&#7847;n)</font></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl41 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl42 style='height:12.95pt'
  x:str="Bên B ch&#7881; &#273;&#7883;nh bên A giao hàng cho bên C t&#7841;i &#273;&#7883;a ch&#7881; : ">Bên
  B ch&#7881; &#273;&#7883;nh bên A giao hàng cho bên C t&#7841;i
  &#273;&#7883;a ch&#7881; :<span style='mso-spacerun:yes'> </span></td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl96 style='height:12.95pt'><%=reciever %></td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl96 style='height:12.95pt'><%=reciever_add %></td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl96 style='height:12.95pt'>TEL :
  <%=reciever_tel %><span style='mso-spacerun:yes'>                    </span>FAX
  :<span style='mso-spacerun:yes'>  </span><%=reciever_fax %></td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=8 style='mso-height-source:userset;height:6.0pt'>
  <td colspan=6 height=8 class=xl96 style='height:6.0pt'></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl41 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl97 style='height:15.0pt'><span
  style='mso-spacerun:yes'> </span><font class="font12">&#272;I&#7872;U 3:</font><font
  class="font13"> PH&#431;&#416;NG TH&#7912;C THANH TOÁN :</font></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 rowspan=3 height=54 class=xl95 style='height:40.9pt'>Bên
  B thanh toán cho bên A theo ph&#432;&#417;ng th&#7913;c <%=payment_local%>
  (<%=payment %>) b&#7857;ng &#272;&#7891;ng <%=curr_vn %> thông<span
  style='mso-spacerun:yes'>  </span>qua <%=bank %> <%=bank_add %> , s&#7889; tài
  kho&#7843;n <%=bank_ac %> (<%=curr %>)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl25 style='height:12.95pt'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl59 style='height:15.0pt'></td>
 </tr>
 <tr class=xl41 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 colspan=7 class=xl42 style='height:12.95pt;mso-ignore:colspan'></td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl87 style='height:15.0pt'>&#272;I&#7872;U 4:<font
  class="font13"> TRÁCH NHI&#7878;M C&#7910;A BÊN A :</font></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl95 style='height:12.95pt'>Ch&#7883;u trách
  nhi&#7879;m v&#7873; s&#7889; l&#432;&#7907;ng và ch&#7845;t l&#432;&#7907;ng
  c&#7911;a hàng hoá s&#7843;n xu&#7845;t và &#273;&#7843;m b&#7843;o
  th&#7901;i gian<span style='mso-spacerun:yes'>  </span>giao hàng &#273;úng
  nh&#432; qui &#273;&#7883;nh.</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl41 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl42 style='height:12.95pt'></td>
  <td class=xl41></td>
 </tr>
 <tr class=xl41 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl87 style='height:15.0pt'>&#272;I&#7872;U 5:<font
  class="font13"> TRÁCH NHI&#7878;M C&#7910;A BÊN B :</font></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=6 height=17 class=xl95 style='height:12.95pt'>&#272;&#7843;m
  b&#7843;o thanh toán &#273;úng h&#7841;n theo qui &#273;&#7883;nh t&#7841;i
  &#272;i&#7873;u 3 c&#7911;a h&#7907;p &#273;&#7891;ng.</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl41 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 colspan=6 class=xl42 style='height:12.95pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl41 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl87 style='height:15.0pt'>&#272;I&#7872;U 6:<font
  class="font13"> &#272;I&#7872;U KHO&#7842;N CHUNG :</font></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=6 height=17 class=xl95 style='height:12.95pt'
  x:str="H&#7907;p &#273;&#7891;ng  này có giá tr&#7883; trong vi&#7879;c giao d&#7883;ch gi&#7919;a các bên ">H&#7907;p
  &#273;&#7891;ng<span style='mso-spacerun:yes'>  </span>này có giá tr&#7883;
  trong vi&#7879;c giao d&#7883;ch gi&#7919;a các bên<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl95 style='height:12.95pt'
  x:str="Bên B có trách nhi&#7879;m thông báo cho bên C nh&#7919;ng thông tin c&#7847;n thi&#7871;t và cùng h&#7907;p tác v&#7899;i bên A hoàn thành &#273;&#7847;y &#273;&#7911; các th&#7911; t&#7909;c cho vi&#7879;c giao ">Bên
  B có trách nhi&#7879;m thông báo cho bên C nh&#7919;ng thông tin c&#7847;n
  thi&#7871;t và cùng h&#7907;p tác v&#7899;i bên A hoàn thành &#273;&#7847;y
  &#273;&#7911; các th&#7911; t&#7909;c cho vi&#7879;c giao<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl95 style='height:12.95pt'
  x:str="nh&#7853;n hàng hóa. T&#7845;t c&#7843; nh&#7919;ng v&#7845;n &#273;&#7873; phát sinh trong quá trình th&#7921;c hi&#7879;n h&#7907;p &#273;&#7891;ng  s&#7869; &#273;&#432;&#7907;c gi&#7843;i quy&#7871;t d&#7921;a trên l&#7907;i ích c&#7911;a các bên tham gia.   ">nh&#7853;n
  hàng hóa. T&#7845;t c&#7843; nh&#7919;ng v&#7845;n &#273;&#7873; phát sinh
  trong quá trình th&#7921;c hi&#7879;n h&#7907;p &#273;&#7891;ng<span
  style='mso-spacerun:yes'>  </span>s&#7869; &#273;&#432;&#7907;c gi&#7843;i
  quy&#7871;t d&#7921;a trên l&#7907;i ích c&#7911;a các bên tham gia.<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl95 style='height:12.95pt'>M&#7885;i s&#7921;
  s&#7917;a &#273;&#7893;i, b&#7893; sung các &#273;i&#7873;u kho&#7843;n
  c&#7911;a h&#7907;p &#273;&#7891;ng<span style='mso-spacerun:yes'> 
  </span>này ph&#7843;i &#273;&#432;&#7907;c l&#7853;p thành v&#259;n b&#7843;n
  và ph&#7843;i có s&#7921; xác nh&#7853;n &#273;&#7891;ng ý gi&#7919;a các
  bên.</td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=7 height=17 class=xl43 style='height:12.95pt'>H&#7907;p
  &#273;&#7891;ng này<span style='mso-spacerun:yes'>  </span>này có giá
  tr&#7883; k&#7875; t&#7915; ngày ký<span style='mso-spacerun:yes'> 
  </span>&#273;&#7871;n ngày <%=exp_date %></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=9 style='mso-height-source:userset;height:6.75pt'>
  <td height=9 colspan=7 class=xl43 style='height:6.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=2 height=41 class=xl98 width=242 style='height:30.75pt;
  width:182pt'><%=seller %></td>
  <td colspan=3 class=xl98 width=307 style='width:231pt'><%=buyer_name %></td>
  <td colspan=2 class=xl98 width=236 style='width:177pt'><%=reciever %></td>
  <td class=xl26></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=7 class=xl44 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=58 style='width:44pt'></td>
  <td width=184 style='width:138pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=80 style='width:60pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
