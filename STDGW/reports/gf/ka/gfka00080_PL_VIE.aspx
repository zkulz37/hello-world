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
    string l_kind    = Request["p_kind"];
    string l_date    = Request["p_date"];
    

    string l_cmp_name = "";
    string l_cmp_add = "";
    string l_cmp_taxcode = "";
    int i;
    
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
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:Created>2008-09-08T09:45:40Z</o:Created>
  <o:LastSaved>2008-09-08T09:49:30Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .5in 1.0in .5in;
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
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl29
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style21;
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
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style21;
	font-size:15.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022For the year ended\0022\\ dd\\ mmmm\\ yyyy";
	text-align:left;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style21;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl47
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style21;
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
.xl59
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
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl61
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style21;
	font-size:11.0pt;
	
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style16;
	color:blue;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style16;
	color:green;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style16;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl72
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl74
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl76
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl81
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	vertical-align:middle;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ \\ dd\\\,\\ \\ yyyy";
	text-align:center;
	vertical-align:middle;}
.xl85
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl86
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl88
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl89
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
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
.xl91
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
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
.xl94
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl95
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>IC</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8835</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl29>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1560 style='border-collapse:
 collapse;table-layout:fixed;width:1174pt'>
 <col class=xl29 width=390 style='mso-width-source:userset;mso-width-alt:14262;
 width:293pt'>
 <col class=xl42 width=58 span=2 style='mso-width-source:userset;mso-width-alt:
 2121;width:44pt'>
 <col class=xl80 width=138 span=2 style='mso-width-source:userset;mso-width-alt:
 5046;width:104pt'>
 <col class=xl29 width=14 style='mso-width-source:userset;mso-width-alt:512;
 width:11pt'>
 <col class=xl37 width=355 style='mso-width-source:userset;mso-width-alt:12982;
 width:266pt'>
 <col class=xl81 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl81 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl31 width=138 span=2 style='mso-width-source:userset;mso-width-alt:
 5046;width:104pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl25 width=390 style='height:18.75pt;width:293pt'><%=l_cmp_name%></td>
  <td class=xl26 width=58 style='width:44pt'></td>
  <td class=xl26 width=58 style='width:44pt'></td>
  <td class=xl27 width=138 style='width:104pt'></td>
  <td class=xl28 width=138 style='width:104pt'>M&#7851;u s&#7889;: B02 - DN</td>
  <td class=xl29 width=14 style='width:11pt'></td>
  
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&#272;&#7883;a ch&#7881;:&nbsp;<%=l_cmp_add %></td>
  <td class=xl26></td>
  <td colspan=3 class=xl34
  x:str="(Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày ">(Ban
  hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
 
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 style='height:15.0pt'></td>
  <td class=xl35></td>
  <td colspan=3 class=xl34>20 tháng 03 n&#259;m 2006 c&#7911;a B&#7897;
  tr&#432;&#7901;ng B&#7897; Tài chính)</td>
  <td class=xl29></td>
 
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl29 style='height:9.95pt'></td>
  <td colspan=4 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl37></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=5 height=26 class=xl38 style='height:19.5pt'>BÁO CÁO K&#7870;T
  QU&#7842; HO&#7840;T &#272;&#7896;NG KINH DOANH</td>
  <td class=xl29></td>
  
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=5 height=21 class=xl39 style='height:15.75pt'>Cho niên
  &#273;&#7897; k&#7871;t thúc vào ngày<span style='mso-spacerun:yes'> 
  </span><%=l_date.Substring(6, 2)%>/<%=l_date.Substring(4, 2)%>/<%=l_date.Substring(0, 4)%></td>
  
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl41 style='height:15.75pt'></td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl43>(&#272;&#417;n v&#7883; tính: VND)</td>
  <td class=xl29></td>
  
 </tr>
 <tr class=xl50 height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl47 style='height:33.75pt'>Ch&#7881; tiêu</td>
  <td class=xl47 style='border-left:none'>Mã s&#7889;</td>
  <td class=xl48 width=58 style='border-left:none;width:44pt'>Thuy&#7871;t
  <br>
    minh</td>
  <td class=xl49 style='border-left:none' x:str="N&#259;m nay"><span
  style='mso-spacerun:yes'> </span>N&#259;m nay<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl49 style='border-left:none' x:str="N&#259;m tr&#432;&#7899;c"><span
  style='mso-spacerun:yes'> </span>N&#259;m tr&#432;&#7899;c<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50></td>
  
 </tr>
 <tr class=xl50 height=19 style='height:14.25pt'>
  <td height=19 class=xl55 style='height:14.25pt;border-top:none' x:num>1</td>
  <td class=xl55 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl55 width=58 style='border-top:none;border-left:none;width:44pt'
  x:num>3</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl50></td>
  
 </tr>
 <%
    if (dt_detail.Rows.Count >0)
	{
        string strBegin = "";
        string strEnd   = "";

        for (i = 0; i < dt_detail.Rows.Count - 1; i++)
	    {
            strBegin    = "";
            strEnd      = "";
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
 
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl61 style='height:19.5pt'><%=strBegin%><%= dt_detail.Rows[i][0].ToString() %><%=strEnd%><%=dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl62 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i][3].ToString() %><%=strEnd%></td>
  <td class=xl63 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i][4].ToString() %><%=strEnd%></td>
  <td class=xl64 style='border-left:none'x:num><%=strBegin%><%= dt_detail.Rows[i][5].ToString() %><%=strEnd%></td>
  <td class=xl64 style='border-left:none'x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  
 </tr>
<%
        }
%>
  <tr class=xl50 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl76 style='height:19.5pt'><%=strBegin%><%= dt_detail.Rows[i][0].ToString() %><%=strEnd%></td>
  <td class=xl77 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][3].ToString() %><%=strEnd%></td>
  <td class=xl77 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i][4].ToString() %><%=strEnd%></td>
  <td class=xl78 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][5].ToString() %><%=strEnd%></td>
  <td class=xl78 style='border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl50></td>
  
 </tr>
 <%
    } 
 %>
 
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl29 style='height:19.5pt'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83>T&#7841;i ngày<span style='mso-spacerun:yes'> 
  </span><%=l_date.Substring(6, 2)%>/<%=l_date.Substring(4, 2)%>/<%=l_date.Substring(0, 4)%></td>
  <td class=xl29></td>
 
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl85 style='height:15.0pt'
  x:str="                          Ng&#432;&#7901;i l&#7853;p bi&#7875;u                              "><span
  style='mso-spacerun:yes'>                          </span>Ng&#432;&#7901;i
  l&#7853;p bi&#7875;u<span
  style='mso-spacerun:yes'>                              </span></td>
  <td class=xl50 colspan=2 style='mso-ignore:colspan'
  x:str="K&#7871; Toán Tr&#432;&#7903;ng                                 ">K&#7871;
  Toán Tr&#432;&#7903;ng <span style='display:none'><span
  style='mso-spacerun:yes'>                                </span></span></td>
  <td colspan=2 class=xl86 x:str=" T&#7893;ng Giám &#272;&#7889;c "><span
  style='mso-spacerun:yes'>  </span>T&#7893;ng Giám &#272;&#7889;c<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl29></td>
  
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>(Ký, h&#7885; tên)</td>
  <td colspan=2 class=xl40>(Ký, h&#7885; tên)</td>
  <td colspan=2 class=xl88 x:str="(Ký, h&#7885; tên, &#273;óng d&#7845;u)"><span
  style='mso-spacerun:yes'> </span>(Ký, h&#7885; tên, &#273;óng d&#7845;u)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29></td>
  
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td class=xl35></td>
  <td class=xl42></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td class=xl35></td>
  <td class=xl42></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td class=xl35></td>
  <td class=xl42></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td class=xl35></td>
  <td class=xl42></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  
 </tr>
 <tr class=xl91 height=21 style='height:15.75pt'>
  <td height=21 class=xl89 style='height:15.75pt'></td>
  <td colspan=2 class=xl89></td>
  <td colspan=2 class=xl90 x:str=""><span
  style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl91></td>
  
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl85 style='height:15.75pt'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl85 style='height:15.75pt'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
 
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl85 style='height:15.75pt'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl94></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl95 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl85 style='height:15.75pt'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl94></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl95 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl85 style='height:15.75pt'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl94></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl95 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl85 style='height:15.75pt'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl94></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl95 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl94></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl95 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=390 style='width:293pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=14 style='width:11pt'></td>
  <td width=355 style='width:266pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
