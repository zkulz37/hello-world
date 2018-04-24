<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
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
	
    SQL = " SELECT v.tco_company_pk, v.voucherno, SUBSTR (v.tr_date, 7, 2) ngay, ";
    SQL +=  "       SUBSTR (v.tr_date, 5, 2) thang, SUBSTR (v.tr_date, 0, 4) nam, ";
    SQL +=  "       tr_person, (SELECT addr1 ";
    SQL +=  "                     FROM tco_buspartner b ";
    SQL +=  "                    WHERE b.pk = v.tco_buspartner_pk) addr, v.buspartner_lnm, ";
    SQL +=  "       v.remark, v.remark2, v.tr_enclose, v.tr_reason ";
    SQL +=  "  FROM tac_bprvpv v ";
    SQL +=  " WHERE pk =  " + p_table_pk;
    
    DataTable dt = ESysLib.TableReadOpen(SQL);
    
	if (dt.Rows.Count >0)
	{
		p_company_pk = dt.Rows[0][0].ToString();
		p_voucher_no = dt.Rows[0][1].ToString();
		p_ngay = dt.Rows[0][2].ToString();
		p_thang = dt.Rows[0][3].ToString();
		p_nam = dt.Rows[0][4].ToString();
		p_person = dt.Rows[0][5].ToString();
		p_addr = dt.Rows[0][6].ToString();
		p_buspartner_lnm = dt.Rows[0][7].ToString();
		p_remark = dt.Rows[0][8].ToString(); 
		p_remark2 = dt.Rows[0][9].ToString();
		p_enclose = dt.Rows[0][10].ToString();
		p_reason = dt.Rows[0][11].ToString(); 

	}   
	SQL = " SELECT partner_lname, addr2, tax_code  FROM tco_company WHERE pk = '" + p_company_pk + "' ";
	dt.Dispose();
	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if (dt1.Rows.Count >0)
	{
		p_cmp_name = dt1.Rows[0][0].ToString();
		p_cmp_add = dt1.Rows[0][1].ToString();
		p_cmp_taxcode = dt1.Rows[0][2].ToString();
	} 


    SQL = " SELECT   d.ccy, SUM (d.trans_amt), TRIM(TO_CHAR(SUM(D.trans_amt), DECODE(D.CCY,'VND','9,999,999,999,999','9,999,999,999,999.99')))||' '||d.ccy  FMT ";
	SQL += "    ,d.TR_RATE  ";
    SQL += "    FROM tac_bprvpvd d ";
    SQL += "   WHERE d.del_if = 0 ";
    SQL += "     AND d.tac_bprvpv_pk = " + p_table_pk;
    SQL += "     AND d.drcr_type = 'C' ";
    SQL += "     AND d.tac_abacctcode_pk IN (SELECT pk FROM tac_abacctcode WHERE ac_cd LIKE '111%' AND tco_company_pk =" + p_company_pk+") ";
    SQL += "  GROUP BY ccy,TR_RATE ";

    DataTable dt2 = ESysLib.TableReadOpen(SQL);
    if (dt2.Rows.Count > 0)
    {
        p_ccy = dt2.Rows[0][0].ToString();
        p_amount = dt2.Rows[0][1].ToString();
        p_fmt_amount = dt2.Rows[0][2].ToString();
		p_rate = dt2.Rows[0][3].ToString();
    }  
	p_amt_vn = CommondLib.Num2VNText(p_amount); 

	SQL = " SELECT   d.drcr_type, sf_a_get_accd (d.tac_abacctcode_pk) ";
	SQL += "    FROM tac_hgtrd d ";
	SQL += "   WHERE d.del_if = 0 AND d.tac_hgtrh_pk = " + l_seq;
	SQL += " GROUP BY d.drcr_type, d.tac_abacctcode_pk,DRCR_ORD ";
	SQL += " ORDER BY d.drcr_type DESC,DRCR_ORD ";

	string strDebit="";
	string strCredit="";
	
	DataTable dt3 = ESysLib.TableReadOpen(SQL);
	tmp1 = "";
	tmp2 = "";
	for (i=0;i<dt3.Rows.Count;i++)
	{
		if (dt3.Rows[i][0].ToString()=="D")
		{
			strDebit = strDebit + tmp1 +dt3.Rows[i][1].ToString();
			tmp1 = "/";
		}
		else
		{
			strCredit = strCredit + tmp2 +dt3.Rows[i][1].ToString();
			tmp2 = "/";
		}
	}
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="PT2_files/filelist.xml">
<link rel=Edit-Time-Data href="PT2_files/editdata.mso">
<link rel=OLE-Object-Data href="PT2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-07-04T08:48:30Z</o:LastPrinted>
  <o:Created>2008-07-04T08:47:41Z</o:Created>
  <o:LastSaved>2008-07-04T08:48:43Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .75in;
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
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:00000;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
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
	vertical-align:top;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022$\0022\#\,\#\#0\.00";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Phieu Chi</x:Name>
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
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$14:$F$14</x:RangeSelection>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15240</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=715 style='border-collapse:
 collapse;table-layout:fixed;width:539pt'>
 <col class=xl26 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl26 width=64 style='width:48pt'>
 <col class=xl26 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl26 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl26 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl26 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl26 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl26 width=40 span=2 style='mso-width-source:userset;mso-width-alt:
 1462;width:30pt'>
 <col class=xl26 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl26 width=54 span=246 style='mso-width-source:userset;mso-width-alt:
 1974;width:41pt'>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=6 height=27 class=xl24 width=459 style='height:20.25pt;
  width:346pt'><%=p_cmp_name %></td>
  <td colspan=4 class=xl25 width=202 style='width:152pt'>Form No/M&#7851;u
  s&#7889;: 02-TT</td>
  <td class=xl26 width=54 style='width:41pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=6 height=20 class=xl27 style='height:15.0pt'><%= p_cmp_add  %></td>
  <td colspan=4 class=xl28>Voucher No/S&#7889; : <font class="font6"><%= p_voucher_no %></font></td>
  <td class=xl26></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl29 style='height:15.0pt'>Tax Code/MST:</td>
  <td colspan=4 class=xl29><%= p_cmp_taxcode %></td>
  <td colspan=4 class=xl28>Seq: <font class="font6"><%= l_seq %></font></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=6 class=xl30 style='height:15.95pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl31>Quy&#7875;n s&#7889;:</td>
  <td colspan=2 class=xl32 width=101 style='width:76pt'>.........................</td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl30 style='height:15.95pt'></td>
  <td colspan=6 rowspan=2 class=xl33 width=466 style='width:351pt'>PAYMENT VOUCHER/ PHI&#7870;U CHI</td>
  <td class=xl34>N&#7907;:</td>
  <td colspan=2 rowspan=2 class=xl35 width=101 style='width:76pt'><%= strDebit %></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 style='height:15.95pt'></td>
  <td class=xl34></td>
  <td class=xl35></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td colspan=6 class=xl36 width=466 style='width:351pt'>Date/Ng�y : <b><%= p_ngay %>/<%= p_thang%>/<%= p_nam%> </b></td>
  <td class=xl34>C�:</td>
  <td colspan=2 rowspan=3 class=xl35 width=101 style='width:76pt'><%= strCredit %></td>
  <td class=xl26></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 colspan=8 class=xl26 style='height:9.75pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=4 height=22 class=xl37 style='height:16.5pt'>Receiver/ H&#7885;
  t�n ng&#432;&#7901;i nh&#7853;n ti&#7873;n:</td>
  <td colspan=4 class=xl38><%= p_person %></td>
  <td class=xl26></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl37 style='height:15.0pt'>Address/
  &#272;&#7883;a ch&#7881;:</td>
  <td colspan=7 class=xl38><%= p_addr %></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl37 style='height:15.75pt'>Object/
  &#272;&#417;n v&#7883;:</td>
  <td colspan=7 class=xl38><%= p_buspartner_lnm%></td>
  <td class=xl26></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl37 style='height:17.25pt'>Payment Reason/L�
  do chi:</td>
  <td colspan=7 class=xl39><%= p_remark%></td>
  <td class=xl26></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl37 style='height:17.25pt'></td>
  <td colspan=7 class=xl39><%= p_remark2 %></td>
  <td class=xl26></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=3 height=24 class=xl37 style='height:18.0pt'>Total Amt/ S&#7889;
  ti&#7873;n:</td>
  <td colspan=3 class=xl40><%= p_fmt_amount %></td>
  <td class=xl41></td>
  <td colspan=2 class=xl42>Rate/T&#7927; gi�:</td>
  <td class=xl43 align=right x:num><%= p_rate %></td>
  <td class=xl26></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=3 height=40 class=xl37 style='height:30.0pt'>In Word/ B&#7857;ng
  ch&#7919;:</td>
  <td colspan=7 class=xl44 width=489 style='width:368pt'><%= p_amt_vn%></td>
  <td class=xl26></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl37 colspan=3 style='height:15.0pt;mso-ignore:colspan'>Enclose/
  K�m theo:</td>
  <td colspan=7><%= p_enclose %></td>
  <td class=xl26></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl26 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl45 style='height:12.75pt'>DIRECTOR</td>
  <td colspan=2 class=xl45>CHIEF ACC</td>
  <td class=xl45>RECEIVER</td>
  <td colspan=2 class=xl45>PREPARE BY</td>
  <td colspan=3 class=xl45>CASHIER</td>
  <td class=xl26></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl45 style='height:12.75pt'>Gi�m &#273;&#7889;c</td>
  <td colspan=2 class=xl45>K&#7871; to�n tr&#432;&#7903;ng</td>
  <td class=xl45>Ng&#432;&#7901;i n&#7897;p ti&#7873;n</td>
  <td colspan=2 class=xl45>Ng&#432;&#7901;i l&#7853;p phi&#7871;u</td>
  <td colspan=3 class=xl45>Th&#7911; qu&#7929;</td>
  <td class=xl26></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl46 style='height:12.75pt'>(K�, h&#7885; t�n,
  &#273;�ng d&#7845;u)</td>
  <td colspan=2 class=xl46>(K�, h&#7885; t�n)</td>
  <td class=xl46>(K�, h&#7885; t�n)</td>
  <td colspan=2 class=xl46>(K�, h&#7885; t�n)</td>
  <td colspan=3 class=xl46>(K�, h&#7885; t�n)</td>
  <td class=xl26></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 rowspan=3 height=91 class=xl47 style='height:68.25pt'></td>
  <td colspan=2 rowspan=3 class=xl47></td>
  <td rowspan=3 class=xl47></td>
  <td colspan=2 rowspan=3 class=xl47></td>
  <td colspan=3 rowspan=3 class=xl47></td>
  <td class=xl26></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl26 style='height:27.75pt'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl26 style='height:27.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=10 height=17 class=xl48 style='height:12.75pt'>Payment Received
  (In Word)/&#272;� nh&#7853;n &#273;&#7911; s&#7889; ti&#7873;n ( b&#7857;ng
  ch&#7919; ):��������������������������..</td>
  <td class=xl26></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl48 style='height:12.75pt'><span
  style='mso-spacerun:yes'>�</span>+ S&#7889; ti&#7873;n quy &#273;&#7893;i:
  &nbsp; VND
  ................................................................................................................................................</td>
  <td colspan=6 class=xl49 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
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
  <td width=54 style='width:41pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
