<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_company_pk = "" + Request["Company"];
    string l_date_from =  "" + Request["rptMonth"];
    string l_book_ccy =  "" + Request["lstCurrency"];
    string l_status =  "" + Request["rbstatus"];
    string l_lang =  "" + Request["lang"];
    string l_rate1 =  "" + Request["txtRate1"];
    string l_rate2 =  "" + Request["txtRate2"];
    string l_rate3 =  "" + Request["txtRate3"];
    string l_form_type = "" + Request["lstFormType"];  
	
    string p_cmp_name = "";
	string p_cmp_add = "";
    string p_cmp_taxcode = "";
    string p_date_frm = "";
    string p_date_to = "";
    string p_year = "";
    string p_acc_name = "";
    string p_acc_name_1 = "";
    string p_acc_name_2 = ""; 
    string p_color = "";
    string p_font_type = ""; 
    int i=0; 

    string SQL = " SELECT partner_lname, addr2, tax_code,'01/'||substr('"+l_date_from+"',0,4) frm_date, ";
    SQL += "to_char(to_date('" + l_date_from + "01','YYYYMMDD'),'MM/YYYY') t_date, substr('" + l_date_from + "',0,4) rpt_year  FROM tco_company WHERE pk = '" + l_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count > 0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
        p_date_frm = dt.Rows[0][3].ToString();
        p_date_to = dt.Rows[0][4].ToString();
        p_year = dt.Rows[0][5].ToString();
    }  
     
   String p_xls_ccy_format ="";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    } 	
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="60110130_production%20expense_files/filelist.xml">
<link rel=Edit-Time-Data
href="60110130_production%20expense_files/editdata.mso">
<link rel=OLE-Object-Data
href="60110130_production%20expense_files/oledata.mso">
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
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-09-04T02:22:35Z</o:LastPrinted>
  <o:Created>2008-09-01T06:28:26Z</o:Created>
  <o:LastSaved>2009-01-16T08:08:03Z</o:LastSaved>
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
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	mso-pattern:auto none;
	}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	mso-pattern:auto none;
	}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	mso-pattern:auto none;
	}
.xl32
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl38
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-pattern:auto none;
	}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sale &amp; admin expense</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>50</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8850</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1961 style='border-collapse:
 collapse;table-layout:fixed;width:1467pt'>
 <col class=xl24 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl26 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=180 span=3 style='mso-width-source:userset;mso-width-alt:
 6582;width:135pt'>
 <col class=xl24 width=103 span=13 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <tr class=xl34 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 width=19 style='height:15.0pt;width:14pt'></td>
  <td class=xl34 width=63 style='width:47pt'><%= p_cmp_name %></td>
  <td width=180 style='width:135pt' align=left valign=top></td>
  <td class=xl34 width=180 style='width:135pt'></td>
  <td class=xl34 width=180 style='width:135pt'></td>
  <td class=xl34 width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt' align=left valign=top></td>
  <td class=xl34 width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt' align=left valign=top></td>
  <td class=xl34 width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt' align=left valign=top></td>
  <td class=xl34 width=103 style='width:77pt'></td>
  <td class=xl34 width=103 style='width:77pt'></td>
  <td class=xl34 width=103 style='width:77pt'></td>
  <td class=xl34 width=103 style='width:77pt'></td>
  <td class=xl34 width=103 style='width:77pt'></td>
  <td class=xl34 width=103 style='width:77pt'></td>
  <td class=xl34 width=103 style='width:77pt'></td>
 </tr>
 <tr class=xl34 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl34 colspan=2 style='mso-ignore:colspan'><%= p_cmp_add %></td>
  <td colspan=15 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=27 style='height:20.25pt'>
  <td height=27 class=xl34 style='height:20.25pt'></td>
  <td colspan=15 class=xl42>BÁO CÁO DOANH THU / PROFIT & LOSS</td>
  <td class=xl34></td>
 </tr>
 <tr class=xl34 height=21 style='height:15.75pt'>
  <td height=21 class=xl34 style='height:15.75pt'></td>
  <td colspan=15 class=xl43>T&#7915; <%= p_date_frm %> &#273;&#7871;n <%= p_date_to%></td>
  <td class=xl34></td>
 </tr>
 <tr class=xl34 height=18 style='height:13.5pt'>
  <td height=18 class=xl34 style='height:13.5pt'></td>
  <td colspan=14 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl37>&#272;&#417;n v&#7883; tính</td>
  <td class=xl36><%= l_book_ccy %></td>
 </tr>
 <tr class=xl34 height=17 style='height:12.75pt'>
  <td rowspan=2 height=37 class=xl40 style='height:27.75pt'>&nbsp;</td>
  <td rowspan=2 class=xl33>Code</td>
  <td rowspan=2 class=xl33>Kho&#7843;n m&#7909;c<span
  style='mso-spacerun:yes'>  </span>(VIE)</td>
  <td rowspan=2 class=xl33>Item</td>
  
  <td rowspan=2 class=xl33>Accumlate</td>
  <td colspan=12 class=xl41 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt;border-top:none;border-left:
  none'>Jan</td>
  <td class=xl33 style='border-top:none;border-left:none'>Feb</td>
  <td class=xl33 style='border-top:none;border-left:none'>Mar</td>
  <td class=xl33 style='border-top:none;border-left:none'>Apr</td>
  <td class=xl33 style='border-top:none;border-left:none'>May</td>
  <td class=xl33 style='border-top:none;border-left:none'>Jun</td>
  <td class=xl33 style='border-top:none;border-left:none'>Jul</td>
  <td class=xl33 style='border-top:none;border-left:none'>Aug</td>
  <td class=xl33 style='border-top:none;border-left:none'>Sep</td>
  <td class=xl33 style='border-top:none;border-left:none'>Oct</td>
  <td class=xl33 style='border-top:none;border-left:none'>Nov</td>
  <td class=xl33 style='border-top:none;border-left:none'>Dec</td>
 </tr>
