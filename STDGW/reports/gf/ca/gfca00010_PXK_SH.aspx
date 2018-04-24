<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("acnt");%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string SQL = "", ls_tac_hgtrh_pk = "", ls_tac_crca_pk = "", lcompany_pk = "";	
    	ls_tac_hgtrh_pk = Request["tac_hgtrh_pk"];
    	lcompany_pk = Request["company_pk"];
    	ls_tac_crca_pk = Request["tac_crca_pk"];
	SQL
	= "select substr(a.tr_date, 4, 1) yyyy, substr(a.tr_date, 5, 2) mm, substr(a.tr_date, 7, 2) dd,  " + 
        "				 c.partner_name, nvl(c.addr1, '') || nvl(c.addr2, ' ') || nvl(c.addr3, ' ') address, " +
        "				 (        select c.item_lnm " +
        "          from tac_crcaditem b, tac_abitem c " +
        "         where b.del_if       = 0 " +
        "           and c.del_if       = 0 " +
        "           and b.tac_crca_pk  = '" + ls_tac_crca_pk + "' " +
        "           and b.tac_abitem_pk = c.pk " +
        "	    and c.item_nm = 'PAYMENT METHOD' ) pay_method, " +
        "				c.tax_code, decode(a.vat_rate, '01', 'None', '00', 'None', a.vat_rate) vat_rate,  " +
        "				a.tot_net_tr_amt, a.tot_vat_tr_amt, nvl(a.tot_net_tr_amt, 0) + nvl(a.tot_vat_tr_amt, 0) tot_inc_vattax, a.invoice_no, " +
        "				 (        select c.item_lnm " +
        "          from tac_crcaditem b, tac_abitem c " +
        "         where b.del_if       = 0 " +
        "           and c.del_if       = 0 " +
        "           and b.tac_crca_pk  = '" + ls_tac_crca_pk + "' " +
        "           and b.tac_abitem_pk = c.pk " +
        "	    and c.item_nm = 'CONTRACT NOAR' ) contract_no " +
        "from tac_crca a, comm.tco_buspartner c " +
        "where a.del_if = 0 " +
        "and c.del_if(+) = 0 " +
        "and a.tco_buspartner_pk = c.pk(+) " +
        "and a.pk = '" + ls_tac_crca_pk + "' " ;

    DataTable dtMst = new DataTable ();
    dtMst = ESysLib.TableReadOpen(SQL); 
	SQL = 
	" select ITEM_DESC, uom, qty, u_price, net_tr_amt, " +	
	"			 item_code, case when sizea = '100' then '#00' when sizea = '101' then '#0E' when sizea = '110' then '#0' " +
	"			 when sizea = '111' then '#1' when sizea = '112' then '#2' when sizea = '113' then '#3' " +
	"			 when sizea = '114' then '#4' when sizea = '115' then '#00E' end sizea, " +
	"			 CAP_COLOR, BODY_COLOR " +	
	 "from ( select d.ITEM_DESC, i.uom, round(sum(d.qty), 3) qty, round(d.u_price, 2) u_price, round(sum(d.net_tr_amt), 2) net_tr_amt, " + 
		" i.item_code, mafg.sf_get_size(s1.matno) sizea, sf_get_colornm_ar(s1.CAP_COLOR) CAP_COLOR, " +
		" sf_get_colornm_ar(s1.BODY_COLOR) BODY_COLOR " +
        "from tac_crcad d, comm.tco_item i , sale.s_rqst_d s, sale.s_rqst s1 " +
        "where d.del_if = 0 " +
        "and i.del_if(+) = 0 " +
        "and d.tco_item_pk = i.pk(+) " +
		" and s.RQST_NO = s1.RQST_NO(+) " +
	    " and i.item_code = s.matno(+) || '-2'  " +		
        "and d.tac_crca_pk = '" + ls_tac_crca_pk + "' " +
       " group by d.ITEM_DESC, i.uom, d.u_price, i.item_code, mafg.sf_get_size(s1.matno), i.item_code, " +
		" sf_get_colornm_ar(s1.CAP_COLOR), sf_get_colornm_ar(s1.BODY_COLOR) "  +
		" ) " ;
    DataTable dtDetail = new DataTable() ;
    dtDetail = ESysLib.TableReadOpen(SQL) ;	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Phieu%20xuat%20kho%20Domestic_files/filelist.xml">
