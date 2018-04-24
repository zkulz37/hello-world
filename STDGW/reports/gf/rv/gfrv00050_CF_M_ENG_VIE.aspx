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
    string l_form_type = Request["p_form_type"];
    string l_status = Request["p_status"];
    string l_tco_company_pk = Request["p_tco_company_pk"];
    string l_date_fr = Request["p_date_fr"];
    string l_date_to = Request["p_date_to"];
    string l_date_type = Request["p_date_type"];
    string l_Scale1 = Request["p_Scale"];
    string l_ccy = Request["p_ccy"];
    string l_exrate = Request["p_exrate"];
    string l_month = Request["p_month"];
    string trsScale = "";
    if (l_Scale1=="1")
    {
        trsScale = "";
    }
    else
    {
        trsScale = l_Scale1;
    }
    string ldate="";
    string l_curYYYY= "";
    string l_lastYYYY = "";
    string l_cmp_name = "";
    string l_cmp_add = "";
    string l_cmp_taxcode = "";
    int    i;
    string p_xls_ccy_format = "";

    if (l_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

        
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE"+
        ",to_char(to_date('" + l_date_to + "','yyyymmdd'),'MM/yyyy') curr_date" +
      ",TO_CHAR (ADD_MONTHS (TO_DATE ('" + l_date_to + "', 'yyyymmdd'), -12), 'MM/yyyy') last_yyyy" +
    " FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL1);
    if (dt.Rows.Count > 0)
    {
        l_cmp_name = dt.Rows[0][0].ToString();
        l_cmp_add = dt.Rows[0][1].ToString();
        l_cmp_taxcode = dt.Rows[0][3].ToString();
        l_curYYYY=dt.Rows[0][4].ToString();
        l_lastYYYY = dt.Rows[0][5].ToString();
    }
    string para = "'" + l_form_type + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_Scale1 + "','" + l_ccy + "','" + l_exrate + "','" + l_month + "'";
    //Response.Write(dt_detail.Rows[0][9].ToString());
    //Response.End();
    string SQL_TEMP = "acnt.sp_sel_gfrv00050_1";
    
    DataTable dt_detail = ESysLib.TableReadOpenCursor(SQL_TEMP, para);
        //Response.Write(dt_detail.Rows[0][9].ToString());
       // Response.End();
    l_date_to = l_date_to.Substring(6, 2) + "/" + l_date_to.Substring(4, 2) +"/" + l_date_to.Substring(0, 4);//2009.08.25  
    l_date_fr = l_date_fr.Substring(6, 2) + "/" + l_date_fr.Substring(4, 2) + "/" + l_date_fr.Substring(0, 4);//2009.08.25     
        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptEV_files/filelist.xml">
<link rel=Edit-Time-Data href="rptEV_files/editdata.mso">
<link rel=OLE-Object-Data href="rptEV_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-01-22T04:03:04Z</o:LastPrinted>
  <o:Created>2010-01-23T05:41:35Z</o:Created>
  <o:LastSaved>2010-01-23T07:20:01Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .75in .75in;
	mso-header-margin:.25in;
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
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
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
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
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
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	text-align:left;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	text-align:left;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl62
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
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
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
.xl65
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
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>gfka00080_CF_PERIOD_VIE</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>87</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8745</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.--><!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.--><!-----------------------------><!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD --><!----------------------------->

<table x:str border=0 cellpadding=0 cellspacing=0 width=1050 style='border-collapse:
 collapse;table-layout:fixed;width:788pt'>
 <col class=xl24 width=255 span=2 style='mso-width-source:userset;mso-width-alt:
 9325;width:191pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl25 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl26 width=138 span=2 style='mso-width-source:userset;mso-width-alt:
 5046;width:104pt'>
 <col class=xl26 width=11 style='mso-width-source:userset;mso-width-alt:402;
 width:8pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl28 width=255 style='height:19.5pt;width:191pt'><%=l_cmp_name%></td>
  <td class=xl25 width=255 style='width:191pt'></td>
  <td class=xl29 width=54 style='width:41pt'></td>
  <td class=xl30 width=71 style='width:53pt'></td>
  <td colspan=2 class=xl59 width=276 style='width:208pt'>Form/Mẫu số: B03 - DN</td>
  <td class=xl32 width=11 style='width:8pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
  <td class=xl27 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'><%=l_cmp_add %></td>
  <td colspan=5 class=xl60
  x:str="Issued with Decision No. 15/2006/QĐ-BTC(Ban hành theo Quyết định số 15/2006/QĐ-BTC) ">Issued
  with Decision No. 15/2006/QĐ-BTC(Ban hành theo Quyết định số
  15/2006/QĐ-BTC)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl34></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=5 class=xl60>dated March 20, 2006 by Ministry of Finance(Ngày 20
  tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
  <td class=xl34></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=6 height=26 class=xl61 style='height:19.5pt'>CASH  FLOWS /
  BÁO CÁO LƯU CHUYỂN TIỀN TỆ</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
  <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=6 height=26 class=xl71 style='height:19.5pt'>Direct Method(Theo phương pháp trực tiếp)</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=6 height=21 class=xl35 style='height:15.75pt'>Date <%=l_date_fr %> To <%=l_date_to %>(Ngày <%=l_date_fr %> đến <%=l_date_to %>)</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=2 class=xl53>(Đơn vị tính:<%=trsScale %> VND)</td>
  <td class=xl26></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=2 height=42 class=xl62 style='border-bottom:.5pt solid black;
  height:31.5pt'>Items</td>
  <td rowspan=2 class=xl62 style='border-bottom:.5pt solid black'>Chỉ Tiêu</td>
  <td rowspan=2 class=xl62 style='border-bottom:.5pt solid black'>Code</td>
  <td class=xl39 width=71 style='width:53pt'>Notes/thuyết minh</td>
  <td colspan=2 class=xl64 style='border-right:.5pt solid black;border-left:
  none' x:str=" This Month/tháng này "><span style='mso-spacerun:yes'> 
  </span>This Month/tháng này<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl26></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl41 width=71 style='height:15.75pt;width:53pt'>&nbsp;</td>
  <td class=xl42 x:str><span style='mso-spacerun:yes'> 
  </span>Month (<%=l_curYYYY%>)<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl43 width=138 style='width:104pt' x:str><span
  style='mso-spacerun:yes'>  </span>Month (<%=l_lastYYYY%>)<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl40></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl44 style='height:15.75pt;border-top:none' x:num>1</td>
  <td class=xl45 style='border-top:none' x:num>2</td>
  <td class=xl45 style='border-top:none' x:num>3</td>
  <td class=xl46 width=71 style='width:53pt' x:num>4</td>
  <td class=xl46 width=138 style='width:104pt' x:num>5</td>
  <td class=xl46 width=138 style='width:104pt' x:num>6</td>
  <td class=xl40></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <%
    
     if (dt_detail.Rows.Count > 0)
     {
         string strBegin = "";
         string strEnd = "";

         for (i = 0; i < dt_detail.Rows.Count; i++)
         {
             strBegin = "";
             strEnd = "";
             if (dt_detail.Rows[i][8].ToString() == "I")
             {
                 strBegin = "<i>";
                 strEnd = "</i>";
             }
             if (dt_detail.Rows[i][8].ToString() == "B")
             {
                 strBegin = "<b>";
                 strEnd = "</b>";
             }
 %>
 <tr class=xl47 height=21 style='height:15.75pt'>
  <td height=21 class=xl49 style='height:15.75pt'><%=strBegin%><%= dt_detail.Rows[i][0].ToString() %><%=strEnd%></td>
  <td class=xl50><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl51><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl51 x:num><%=strBegin%><%= dt_detail.Rows[i][7].ToString() %><%=strEnd%></td>
  <td class=xl52 x:num><%=strBegin%><%= dt_detail.Rows[i][9].ToString() %><%=strEnd%></td>
  <td class=xl52 x:num><%=strBegin%><%= dt_detail.Rows[i][10].ToString() %><%=strEnd%></td>
  <td class=xl32></td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
  <%
     }
 } %>
 <tr class=xl47 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl53 style='height:15.75pt'></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl54 x:num="0"><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl54 x:num="0"><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl55></td>
  <td class=xl32></td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35>Date<span style='mso-spacerun:yes'> 
  </span><%=l_date_to %></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string l_col1_1 = "";
     string l_col1_2 = "";
     string l_col1_3 = "";

     string l_col2_1 = "";
     string l_col2_2 = "";
     string l_col2_3 = "";

     string l_col3_1 = "";
     string l_col3_2 = "";
     string l_col3_3 = "";

     string l_colK_1 = "";
     string l_colK_2 = "";
     string l_colK_3 = "";
     string l_colK_4 = "";
     string l_colK_5 = "";

     string l_colV_1 = "";
     string l_colV_2 = "";
     string l_colV_3 = "";
     string l_colV_4 = "";
     string l_colV_5 = "";

     string l_colE_1 = "";
     string l_colE_2 = "";
     string l_colE_3 = "";
     string l_colE_4 = "";
     string l_colE_5 = "";

     string l_colS_1 = "";
     string l_colS_2 = "";
     string l_colS_3 = "";
     string l_colS_4 = "";
     string l_colS_5 = "";
     string l_colN_1 = "";
     string l_colN_2 = "";
     string l_colN_3 = "";
     string l_colN_4 = "";
     string l_colN_5 = "";

     string SQL_EACAB044 = "SELECT   char_1, char_2, char_3,char_4, code,char_5 " +
           "    FROM tac_commcode_master a, tac_commcode_detail b " +
           "    WHERE a.pk = b.tac_commcode_master_pk AND a.ID = 'EACAB031' " +
           "         AND a.del_if = 0 AND b.del_if = 0 AND b.use_yn = 'Y' " +
           "    ORDER BY code, b.code_nm ";

     DataTable dt_EACAB044 = ESysLib.TableReadOpen(SQL_EACAB044);
     if (dt_EACAB044.Rows.Count > 0)
     {
         for (int j = 0; j < dt_EACAB044.Rows.Count; j++)
         {
             switch (dt_EACAB044.Rows[j][4].ToString())
             {
                 case "ENG":
                     l_colK_1 = dt_EACAB044.Rows[j][0].ToString();
                     l_colK_2 = dt_EACAB044.Rows[j][1].ToString();
                     l_colK_3 = dt_EACAB044.Rows[j][2].ToString();
                     l_colK_4 = dt_EACAB044.Rows[j][3].ToString();
                     l_colK_5 = dt_EACAB044.Rows[j][5].ToString();
                     break;
                 case "ENG_SIG":
                     l_colE_1 = dt_EACAB044.Rows[j][0].ToString();
                     l_colE_2 = dt_EACAB044.Rows[j][1].ToString();
                     l_colE_3 = dt_EACAB044.Rows[j][2].ToString();
                     l_colE_4 = dt_EACAB044.Rows[j][3].ToString();
                     l_colE_5 = dt_EACAB044.Rows[j][5].ToString();
                     break;
                 case "VIE":
                     l_colV_1 = dt_EACAB044.Rows[j][0].ToString();
                     l_colV_2 = dt_EACAB044.Rows[j][1].ToString();
                     l_colV_3 = dt_EACAB044.Rows[j][2].ToString();
                     l_colV_4 = dt_EACAB044.Rows[j][3].ToString();
                     l_colV_5 = dt_EACAB044.Rows[j][5].ToString();
                     break;
                 case "SIG":
                     l_colS_1 = dt_EACAB044.Rows[j][0].ToString();
                     l_colS_2 = dt_EACAB044.Rows[j][1].ToString();
                     l_colS_3 = dt_EACAB044.Rows[j][2].ToString();
                     l_colS_4 = dt_EACAB044.Rows[j][3].ToString();
                     l_colS_5 = dt_EACAB044.Rows[j][5].ToString();
                     break;
                 case "NAM":
                     l_colN_1 = dt_EACAB044.Rows[j][0].ToString();
                     l_colN_2 = dt_EACAB044.Rows[j][1].ToString();
                     l_colN_3 = dt_EACAB044.Rows[j][2].ToString();
                     l_colN_4 = dt_EACAB044.Rows[j][3].ToString();
                     l_colN_5 = dt_EACAB044.Rows[j][5].ToString();
                     break;
             }
         }
     }     

  %>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'><%=l_colK_1%></td>
  <td colspan=3 class=xl37><%=l_colK_2%></td>
  <td colspan=2 class=xl40 x:str="  General Director  "><span
  style='mso-spacerun:yes'>   </span><%=l_colK_3%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl56></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl57 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl35 style='height:18.0pt'><%=l_colE_1%></td>
  <td colspan=2 class=xl30 x:str><span
  style='mso-spacerun:yes'>  </span><%=l_colE_2%><span
  style='mso-spacerun:yes'>  </span></td>
  <td colspan=5 class=xl66 x:str><span
  style='mso-spacerun:yes'>   </span><%=l_colE_3%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl58></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl26></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'></td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=4 class=xl70 style='border-left:none' x:str="  "><span
  style='mso-spacerun:yes'>    </span></td>
  <td class=xl48><!-----------------------------><!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD--><!-----------------------------></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=255 style='width:191pt'></td>
  <td width=255 style='width:191pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=11 style='width:8pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