<%
     SQL = "SELECT HEADER,SF_A_GET_ACCD(A.TAC_ABACCTCODE_PK, '" + l_company_pk + "'), " +
              "             A.PRN_LACNM, A.PRN_ACNM, A.PRN_KACNM, " +
              "             A.PRN_LR, UPPER(A.FONT_STYPE),  " +
              "             SUBSTR(A.PRN_COLOR,7,2)||SUBSTR(A.PRN_COLOR,5,2)||SUBSTR(A.PRN_COLOR,3,2) PRN_COLOR,  A.FORMULAR, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + l_date_from + "',A.TCO_COMPANY_PK,'" + l_status + "','ACC','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Accumlate, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'01',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Jan, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'02',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Feb, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'03',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Mar, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'04',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Apr, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'05',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_May, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'06',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Jun, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'07',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Jul, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'08',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Aug, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'09',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Sep, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'10',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Oct, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'11',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Nov, " +
              "             SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'12',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Dec " +
              "              " +
              "        FROM TAC_KAFINANCEFORM A " +
              "       WHERE A.DEL_IF = 0 " +
              "         AND A.FORM_TYPE       = '" + l_form_type + "' " +
              "         AND A.TCO_COMPANY_PK  = '" + l_company_pk + "' " +
              "         AND A.PRN_CHK = 'Y' " +
              "         AND ( SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'01',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'02',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'03',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'04',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'05',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'06',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'07',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'08',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'09',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'10',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'11',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              "         OR  SF_EXPENSE_FORMULAR(A.FORMULAR,'" + p_year + "'||'12',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "')  " +
              
              "         )  " +
              "       ORDER BY PRN_SEQ ";
     
     DataTable dt_detail = ESysLib.TableReadOpen(SQL);
     for (i = 0; i < dt_detail.Rows.Count; i++)
     {
             if (l_lang == "KOR-VIE")
             {
                 p_acc_name_1 = dt_detail.Rows[i][2].ToString(); //vie
                 p_acc_name_2 = dt_detail.Rows[i][4].ToString();// kor
             }
             else if (l_lang == "ENG-VIE")
             {
                 p_acc_name_1 = dt_detail.Rows[i][2].ToString(); //vie
                 p_acc_name_2 = dt_detail.Rows[i][3].ToString();// eng
             }
             else
             {
                 p_acc_name_1 = dt_detail.Rows[i][2].ToString(); //vie
                 p_acc_name_2 = dt_detail.Rows[i][3].ToString();// eng
             }
             
            p_color = dt_detail.Rows[i][7].ToString();
            if (dt_detail.Rows[i][6].ToString() == "R")
            {
                p_font_type = "";
            }
            if (dt_detail.Rows[i][6].ToString() == "B")
            {
                p_font_type = "font-weight:700;";
            }
            if (dt_detail.Rows[i][6].ToString() == "I")
            {
                p_font_type = "font-style:italic;";
            } 
  %> 
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt;border-top:none;background:#<%=p_color %>;<%=p_font_type %>' x:str="<%=dt_detail.Rows[i][0].ToString() %>"><%=dt_detail.Rows[i][0].ToString() %></td>
  <td class=xl27 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>' x:str="<%=dt_detail.Rows[i][1].ToString() %>" ><%=dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl28 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>'><%=p_acc_name_1%></td>
  <td class=xl28 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>'><%=p_acc_name_2%></td>
  
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][9].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][10].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][11].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][12].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][13].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][14].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][15].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][16].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][17].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][18].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][19].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][20].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";' x:num><%=dt_detail.Rows[i][21].ToString() %></td>
 </tr>
<%
     }
%> 
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=19 style='width:14pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
