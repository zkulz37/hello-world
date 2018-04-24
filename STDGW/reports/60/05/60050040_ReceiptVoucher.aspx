<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_seq = ""+ Request["seq"];
	string p_table_pk = ""+ Request["pv_pk"];
    string p_company_pk = "";
    string p_cmp_name = "";
	string p_cmp_add = "";	
	string p_cmp_taxcode = ""; 	
    string p_voucher_no =""; 
    string p_ngay =""; 
    string p_thang =""; 
    string p_nam =""; 
    string p_person =""; 
    string p_addr =""; 
    string p_remark =""; 
    string p_remark2 =""; 
    string p_reason ="";
    string p_buspartner_lnm = "";
    string p_enclose = ""; 
	string SQL = "";
    string p_ccy = "";
    string p_amount = "";
    string p_fmt_amount = ""; 
	string p_rate = "";
	string p_amt_vn = "";
	string p_book_ccy = "";
    string p_voucher_code = "";
    String p_voucher_name = "PHIẾU THU";
	string tmp1 ="";
	string tmp2 ="";
	string tmp3 ="";
	int i =0;
	
	SQL = "SELECT CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y'";
	DataTable dt0 = ESysLib.TableReadOpen(SQL);
	if (dt0.Rows.Count >0)
    {
		p_book_ccy = dt0.Rows[0][0].ToString();
	}
	
	SQL = "SELECT a.tr_person,a.voucherno,a.tr_enclose, ";
	SQL +=  "       tr_person, (SELECT addr1 ";
	SQL +=  "                     FROM tco_buspartner c ";
	SQL +=  "                    WHERE c.pk = a.tco_buspartner_pk) addr, a.buspartner_lnm ";
	SQL +=  " FROM tac_bprvpv a, tac_hgtrh b WHERE b.tr_table_pk = a.pk AND b.tr_tablenm = 'TAC_BPRVPV' AND b.pk = "+ l_seq;
	dt0 = ESysLib.TableReadOpen(SQL);
	if (dt0.Rows.Count >0)
    {
		p_person  = dt0.Rows[0][0].ToString();
		p_enclose = dt0.Rows[0][2].ToString();
		p_reason  = dt0.Rows[0][3].ToString(); 
		p_addr = dt0.Rows[0][4].ToString();
		p_buspartner_lnm = dt0.Rows[0][5].ToString();
	}
	
	SQL = " SELECT v.tco_company_pk, v.voucherno, TO_CHAR(v.tr_date,'DD') ngay, ";
	SQL +=  "       TO_CHAR(v.tr_date, 'MM') thang, TO_CHAR (v.tr_date,'YYYY') nam, ";
    SQL += "       v.remark, v.remark2, v.VOUCHER_TYPE  ";
	SQL +=  "    FROM TAC_HGTRH v WHERE PK =  "+ l_seq;
	DataTable dt = ESysLib.TableReadOpen(SQL);
	    
	if (dt.Rows.Count >0)
	{
		p_company_pk = dt.Rows[0][0].ToString();
		p_voucher_no = dt.Rows[0][1].ToString();
		p_ngay = dt.Rows[0][2].ToString();
		p_thang = dt.Rows[0][3].ToString();
		p_nam = dt.Rows[0][4].ToString();	
		p_remark = dt.Rows[0][5].ToString(); 
		p_remark2 = dt.Rows[0][6].ToString();
        p_voucher_code = dt.Rows[0][7].ToString();
	}
    SQL = "SELECT UPPER(D.CODE_LNM) FROM TAC_COMMCODE_MASTER M, TAC_COMMCODE_DETAIL D WHERE M.DEL_IF =0 AND D.DEL_IF =0 AND M.ID ='ACBG0130' AND D.CODE = '" + p_voucher_code + "' ";
    dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        p_voucher_name = dt.Rows[0][0].ToString();
    }
	SQL = " SELECT   d.ccy, TO_CHAR(SUM (d.TR_AMT),'9,999,999,999,999.99'), TRIM(TO_CHAR(SUM(D.TR_AMT), DECODE(D.CCY,'VND','9,999,999,999,999','9,999,999,999,999.99')))||' '||d.ccy  FMT ";
	SQL += "    ,d.TR_RATE  ";
	SQL += "    FROM tac_hgtrd d ";
	SQL += "   WHERE d.del_if = 0 ";
	SQL += "     AND d.tac_hgtrh_pk = " + l_seq;
	SQL += "     AND d.drcr_type = 'D' ";
	SQL += "     AND d.tac_abacctcode_pk IN (SELECT pk FROM tac_abacctcode WHERE (ac_cd LIKE '111%'  or ac_cd LIKE '112%') ) ";
	SQL += "  GROUP BY ccy,TR_RATE ";
	
	DataTable dt2 = ESysLib.TableReadOpen(SQL);
	if (dt2.Rows.Count > 0)
	{
		p_ccy = dt2.Rows[0][0].ToString();
		p_amount = dt2.Rows[0][1].ToString();
		p_fmt_amount = dt2.Rows[0][2].ToString();
		p_rate = dt2.Rows[0][3].ToString();
	}
    if (p_amount != "")
    {
        p_amt_vn = CommondLib.Num2VNText(p_amount, p_ccy);
    }
		SQL = " SELECT partner_lname, addr2, tax_code  FROM tco_company WHERE pk = '" + p_company_pk + "' ";
	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if (dt1.Rows.Count >0)
	{
		p_cmp_name = dt1.Rows[0][0].ToString();
		p_cmp_add = dt1.Rows[0][1].ToString();
		p_cmp_taxcode = dt1.Rows[0][2].ToString();
	} 

	SQL = " SELECT   d.drcr_type, ";
