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
    string l_company = Request["p_company_pk"];
    string l_kind = Request["p_kind"];
    string l_date = Request["p_date"];

    string l_cmp_name = "";
    string l_cmp_add = "";
    string l_cmp_taxcode = "";
    int    i;
    
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL1);
    if (dt.Rows.Count > 0)
    {
        l_cmp_name = dt.Rows[0][0].ToString();
        l_cmp_add = dt.Rows[0][1].ToString();
        l_cmp_taxcode = dt.Rows[0][3].ToString();
    }

    string SQL= " SELECT T.PRN_ACNM, T.PRN_LACNM, T.PRN_KACNM, T.CODE, T.HEADER,";
    SQL = SQL + "        T.FORMULAR_ACC,    ";
    SQL = SQL + "        T.FORMULAR2,       ";
    SQL = SQL + "        T.FONT_STYPE       ";
    SQL = SQL + "   FROM TAC_KAFINANCEFORM T";
    SQL = SQL + "  WHERE T.FORM_TYPE = '" + l_kind + "'";
    SQL = SQL + "    AND DEL_IF      = 0 ";
    SQL = SQL + "  ORDER BY form_type, prn_seq";

    DataTable dt_detail = ESysLib.TableReadOpen(SQL);
  
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book2_files/filelist.xml">
<link rel=Edit-Time-Data href="Book2_files/editdata.mso">
<link rel=OLE-Object-Data href="Book2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2008-09-16T06:20:47Z</o:LastPrinted>
  <o:Created>2008-09-16T06:17:58Z</o:Created>
  <o:LastSaved>2008-09-16T06:21:46Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .5in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
.style21
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
	mso-style-name:Normal_Bctc50;}
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
.xl25
	{mso-style-parent:style21;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl31
	{mso-style-parent:style21;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl39
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl41
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl42
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style21;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl47
	{mso-style-parent:style21;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl49
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl65
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl68
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
.xl69
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl73
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl78
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl80
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl86
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl94
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl95
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl96
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl97
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl98
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl101
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl103
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl104
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl105
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl106
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl107
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl108
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl109
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl110
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl111
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl112
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl113
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl114
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;}
.xl115
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;}
.xl116
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;}
.xl117
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl118
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022Trang \00220";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl119
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl120
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl121
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl122
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022Page \00220";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl123
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl124
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
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl125
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
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl127
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl128
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl129
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl130
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl131
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl132
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl133
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl134
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl135
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl136
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl137
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl138
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl139
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl140
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl141
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl142
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl143
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl144
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl145
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl146
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	mso-protection:unlocked visible;}
.xl147
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl148
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl149
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl150
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl151
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl152
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl153
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl154
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl155
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl156
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	mso-protection:unlocked visible;}
.xl157
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl158
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl159
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl160
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl161
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl162
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl163
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl164
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl165
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl166
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;
	mso-protection:unlocked visible;}
.xl167
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl168
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl169
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl170
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl171
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl172
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl173
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	mso-protection:unlocked visible;}
.xl174
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl175
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl176
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl177
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl178
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl179
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl180
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl181
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl182
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl183
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl184
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl185
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ \\ dd\\ \\ \\ yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl186
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl187
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl188
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl189
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl190
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl191
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ \\ dd\\\,\\ \\ yyyy";
	text-align:center;
	vertical-align:middle;}
