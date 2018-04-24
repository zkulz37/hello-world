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
    //string l_gffa_mst_pk = Request["p_tac_gffa_mst_pk"];
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" +aa+"'";
    string l_cmp_name = "", l_cmp_add = "", l_cmp_taxcode = "";
    
    
    DataTable dt1 = ESysLib.TableReadOpen(SQL1);
    if (dt1.Rows.Count > 0)
    {
        l_cmp_name = dt1.Rows[0][0].ToString();
        l_cmp_add = dt1.Rows[0][1].ToString();
        l_cmp_taxcode = dt1.Rows[0][3].ToString();
    }
    
    string l_parameter2 = Request["p_tac_gffa_mst_pk"];
    string sp2 = "acnt.sp_sel_gfgf00050_3";    
    DataTable dt = ESysLib.TableReadOpenCursor(sp2, l_parameter2);
    if (dt.Rows.Count == 0)
    {
        
        Response.Write("there are not data.");
        Response.End();
       
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="English-vietnamese_files/filelist.xml">
<link rel=Edit-Time-Data href="English-vietnamese_files/editdata.mso">
<link rel=OLE-Object-Data href="English-vietnamese_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Long</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2009-10-06T01:51:10Z</o:LastPrinted>
  <o:Created>2009-10-05T02:32:18Z</o:Created>
  <o:LastSaved>2009-10-09T08:43:06Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .75in .5in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font26
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
.style22
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
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style22;
	font-size:13.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:VNI-Helve;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl32
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl42
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl43
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl44
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl46
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl48
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl49
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl50
	{mso-style-parent:style22;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl51
	{mso-style-parent:style0;
	font-size:15.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl56
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl57
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl58
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl64
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl69
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl70
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl82
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl83
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl84
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl92
	{mso-style-parent:style22;
	font-size:15.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:15.0pt;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	font-size:15.0pt;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style22;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl97
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl99
	{mso-style-parent:style22;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl100
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl101
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl102
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:VNI-Helve;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl104
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl105
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl106
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl107
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl108
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl109
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl110
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl111
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl112
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl113
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl114
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl115
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl116
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl117
	{mso-style-parent:style0;
	font-size:15.0pt;
	text-align:center;}
.xl118
	{mso-style-parent:style0;
	font-size:15.0pt;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl119
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl120
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl121
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl122
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl123
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl124
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl125
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl126
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl127
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl128
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl129
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl130
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl131
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl132
	{mso-style-parent:style22;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl133
	{mso-style-parent:style22;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl134
	{mso-style-parent:style22;
	font-size:13.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl135
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl136
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl137
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl138
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl139
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl140
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;}
.xl141
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl142
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl143
	{mso-style-parent:style0;
	font-size:12.0pt;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl144
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl145
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl146
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl147
	{mso-style-parent:style22;
	font-size:15.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl148
	{mso-style-parent:style0;
	font-style:italic;
	text-align:center;}
.xl149
	{mso-style-parent:style0;
	font-style:italic;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl150
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl151
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl152
	{mso-style-parent:style0;
	font-size:15.0pt;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl153
	{mso-style-parent:style0;
	font-size:15.0pt;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl154
	{mso-style-parent:style0;
	font-size:15.0pt;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>77</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12525</x:WindowHeight>
  <x:WindowWidth>18045</x:WindowWidth>
  <x:WindowTopX>255</x:WindowTopX>
  <x:WindowTopY>225</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=918 style='border-collapse:
 collapse;table-layout:fixed;width:690pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <col class=xl25 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl25 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl25 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1206'>
 <col class=xl25 width=138 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl25 width=140 style='mso-width-source:userset;mso-width-alt:5120;
 width:105pt'>
 <col class=xl25 width=169 style='mso-width-source:userset;mso-width-alt:6180;
 width:127pt'>
 <col class=xl25 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <col class=xl25 width=90 span=246 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <tr height=30 style='height:22.5pt'>
  <td colspan=4 height=30 class=xl137 width=310 style='height:22.5pt;
  width:232pt'><%=l_cmp_name%></td>
  <td class=xl96 width=0>&nbsp;</td>
  <td class=xl96 width=138 style='width:104pt'>&nbsp;</td>
  <td class=xl96 width=61 style='width:46pt'>&nbsp;</td>
  <td colspan=2 class=xl128 width=309 style='border-right:1.0pt solid black;
  width:232pt'>Form : S23 - DN/ Mẫu số: S23 - DN</td>
  <td class=xl25 width=10 style='width:8pt'></td>
  <td class=xl25 width=90 style='width:68pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl139 style='height:15.75pt'><%=l_cmp_add %></td>
  <td class=xl25></td>
  <td colspan=4 class=xl141 style='border-right:1.0pt solid black'
  x:str="(Issued with Decision No. 15/2006/QĐ-BTC / Ban hành theo QĐ số 15/2006/QĐ-BTC ">(Issued
  with Decision No. 15/2006/QĐ-BTC / Ban hành theo QĐ số 15/2006/QĐ-BTC<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=9 height=21 class=xl144 style='border-right:1.0pt solid black;
  height:15.75pt'><span style='mso-spacerun:yes'> </span>dated March 20, 2006
  by Ministry of Finance/ ngày 20/3/2006 của Bộ trưởng BTC)</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl97 style='height:15.75pt'>&nbsp;</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl98></td>
  <td colspan=2 class=xl135 style='border-right:1.0pt solid black'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=9 height=26 class=xl99 style='border-right:1.0pt solid black;
  height:19.5pt'>THẺ TÀI SẢN CỐ ĐỊNH</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl100 style='height:16.5pt'>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl134><span
  style='mso-spacerun:yes'>                      </span>FIXED ASSET CARD</td>
  <td class=xl101 x:str="No.  ">No.<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl102 x:num><%=l_parameter2%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl100 style='height:18.75pt'>&nbsp;</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl103></td>
  <td class=xl25></td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl100 style='height:15.75pt'>&nbsp;</td>
  <td class=xl32>Ngày lập <span style='display:none'>thẻ</span></td>
  <td class=xl55 colspan=2 style='mso-ignore:colspan'>Date of issuing card</td>
  <td class=xl105 x:str="Date of issuing card ">Date of issuing card<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl100 style='height:15.75pt'>&nbsp;</td>
  <td class=xl32>Kế toán t<span style='display:none'>rưởng</span></td>
  <td class=xl55 colspan=2 style='mso-ignore:colspan' x:str="Chief accountant ">Chief
  accountant<span style='mso-spacerun:yes'> </span></td>
  <td class=xl105></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=20 style='height:15.0pt'>
  <td height=20 class=xl100 style='height:15.0pt'>&nbsp;</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl50></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <%   
     for (int i = 0; i < dt.Rows.Count; i++)
     {
   %>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl106 colspan=4 style='height:15.75pt;mso-ignore:colspan'>Căn
  cứ<span style='mso-spacerun:yes'>  </span>vào Biên bản giao nhận TSCĐ<span
  style='mso-spacerun:yes'>  </span>số</td>
  <td class=xl32></td>
  <td class=xl32><% = dt.Rows[i][1].ToString()%></td>
  <td class=xl32>Ngày</td>
  <td class=xl27></td>
  <td class=xl110 x:num><% = dt.Rows[i][3].ToString()%></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl108 colspan=4 style='height:12.0pt;mso-ignore:colspan'>According
  to the minutes of delivery and receiving No.</td>
  <td class=xl55></td>
  <td class=xl82></td>
  <td class=xl55>Date</td>
  <td class=xl29></td>
  <td class=xl109>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl106 colspan=4 style='height:15.75pt;mso-ignore:colspan'>Tên,
  ký mã hiệu, quy cách (cấp hạng) TSCĐ</td>
  <td class=xl32></td>
  <td class=xl32><% = dt.Rows[i][4].ToString()%></td>
  <td class=xl32 colspan=2 style='mso-ignore:colspan'>Số hiệu TSCĐ</td>
  <td class=xl110 x:num><% = dt.Rows[i][5].ToString()%></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl108 colspan=4 style='height:12.75pt;mso-ignore:colspan'>Name,
  code, model (grade) of fixed asset</td>
  <td class=xl55></td>
  <td class=xl82></td>
  <td class=xl55 colspan=2 style='mso-ignore:colspan'>Series No. of fixed asset</td>
  <td class=xl109>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl106 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Nước
  sản xuất (xây dựng )</td>
  <td colspan=3 class=xl32><% = dt.Rows[i][6].ToString()%></td>
  <td class=xl52 colspan=2 style='mso-ignore:colspan'>Năm sản xuất</td>
  <td class=xl110><% = dt.Rows[i][7].ToString()%></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl108 colspan=3 style='height:12.75pt;mso-ignore:colspan'>Country
  product/ made in</td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td class=xl82></td>
  <td colspan=2 class=xl55>Year produced</td>
  <td class=xl109>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl106 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Bộ
  phận quản lý, sử dụng</td>
  <td colspan=3 class=xl32><% = dt.Rows[i][2].ToString()%></td>
  <td class=xl52 colspan=2 style='mso-ignore:colspan'>Năm đưa vào sử dụng</td>
  <td class=xl110><% = dt.Rows[i][8].ToString()%></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl108 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Using
  department</td>
  <td colspan=3 class=xl55 style='mso-ignore:colspan'></td>
  <td class=xl82></td>
  <td class=xl55>Year used</td>
  <td class=xl29></td>
  <td class=xl109>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl106 colspan=4 style='height:15.75pt;mso-ignore:colspan'>Công
  suất (diện tích ) thiết kế<span style='mso-spacerun:yes'>    </span><font
  class="font26">(Power designed)</font></td>
  <td class=xl27></td>
  <td class=xl27><% = dt.Rows[i][9].ToString()%></td>
  <td colspan=2 class=xl27>Lý do đình chỉ</td>
  <td class=xl111>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=21 style='height:15.75pt'>
  <td height=21 class=xl106 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Đình
  chỉ sủ dụng TSCĐ ngày</td>
  <td colspan=3 class=xl32><% = dt.Rows[i][10].ToString()%></td>
  <td colspan=2 class=xl55>Reason for not using</td>
  <td class=xl107>&nbsp;</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl108 colspan=3 style='height:11.25pt;mso-ignore:colspan'>Date
  ceased using fixed asset</td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td class=xl82></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl109>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
   <%
     } %>
 <tr class=xl36 height=22 style='height:16.5pt'>
  <td height=22 class=xl106 style='height:16.5pt'>&nbsp;</td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl112>&nbsp;</td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl41 height=21 style='height:15.75pt'>
  <td height=21 class=xl56 style='height:15.75pt'>Số hiệu</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl58>Nguyên giá tài sản cố định</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl59 colspan=3 style='mso-ignore:colspan;border-right:1.0pt solid black'><span
  style='mso-spacerun:yes'>       </span>Giá trị hao mòn tài sản cố định</td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl42 height=21 style='height:15.75pt'>
  <td height=21 class=xl57 style='height:15.75pt' x:str="chứng từ ">chứng
  từ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl71>Cost of fixed asset</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl72 colspan=3 style='mso-ignore:colspan;border-right:1.0pt solid black'><span
  style='mso-spacerun:yes'>          </span>Accumulated Depreciation of Fixed
  asset</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=21 style='height:15.75pt'>
  <td height=21 class=xl68 style='height:15.75pt'>Document</td>
  <td class=xl61>Ngày</td>
  <td colspan=2 class=xl130><span style='mso-spacerun:yes'>  </span>Diễn giải</td>
  <td class=xl77></td>
  <td class=xl61>Nguyên giá</td>
  <td class=xl61>Năm</td>
  <td class=xl61>Giá trị hao mòn</td>
  <td class=xl62>Cộng dồn</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl42 height=17 style='height:12.75pt'>
  <td height=17 class=xl69 style='height:12.75pt'>No.</td>
  <td class=xl70>Date</td>
  <td class=xl40 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                        </span>Description</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl70>Cost</td>
  <td class=xl70>Year</td>
  <td class=xl70>Depreciation</td>
  <td class=xl74>Accumulated total</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl45 height=21 style='height:15.75pt'>
  <td height=21 class=xl63 style='height:15.75pt'>A</td>
  <td class=xl64>B</td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                         </span>C</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl64 x:num>1</td>
  <td class=xl64 x:num>2</td>
  <td class=xl64 x:num>3</td>
  <td class=xl67 x:num>4</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl45 height=18 style='height:13.5pt'>
  <td height=18 class=xl91 style='height:13.5pt'>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td colspan=2 class=xl150>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl89>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl95>&nbsp;</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl45 height=16 style='height:12.0pt'>
  <td height=16 class=xl115 style='height:12.0pt'>&nbsp;</td>
  <td colspan=7 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl116>&nbsp;</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl42 height=26 style='height:19.5pt'>
  <td colspan=9 height=26 class=xl99 style='border-right:1.0pt solid black;
  height:19.5pt'>DỤNG CỤ PHỤ TÙNG KÈM THEO</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl42 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=9 height=21 class=xl147 style='border-right:1.0pt solid black;
  height:15.75pt'>MODE OF TOOLS AND ACCESSORIES</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl42 height=27 style='height:20.25pt'>
  <td height=27 class=xl99 style='height:20.25pt'>&nbsp;</td>
  <td colspan=7 class=xl117 style='mso-ignore:colspan'></td>
  <td class=xl118>&nbsp;</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl42 height=21 style='height:15.75pt'>
  <td height=21 class=xl84 style='height:15.75pt'>Số TT</td>
  <td colspan=3 class=xl85 style='border-left:none'>Tên, quy cách dụng cụ, phụ
  tùng</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-left:none'>Đơn vị tính</td>
  <td colspan=2 class=xl85 style='border-left:none'>Số lượng</td>
  <td class=xl86 style='border-left:none'>Giá trị</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl42 height=17 style='height:12.75pt'>
  <td height=17 class=xl87 style='height:12.75pt'>No.</td>
  <td colspan=3 class=xl79 style='border-left:none'
  x:str="Name, specification of instrument ">Name, specification of
  instrument<span style='mso-spacerun:yes'> </span></td>
  <td class=xl80 style='border-left:none'>&nbsp;</td>
  <td class=xl79 style='border-left:none'>Unit</td>
  <td colspan=2 class=xl146 style='border-left:none'>Quantity</td>
  <td class=xl88 style='border-left:none'>Value</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl42 height=21 style='height:15.75pt'>
  <td height=21 class=xl75 style='height:15.75pt;border-top:none'>A</td>
  <td colspan=3 class=xl53 style='border-left:none'>B</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>C</td>
  <td colspan=2 class=xl53 style='border-left:none' x:num>1</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num>2</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl42 height=27 style='height:20.25pt'>
  <td height=27 class=xl92 style='height:20.25pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl152 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl93 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl152 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl43 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl119 colspan=3 style='height:18.0pt;mso-ignore:colspan'>Ghi
  giảm TSCĐ chứng từ số</td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl81>Ngày</td>
  <td class=xl107>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl120 colspan=4 style='height:15.0pt;mso-ignore:colspan'>Account
  for reducing FA according to doc. No.</td>
  <td class=xl49></td>
  <td class=xl49></td>
  <td class=xl48></td>
  <td class=xl83>Date</td>
  <td class=xl116>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl120 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl49 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
  <td class=xl49></td>
  <td class=xl116>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl119 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Lý
  do giảm</td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl107>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl120 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Reason
  for decreasing</td>
  <td colspan=5 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl112>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl100 style='height:15.75pt'>&nbsp;</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl81>Ngày</td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl100 style='height:15.0pt'>&nbsp;</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl83>Date</td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl100 style='height:15.75pt'>&nbsp;</td>
  <td class=xl121 colspan=2 style='mso-ignore:colspan'>Prepared by</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl121>Chief Accountant</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl122><span style='mso-spacerun:yes'>       </span>Director</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl100 style='height:12.0pt'>&nbsp;</td>
  <td class=xl55 colspan=2 style='mso-ignore:colspan'>(Signature)</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl123>(Signature)</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl124>(Signature and seal)</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl100 style='height:15.0pt'>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl100 style='height:15.0pt'>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl100 style='height:15.0pt'>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl100 style='height:15.0pt'>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl100 style='height:15.0pt'>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl104>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl125 style='height:15.75pt'>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl126>&nbsp;</td>
  <td class=xl127>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=0></td>
  <td width=138 style='width:104pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=140 style='width:105pt'></td>
  <td width=169 style='width:127pt'></td>
  <td width=10 style='width:8pt'></td>
  <td width=90 style='width:68pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
