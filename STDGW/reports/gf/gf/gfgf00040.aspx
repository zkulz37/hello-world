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
	string p_company_pk = ""+Request["company_pk"];
	string p_kindCode = ""+Request["KindCode"];
	string p_DeptPK = ""+Request["DeptPK"];
	string p_Status = ""+Request["Status"];
	string p_AssetAccCode = ""+ Request["AssetAccCode"];
	string p_AssetDepr = ""+ Request["AssetDepr"]	;
	string p_ExpAcc = ""+ Request["ExpAcc"];
	string p_date_search = ""+Request["dtMonth"];
    string p_company_name = "";
    string p_rpt_date = "";
    string p_rpt_date2 = "";
    string p_open_date = "";
    string p_tax_code = "";
    string p_cmp_add = "";
    string p_unit = "";
    string SQL_1 = "";
    string SQL_2 = "";
    string SQL_3 = "";
    string SQL = " SELECT partner_name, ";
    SQL += "       tax_code,ADDR1,ADDR2,ADDR3,INITCAP(TO_CHAR(TO_DATE('"+p_date_search+"01','YYYYMMDD'),'MONTH')) F_MONTH, SUBSTR('"+p_date_search+"',0,4) F_YEAR ";
    SQL += "  FROM tco_company ";
    SQL += " WHERE pk =" + p_company_pk; 
   DataTable  dt = ESysLib.TableReadOpen(SQL);
    p_company_name = dt.Rows[0][0].ToString();
    p_tax_code = dt.Rows[0][1].ToString();
    p_cmp_add = dt.Rows[0][2].ToString() + " " + dt.Rows[0][3].ToString(); 
   p_rpt_date =  dt.Rows[0][5].ToString(); 
   p_rpt_date2 = dt.Rows[0][6].ToString(); 
   SQL = " SELECT CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y' ";
   dt = ESysLib.TableReadOpen(SQL);
   p_unit = dt.Rows[0][0].ToString();
   
   double t1,t2,t3,t4;
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="LIST%20OF%20FIXED%20ASSETS%20DEPRECIATION_files/filelist.xml">
<link rel=Edit-Time-Data
href="LIST%20OF%20FIXED%20ASSETS%20DEPRECIATION_files/editdata.mso">
<link rel=OLE-Object-Data
href="LIST%20OF%20FIXED%20ASSETS%20DEPRECIATION_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-10-29T05:47:08Z</o:LastPrinted>
  <o:Created>2008-10-29T01:54:18Z</o:Created>
  <o:LastSaved>2008-10-29T06:10:39Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .75in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.5in;
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
	font-family:Tahoma;
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
	font-family:Tahoma;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl30
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl46
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	color:#333399;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl50
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:right;
	border:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>97</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15240</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl28>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1064 style='border-collapse:
 collapse;table-layout:fixed;width:798pt'>
 <col class=xl28 width=28 style='mso-width-source:userset;mso-width-alt:1024;
 width:21pt'>
 <col class=xl28 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl28 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl28 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col class=xl28 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl28 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl28 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl28 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl28 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl28 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl28 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl28 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl28 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl28 width=64 style='width:48pt'>
 <tr class=xl24 height=22 style='height:16.5pt'>
  <td height=22 class=xl42 colspan=2 width=146 style='height:16.5pt;mso-ignore:
  colspan;width:110pt'><%=p_company_name %></td>
  <td class=xl42 width=68 style='width:51pt'></td>
  <td class=xl42 width=27 style='width:20pt'></td>
  <td class=xl42 width=111 style='width:83pt'></td>
  <td class=xl42 width=75 style='width:56pt'></td>
  <td class=xl42 width=75 style='width:56pt'></td>
  <td class=xl42 width=59 style='width:44pt'></td>
  <td class=xl42 width=92 style='width:69pt'></td>
  <td class=xl42 width=105 style='width:79pt'></td>
  <td class=xl42 width=86 style='width:65pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=35 style='width:26pt'></td>
  <td class=xl24 width=46 style='width:35pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl24 height=22 style='height:16.5pt'>
  <td height=22 class=xl42 colspan=5 style='height:16.5pt;mso-ignore:colspan'><%= p_cmp_add %></td>
  <td colspan=6 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=22 style='height:16.5pt'>
  <td height=22 class=xl42 colspan=2 style='height:16.5pt;mso-ignore:colspan'>MST  : <%= p_tax_code %></td>
  <td colspan=9 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=27 style='height:20.25pt'>
  <td colspan=14 height=27 class=xl50 style='height:20.25pt'>LIST OF FIXED
  ASSETS DEPRECIATION</td>
  <td class=xl26></td>
 </tr>
 <tr class=xl26 height=27 style='height:20.25pt'>
  <td colspan=14 height=27 class=xl45 style='height:20.25pt'>Month <%=p_rpt_date  %> Year <%= p_rpt_date2 %></td>
  <td class=xl27></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl30>UNIT:</td>
  <td class=xl29><%= p_unit  %></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=17 style='height:12.75pt'>
  <td height=17 class=xl57 style='height:12.75pt'>No.</td>
  <td class=xl31>Name of fixed assets</td>
  <td class=xl31>Assets No</td>
  <td class=xl31>Qty</td>
  <td class=xl31>Date of installation</td>
  <td class=xl31>Estimate life</td>
  <td class=xl31>Estimate life</td>
  <td class=xl31>First cost</td>
  <td class=xl31>Depre.in month</td>
  <td class=xl31>Acc. Depreciation</td>
  <td class=xl31>Ramain Amt</td>
  <td class=xl31>Expense Acc</td>
  <td class=xl31>Dept.</td>
  <td class=xl31>Invoice</td>
  <td class=xl32></td>
 </tr>
 <tr class=xl32 height=17 style='height:12.75pt'>
  <td height=17 class=xl58 style='height:12.75pt'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>(year)</td>
  <td class=xl33>(month)</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>PO No.</td>
  <td class=xl32></td>
 </tr>
 <%
    SQL_1 = "SELECT C.PK,C.AC_CD,A.CODE_NM  " + 
        " FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B, ACNT.TAC_ABACCTCODE C " +
        " WHERE A.TCO_ABCODEGRP_PK = b.pk  " +
        " and b.id ='ACDF0030'  " +
        " and a.use_if = 1 and a.del_if = 0  " +
        " and b.del_if = 0 " +
        " AND C.DEL_IF =0 " +
        " AND A.CODE = C.AC_CD " +
        " AND C.TCO_COMPANY_PK = " + p_company_pk +
        " ORDER BY A.ORD " ;
    DataTable dt1 = ESysLib.TableReadOpen(SQL_1);
    for(int i=0; i<dt1.Rows.Count;i++)
   {
        string SQL_1_SUM = "SELECT  NVL(SUM(a.fa_cost),0) TOTAL_COST, NVL(SUM(a.fa_depr_amt),0) TOTAL_DEPR, " + 
        "             SUM((NVL (a.fa_begin_depr_amt, 0) + NVL (b.fd_damt, 0))) TOTAL_ACCUM, " +
        "             SUM((a.fa_cost - NVL (a.fa_begin_depr_amt, 0) - NVL (b.fd_damt, 0))) TOTAL_remain_amt " +
        "        FROM tac_gffa_mst a, " +
        "             (SELECT   d.tac_gffa_mst_pk, SUM (d.fd_damt) fd_damt, " +
        "                       SUM (d.fd_dfamt) fd_dfamt " +
        "                  FROM tac_gffadprc_mst m, tac_gffadprc_dtl d " +
        "                 WHERE m.del_if = 0 " +
        "                   AND d.del_if = 0 " +
        "                   AND m.fd_status IN ('0', '1', '2') " +
        "                   AND d.tac_gffadprc_mst_pk = m.pk " +
        "              GROUP BY d.tac_gffa_mst_pk) b " +
        "       WHERE a.del_if = 0 " +
        "         AND b.tac_gffa_mst_pk(+) = a.pk " +
        "         AND a.tco_company_pk =  " + p_company_pk +
        "         AND a.fa_status =  '" +p_Status+"' "+
        "         AND a.tco_dept_pk LIKE DECODE ('"+p_DeptPK+"', '', '%', '"+p_DeptPK+"') " +
        "         AND a.fa_use_date <= TO_CHAR (LAST_DAY (TO_DATE ('"+p_date_search+"' || '01', 'yyyymmdd')), 'yyyymmdd') " +
        "         AND a.tac_abacctcode_pk_depr = " + dt1.Rows[i][0].ToString();
        DataTable dt1_sum = ESysLib.TableReadOpen(SQL_1_SUM);
       
      %>
    <tr class=xl32 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl52 style='height:14.25pt;border-top:none' x:num></td>
  <td class=xl56 style='border-top:none;border-left:none'><b><%=dt1.Rows[i][1].ToString() %> - <%=dt1.Rows[i][2].ToString()  %></b></td>
  <td class=xl56 style='border-top:none;border-left:none'></td>
  <td class=xl52 style='border-top:none;border-left:none' ></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl52 style='border-top:none;border-left:none' ></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><b><%= dt1_sum.Rows[0][0].ToString() %></b></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><b><%= dt1_sum.Rows[0][1].ToString() %></b></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><b><%= dt1_sum.Rows[0][2].ToString() %></b></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><b><%= dt1_sum.Rows[0][3].ToString() %></b></td>
  <td class=xl51 style='border-top:none;border-left:none' ></td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32></td>
 </tr>
<% 
        SQL_2 = "SELECT CODE, CODE_NM " + 
        "FROM TCO_ABCODE A, TCO_ABCODEGRP B  " +
        "WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACDF0010'  " +
        "and a.use_if = 1 and a.del_if = 0  " +
        "and b.del_if = 0  " ;
        DataTable dt2 = ESysLib.TableReadOpen(SQL_2);
        for(int j=0;j<dt2.Rows.Count;j++)
        {
            string SQL_2_SUM = "SELECT  NVL(SUM(a.fa_cost),0) TOTAL_COST, NVL(SUM(a.fa_depr_amt),0) TOTAL_DEPR, " + 
        "             SUM((NVL (a.fa_begin_depr_amt, 0) + NVL (b.fd_damt, 0))) TOTAL_ACCUM, " +
        "             SUM((a.fa_cost - NVL (a.fa_begin_depr_amt, 0) - NVL (b.fd_damt, 0))) TOTAL_remain_amt " +
        "        FROM tac_gffa_mst a, " +
        "             (SELECT   d.tac_gffa_mst_pk, SUM (d.fd_damt) fd_damt, " +
        "                       SUM (d.fd_dfamt) fd_dfamt " +
        "                  FROM tac_gffadprc_mst m, tac_gffadprc_dtl d " +
        "                 WHERE m.del_if = 0 " +
        "                   AND d.del_if = 0 " +
        "                   AND m.fd_status IN ('0', '1', '2') " +
        "                   AND d.tac_gffadprc_mst_pk = m.pk " +
        "              GROUP BY d.tac_gffa_mst_pk) b " +
        "       WHERE a.del_if = 0 " +
        "         AND b.tac_gffa_mst_pk(+) = a.pk " +
        "         AND a.tco_company_pk =  " + p_company_pk +
        "         AND a.fa_status =  '" +p_Status+"' "+
        "         AND a.tco_dept_pk LIKE DECODE ('"+p_DeptPK+"', '', '%', '"+p_DeptPK+"') " +
        "         AND a.fa_use_date <= TO_CHAR (LAST_DAY (TO_DATE ('"+p_date_search+"' || '01', 'yyyymmdd')), 'yyyymmdd') " +
        "         AND a.fa_kind_cd LIKE DECODE ('"+dt2.Rows[j][0].ToString()+"', 'ALL', '%', '"+dt2.Rows[j][0].ToString()+"') " +
        "         AND a.tac_abacctcode_pk_depr = " + dt1.Rows[i][0].ToString();
        DataTable dt2_sum = ESysLib.TableReadOpen(SQL_2_SUM);
        

 SQL_3 = "SELECT a.fa_nm, a.fa_cd, a.fa_qty, to_char(to_date(a.fa_use_date,'YYYYMMDD'),'DD/MM/YYYY'), a.fa_depr_yy, " + 
        "             a.fa_depr_mm, a.fa_cost, a.fa_depr_amt, " +
        "             (NVL (a.fa_begin_depr_amt, 0) + NVL (b.fd_damt, 0)) accum_amt, " +
        "             (a.fa_cost - NVL (a.fa_begin_depr_amt, 0) - NVL (b.fd_damt, 0)) remain_amt,d.ac_cd grp1, " +
        "             c.dept_nm,  fa_kind_cd, e.ac_cd grp2 " +
        "        FROM tac_gffa_mst a, " +
        "             (SELECT   d.tac_gffa_mst_pk, SUM (d.fd_damt) fd_damt, " +
        "                       SUM (d.fd_dfamt) fd_dfamt " +
        "                  FROM tac_gffadprc_mst m, tac_gffadprc_dtl d " +
        "                 WHERE m.del_if = 0 " +
        "                   AND d.del_if = 0 " +
        "                   AND m.fd_status IN ('0', '1', '2') " +
        "                   AND d.tac_gffadprc_mst_pk = m.pk " +
        "              GROUP BY d.tac_gffa_mst_pk) b, " +
        "             tco_dept c, " +
        "             tac_abacctcode d, " +
        "             tac_abacctcode e " +
        "       WHERE a.del_if = 0 " +
        "         AND c.del_if(+) = 0 " +
        "         AND d.del_if = 0 " +
        "         AND e.del_if = 0 " +
        "         AND b.tac_gffa_mst_pk(+) = a.pk " +
        "         AND a.tco_dept_pk = c.pk(+) " +
        "         AND a.tac_abacctcode_pk_expe = d.pk " +
        "         AND a.tac_abacctcode_pk_depr = e.pk " +
        "         AND a.tco_company_pk =  " + p_company_pk +
        "         AND a.fa_status =  '" +p_Status+"' "+
        "         AND a.tco_dept_pk LIKE DECODE ('"+p_DeptPK+"', '', '%', '"+p_DeptPK+"') " +
        "         AND a.fa_use_date <= TO_CHAR (LAST_DAY (TO_DATE ('"+p_date_search+"' || '01', 'yyyymmdd')), 'yyyymmdd') " +
        "         AND a.fa_kind_cd LIKE DECODE ('"+dt2.Rows[j][0].ToString()+"', 'ALL', '%', '"+dt2.Rows[j][0].ToString()+"') " +
        "         AND tac_abacctcode_pk LIKE DECODE ('ALL', 'ALL', '%', 'ALL') " +
        "         AND tac_abacctcode_pk_depr LIKE DECODE ('"+dt1.Rows[i][0].ToString()+"','ALL', '%','"+dt1.Rows[i][0].ToString()+"') " +
        "         AND tac_abacctcode_pk_expe LIKE DECODE ('ALL','ALL', '%','ALL') " ;
             DataTable dt3 = ESysLib.TableReadOpen(SQL_3);
            for(int k=0;k<dt3.Rows.Count;k++)
            {
                if (k == 0)
                { 
   %>
                 <tr class=xl32 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl52 style='height:14.25pt;border-top:none' x:num></td>
  <td class=xl56 style='border-top:none;border-left:none'><b><%=dt2.Rows[j][1].ToString() %> </b></td>
  <td class=xl56 style='border-top:none;border-left:none'></td>
  <td class=xl52 style='border-top:none;border-left:none' ></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl52 style='border-top:none;border-left:none' ></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><b><%= dt2_sum.Rows[0][0].ToString() %></b></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><b><%= dt2_sum.Rows[0][1].ToString() %></b></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><b><%= dt2_sum.Rows[0][2].ToString() %></b></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><b><%= dt2_sum.Rows[0][3].ToString() %></b></td>
  <td class=xl51 style='border-top:none;border-left:none' ></td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32></td>
 </tr>
   <%
        }//end if
    %>
 <tr class=xl32 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl52 style='height:14.25pt;border-top:none' x:num><%= (k+1) %></td>
  <td class=xl56 style='border-top:none;border-left:none'><%= dt3.Rows[k][0].ToString() %></td>
  <td class=xl56 style='border-top:none;border-left:none'><%= dt3.Rows[k][1].ToString() %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%= dt3.Rows[k][2].ToString() %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:str="<%= dt3.Rows[k][3].ToString() %>"><%= dt3.Rows[k][3].ToString() %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%= dt3.Rows[k][4].ToString() %></td>
  <td class=xl52 style='border-top:none;border-left:none'  x:num><%= dt3.Rows[k][5].ToString() %></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= dt3.Rows[k][6].ToString() %></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= dt3.Rows[k][7].ToString() %></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= dt3.Rows[k][8].ToString() %></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= dt3.Rows[k][9].ToString() %></td>
  <td class=xl51 style='border-top:none;border-left:none' x:num><%= dt3.Rows[k][10].ToString() %></td>
  <td class=xl51 style='border-top:none;border-left:none'><%= dt3.Rows[k][11].ToString() %></td>
  <td class=xl51 style='border-top:none;border-left:none'><%= dt3.Rows[k][12].ToString() %></td>
  <td class=xl32></td>
  <%
  }
  }
  }
   %>