.xl192
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl193
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl194
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl195
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl196
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl197
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl198
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl199
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl200
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl201
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl202
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl203
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl204
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;}
.xl205
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;}
.xl206
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>61</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl30>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1480 style='border-collapse:
 collapse;table-layout:fixed;width:1114pt'>
 <col class=xl30 width=334 style='mso-width-source:userset;mso-width-alt:12214;
 width:251pt'>
 <col class=xl30 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl27 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl28 width=138 span=2 style='mso-width-source:userset;mso-width-alt:
 5046;width:104pt'>
 <col class=xl30 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl30 width=334 style='mso-width-source:userset;mso-width-alt:12214;
 width:251pt'>
 <col class=xl30 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl30 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl28 width=138 span=2 style='mso-width-source:userset;mso-width-alt:
 5046;width:104pt'>
 <col class=xl30 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl25 colspan=4 width=587 style='height:18.75pt;
  mso-ignore:colspan;width:442pt'><%=l_cmp_name%></td>
  <td class=xl29 width=138 style='width:104pt'>M&#7851;u s&#7889;: B01 - DN</td>
  <td class=xl30 width=15 style='width:11pt'></td>
  <td class=xl25 width=334 style='width:251pt'><%=l_cmp_name%></td>
  <td class=xl31 width=54 style='width:41pt'></td>
  <td class=xl32 width=61 style='width:46pt'></td>
  <td class=xl33 width=138 style='width:104pt'></td>
  <td class=xl34 width=138 style='width:104pt'>Form: B 01 - DN</td>
  <td class=xl30 width=15 style='width:11pt'></td>
 </tr>
 <tr class=xl38 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style='height:15.0pt'>&#272;&#7883;a ch&#7881;:&nbsp;<%=l_cmp_add %></td>
  <td class=xl36></td>
  <td colspan=3 class=xl37
  x:str="(Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày ">(Ban
  hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl38></td>
  <td class=xl35>&#272;&#7883;a ch&#7881;:&nbsp;<%=l_cmp_add %></td>
  <td class=xl39></td>
  <td colspan=3 class=xl37
  x:str="(Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày ">(Ban
  hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl38></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt'></td>
  <td class=xl41></td>
  <td colspan=3 class=xl37>20 tháng 03 n&#259;m 2006 c&#7911;a B&#7897;
  tr&#432;&#7901;ng B&#7897; Tài chính)</td>
  <td class=xl30></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td colspan=3 class=xl37>20 tháng 03 n&#259;m 2006 c&#7911;a B&#7897;
  tr&#432;&#7901;ng B&#7897; Tài chính)</td>
  <td class=xl30></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl40 style='height:9.95pt'></td>
  <td class=xl41></td>
  <td colspan=3 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl32></td>
  <td class=xl33></td>
  <td class=xl45></td>
  <td class=xl30></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=5 height=26 class=xl46 style='height:19.5pt'>B&#7842;NG CÂN
  &#272;&#7888;I K&#7870; TOÁN</td>
  <td class=xl30></td>
  <td colspan=5 class=xl47>BALANCE SHEET</td>
  <td class=xl30></td>
 </tr>
 <tr class=xl38 height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl48 style='height:15.0pt'>T&#7841;i ngày
  <%=l_date.Substring(6, 2)%>/<%=l_date.Substring(4, 2)%>/<%=l_date.Substring(0, 4)%></td>
  <td class=xl38></td>
  <td colspan=5 class=xl49>As at <%=l_date.Substring(6, 2)%>/<%=l_date.Substring(4, 2)%>/<%=l_date.Substring(0, 4)%></td>
  <td class=xl38></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl41 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl50></td>
  <td class=xl51 x:str="(&#272;&#417;n v&#7883; tính: VND)"><span
  style='mso-spacerun:yes'> </span>(&#272;&#417;n v&#7883; tính: VND)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl30></td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl33></td>
  <td class=xl45>(Currency : VND)</td>
  <td class=xl30></td>
 </tr>
 <tr class=xl38 height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl53 style='height:39.75pt'>TÀI S&#7842;N</td>
  <td class=xl54 width=54 style='border-left:none;width:41pt'>Mã<br>
    s&#7889;</td>
  <td class=xl55 width=61 style='border-left:none;width:46pt'>Thuy&#7871;t
  <br>
    minh</td>
  <td class=xl56 style='border-left:none'>S&#7889; d&#432; cu&#7889;i k&#7923;</td>
  <td class=xl57 style='border-left:none'>S&#7889; &#273;&#7847;u n&#259;m</td>
  <td class=xl38></td>
  <td class=xl58>ASSETS</td>
  <td class=xl59 style='border-left:none'>CODE</td>
  <td class=xl59 style='border-left:none'>NOTES</td>
  <td class=xl56 style='border-left:none'>CLOSING</td>
  <td class=xl56 style='border-left:none'>OPENNING</td>
  <td class=xl38></td>
 </tr>
 <tr class=xl38 height=20 style='height:15.0pt'>
  <td height=20 class=xl60 style='height:15.0pt;border-top:none' x:num>1</td>
  <td class=xl54 width=54 style='border-top:none;border-left:none;width:41pt'
  x:num>2</td>
  <td class=xl55 width=61 style='border-top:none;border-left:none;width:46pt'>3</td>
  <td class=xl57 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl57 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl38></td>
  <td class=xl59 style='border-top:none' x:num x:fmla="=A9">1</td>
  <td class=xl59 style='border-top:none;border-left:none' x:num x:fmla="=B9">2</td>
  <td class=xl61 style='border-top:none;border-left:none' x:fmla="=C9">3</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num x:fmla="=D9">4</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num x:fmla="=E9">5</td>
  <td class=xl38></td>
 </tr>
 
 <%
    
    if (dt_detail.Rows.Count >0)
	{
        string strBegin = "";
        string strEnd = "";
        
	    for(i = 0; i < 52; i++)
	    {
            strBegin = "";
            strEnd = "";
            if (dt_detail.Rows[i][7].ToString() == "I")
            {
                strBegin = "<i>";
                strEnd = "</i>";
            }
            if (dt_detail.Rows[i][7].ToString() == "B")
            {
                strBegin = "<b>";
                strEnd = "</b>";
            }
 %>
 
 <tr class=xl38 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl77 style='height:19.5pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i][0].ToString() %><%=strEnd%></td>
  <td class=xl78 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][3].ToString() %><%=strEnd%></td>
  <td class=xl79 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][4].ToString() %><%=strEnd%></td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][5].ToString() %><%=strEnd%></td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl81></td>
  <td class=xl82 style='border-top:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][3].ToString() %><%=strEnd%></td>
  <td class=xl83 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][4].ToString() %><%=strEnd%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][5].ToString() %><%=strEnd%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl81></td>
 </tr>
