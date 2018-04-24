<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
  ESysLib.SetUser("acnt");
  string l_kind=Request["p_kind"];  
  string l_status=Request["p_status"];
  string l_tco_company_pk=Request["p_tco_company_pk"];
  string l_date_fr=Request["p_date_fr"];
  string l_date_to=Request["p_date_to"];
  string l_date_type=Request["p_date_type"];
  string l_quarter = Request["p_quarter"];
  string l_Scale = Request["p_Scale"];
  
  string l_ccy = Request["p_ccy"];

  string p_xls_ccy_format = "";

  if (l_ccy == "VND")
  {
      p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";      
  }
  else
  {
      p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";      
  }

  string fr_dt, to_dt, l_cmp_name, l_cmp_add, l_cmp_taxcode, to_dt_e, quarter,year;
  fr_dt = "";
  to_dt = "";
  l_cmp_name = "";
  l_cmp_add = "";
  l_cmp_taxcode = "";
  to_dt_e = "";
  quarter = "";
  year = "";

  string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE "+
      ",to_char(to_date('" + l_date_fr + "','yyyymmdd'),'dd/mm/yyyy') fr_dt,to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd/mm/yyyy') to_dt"+
      ",to_char(to_date('" + l_date_to + "','yyyymmdd'),'dd-Mon-yyyy') sign_dt,decode('" + l_quarter + "','1','I','2','II','3','III','IV')"+
      ",substr('" + l_date_fr + "',1,4) year" +
    " FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "' ";
      
  DataTable dt_f = ESysLib.TableReadOpen(SQL1);
  if (dt_f.Rows.Count > 0)
  {
      l_cmp_name = dt_f.Rows[0][0].ToString();
      l_cmp_add = dt_f.Rows[0][1].ToString();
      l_cmp_taxcode = dt_f.Rows[0][3].ToString();
      fr_dt = dt_f.Rows[0][4].ToString();
      to_dt = dt_f.Rows[0][5].ToString();
      to_dt_e = dt_f.Rows[0][6].ToString();
      quarter = dt_f.Rows[0][7].ToString();
      year = dt_f.Rows[0][8].ToString();
  }

  string l_parameter = "'" + l_kind + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_Scale + "'";
  
  DataTable dt = ESysLib.TableReadOpenCursor("SP_SEL_GRD_FINANCE_STATEMENT3",l_parameter);
  
  if (dt.Rows.Count==0)
  {
    Response.Write("There is no data");
    Response.End();
  }     
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00080_CF_QUARTER_ENG_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00080_CF_QUARTER_ENG_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00080_CF_QUARTER_ENG_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Thu Hien</o:LastAuthor>
  <o:LastPrinted>2009-01-22T02:45:25Z</o:LastPrinted>
  <o:LastSaved>2009-01-22T03:05:31Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022For the year ended\0022\\ dd\\ mmmm\\ yyyy";
	text-align:center;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ \\ dd\\\,\\ yyyy";
	text-align:center;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>gfka00080_CF_QUARTER_ENG</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>88</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.--><!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.--><!-----------------------------><!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD --><!----------------------------->

