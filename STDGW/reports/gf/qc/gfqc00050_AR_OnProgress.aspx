﻿<%@ Page Language="C#"%>
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
    string l_company_pk = Request["l_company"];
    string l_book_ccy =   Request["bookccy"];
    string l_taxcode = "";
    string l_compa = ""; 
    string l_address = "";
    //-----------------------------------------------------------------------------------------------
    string SQL1 = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company_pk + "' ";

    
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);
    
    if (dt_f.Rows.Count > 0)
    {
        l_compa = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
        l_taxcode = dt_f.Rows[0][3].ToString();
    }

    string l_tac_crcontract_pk = Request["p_tac_crcontract_pk"];
    //Response.Write(l_tac_crcontract_pk);
    //Response.End();
   
    DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_gfqc00050_report", l_tac_crcontract_pk);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }

    String p_xls_ccy_format = "";
    String p_xls_ccy_format_usd = "";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Copy%20of%20progress_files/filelist.xml">
<link rel=Edit-Time-Data href="Copy%20of%20progress_files/editdata.mso">
<link rel=OLE-Object-Data href="Copy%20of%20progress_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AiLinh</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:Created>2009-07-10T02:02:20Z</o:Created>
  <o:LastSaved>2009-12-31T03:08:14Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in 0in .25in .5in;
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
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl53
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
	border-left:1.0pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
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
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl66
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl77
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
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl81
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl82
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
.xl83
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl90
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
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl95
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
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PROGRESS</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>93</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>28</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12585</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path>http://localhost:1631/Projects\Poslilama\AR ON PROGRESS FORM(VERSION2) (2).xls</x:Path>
  <x:SheetName>SUMMARY</x:SheetName>
  <x:SheetName>PROGRESS</x:SheetName>
  <x:SheetName>ADVANCE</x:SheetName>
  <x:SheetName>TO</x:SheetName>
  <x:SheetName>Issue inv</x:SheetName>
  <x:SheetName>COLLECTION</x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>3</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl27>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1010 style='border-collapse:
 collapse;table-layout:fixed;width:759pt'>
 <col class=xl27 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl27 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl27 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl27 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl27 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl27 width=126 style='mso-width-source:userset;mso-width-alt:4608;
 width:95pt'>
 <col class=xl27 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl27 width=64 style='width:48pt'>
 <col class=xl27 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl27 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl27 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl27 width=131 span=2 style='mso-width-source:userset;mso-width-alt:
 4790;width:98pt'>
 <col class=xl27 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:146'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 width=31 style='height:12.75pt;width:23pt'></td>
  <td class=xl24 width=33 style='width:25pt'></td>
  <td class=xl25 width=102 style='width:77pt'>Tên công ty</td>
  <td colspan=3 class=xl25 width=240 style='width:181pt'><%=l_compa%></td>
  <td class=xl25 width=67 style='width:50pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=66 style='width:50pt'></td>
  <td class=xl25 width=39 style='width:29pt'></td>
  <td class=xl25 width=106 style='width:80pt'></td>
  <td class=xl25 width=131 style='width:98pt'></td>
  <td class=xl25 width=131 style='width:98pt'></td>
  <td class=xl26 width=0></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl27 style='height:13.5pt'></td>
  <td class=xl28></td>
  <td class=xl25>Địa chỉ công ty</td>
  <td colspan=3 class=xl78><%=l_address%></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl28></td>
  <td class=xl25 colspan=3 style='mso-ignore:colspan'>Mã số thuế :<%=l_taxcode%></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl27 style='height:13.5pt'></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=5 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 style='height:18.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=11 class=xl79 style='border-right:1.0pt solid black'
  >A/R ON PROGRESS<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37>&nbsp;</td>
 </tr>
 
  <%
      decimal profit_rate = 0;
      decimal Contract_Amount = 0;
      decimal Buget_Cost = 0;
      decimal Final_Amount = 0;
      decimal Adjust = 0;
      decimal VAT_Amt = 0;
      decimal VAT_Adj = 0;
      decimal VAT_Final = 0;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         if (dt.Rows[i][16].ToString().Trim() != "" )
         {
             Contract_Amount = decimal.Parse(dt.Rows[i][16].ToString());
         }
         else
         {
             Contract_Amount = 0;
         }
         if (dt.Rows[i][44].ToString().Trim() != "")
         {
             Buget_Cost = decimal.Parse(dt.Rows[i][44].ToString());
             profit_rate = (Contract_Amount - Buget_Cost) / Buget_Cost * 100;
         }
         else
         {
             profit_rate = 0;
         }  
         if (dt.Rows[i][17].ToString().Trim() != "")
         {
             Adjust = decimal.Parse(dt.Rows[i][17].ToString());
             Final_Amount = Contract_Amount + Adjust;
         }
         else
         {
             Final_Amount = 0;
         }
         if (dt.Rows[i][25].ToString().Trim() != "")
         {
             VAT_Amt = decimal.Parse(dt.Rows[i][25].ToString());
         }
         else
         {
             VAT_Amt = 0;
         }
         if (dt.Rows[i][28].ToString().Trim() != "")
         {
             VAT_Adj = decimal.Parse(dt.Rows[i][28].ToString());
             VAT_Final = VAT_Amt + VAT_Adj;
         }
         else
         {
             VAT_Adj = 0;
             VAT_Final = 0;
         }
         
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38>Contract No :</td>
  <td class=xl27></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][6]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl40>Project code</td>
  <td class=xl41></td>
  <td colspan=2 class=xl38><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][37]%></td>
  <td class=xl41></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38>Project Name :</td>
  <td class=xl27></td>
  <td class=xl40 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][38]%></td>
  <td class=xl27></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl42>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl40>Customer code</td>
  <td class=xl41></td>
  <td colspan=2 class=xl83 ><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][39]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl41></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl40>Customer Name</td>
  <td class=xl41></td>
  <td colspan=2 class=xl83 ><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][40]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl41></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl45></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl26></td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38 colspan=2 style='mso-ignore:colspan'>Contract Amount :</td>
  <td colspan=2 class=xl46  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes' ></span><%=dt.Rows[i][16]%></td>
  <td class=xl46 ><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][12]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27></td>
  <td class=xl38 colspan=2 style='mso-ignore:colspan' >Final
  Amount:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'>      </span><%=Final_Amount%></td>
  <td class=xl38><%=dt.Rows[i][12]%></td>
  <td class=xl48>&nbsp;</td>
  <td class=xl37><%=dt.Rows[i][12]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38>VAT</td>
  <td class=xl27></td>
  <td class=xl46></td>
  <td class=xl46 ><span
  style='mso-spacerun:yes'></span><%=dt.Rows[i][25]%></td>
  <td class=xl46></td>
  <td class=xl27></td>
  <td class=xl38>VAT</td>
  <td class=xl27></td>
  <td class=xl47 ><span style='mso-spacerun:yes'> </span><%=VAT_Final %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl38></td>
  <td class=xl48>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38 >Adjust amount:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27 align=right style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=dt.Rows[i][17]%></td>
  <td class=xl46 ><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][12]%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38>VAT</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl27 align=right x:num><%=dt.Rows[i][28]%></td>
  <td colspan=3 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38>BUDGET COST</td>
  <td class=xl27></td>
  <td colspan=2 class=xl81 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'>                                     
  </span><%=dt.Rows[i][44]%></td>
  <td class=xl46 ><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][12]%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38>Profit rate</td>
  <td class=xl27></td>
  <td class=xl46  style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'>          </span><%=profit_rate %></td>
  <td class=xl46 ><span style='mso-spacerun:yes'> </span>%<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38>Provision rate</td>
  <td class=xl27></td>
  <td class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'>           
  </span><%=dt.Rows[i][35]%></td>
  <td class=xl46 ><span style='mso-spacerun:yes'> </span>%<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38>Indirect cost rate</td>
  <td class=xl27></td>
  <td class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'>         
  </span><%=dt.Rows[i][36]%></td>
  <td class=xl46 ><span style='mso-spacerun:yes'> </span>%<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl50 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <%} %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl50 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl38></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl50 style='mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl51>&nbsp;</td>
  <td colspan=5 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl52>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt'>
  <td height=52 class=xl27 style='height:39.0pt'></td>
  <td class=xl53>No</td>
  <td colspan=2 class=xl54 style='border-left:none'>ACC - TURN OVER</td>
  <td class=xl55 width=65 style='border-left:none;width:49pt'>% (TO/CONT)</td>
  <td class=xl54 style='border-left:none'>ACC- DIRECT COST</td>
  <td class=xl54 style='border-left:none'>% Profit</td>
  <td colspan=2 class=xl77 width=130 style='border-right:.5pt solid black;
  border-left:none;width:98pt'>ISSUE INVOICE<span style='mso-spacerun:yes'> 
  </span>(NET)</td>
  <td colspan=2 class=xl87 width=145 style='border-right:.5pt solid black;
  border-left:none;width:109pt'>COLLECTION MONEY<span
  style='mso-spacerun:yes'>   </span>(NET)</td>
  <td class=xl54 style='border-left:none'>TO/INV</td>
  <td class=xl56 style='border-left:none'>INV/COLLEC</td>
  <td class=xl27></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl27 style='height:28.5pt'></td>
  <td class=xl53 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>(A)</td>
  <td class=xl54 style='border-top:none;border-left:none'>(A1)</td>
  <td class=xl54 style='border-top:none;border-left:none'>(A2)</td>
  <td class=xl57 style='border-top:none;border-left:none'>(A3)</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black'>(B)</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>(C)</td>
  <td class=xl54 style='border-top:none;border-left:none'>(A-B)</td>
  <td class=xl56 style='border-top:none;border-left:none'>(B-C)</td>
  <td class=xl27></td>
 </tr>
 <%
    
     DataTable dt_detail = ESysLib.TableReadOpenCursor("sp_sel_gfqc00050_6", l_tac_crcontract_pk);
    //Response.Write(dt.Rows.Count.ToString());
    //Response.End();
    if (dt_detail.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    for (int j = 0; j < dt_detail.Rows.Count; j++)
    { 
 %>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl27 style='height:30.75pt'></td>
  <td class=xl58 style='border-top:none' x:num>1</td>
  <td colspan=2 class=xl59 width=151 style="border-left:none;width:114pt;mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[j][0]%></td>
  <td class=xl60 width=65 style="border-top:none;border-left:none;width:49pt;mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><%=dt_detail.Rows[j][1]%></td>
  <td class=xl60 width=126 style="border-top:none;border-left:none;width:95pt;mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><%=dt_detail.Rows[j][2]%></td>
  <td class=xl60 width=67 style="border-top:none;border-left:none;width:50pt;mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><%=dt_detail.Rows[j][3]%></td>
  <td colspan=2 class=xl59 width=130 style="border-left:none;width:98pt;mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[j][4]%></td>
  <td colspan=2 class=xl89 width=145 style="border-right:.5pt solid black;border-left:none;width:109pt;mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[j][5]%></td>
  <td class=xl59 width=131 style="border-top:none;border-left:none;width:98pt;mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[j][6]%></td>
  <td class=xl61 width=131 style="border-top:none;border-left:none;width:98pt;mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[j][7]%></td>
  <td class=xl27></td>
 </tr>
 <%} %>
 
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl27 style='height:25.5pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl62></td>
  <td colspan=4 class=xl63 style='mso-ignore:colspan'></td>
  <td class=xl62></td>
  <td class=xl63></td>
  <td class=xl62></td>
  <td class=xl63></td>
  <td class=xl64></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl27 style='height:25.5pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl62></td>
  <td colspan=4 class=xl63 style='mso-ignore:colspan'></td>
  <td class=xl62></td>
  <td class=xl63></td>
  <td class=xl62></td>
  <td class=xl63></td>
  <td class=xl64></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl27 style='height:25.5pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl62></td>
  <td colspan=4 class=xl63 style='mso-ignore:colspan'></td>
  <td class=xl62></td>
  <td class=xl63></td>
  <td class=xl62></td>
  <td class=xl63></td>
  <td class=xl64></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl65>&nbsp;</td>
  <td class=xl27></td>
  <td colspan=4 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl69>&nbsp;</td>
  <td class=xl67></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>

 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl26></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black'>Date</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>Repaired by</td>
  <td class=xl57 style='border-left:none'>Checked by</td>
  <td class=xl54>Approved by</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <%
    string  SQL = "SELECT   " +
             "    D.CODE, " +
             "    D.CHAR_1,  " +
             "    D.CHAR_2,  " +
             "    D.CHAR_3,  " +
             "    D.CHAR_4,  " +
             "    D.CHAR_5,  " +
             "    D.REMARK " +
             " FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M " +
             " WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK " +
             " AND M.ID='EACAB012' " +
             " order by D.ORD ";
    DataTable dt1 = ESysLib.TableReadOpen(SQL);
     string n1 = "";
     string n2 = "";
     string n3 = "";
     string n4 = "";
     string n5 = "";
     string n6 = "";
     for (int k = 0; k < dt1.Rows.Count; k++)
     {

         string strTmp = dt1.Rows[k][0].ToString();
         if (strTmp == "NAM")
         {
             n1 = dt1.Rows[k][1].ToString();
             n2 = dt1.Rows[k][2].ToString();
             n3 = dt1.Rows[k][3].ToString();
             n4 = dt1.Rows[k][4].ToString();
             n5 = dt1.Rows[k][5].ToString();
             n6 = dt1.Rows[k][6].ToString();
         }
     }
 %>
  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl26></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 rowspan=4 class=xl76 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black' ></td>
  <td colspan=2 rowspan=4 class=xl91 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'><%=n1 %></td>
  <td rowspan=4 class=xl84 style='border-bottom:.5pt solid black;border-top:
  none'><%=n2 %></td>
  <td rowspan=4 class=xl84 style='border-bottom:.5pt solid black;border-top:
  none'><%=n3 %></td>
  <td class=xl48>&nbsp;</td>
  <td class=xl27></td>
 </tr>


 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl26></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl48>&nbsp;</td>
  <td class=xl27></td>
 </tr>

 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl26></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl48>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl26></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl48>&nbsp;</td>
  <td class=xl27></td>
 </tr>
 
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl27 style='height:13.5pt'></td>
  <td class=xl70>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=0></td>
 </tr>
 <![endif]>
</table>

</body>

</html>