SQL += "ac_get_accd (d.tac_abacctcode_pk,"+p_company_pk+")|| ' : '|| TRIM(TO_CHAR(SUM(d.TR_BOOKAMT),DECODE('"+ p_book_ccy +"','VND','9,999,999,999,999','9,999,999,999,999.99'))) ";
SQL += "    FROM tac_hgtrd d ";
SQL += "   WHERE d.del_if = 0 AND d.tac_hgtrh_pk = " + l_seq;
SQL += " GROUP BY d.drcr_type, d.tac_abacctcode_pk,DRCR_ORD ";
SQL += " ORDER BY d.drcr_type DESC,DRCR_ORD ASC ";
//SQL += " ORDER BY d.drcr_type DESC,d.tac_abacctcode_pk  ASC,DRCR_ORD ASC ";
DataTable dt3 =ESysLib.TableReadOpen(SQL);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="PVR_files/filelist.xml">
<link rel=Edit-Time-Data href="gfbr00030_PaymentVoucher_files/editdata.mso">
<link rel=OLE-Object-Data href="gfbr00030_PaymentVoucher_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-07-02T01:53:36Z</o:LastPrinted>
  <o:Created>2008-07-02T01:53:26Z</o:Created>
  <o:LastSaved>2008-07-03T08:50:48Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
.font6
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:00000;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Phieu Thu</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>1200</x:HorizontalResolution>
      <x:VerticalResolution>1200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <x:RowBreak>
       <x:Row>25</x:Row>
      </x:RowBreak>
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15000</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>375</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=661 style='border-collapse:
 collapse;table-layout:fixed;width:498pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=40 span=2 style='mso-width-source:userset;mso-width-alt:
 1462;width:30pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=54 span=246 style='mso-width-source:userset;mso-width-alt:
 1974;width:41pt'>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=6 height=33 class=xl43 width=459 style='height:24.95pt;
  width:346pt'><%=p_cmp_name %></td>
  <td colspan=4 class=xl44 width=202 style='width:152pt'>Form No/M&#7851;u
  s&#7889;: 01-TT</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=6 height=20 class=xl45 style='height:15.0pt'><%= p_cmp_add  %></td>
  <td colspan=4 class=xl42>Voucher No/S&#7889;: <font class="font6"><%= p_voucher_no%></font></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl41 style='height:15.0pt'>Tax Code/MST:</td>
  <td colspan=4 class=xl41><%= p_cmp_taxcode %></td>
  <td colspan=4 class=xl42>Seq: <font class="font6"><%= l_seq %></font></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=6 rowspan=5 height=103 class=xl40 width=459 style='height:77.85pt;
  width:346pt'>RECEIPT VOUCHER/ <%= p_voucher_name %><br>
    <font class="font10"><br>
    </font><font class="font7">Date/Ng&agrave;y : <%= p_ngay %>/<%= p_thang%>/<%= p_nam%></font></td>