<%
SQL = "SELECT  NVL(SUM(a.fa_cost),0) TOTAL_COST, NVL(SUM(a.fa_depr_amt),0) TOTAL_DEPR, " + 
        "             SUM((NVL (a.fa_begin_depr_amt, 0) + NVL (b.fd_damt, 0))) TOTAL_ACCUM, " +
        "             SUM((a.fa_cost - NVL (a.fa_begin_depr_amt, 0) - NVL (b.fd_damt, 0))) TOTAL_remain_amt " +
        "        FROM tac_gffa_mst a, " +
        "             (SELECT   d.tac_gffa_mst_pk, SUM (d.fd_damt) fd_damt, " +
        "                       SUM (d.fd_dfamt) fd_dfamt " +
        "                  FROM tac_gffadprc_mst m, tac_gffadprc_dtl d " +
        "                 WHERE m.del_if = 0 " +
        "                   AND d.del_if = 0 " +
        "                   AND m.fd_status IN ('0', '1', '2') " +
        "                   AND d.tac_gffadprc_mst_pk = m.pk " +
        "              GROUP BY d.tac_gffa_mst_pk) b " +
        "       WHERE a.del_if = 0 " +
        "         AND b.tac_gffa_mst_pk(+) = a.pk " +
        "         AND a.tco_company_pk =  " + p_company_pk +
        "         AND a.fa_status =  '" +p_Status+"' "+
        "         AND a.tco_dept_pk LIKE DECODE ('"+p_DeptPK+"', '', '%', '"+p_DeptPK+"') " +
        "         AND a.fa_use_date <= TO_CHAR (LAST_DAY (TO_DATE ('"+p_date_search+"' || '01', 'yyyymmdd')), 'yyyymmdd') ";
        DataTable dt_total = ESysLib.TableReadOpen(SQL);


 %> 
 
 <tr class=xl25 height=19 style='height:14.25pt'>
  <td colspan=3 height=19 class=xl46 style='border-right:.5pt solid black;
  height:14.25pt'>GRAND TOTAL</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37 x:num><%= dt_total.Rows[0][0].ToString() %></td>
  <td class=xl37 x:num><%= dt_total.Rows[0][1].ToString() %></td>
  <td class=xl37 x:num><%= dt_total.Rows[0][2].ToString() %></td>
  <td class=xl37 x:num><%= dt_total.Rows[0][3].ToString() %></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl25></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl49>Day...…..Month...…….Year.....</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'></td>
  <td class=xl38>prepared by</td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl28></td>
  <td colspan=3 class=xl38>Director</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl28 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl28 style='height:13.5pt'></td>
  <td colspan=7 class=xl39></td>
  <td colspan=7 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'></td>
  <td colspan=7 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl28 style='height:13.5pt'></td>
  <td class=xl39></td>
  <td colspan=6 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=28 style='width:21pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