<%
        }
%>
<tr class=xl38 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl102 style='height:19.5pt'>T&#7893;ng c&#7897;ng tài
  s&#7843;n (270 = 100 + 200)</td>
  <td class=xl103 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][3].ToString() %><%=strEnd%></td>
  <td class=xl104 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i][4].ToString() %><%=strEnd%></td>
  <td class=xl105 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][5].ToString() %><%=strEnd%></td>
  <td class=xl105 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl66></td>
  <td class=xl58>TOTAL ASSETS (270 = 100 + 200)</td>
  <td class=xl59 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][3].ToString() %><%=strEnd%></td>
  <td class=xl59 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i][4].ToString() %><%=strEnd%></td>
  <td class=xl106 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][5].ToString() %><%=strEnd%></td>
  <td class=xl106 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl66></td>
 </tr>
<%
 }
%>
 
 
 <tr class=xl38 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl107 style='height:19.5pt'></td>
  <td class=xl108></td>
  <td class=xl109></td>
  <td colspan=2 class=xl110 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl111></td>
  <td colspan=2 class=xl112 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl113 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
 </tr>
 <tr class=xl38 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl114 style='height:19.5pt'>&nbsp;</td>
  <td class=xl115>&nbsp;</td>
  <td class=xl116>&nbsp;</td>
  <td class=xl117>&nbsp;</td>
  <td class=xl118>&nbsp;</td>
  <td class=xl66></td>
  <td class=xl119><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl120>&nbsp;</td>
  <td class=xl120>&nbsp;</td>
  <td class=xl121>&nbsp;</td>
  <td class=xl122>&nbsp;</td>
  <td class=xl66></td>
 </tr>
 <tr class=xl38 height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl53 style='height:39.75pt'>NGU&#7890;N V&#7888;N</td>
  <td class=xl54 width=54 style='border-left:none;width:41pt'>Mã<br>
    s&#7889;</td>
  <td class=xl55 width=61 style='border-left:none;width:46pt'>Thuy&#7871;t
  <br>
    minh</td>
  <td class=xl123 style='border-left:none' x:str="S&#7889; d&#432; cu&#7889;i k&#7923;"
  x:fmla="=+D8"><span style='mso-spacerun:yes'> </span>S&#7889; d&#432;
  cu&#7889;i k&#7923;<span style='mso-spacerun:yes'> </span></td>
  <td class=xl123 style='border-left:none' x:str="S&#7889; &#273;&#7847;u n&#259;m"
  x:fmla="=+E8"><span style='mso-spacerun:yes'> </span>S&#7889; &#273;&#7847;u
  n&#259;m<span style='mso-spacerun:yes'> </span></td>
  <td class=xl38></td>
  <td class=xl58>RESOURCES</td>
  <td class=xl59 style='border-left:none'>CODE</td>
  <td class=xl59 style='border-left:none'>NOTES</td>
  <td class=xl56 style='border-left:none' x:fmla="=+J8">CLOSING</td>
  <td class=xl56 style='border-left:none' x:fmla="=+K8">OPENNING</td>
  <td class=xl38></td>
 </tr>
 <tr class=xl38 height=20 style='height:15.0pt'>
  <td height=20 class=xl124 style='height:15.0pt' x:num>1</td>
  <td class=xl125 width=54 style='border-left:none;width:41pt' x:num>2</td>
  <td class=xl126 width=61 style='border-left:none;width:46pt'>3</td>
  <td class=xl127 style='border-left:none' x:num>4</td>
  <td class=xl127 style='border-left:none' x:num>5</td>
  <td class=xl38></td>
  <td class=xl60 style='border-top:none' x:num>1</td>
  <td class=xl54 width=54 style='border-top:none;border-left:none;width:41pt'
  x:num>2</td>
  <td class=xl55 width=61 style='border-top:none;border-left:none;width:46pt'>3</td>
  <td class=xl57 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl57 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl38></td>
 </tr>
 <%
    
    if (dt_detail.Rows.Count >0)
	{
        string strBegin = "";
        string strEnd = "";
        
	    for(i = 54; i < dt_detail.Rows.Count - 1; i++)
	    {
            strBegin = "";
            strEnd = "";
            if (dt_detail.Rows[i][7].ToString() == "I")
            {
                strBegin = "<i>";
                strEnd = "</i>";
            }
            if (dt_detail.Rows[i][7].ToString() == "B")
            {
                strBegin = "<b>";
                strEnd = "</b>";
            }
 %> 
 <tr class=xl38 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl77 style='height:19.5pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i][0].ToString() %><%=strEnd%></td>
  <td class=xl78 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][3].ToString() %><%=strEnd%></td>
  <td class=xl79 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][4].ToString() %><%=strEnd%></td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][5].ToString() %><%=strEnd%></td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl38></td>
  <td class=xl82 style='border-top:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][3].ToString() %><%=strEnd%></td>
  <td class=xl83 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][4].ToString() %><%=strEnd%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][5].ToString() %><%=strEnd%></td>
  <td class=xl101 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl38></td>
 </tr>
 <%
        }
