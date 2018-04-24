<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company 	= Request["Company"];
	string l_status 	= Request["status"];
	string l_prpsfr 	= Request["prps_fr"];
	string l_prpsto 	= Request["prps_to"];
    string bccy = Request["bccy"];
    string l_lang = Request["lang"];
    string p_xls_ccy_format = "";
    if (bccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    
	string l_cmp_name = "";
	string l_cmp_add = "";
	string l_cmp_taxcode = "";
	string SQL = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
		l_cmp_name = dt.Rows[0][0].ToString();
		l_cmp_add = dt.Rows[0][1].ToString();
		l_cmp_taxcode = dt.Rows[0][3].ToString();
	}

    SQL = " SELECT  AC_CD, B.AC_LNM, B.AC_NM, B.AC_KNM, LTRIM(A.DR_AMOUNT), LTRIM(CR_AMOUNT) ";
SQL = SQL + "      FROM (SELECT D.TAC_ABACCTCODE_PK,  ";
SQL = SQL + " TO_CHAR(NVL(SUM(DECODE(D.DRCR_TYPE, 'D', D.TR_BOOKAMT)), 0), AC_sf_get_bookformat('ACBG0040')) DR_AMOUNT, ";
SQL = SQL + " TO_CHAR(NVL(SUM(DECODE(D.DRCR_TYPE, 'C', D.TR_BOOKAMT)), 0), AC_sf_get_bookformat('ACBG0040')) CR_AMOUNT ";
SQL = SQL + "              FROM TAC_HGTRH H, TAC_HGTRD D ";
SQL = SQL + "             WHERE H.PK = D.TAC_HGTRH_PK ";
SQL = SQL + "            AND H.TR_STATUS IN  ('" + l_status + "',DECODE('" + l_status + "',2,0,'" + l_status + "'),DECODE('" + l_status + "',2,4,'" + l_status + "'))  ";
SQL = SQL + "               AND H.DEL_IF = 0 ";
SQL = SQL + "               AND D.DEL_IF = 0 ";
SQL = SQL + "               AND H.TCO_COMPANY_PK = '" + l_company + "'";
SQL = SQL + "     AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '" + l_prpsfr + "' AND '" + l_prpsto + "'";
SQL = SQL + "     GROUP BY D.TAC_ABACCTCODE_PK) A, TAC_ABACCTCODE B ";
SQL = SQL + "     WHERE A.TAC_ABACCTCODE_PK = B.PK ";
SQL = SQL + "     AND B.DEL_IF = 0 ";
SQL = SQL + "     ORDER BY B.AC_CD";

	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfhg00040_DailyAggregate_files/filelist.xml">
<link rel=Edit-Time-Data href="gfhg00040_DailyAggregate_files/editdata.mso">
<link rel=OLE-Object-Data href="gfhg00040_DailyAggregate_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>Acc</o:LastAuthor>
  <o:LastPrinted>2008-05-17T03:14:52Z</o:LastPrinted>
  <o:Created>2008-05-15T08:19:48Z</o:Created>
  <o:LastSaved>2008-05-17T03:18:10Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.75in .5in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
	padding:0px;
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
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Daily Aggregate</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>240</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>1200</x:HorizontalResolution>
      <x:VerticalResolution>1200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>0</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>315</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Daily Aggregate'!$A$7:$F$7</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Daily Aggregate'!$6:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl27>

