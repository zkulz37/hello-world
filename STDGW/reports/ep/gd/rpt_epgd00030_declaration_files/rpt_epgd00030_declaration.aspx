<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("imex");%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string SQL, company = "", company_pk = "", pk = "";
    string com_name = "", com_add = "", com_tax = "", com_tel="", com_fax="";
    string partner1 = "", partner_add1 = "", tax1="", partner2 = "", partner_add2 = "", tax2="";
    string partner3 = "", partner_add3 = "", partner4 = "", partner_add4 = "", sogpxuat = "", ngaygpxuat = "";
    string sohdgxuat = "", ngayhdgxuat = "", ngayhhxuat = "",sogpnhap = "", ngaygpnhap = "", diadiemgiaohang = "";
    string sodh12 = "", ngaydh12 = "", ngayhdgnhap = "", sohdgnhap="",ngayhhnhap = "",hdtm = "", ngayhdtm = "";
    string phuongthucthanhtoan = "", curr = "", tigia = "", decl_no = "", decl_dt = "", annex="", im_country="";
    string exp_gate = "", trade_term="", st="", customs="", chicuchq="";
    
    pk = Request.QueryString["pk"];
    company_pk = Request.QueryString["company_pk"];

    SQL = " select  a.partner_name, a.addr1, a.tax_code, a.phone_no,a.fax_no  " +
        " from    tco_company a   " +
        " where pk='" + company_pk + "' ";
    System.Data.DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        com_name = (string)dt.Rows[0][0].ToString();
        com_add = (string)dt.Rows[0][1].ToString();
        com_tax = (string)dt.Rows[0][2].ToString();
        com_tel = (string)dt.Rows[0][3].ToString();
        com_fax = (string)dt.Rows[0][4].ToString();
    }

    SQL = " select  nvl(com.partner_name,exp.partner_name) partner1 " +
        "        , nvl(com.addr1,exp.addr1) partner_add1,  nvl(exp.tax_code,exp.tax_code) tax1 " +
        "        , imp.partner_name partner2, imp.tax_code tax1 " +
        "        , imp.addr1 partner_add2 " +
        "        , cons.partner_name partner3 " +
        "        , cons.addr1 partner_add3 " +
        "        , forw.partner_name partner4 " +
        "        , forw.addr1 partner_add4  " +
        "        , license ex_license, to_char(to_date(license_date,'yyyymmdd'),'dd/mm/yyyy') ex_license_date  " +
        "        , to_char(to_date(license_expdate,'yyyymmdd'),'dd/mm/yyyy') ex_license_expdate  " +
        "        , nvl(a.contr_no,ctr.contr_no) ex_contr_no " +
        "        , to_char(to_date(nvl(a.contr_date, ctr.contr_date),'yyyymmdd'),'dd-Mon-yy') ex_contr_date  " +
        "        , to_char(to_date(nvl(a.contr_exp_date,ctr.exp_date),'yyyymmdd'),'dd/mm/yy') exp_date_ex_ctr  " +
        "        , '' im_contr_no, '' im_contr_date, '' exp_date_im_ctr   " +
        "        , '' im_license, '' im_license_date, '' im_license_expdate           " +
        "        , '' diadiemgiaohang, '' sohoadon12, '' ngayhoadon12  " +
        "        , '' ngayhdnhap, '' sohdnhap , '' ngayhhhdgnhap  " +
        "        , nvl(a.invoice_no,cinv.co_invoice_no) invoice_no " +
        "        , to_char(to_date(nvl(a.invoice_date,cinv.co_invoice_date),'yyyymmdd'),'dd/mm/yy') cnv_date  " +
        "        , pay.code_nm payment_method, a.tr_ccy, a.ex_rate  " +
        "        , a.decl_no, to_char(to_date(a.decl_date,'yyyymmdd'),'dd/mm/yyyy') decl_date, a.annex " +
        "        , v.country_nm , exp_gate.port_nm exp_gate, a.trade_terms , cus.partner_name customs" +
        "    from  tex_decl_mst a, tco_buspartner cus  " +
        "            , tco_buspartner exp, tco_buspartner imp  " +
        "            , tco_buspartner cons, tco_buspartner forw  " +
        "            , tex_cinv_mst_a  cinv, tco_company com  " +
        "            , tex_contr_mst ctr, tie_country v, tie_port exp_gate  " +
        "            , (select a.code,  a.code_nm from tco_abcode a, tco_abcodegrp b     " +
        "              where tco_abcodegrp_pk=b.pk and b.id='ACCR0140'     " +
        "                  and a.del_if=0 and b.del_if=0 order by a.CODE) pay  " +
        "    where a.del_if = 0 and cus.del_if(+)=0   " +
        "         and  cons.del_if(+)=0 and forw.del_if(+)=0  " +
        "         and a.tco_buspartner_pk = cus.pk(+)  " +
        "         and a.tco_buspartner_pk1 = exp.pk(+)  " +
        "         and a.tco_buspartner_pk1 = com.pk(+)  " +
        "         and a.tco_buspartner_pk2 = imp.pk(+)  " +
        "         and a.tco_buspartner_pk3 = cons.pk(+)  " +
        "         and a.tco_buspartner_pk4 = forw.pk(+)  " +
        "         and a.tex_cinv_mst_a_pk = cinv.pk(+)  " +
        "         and upper(a.im_port_country) = upper(v.country_cd2(+)) " +
        "         and cinv.contract_pk = ctr.pk(+)  " +
        "         and upper(cinv.pay_meth) = upper(pay.code(+))  " +
        "         and a.export_gate = exp_gate.pk(+)  " +
        "         and a.pk='" + pk + "' ";
    dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        partner1 = (string) dt.Rows[0][0].ToString() ; 
        partner_add1 = (string) dt.Rows[0][1].ToString() ;
        tax1 = (string)dt.Rows[0][2].ToString();
        partner2 = (string) dt.Rows[0][3].ToString() ; 
        partner_add2 = (string) dt.Rows[0][5].ToString() ;
        tax2 = (string)dt.Rows[0][4].ToString();
        partner3 = (string) dt.Rows[0][6].ToString() ; 
        partner_add3 = (string) dt.Rows[0][7].ToString() ;
        partner4 = (string) dt.Rows[0][8].ToString() ; 
        partner_add4 = (string) dt.Rows[0][9].ToString() ; 
        sogpxuat = (string) dt.Rows[0][10].ToString() ; 
        ngaygpxuat = (string) dt.Rows[0][11].ToString() ; 
        sohdgxuat = (string) dt.Rows[0][13].ToString() ; 
        ngayhdgxuat = (string) dt.Rows[0][14].ToString() ; 
        ngayhhxuat = (string) dt.Rows[0][15].ToString() ;
        sogpnhap = (string) dt.Rows[0][19].ToString() ; 
        ngaygpnhap = (string) dt.Rows[0][20].ToString() ; 
        diadiemgiaohang = (string) dt.Rows[0][22].ToString() ; 
        sodh12 = (string) dt.Rows[0][23].ToString() ; 
        ngaydh12 = (string) dt.Rows[0][24].ToString() ; 
        ngayhdgnhap = (string) dt.Rows[0][25].ToString() ;
        sohdgnhap = (string)dt.Rows[0][26].ToString();
        ngayhhnhap = (string) dt.Rows[0][27].ToString() ;
        hdtm = (string) dt.Rows[0][28].ToString() ; 
        ngayhdtm = (string) dt.Rows[0][29].ToString() ; 
        phuongthucthanhtoan = (string) dt.Rows[0][30].ToString() ; 
        curr = (string) dt.Rows[0][31].ToString() ; 
        tigia = (string) dt.Rows[0][32].ToString() ;
        decl_no = (string)dt.Rows[0][33].ToString();
        decl_dt = (string)dt.Rows[0][34].ToString();
        annex = (string)dt.Rows[0][35].ToString();
        im_country = (string)dt.Rows[0][36].ToString();
        exp_gate = (string)dt.Rows[0][37].ToString();
        trade_term = (string)dt.Rows[0][38].ToString();
        customs = (string)dt.Rows[0][39].ToString();
    }
    SQL = " select v5.GRP_LNM ,v5.grp_nm, v5.grp_cd, v.item_name, v4.hs_code, v2.country_nm  " +
        "     , comm.sf_get_item_attribute(a.tco_item_pk ) item_attribute      " +
        "     , to_char(a.qty,'999,999,999') qty, v3.uom_nm      " +
        "     , decode(v1.tr_ccy,'VND',to_char(a.u_price,'999,999,999,999'),to_char(a.u_price,'999,999,999,990.99')) u_price      " +
        "     , decode(v1.tr_ccy,'VND',to_char(a.ext_price ,'999,999,999,999'),to_char(a.ext_price ,'999,999,999,990.99')) ext_amt " +
        "     , nvl(v.trans_fee_yn,'N'), a.pk  , decode(nvl(v3.cnv_ratio,1),1,'',to_char(v3.cnv_ratio,'9,999,999')) || v3.uom_nm unit_cd  " +
        "     , a.unit_packing, nvl(a.qty_packing,0), a.unit_weight, nvl(a.net_weight,0), nvl(a.gross_weight,0), v.item_code " +
        "     , max(v7.consp_slip_no) slip_no, max(v7.consp_reg_date) consp_date     " +
        " from tex_decl_dtl a, tco_item v, tex_decl_mst v1    " +
        "       , tie_country v2, comm.tco_uom v3  " +
        "       , tco_hscode v4, tco_itemgrp v5  " +
        "       , tie_consp_dtlm v6, tie_consp_mst v7  " +
        " where a.del_if = 0    " +
        "        and  a.tco_item_pk = v.pk   " +
        "        and  a.tex_decl_mst_pk=v1.pk      " +
        "        and  upper(a.item_origin) = upper(v2.country_cd2(+))   " +
        "        and  upper(a.unit_cd) = upper(v3.uom_code(+))   " +
        "        and  v.tco_hscode_pk = v4.pk(+)    " +
        "        and  v.tco_itemgrp_pk = v5.pk  " +
        "        and  a.tco_item_pk = v6.tco_item_ex_pk(+) " +
        "        and  v6.tie_consp_mst_pk = v7.pk(+) " +
        "        and  a.tex_decl_mst_pk='" + pk + "' " +
        " group by  v5.GRP_LNM ,v5.grp_nm, v5.grp_cd, v.item_name, v4.hs_code, v2.country_nm    " +
        "        , a.tco_item_pk, a.qty, v3.uom_nm, v1.tr_ccy, a.u_price, a.ext_price " +
        "        , v.trans_fee_yn, a.pk, v3.cnv_ratio, a.unit_packing, a.qty_packing " +
        "        , a.unit_weight, a.net_weight, a.gross_weight, v.item_code        " +
        " order by  v.trans_fee_yn, a.pk ";

    dt = ESysLib.TableReadOpen(SQL);

    SQL = "select   to_char(sum(nvl(a.qty,0)),'999,999.99') qty, v3.uom_nm  " +
       "        , to_char(sum(nvl(a.qty_packing,0)),'999,999.99') qty_packing, a.unit_packing  " +
       "        , a.unit_weight, to_char(sum(nvl(a.net_weight,0)),'999,999.99') net_wt   " +
       "        , to_char(sum(nvl(a.gross_weight,0)),'999,999.99') gross_wt          " +
       " from tex_decl_dtl a, tco_item v, tex_decl_mst v1    " +
       "       , tie_country v2, comm.tco_uom v3  " +
       "       , tco_hscode v4, tco_itemgrp v5  " +
       " where a.del_if = 0    " +
       "        and  a.tco_item_pk = v.pk   " +
       "        and  a.tex_decl_mst_pk=v1.pk      " +
       "        and  upper(a.item_origin) = upper(v2.country_cd2(+))   " +
       "        and  upper(a.unit_cd) = upper(v3.uom_code(+))   " +
       "        and  v.tco_hscode_pk = v4.pk(+)    " +
       "        and  v.tco_itemgrp_pk = v5.pk  " +
       "        and  nvl(v.trans_fee_yn,'N') = 'N'  " +
       "        and  a.tex_decl_mst_pk='" + pk + "'" +
       " group by  v3.uom_nm,  a.unit_packing, a.unit_weight, v.trans_fee_yn   ";

    DataTable dtSum = ESysLib.TableReadOpen(SQL);  
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link id=Main-File rel=Main-File href="../rpt_epgd00030_declaration.htm">
<link rel=File-List href=filelist.xml>
<link rel=Edit-Time-Data href=editdata.mso>
<link rel=Stylesheet href=stylesheet.css>
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in .27in .37in .37in;
	mso-header-margin:.32in;
	mso-footer-margin:.23in;}
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
 window.location.replace("../rpt_epgd00030_declaration.htm");