<%
	for(i=0;i<dt3.Rows.Count;i++)
	{
		tmp1 = dt3.Rows[i][0].ToString();
		tmp2 = dt3.Rows[i][1].ToString();
		if (tmp1=="D")
		{
			tmp3 = "N&#7907;";
		}
		else
		{
			tmp3 = "C&oacute;";
		}
		if (i==0)
		{
%>
  <td class=xl25><%= tmp3 %> :</td>
  <td colspan=3 class=xl39><%= tmp2 %></td>
 </tr>
	 <%
		}
		else
		{
	 %>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
 <% if (i>4) {%> <td colspan=6 class=xl40 width=459 style='width:346pt'></td><%} %>
  <td height=21 class=xl25 style='height:15.95pt'><%= tmp3 %>:</td>
  <td colspan=3 class=xl39><%= tmp2 %></td>
 </tr>
<%
		}
	}
	for (i=0;i<5-dt3.Rows.Count;i++)//Blank rows
	{
%>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=3 class=xl39></td>
 </tr>
 <%
	}
%>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=4 height=22 class=xl26 style='height:16.5pt'>Payer Name/ H&#7885; t&ecirc;n ng&#432;&#7901;i n&#7897;p ti&#7873;n:</td>
  <td colspan=6 class=xl38><%= p_person %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl26 style='height:15.0pt'>Address/
  &#272;&#7883;a ch&#7881;:</td>
  <td colspan=7 class=xl38><%= p_addr %></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl26 style='height:15.75pt'>Object/
  &#272;&#417;n v&#7883;:</td>
  <td colspan=7 class=xl38><%= p_buspartner_lnm%></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl26 style='height:17.25pt'>Receive Reason/L&yacute; do n&#7897;p:</td>
  <td colspan=7 class=xl35><%= p_remark%></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl26 style='height:17.25pt'></td>
  <td colspan=7 class=xl35><%= p_remark2 %></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=3 height=24 class=xl26 style='height:18.0pt'>Total Amt/ S&#7889;
  ti&#7873;n:</td>
  <td colspan=3 class=xl36><%= p_fmt_amount %></td>
  <td class=xl27></td>
  <td colspan=2 class=xl37>Rate/T&#7927; gi&aacute;:</td>
  <td class=xl28 align=right x:num><%= p_rate %></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=3 height=40 class=xl26 style='height:30.0pt'>In Word/ B&#7857;ng
  ch&#7919;:</td>
  <td colspan=7 class=xl34 width=489 style='width:368pt'><%= p_amt_vn%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl26 colspan=3 style='height:15.0pt;mso-ignore:colspan'>Enclose/
  Km theo:</td>
  <td colspan=7><%= p_enclose %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl29 style='height:12.75pt'>DIRECTOR</td>
  <td colspan=2 class=xl29>CHIEF ACC</td>
  <td class=xl29>CASHIER</td>
  <td colspan=2 class=xl29>PREPARE BY</td>
  <td colspan=3 class=xl29>PAYER</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl29 style='height:12.75pt'>Gi&aacute;m &#273;&#7889;c</td>
  <td colspan=2 class=xl29>K&#7871; to&aacute;n tr&#432;&#7903;ng</td>
  <td class=xl29>Th&#7911; qu&#7929;</td>
  <td colspan=2 class=xl29>Ng&#432;&#7901;i l&#7853;p phi&#7871;u</td>
  <td colspan=3 class=xl29>Ng&#432;&#7901;i n&#7897;p ti&#7873;n</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl30 style='height:12.75pt'>(K&yacute;, h&#7885; t&ecirc;n,
  &#273;&oacute;ng d&#7845;u)</td>
  <td colspan=2 class=xl30>(K&yacute;, h&#7885; t&ecirc;n)</td>
  <td class=xl30>(K&yacute;, h&#7885; t&ecirc;n)</td>
  <td colspan=2 class=xl30>(K&yacute;, h&#7885; t&ecirc;n)</td>
  <td colspan=3 class=xl30>(K&yacute;, h&#7885; t&ecirc;n)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 rowspan=3 height=76 class=xl32 style='height:57.0pt'></td>
  <td colspan=2 rowspan=3 class=xl32></td>
  <td rowspan=3 class=xl32></td>
  <td colspan=2 rowspan=3 class=xl32></td>
  <td colspan=3 rowspan=3 class=xl32></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=10 height=17 class=xl33 style='height:12.75pt'>Payment Received
  (In Word)/&#272;&atilde; nh&#7853;n &#273;&#7911; s&#7889; ti&#7873;n ( b&#7857;ng
  ch&#7919; ):……………………………………………………………………..</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl33 style='height:12.75pt'><span
  style='mso-spacerun:yes'> </span>+ S&#7889; ti&#7873;n quy &#273;&#7893;i:
  ................................................................................................................................................</td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=54 style='width:41pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=61 style='width:46pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
