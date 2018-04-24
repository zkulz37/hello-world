<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_master_pk = Request.QueryString["master_pk"];
    string para = "'" + p_master_pk + "'";
    string sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM  tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM  tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    DataTable dt, dt1, dt2;

    dt = ESysLib.TableReadOpen(sql);
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_dsbs00201_songwol", para);
    dt2 = ESysLib.TableReadOpenCursor("lg_rpt_dsbs00201_songwol_1", para);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=ytf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsbs00201_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsbs00201_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsbs00201_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>&#51060;&#49345;&#54788;</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2012-03-23T04:22:52Z</o:LastPrinted>
  <o:Created>2010-04-02T01:39:39Z</o:Created>
  <o:LastSaved>2012-03-23T04:25:25Z</o:LastSaved>
  <o:Company>songwol</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.42in .24in .33in .24in;
	mso-header-margin:.31in;
	mso-footer-margin:.17in;
	mso-horizontal-page-align:center;}
.font7
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\B9D1\C740 \ACE0\B515", monospace;
	mso-font-charset:129;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style44
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
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
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	mso-rotate:-90;}
.xl69
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	mso-rotate:90;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style44;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style44;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style44;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style44;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style44;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style44;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style44;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl95
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl100
	{mso-style-parent:style44;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style44;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl103
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl104
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl105
	{mso-style-parent:style44;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style44;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style44;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl108
	{mso-style-parent:style44;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl109
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl110
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl111
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl112
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl114
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl115
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl116
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl117
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl118
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl119
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl120
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl121
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl122
	{mso-style-parent:style44;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ ";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl123
	{mso-style-parent:style44;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl124
	{mso-style-parent:style44;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl125
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl127
	{mso-style-parent:style44;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl128
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl129
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl130
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl131
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl132
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl133
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl134
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl135
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl136
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl137
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl138
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl139
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl140
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"\B9D1\C740 \ACE0\B515", monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl141
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl142
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl143
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_ \;\[Red\]\\-\#\,\#\#0\\ ";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl144
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl145
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl146
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl147
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl148
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl149
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Cambria, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>BATH</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>420</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:StandardWidth>608</x:StandardWidth>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>97</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>50</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7995</x:WindowHeight>
  <x:WindowWidth>14160</x:WindowWidth>
  <x:WindowTopX>600</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=737 style='border-collapse:
 collapse;table-layout:fixed;width:552pt'>
 <col class=xl65 width=20 span=34 style='mso-width-source:userset;mso-width-alt:
 640;width:15pt'>
 <col class=xl65 width=19 span=3 style='width:14pt'>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 rowspan=3 height=84 class=xl148 width=40 style='height:63.0pt;
  width:30pt'>C<br>
    O<br>
    D<br>
    E</td>
  <td colspan=5 class=xl144 width=100 style='border-left:none;width:75pt'>&nbsp;</td>
  <td colspan=18 rowspan=3 class=xl97 width=360 style='width:270pt'>ORDER FORM</td>
  <td colspan=3 class=xl96 width=60 style='width:45pt'>STAFF</td>
  <td colspan=3 class=xl96 width=60 style='border-left:none;width:45pt'>CHIEF</td>
  <td colspan=3 class=xl96 width=60 style='border-left:none;width:45pt'>MANAGER</td>
  <td colspan=3 class=xl96 width=57 style='border-left:none;width:42pt'>P.M</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=5 height=28 class=xl144 style='height:21.0pt;border-left:none'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl144>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl144>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl144>&nbsp;</td>
  <td class=xl90 style='border-top:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none'>&nbsp;</td>
  <td class=xl92 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=5 height=28 class=xl144 style='height:21.0pt;border-left:none'>&nbsp;</td>
  <td class=xl93>&nbsp;</td>
  <td class=xl94>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=7 class=xl65 style='height:21.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=5 height=30 class=xl118 style='border-right:.5pt solid black;
  height:23.1pt'>Buyer name</td>
  <td colspan=9 class=xl146 style='border-right:1.0pt solid black'><%= dt1.Rows[0]["partner_name"]%></td>
  <td colspan=5 class=xl118 style='border-right:.5pt solid black;border-left:
  none'>Order Date</td>
  <td colspan=6 class=xl98 style='border-right:.5pt solid black;border-left:none'><%= dt1.Rows[0]["order_dt"]%></td>
  <td colspan=5 class=xl98 style='border-right:.5pt solid black;border-left:
  none'>Inspection Date</td>
  <td colspan=7 class=xl99 style='border-right:1.0pt solid black'><%= dt1.Rows[0]["inspection_date"]%></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=5 height=30 class=xl135 style='border-right:.5pt solid black;
  height:23.1pt'>Item name</td>
  <td colspan=9 class=xl140 style='border-right:1.0pt solid black'><%= dt1.Rows[0]["item_name"]%></td>
  <td colspan=5 class=xl135 style='border-right:.5pt solid black;border-left:
  none'>PO No.</td>
  <td colspan=6 class=xl86 style='border-right:.5pt solid black;border-left:
  none'><%= dt1.Rows[0]["po_no"]%></td>
  <td colspan=5 class=xl86 style='border-right:.5pt solid black;border-left:
  none'>Price</td>
  <td colspan=7 class=xl87 style='border-right:1.0pt solid black'><%= dt1.Rows[0]["price"]%></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=5 height=30 class=xl135 style='border-right:.5pt solid black;
  height:23.1pt'>Size</td>
  <td colspan=7 class=xl143><%= dt1.Rows[0]["item_size"]%></td>
  <td colspan=2 class=xl136 style='border-right:1.0pt solid black'>cm</td>
  <td colspan=5 class=xl135 style='border-right:.5pt solid black;border-left:
  none'>Pile Yarn</td>
  <td colspan=18 class=xl125 width=357 style='border-right:1.0pt solid black;
  width:267pt'><%= dt1.Rows[0]["pile_yarn"]%></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=5 height=30 class=xl135 style='border-right:.5pt solid black;
  height:23.1pt'>Weight</td>
  <td colspan=7 class=xl139 x:num><%= dt1.Rows[0]["weight"]%></td>
  <td colspan=2 class=xl136 style='border-right:1.0pt solid black'>g</td>
  <td colspan=5 class=xl135 style='border-right:.5pt solid black;border-left:
  none'>Sewing</td>
  <td colspan=18 class=xl123 style='border-right:1.0pt solid black'><%= dt1.Rows[0]["sewing"]%></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td colspan=5 height=30 class=xl82 style='border-right:.5pt solid black;
  height:23.1pt'>Quantity</td>
  <td colspan=7 class=xl80 x:num><%= dt1.Rows[0]["total_ord_qty"]%></td>
  <td colspan=2 class=xl78 style='border-right:1.0pt solid black'>pcs</td>
  <td colspan=5 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Label</td>
  <td colspan=18 class=xl79 style='border-right:1.0pt solid black'><%= dt1.Rows[0]["label_desc"]%></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl73 style='height:11.25pt;border-top:none'>&nbsp;</td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl76 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=18 class=xl77 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=5 height=20 class=xl128 style='border-right:.5pt solid black;
  height:15.0pt'>Color</td>
  <td colspan=9 class=xl131 style='border-right:.5pt solid black;border-left:
  none'>Pantone</td>
  <td colspan=5 class=xl131 style='border-right:.5pt solid black;border-left:
  none'>Qty</td>
  <td colspan=6 class=xl89 style='border-right:.5pt solid black;border-left:
  none' x:str="Jan Code"><span style='mso-spacerun:yes'>�</span>Jan Code<span
  style='mso-spacerun:yes'>�</span></td>
  <td colspan=12 class=xl75 style='border-right:1.0pt solid black'
  x:str="Remark"><span style='mso-spacerun:yes'>�</span>Remark<span
  style='mso-spacerun:yes'>�</span></td>
 </tr>
 <%
     for (int i = 0; i < dt2.Rows.Count; i++)
     {
      %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=5 height=22 class=xl115 style='border-right:.5pt solid black;
  height:16.5pt'><%= dt2.Rows[i]["item_color"]%></td>
  <td colspan=9 class=xl112 style='border-right:.5pt solid black;border-left:
  none'><%= dt2.Rows[i]["pantone"]%></td>
  <td colspan=5 class=xl109 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dt2.Rows[i]["ord_qty"]%></td>
  <td colspan=6 class=xl112 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'></span><%= dt2.Rows[i]["jan_code"]%></td>
  <td colspan=12 class=xl105 style='border-right:1.0pt solid black;border-left:
  none'><span style='mso-spacerun:yes'></span><%= dt2.Rows[i]["description"]%><span
  style='mso-spacerun:yes'></span></td>
 </tr>
 <%} %>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td colspan=37 height=15 class=xl149 style='height:11.25pt'>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=8 height=33 class=xl118 style='border-right:.5pt solid black;
  height:24.95pt'>Order Name</td>
  <td class=xl83 colspan=13 style='mso-ignore:colspan'><%= dt1.Rows[0]["item_name"]%></td>
  <td colspan=13 class=xl83 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl84 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl66 style='height:15.0pt'>&nbsp;</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=27 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl66 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=19 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl66 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=19 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl66 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=19 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl66 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=19 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl66 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=28 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl66 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=28 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl66 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=19 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl66 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl68 style='mso-ignore:colspan'></td>
  <td colspan=19 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl82 style='height:15.0pt'>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl73 style='height:11.25pt;border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=34 height=25 class=xl133 style='height:18.75pt'><span
  style='mso-spacerun:yes'></span>&#8251; Towel design &amp; Hem design : <%= dt1.Rows[0]["att05"]%></td>
  <td class=xl74 style='border-top:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=34 height=25 class=xl104 style='height:18.75pt'><span
  style='mso-spacerun:yes'></span>&#8251; Pile Yarn : <%= dt1.Rows[0]["att06"]%></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=34 height=25 class=xl104 style='height:18.75pt'><span
  style='mso-spacerun:yes'></span>&#8251; Dyeing : <%= dt1.Rows[0]["att07"]%></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=34 height=28 class=xl104 style='height:21.0pt'><span
  style='mso-spacerun:yes'></span>&#8251; How to set : <%= dt1.Rows[0]["att08"]%></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=34 height=28 class=xl104 style='height:21.0pt'><span
  style='mso-spacerun:yes'></span>&#8251; Accessaries : <%= dt1.Rows[0]["att09"]%></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=34 height=28 class=xl102 style='height:21.0pt'><span
  style='mso-spacerun:yes'></span>&#8251; Pile length : <%= dt1.Rows[0]["att10"]%></td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