<table x:str border=0 cellpadding=0 cellspacing=0 width=746 style='border-collapse:
 collapse;table-layout:fixed;width:561pt'>
 <col class=xl24 width=355 style='mso-width-source:userset;mso-width-alt:12982;
 width:266pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl26 width=138 span=2 style='mso-width-source:userset;mso-width-alt:
 5046;width:104pt'>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl28 width=355 style='height:19.5pt;width:266pt'><%= l_cmp_name%></td>
  <td class=xl29 width=54 style='width:41pt'></td>
  <td class=xl29 width=61 style='width:46pt'></td>
  <td class=xl30 width=138 style='width:104pt'></td>
  <td class=xl31 width=138 style='width:104pt'>Form: B 03 - DN</td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt'>Địa chỉ:<%= l_cmp_add %></td>
  <td colspan=4 class=xl52
  x:str="(Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày ">(Ban hành theo
  Quyết định số 15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=4 class=xl52>20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=5 height=26 class=xl53 style='height:19.5pt'>CASH FLOW STATEMENT</td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=5 height=21 class=xl34 style='height:15.75pt'>(</td>
 </tr>
 <tr class=xl35 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=5 height=26 class=xl53 style='height:19.5pt'>Quarter <%=quarter %>/<%=year %></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=5 height=21 class=xl54 style='height:15.75pt'>From <%=fr_dt %> to <%=to_dt %></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl37>(Currency: <%=l_ccy%>)</td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=2 height=42 class=xl55 style='border-bottom:.5pt solid black;
  height:31.5pt'>Items</td>
  <td rowspan=2 class=xl55 style='border-bottom:.5pt solid black'>Code</td>
  <td rowspan=2 class=xl55 style='border-bottom:.5pt solid black'>Notes</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none' x:str="Accumulate in this quarter"><span
  style='mso-spacerun:yes'> </span>Accumulate in this quarter<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt' x:str="This year"><span
  style='mso-spacerun:yes'> </span>This year<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl38 x:str="Previous year"><span
  style='mso-spacerun:yes'> </span>Previous year<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt' x:num>1</td>
  <td class=xl40 x:num>2</td>
  <td class=xl41 width=61 style='width:46pt' x:num>3</td>
  <td class=xl41 width=138 style='width:104pt' x:num>4</td>
  <td class=xl41 width=138 style='width:104pt' x:num>5</td>
 </tr>
 <%
    string tag_begin="";
    string tag_end="";
    int i;
    for(i=0;i<dt.Rows.Count-1;i++)
    {
        tag_begin=" ";
        tag_end=" ";
        if (dt.Rows[i][5].ToString()=="I")
        {
            tag_begin="<i>";
            tag_end="</i>";
        }
        if (dt.Rows[i][5].ToString()=="B")
        {
            tag_begin="<b>";
            tag_end="</b>";
        }
        if (i == 0)
        {
 %>
 <tr class=xl42>
  <td class=xl43><%=tag_begin%><%= dt.Rows[i][1].ToString()%><%=tag_end%></td>
  <td class=xl44 x:str><%=tag_begin%><%=dt.Rows[i][3].ToString()%><%=tag_end%></td>
  <td class=xl44 x:num><%=tag_begin%><%=dt.Rows[i][4].ToString()%><%=tag_end%></td>
  <td class=xl45 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl45 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
 </tr>
 <%
     }
     else
     {
 %>
 <tr class=xl42>
  <td class=xl63><%=tag_begin%><%= dt.Rows[i][1].ToString()%><%=tag_end%></td>
  <td class=xl46 x:str><%=tag_begin%><%=dt.Rows[i][3].ToString()%><%=tag_end%></td>
  <td class=xl46 x:num><%=tag_begin%><%=dt.Rows[i][4].ToString()%><%=tag_end%></td>
  <td class=xl47 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl47 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%=dt.Rows[i][7].ToString()%><%=tag_end%></td>
 </tr>
 <%
     }
 }
         %>
 <tr class=xl42>
  <td class=xl48><%=tag_begin%><%= dt.Rows[i][1].ToString()%><%=tag_end%></td>
  <td class=xl49><%=tag_begin%><%= dt.Rows[i][3].ToString()%><%=tag_end%></td>
  <td class=xl49 x:num><%=tag_begin%><%= dt.Rows[i][4].ToString()%><%=tag_end%></td>
  <td class=xl64 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%= dt.Rows[i][6].ToString()%><%=tag_end%></td>
  <td class=xl64 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=tag_begin%><%= dt.Rows[i][7].ToString()%><%=tag_end%></td>
 </tr>
 <tr class=xl42 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=5 class=xl50 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl59>At dated<span style='mso-spacerun:yes'> 
  </span><%=to_dt_e %></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl34 style='height:15.75pt'>Repairer by</td>
  <td colspan=2 class=xl60
  x:str="Chief Accountant                                ">Chief
  Accountant<span
  style='mso-spacerun:yes'>                                </span></td>
  <td colspan=2 class=xl34>General Director</td>
 </tr>
 <tr class=xl51 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl33 style='height:18.0pt'>(Sign, Fullname)</td>
  <td colspan=2 class=xl33>(Sign, Fullname)</td>
  <td colspan=2 class=xl61 x:str="(Sign, Fullname, Stamp)"><span
  style='mso-spacerun:yes'> </span>(Sign, Fullname, Stamp)<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=3 class=xl34 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl62></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=4 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl34 style='height:15.75pt'>NGUYEN VAN</td>
  <td colspan=2 class=xl62 x:str="LAM VAN"><span
  style='mso-spacerun:yes'> </span>LAM VAN<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl62 x:str="LAM VAN"><span
  style='mso-spacerun:yes'> </span>LAM VAN<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl30><!-----------------------------><!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD--><!-----------------------------></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=355 style='width:266pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
