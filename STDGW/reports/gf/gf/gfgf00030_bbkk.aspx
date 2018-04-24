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
    string p_company_pk = "" + Request["company_pk"];
    string p_kindCode = "" + Request["KindCode"];
    string p_DeptPK = "" + Request["DeptPK"];
    string p_Status = "" + Request["Status"];
    string p_AssetNo = "" + Request["AssetNo"];
    string p_AssetName = "" + Request["AssetName"];
    string p_date_from = "" + Request["dtFrom"];
    string p_date_to = "" + Request["dtTo"];
    string p_ccy = "" + Request["ccy"];
    string p_unit = "" + Request["unit"];

     
    string l_parameter = "'" + p_company_pk + "', ";
    l_parameter += "'" + p_kindCode + "', ";
    l_parameter += "'" + p_DeptPK + "', ";
    l_parameter += "'" + p_Status + "', ";
    l_parameter += "'" + p_AssetNo + "', ";
    l_parameter += "'" + p_AssetName + "', ";
    l_parameter += "'" + p_date_from + "', ";
    l_parameter += "'" + p_date_to + "', ";
    l_parameter += "'" + p_unit + "' ";

    DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_60130140_fa_list", l_parameter);
    
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }


    string l_taxcode = "";
    string l_compa = "";
    string l_address = "";

    string SQL1 = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + p_company_pk + "' ";
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);

    if (dt_f.Rows.Count > 0)
    {
        l_compa = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
        l_taxcode = dt_f.Rows[0][3].ToString();
    }
