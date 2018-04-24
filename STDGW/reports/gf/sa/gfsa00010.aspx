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
    ESysLib.SetUser("acnt");
	string p_company_pk = Request["company_pk"];
	string p_year = Request["dtfrom"];
	string p_status = Request["status"];
	string p_ccy = Request["ccy"];
	string p_rate = Request["rate"];
	string p_level = Request["level"];
	string p_post_sum = Request["post"];
	string p_ac_cd = Request["accd"];
	string p_report_type = Request["rptType"];//1:monthly, 2:period
    string p_language = Request["language"];
    string p_acctype = Request["acctype"];
	String p_xls_ccy_format ="";
	string p_cmp_name = "";
    string p_cmp_add = "";
    string p_cmp_taxcode = "";
    string SQL = "";
   // string p_xls_ccy_format = "";
    if (p_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

    SQL = " SELECT partner_lname, addr2, tax_code FROM tco_company WHERE del_if = 0 and pk = '" + p_company_pk + "' ";
    DataTable dt_comp = ESysLib.TableReadOpen(SQL);
    if (dt_comp.Rows.Count > 0)
    {
        p_cmp_name = dt_comp.Rows[0][0].ToString();
        p_cmp_add = dt_comp.Rows[0][1].ToString();
        p_cmp_taxcode = dt_comp.Rows[0][2].ToString();
    }
    string l_parameter = "'" + p_company_pk + "','" + p_year + "','" + p_status + "','" + p_language + "','" + p_ccy + "','" + p_rate + "','" + p_ac_cd + "','" + p_level + "','" + p_post_sum + "','" + p_acctype + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("sp_pro_gfsa00010", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    string l_parameter2 = "'" + p_company_pk + "','" + p_year + "','" + p_status + "','" + p_language + "','" + p_ccy + "','" + p_rate + "','" + p_ac_cd + "','" + p_level + "','" + p_acctype + "'";
    DataTable dt_sum = ESysLib.TableReadOpenCursor("sp_pro_gfsa00010_sum", l_parameter2);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfsa00010_files/filelist.xml">
<link rel=Edit-Time-Data href="gfsa00010_files/editdata.mso">
<link rel=OLE-Object-Data href="gfsa00010_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>shvtn04</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-11-16T02:45:21Z</o:LastPrinted>
  <o:Created>2009-12-22T01:52:57Z</o:Created>
  <o:LastSaved>2011-11-16T06:28:16Z</o:LastSaved>
  <o:Company>admin</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.26in .25in .25in .25in;
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
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	color:navy;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	color:navy;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	vertical-align:bottom;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:bottom;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:bottom;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:bottom;}
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:bottom;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:bottom;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:bottom;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:bottom;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:bottom;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:bottom;}
.xl57
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:bottom;}
.xl58
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:bottom;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:bottom;}
.xl60
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl67
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl68
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl69
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl70
	{mso-style-parent:style16;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Trial 1~12</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>14</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>17</x:LeftColumnVisible>
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
       <x:ActiveCol>21</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>360</x:WindowTopY>
  <x:TabRatio>188</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=7839 style='border-collapse:
 collapse;table-layout:fixed;width:5898pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2247;
 width:59pt'>
 <col class=xl24 width=245 span=3 style='mso-width-source:userset;mso-width-alt:
 6968;width:184pt'>
 <col class=xl24 width=41 style='mso-width-source:userset;mso-width-alt:1166;
 width:31pt'>
 <col class=xl24 width=97 span=72 style='mso-width-source:userset;mso-width-alt:
 2759;width:73pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 width=79 style='height:15.75pt;width:59pt'><%=p_cmp_name %></td>
  <td class=xl26 width=245 style='width:184pt'></td>
  <td class=xl24 width=245 style='width:184pt'></td>
  <td class=xl24 width=245 style='width:184pt'></td>
  <td class=xl24 width=41 style='width:31pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl27 width=97 style='width:73pt'></td>
  <td class=xl27 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl27 width=97 style='width:73pt'></td>
  <td class=xl27 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl29 width=97 style='width:73pt'></td>
  <td class=xl29 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl29 width=97 style='width:73pt'></td>
  <td class=xl29 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl27 width=97 style='width:73pt'></td>
  <td class=xl27 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl27 width=97 style='width:73pt'></td>
  <td class=xl27 width=97 style='width:73pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'><%=p_cmp_add %></td>
  <td class=xl25></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>Mã số thuế:<%=p_cmp_taxcode %></td>
  <td class=xl25></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=42 height=19 class=xl59 style='height:14.25pt'>BẢNG CÂN ĐỐI SỐ
  PHÁT SINH - TRIAL BALANCE</td>
  <td colspan=11 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=24 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=42 height=26 class=xl31 style='height:19.5pt'>From 01/ - 12/<%=p_year%><%=p_year%></td>
  <td colspan=11 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=24 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=15 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=2 height=49 class=xl60 width=79 style='border-bottom:.5pt solid black;
  height:36.75pt;width:59pt'>Account ID<br>
    Mã TK</td>
  <td rowspan=2 class=xl62 width=245 style='border-bottom:.5pt solid black;
  width:184pt'>Account Name<br>
    Tên TK</td>
  <td rowspan=2 class=xl64 style='border-bottom:.5pt solid black'>Tiếng anh</td>
  <td rowspan=2 class=xl64 style='border-bottom:.5pt solid black'>Tiếng hàn</td>
  <td rowspan=2 class=xl64 style='border-bottom:.5pt solid black'>Level</td>
  <td colspan=12 class=xl67 width=1164 style='border-right:.5pt solid black;
  border-left:none;width:876pt' x:str="Openning Balance&#10;SỐ DƯ ĐẦU KỲ"><span
  style='mso-spacerun:yes'> </span>Openning Balance<br>
    SỐ DƯ ĐẦU KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=12 class=xl67 width=1164 style='border-right:.5pt solid black;
  border-left:none;width:876pt' x:str="Openning Balance&#10;SỐ DƯ ĐẦU KỲ"><span
  style='mso-spacerun:yes'> </span>Openning Balance<br>
    SỐ DƯ ĐẦU KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=12 class=xl67 width=1164 style='border-right:.5pt solid black;
  border-left:none;width:876pt' x:str="Period amount&#10;SỐ PHÁT SINH TRONG KỲ"><span
  style='mso-spacerun:yes'> </span>Period amount<br>
    SỐ PHÁT SINH TRONG KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=12 class=xl69 width=1164 style='border-right:.5pt solid black;
  border-left:none;width:876pt' x:str="Period amount&#10;SỐ PHÁT SINH TRONG KỲ"><span
  style='mso-spacerun:yes'> </span>Period amount<br>
    SỐ PHÁT SINH TRONG KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=12 class=xl69 width=1164 style='border-right:.5pt solid black;
  border-left:none;width:876pt' x:str="Ending Balance&#10;SỐ DƯ CUỐI KỲ"><span
  style='mso-spacerun:yes'> </span>Ending Balance<br>
    SỐ DƯ CUỐI KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=12 class=xl69 width=1164 style='border-right:1.0pt solid black;
  border-left:none;width:876pt' x:str="Ending Balance&#10;SỐ DƯ CUỐI KỲ"><span
  style='mso-spacerun:yes'> </span>Ending Balance<br>
    SỐ DƯ CUỐI KỲ<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl35 height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt' x:str="Dr1"><span
  style='mso-spacerun:yes'> </span>Dr1<span style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr2"><span style='mso-spacerun:yes'> </span>Dr2<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr3"><span style='mso-spacerun:yes'> </span>Dr3<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr4"><span style='mso-spacerun:yes'> </span>Dr4<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr5"><span style='mso-spacerun:yes'> </span>Dr5<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr6"><span style='mso-spacerun:yes'> </span>Dr6<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr7"><span style='mso-spacerun:yes'> </span>Dr7<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr8"><span style='mso-spacerun:yes'> </span>Dr8<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr9"><span style='mso-spacerun:yes'> </span>Dr9<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr10"><span style='mso-spacerun:yes'> </span>Dr10<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr11"><span style='mso-spacerun:yes'> </span>Dr11<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr12"><span style='mso-spacerun:yes'> </span>Dr12<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr1"><span style='mso-spacerun:yes'> </span>Cr1<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr2"><span style='mso-spacerun:yes'> </span>Cr2<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr3"><span style='mso-spacerun:yes'> </span>Cr3<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr4"><span style='mso-spacerun:yes'> </span>Cr4<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr5"><span style='mso-spacerun:yes'> </span>Cr5<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr6"><span style='mso-spacerun:yes'> </span>Cr6<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr7"><span style='mso-spacerun:yes'> </span>Cr7<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr8"><span style='mso-spacerun:yes'> </span>Cr8<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr9"><span style='mso-spacerun:yes'> </span>Cr9<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr10"><span style='mso-spacerun:yes'> </span>Cr10<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr11"><span style='mso-spacerun:yes'> </span>Cr11<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr12"><span style='mso-spacerun:yes'> </span>Cr12<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr1"><span style='mso-spacerun:yes'> </span>Dr1<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr2"><span style='mso-spacerun:yes'> </span>Dr2<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr3"><span style='mso-spacerun:yes'> </span>Dr3<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr4"><span style='mso-spacerun:yes'> </span>Dr4<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr5"><span style='mso-spacerun:yes'> </span>Dr5<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr6"><span style='mso-spacerun:yes'> </span>Dr6<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr7"><span style='mso-spacerun:yes'> </span>Dr7<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr8"><span style='mso-spacerun:yes'> </span>Dr8<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr9"><span style='mso-spacerun:yes'> </span>Dr9<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr10"><span style='mso-spacerun:yes'> </span>Dr10<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr11"><span style='mso-spacerun:yes'> </span>Dr11<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr12"><span style='mso-spacerun:yes'> </span>Dr12<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr1"><span style='mso-spacerun:yes'> </span>Cr1<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr2"><span style='mso-spacerun:yes'> </span>Cr2<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr3"><span style='mso-spacerun:yes'> </span>Cr3<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr4"><span style='mso-spacerun:yes'> </span>Cr4<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr5"><span style='mso-spacerun:yes'> </span>Cr5<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr6"><span style='mso-spacerun:yes'> </span>Cr6<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr7"><span style='mso-spacerun:yes'> </span>Cr7<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr8"><span style='mso-spacerun:yes'> </span>Cr8<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr9"><span style='mso-spacerun:yes'> </span>Cr9<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr10"><span style='mso-spacerun:yes'> </span>Cr10<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr11"><span style='mso-spacerun:yes'> </span>Cr11<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr12"><span style='mso-spacerun:yes'> </span>Cr12<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr1"><span style='mso-spacerun:yes'> </span>Dr1<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr2"><span style='mso-spacerun:yes'> </span>Dr2<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr3"><span style='mso-spacerun:yes'> </span>Dr3<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr4"><span style='mso-spacerun:yes'> </span>Dr4<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr5"><span style='mso-spacerun:yes'> </span>Dr5<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr6"><span style='mso-spacerun:yes'> </span>Dr6<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr7"><span style='mso-spacerun:yes'> </span>Dr7<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr8"><span style='mso-spacerun:yes'> </span>Dr8<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr9"><span style='mso-spacerun:yes'> </span>Dr9<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr10"><span style='mso-spacerun:yes'> </span>Dr10<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr11"><span style='mso-spacerun:yes'> </span>Dr11<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Dr12"><span style='mso-spacerun:yes'> </span>Dr12<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr1"><span style='mso-spacerun:yes'> </span>Cr1<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr2"><span style='mso-spacerun:yes'> </span>Cr2<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr3"><span style='mso-spacerun:yes'> </span>Cr3<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr4"><span style='mso-spacerun:yes'> </span>Cr4<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr5"><span style='mso-spacerun:yes'> </span>Cr5<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr6"><span style='mso-spacerun:yes'> </span>Cr6<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr7"><span style='mso-spacerun:yes'> </span>Cr7<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr8"><span style='mso-spacerun:yes'> </span>Cr8<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr9"><span style='mso-spacerun:yes'> </span>Cr9<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr10"><span style='mso-spacerun:yes'> </span>Cr10<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr11"><span style='mso-spacerun:yes'> </span>Cr11<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:str="Cr12"><span style='mso-spacerun:yes'> </span>Cr12<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <%
     int i=0;
     string _font = "";
     string _color="";
     for (i = 1; i < dt.Rows.Count; i++)
     {
         if (dt.Rows[i][150].ToString() == "B")
         {
             _font = "font-weight:700";
         }
         else
         {
             _font = "";
         }
         
        
         _color = "#" + dt.Rows[i][151].ToString().Substring(6,2) + dt.Rows[i][151].ToString().Substring(4,2) + dt.Rows[i][151].ToString().Substring(2,2);
         //Response.Write(_color);
         //Response.End();
 %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt;<%=_font%>;background-color:<%=_color%>'><%=dt.Rows[i][2]%></td>
 <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>'><%=dt.Rows[i][3]%></td>
 <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>'><%=dt.Rows[i][4]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>'><%=dt.Rows[i][5]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;text-align:center' ><%=dt.Rows[i][152]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][30]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][31]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][32]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][33]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][34]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][35]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][36]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][37]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][38]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][39]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][40]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][41]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][42]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][43]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][44]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][45]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][46]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][47]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][48]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][49]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][50]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][51]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][52]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][53]%></td>
  
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][78]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][79]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][80]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][81]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][82]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][83]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][84]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][85]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][86]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][87]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][88]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][89]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][90]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][91]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][92]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][93]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][94]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][95]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][96]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][97]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][98]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][99]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][100]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][101]%></td>

  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][126]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][127]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][128]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][129]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][130]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][131]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][132]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][133]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][134]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][135]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][136]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][137]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][138]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][139]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][140]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][141]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][142]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][143]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][144]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][145]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][146]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][147]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][148]%></td>
  <td class=xl39 width=245 style='width:184pt;<%=_font%>;background-color:<%=_color%>;mso-number-format:"<%= p_xls_ccy_format%>";text-align:right' x:num><%=dt.Rows[i][149]%></td>
 </tr>
 <%} %>
 
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl48 width=79 style='height:16.5pt;width:59pt'>Tổng cộng</td>
  <td class=xl49 width=245 style='width:184pt'>&nbsp;</td>
  <td class=xl49 width=245 style='width:184pt'>&nbsp;</td>
  <td class=xl49 width=245 style='width:184pt'>&nbsp;</td>
  <td class=xl50 width=41 style='width:31pt'>&nbsp;</td>
  <td class=xl51 x:num><%=dt_sum.Rows[1][25]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][26]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][27]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][28]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][29]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][30]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][31]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][32]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][33]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][34]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][35]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][36]%></td>
  <td class=xl51 x:num><%=dt_sum.Rows[1][37]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][38]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][39]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][40]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][41]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][42]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][43]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][44]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][45]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][46]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][47]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][48]%></td>

  <td class=xl52 x:num><%=dt_sum.Rows[1][73]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][74]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][75]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][76]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][77]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][78]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][79]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][80]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][81]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][82]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][83]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][84]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][85]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][86]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][87]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][88]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][89]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][90]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][91]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][92]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][93]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][94]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][95]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][96]%></td>

  <td class=xl52 x:num><%=dt_sum.Rows[1][121]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][122]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][123]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][124]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][125]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][126]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][127]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][128]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][129]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][130]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][131]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][132]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][133]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][134]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][135]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][136]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][137]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][138]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][139]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][140]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][141]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][142]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][143]%></td>
  <td class=xl52 x:num><%=dt_sum.Rows[1][144]%></td>
 </tr>
 
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl33 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl33></td>
  <td colspan=21 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl55></td>
  <td class=xl54></td>
  <td colspan=10 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=20 style='height:15.0pt'>
  <td height=20 class=xl56 style='height:15.0pt'>Người ghi sổ</td>
  <td colspan=2 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl56>Kế toán trưởng</td>
  <td colspan=24 class=xl57 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl56></td>
  <td colspan=11 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=24 class=xl57 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=20 style='height:15.0pt'>
  <td height=20 class=xl58 style='height:15.0pt'>( Ký, họ tên )</td>
  <td colspan=2 class=xl58 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl58>( Ký, họ tên )</td>
  <td colspan=24 class=xl57 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl58></td>
  <td colspan=11 class=xl58 style='mso-ignore:colspan'></td>
  <td colspan=24 class=xl57 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=15 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=79 style='width:59pt'></td>
  <td width=245 style='width:184pt'></td>
  <td width=245 style='width:184pt'></td>
  <td width=245 style='width:184pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=97 style='width:73pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