<table x:str border=0 cellpadding=0 cellspacing=0 width=972 style='border-collapse: collapse;table-layout:fixed;width:731pt'>
 <col class=xl36 width=65 style='mso-width-source:userset;mso-width-alt:2377; width:49pt'>
 <% if (l_lang == "ENG")
    {  %>
         <col class=xl27 width=229  style=' mso-width-source:userset;mso-width-alt: 8374;width:172pt'>
         <col class=xl27 width=229  style='display:none;mso-width-source:userset;mso-width-alt: 8374;width:172pt'>
         <col class=xl27 width=229  style='display:none;mso-width-source:userset;mso-width-alt: 8374;width:172pt'>
<%}else if (l_lang == "VIE")
    {  %>
        <col class=xl27 width=229  style='display:none;mso-width-source:userset;mso-width-alt: 8374;width:172pt'>
         <col class=xl27 width=229  style='mso-width-source:userset;mso-width-alt: 8374;width:172pt'>
         <col class=xl27 width=229  style='display:none;mso-width-source:userset;mso-width-alt: 8374;width:172pt'>
    <%}else if (l_lang == "KOR")
    { %>
        <col class=xl27 width=229  style='display:none;mso-width-source:userset;mso-width-alt: 8374;width:172pt'>
         <col class=xl27 width=229  style='display:none;mso-width-source:userset;mso-width-alt: 8374;width:172pt'>
         <col class=xl27 width=229  style='mso-width-source:userset;mso-width-alt: 8374;width:172pt'>
    <%} %>
 <col class=xl27 width=110 span=2 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt'>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 width=65 style='height:12.0pt;width:49pt'>Company</td>
  <td class=xl25 colspan=2 width=458 style='mso-ignore:colspan;width:344pt'><%=l_cmp_name%></td>
  <td class=xl26 width=229 style='width:172pt'></td>
  <td class=xl27 width=110 style='width:83pt'></td>
  <td class=xl27 width=110 style='width:83pt'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'>Addres</td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'><%=l_cmp_add%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'>Tax Code</td>
  <td class=xl28><%=l_cmp_taxcode%></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=6 height=25 class=xl40 style='height:18.75pt'>Daily Aggregate
  Report</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=6 height=27 class=xl29 style='height:20.25pt'>From Date
  <%=l_prpsfr.Substring(0,4)%>-<%=l_prpsfr.Substring(4,2)%>-<%=l_prpsfr.Substring(6,2)%> To Date <%=l_prpsto.Substring(0,4)%>-<%=l_prpsto.Substring(4,2)%>-<%=l_prpsto.Substring(6,2)%></td>
 </tr>
 <tr class=xl29 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl41 style='border-right:.5pt solid black;
  height:15.0pt'>ACCOUNT</td>
  <td colspan=2 class=xl41 style='border-right:.5pt solid black;border-left:
  none'>AMOUNT</td>
 </tr>
 <tr class=xl29 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 id="_x0000_s1025" x:autofilter="all"  x:autofilterrange="$A$7:$F$7" style='height:15.0pt'>Code</td>
  <td class=xl31 id="_x0000_s1026" x:autofilter="all">Foreign</td>
  <td class=xl31 id="_x0000_s1027" x:autofilter="all">Local</td>
  <td class=xl31 id="_x0000_s1028" x:autofilter="all">Korea</td>
  <td class=xl31 id="_x0000_s1029" x:autofilter="all">Debit</td>
  <td class=xl31 id="_x0000_s1030" x:autofilter="all">Credit</td>
 </tr>
 <%
	if (dt_detail.Rows.Count >0)
	{
		for(int i=0;i<dt_detail.Rows.Count;i++)
		{
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt' x:num><%=dt_detail.Rows[i][0].ToString()%></td>
    <td class=xl33><%=dt_detail.Rows[i][2].ToString()%></td>
    <td class=xl33 ><%=dt_detail.Rows[i][1].ToString()%></td>
    <td class=xl33 ><%=dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';"  x:num><span  style='mso-spacerun:yes'></span><%=dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'></span><%=dt_detail.Rows[i][5].ToString()%></td>
 </tr>
 <%
 		}
	}
 %>
 <%
     SQL = "SELECT   ";
     SQL = SQL + " TO_CHAR(NVL(SUM(DECODE(D.DRCR_TYPE, 'D', D.TR_BOOKAMT)), 0), AC_sf_get_bookformat('ACBG0040')) DR_AMOUNT, ";
     SQL = SQL + " TO_CHAR(NVL(SUM(DECODE(D.DRCR_TYPE, 'C', D.TR_BOOKAMT)), 0), AC_sf_get_bookformat('ACBG0040')) CR_AMOUNT ";
     SQL = SQL + "              FROM TAC_HGTRH H, TAC_HGTRD D ";
     SQL = SQL + "             WHERE H.PK = D.TAC_HGTRH_PK ";
     SQL = SQL + "            AND H.TR_STATUS IN  ('" + l_status + "',DECODE('" + l_status + "',2,0,'" + l_status + "'),DECODE('" + l_status + "',2,4,'" + l_status + "'))  ";
     SQL = SQL + "               AND H.DEL_IF = 0 ";
     SQL = SQL + "               AND D.DEL_IF = 0 ";
     SQL = SQL + "               AND H.TCO_COMPANY_PK = '" + l_company + "'";
     SQL = SQL + "     AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '" + l_prpsfr + "' AND '" + l_prpsto + "'";
     SQL = SQL + "     and (select AC_TABLE_IO from TAC_ABACCTCODE where del_if = 0 and pk =D.TAC_ABACCTCODE_PK) = 'I'";
     
     
     DataTable dtsum = ESysLib.TableReadOpen(SQL);
 String l_total_book_amt_dr = "";
 String l_total_book_amt_cr = "";
 if (dt.Rows.Count > 0)
 {
     l_total_book_amt_dr = dtsum.Rows[0][0].ToString();
     l_total_book_amt_cr = dtsum.Rows[0][1].ToString();
 }

  %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl37 style='border-right:.5pt solid black;
  height:15.0pt'>TOTAL</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num ><span style='mso-spacerun:yes'></span><%=l_total_book_amt_dr%></td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num ><span style='mso-spacerun:yes'></span><%=l_total_book_amt_cr%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=65 style='width:49pt'></td>
  <td width=229 style='width:172pt'></td>
  <td width=229 style='width:172pt'></td>
  <td width=229 style='width:172pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>
</body>
</html>
