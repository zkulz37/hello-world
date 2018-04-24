<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
   
    string l_company_pk = "" +Request["company_pk"];
	string l_date_from	= Request["dtbFrom"];
	string l_date_to = Request["dtbTo"];
	string l_book_ccy = Request["Bookccy"];
	string l_status = Request["status"];
    
    string p_cmp_name = "";
	string p_cmp_add = "";	
	string p_cmp_taxcode = "";
	string p_cmp_fname = "";
	string p_cmp_fadd ="";
	string p_cmp_fname2 ="";
	string p_rpt_date = "";
    string p_date_frm = "";
    string p_date_to = "";
    string p_acpk = "";
    string p_accd = "";
    string p_acnm = "";
    string p_opentrans = "0";
    int i = 0;
    int j = 0;
    int stt = 1; 
    string SQLDetail = "";
    string SQLTotal = "";
    string p_bankpk = "";
    string p_bankacc = "";
    string p_bankid = "";
    string p_accbank_pklist = "";
    string p_strtmp = "";
    string p_bankopenbal = "";
    String p_xls_ccy_format = "";
    String p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    } 	 
	
	 string SQL = " SELECT partner_lname, addr2, tax_code,to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
	SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date, partner_name, addr1,UPPER(partner_name),TRIM(INITCAP(TO_CHAR(SYSDATE,'MONTH')))||' '||LOWER(TO_CHAR(SYSDATE,'DDTH YYYY'))  FROM tco_company WHERE pk = '" + l_company_pk + "' ";
 
    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
		p_date_frm = dt.Rows[0][3].ToString();
		p_date_to = dt.Rows[0][4].ToString();
		p_cmp_fname = dt.Rows[0][5].ToString();
		p_cmp_fadd = dt.Rows[0][6].ToString();
		p_cmp_fname2 = dt.Rows[0][7].ToString();
		p_rpt_date = dt.Rows[0][8].ToString(); 
    }  
	%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="60110040_files/filelist.xml">
<link rel=Edit-Time-Data href="60110040_files/editdata.mso">
<link rel=OLE-Object-Data href="60110040_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2009-01-09T04:24:50Z</o:LastPrinted>
  <o:Created>2006-10-31T07:47:43Z</o:Created>
  <o:LastSaved>2009-03-05T03:31:46Z</o:LastSaved>
  <o:Company>poslilama</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .25in .5in;
	mso-header-margin:.01in;
	mso-footer-margin:.01in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;
	mso-vertical-page-align:center;}
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
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
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Cash in hand and cash in bank</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>55</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>70</x:Zoom>
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
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9630</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Cash in hand and cash in bank'!$6:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1538 style='border-collapse:
 collapse;table-layout:fixed;width:1152pt'>
 <col class=xl24 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl25 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl28 colspan=2 width=129 style='height:15.95pt;
  mso-ignore:colspan;width:97pt'><%= p_cmp_name %></td>
  
 </tr>
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl26 colspan=2 style='height:15.95pt;mso-ignore:colspan'>Tax
  Code:</td>
  <td class=xl26><%= p_cmp_taxcode %></td>
  <td class=xl27></td>
  <td colspan=12 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=16 height=32 class=xl53 style='height:24.0pt'>CASH ON HAND AND
  CASH IN BANK</td>
 </tr>
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=16 height=21 class=xl54 style='height:15.95pt'>From date <%= p_date_frm %> To date <%= p_date_to %></td>
 </tr>
 <tr class=xl26 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=3 class=xl26 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=7 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl55>Exchange Rate:</td>
  <td class=xl30></td>
 </tr>
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td rowspan=2 height=58 class=xl56 style='border-bottom:.5pt solid black;
  height:43.9pt'>No</td>
  <td colspan=2 class=xl58 style='border-right:.5pt solid black;border-left:
  none'>Bank</td>
  <td rowspan=2 class=xl56 style='border-bottom:.5pt solid black'>Ccy</td>
  <td colspan=3 class=xl58 style='border-right:.5pt solid black;border-left:
  none'>Openning</td>
  <td colspan=3 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Deposit</td>
  <td colspan=3 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Withdrawal</td>
  <td colspan=3 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Closing</td>
 </tr>
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl31 style='height:21.95pt' x:str="Account No  ">Account
  No<span style='mso-spacerun:yes'> &nbsp;</span></td>
  <td class=xl31>Name</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>Book Amount</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>Book Amount</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>Book Amount</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>Book Amount</td>
 </tr>