<link rel=Edit-Time-Data href="Phieu%20xuat%20kho%20Domestic_files/editdata.mso">
<link rel=OLE-Object-Data href="Phieu%20xuat%20kho%20Domestic_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>shvtn04</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2009-09-04T04:30:20Z</o:LastPrinted>
  <o:Created>2009-04-07T08:26:17Z</o:Created>
  <o:LastSaved>2009-09-07T05:51:22Z</o:LastSaved>
  <o:Company>admin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in .12in 1.0in .35in;
	mso-header-margin:.17in;
	mso-footer-margin:.5in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";}
.xl25
	{mso-style-parent:style0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl27
	{mso-style-parent:style0;
	vertical-align:top;}
.xl28
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:top;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:top;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:top;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet 1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=758 style='border-collapse:
 collapse;table-layout:fixed;width:570pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=64 style='width:48pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=64 style='width:48pt'>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 width=42 style='height:21.75pt;width:32pt'></td>
  <td class=xl26 colspan=2 width=174 style='mso-ignore:colspan;width:131pt'>Cty
  TNHH Suheung Việt Nam</td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 style='height:6.0pt'></td>
  <td colspan=2 rowspan=2 class=xl34><span style='mso-spacerun:yes'>     
  </span>KCN Long Thành, Đồng Nai</td>
  <td class=xl26></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt'></td>
  <td colspan=4 style='mso-ignore:colspan'><span style='mso-spacerun:yes'>   
  </span><%=dtMst.Rows[0][2]%><span style='mso-spacerun:yes'>             </span><%=dtMst.Rows[0][1]%><span
  style='mso-spacerun:yes'>                             </span><%=dtMst.Rows[0][0]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'><span style='mso-spacerun:yes'>    
  </span>32/2009-BNĐ</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <%
	string ls_sale_to = "";
	ls_sale_to = "Xuất bán cho " + dtMst.Rows[0][3].ToString() ;
 %>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>          </span><%=ls_sale_to%><span style='mso-spacerun:yes'>                        </span>HĐTC
  00133774</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'>nhà máy cty Suheung VN</td>
  <td colspan=4 class=xl33><span style='mso-spacerun:yes'>   </span>KCN Long
  Thành, Đồng Nai</td>
  <td></td>
 </tr>
 <tr height=68 style='height:51.0pt;mso-xlrowspan:4'>
  <td height=68 colspan=11 style='height:51.0pt;mso-ignore:colspan'></td>
 </tr>
 <% 
	int i;
	string ls_size = "";
	for( i = 0 ; i < dtDetail.Rows.Count; i++)
	{
		ls_size = "Size " + dtDetail.Rows[i][6].ToString() + " - " + dtDetail.Rows[i][7].ToString() + " / " + dtDetail.Rows[i][8].ToString();
 %>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl25 style='height:25.5pt'></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'
  x:str><span style='mso-spacerun:yes'> 
  </span><%=ls_size%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl27 x:str><%=dtDetail.Rows[i][5]%></td>
  <td class=xl32 width=58 style='width:44pt'><%=dtDetail.Rows[i][1]%><br></td>
  <td class=xl28 x:num><%=dtDetail.Rows[i][2]%></td>
  <td class=xl28 x:num ><%=dtDetail.Rows[i][2]%></td>
  <td class=xl29>XXXX</td>
  <td class=xl29>XXXX</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <%
	}
	if(dtDetail.Rows.Count < 5 )
	{
		for(i = dtDetail.Rows.Count; i < 5 ; i++)
		{
 %>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl25 style='height:25.5pt'></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'
  x:str><span style='mso-spacerun:yes'> 
  </span><span style='mso-spacerun:yes'> </span></td>
  <td class=xl27 x:str></td>
  <td class=xl32 width=58 style='width:44pt'><br></td>
  <td class=xl28 x:num></td>
  <td class=xl28 x:num ></td>
  <td class=xl29></td>
  <td class=xl29></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>	
<% 
		}
	}
%>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=4 class=xl31></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=4 class=xl31>Theo<span style='mso-spacerun:yes'>  
  </span>Hđồng<span style='mso-spacerun:yes'>  </span><%=dtMst.Rows[0][11]%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=4 class=xl31></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan' x:fmla="=D3"><span
  style='mso-spacerun:yes'>    </span>19<span
  style='mso-spacerun:yes'>             </span>6<span
  style='mso-spacerun:yes'>                             </span>9</td>
 </tr>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=11 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=11 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=42 style='width:32pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