%>
 <tr class=xl38 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl102 style='height:27.75pt;border-top:none'>T&#7893;ng
  c&#7897;ng ngu&#7891;n v&#7889;n (440 = 300 + 400)</td>
  <td class=xl103 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][3].ToString() %><%=strEnd%></td>
  <td class=xl104 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][4].ToString() %><%=strEnd%></td>
  <td class=xl105 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][5].ToString() %><%=strEnd%></td>
  <td class=xl105 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl81></td>
  <td class=xl138 width=334 style='width:251pt'>TOTAL LIABILITIES AND OWNERS'
  EQUITY<br>
    <span style='mso-spacerun:yes'> </span>(440 = 300 + 400)</td>
  <td class=xl59 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][3].ToString() %><%=strEnd%></td>
  <td class=xl59 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i][4].ToString() %><%=strEnd%></td>
  <td class=xl106 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][5].ToString() %><%=strEnd%></td>
  <td class=xl106 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl81></td>
 </tr>
 <%
        }
%>
 
 <tr class=xl38 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl38 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl139></td>
  <td colspan=2 class=xl140 style='mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td colspan=2 class=xl141 style='mso-ignore:colspan'></td>
  <td class=xl142></td>
  <td colspan=2 class=xl143 style='mso-ignore:colspan'></td>
  <td class=xl81></td>
 </tr>
 <tr class=xl38 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl108 style='height:18.0pt'>TÀI KHO&#7842;N
  NGOÀI B&#7842;NG</td>
  <td class=xl81></td>
  <td colspan=5 class=xl112>OFF BALANCE SHEET ITEMS</td>
  <td class=xl81></td>
 </tr>
 <tr class=xl38 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl38 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl139></td>
  <td colspan=2 class=xl140 style='mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td colspan=2 class=xl141 style='mso-ignore:colspan'></td>
  <td class=xl142></td>
  <td class=xl144></td>
  <td class=xl145></td>
  <td class=xl81></td>
 </tr>
 <tr class=xl38 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl146 style='height:18.0pt'>Kho&#7843;n m&#7909;c</td>
  <td class=xl147>&nbsp;</td>
  <td class=xl148 style='border-left:none'>TM</td>
  <td class=xl149 style='border-left:none' x:str="S&#7889; d&#432; cu&#7889;i k&#7923;"
  x:fmla="=+D65"><span style='mso-spacerun:yes'> </span>S&#7889; d&#432;
  cu&#7889;i k&#7923;<span style='mso-spacerun:yes'> </span></td>
  <td class=xl150 style='border-left:none' x:str="S&#7889; &#273;&#7847;u n&#259;m"
  x:fmla="=+E65"><span style='mso-spacerun:yes'> </span>S&#7889; &#273;&#7847;u
  n&#259;m<span style='mso-spacerun:yes'> </span></td>
  <td class=xl81></td>
  <td class=xl151>ITEMS</td>
  <td class=xl152>&nbsp;</td>
  <td class=xl153>Notes</td>
  <td class=xl154 x:fmla="=+J65">CLOSING</td>
  <td class=xl155 style='border-left:none' x:fmla="=+K65">OPENNING</td>
  <td class=xl81></td>
 </tr>
 <tr class=xl38 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl156 style='height:18.0pt'>1. Tài s&#7843;n thuê ngoài</td>
  <td class=xl157>&nbsp;</td>
  <td class=xl158>&nbsp;</td>
  <td class=xl159 style='border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl160 style='border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
  <td class=xl161 style='border-top:none'>1. Operating lease assets</td>
  <td class=xl162>&nbsp;</td>
  <td class=xl163>&nbsp;</td>
  <td class=xl164 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=+D109"><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl165 style='border-top:none' x:num="0" x:fmla="=+E109"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
 </tr>
 <tr class=xl38 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl166 style='height:18.0pt;border-top:none'>2. V&#7853;t
  t&#432;, hàng hóa nh&#7853;n gi&#7919; h&#7897;, nh&#7853;n ký g&#7917;i</td>
  <td class=xl167 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
  <td class=xl169 style='border-top:none'>2. Goods held under trust or for
  processing</td>
  <td class=xl170 style='border-top:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none'>&nbsp;</td>
  <td class=xl171 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=+D110"><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl172 style='border-top:none' x:num="0" x:fmla="=+E110"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
 </tr>
 <tr class=xl38 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl166 style='height:18.0pt;border-top:none'>3. Hàng hóa
  nh&#7853;n bán h&#7897;, nh&#7853;n ký g&#7917;i</td>
  <td class=xl167 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
  <td class=xl169 style='border-top:none'>3. Goods received on consignment for
  sale</td>
  <td class=xl170 style='border-top:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none'>&nbsp;</td>
  <td class=xl171 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=+D111"><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl172 style='border-top:none' x:num="0" x:fmla="=+E111"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
 </tr>
 <tr class=xl38 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl166 style='height:18.0pt;border-top:none'>4. N&#7907;
  khó &#273;òi &#273;ã x&#7919; lý</td>
  <td class=xl167 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
  <td class=xl169 style='border-top:none'>4. Bad debts written off</td>
  <td class=xl170 style='border-top:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none'>&nbsp;</td>
  <td class=xl171 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=+D112"><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl172 style='border-top:none' x:num="0" x:fmla="=+E112"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
 </tr>
 <tr class=xl38 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl166 style='height:18.0pt;border-top:none'>5.
  Ng&#7885;ai t&#7879; các l&#7885;ai</td>
  <td class=xl167 style='border-top:none'>&nbsp;</td>
  <td class=xl77 style='border-top:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl168 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
  <td class=xl169 style='border-top:none'>5. Foreign currencies</td>
  <td class=xl170 style='border-top:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none'>&nbsp;</td>
  <td class=xl171 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=+D113"><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl172 style='border-top:none' x:num="0" x:fmla="=+E113"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
 </tr>
 <tr class=xl38 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl173 style='height:18.0pt;border-top:none'>6. D&#7921;
  tóan chi s&#7921; nghi&#7879;p, d&#7921; án</td>
  <td class=xl174 style='border-top:none'>&nbsp;</td>
  <td class=xl175 style='border-top:none'>&nbsp;</td>
  <td class=xl176 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl177 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
  <td class=xl178 style='border-top:none'>6. Subsidies of state budget</td>
  <td class=xl179 style='border-top:none'>&nbsp;</td>
  <td class=xl180 style='border-top:none'>&nbsp;</td>
  <td class=xl181 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=+D114"><span style='mso-spacerun:yes'> </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl182 style='border-top:none' x:num="0" x:fmla="=+E114"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl81></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl30 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl183 style='mso-ignore:colspan'></td>
  <td class=xl184></td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl185>&nbsp;</td>
  <td class=xl184></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl186 style='height:18.0pt'></td>
  <td colspan=2 class=xl187 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl188>T&#7841;i ngày<span style='mso-spacerun:yes'> 
  </span><%=l_date.Substring(6, 2)%>/<%=l_date.Substring(4, 2)%>/<%=l_date.Substring(0, 4)%></td>
  <td class=xl184></td>
  <td class=xl189></td>
  <td colspan=2 class=xl190 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl191>At dated<span style='mso-spacerun:yes'> 
  </span><%=l_date.Substring(6, 2)%>/<%=l_date.Substring(4, 2)%>/<%=l_date.Substring(0, 4)%></td>
  <td class=xl184></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl192 style='height:18.0pt'
  x:str="                          Ng&#432;&#7901;i l&#7853;p bi&#7875;u                              "><span
  style='mso-spacerun:yes'>                          </span>Ng&#432;&#7901;i
  l&#7853;p bi&#7875;u<span
  style='mso-spacerun:yes'>                              </span></td>
  <td class=xl39 colspan=2 style='mso-ignore:colspan'
  x:str="K&#7871; Toán Tr&#432;&#7903;ng                                 ">K&#7871;
  Toán Tr&#432;&#7903;ng <span style='display:none'><span
  style='mso-spacerun:yes'>                                </span></span></td>
  <td colspan=2 class=xl193 x:str=" T&#7893;ng Giám &#272;&#7889;c "><span
  style='mso-spacerun:yes'>  </span>T&#7893;ng Giám &#272;&#7889;c<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl194></td>
  <td class=xl192>Prepared by</td>
  <td class=xl39 colspan=2 style='mso-ignore:colspan'
  x:str="Chief Accountant                                ">Chief Accountant<span
  style='display:none'><span
  style='mso-spacerun:yes'>                                </span></span></td>
  <td colspan=2 class=xl112>General Director</td>
  <td class=xl194></td>
 </tr>
 <tr class=xl196 height=21 style='height:15.75pt'>
  <td height=21 class=xl49 style='height:15.75pt'>(Ký, h&#7885; tên)</td>
  <td colspan=2 class=xl49>(Ký, h&#7885; tên)</td>
  <td colspan=2 class=xl195 x:str="(Ký, h&#7885; tên, &#273;óng d&#7845;u)"><span
  style='mso-spacerun:yes'> </span>(Ký, h&#7885; tên, &#273;óng d&#7845;u)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl196></td>
  <td class=xl49>(Sign, Fullname)</td>
  <td colspan=2 class=xl49>(Sign, Fullname)</td>
  <td colspan=2 class=xl195 x:str="(Sign, Fullname, Stamp)"><span
  style='mso-spacerun:yes'> </span>(Sign, Fullname, Stamp)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl196></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl186 style='height:15.75pt'></td>
  <td class=xl197></td>
  <td class=xl187></td>
  <td colspan=2 class=xl198 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl189></td>
  <td colspan=2 class=xl190 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl199 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl186 style='height:15.75pt'></td>
  <td class=xl197></td>
  <td class=xl187></td>
  <td colspan=2 class=xl198 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl189></td>
  <td colspan=2 class=xl190 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl199 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl186 style='height:15.75pt'></td>
  <td class=xl197></td>
  <td class=xl187></td>
  <td colspan=2 class=xl198 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl189></td>
  <td colspan=2 class=xl190 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl199 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl186 style='height:18.0pt'></td>
  <td class=xl197></td>
  <td class=xl187></td>
  <td colspan=2 class=xl198 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td class=xl189></td>
  <td colspan=2 class=xl190 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl199 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl200 style='height:15.75pt'></td>
  <td colspan=2 class=xl200></td>
  <td colspan=2 class=xl201 x:str=""><span
  style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl194></td>
  <td class=xl202></td>
  <td colspan=2 class=xl200></td>
  <td colspan=2 class=xl203 x:str=""><span
  style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl194></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl30 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl204 style='height:15.75pt'>&nbsp;</td>
  <td class=xl204>&nbsp;</td>
  <td class=xl205>&nbsp;</td>
  <td class=xl206>&nbsp;</td>
  <td class=xl118>&nbsp;</td>
  <td class=xl30></td>
  <td class=xl204>&nbsp;</td>
  <td class=xl204>&nbsp;</td>
  <td class=xl204>&nbsp;</td>
  <td class=xl206>&nbsp;</td>
  <td class=xl122>&nbsp;</td>
  <td class=xl30></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=334 style='width:251pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=15 style='width:11pt'></td>
  <td width=334 style='width:251pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=15 style='width:11pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