<%

    SQL = "SELECT  " +
        "    B.PK,B.ACCOUNT_NO, B.BANK_ID,C.PARTNER_NAME, B.CCY, " +
        "     NVL(o_mm_vnd_bal,0) o_mm_vnd_bal,  NVL(o_mm_usd_bal,0) o_mm_usd_bal, NVL(o_mm_book_bal,0) o_mm_book_bal, " +
        "     NVL(dr_vnd_bal,0) dr_vnd_bal, NVL(dr_usd_bal,0) dr_usd_bal, NVL(dr_book_bal,0) dr_book_bal, " +
        "     NVL(cr_vnd_bal,0) cr_vnd_bal, NVL(cr_usd_bal,0) cr_usd_bal, NVL(cr_book_bal,0) cr_book_bal, " +
        "     (NVL(o_mm_vnd_bal,0) + NVL(dr_vnd_bal,0) - NVL(cr_vnd_bal,0)) cl_vnd_bal, " +
        "     (NVL(o_mm_usd_bal,0) + NVL(dr_usd_bal,0) - NVL(cr_usd_bal,0)) cl_usd_bal, " +
        "     (NVL(o_mm_book_bal,0)+ NVL(dr_book_bal,0) - NVL(cr_book_bal,0)) cl_book_bal  " +
        "    FROM " +
        "    ( " +
        "    SELECT TAC_ABDEPOMT_PK, NVL(SUM(NVL(o_mm_vnd_bal,0)),0) o_mm_vnd_bal, NVL(SUM(NVL(o_mm_usd_bal,0)),0) o_mm_usd_bal,  " +
        "    NVL(SUM(NVL(o_mm_book_bal,0)),0) o_mm_book_bal, " +
        "     NVL(SUM(NVL(dr_vnd_bal,0)),0) dr_vnd_bal, NVL(SUM(NVL(dr_usd_bal,0)),0) dr_usd_bal, NVL(SUM(NVL(dr_book_bal,0)),0) dr_book_bal, " +
        "     NVL(SUM(NVL(cr_vnd_bal,0)),0) cr_vnd_bal, NVL(SUM(NVL(cr_usd_bal,0)),0)  cr_usd_bal, NVL(SUM(NVL(cr_book_bal,0)),0) cr_book_bal " +
        "    FROM " +
        "    (  " +
        "    ( " +
        "        SELECT TAC_ABDEPOMT_PK, SUM (o_mm_vnd_bal) o_mm_vnd_bal, SUM(o_mm_usd_bal) o_mm_usd_bal, SUM (o_mm_book_bal) o_mm_book_bal, " +
        "      0 dr_vnd_bal, 0 dr_usd_bal , 0 dr_book_bal, 0 cr_vnd_bal, 0 cr_usd_bal , 0 cr_book_bal " +
        "    FROM " +
        "    (( " +
        "     SELECT  TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0) o_mm_vnd_bal, " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0) o_mm_usd_bal, " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT M.TAC_ABACCTCODE_PK,M.TAC_ABDEPOMT_PK, " +
        "        NVL((SUM(DECODE(M.CCY,'VND',NVL(M.THIS_DRFAMT,0),0))) - SUM(DECODE(M.CCY,'VND',NVL(M.THIS_CRFAMT,0),0)) ,0)  o_mm_vnd_bal, " +
        "        NVL((SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_DRFAMT,0))) - SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_CRFAMT,0))) ),0)  o_mm_usd_bal, " +
        "        NVL((SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0))) ,0)  o_mm_book_bal, " +
        "        TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",M.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPOMMBAL M " +
        "            WHERE M.DEL_IF =0 " +
        "        AND M.TCO_COMPANY_PK = " + l_company_pk + " " +
        "        AND M.TR_STATUS = '" + l_status + "' " +
        "        AND M.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                          /*  AND B.AC_CD IN ('112000','311000')*/ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        "   ))  ) " +
        "        AND (M.STD_YM||'01') = SF_GET_LASTCLOSEMM ('" + l_date_from + "'," + l_company_pk + ") " +
        "        GROUP BY M.TAC_ABACCTCODE_PK, M.TAC_ABDEPOMT_PK " +
        "        ) " +
        "        GROUP BY TAC_ABDEPOMT_PK ) " +
        "        UNION ALL " +
        "       ( " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0)  o_mm_vnd_bal, " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0)  o_mm_usd_bal, " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK, " +
        "         NVL((SUM(DECODE(D.CCY,'VND',NVL(D.YMD_DRTRANS,0),0)) - SUM(DECODE(D.CCY,'VND',NVL(D.YMD_CRTRANS,0),0)) ),0) o_mm_vnd_bal, " +
        "         NVL((SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_DRTRANS,0))) - SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_CRTRANS,0))) ),0) o_mm_usd_bal, " +
        "         NVL((SUM(NVL(D.YMD_DRBOOKS,0)) - SUM(NVL(D.YMD_CRBOOKS,0))),0) o_mm_book_bal, " +
        "         TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPODDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "            AND D.TCO_COMPANY_PK =" + l_company_pk + " " +
        "            AND D.TR_STATUS = '" + l_status + "' " +
        "            AND D.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                           /* AND B.AC_CD IN ('112000','311000') */" +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " + 
        "                    )) " +
        "                   ) " +
        "            AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(SF_GET_LASTCLOSEMM ('" + l_date_from + "'," + l_company_pk + "),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "            AND D.STD_YMD < '" + l_date_from + "' " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK) " +
        "            GROUP BY TAC_ABDEPOMT_PK " +
        "       )  " +
        "       )  " +
        "       GROUP BY TAC_ABDEPOMT_PK " +
        "       ) " +
        "      UNION ALL " +
        "       ( " +
        "       SELECT TAC_ABDEPOMT_PK,0 o_mm_vnd_bal,0 o_mm_usd_bal,0 o_mm_book_bal, " +
        "       dr_vnd_bal, dr_usd_bal, dr_book_bal, cr_vnd_bal, cr_usd_bal, cr_book_bal " +
        "       FROM " +
        "       ( " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(dr_vnd_bal*CRDR),0) dr_vnd_bal,NVL(SUM(dr_usd_bal*CRDR),0) dr_usd_bal, NVL(SUM(dr_book_bal*CRDR),0) dr_book_bal, " +
        "         NVL(SUM(cr_vnd_bal*CRDR),0) cr_vnd_bal, NVL(SUM(cr_usd_bal*CRDR),0) cr_usd_bal, NVL(SUM(cr_book_bal*CRDR),0) cr_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_DRTRANS,0),0)),0) dr_vnd_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_DRTRANS,0))),0) dr_usd_bal, " +
        "            NVL(SUM(NVL(D.YMD_DRBOOKS,0)),0) dr_book_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_CRTRANS,0),0)),0) cr_vnd_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_CRTRANS,0))),0) cr_usd_bal, " +
        "            NVL(SUM(NVL(D.YMD_CRBOOKS,0)),0) cr_book_bal, " +
        "            TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPODDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "            AND D.TCO_COMPANY_PK =" + l_company_pk + " " +
        "            AND D.TR_STATUS = '" + l_status + "' " +
        "            AND D.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                          /* AND B.AC_CD IN ('112000','311000')*/ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        "                    )) " +
        "                   ) " +
        "            AND D.STD_YMD >= '" + l_date_from + "' " +
        "            AND D.STD_YMD <= '" + l_date_to + "' " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK " +
        "            ) " +
        "            GROUP BY TAC_ABDEPOMT_PK " +
        "       ) " +
        "      ) " +
        "      ) " +
        "        GROUP BY TAC_ABDEPOMT_PK " +
        "      ) " +
        "      A,TAC_ABDEPOMT B, TCO_BUSPARTNER C " +
        "      WHERE B.DEL_IF =0   " +  
        "     and   B.PK = A.TAC_ABDEPOMT_PK(+)  AND   b.DEPO_PERIOD is null  and (b.CLOSING_DT >= '" + l_date_to + "'  or b.CLOSING_DT is null )" +
		"     and   ( NVL(o_mm_vnd_bal,0) <> 0 or  NVL(o_mm_usd_bal,0) <> 0 or  NVL(o_mm_book_bal,0) <> 0  " +
        "             or NVL(dr_vnd_bal,0) <> 0 or  NVL(dr_usd_bal,0) <> 0  or  NVL(dr_book_bal,0) <> 0 " +
        "             or  NVL(cr_vnd_bal,0) <> 0 or  NVL(cr_usd_bal,0) <> 0 or  NVL(cr_book_bal,0) <> 0 " +
        "             or  (NVL(o_mm_vnd_bal,0) + NVL(dr_vnd_bal,0) - NVL(cr_vnd_bal,0)) <> 0  " +
        "             or (NVL(o_mm_usd_bal,0) + NVL(dr_usd_bal,0) - NVL(cr_usd_bal,0))  <> 0 " +
        "             or  (NVL(o_mm_book_bal,0)+ NVL(dr_book_bal,0) - NVL(cr_book_bal,0)) <> 0  ) " +
        "      AND B.TCO_BUSPARTNER_PK = C.PK   order by  4,2 ";

    //Response.Write(SQL);
    //Response.End(); 
    
    DataTable dtbank_detail = ESysLib.TableReadOpen(SQL);
    
   
    if (dtbank_detail.Rows.Count > 0)
    {
        for (i = 0; i < dtbank_detail.Rows.Count; i++)
        {
//Response.Write(stt);
    //Response.End(); 
 %> 
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl33 style='height:21.95pt' x:num><%=stt %></td>
  <td class=xl34  x:num><%= dtbank_detail.Rows[i][1].ToString() %></td>
  <td class=xl35><%= dtbank_detail.Rows[i][3].ToString() %></td>
  <td class=xl36><%= dtbank_detail.Rows[i][4].ToString() %></td>
  <td class=xl37 x:num><%= dtbank_detail.Rows[i][5].ToString() %></td>
  <td class=xl38 x:num><%= dtbank_detail.Rows[i][6].ToString() %></td>
  <td class=xl38  x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_detail.Rows[i][7].ToString() %></td>
  <td class=xl37  x:num><%= dtbank_detail.Rows[i][8].ToString() %></td>
  <td class=xl38  x:num><%= dtbank_detail.Rows[i][9].ToString() %></td>
  <td class=xl38  x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_detail.Rows[i][10].ToString() %></td>
  <td class=xl37  x:num><%= dtbank_detail.Rows[i][11].ToString() %></td>
  <td class=xl38  x:num><%= dtbank_detail.Rows[i][12].ToString() %></td>
  <td class=xl38 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_detail.Rows[i][13].ToString() %></td>
  <td class=xl37 x:num><%= dtbank_detail.Rows[i][14].ToString() %></td>
  <td class=xl38  x:num><%= dtbank_detail.Rows[i][15].ToString() %></td>
  <td class=xl38  x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_detail.Rows[i][16].ToString() %></td>
 </tr>
<%
    stt += 1;
    }
    }

    SQL = "SELECT  " +
        "       SUM(NVL (o_mm_vnd_bal, 0)) o_mm_vnd_bal, SUM(NVL (o_mm_usd_bal, 0)) o_mm_usd_bal, " +
        "       SUM(NVL (o_mm_book_bal, 0)) o_mm_book_bal, SUM(NVL (dr_vnd_bal, 0)) dr_vnd_bal, " +
        "       SUM(NVL (dr_usd_bal, 0)) dr_usd_bal, SUM(NVL (dr_book_bal, 0)) dr_book_bal, " +
        "       SUM(NVL (cr_vnd_bal, 0)) cr_vnd_bal, SUM(NVL (cr_usd_bal, 0)) cr_usd_bal, " +
        "       SUM(NVL (cr_book_bal, 0)) cr_book_bal, " +
        "       SUM(NVL (o_mm_vnd_bal, 0) + NVL (dr_vnd_bal, 0) - NVL (cr_vnd_bal, 0)) cl_vnd_bal, " +
        "       SUM(NVL (o_mm_usd_bal, 0) + NVL (dr_usd_bal, 0) - NVL (cr_usd_bal, 0)) cl_usd_bal, " +
        "       SUM(NVL (o_mm_book_bal, 0) + NVL (dr_book_bal, 0) - NVL (cr_book_bal, 0)) cl_book_bal "+
        "    FROM " +
        "    ( " +
        "    SELECT TAC_ABDEPOMT_PK, NVL(SUM(NVL(o_mm_vnd_bal,0)),0) o_mm_vnd_bal, NVL(SUM(NVL(o_mm_usd_bal,0)),0) o_mm_usd_bal,  " +
        "    NVL(SUM(NVL(o_mm_book_bal,0)),0) o_mm_book_bal, " +
        "     NVL(SUM(NVL(dr_vnd_bal,0)),0) dr_vnd_bal, NVL(SUM(NVL(dr_usd_bal,0)),0) dr_usd_bal, NVL(SUM(NVL(dr_book_bal,0)),0) dr_book_bal, " +
        "     NVL(SUM(NVL(cr_vnd_bal,0)),0) cr_vnd_bal, NVL(SUM(NVL(cr_usd_bal,0)),0)  cr_usd_bal, NVL(SUM(NVL(cr_book_bal,0)),0) cr_book_bal " +
        "    FROM " +
        "    (  " +
        "    ( " +
        "        SELECT TAC_ABDEPOMT_PK, SUM (o_mm_vnd_bal) o_mm_vnd_bal, SUM(o_mm_usd_bal) o_mm_usd_bal, SUM (o_mm_book_bal) o_mm_book_bal, " +
        "      0 dr_vnd_bal, 0 dr_usd_bal , 0 dr_book_bal, 0 cr_vnd_bal, 0 cr_usd_bal , 0 cr_book_bal " +
        "    FROM " +
        "    (( " +
        "     SELECT  TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0) o_mm_vnd_bal, " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0) o_mm_usd_bal, " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT M.TAC_ABACCTCODE_PK,M.TAC_ABDEPOMT_PK, " +
        "        NVL((SUM(DECODE(M.CCY,'VND',NVL(M.THIS_DRFAMT,0),0))) - SUM(DECODE(M.CCY,'VND',NVL(M.THIS_CRFAMT,0),0)) ,0)  o_mm_vnd_bal, " +
        "        NVL((SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_DRFAMT,0))) - SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_CRFAMT,0))) ),0)  o_mm_usd_bal, " +
        "        NVL((SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0))) ,0)  o_mm_book_bal, " +
        "        TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",M.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPOMMBAL M " +
        "            WHERE M.DEL_IF =0 " +
        "        AND M.TCO_COMPANY_PK = " + l_company_pk + " " +
        "        AND M.TR_STATUS = '" + l_status + "' " +
        "        AND M.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                         /*   AND B.AC_CD IN ('112000','311000') */ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " + 
        " ))  ) " +
        "        AND (M.STD_YM||'01') = SF_GET_LASTCLOSEMM ('" + l_date_from + "'," + l_company_pk + ") " +
        "        GROUP BY M.TAC_ABACCTCODE_PK, M.TAC_ABDEPOMT_PK " +
        "        ) " +
        "        GROUP BY TAC_ABDEPOMT_PK ) " +
        "        UNION ALL " +
        "       ( " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0)  o_mm_vnd_bal, " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0)  o_mm_usd_bal, " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK, " +
        "         NVL((SUM(DECODE(D.CCY,'VND',NVL(D.YMD_DRTRANS,0),0)) - SUM(DECODE(D.CCY,'VND',NVL(D.YMD_CRTRANS,0),0)) ),0) o_mm_vnd_bal, " +
        "         NVL((SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_DRTRANS,0))) - SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_CRTRANS,0))) ),0) o_mm_usd_bal, " +
        "         NVL((SUM(NVL(D.YMD_DRBOOKS,0)) - SUM(NVL(D.YMD_CRBOOKS,0))),0) o_mm_book_bal, " +
        "         TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPODDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "            AND D.TCO_COMPANY_PK =" + l_company_pk + " " +
        "            AND D.TR_STATUS = '" + l_status + "' " +
        "            AND D.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                          /*  AND B.AC_CD IN ('112000','311000') */" +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " + 
        "                    )) " +
        "                   ) " +
        "            AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(SF_GET_LASTCLOSEMM ('" + l_date_from + "'," + l_company_pk + "),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "            AND D.STD_YMD < '" + l_date_from + "' " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK) " +
        "            GROUP BY TAC_ABDEPOMT_PK " +
        "       )  " +
        "       )  " +
        "       GROUP BY TAC_ABDEPOMT_PK " +
        "       ) " +
        "      UNION ALL " +
        "       ( " +
        "       SELECT TAC_ABDEPOMT_PK,0 o_mm_vnd_bal,0 o_mm_usd_bal,0 o_mm_book_bal, " +
        "       dr_vnd_bal, dr_usd_bal, dr_book_bal, cr_vnd_bal, cr_usd_bal, cr_book_bal " +
        "       FROM " +
        "       ( " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(dr_vnd_bal*CRDR),0) dr_vnd_bal,NVL(SUM(dr_usd_bal*CRDR),0) dr_usd_bal, NVL(SUM(dr_book_bal*CRDR),0) dr_book_bal, " +
        "         NVL(SUM(cr_vnd_bal*CRDR),0) cr_vnd_bal, NVL(SUM(cr_usd_bal*CRDR),0) cr_usd_bal, NVL(SUM(cr_book_bal*CRDR),0) cr_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_DRTRANS,0),0)),0) dr_vnd_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_DRTRANS,0))),0) dr_usd_bal, " +
        "            NVL(SUM(NVL(D.YMD_DRBOOKS,0)),0) dr_book_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_CRTRANS,0),0)),0) cr_vnd_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_CRTRANS,0))),0) cr_usd_bal, " +
        "            NVL(SUM(NVL(D.YMD_CRBOOKS,0)),0) cr_book_bal, " +
        "            TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPODDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "            AND D.TCO_COMPANY_PK =" + l_company_pk + " " +
        "            AND D.TR_STATUS = '" + l_status + "' " +
        "            AND D.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                          /*  AND B.AC_CD IN ('112000','311000') */ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        "                    )) " +
        "                   ) " +
        "            AND D.STD_YMD >= '" + l_date_from + "' " +
        "            AND D.STD_YMD <= '" + l_date_to + "' " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK " +
        "            ) " +
        "            GROUP BY TAC_ABDEPOMT_PK " +
        "       ) " +
        "      ) " +
        "      ) " +
        "        GROUP BY TAC_ABDEPOMT_PK " +
        "      ) " +
        "      A,TAC_ABDEPOMT B " +
        "      WHERE B.DEL_IF =0   AND   b.DEPO_PERIOD is null and (b.CLOSING_DT >= '" + l_date_to + "'  or b.CLOSING_DT is null ) " +
		"       and (  NVL(o_mm_vnd_bal,0) <> 0 or  NVL(o_mm_usd_bal,0) <> 0 or  NVL(o_mm_book_bal,0) <> 0 " +
        "        or  NVL(dr_vnd_bal,0) <> 0 or  NVL(dr_usd_bal,0) <> 0 or  NVL(dr_book_bal,0) <> 0 " +
        "       or  NVL(cr_vnd_bal,0)  <> 0 or  NVL(cr_usd_bal,0) <> 0 or NVL(cr_book_bal,0) <> 0  " +
        "       or  (NVL(o_mm_vnd_bal,0) + NVL(dr_vnd_bal,0) - NVL(cr_vnd_bal,0)) <> 0   " +
        "       or  (NVL(o_mm_usd_bal,0) + NVL(dr_usd_bal,0) - NVL(cr_usd_bal,0)) <> 0  " +
        "       or  (NVL(o_mm_book_bal,0)+ NVL(dr_book_bal,0) - NVL(cr_book_bal,0)) <> 0  " +
        "   )   "+
        "    and  B.PK = A.TAC_ABDEPOMT_PK(+)  " ;
    //Response.Write(SQL);
   // Response.End();
       DataTable dtbank_total = ESysLib.TableReadOpen(SQL);

    if (dtbank_total.Rows.Count > 0)
    {
 %> 
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td colspan=4 height=29 class=xl63 style='height:21.95pt'>I. Demand deposit -
  Sub Total</td>
  <td class=xl49 style='border-left:none' x:num><%= dtbank_total.Rows[0][0].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num><%= dtbank_total.Rows[0][1].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][2].ToString()%></td>
  <td class=xl49 style='border-left:none' x:num><%= dtbank_total.Rows[0][3].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num><%= dtbank_total.Rows[0][4].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][5].ToString()%></td>
  <td class=xl49 style='border-left:none' x:num><%= dtbank_total.Rows[0][6].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num><%= dtbank_total.Rows[0][7].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][8].ToString()%></td>
  <td class=xl49 style='border-left:none' x:num><%= dtbank_total.Rows[0][9].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num><%= dtbank_total.Rows[0][10].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][11].ToString()%></td>
 </tr>
 <%
}
    SQL = "SELECT  " +
        "    B.PK,B.ACCOUNT_NO, B.BANK_ID,C.PARTNER_NAME, B.CCY, " +
        "     NVL(o_mm_vnd_bal,0) o_mm_vnd_bal,  NVL(o_mm_usd_bal,0) o_mm_usd_bal, NVL(o_mm_book_bal,0) o_mm_book_bal, " +
        "     NVL(dr_vnd_bal,0) dr_vnd_bal, NVL(dr_usd_bal,0) dr_usd_bal, NVL(dr_book_bal,0) dr_book_bal, " +
        "     NVL(cr_vnd_bal,0) cr_vnd_bal, NVL(cr_usd_bal,0) cr_usd_bal, NVL(cr_book_bal,0) cr_book_bal, " +
        "     (NVL(o_mm_vnd_bal,0) + NVL(dr_vnd_bal,0) - NVL(cr_vnd_bal,0)) cl_vnd_bal, " +
        "     (NVL(o_mm_usd_bal,0) + NVL(dr_usd_bal,0) - NVL(cr_usd_bal,0)) cl_usd_bal, " +
        "     (NVL(o_mm_book_bal,0)+ NVL(dr_book_bal,0) - NVL(cr_book_bal,0)) cl_book_bal  " +
        "    FROM " +
        "    ( " +
        "    SELECT TAC_ABDEPOMT_PK, NVL(SUM(NVL(o_mm_vnd_bal,0)),0) o_mm_vnd_bal, NVL(SUM(NVL(o_mm_usd_bal,0)),0) o_mm_usd_bal,  " +
        "    NVL(SUM(NVL(o_mm_book_bal,0)),0) o_mm_book_bal, " +
        "     NVL(SUM(NVL(dr_vnd_bal,0)),0) dr_vnd_bal, NVL(SUM(NVL(dr_usd_bal,0)),0) dr_usd_bal, NVL(SUM(NVL(dr_book_bal,0)),0) dr_book_bal, " +
        "     NVL(SUM(NVL(cr_vnd_bal,0)),0) cr_vnd_bal, NVL(SUM(NVL(cr_usd_bal,0)),0)  cr_usd_bal, NVL(SUM(NVL(cr_book_bal,0)),0) cr_book_bal " +
        "    FROM " +
        "    (  " +
        "    ( " +
        "        SELECT TAC_ABDEPOMT_PK, SUM (o_mm_vnd_bal) o_mm_vnd_bal, SUM(o_mm_usd_bal) o_mm_usd_bal, SUM (o_mm_book_bal) o_mm_book_bal, " +
        "      0 dr_vnd_bal, 0 dr_usd_bal , 0 dr_book_bal, 0 cr_vnd_bal, 0 cr_usd_bal , 0 cr_book_bal " +
        "    FROM " +
        "    (( " +
        "     SELECT  TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0) o_mm_vnd_bal, " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0) o_mm_usd_bal, " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT M.TAC_ABACCTCODE_PK,M.TAC_ABDEPOMT_PK, " +
        "        NVL((SUM(DECODE(M.CCY,'VND',NVL(M.THIS_DRFAMT,0),0))) - SUM(DECODE(M.CCY,'VND',NVL(M.THIS_CRFAMT,0),0)) ,0)  o_mm_vnd_bal, " +
        "        NVL((SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_DRFAMT,0))) - SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_CRFAMT,0))) ),0)  o_mm_usd_bal, " +
        "        NVL((SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0))) ,0)  o_mm_book_bal, " +
        "        TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",M.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPOMMBAL M " +
        "            WHERE M.DEL_IF =0 " +
        "        AND M.TCO_COMPANY_PK = " + l_company_pk + " " +
        "        AND M.TR_STATUS = '" + l_status + "' " +
        "        AND M.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                           /* AND B.AC_CD IN ('112000','311000') */  " + 
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        " ))  ) " +
        "        AND (M.STD_YM||'01') = SF_GET_LASTCLOSEMM ('" + l_date_from + "'," + l_company_pk + ") " +
        "        GROUP BY M.TAC_ABACCTCODE_PK, M.TAC_ABDEPOMT_PK " +
        "        ) " +
        "        GROUP BY TAC_ABDEPOMT_PK ) " +
        "        UNION ALL " +
        "       ( " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0)  o_mm_vnd_bal, " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0)  o_mm_usd_bal, " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK, " +
        "         NVL((SUM(DECODE(D.CCY,'VND',NVL(D.YMD_DRTRANS,0),0)) - SUM(DECODE(D.CCY,'VND',NVL(D.YMD_CRTRANS,0),0)) ),0) o_mm_vnd_bal, " +
        "         NVL((SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_DRTRANS,0))) - SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_CRTRANS,0))) ),0) o_mm_usd_bal, " +
        "         NVL((SUM(NVL(D.YMD_DRBOOKS,0)) - SUM(NVL(D.YMD_CRBOOKS,0))),0) o_mm_book_bal, " +
        "         TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPODDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "            AND D.TCO_COMPANY_PK =" + l_company_pk + " " +
        "            AND D.TR_STATUS = '" + l_status + "' " +
        "            AND D.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                           /* AND B.AC_CD IN ('112000','311000') */ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        "                    )) " +
        "                   ) " +
        "            AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(SF_GET_LASTCLOSEMM ('" + l_date_from + "'," + l_company_pk + "),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "            AND D.STD_YMD < '" + l_date_from + "' " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK) " +
        "            GROUP BY TAC_ABDEPOMT_PK " +
        "       )  " +
        "       )  " +
        "       GROUP BY TAC_ABDEPOMT_PK " +
        "       ) " +
        "      UNION ALL " +
        "       ( " +
        "       SELECT TAC_ABDEPOMT_PK,0 o_mm_vnd_bal,0 o_mm_usd_bal,0 o_mm_book_bal, " +
        "       dr_vnd_bal, dr_usd_bal, dr_book_bal, cr_vnd_bal, cr_usd_bal, cr_book_bal " +
        "       FROM " +
        "       ( " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(dr_vnd_bal*CRDR),0) dr_vnd_bal,NVL(SUM(dr_usd_bal*CRDR),0) dr_usd_bal, NVL(SUM(dr_book_bal*CRDR),0) dr_book_bal, " +
        "         NVL(SUM(cr_vnd_bal*CRDR),0) cr_vnd_bal, NVL(SUM(cr_usd_bal*CRDR),0) cr_usd_bal, NVL(SUM(cr_book_bal*CRDR),0) cr_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_DRTRANS,0),0)),0) dr_vnd_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_DRTRANS,0))),0) dr_usd_bal, " +
        "            NVL(SUM(NVL(D.YMD_DRBOOKS,0)),0) dr_book_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_CRTRANS,0),0)),0) cr_vnd_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_CRTRANS,0))),0) cr_usd_bal, " +
        "            NVL(SUM(NVL(D.YMD_CRBOOKS,0)),0) cr_book_bal, " +
        "            TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPODDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "            AND D.TCO_COMPANY_PK =" + l_company_pk + " " +
        "            AND D.TR_STATUS = '" + l_status + "' " +
        "            AND D.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                           /* AND B.AC_CD IN ('112000','311000') */ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        "                    )) " +
        "                   ) " +
        "            AND D.STD_YMD >= '" + l_date_from + "' " +
        "            AND D.STD_YMD <= '" + l_date_to + "' " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK " +
        "            ) " +
        "            GROUP BY TAC_ABDEPOMT_PK " +
        "       ) " +
        "      ) " +
        "      ) " +
        "        GROUP BY TAC_ABDEPOMT_PK " +
        "      ) " +
        "      A,TAC_ABDEPOMT B, TCO_BUSPARTNER C " +
        "      WHERE B.DEL_IF =0    AND " +
        "      B.PK = A.TAC_ABDEPOMT_PK(+) AND   b.DEPO_PERIOD is not null and ( b.CLOSING_DT >= '" + l_date_to + "'  or b.CLOSING_DT is null ) " +
		"   and (  NVL(o_mm_vnd_bal,0) <> 0 or  NVL(o_mm_usd_bal,0) <> 0 or  NVL(o_mm_book_bal,0) <> 0 " +
        "       or  NVL(dr_vnd_bal,0) <> 0 or  NVL(dr_usd_bal,0) <> 0 or  NVL(dr_book_bal,0) <> 0  " +
        "       or  NVL(cr_vnd_bal,0)  <> 0 or  NVL(cr_usd_bal,0) <> 0 or NVL(cr_book_bal,0) <> 0  " +
        "       or  (NVL(o_mm_vnd_bal,0) + NVL(dr_vnd_bal,0) - NVL(cr_vnd_bal,0)) <> 0             " +
        "       or  (NVL(o_mm_usd_bal,0) + NVL(dr_usd_bal,0) - NVL(cr_usd_bal,0)) <> 0             " +
        "       or  (NVL(o_mm_book_bal,0)+ NVL(dr_book_bal,0) - NVL(cr_book_bal,0)) <> 0  )         " +
       "      AND B.TCO_BUSPARTNER_PK = C.PK    order by C.PARTNER_NAME ";
    dtbank_detail = ESysLib.TableReadOpen(SQL);
    if (dtbank_detail.Rows.Count > 0)
    {
        for (i = 0; i < dtbank_detail.Rows.Count; i++)
        {
  %>
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl33 style='height:21.95pt' x:num><%=stt %></td>
  <td class=xl34 x:num><%= dtbank_detail.Rows[i][1].ToString() %></td>
  <td class=xl35><%= dtbank_detail.Rows[i][3].ToString() %></td>
  <td class=xl36><%= dtbank_detail.Rows[i][4].ToString() %></td>
  <td class=xl37 x:num><%= dtbank_detail.Rows[i][5].ToString() %></td>
  <td class=xl38 x:num><%= dtbank_detail.Rows[i][6].ToString() %></td>
  <td class=xl38  x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_detail.Rows[i][7].ToString() %></td>
  <td class=xl37 x:num><%= dtbank_detail.Rows[i][8].ToString() %></td>
  <td class=xl38 x:num><%= dtbank_detail.Rows[i][9].ToString() %></td>
  <td class=xl38 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_detail.Rows[i][10].ToString() %></td>
  <td class=xl37 x:num><%= dtbank_detail.Rows[i][11].ToString() %></td>
  <td class=xl38 x:num><%= dtbank_detail.Rows[i][12].ToString() %></td>
  <td class=xl38x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_detail.Rows[i][13].ToString() %></td>
  <td class=xl37 x:num><%= dtbank_detail.Rows[i][14].ToString() %></td>
  <td class=xl38 x:num><%= dtbank_detail.Rows[i][15].ToString() %></td>
  <td class=xl38 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_detail.Rows[i][16].ToString() %></td>
 </tr>
<%
    stt += 1;
     }
 }
    
    SQL = "SELECT  " +
        "       SUM(NVL (o_mm_vnd_bal, 0)) o_mm_vnd_bal, SUM(NVL (o_mm_usd_bal, 0)) o_mm_usd_bal, " +
        "       SUM(NVL (o_mm_book_bal, 0)) o_mm_book_bal, SUM(NVL (dr_vnd_bal, 0)) dr_vnd_bal, " +
        "       SUM(NVL (dr_usd_bal, 0)) dr_usd_bal, SUM(NVL (dr_book_bal, 0)) dr_book_bal, " +
        "       SUM(NVL (cr_vnd_bal, 0)) cr_vnd_bal, SUM(NVL (cr_usd_bal, 0)) cr_usd_bal, " +
        "       SUM(NVL (cr_book_bal, 0)) cr_book_bal, " +
        "       SUM(NVL (o_mm_vnd_bal, 0) + NVL (dr_vnd_bal, 0) - NVL (cr_vnd_bal, 0)) cl_vnd_bal, " +
        "       SUM(NVL (o_mm_usd_bal, 0) + NVL (dr_usd_bal, 0) - NVL (cr_usd_bal, 0)) cl_usd_bal, " +
        "       SUM(NVL (o_mm_book_bal, 0) + NVL (dr_book_bal, 0) - NVL (cr_book_bal, 0)) cl_book_bal "+
        "    FROM " +
        "    ( " +
        "    SELECT TAC_ABDEPOMT_PK, NVL(SUM(NVL(o_mm_vnd_bal,0)),0) o_mm_vnd_bal, NVL(SUM(NVL(o_mm_usd_bal,0)),0) o_mm_usd_bal,  " +
        "    NVL(SUM(NVL(o_mm_book_bal,0)),0) o_mm_book_bal, " +
        "     NVL(SUM(NVL(dr_vnd_bal,0)),0) dr_vnd_bal, NVL(SUM(NVL(dr_usd_bal,0)),0) dr_usd_bal, NVL(SUM(NVL(dr_book_bal,0)),0) dr_book_bal, " +
        "     NVL(SUM(NVL(cr_vnd_bal,0)),0) cr_vnd_bal, NVL(SUM(NVL(cr_usd_bal,0)),0)  cr_usd_bal, NVL(SUM(NVL(cr_book_bal,0)),0) cr_book_bal " +
        "    FROM " +
        "    (  " +
        "    ( " +
        "        SELECT TAC_ABDEPOMT_PK, SUM (o_mm_vnd_bal) o_mm_vnd_bal, SUM(o_mm_usd_bal) o_mm_usd_bal, SUM (o_mm_book_bal) o_mm_book_bal, " +
        "      0 dr_vnd_bal, 0 dr_usd_bal , 0 dr_book_bal, 0 cr_vnd_bal, 0 cr_usd_bal , 0 cr_book_bal " +
        "    FROM " +
        "    (( " +
        "     SELECT  TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0) o_mm_vnd_bal, " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0) o_mm_usd_bal, " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT M.TAC_ABACCTCODE_PK,M.TAC_ABDEPOMT_PK, " +
        "        NVL((SUM(DECODE(M.CCY,'VND',NVL(M.THIS_DRFAMT,0),0))) - SUM(DECODE(M.CCY,'VND',NVL(M.THIS_CRFAMT,0),0)) ,0)  o_mm_vnd_bal, " +
        "        NVL((SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_DRFAMT,0))) - SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_CRFAMT,0))) ),0)  o_mm_usd_bal, " +
        "        NVL((SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0))) ,0)  o_mm_book_bal, " +
        "        TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",M.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPOMMBAL M " +
        "            WHERE M.DEL_IF =0 " +
        "        AND M.TCO_COMPANY_PK = " + l_company_pk + " " +
        "        AND M.TR_STATUS = '" + l_status + "' " +
        "        AND M.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                             /* AND B.AC_CD IN ('112000','311000')  */ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        "  ))  ) " +
        "        AND (M.STD_YM||'01') = SF_GET_LASTCLOSEMM ('" + l_date_from + "'," + l_company_pk + ") " +
        "        GROUP BY M.TAC_ABACCTCODE_PK, M.TAC_ABDEPOMT_PK " +
        "        ) " +
        "        GROUP BY TAC_ABDEPOMT_PK ) " +
        "        UNION ALL " +
        "       ( " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0)  o_mm_vnd_bal, " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0)  o_mm_usd_bal, " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK, " +
        "         NVL((SUM(DECODE(D.CCY,'VND',NVL(D.YMD_DRTRANS,0),0)) - SUM(DECODE(D.CCY,'VND',NVL(D.YMD_CRTRANS,0),0)) ),0) o_mm_vnd_bal, " +
        "         NVL((SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_DRTRANS,0))) - SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_CRTRANS,0))) ),0) o_mm_usd_bal, " +
        "         NVL((SUM(NVL(D.YMD_DRBOOKS,0)) - SUM(NVL(D.YMD_CRBOOKS,0))),0) o_mm_book_bal, " +
        "         TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPODDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "            AND D.TCO_COMPANY_PK =" + l_company_pk + " " +
        "            AND D.TR_STATUS = '" + l_status + "' " +
        "            AND D.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                           /* AND B.AC_CD IN ('112000','311000') */ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        "                    )) " +
        "                   ) " +
        "            AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(SF_GET_LASTCLOSEMM ('" + l_date_from + "'," + l_company_pk + "),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "            AND D.STD_YMD < '" + l_date_from + "' " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK) " +
        "            GROUP BY TAC_ABDEPOMT_PK " +
        "       )  " +
        "       )  " +
        "       GROUP BY TAC_ABDEPOMT_PK " +
        "       ) " +
        "      UNION ALL " +
        "       ( " +
        "       SELECT TAC_ABDEPOMT_PK,0 o_mm_vnd_bal,0 o_mm_usd_bal,0 o_mm_book_bal, " +
        "       dr_vnd_bal, dr_usd_bal, dr_book_bal, cr_vnd_bal, cr_usd_bal, cr_book_bal " +
        "       FROM " +
        "       ( " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(dr_vnd_bal*CRDR),0) dr_vnd_bal,NVL(SUM(dr_usd_bal*CRDR),0) dr_usd_bal, NVL(SUM(dr_book_bal*CRDR),0) dr_book_bal, " +
        "         NVL(SUM(cr_vnd_bal*CRDR),0) cr_vnd_bal, NVL(SUM(cr_usd_bal*CRDR),0) cr_usd_bal, NVL(SUM(cr_book_bal*CRDR),0) cr_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_DRTRANS,0),0)),0) dr_vnd_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_DRTRANS,0))),0) dr_usd_bal, " +
        "            NVL(SUM(NVL(D.YMD_DRBOOKS,0)),0) dr_book_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_CRTRANS,0),0)),0) cr_vnd_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_CRTRANS,0))),0) cr_usd_bal, " +
        "            NVL(SUM(NVL(D.YMD_CRBOOKS,0)),0) cr_book_bal, " +
        "            TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPODDBAL D " +
        "            WHERE D.DEL_IF =0 " +
        "            AND D.TCO_COMPANY_PK =" + l_company_pk + " " +
        "            AND D.TR_STATUS = '" + l_status + "' " +
        "            AND D.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                          /*  AND B.AC_CD IN ('112000','311000') */ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        "                    )) " +
        "                   ) " +
        "            AND D.STD_YMD >= '" + l_date_from + "' " +
        "            AND D.STD_YMD <= '" + l_date_to + "' " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK " +
        "            ) " +
        "            GROUP BY TAC_ABDEPOMT_PK " +
        "       ) " +
        "      ) " +
        "      ) " +
        "        GROUP BY TAC_ABDEPOMT_PK " +
        "      ) " +
        "      A,TAC_ABDEPOMT B " +
        "      WHERE B.DEL_IF =0   AND  b.DEPO_PERIOD is not null  and (b.CLOSING_DT >= '" + l_date_to + "' or b.CLOSING_DT is null ) " +
        "     and  B.PK = A.TAC_ABDEPOMT_PK(+)  " ;
       dtbank_total = ESysLib.TableReadOpen(SQL);
       if (dtbank_total.Rows.Count > 0)
       {  
 %> 
 
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td colspan=4 height=29 class=xl63 style='height:21.95pt'>II. Time deposit -
  Sub Total</td>
  <td class=xl49 style='border-left:none' x:num><%= dtbank_total.Rows[0][0].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num><%= dtbank_total.Rows[0][1].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][2].ToString()%></td>
  <td class=xl49 style='border-left:none' x:num><%= dtbank_total.Rows[0][3].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num><%= dtbank_total.Rows[0][4].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][5].ToString()%></td>
  <td class=xl49 style='border-left:none' x:num><%= dtbank_total.Rows[0][6].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num><%= dtbank_total.Rows[0][7].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][8].ToString()%></td>
  <td class=xl49 style='border-left:none' x:num><%= dtbank_total.Rows[0][9].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num><%= dtbank_total.Rows[0][10].ToString()%></td>
  <td class=xl50 style='border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][11].ToString()%></td>
 </tr>