//-------------------------------------------------------------------------
    string l_book_ccy = "";
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
<link rel=File-List
href="Copy%20of%20bienbankiemkeTSCD_05-TSCD_files/filelist.xml">
<link rel=Edit-Time-Data
href="Copy%20of%20bienbankiemkeTSCD_05-TSCD_files/editdata.mso">
<link rel=OLE-Object-Data
href="Copy%20of%20bienbankiemkeTSCD_05-TSCD_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Cuong</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-03-29T01:39:10Z</o:LastPrinted>
  <o:Created>2006-06-29T05:06:28Z</o:Created>
  <o:LastSaved>2010-04-02T10:48:29Z</o:LastSaved>
  <o:Company>abc</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .75in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl38
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
	border-bottom:.5pt solid windowtext;
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl43
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
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
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
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:left;
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
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
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
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
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
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
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
.xl71
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl72
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Mẫu số 05-TSCD(report)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet1</x:CodeName>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>15</x:SplitHorizontal>
     <x:TopRowBottomPane>15</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>25</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Mẫu số 05-TSCD(report)'!$B$15:$N$15</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Mẫu số 05-TSCD(report)'!$13:$15</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1040"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1315 style='border-collapse:
 collapse;table-layout:fixed;width:988pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl24 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=139 style='mso-width-source:userset;mso-width-alt:5083;
 width:104pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl25 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl25 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl25 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl25 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl25 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 width=31 style='height:15.75pt;width:23pt'></td>
  <td colspan=4 class=xl67 width=469 style='width:351pt'>Tên công ty: <%=l_compa%></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl25 width=110 style='width:83pt'></td>
  <td class=xl26 width=47 style='width:35pt'></td>
  <td class=xl26 width=110 style='width:83pt'></td>
  <td class=xl26 width=110 style='width:83pt'></td>
  <td class=xl26 width=47 style='width:35pt'></td>
  <td class=xl26 colspan=2 width=220 style='mso-ignore:colspan;width:166pt'>Mẫu
  số: 05-TSCD</td>
  <td class=xl24 width=61 style='width:46pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=4 class=xl27>Địa chỉ: <%=l_address%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl29
  x:str="                 (Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày "><span
  style='mso-spacerun:yes'>                 </span>(Ban hành theo Quyết định số
  15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>Tax
  Code/MST:&nbsp;&nbsp;<%=l_taxcode%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;&nbsp;&nbsp;<span style='mso-spacerun:yes'>           
  </span>20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 class=xl24 style='height:22.5pt'></td>
  <td colspan=12 class=xl68>BIÊN BẢN KIỂM KÊ TÀI SẢN CỐ ĐỊNH</td>
  <td class=xl30></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td colspan=12 class=xl31></td>
  <td class=xl27></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl32 colspan=6 style='mso-ignore:colspan'>Thời điểm kiểm kê ……………..
  Giờ …………… ngày ………… tháng …………. Năm</td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl32>Ban kiểm kê bao gồm:</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl32 colspan=10 style='mso-ignore:colspan'
  x:str="'- Ông/ Bà ……………………………………………. Chức vụ ………………………… Đại diện …………………………………. Trưởng ban">-
  Ông/ Bà ……………………………………………. Chức vụ ………………………… Đại diện …………………………………. Trưởng
  ban</td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl32 colspan=9 style='mso-ignore:colspan'
  x:str="'- Ông/ Bà ……………………………………………. Chức vụ ………………………… Đại diện …………………………………. Ủy viên">-
  Ông/ Bà ……………………………………………. Chức vụ ………………………… Đại diện …………………………………. Ủy viên</td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl32 colspan=9 style='mso-ignore:colspan'
  x:str="'- Ông/ Bà ……………………………………………. Chức vụ ………………………… Đại diện …………………………………. Ủy viên">-
  Ông/ Bà ……………………………………………. Chức vụ ………………………… Đại diện …………………………………. Ủy viên</td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td class=xl32 colspan=2 style='mso-ignore:colspan'>Đã kiểm kê TSCĐ, kết quả
  như sau:</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl35></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=7 class=xl69>Đơn vị tính:<%=p_ccy%></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl37 height=21 style='height:15.75pt'>
  <td height=21 class=xl38 style='height:15.75pt'>Số</td>
  <td rowspan=2 class=xl38 style='border-bottom:.5pt solid black'>Tên TSCĐ</td>
  <td rowspan=2 class=xl38 style='border-bottom:.5pt solid black;border-top:
  none'>Mã số</td>
  <td rowspan=2 class=xl71 width=139 style='border-bottom:.5pt solid black;
  width:104pt'>Nơi sử dụng</td>
  <td colspan=3 class=xl74 style='border-right:.5pt solid black;border-left:
  none'>Theo số kế toán</td>
  <td colspan=3 class=xl76 style='border-right:.5pt solid black;border-left:
  none'>Theo kiểm kê</td>
  <td colspan=3 class=xl76 style='border-right:.5pt solid black;border-left:
  none'>Chênh lệch</td>
  <td rowspan=2 class=xl38 style='border-bottom:.5pt solid black'>Ghi Chú</td>
 </tr>
 <tr class=xl37 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl39 style='height:30.0pt'>TT</td>
  <td class=xl40 width=47 style='width:35pt'>Số lượng</td>
  <td class=xl41>Nguyên giá</td>
  <td class=xl41>Giá trị còn lại</td>
  <td class=xl40 width=47 style='width:35pt'>Số lượng</td>
  <td class=xl41>Nguyên giá</td>
  <td class=xl41>Giá trị còn lại</td>
  <td class=xl40 width=47 style='width:35pt'>Số lượng</td>
  <td class=xl41>Nguyên giá</td>
  <td class=xl41>Giá trị còn lại</td>
 </tr>
 <tr class=xl37 height=21 style='height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt'>A</td>
  <td class=xl42 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$B$15:$N$15" width=180 style='width:135pt'>B</td>
  <td class=xl42 id="_x0000_s1027" x:autofilter="all" width=103
  style='width:77pt'>C</td>
  <td class=xl42 id="_x0000_s1029" x:autofilter="all" width=139
  style='width:104pt'>D</td>
  <td class=xl41 id="_x0000_s1034" x:autofilter="all" x:num>1</td>
  <td class=xl41 id="_x0000_s1030" x:autofilter="all" x:num>2</td>
  <td class=xl41 id="_x0000_s1031" x:autofilter="all" x:num>3</td>
  <td class=xl41 id="_x0000_s1038" x:autofilter="all" x:num>4</td>
  <td class=xl41 id="_x0000_s1037" x:autofilter="all" x:num>5</td>
  <td class=xl41 id="_x0000_s1036" x:autofilter="all" x:num>6</td>
  <td class=xl41 id="_x0000_s1035" x:autofilter="all" x:num>7</td>
  <td class=xl41 id="_x0000_s1039" x:autofilter="all" x:num>8</td>
  <td class=xl41 id="_x0000_s1032" x:autofilter="all" x:num>9</td>
  <td class=xl43 id="_x0000_s1033" x:autofilter="all">F</td>
 </tr>
 <%
     decimal qty = 0;
     decimal nguyengia = 0;
     decimal remain_Amt = 0;
     int k = 0;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         if (dt.Rows[i][11].ToString().Trim() != "")
         {
             qty += decimal.Parse(dt.Rows[i][11].ToString());
         }
         else
         {
             qty += 0;
         }

         if (dt.Rows[i][6].ToString().Trim() != "")
         {
             nguyengia += decimal.Parse(dt.Rows[i][6].ToString());
         }
         else
         {
             nguyengia += 0;
         }

         if (dt.Rows[i][9].ToString().Trim() != "")
         {
             remain_Amt += decimal.Parse(dt.Rows[i][9].ToString());
         }
         else
         {
             remain_Amt += 0;
         }
  %>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl44 align=right style='height:15.75pt;text-align:center' x:num><%=k+1%></td>
  <td class=xl45><%=dt.Rows[i][3]%></td>
  <td class=xl46 style="text-align:left"><%=dt.Rows[i][4]%> - <%=dt.Rows[i][2]%></td>
  <td class=xl47 width=139 style='width:104pt'><%=dt.Rows[i][10]%></td>
  <td class=xl48 style="text-align:right" ><span style='mso-spacerun:yes;'> </span><%=dt.Rows[i][11]%></td>
  <td class=xl80 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][6]%></td>
  <td class=xl80 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][9]%></td>
  <td class=xl48 ><span style='mso-spacerun:yes'> </span></td>
  <td class=xl80 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl80 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl48 ><span style='mso-spacerun:yes'> </span> </td>
  <td class=xl80 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl80 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl49></td>
 </tr>
 <% k += 1;
} %>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl50 style='height:15.75pt'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53 width=139 style='width:104pt'>Cộng</td>
  <td class=xl54 style="text-align:right" ><span
  style='mso-spacerun:yes;'> </span><%=qty%></td>
  <td class=xl81 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=nguyengia%></td>
  <td class=xl81 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=remain_Amt%></td>
  <td class=xl54 ><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl82 ><span style='mso-spacerun:yes'> </span> </td>
  <td class=xl82 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl54 ><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl82 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl82 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl55>&nbsp;</td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl27 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'></td>
  <td colspan=6 class=xl78></td>
  <td colspan=5 class=xl56 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'></td>
  <td colspan=4 class=xl57 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=4 class=xl58 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl79>Ngày …. Tháng .. Năm</td>
  <td class=xl59></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'></td>
  <td colspan=2 class=xl60>Giám đốc</td>
  <td class=xl27></td>
  <td class=xl61></td>
  <td class=xl28></td>
  <td class=xl60>Kế toán trưởng</td>
  <td colspan=3 class=xl62 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl60>Trưởng ban kiểm kê</td>
  <td class=xl63></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'></td>
  <td colspan=2 class=xl31>(Ghi ý kiến giải quyết số chênh lệch)</td>
  <td class=xl27></td>
  <td class=xl64></td>
  <td class=xl28></td>
  <td class=xl65>( ký, họ tên )</td>
  <td colspan=3 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl65>( ký, họ tên )</td>
  <td class=xl59></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'></td>
  <td colspan=2 class=xl65>( ký, họ tên, đóng dấu )</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl27 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl27 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=139 style='width:104pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=61 style='width:46pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
