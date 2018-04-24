<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
    ESysLib.SetUser("acnt");
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
 string aa = Request["p_company"];
   
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE, TO_CHAR(sysdate,'DD')  RP_DD, TO_CHAR(sysdate,'MM')  RP_MM , TO_CHAR(sysdate,'YYYY')  RP_yyyy FROM TCO_COMPANY WHERE PK = '" +aa+"'";
    string l_cmp_name = "", l_cmp_add = "", l_cmp_taxcode = "";
    string l_report_dd = "";
	string l_report_mm = "";
	string l_report_yy = "";
    
    DataTable dt1 = ESysLib.TableReadOpen(SQL1);
    if (dt1.Rows.Count > 0)
    {
        l_cmp_name = dt1.Rows[0][0].ToString();
        l_cmp_add = dt1.Rows[0][1].ToString();
        l_cmp_taxcode = dt1.Rows[0][3].ToString();
		
		l_report_dd = dt1.Rows[0][4].ToString();
		l_report_mm = dt1.Rows[0][5].ToString();
		l_report_yy = dt1.Rows[0][6].ToString();
    }
    
    string l_parameter2 = Request["p_tac_gffa_mst_pk"];

    string sp2 = "ac_sel_gfgf00050_rpt";    
    DataTable dt = ESysLib.TableReadOpenCursor(sp2, l_parameter2);
    //Response.Write("sadsa");
    //Response.End();
    if (dt.Rows.Count == 0)
    {
        
        Response.Write("there is not data.");
        Response.End();
       
    }
    
    
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
<link rel=File-List href="dddddddddddddddd_files/filelist.xml">
<link rel=Edit-Time-Data href="dddddddddddddddd_files/editdata.mso">
<link rel=OLE-Object-Data href="dddddddddddddddd_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Linh</o:Author>
  <o:LastAuthor>Se7ven</o:LastAuthor>
  <o:LastPrinted>2013-06-26T02:01:49Z</o:LastPrinted>
  <o:Created>2006-06-16T05:06:29Z</o:Created>
  <o:LastSaved>2013-06-26T03:06:47Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_FA-FORM;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style21;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style21;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style21;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl31
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	white-space:normal;}
.xl32
	{mso-style-parent:style21;
	font-size:13.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl34
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:VNI-Helve;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:VNI-Helve;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style21;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl37
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl39
	{mso-style-parent:style21;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl41
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl43
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl44
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl45
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl46
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl47
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl51
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl54
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl55
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl56
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl63
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl64
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl67
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl72
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl78
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style21;
	font-size:11.0pt;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style21;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl91
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl92
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl93
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl94
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl95
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl96
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl97
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl98
	{mso-style-parent:style21;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl99
	{mso-style-parent:style21;
	font-size:13.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl100
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl101
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style21;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl104
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl105
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl106
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl107
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl108
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl109
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl110
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl111
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	}
.xl112
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl113
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl114
	{mso-style-parent:style22;
	color:navy;
	font-size:11.0pt;
	font-weight:700;
	font-family:VNI-Helve;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>the TS co dinh</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>96</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:TopRowVisible>12</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>24</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>15840</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=867 style='border-collapse:
 collapse;table-layout:fixed;width:652pt'>
 <col class=xl25 width=64 style='mso-width-source:userset;mso-width-alt:1820;
 width:48pt'>
 <col class=xl25 width=98 style='mso-width-source:userset;mso-width-alt:2787;
 width:74pt'>
 <col class=xl25 width=107 style='mso-width-source:userset;mso-width-alt:3043;
 width:80pt'>
 <col class=xl25 width=118 style='mso-width-source:userset;mso-width-alt:3356;
 width:89pt'>
 <col class=xl25 width=34 style='mso-width-source:userset;mso-width-alt:967;
 width:26pt'>
 <col class=xl25 width=119 style='mso-width-source:userset;mso-width-alt:3384;
 width:89pt'>
 <col class=xl25 width=69 style='mso-width-source:userset;mso-width-alt:1962;
 width:52pt'>
 <col class=xl25 width=110 style='mso-width-source:userset;mso-width-alt:3128;
 width:83pt'>
 <col class=xl25 width=148 style='mso-width-source:userset;mso-width-alt:4209;
 width:111pt'>
 <col class=xl25 width=10 style='mso-width-source:userset;mso-width-alt:284;
 width:8pt'>
 <col class=xl25 width=90 span=246 style='mso-width-source:userset;mso-width-alt:
 2560;width:68pt'>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=7 height=31 class=xl26 width=609 style='height:23.25pt;
  width:458pt'><%=l_cmp_name%></td>
  <td class=xl27 width=110 style='width:83pt'></td>
  <td class=xl28 width=148 style='width:111pt'>Mẫu số: S23 - DN</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=4 height=22 class=xl30 style='height:16.5pt'>MST:<%=l_cmp_taxcode%></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl96 x:str="(Ban hành theo QĐ số 15/2006/QĐ-BTC ">(Ban
  hành theo QĐ số 15/2006/QĐ-BTC<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=5 class=xl25 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl31 width=119 style='width:89pt'><br>
    </td>
  <td colspan=3 class=xl97>ngày 20/3/2006 của Bộ trưởng BTC)</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=9 height=24 class=xl98 style='height:18.0pt'>THẺ TÀI SẢN CỐ ĐỊNH</td>
 </tr>
 <%for(int k=0;k<dt.Rows.Count;k++)
   { %>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl99></td>
  <td class=xl33 x:str="Số ">Số<span style='mso-spacerun:yes'> </span></td>
  <td class=xl35><%=dt.Rows[k][55]%></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=6 class=xl25 style='height:6.0pt;mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl29>Ngày lập thẻ</td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl39><%=dt.Rows[k][59]%></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
 l_report_dd = dt.Rows[k][59].ToString();
 %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl25 style='height:21.0pt'></td>
  <td class=xl29>Kế toán trưởng</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl39><%=dt.Rows[k][60]%></td>
  <td class=xl39>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=5 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl29 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Căn
  cứ<span style='mso-spacerun:yes'>  </span>vào Biên bản giao nhận TSCĐ<span
  style='mso-spacerun:yes'>  </span>số</td>
  <td class=xl29></td>
  <td colspan=2 class=xl100><%=dt.Rows[k][62]%></td>
  <td class=xl29><span style='mso-spacerun:yes'>  </span>ngày</td>
  <td class=xl41><%=dt.Rows[k][61]%></td>
  <td class=xl29></td>
 </tr>
 <tr class=xl37 height=16 style='height:12.0pt'>
  <td height=16 colspan=5 class=xl42 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 colspan=3 style='height:18.0pt;mso-ignore:colspan'>Tên,
  ký mã hiệu, quy cách (cấp hạng) TSCĐ:</td>
  <td colspan=6 class=xl100><%=dt.Rows[k][2]%></td>
 </tr>
 <tr class=xl37 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl30 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Số
  hiệu TSCĐ</td>
  <td class=xl42></td>
  <td class=xl100><%=dt.Rows[k][66]%></td>
  <td class=xl100></td>
  <td class=xl100></td>
  <td class=xl41>&nbsp;</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 colspan=3 style='height:18.0pt;mso-ignore:colspan'>Nước
  sản xuất (xây dựng )</td>
  <td colspan=3 class=xl100><%=dt.Rows[k][46]%></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'
  x:str="  Năm sản xuất                "><span style='mso-spacerun:yes'> 
  </span>Năm sản xuất<span style='mso-spacerun:yes'>                </span></td>
  <td class=xl41><%=dt.Rows[k][37]%></td>
 </tr>
 <tr class=xl37 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=5 class=xl42 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl29 colspan=2 style='height:17.25pt;mso-ignore:colspan'>Bộ
  phận quản lý, sử dụng</td>
  <td class=xl44></td>
  <td colspan=3 class=xl100><%=dt.Rows[k][65]%></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'
  x:str="  Năm đưa vào sử dụng  "><span style='mso-spacerun:yes'>  </span>Năm
  đưa vào sử dụng<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl41><%=dt.Rows[k][59]%></td>
 </tr>
 <tr class=xl37 height=16 style='height:12.0pt'>
  <td height=16 colspan=5 class=xl42 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl29 colspan=3 style='height:17.25pt;mso-ignore:colspan'>Công
  suất (diện tích ) thiết kế</td>
  <td colspan=3 class=xl100><%=dt.Rows[k][50]%></td>
  <td class=xl29></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl29 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Đình
  chỉ sủ dụng TSCĐ ngày</td>
  <td class=xl41><%=dt.Rows[k][63]%></td>
  <td class=xl44></td>
  <td class=xl29>Lý do đình chỉ</td>
  <td class=xl41><%=dt.Rows[k][64]%></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
 </tr>
  <%} %>
 <tr class=xl37 height=16 style='height:12.0pt'>
  <td height=16 colspan=5 class=xl42 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=9 class=xl44 style='height:5.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl45 height=17 style='height:12.75pt'>
  <td height=17 class=xl46 style='height:12.75pt'>Số hiệu</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>Nguyên giá tài sản cố định</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl51 colspan=3 style='mso-ignore:colspan;border-right:1.0pt solid black'><span
  style='mso-spacerun:yes'>       </span>Giá trị hao mòn tài sản cố định</td>
 </tr>
 <tr class=xl54 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl55 style='height:12.75pt' x:str="chứng từ ">chứng
  từ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
 </tr>
 <tr class=xl62 height=17 style='height:12.75pt'>
  <td height=17 class=xl63 style='height:12.75pt'>&nbsp;</td>
  <td class=xl64>Ngày</td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                   </span>Diễn giải</td>
  <td class=xl66></td>
  <td class=xl64>Nguyên giá</td>
  <td class=xl64>Năm</td>
  <td class=xl67>Giá trị hao mòn</td>
  <td class=xl68>Cộng dồn</td>
 </tr>
 <tr class=xl62 height=17 style='height:12.75pt'>
  <td height=17 class=xl69 style='height:12.75pt'>A</td>
  <td class=xl70>B</td>
  <td colspan=3 class=xl102 style='border-right:.5pt solid black;border-left:
  none'><span style='mso-spacerun:yes'>                         </span>C</td>
  <td class=xl70 x:num>1</td>
  <td class=xl70 x:num>2</td>
  <td class=xl70 x:num>3</td>
  <td class=xl70 x:num>4</td>
 </tr>
 
 <%
		
		
		
 %>
 <%
     decimal nguyengia = 0;
     decimal gthm = 0;
     decimal congdon = 0;
     string sp3 = "ac_sel_gfgf00050_4";
     DataTable dt_detail = ESysLib.TableReadOpenCursor(sp3, l_parameter2);
     for (int y = 0; y < dt_detail.Rows.Count ; y++)
     {
        

         if (dt_detail.Rows[y][5].ToString().Trim() != "")
         {
             gthm += decimal.Parse(dt_detail.Rows[y][5].ToString());
         }
         else
         {
             gthm += 0;
         }

         if (dt_detail.Rows[y][3].ToString().Trim() != "")
         {
             nguyengia += decimal.Parse(dt_detail.Rows[y][3].ToString());
         }
         else
         {
             nguyengia += 0;
         }
        
        
        
      %>
 <tr class=xl71 height=36 style='mso-height-source:userset;height:27.0pt'
  <td height=22 class=xl72 style='height:16.5pt'><%=dt_detail.Rows[y][0]%></td>
  <td class=xl73 ><%=dt_detail.Rows[y][1]%></td>
  <td colspan=3 class=xl111 width=230 style='border-right:.5pt solid black;
  width:173pt'><%=dt_detail.Rows[y][2]%></td>
  <td class=xl74 style='border-left:none' x:num><%=dt_detail.Rows[y][3]%></td>
  <td class=xl75><%=dt_detail.Rows[y][4]%></td>
  <td class=xl74 x:num><%=dt_detail.Rows[y][5]%></td>
  <td class=xl76 x:num><%=dt_detail.Rows[y][6]%></td>
 </tr>
 <% 
    
     }

   %>
   
   
   
 
 
 
 <% for (int h = 0; h <= 6; h++)
     {

     %>
	 <tr class=xl71 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=22 class=xl72 style='height:16.5pt'></td>
  <td class=xl73 ></td>
  <td colspan=3 class=xl105 style='border-right:.5pt solid black'></td>
  <td class=xl74 style='border-left:none' x:num></td>
  <td class=xl75></td>
  <td class=xl74 x:num></td>
  <td class=xl76 x:num></td>
 </tr>
	 <%
 } %>
 <% for (int h = 0; h <= dt_detail.Rows.Count -1; h++)
     {

     if (dt_detail.Rows[h][6].ToString().Trim() != "")
     {
         congdon = decimal.Parse(dt_detail.Rows[h][6].ToString());
     }
     else
     {
         congdon = 0;
     }
 } %>
 <tr class=xl71 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl84 style='height:15.0pt'>Tổng</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl87 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%=nguyengia%></td>
  <td class=xl85>&nbsp;</td>
  <td class=xl88 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%%></td>
  <td class=xl89 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num></td>
 </tr>
 
 <tr class=xl62 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl50 colspan=2 style='height:31.5pt;mso-ignore:colspan'>Ghi
  giảm TSCĐ chứng từ số</td>
  <td class=xl66></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl92 x:str="Ngày   ">Ngày<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl93>&nbsp;</td>
 </tr>
 
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl50 style='height:20.25pt'>Lý do giảm</td>
  <td class=xl44></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
 </tr>
 
 
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl104><span style='mso-spacerun:yes'> </span>Ng&agrave;y <%= l_report_dd %></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl44 height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl104 style='height:15.75pt'>Ng&#432;&#7901;i
  l&#7853;p</td>
  <td class=xl44></td>
  <td colspan=3 class=xl104>K&#7871; toán tr&#432;&#7903;ng</td>
  <td class=xl44></td>
  <td colspan=2 class=xl104>Giám &#273;&#7889;c</td>
 </tr>
 <tr class=xl44 height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl104 style='height:15.75pt'>(Ký, h&#7885; tên)</td>
  <td class=xl44></td>
  <td colspan=3 class=xl104>(Ký, h&#7885; tên)</td>
  <td class=xl44></td>
  <td colspan=2 class=xl104>(Ký, h&#7885; tên, &#273;óng d&#7845;u)</td>
 </tr>
 <tr class=xl44 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl44 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 
 <tr class=xl44 height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl104 style='height:15.75pt'><%%></td>
  <td class=xl44></td>
  <td colspan=3 class=xl104><%%></td>
  <td class=xl44></td>
  <td colspan=2 class=xl104><%%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=148 style='width:111pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