<%
    }
     SQL = "SELECT  " +
        "       SUM(NVL (o_mm_vnd_bal, 0)) o_mm_vnd_bal, SUM(NVL (o_mm_usd_bal, 0)) o_mm_usd_bal, " +
        "       SUM(NVL (o_mm_book_bal, 0)) o_mm_book_bal, SUM(NVL (dr_vnd_bal, 0)) dr_vnd_bal, " +
        "       SUM(NVL (dr_usd_bal, 0)) dr_usd_bal, SUM(NVL (dr_book_bal, 0)) dr_book_bal, " +
        "       SUM(NVL (cr_vnd_bal, 0)) cr_vnd_bal, SUM(NVL (cr_usd_bal, 0)) cr_usd_bal, " +
        "       SUM(NVL (cr_book_bal, 0)) cr_book_bal, " +
        "       SUM(NVL (o_mm_vnd_bal, 0) + NVL (dr_vnd_bal, 0) - NVL (cr_vnd_bal, 0)) cl_vnd_bal, " +
        "       SUM(NVL (o_mm_usd_bal, 0) + NVL (dr_usd_bal, 0) - NVL (cr_usd_bal, 0)) cl_usd_bal, " +
        "       SUM(NVL (o_mm_book_bal, 0) + NVL (dr_book_bal, 0) - NVL (cr_book_bal, 0)) cl_book_bal "+
        "    FROM " +
        "    ( " +
        "    SELECT TAC_ABDEPOMT_PK, NVL(SUM(NVL(o_mm_vnd_bal,0)),0) o_mm_vnd_bal, NVL(SUM(NVL(o_mm_usd_bal,0)),0) o_mm_usd_bal,  " +
        "    NVL(SUM(NVL(o_mm_book_bal,0)),0) o_mm_book_bal, " +
        "     NVL(SUM(NVL(dr_vnd_bal,0)),0) dr_vnd_bal, NVL(SUM(NVL(dr_usd_bal,0)),0) dr_usd_bal, NVL(SUM(NVL(dr_book_bal,0)),0) dr_book_bal, " +
        "     NVL(SUM(NVL(cr_vnd_bal,0)),0) cr_vnd_bal, NVL(SUM(NVL(cr_usd_bal,0)),0)  cr_usd_bal, NVL(SUM(NVL(cr_book_bal,0)),0) cr_book_bal " +
        "    FROM " +
        "    (  " +
        "    ( " +
        "        SELECT TAC_ABDEPOMT_PK, SUM (o_mm_vnd_bal) o_mm_vnd_bal, SUM(o_mm_usd_bal) o_mm_usd_bal, SUM (o_mm_book_bal) o_mm_book_bal, " +
        "      0 dr_vnd_bal, 0 dr_usd_bal , 0 dr_book_bal, 0 cr_vnd_bal, 0 cr_usd_bal , 0 cr_book_bal " +
        "    FROM " +
        "    (( " +
        "     SELECT  TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0) o_mm_vnd_bal, " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0) o_mm_usd_bal, " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT M.TAC_ABACCTCODE_PK,M.TAC_ABDEPOMT_PK, " +
        "        NVL((SUM(DECODE(M.CCY,'VND',NVL(M.THIS_DRFAMT,0),0))) - SUM(DECODE(M.CCY,'VND',NVL(M.THIS_CRFAMT,0),0)) ,0)  o_mm_vnd_bal, " +
        "        NVL((SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_DRFAMT,0))) - SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_CRFAMT,0))) ),0)  o_mm_usd_bal, " +
        "        NVL((SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0))) ,0)  o_mm_book_bal, " +
        "        TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",M.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPOMMBAL M " +
        "            WHERE M.DEL_IF =0 " +
        "        AND M.TCO_COMPANY_PK = " + l_company_pk + " " +
        "        AND M.TR_STATUS = '" + l_status + "' " +
        "        AND M.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                           /* AND B.AC_CD IN ('112000','311000') */ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        " ))  ) " +
        "        AND (M.STD_YM||'01') = SF_GET_LASTCLOSEMM ('" + l_date_from + "'," + l_company_pk + ") " +
        "        GROUP BY M.TAC_ABACCTCODE_PK, M.TAC_ABDEPOMT_PK " +
        "        ) " +
        "        GROUP BY TAC_ABDEPOMT_PK ) " +
        "        UNION ALL " +
        "       ( " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0)  o_mm_vnd_bal, " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0)  o_mm_usd_bal, " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK, " +
        "         NVL((SUM(DECODE(D.CCY,'VND',NVL(D.YMD_DRTRANS,0),0)) - SUM(DECODE(D.CCY,'VND',NVL(D.YMD_CRTRANS,0),0)) ),0) o_mm_vnd_bal, " +
        "         NVL((SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_DRTRANS,0))) - SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_CRTRANS,0))) ),0) o_mm_usd_bal, " +
        "         NVL((SUM(NVL(D.YMD_DRBOOKS,0)) - SUM(NVL(D.YMD_CRBOOKS,0))),0) o_mm_book_bal, " +
        "         TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPODDBAL D " +
        "            WHERE D.DEL_IF =0 and   D.TAC_ABDEPOMT_PK in (select pk from TAC_ABDEPOMT where del_if =0 and DEPO_PERIOD is  null)" +
        "            AND D.TCO_COMPANY_PK =" + l_company_pk + " " +
        "            AND D.TR_STATUS = '" + l_status + "' " +
        "            AND D.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                          /*  AND B.AC_CD IN ('112000','311000') */ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        "                    )) " +
        "                   ) " +
        "            AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(SF_GET_LASTCLOSEMM ('" + l_date_from + "'," + l_company_pk + "),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "            AND D.STD_YMD < '" + l_date_from + "' " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK) " +
        "            GROUP BY TAC_ABDEPOMT_PK " +
        "       )  " +
        "       )  " +
        "       GROUP BY TAC_ABDEPOMT_PK " +
        "       ) " +
        "      UNION ALL " +
        "       ( " +
        "       SELECT TAC_ABDEPOMT_PK,0 o_mm_vnd_bal,0 o_mm_usd_bal,0 o_mm_book_bal, " +
        "       dr_vnd_bal, dr_usd_bal, dr_book_bal, cr_vnd_bal, cr_usd_bal, cr_book_bal " +
        "       FROM " +
        "       ( " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(dr_vnd_bal*CRDR),0) dr_vnd_bal,NVL(SUM(dr_usd_bal*CRDR),0) dr_usd_bal, NVL(SUM(dr_book_bal*CRDR),0) dr_book_bal, " +
        "         NVL(SUM(cr_vnd_bal*CRDR),0) cr_vnd_bal, NVL(SUM(cr_usd_bal*CRDR),0) cr_usd_bal, NVL(SUM(cr_book_bal*CRDR),0) cr_book_bal " +
        "        FROM " +
        "        ( " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_DRTRANS,0),0)),0) dr_vnd_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_DRTRANS,0))),0) dr_usd_bal, " +
        "            NVL(SUM(NVL(D.YMD_DRBOOKS,0)),0) dr_book_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_CRTRANS,0),0)),0) cr_vnd_bal, " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_CRTRANS,0))),0) cr_usd_bal, " +
        "            NVL(SUM(NVL(D.YMD_CRBOOKS,0)),0) cr_book_bal, " +
        "            TO_NUMBER(DECODE(SF_GET_DRCRTYPE(" + l_company_pk + ",D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR " +
        "            FROM TAC_HGDEPODDBAL D " +
        "            WHERE D.DEL_IF =0  and   D.TAC_ABDEPOMT_PK in (select pk from TAC_ABDEPOMT where del_if =0 and DEPO_PERIOD is not null)" +
        "            AND D.TCO_COMPANY_PK =" + l_company_pk + " " +
        "            AND D.TR_STATUS = '" + l_status + "' " +
        "            AND D.TAC_ABACCTCODE_PK IN ( " +
        "                SELECT PK " +
        "            FROM TAC_ABACCTCODE A " +
        "                WHERE A.DEL_IF= 0 " +
        "                AND A.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                AND A.LEAF_YN ='Y' " +
        "                CONNECT BY PRIOR PK = PAC_PK  " +
        "                START WITH (PK IN ( " +
        "                    SELECT B.PK " +
        "                        FROM TAC_ABACCTCODE B " +
        "                        WHERE B.DEL_IF= 0 " +
        "                            AND B.TCO_COMPANY_PK = " + l_company_pk + " " +
        "                           /* AND B.AC_CD IN ('112000','311000') */ " +
         "                             AND B.AC_CD IN (  SELECT AC_CODE " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
        "       WHERE D.DEL_IF           = 0  " +
        "         AND H.DEL_IF           = 0 " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK " +
        "       and AC_GRP in ('BANK','LIABILITI'))   " +
        "                    )) " +
        "                   ) " +
        "            AND D.STD_YMD >= '" + l_date_from + "' " +
        "            AND D.STD_YMD <= '" + l_date_to + "' " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK " +
        "            ) " +
        "            GROUP BY TAC_ABDEPOMT_PK " +
        "       ) " +
        "      ) " +
        "      ) " +
        "        GROUP BY TAC_ABDEPOMT_PK " +
        "      ) " +
        "      A ";

     SQL = "  select SUM(NVL (o_mm_vnd_bal, 0)) o_mm_vnd_bal, SUM(NVL (o_mm_usd_bal, 0)) o_mm_usd_bal,  " +
        "       SUM(NVL (o_mm_book_bal, 0)) o_mm_book_bal, SUM(NVL (dr_vnd_bal, 0)) dr_vnd_bal,  " +
        "       SUM(NVL (dr_usd_bal, 0)) dr_usd_bal, SUM(NVL (dr_book_bal, 0)) dr_book_bal,  " +
        "       SUM(NVL (cr_vnd_bal, 0)) cr_vnd_bal, SUM(NVL (cr_usd_bal, 0)) cr_usd_bal,  " +
        "       SUM(NVL (cr_book_bal, 0)) cr_book_bal, " +
        "       SUM(NVL ( cl_vnd_bal, 0))  cl_vnd_bal, " +
        "        SUM(NVL ( cl_usd_bal, 0))  cl_usd_bal, " +
        "         SUM(NVL ( cl_book_bal, 0))  cl_book_bal " +
        " from  ( SELECT   " +
        "       SUM(NVL (o_mm_vnd_bal, 0)) o_mm_vnd_bal, SUM(NVL (o_mm_usd_bal, 0)) o_mm_usd_bal,  " +
        "       SUM(NVL (o_mm_book_bal, 0)) o_mm_book_bal, SUM(NVL (dr_vnd_bal, 0)) dr_vnd_bal,  " +
        "       SUM(NVL (dr_usd_bal, 0)) dr_usd_bal, SUM(NVL (dr_book_bal, 0)) dr_book_bal,  " +
        "       SUM(NVL (cr_vnd_bal, 0)) cr_vnd_bal, SUM(NVL (cr_usd_bal, 0)) cr_usd_bal,  " +
        "       SUM(NVL (cr_book_bal, 0)) cr_book_bal,  " +
        "       SUM(NVL (o_mm_vnd_bal, 0) + NVL (dr_vnd_bal, 0) - NVL (cr_vnd_bal, 0)) cl_vnd_bal,  " +
        "       SUM(NVL (o_mm_usd_bal, 0) + NVL (dr_usd_bal, 0) - NVL (cr_usd_bal, 0)) cl_usd_bal,  " +
        "       SUM(NVL (o_mm_book_bal, 0) + NVL (dr_book_bal, 0) - NVL (cr_book_bal, 0)) cl_book_bal  " +
        "    FROM  " +
        "    (  " +
        "    SELECT TAC_ABDEPOMT_PK, NVL(SUM(NVL(o_mm_vnd_bal,0)),0) o_mm_vnd_bal, NVL(SUM(NVL(o_mm_usd_bal,0)),0) o_mm_usd_bal,   " +
        "    NVL(SUM(NVL(o_mm_book_bal,0)),0) o_mm_book_bal,  " +
        "     NVL(SUM(NVL(dr_vnd_bal,0)),0) dr_vnd_bal, NVL(SUM(NVL(dr_usd_bal,0)),0) dr_usd_bal, NVL(SUM(NVL(dr_book_bal,0)),0) dr_book_bal,  " +
        "     NVL(SUM(NVL(cr_vnd_bal,0)),0) cr_vnd_bal, NVL(SUM(NVL(cr_usd_bal,0)),0)  cr_usd_bal, NVL(SUM(NVL(cr_book_bal,0)),0) cr_book_bal  " +
        "    FROM  " +
        "    (   " +
        "    (  " +
        "        SELECT TAC_ABDEPOMT_PK, SUM (o_mm_vnd_bal) o_mm_vnd_bal, SUM(o_mm_usd_bal) o_mm_usd_bal, SUM (o_mm_book_bal) o_mm_book_bal,  " +
        "      0 dr_vnd_bal, 0 dr_usd_bal , 0 dr_book_bal, 0 cr_vnd_bal, 0 cr_usd_bal , 0 cr_book_bal  " +
        "    FROM  " +
        "    ((  " +
        "     SELECT  TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0) o_mm_vnd_bal,  " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0) o_mm_usd_bal,  " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal  " +
        "        FROM  " +
        "        (  " +
        "        SELECT M.TAC_ABACCTCODE_PK,M.TAC_ABDEPOMT_PK,  " +
        "        NVL((SUM(DECODE(M.CCY,'VND',NVL(M.THIS_DRFAMT,0),0))) - SUM(DECODE(M.CCY,'VND',NVL(M.THIS_CRFAMT,0),0)) ,0)  o_mm_vnd_bal,  " +
        "        NVL((SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_DRFAMT,0))) - SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_CRFAMT,0))) ),0)  o_mm_usd_bal,  " +
        "        NVL((SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0))) ,0)  o_mm_book_bal,  " +
        "        TO_NUMBER(DECODE(SF_GET_DRCRTYPE( " + l_company_pk + " ,M.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR  " +
        "            FROM TAC_HGDEPOMMBAL M  " +
        "            WHERE M.DEL_IF =0  " +
        "        AND M.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "        AND M.TR_STATUS = '" + l_status + "'  " +
        "        AND M.TAC_ABACCTCODE_PK IN (  " +
        "                SELECT PK  " +
        "            FROM TAC_ABACCTCODE A  " +
        "                WHERE A.DEL_IF= 0  " +
        "                AND A.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                AND A.LEAF_YN ='Y'  " +
        "                CONNECT BY PRIOR PK = PAC_PK   " +
        "                START WITH (PK IN (  " +
        "                    SELECT B.PK  " +
        "                        FROM TAC_ABACCTCODE B  " +
        "                        WHERE B.DEL_IF= 0  " +
        "                            AND B.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                             /* AND B.AC_CD IN ('112000','311000')  */  " +
        "                             AND B.AC_CD IN (  SELECT AC_CODE  " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H  " +
        "       WHERE D.DEL_IF           = 0   " +
        "         AND H.DEL_IF           = 0  " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK  " +
        "       and AC_GRP in ('BANK','LIABILITI'))    " +
        "  ))  )  " +
        "        AND (M.STD_YM||'01') = SF_GET_LASTCLOSEMM ('" + l_date_from + "', " + l_company_pk + " )  " +
        "        GROUP BY M.TAC_ABACCTCODE_PK, M.TAC_ABDEPOMT_PK  " +
        "        )  " +
        "        GROUP BY TAC_ABDEPOMT_PK )  " +
        "        UNION ALL  " +
        "       (  " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0)  o_mm_vnd_bal,  " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0)  o_mm_usd_bal,  " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal  " +
        "        FROM  " +
        "        (  " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK,  " +
        "         NVL((SUM(DECODE(D.CCY,'VND',NVL(D.YMD_DRTRANS,0),0)) - SUM(DECODE(D.CCY,'VND',NVL(D.YMD_CRTRANS,0),0)) ),0) o_mm_vnd_bal,  " +
        "         NVL((SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_DRTRANS,0))) - SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_CRTRANS,0))) ),0) o_mm_usd_bal,  " +
        "         NVL((SUM(NVL(D.YMD_DRBOOKS,0)) - SUM(NVL(D.YMD_CRBOOKS,0))),0) o_mm_book_bal,  " +
        "         TO_NUMBER(DECODE(SF_GET_DRCRTYPE( " + l_company_pk + " ,D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR  " +
        "            FROM TAC_HGDEPODDBAL D  " +
        "            WHERE D.DEL_IF =0  " +
        "            AND D.TCO_COMPANY_PK = " + l_company_pk + "   " +
        "            AND D.TR_STATUS = '" + l_status + "'  " +
        "            AND D.TAC_ABACCTCODE_PK IN (  " +
        "                SELECT PK  " +
        "            FROM TAC_ABACCTCODE A  " +
        "                WHERE A.DEL_IF= 0  " +
        "                AND A.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                AND A.LEAF_YN ='Y'  " +
        "                CONNECT BY PRIOR PK = PAC_PK   " +
        "                START WITH (PK IN (  " +
        "                    SELECT B.PK  " +
        "                        FROM TAC_ABACCTCODE B  " +
        "                        WHERE B.DEL_IF= 0  " +
        "                            AND B.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                           /* AND B.AC_CD IN ('112000','311000') */  " +
        "                             AND B.AC_CD IN (  SELECT AC_CODE  " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H  " +
        "       WHERE D.DEL_IF           = 0   " +
        "         AND H.DEL_IF           = 0  " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK  " +
        "       and AC_GRP in ('BANK','LIABILITI'))    " +
        "                    ))  " +
        "                   )  " +
        "            AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(SF_GET_LASTCLOSEMM ('" + l_date_from + "', " + l_company_pk + " ),'YYYYMMDD'),+1),'YYYYMMDD')  " +
        "            AND D.STD_YMD < '" + l_date_from + "'  " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK)  " +
        "            GROUP BY TAC_ABDEPOMT_PK  " +
        "       )   " +
        "       )   " +
        "       GROUP BY TAC_ABDEPOMT_PK  " +
        "       )  " +
        "      UNION ALL  " +
        "       (  " +
        "       SELECT TAC_ABDEPOMT_PK,0 o_mm_vnd_bal,0 o_mm_usd_bal,0 o_mm_book_bal,  " +
        "       dr_vnd_bal, dr_usd_bal, dr_book_bal, cr_vnd_bal, cr_usd_bal, cr_book_bal  " +
        "       FROM  " +
        "       (  " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(dr_vnd_bal*CRDR),0) dr_vnd_bal,NVL(SUM(dr_usd_bal*CRDR),0) dr_usd_bal, NVL(SUM(dr_book_bal*CRDR),0) dr_book_bal,  " +
        "         NVL(SUM(cr_vnd_bal*CRDR),0) cr_vnd_bal, NVL(SUM(cr_usd_bal*CRDR),0) cr_usd_bal, NVL(SUM(cr_book_bal*CRDR),0) cr_book_bal  " +
        "        FROM  " +
        "        (  " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK,  " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_DRTRANS,0),0)),0) dr_vnd_bal,  " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_DRTRANS,0))),0) dr_usd_bal,  " +
        "            NVL(SUM(NVL(D.YMD_DRBOOKS,0)),0) dr_book_bal,  " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_CRTRANS,0),0)),0) cr_vnd_bal,  " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_CRTRANS,0))),0) cr_usd_bal,  " +
        "            NVL(SUM(NVL(D.YMD_CRBOOKS,0)),0) cr_book_bal,  " +
        "            TO_NUMBER(DECODE(SF_GET_DRCRTYPE( " + l_company_pk + " ,D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR  " +
        "            FROM TAC_HGDEPODDBAL D  " +
        "            WHERE D.DEL_IF =0  " +
        "            AND D.TCO_COMPANY_PK = " + l_company_pk + "   " +
        "            AND D.TR_STATUS = '" + l_status + "'  " +
        "            AND D.TAC_ABACCTCODE_PK IN (  " +
        "                SELECT PK  " +
        "            FROM TAC_ABACCTCODE A  " +
        "                WHERE A.DEL_IF= 0  " +
        "                AND A.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                AND A.LEAF_YN ='Y'  " +
        "                CONNECT BY PRIOR PK = PAC_PK   " +
        "                START WITH (PK IN (  " +
        "                    SELECT B.PK  " +
        "                        FROM TAC_ABACCTCODE B  " +
        "                        WHERE B.DEL_IF= 0  " +
        "                            AND B.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                          /*  AND B.AC_CD IN ('112000','311000') */  " +
        "                             AND B.AC_CD IN (  SELECT AC_CODE  " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H  " +
        "       WHERE D.DEL_IF           = 0   " +
        "         AND H.DEL_IF           = 0  " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK  " +
        "       and AC_GRP in ('BANK','LIABILITI'))    " +
        "                    ))  " +
        "                   )  " +
        "            AND D.STD_YMD >= '" + l_date_from + "'  " +
        "            AND D.STD_YMD <= '" + l_date_to + "'  " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK  " +
        "            )  " +
        "            GROUP BY TAC_ABDEPOMT_PK  " +
        "       )  " +
        "      )  " +
        "      )  " +
        "        GROUP BY TAC_ABDEPOMT_PK  " +
        "      )  " +
        "      A,TAC_ABDEPOMT B  " +
        "      WHERE B.DEL_IF =0 AND    b.DEPO_PERIOD is not null  and (b.CLOSING_DT >= '" + l_date_to + "' or b.CLOSING_DT is null ) " +
        "      and  B.PK = A.TAC_ABDEPOMT_PK(+)   " +
        "       " +
        "      union " +
        "       " +
        "     SELECT   " +
        "       SUM(NVL (o_mm_vnd_bal, 0)) o_mm_vnd_bal, SUM(NVL (o_mm_usd_bal, 0)) o_mm_usd_bal,  " +
        "       SUM(NVL (o_mm_book_bal, 0)) o_mm_book_bal, SUM(NVL (dr_vnd_bal, 0)) dr_vnd_bal,  " +
        "       SUM(NVL (dr_usd_bal, 0)) dr_usd_bal, SUM(NVL (dr_book_bal, 0)) dr_book_bal,  " +
        "       SUM(NVL (cr_vnd_bal, 0)) cr_vnd_bal, SUM(NVL (cr_usd_bal, 0)) cr_usd_bal,  " +
        "       SUM(NVL (cr_book_bal, 0)) cr_book_bal,  " +
        "       SUM(NVL (o_mm_vnd_bal, 0) + NVL (dr_vnd_bal, 0) - NVL (cr_vnd_bal, 0)) cl_vnd_bal,  " +
        "       SUM(NVL (o_mm_usd_bal, 0) + NVL (dr_usd_bal, 0) - NVL (cr_usd_bal, 0)) cl_usd_bal,  " +
        "       SUM(NVL (o_mm_book_bal, 0) + NVL (dr_book_bal, 0) - NVL (cr_book_bal, 0)) cl_book_bal  " +
        "    FROM  " +
        "    (  " +
        "    SELECT TAC_ABDEPOMT_PK, NVL(SUM(NVL(o_mm_vnd_bal,0)),0) o_mm_vnd_bal, NVL(SUM(NVL(o_mm_usd_bal,0)),0) o_mm_usd_bal,   " +
        "    NVL(SUM(NVL(o_mm_book_bal,0)),0) o_mm_book_bal,  " +
        "     NVL(SUM(NVL(dr_vnd_bal,0)),0) dr_vnd_bal, NVL(SUM(NVL(dr_usd_bal,0)),0) dr_usd_bal, NVL(SUM(NVL(dr_book_bal,0)),0) dr_book_bal,  " +
        "     NVL(SUM(NVL(cr_vnd_bal,0)),0) cr_vnd_bal, NVL(SUM(NVL(cr_usd_bal,0)),0)  cr_usd_bal, NVL(SUM(NVL(cr_book_bal,0)),0) cr_book_bal  " +
        "    FROM  " +
        "    (   " +
        "    (  " +
        "        SELECT TAC_ABDEPOMT_PK, SUM (o_mm_vnd_bal) o_mm_vnd_bal, SUM(o_mm_usd_bal) o_mm_usd_bal, SUM (o_mm_book_bal) o_mm_book_bal,  " +
        "      0 dr_vnd_bal, 0 dr_usd_bal , 0 dr_book_bal, 0 cr_vnd_bal, 0 cr_usd_bal , 0 cr_book_bal  " +
        "    FROM  " +
        "    ((  " +
        "     SELECT  TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0) o_mm_vnd_bal,  " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0) o_mm_usd_bal,  " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal  " +
        "        FROM  " +
        "        (  " +
        "        SELECT M.TAC_ABACCTCODE_PK,M.TAC_ABDEPOMT_PK,  " +
        "        NVL((SUM(DECODE(M.CCY,'VND',NVL(M.THIS_DRFAMT,0),0))) - SUM(DECODE(M.CCY,'VND',NVL(M.THIS_CRFAMT,0),0)) ,0)  o_mm_vnd_bal,  " +
        "        NVL((SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_DRFAMT,0))) - SUM(DECODE(M.CCY,'VND',0,NVL(M.THIS_CRFAMT,0))) ),0)  o_mm_usd_bal,  " +
        "        NVL((SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0))) ,0)  o_mm_book_bal,  " +
        "        TO_NUMBER(DECODE(SF_GET_DRCRTYPE( " + l_company_pk + " ,M.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR  " +
        "            FROM TAC_HGDEPOMMBAL M  " +
        "            WHERE M.DEL_IF =0  " +
        "        AND M.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "        AND M.TR_STATUS = '" + l_status + "'  " +
        "        AND M.TAC_ABACCTCODE_PK IN (  " +
        "                SELECT PK  " +
        "            FROM TAC_ABACCTCODE A  " +
        "                WHERE A.DEL_IF= 0  " +
        "                AND A.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                AND A.LEAF_YN ='Y'  " +
        "                CONNECT BY PRIOR PK = PAC_PK   " +
        "                START WITH (PK IN (  " +
        "                    SELECT B.PK  " +
        "                        FROM TAC_ABACCTCODE B  " +
        "                        WHERE B.DEL_IF= 0  " +
        "                            AND B.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                             /* AND B.AC_CD IN ('112000','311000')  */  " +
        "                             AND B.AC_CD IN (  SELECT AC_CODE  " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H  " +
        "       WHERE D.DEL_IF           = 0   " +
        "         AND H.DEL_IF           = 0  " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK  " +
        "       and AC_GRP in ('BANK','LIABILITI'))    " +
        "  ))  )  " +
        "        AND (M.STD_YM||'01') = SF_GET_LASTCLOSEMM ('" + l_date_from + "', " + l_company_pk + " )  " +
        "        GROUP BY M.TAC_ABACCTCODE_PK, M.TAC_ABDEPOMT_PK  " +
        "        )  " +
        "        GROUP BY TAC_ABDEPOMT_PK )  " +
        "        UNION ALL  " +
        "       (  " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(o_mm_vnd_bal*CRDR),0)  o_mm_vnd_bal,  " +
        "        NVL(SUM(o_mm_usd_bal*CRDR),0)  o_mm_usd_bal,  " +
        "        NVL(SUM(o_mm_book_bal*CRDR),0) o_mm_book_bal  " +
        "        FROM  " +
        "        (  " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK,  " +
        "         NVL((SUM(DECODE(D.CCY,'VND',NVL(D.YMD_DRTRANS,0),0)) - SUM(DECODE(D.CCY,'VND',NVL(D.YMD_CRTRANS,0),0)) ),0) o_mm_vnd_bal,  " +
        "         NVL((SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_DRTRANS,0))) - SUM(DECODE(D.CCY,'VND',0,NVL(D.YMD_CRTRANS,0))) ),0) o_mm_usd_bal,  " +
        "         NVL((SUM(NVL(D.YMD_DRBOOKS,0)) - SUM(NVL(D.YMD_CRBOOKS,0))),0) o_mm_book_bal,  " +
        "         TO_NUMBER(DECODE(SF_GET_DRCRTYPE( " + l_company_pk + " ,D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR  " +
        "            FROM TAC_HGDEPODDBAL D  " +
        "            WHERE D.DEL_IF =0  " +
        "            AND D.TCO_COMPANY_PK = " + l_company_pk + "   " +
        "            AND D.TR_STATUS = '" + l_status + "'  " +
        "            AND D.TAC_ABACCTCODE_PK IN (  " +
        "                SELECT PK  " +
        "            FROM TAC_ABACCTCODE A  " +
        "                WHERE A.DEL_IF= 0  " +
        "                AND A.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                AND A.LEAF_YN ='Y'  " +
        "                CONNECT BY PRIOR PK = PAC_PK   " +
        "                START WITH (PK IN (  " +
        "                    SELECT B.PK  " +
        "                        FROM TAC_ABACCTCODE B  " +
        "                        WHERE B.DEL_IF= 0  " +
        "                            AND B.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                           /* AND B.AC_CD IN ('112000','311000') */  " +
        "                             AND B.AC_CD IN (  SELECT AC_CODE  " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H  " +
        "       WHERE D.DEL_IF           = 0   " +
        "         AND H.DEL_IF           = 0  " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK  " +
        "       and AC_GRP in ('BANK','LIABILITI'))    " +
        "                    ))  " +
        "                   )  " +
        "            AND D.STD_YMD >= TO_CHAR(ADD_MONTHS(TO_DATE(SF_GET_LASTCLOSEMM ('" + l_date_from + "', " + l_company_pk + " ),'YYYYMMDD'),+1),'YYYYMMDD')  " +
        "            AND D.STD_YMD < '" + l_date_from + "'  " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK)  " +
        "            GROUP BY TAC_ABDEPOMT_PK  " +
        "       )   " +
        "       )   " +
        "       GROUP BY TAC_ABDEPOMT_PK  " +
        "       )  " +
        "      UNION ALL  " +
        "       (  " +
        "       SELECT TAC_ABDEPOMT_PK,0 o_mm_vnd_bal,0 o_mm_usd_bal,0 o_mm_book_bal,  " +
        "       dr_vnd_bal, dr_usd_bal, dr_book_bal, cr_vnd_bal, cr_usd_bal, cr_book_bal  " +
        "       FROM  " +
        "       (  " +
        "        SELECT TAC_ABDEPOMT_PK, NVL(SUM(dr_vnd_bal*CRDR),0) dr_vnd_bal,NVL(SUM(dr_usd_bal*CRDR),0) dr_usd_bal, NVL(SUM(dr_book_bal*CRDR),0) dr_book_bal,  " +
        "         NVL(SUM(cr_vnd_bal*CRDR),0) cr_vnd_bal, NVL(SUM(cr_usd_bal*CRDR),0) cr_usd_bal, NVL(SUM(cr_book_bal*CRDR),0) cr_book_bal  " +
        "        FROM  " +
        "        (  " +
        "        SELECT D.TAC_ABACCTCODE_PK,D.TAC_ABDEPOMT_PK,  " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_DRTRANS,0),0)),0) dr_vnd_bal,  " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_DRTRANS,0))),0) dr_usd_bal,  " +
        "            NVL(SUM(NVL(D.YMD_DRBOOKS,0)),0) dr_book_bal,  " +
        "            NVL(SUM(DECODE(D.CCY,'VND',NVL(YMD_CRTRANS,0),0)),0) cr_vnd_bal,  " +
        "            NVL(SUM(DECODE(D.CCY,'VND',0,NVL(YMD_CRTRANS,0))),0) cr_usd_bal,  " +
        "            NVL(SUM(NVL(D.YMD_CRBOOKS,0)),0) cr_book_bal,  " +
        "            TO_NUMBER(DECODE(SF_GET_DRCRTYPE( " + l_company_pk + " ,D.TAC_ABACCTCODE_PK),'C','-1','1')) CRDR  " +
        "            FROM TAC_HGDEPODDBAL D  " +
        "            WHERE D.DEL_IF =0  " +
        "            AND D.TCO_COMPANY_PK = " + l_company_pk + "   " +
        "            AND D.TR_STATUS = '" + l_status + "'  " +
        "            AND D.TAC_ABACCTCODE_PK IN (  " +
        "                SELECT PK  " +
        "            FROM TAC_ABACCTCODE A  " +
        "                WHERE A.DEL_IF= 0  " +
        "                AND A.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                AND A.LEAF_YN ='Y'  " +
        "                CONNECT BY PRIOR PK = PAC_PK   " +
        "                START WITH (PK IN (  " +
        "                    SELECT B.PK  " +
        "                        FROM TAC_ABACCTCODE B  " +
        "                        WHERE B.DEL_IF= 0  " +
        "                            AND B.TCO_COMPANY_PK =  " + l_company_pk + "   " +
        "                          /*  AND B.AC_CD IN ('112000','311000') */  " +
        "                             AND B.AC_CD IN (  SELECT AC_CODE  " +
        "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H  " +
        "       WHERE D.DEL_IF           = 0   " +
        "         AND H.DEL_IF           = 0  " +
        "         AND D.TAC_ABTRACGRP_PK = H.PK  " +
        "       and AC_GRP in ('BANK','LIABILITI'))    " +
        "                    ))  " +
        "                   )  " +
        "            AND D.STD_YMD >= '" + l_date_from + "'  " +
        "            AND D.STD_YMD <= '" + l_date_to + "'  " +
        "            GROUP BY D.TAC_ABACCTCODE_PK, D.TAC_ABDEPOMT_PK  " +
        "            )  " +
        "            GROUP BY TAC_ABDEPOMT_PK  " +
        "       )  " +
        "      )  " +
        "      )  " +
        "        GROUP BY TAC_ABDEPOMT_PK  " +
        "      )  " +
        "      A,TAC_ABDEPOMT B  " +
        "      WHERE B.DEL_IF =0    AND  b.DEPO_PERIOD is  null  and (b.CLOSING_DT >= '" + l_date_to + "' or b.CLOSING_DT is null )  " +
        "      and B.PK = A.TAC_ABDEPOMT_PK(+)  ) ";
    
    // Response.Write(SQL);
    // Response.End();
       dtbank_total = ESysLib.TableReadOpen(SQL);
       if (dtbank_total.Rows.Count > 0)
       {  
 %> 
 <tr class=xl26 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=4 height=33 class=xl64 style='height:24.95pt'>Grand Total</td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%= dtbank_total.Rows[0][0].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';" ><%= dtbank_total.Rows[0][1].ToString()%></td>
  <td class=xl50 style='border-top:none;border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][2].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%= dtbank_total.Rows[0][3].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';" ><%= dtbank_total.Rows[0][4].ToString()%></td>
  <td class=xl50 style='border-top:none;border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][5].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num><%= dtbank_total.Rows[0][6].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';" ><%= dtbank_total.Rows[0][7].ToString()%></td>
  <td class=xl50 style='border-top:none;border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][8].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none'  x:num><%= dtbank_total.Rows[0][9].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';" ><%= dtbank_total.Rows[0][10].ToString()%></td>
  <td class=xl50 style='border-top:none;border-left:none' x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtbank_total.Rows[0][11].ToString()%></td>
 </tr>
<%
}
 %> 
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl51 style='height:15.95pt'>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=7 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl65>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td rowspan=2 height=58 class=xl56 style='border-bottom:.5pt solid black;
  height:43.9pt'>No</td>
  <td colspan=2 class=xl58 style='border-right:.5pt solid black;border-left:
  none'>Account</td>
  <td rowspan=2 class=xl56 style='border-bottom:.5pt solid black'>Ccy</td>
  <td colspan=3 class=xl58 style='border-right:.5pt solid black;border-left:
  none'>Openning</td>
  <td colspan=3 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Debit</td>
  <td colspan=3 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Credit</td>
  <td colspan=3 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Closing</td>
 </tr>
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl31 style='height:21.95pt'>Code</td>
  <td class=xl31>Name</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>Book Amount</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>Book Amount</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>Book Amount</td>
  <td class=xl32>VND</td>
  <td class=xl32>USD</td>
  <td class=xl32>Book Amount</td>
 </tr>
