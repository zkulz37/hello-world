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
    string p_font_type = ""; 
    string p_color = ""; 
    int i=0;
    string p_tittle = "";

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


    SQL = " SELECT  decode( '" + l_lang + "', 'ENG', code_nm, 'KOR',code_fnm, code_Lnm) code_nm ";
    SQL += "    FROM tco_abcode a, tco_abcodegrp b";
    SQL += "   WHERE a.tco_abcodegrp_pk = b.pk";
    SQL += "     AND b.ID = 'ACBG0020'";
    SQL += "     AND a.use_if = 1";
    SQL += "     AND a.del_if = 0";
    SQL += "     AND b.del_if = 0";
    SQL += "     AND code LIKE '" + l_form_type + "' ";
    SQL += "ORDER BY a.def_yn DESC, code";
    //Response.Write(SQL);
    //Response.End();
    DataTable dt1 = ESysLib.TableReadOpen(SQL);
    if (dt1.Rows.Count > 0)
    {
        p_tittle = dt1.Rows[0][0].ToString();
    }
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="60110130_production%20expense_lang_files/filelist.xml">
<link rel=Edit-Time-Data
href="60110130_production%20expense_lang_files/editdata.mso">
<link rel=OLE-Object-Data
href="60110130_production%20expense_lang_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2009-01-16T08:24:21Z</o:LastPrinted>
  <o:Created>2008-09-01T06:28:26Z</o:Created>
  <o:LastSaved>2009-01-16T08:24:46Z</o:LastSaved>
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-pattern:auto none;
	}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	mso-pattern:auto none;
	}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	mso-pattern:auto none;
	}
.xl35
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	mso-pattern:auto none;
	}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
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
.xl46
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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
      <x:Scale>62</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
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
       <x:ActiveRow>0</x:ActiveRow>
       <x:RangeSelection>$D:$D</x:RangeSelection>
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
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1601 style='border-collapse:
 collapse;table-layout:fixed;width:1197pt'>
 <col class=xl24 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl25 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl24 width=103 span=13 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 width=19 style='height:15.0pt;width:14pt'></td>
  <td class=xl26 colspan=3 width=346 style='mso-ignore:colspan;width:259pt'><%= p_cmp_name %></td>
  <td width=103 style='width:77pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'><%= p_cmp_add %></td>
  <td colspan=13 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 class=xl26 style='height:20.25pt'></td>
  <td colspan=14 class=xl40><%=p_tittle %></td>
  <td class=xl26></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 style='height:15.75pt'></td>
  <td colspan=14 class=xl41>T&#7915; <%= p_date_frm %> &#273;&#7871;n <%= p_date_to%></td>
  <td class=xl26></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt'></td>
  <td colspan=13 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl28>&#272;&#417;n v&#7883; tính</td>
  <td class=xl29><%= l_book_ccy %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=37 class=xl42 style='border-bottom:.5pt solid black;
  height:27.75pt'>&nbsp;</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Code</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Kho&#7843;n
  m&#7909;c<span style='mso-spacerun:yes'>  </span>(<%=l_lang %>)</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Accumlate</td>
  <td colspan=12 class=xl47 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>Jan</td>
  <td class=xl32>Feb</td>
  <td class=xl32>Mar</td>
  <td class=xl32>Apr</td>
  <td class=xl32>May</td>
  <td class=xl32>Jun</td>
  <td class=xl32>Jul</td>
  <td class=xl32>Aug</td>
  <td class=xl32>Sep</td>
  <td class=xl32>Oct</td>
  <td class=xl32>Nov</td>
  <td class=xl32>Dec</td>
 </tr>
 <%
     SQL = "SELECT HEADER,SF_A_GET_ACCD(A.TAC_ABACCTCODE_PK, '" + l_company_pk + "'), " +
              "             A.PRN_ACNM, A.PRN_LACNM, A.PRN_KACNM, " +
              "             A.PRN_LR, UPPER(A.FONT_STYPE),  " +
              "             SUBSTR(A.PRN_COLOR,7,2)||SUBSTR(A.PRN_COLOR,5,2)||SUBSTR(A.PRN_COLOR,3,2) PRN_COLOR,  A.FORMULAR,  " +
              "             sf_gfka00130_1(A.pk,'" + l_date_from + "',A.TCO_COMPANY_PK,'" + l_status + "','ACC','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Accumlate, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'01',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Jan, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'02',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Feb, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'03',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Mar, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'04',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Apr, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'05',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_May, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'06',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Jun, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'07',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Jul, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'08',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Aug, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'09',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Sep, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'10',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Oct, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'11',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Nov, " +
              "             sf_gfka00130_1(A.pk,'" + p_year + "'||'12',A.TCO_COMPANY_PK,'" + l_status + "','MONTH','" + l_rate1 + "','" + l_rate2 + "','" + l_rate3 + "') sum_Dec " +
              "              " +
              "        FROM TAC_KAFINANCEFORM A " +
              "       WHERE A.DEL_IF = 0 " +
              "         AND A.FORM_TYPE       = '" + l_form_type + "' " +
              "         AND A.TCO_COMPANY_PK  = '" + l_company_pk + "' " +
              "         AND A.PRN_CHK = 'Y' " +
              "       ORDER BY PRN_SEQ ";
     
     DataTable dt_detail = ESysLib.TableReadOpen(SQL);
     for (i = 0; i < dt_detail.Rows.Count; i++)
     {
            if (l_lang=="VIE")
            {
                p_acc_name = dt_detail.Rows[i][3].ToString();
            }
         else if (l_lang=="KOR")
            {
             p_acc_name = dt_detail.Rows[i][4].ToString();
         }
            else{
             p_acc_name = dt_detail.Rows[i][2].ToString();
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
  <td height=20 class=xl30 style='height:15.0pt;background:#<%=p_color %>;<%=p_font_type %>' x:str="<%=dt_detail.Rows[i][0].ToString() %>"><%=dt_detail.Rows[i][0].ToString() %></td>
  <td class=xl33 style='background:#<%=p_color %>;<%=p_font_type %>'   x:str="<%=dt_detail.Rows[i][1].ToString() %>" ><%=dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl34 style='background:#<%=p_color %>;<%=p_font_type %>' ><%=p_acc_name%></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][9].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][10].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][11].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][12].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][13].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][14].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][15].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][16].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][17].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][18].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][19].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][20].ToString() %></td>
  <td class=xl35 style='background:#<%=p_color %>;<%=p_font_type %>;mso-number-format:"<%=p_xls_ccy_format %>";'  x:num><%=dt_detail.Rows[i][21].ToString() %></td>
 </tr>

<%
     }
%>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=19 style='width:14pt'></td>
  <td width=63 style='width:47pt'></td>
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