else
 fnUpdateTabs();
//-->
</script>
<![endif]><!--[if gte mso 9]><xml>
 <x:WorksheetOptions>
  <x:DefaultRowHeight>240</x:DefaultRowHeight>
  <x:Print>
   <x:ValidPrinterInfo/>
   <x:Scale>97</x:Scale>
   <x:HorizontalResolution>600</x:HorizontalResolution>
   <x:VerticalResolution>600</x:VerticalResolution>
  </x:Print>
  <x:PageBreakZoom>75</x:PageBreakZoom>
  <x:Selected/>
  <x:TopRowVisible>9</x:TopRowVisible>
  <x:Panes>
   <x:Pane>
    <x:Number>3</x:Number>
    <x:ActiveRow>27</x:ActiveRow>
    <x:ActiveCol>3</x:ActiveCol>
   </x:Pane>
  </x:Panes>
  <x:ProtectContents>False</x:ProtectContents>
  <x:ProtectObjects>False</x:ProtectObjects>
  <x:ProtectScenarios>False</x:ProtectScenarios>
 </x:WorksheetOptions>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl44>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1018 style='border-collapse:
 collapse;table-layout:fixed;width:764pt'>
 <col class=xl44 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl44 width=229 style='mso-width-source:userset;mso-width-alt:8374;
 width:172pt'>
 <col class=xl44 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl44 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl44 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl44 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl44 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl44 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl44 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl44 width=64 style='width:48pt'>
 <col class=xl44 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl44 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl44 width=64 span=3 style='width:48pt'>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl39 width=44 style='height:21.75pt;width:33pt'><a
  name="Print_Area">&nbsp;</a></td>
  <td class=xl40 width=229 style='border-left:none;width:172pt'>&nbsp;</td>
  <td class=xl39 width=39 style='width:29pt'>&nbsp;</td>
  <td class=xl41 width=111 style='border-left:none;width:83pt'>&nbsp;</td>
  <td class=xl42 width=72 style='border-left:none;width:54pt'><span
  style='mso-spacerun:yes'>  </span><%=decl_no %><span style='mso-spacerun:yes'>   
  </span><span style='display:none'>XSX<span style='mso-spacerun:yes'>   
  </span>LT 02</span></td>
  <td class=xl43 width=46 style='border-left:none;width:35pt'>&nbsp;</td>
  <td class=xl39 width=38 style='width:29pt'>&nbsp;</td>
  <td class=xl41 width=16 style='border-left:none;width:12pt'>&nbsp;</td>
  <td class=xl41 width=55 style='border-left:none;width:41pt'>&nbsp;</td>
  <td class=xl41 width=64 style='border-left:none;width:48pt'>&nbsp;</td>
  <td class=xl43 width=73 style='border-left:none;width:55pt'>&nbsp;</td>
  <td class=xl44 width=39 style='width:29pt'></td>
  <td class=xl44 width=64 style='width:48pt'></td>
  <td class=xl44 width=64 style='width:48pt'></td>
  <td class=xl44 width=64 style='width:48pt'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl45 style='height:17.25pt;border-top:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'><%=customs %></td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl47 style='border-right:.5pt solid white;border-left:
  none'><%=decl_dt %></td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl45 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'><%=chicuchq %></td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'><u style='visibility:
  hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num>0</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl45 style='height:9.0pt;border-top:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-left:none'><%=annex %></td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl54 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl57 style='height:12.75pt'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl39 style='height:14.25pt'>&nbsp;</td>
  <td class=xl60 style='border-left:none'
  x:str="                                  3    6    0    0    7     9    0     1     5      4     "><span
  style='mso-spacerun:yes'>                                  </span>3<span
  style='mso-spacerun:yes'>    </span>6<span style='mso-spacerun:yes'>   
  </span>0<span style='mso-spacerun:yes'>    </span>0<span
  style='mso-spacerun:yes'>    </span>7<span style='mso-spacerun:yes'>    
  </span>9<span style='mso-spacerun:yes'>    </span>0<span
  style='mso-spacerun:yes'>   </span><span style='display:none'><span
  style='mso-spacerun:yes'>  </span>1<span style='mso-spacerun:yes'>    
  </span>5<span style='mso-spacerun:yes'>      </span>4<span
  style='mso-spacerun:yes'>     </span></span></td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl61 style='height:20.25pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl62 width=379 style='border-left:none;width:284pt'><%=com_name %></td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl64 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl65><%=sogpxuat %></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl45 style='height:14.25pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl68 style='border-left:none'><%=com_add %></td>
  <td rowspan=2 class=xl70 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl71><%=ngaygpxuat %></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl54 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none;border-left:none'>ĐT:<span
  style='mso-spacerun:yes'>  </span><%=com_tel %><span
  style='mso-spacerun:yes'>      </span>FAX:<span style='mso-spacerun:yes'> 
  </span><%=com_fax %></td>
  <td class=xl74 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl39 style='height:16.5pt'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl61 style='height:14.25pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl77 style='border-left:none'><%=partner2 %></td>
  <td colspan=4 class=xl79><%=sohdgxuat %></td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none;border-left:none'><%=im_country%></td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl45 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl82 width=379 style='width:284pt'><%=partner_add2 %></td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl84 style='border-left:none'><%=ngayhdgxuat %></td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td rowspan=2 class=xl86></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl54 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl39 style='height:16.5pt'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl91 style='height:14.25pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl92><%=partner3 %></td>
  <td colspan=3 class=xl33><%=exp_gate %></td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl45 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 rowspan=3 class=xl93 width=379 style='width:284pt'><%=partner_add3 %></td>
  <td colspan=2 class=xl95>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl96 style='border-left:none'><%=trade_term %></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl45 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl54 style='height:10.5pt;border-top:none'>&nbsp;</td>
  <td class=xl100 style='border-top:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl101 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl39 style='height:12.0pt'>&nbsp;</td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-left:none'>&nbsp;</td>
  <td class=xl104 style='border-left:none'>&nbsp;</td>
  <td class=xl105>&nbsp;</td>
  <td class=xl106><% st = curr.Length > 0 ? curr.Substring(0, 1) : "";%><%=st %></td>
  <td class=xl107 style='border-left:none'><% st = curr.Length > 1 ? curr.Substring(1, 1) : "";%><%=st %></td>
  <td class=xl59 style='border-left:none'><% st = curr.Length > 2 ? curr.Substring(2, 1) : "";%><%=st %></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl108 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl109 style='border-left:none'><%=partner4 %></td>
  <td class=xl111 style='border-top:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl45 style='height:14.25pt;border-top:none'>&nbsp;</td>
  <td colspan=3 rowspan=4 class=xl112><%=partner_add4 %></td>
  <td class=xl111 style='border-top:none'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl114 x:str><span
  style='mso-spacerun:yes'> </span><%=tigia %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl116><%=phuongthucthanhtoan %></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl45 style='height:5.25pt;border-top:none'>&nbsp;</td>
  <td class=xl111 style='border-top:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl45 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl111 style='border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl54 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl119 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
  <td class=xl56 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl55 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl57 style='height:30.0pt'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl58 style='border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     if (dt.Rows.Count > 0)
     {
 %>
 <tr height=23 style='mso-height-source:userset;height:17.65pt'>
  <td height=23 class=xl44 style='height:17.65pt'></td>
  <td class=xl44><%=dt.Rows[0][0] %></td>
  <td colspan=5 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl57>&nbsp;</td>
  <td class=xl59 style='border-left:none'>&nbsp;</td>
  <td colspan=6 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl120 height=23 style='mso-height-source:userset;height:17.65pt'>
  <td height=23 class=xl120 style='height:17.65pt'></td>
  <td colspan=2 class=xl121 width=268 style='width:201pt' x:str><%=dt.Rows[0][1] %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl122></td>
  <td class=xl123></td>
  <td colspan=2 class=xl124></td>
  <td class=xl125>&nbsp;</td>
  <td class=xl126 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl127></td>
  <td colspan=4 class=xl120 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl128 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl128 style='height:25.5pt'></td>
  <td colspan=2 class=xl129 width=268 style='width:201pt'><%=dt.Rows[0][6] %></td>
  <td class=xl130><%=dt.Rows[0][4] %></td>
  <td class=xl131><%=dt.Rows[0][7] %></td>
  <td colspan=2 class=xl132><%=dt.Rows[0][8] %></td>
  <td class=xl134>&nbsp;</td>
  <td class=xl135 style='border-left:none' x:str><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[0][9] %><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl136 x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[0][10] %><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl128 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl44 style='height:25.5pt'></td>
  <td colspan=2 class=xl35 width=268 style='width:201pt'>Mã hàng: <%=dt.Rows[0][19] %></td>
  <td class=xl137></td>
  <td class=xl138 colspan=2 style='mso-ignore:colspan'>( <%=dt.Rows[0][17] %><span
  style='mso-spacerun:yes'>  </span><%=dt.Rows[0][16] %>)</td>
  <td class=xl140></td>
  <td class=xl141>&nbsp;</td>
  <td class=xl142 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl143></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl44 style='height:25.5pt'></td>
  <td colspan=2 class=xl36 width=268 style='width:201pt'>&#272;&#7883;nh
  m&#7913;c s&#7889;: <%=dt.Rows[0][20] %></td>
  <td class=xl144></td>
  <td class=xl137></td>
  <td colspan=2 class=xl145>&nbsp;</td>
  <td class=xl141>&nbsp;</td>
  <td class=xl142 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl147></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl44 style='height:25.5pt'></td>
  <td class=xl148 width=229 style='width:172pt'>Ngày định mức&nbsp;: <%=dt.Rows[0][21] %></td>
  <td class=xl149 width=39 style='border-left:none;width:29pt'>&nbsp;</td>
  <td class=xl150></td>
  <td class=xl151></td>
  <td class=xl145>&nbsp;</td>
  <td class=xl152 style='border-left:none'>&nbsp;</td>
  <td class=xl141>&nbsp;</td>
  <td class=xl142 style='border-left:none'>&nbsp;</td>
  <td class=xl153>&nbsp;</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl44 style='height:25.5pt'></td>
  <td class=xl155 width=229 style='width:172pt'>&nbsp;</td>
  <td class=xl149 width=39 style='border-left:none;width:29pt'>&nbsp;</td>
  <td class=xl150></td>
  <td class=xl151></td>
  <td class=xl145>&nbsp;</td>
  <td class=xl146 style='border-left:none'>&nbsp;</td>
  <td class=xl141>&nbsp;</td>
  <td class=xl142 style='border-left:none'>&nbsp;</td>
  <td class=xl153>&nbsp;</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=100 style='mso-height-source:userset;height:75.0pt'>
  <td height=100 class=xl44 style='height:75.0pt'></td>
  <td class=xl148 width=229 style='width:172pt'>&nbsp;</td>
  <td class=xl156 width=39 style='border-left:none;width:29pt'>&nbsp;</td>
  <td colspan=2 class=xl137 style='mso-ignore:colspan'></td>
  <td class=xl145>&nbsp;</td>
  <td class=xl146 style='border-left:none'>&nbsp;</td>
  <td class=xl141>&nbsp;</td>
  <td class=xl142 style='border-left:none'>&nbsp;</td>
  <td class=xl153>&nbsp;</td>
  <td class=xl154 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <%
     if (dtSum.Rows.Count > 0)
     {
  %>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl44 style='height:22.5pt'></td>
  <td class=xl31 colspan=5 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>T&#7893;ng c&#7897;ng: <%=dtSum.Rows[0][2] %><span style='mso-spacerun:yes'>  </span><%=dtSum.Rows[0][3] %> =
  <%=dtSum.Rows[0][6] %> <%=dtSum.Rows[0][4] %> (G.W)</td>
  <td colspan=2 class=xl32></td>
  <td class=xl59>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl28 style='border-left:none' x:num="0" x:fmla="=SUM(J29:K34)"><span
  style='mso-spacerun:yes'>                  </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl39 style='height:12.0pt'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl45 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl45 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl45 style='height:16.5pt;border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl45 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl45 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl159 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=44 style='width:33pt'></td>
  <td width=229 style='width:172pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