<%
    SQL = "SELECT B.PK,MAX(B.AC_CD) AC_CD, max(B.AC_NM) AC_NM, B.ccy, SUM(Open_vnd) Open_vnd, SUM(open_usd) open_usd, SUM(open_book) open_book, " +
           "                SUM(DR_VND) DR_VND,SUM(DR_USD) DR_USD,SUM(DR_BOOK) DR_BOOK,SUM(CR_VND) CR_VND,SUM(CR_USD) CR_USD, " +
           "                SUM(CR_BOOK) CR_BOOK,  " +
           "                (SUM(Open_vnd) + SUM(DR_VND) - SUM(CR_VND)) CLOSE_VND, " +
           "                (SUM(open_usd) + SUM(DR_USD) - SUM(CR_USD)) CLOSE_USD, " +
           "                (SUM(open_book) + SUM(DR_BOOK) - SUM(CR_BOOK)) CLOSE_BOOK   " +
           "   FROM " +
           "   ( " +
           "      SELECT   tac_abacctcode_pk, ccy,0 Open_vnd, 0 open_usd, 0 open_book, " +
           "                         SUM(DECODE(a.CCY,'VND',NVL(ymd_drtrans,0),0)) DR_VND, " +
           "                         SUM(DECODE(A.CCY,'VND',0,NVL(ymd_drtrans,0))) DR_USD, " +
           "                         SUM (NVL (ymd_drbooks, 0)) DR_BOOK, " +
           "                         SUM(DECODE(a.CCY,'VND',NVL(ymd_crtrans,0),0)) CR_VND, " +
           "                         SUM(DECODE(A.CCY,'VND',0,NVL(ymd_crtrans,0))) CR_USD, " +
           "                         SUM (NVL (ymd_crbooks, 0)) CR_BOOK " +
           "                    FROM TAC_HGDDBAL a " +
           "                   WHERE a.del_if = 0 " +
           "                     AND a.tco_company_pk = " + l_company_pk +
           "                     AND a.tac_abacctcode_pk in  " +
           "                        ( " +
           "                            SELECT PK  " +
           "                            FROM TAC_ABACCTCODE A  " +
           "                            WHERE A.DEL_IF= 0  " +
           "                            AND A.TCO_COMPANY_PK =  " + l_company_pk +
           "                            AND A.LEAF_YN ='Y'  " +
           "                            CONNECT BY PRIOR PK = PAC_PK   " +
           "                            START WITH (PK IN (  " +
           "                                SELECT B.PK  " +
           "                                    FROM TAC_ABACCTCODE B  " +
           "                                    WHERE B.DEL_IF= 0  " +
           "                                        AND B.TCO_COMPANY_PK =  " + l_company_pk +
           "                                        /* AND B.AC_CD IN ('111100','111200','113000') */ " +
		   "                             AND B.AC_CD IN (  SELECT AC_CODE " +
		   "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
		   "       WHERE D.DEL_IF           = 0  " +
		   "         AND H.DEL_IF           = 0 " +
		   "         AND D.TAC_ABTRACGRP_PK = H.PK " +
		   "       and AC_GRP in ('CASH'))   " +
		   "		)) " +
           "                        ) " +
           "                     AND a.tr_status = '" + l_status + "' " +
           "                     AND a.std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "' " +
           "                GROUP BY tac_abacctcode_pk, ccy " +
           "                UNION ALL " +
           "                SELECT tac_abacctcode_pk, CCY, SUM(OPEN_VND) OPEN_VND, SUM(OPEN_USD) OPEN_USD, SUM(OPEN_BOOK) OPEN_BOOK, " +
           "                    0 DR_VND,0 DR_USD,0 DR_BOOK,0 CR_VND,0 CR_USD,0 CR_BOOK " +
           "                FROM( " +
           "                SELECT tac_abacctcode_pk, CCY, " +
           "                        DECODE(CCY,'VND',NVL((SUM (NVL(this_drfbal,0)) - SUM (NVL(this_crfbal,0))),0),0) OPEN_VND, " +
           "                        DECODE(CCY,'VND',0,NVL((SUM (NVL(this_drfbal,0)) - SUM (NVL(this_crfbal,0))),0)) OPEN_USD, " +
           "                        SUM(NVL(THIS_DRBAL,0) - NVL(THIS_CRBAL,0)) OPEN_BOOK " +
           "                     FROM TAC_HGMMBAL " +
           "                     WHERE del_if = 0 " +
           "                           AND tco_company_pk = " + l_company_pk +
           "                           AND tac_abacctcode_pk in  " +
           "                        ( " +
           "                            SELECT PK  " +
           "                            FROM TAC_ABACCTCODE A  " +
           "                            WHERE A.DEL_IF= 0  " +
           "                            AND A.TCO_COMPANY_PK =  " + l_company_pk +
           "                            AND A.LEAF_YN ='Y'  " +
           "                            CONNECT BY PRIOR PK = PAC_PK   " +
           "                            START WITH (PK IN (  " +
           "                                SELECT B.PK  " +
           "                                    FROM TAC_ABACCTCODE B  " +
           "                                    WHERE B.DEL_IF= 0  " +
           "                                        AND B.TCO_COMPANY_PK =  " + l_company_pk +
           "                                        /* AND B.AC_CD IN ('111100','111200','113000') */ " +
		   "                             AND B.AC_CD IN (  SELECT AC_CODE " +
		   "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
		   "       WHERE D.DEL_IF           = 0  " +
		   "         AND H.DEL_IF           = 0 " +
		   "         AND D.TAC_ABTRACGRP_PK = H.PK " +
		   "       and AC_GRP in ('CASH'))   " +
		   "		)) " +
           "                        ) " +
           "                           AND tr_status = '" + l_status + "' " +
           "                           AND std_ym = SUBSTR (Sf_Get_Lastclosemm ('" + l_date_from + "','" + l_company_pk + "'),1,6) " +
           "                           GROUP BY tac_abacctcode_pk, CCY " +
           "                       UNION ALL " +
           "                       SELECT tac_abacctcode_pk,CCY, " +
           "                                DECODE(CCY,'VND',NVL(SUM(NVL(YMD_DRTRANS,0))- SUM(NVL(YMD_CRTRANS,0)),0),0) OPEN_VND, " +
           "                                DECODE(CCY,'VND',0,NVL(SUM(NVL(YMD_DRTRANS,0))- SUM(NVL(YMD_CRTRANS,0)),0)) OPEN_USD, " +
           "                                NVL( SUM(NVL(YMD_DRBOOKS,0)) - SUM(NVL(YMD_CRBOOKS,0)),0) OPEN_BOOK  " +
           "                          FROM TAC_HGDDBAL " +
           "                         WHERE del_if = 0 " +
           "                           AND tco_company_pk = " + l_company_pk +
           "                           AND tac_abacctcode_pk in  " +
           "                        ( " +
           "                            SELECT PK  " +
           "                            FROM TAC_ABACCTCODE A  " +
           "                            WHERE A.DEL_IF= 0  " +
           "                            AND A.TCO_COMPANY_PK =  " + l_company_pk +
           "                            AND A.LEAF_YN ='Y'  " +
           "                            CONNECT BY PRIOR PK = PAC_PK   " +
           "                            START WITH (PK IN (  " +
           "                                SELECT B.PK  " +
           "                                    FROM TAC_ABACCTCODE B  " +
           "                                    WHERE B.DEL_IF= 0  " +
           "                                        AND B.TCO_COMPANY_PK =  " + l_company_pk +
           "                                        /* AND B.AC_CD IN ('111100','111200','113000') */ " +
		   "                             AND B.AC_CD IN (  SELECT AC_CODE " +
		   "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
		   "       WHERE D.DEL_IF           = 0  " +
		   "         AND H.DEL_IF           = 0 " +
		   "         AND D.TAC_ABTRACGRP_PK = H.PK " +
		   "       and AC_GRP in ('CASH'))   " +
		   "		)) " +
           "                        ) " +
           "                           AND tr_status = '" + l_status + "' " +
           "                           AND std_ymd " +
           "                                  BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (Sf_Get_Lastclosemm('" + l_date_from + "', '" + l_company_pk + "' ),'YYYYMMDD'),+1),'YYYYMMDD') " +
           "                                      AND TO_CHAR (  TO_DATE ('" + l_date_from + "','YYYYMMDD')- 1,'YYYYMMDD') " +
           "                    GROUP BY tac_abacctcode_pk, CCY " +
           "                    ) " +
           "              GROUP BY tac_abacctcode_pk, CCY   " +
           "              ) A, TAC_ABACCTCODE B " +
           "              WHERE B.DEL_IF =0 " +
           "              AND B.PK = A.TAC_ABACCTCODE_PK(+) " +
           "                 AND B.PK IN ( " +
           "                 SELECT PK  " +
           "                            FROM TAC_ABACCTCODE A  " +
           "                            WHERE A.DEL_IF= 0  " +
           "                            AND A.TCO_COMPANY_PK =  " + l_company_pk +
           "                            AND A.LEAF_YN ='Y'  " +
           "                            CONNECT BY PRIOR PK = PAC_PK   " +
           "                            START WITH (PK IN (  " +
           "                                SELECT B.PK  " +
           "                                    FROM TAC_ABACCTCODE B  " +
           "                                    WHERE B.DEL_IF= 0  " +
           "                                        AND B.TCO_COMPANY_PK =  " + l_company_pk +
           "                                        /* AND B.AC_CD IN ('111100','111200','113000') */ " +
		   "                             AND B.AC_CD IN (  SELECT AC_CODE " +
		   "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
		   "       WHERE D.DEL_IF           = 0  " +
		   "         AND H.DEL_IF           = 0 " +
		   "         AND D.TAC_ABTRACGRP_PK = H.PK " +
		   "       and AC_GRP in ('CASH'))   " +
		   "		)) " +
           "                                        ) " +
           "                   GROUP BY B.PK, B.CCY  ORDER BY AC_CD";
    
        DataTable dtcash_detail = ESysLib.TableReadOpen(SQL);

        if (dtcash_detail.Rows.Count > 0)
        {
            for (i = 0; i < dtcash_detail.Rows.Count; i++)
            {
 %>
 
 <tr class=xl26 height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl33 style='height:21.95pt' x:num><%=stt%></td>
  <td class=xl41 width=103 style='width:77pt' x:num><%= dtcash_detail.Rows[i][1].ToString()%></td>
  <td class=xl42 width=145 style='width:109pt'><%= dtcash_detail.Rows[i][2].ToString()%></td>
  <td class=xl36><%= dtcash_detail.Rows[i][3].ToString()%></td>
  <td class=xl37 x:num><%= dtcash_detail.Rows[i][4].ToString()%></td>
  <td class=xl38 x:num><%= dtcash_detail.Rows[i][5].ToString()%></td>
  <td class=xl38 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtcash_detail.Rows[i][6].ToString()%></td>
  <td class=xl37 x:num><%= dtcash_detail.Rows[i][7].ToString()%></td>
  <td class=xl38 x:num><%= dtcash_detail.Rows[i][8].ToString()%></td>
  <td class=xl38 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtcash_detail.Rows[i][9].ToString()%></td>
  <td class=xl37 x:num><%= dtcash_detail.Rows[i][10].ToString()%></td>
  <td class=xl38 x:num><%= dtcash_detail.Rows[i][11].ToString()%></td>
  <td class=xl38 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtcash_detail.Rows[i][12].ToString()%></td>
  <td class=xl37 x:num><%= dtcash_detail.Rows[i][13].ToString()%></td>
  <td class=xl38 x:num><%= dtcash_detail.Rows[i][14].ToString()%></td>
  <td class=xl38 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtcash_detail.Rows[i][15].ToString()%></td>
 </tr>
 <%
            stt += 1;
        }
    }

    SQL = "SELECT  SUM(Open_vnd) Open_vnd, SUM(open_usd) open_usd, SUM(open_book) open_book, " +
          "                SUM(DR_VND) DR_VND,SUM(DR_USD) DR_USD,SUM(DR_BOOK) DR_BOOK,SUM(CR_VND) CR_VND,SUM(CR_USD) CR_USD, " +
          "                SUM(CR_BOOK) CR_BOOK,  " +
          "                (SUM(Open_vnd) + SUM(DR_VND) - SUM(CR_VND)) CLOSE_VND, " +
          "                (SUM(open_usd) + SUM(DR_USD) - SUM(CR_USD)) CLOSE_USD, " +
          "                (SUM(open_book) + SUM(DR_BOOK) - SUM(CR_BOOK)) CLOSE_BOOK   " +
          "   FROM " +
          "   ( " +
          "      SELECT   tac_abacctcode_pk, ccy,0 Open_vnd, 0 open_usd, 0 open_book, " +
          "                         SUM(DECODE(a.CCY,'VND',NVL(ymd_drtrans,0),0)) DR_VND, " +
          "                         SUM(DECODE(A.CCY,'VND',0,NVL(ymd_drtrans,0))) DR_USD, " +
          "                         SUM (NVL (ymd_drbooks, 0)) DR_BOOK, " +
          "                         SUM(DECODE(a.CCY,'VND',NVL(ymd_crtrans,0),0)) CR_VND, " +
          "                         SUM(DECODE(A.CCY,'VND',0,NVL(ymd_crtrans,0))) CR_USD, " +
          "                         SUM (NVL (ymd_crbooks, 0)) CR_BOOK " +
          "                    FROM TAC_HGDDBAL a " +
          "                   WHERE a.del_if = 0 " +
          "                     AND a.tco_company_pk = " + l_company_pk +
          "                     AND a.tac_abacctcode_pk in  " +
          "                        ( " +
          "                            SELECT PK  " +
          "                            FROM TAC_ABACCTCODE A  " +
          "                            WHERE A.DEL_IF= 0  " +
          "                            AND A.TCO_COMPANY_PK =  " + l_company_pk +
          "                            AND A.LEAF_YN ='Y'  " +
          "                            CONNECT BY PRIOR PK = PAC_PK   " +
          "                            START WITH (PK IN (  " +
          "                                SELECT B.PK  " +
          "                                    FROM TAC_ABACCTCODE B  " +
          "                                    WHERE B.DEL_IF= 0  " +
          "                                        AND B.TCO_COMPANY_PK =  " + l_company_pk +
          "                                        /* AND B.AC_CD IN ('111100','111200','113000') */ " +
		   "                             AND B.AC_CD IN (  SELECT AC_CODE " +
		   "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
		   "       WHERE D.DEL_IF           = 0  " +
		   "         AND H.DEL_IF           = 0 " +
		   "         AND D.TAC_ABTRACGRP_PK = H.PK " +
		   "       and AC_GRP in ('CASH'))   " +
		   "		)) " +
          "                        ) " +
          "                     AND a.tr_status = '" + l_status + "' " +
          "                     AND a.std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "' " +
          "                GROUP BY tac_abacctcode_pk, ccy " +
          "                UNION ALL " +
          "                SELECT tac_abacctcode_pk, CCY, SUM(OPEN_VND) OPEN_VND, SUM(OPEN_USD) OPEN_USD, SUM(OPEN_BOOK) OPEN_BOOK, " +
          "                    0 DR_VND,0 DR_USD,0 DR_BOOK,0 CR_VND,0 CR_USD,0 CR_BOOK " +
          "                FROM( " +
          "                SELECT tac_abacctcode_pk, CCY, " +
          "                        DECODE(CCY,'VND',NVL((SUM (NVL(this_drfbal,0)) - SUM (NVL(this_crfbal,0))),0),0) OPEN_VND, " +
          "                        DECODE(CCY,'VND',0,NVL((SUM (NVL(this_drfbal,0)) - SUM (NVL(this_crfbal,0))),0)) OPEN_USD, " +
          "                        SUM(NVL(THIS_DRBAL,0) - NVL(THIS_CRBAL,0)) OPEN_BOOK " +
          "                     FROM TAC_HGMMBAL " +
          "                     WHERE del_if = 0 " +
          "                           AND tco_company_pk = " + l_company_pk +
          "                           AND tac_abacctcode_pk in  " +
          "                        ( " +
          "                            SELECT PK  " +
          "                            FROM TAC_ABACCTCODE A  " +
          "                            WHERE A.DEL_IF= 0  " +
          "                            AND A.TCO_COMPANY_PK =  " + l_company_pk +
          "                            AND A.LEAF_YN ='Y'  " +
          "                            CONNECT BY PRIOR PK = PAC_PK   " +
          "                            START WITH (PK IN (  " +
          "                                SELECT B.PK  " +
          "                                    FROM TAC_ABACCTCODE B  " +
          "                                    WHERE B.DEL_IF= 0  " +
          "                                        AND B.TCO_COMPANY_PK =  " + l_company_pk +
          "                                        /* AND B.AC_CD IN ('111100','111200','113000') */ " +
		   "                             AND B.AC_CD IN (  SELECT AC_CODE " +
		   "        FROM TAC_ABTRACGRPD D, TAC_ABTRACGRP H " +
		   "       WHERE D.DEL_IF           = 0  " +
		   "         AND H.DEL_IF           = 0 " +
		   "         AND D.TAC_ABTRACGRP_PK = H.PK " +
		   "       and AC_GRP in ('CASH'))   " +
		   "		)) " +
          "                        ) " +
          "                           AND tr_status = '" + l_status + "' " +
          "                           AND std_ym = SUBSTR (Sf_Get_Lastclosemm ('" + l_date_from + "','" + l_company_pk + "'),1,6) " +
          "                           GROUP BY tac_abacctcode_pk, CCY " +
          "                       UNION ALL " +
          "                       SELECT tac_abacctcode_pk,CCY, " +
          "                                DECODE(CCY,'VND',NVL(SUM(NVL(YMD_DRTRANS,0))- SUM(NVL(YMD_CRTRANS,0)),0),0) OPEN_VND, " +
          "                                DECODE(CCY,'VND',0,NVL(SUM(NVL(YMD_DRTRANS,0))- SUM(NVL(YMD_CRTRANS,0)),0)) OPEN_USD, " +
          "                                NVL( SUM(NVL(YMD_DRBOOKS,0)) - SUM(NVL(YMD_CRBOOKS,0)),0) OPEN_BOOK  " +
          "                          FROM TAC_HGDDBAL " +
          "                         WHERE del_if = 0 " +
          "                           AND tco_company_pk = " + l_company_pk +
          "                           AND tac_abacctcode_pk in  " +
          "                        ( " +
          "                            SELECT PK  " +
          "                            FROM TAC_ABACCTCODE A  " +
          "                            WHERE A.DEL_IF= 0  " +
          "                            AND A.TCO_COMPANY_PK =  " + l_company_pk +
          "                            AND A.LEAF_YN ='Y'  " +
          "                            CONNECT BY PRIOR PK = PAC_PK   " +
          "                            START WITH (PK IN (  " +
          "                                SELECT B.PK  " +
          "                                    FROM TAC_ABACCTCODE B  " +
          "                                    WHERE B.DEL_IF= 0  " +
          "                                        AND B.TCO_COMPANY_PK =  " + l_company_pk +
          "                                        /* AND B.AC_CD IN ('111100','111200','113000') */ " +
		   "                             AND B.AC_CD IN (  SELECT AC_CODE " +
		   "        FROM TAC_ABTRACGRPD D,TAC_ABTRACGRP H " +
		   "       WHERE D.DEL_IF           = 0  " +
		   "         AND H.DEL_IF           = 0 " +
		   "         AND D.TAC_ABTRACGRP_PK = H.PK " +
		   "       and AC_GRP in ('CASH'))   " +
		   "		)) " +
          "                        ) " +
          "                           AND tr_status = '" + l_status + "' " +
          "                           AND std_ymd " +
          "                                  BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (Sf_Get_Lastclosemm('" + l_date_from + "', '" + l_company_pk + "' ),'YYYYMMDD'),+1),'YYYYMMDD') " +
          "                                      AND TO_CHAR (  TO_DATE ('" + l_date_from + "','YYYYMMDD')- 1,'YYYYMMDD') " +
          "                    GROUP BY tac_abacctcode_pk, CCY " +
          "                    ) " +
          "              GROUP BY tac_abacctcode_pk, CCY   " +
          "              )  ";

      //Response.Write(SQL);
	  //Response.End();

      DataTable dtcash_total = ESysLib.TableReadOpen(SQL);

      if (dtcash_total.Rows.Count > 0)
      {
  %>
 
 <tr class=xl26 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=4 height=33 class=xl66 style='border-right:.5pt solid black;
  height:24.95pt'>Grand Total</td>
  <td class=xl39 x:num><%= dtcash_total.Rows[0][0].ToString()%></td>
  <td class=xl40 x:num><%= dtcash_total.Rows[0][1].ToString()%></td>
  <td class=xl40 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtcash_total.Rows[0][2].ToString()%></td>
  <td class=xl39 x:num><%= dtcash_total.Rows[0][3].ToString()%></td>
  <td class=xl40 x:num><%= dtcash_total.Rows[0][4].ToString()%></td>
  <td class=xl40 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtcash_total.Rows[0][5].ToString()%></td>
  <td class=xl39 x:num><%= dtcash_total.Rows[0][6].ToString()%></td>
  <td class=xl40 x:num><%= dtcash_total.Rows[0][7].ToString()%></td>
  <td class=xl40 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtcash_total.Rows[0][8].ToString()%></td>
  <td class=xl39 x:num><%= dtcash_total.Rows[0][9].ToString()%></td>
  <td class=xl40 x:num><%= dtcash_total.Rows[0][10].ToString()%></td>
  <td class=xl40 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dtcash_total.Rows[0][11].ToString()%></td>
 </tr>
<%
     }
 %> 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=26 style='width:20pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=100 style='width:75pt'></td>
 </tr>
 <![endif]></table>

</body>

</html>
