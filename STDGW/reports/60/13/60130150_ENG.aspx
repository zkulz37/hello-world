<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
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
    string sp2 = "ac_sel_60130150_3";
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
<link rel=File-List href="English_files/filelist.xml">
<link rel=Edit-Time-Data href="English_files/editdata.mso">
<link rel=OLE-Object-Data href="English_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Long</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2009-10-09T07:36:33Z</o:LastPrinted>
  <o:Created>2009-10-05T02:32:18Z</o:Created>
  <o:LastSaved>2009-10-09T08:25:27Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .78in .5in .78in;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl34
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl35
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl37
	{mso-style-parent:style22;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl38
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl39
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style22;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:15.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:15.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style22;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl51
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl52
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style22;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl58
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl66
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl67
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
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:15.0pt;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl72
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
.xl73
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl74
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl75
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
.xl76
	{mso-style-parent:style22;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl77
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl78
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl79
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl80
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl81
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl82
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
.xl83
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
.xl84
	{mso-style-parent:style0;
	font-size:15.0pt;
	text-align:center;}
.xl85
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl86
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl87
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl88
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl89
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl90
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl91
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl92
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl93
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl94
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl95
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl100
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
.xl101
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl103
	{mso-style-parent:style0;
	text-align:left;}
.xl104
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl105
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;}
.xl106
	{mso-style-parent:style0;
	text-align:center;}
.xl107
	{mso-style-parent:style22;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl108
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
.xl109
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl110
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
.xl111
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	text-align:left;}
.xl112
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl113
	{mso-style-parent:style22;
	font-size:13.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl114
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl116
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl117
	{mso-style-parent:style22;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl118
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
.xl119
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
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
      <x:Scale>81</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:WindowTopX>600</x:WindowTopX>
  <x:WindowTopY>390</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=880 style='border-collapse:
 collapse;table-layout:fixed;width:663pt'>
 <col class=xl25 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl25 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl25 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl25 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1206'>
 <col class=xl25 width=109 style='mso-width-source:userset;mso-width-alt:3986;
 width:82pt'>
 <col class=xl25 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl25 width=134 style='mso-width-source:userset;mso-width-alt:4900;
 width:101pt'>
 <col class=xl25 width=169 style='mso-width-source:userset;mso-width-alt:6180;
 width:127pt'>
 <col class=xl25 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <col class=xl25 width=90 span=246 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <tr height=30 style='height:22.5pt'>
  <td colspan=4 height=30 class=xl108 width=305 style='height:22.5pt;
  width:230pt'><%=l_cmp_name%></td>
  <td class=xl67 width=0>&nbsp;</td>
  <td class=xl67 width=109 style='width:82pt'>&nbsp;</td>
  <td class=xl67 width=63 style='width:47pt'>&nbsp;</td>
  <td class=xl67 width=134 style='width:101pt'>&nbsp;</td>
  <td class=xl68 width=169 style='width:127pt'>Form: S23 - DN</td>
  <td class=xl25 width=10 style='width:8pt'></td>
  <td class=xl25 width=90 style='width:68pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl110 style='height:15.75pt'><%=l_cmp_add %></td>
  <td class=xl25></td>
  <td class=xl25></td>
  <td class=xl69></td>
  <td colspan=2 class=xl45 style='border-right:1.0pt solid black'
  x:str="(Issued with Decision No. 15/2006/QĐ-BTC ">(Issued with Decision No.
  15/2006/QĐ-BTC<span style='mso-spacerun:yes'> </span></td>
  <td class=xl45></td>
  <td></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl112 style='height:15.75pt'>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl25></td>
  <td class=xl69></td>
  <td colspan=2 class=xl99 style='border-right:1.0pt solid black'>dated March
  20.2006 by Ministry of Finance</td>
  <td class=xl46></td>
  <td></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl71 style='height:15.75pt'>&nbsp;</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=2 class=xl99 style='border-right:1.0pt solid black'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=9 height=26 class=xl72 style='border-right:1.0pt solid black;
  height:19.5pt'><span style='mso-spacerun:yes'>                     
  </span>FIXED ASSET CARD</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl73 style='height:16.5pt'>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl113></td>
  <td class=xl74 x:str="No.  ">No.<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl75 x:num><%=l_parameter2%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl73 style='height:18.75pt'>&nbsp;</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl76></td>
  <td class=xl25></td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl73 style='height:15.75pt'>&nbsp;</td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>Date of issuing card</td>
  <td class=xl38></td>
  <td class=xl65 x:str="Date of issuing card ">Date of issuing card<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl73 style='height:15.75pt'>&nbsp;</td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>Chief accountant</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'>&nbsp;</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl37></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 
  <%   
     for (int i = 0; i < dt.Rows.Count; i++)
     {
   %>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td height=21 class=xl78 colspan=5 style='height:15.75pt;mso-ignore:colspan'>According
  to the minutes of delivery and receiving <span style='display:none'>No.</span></td>
  <td class=xl27><% = dt.Rows[i][1].ToString()%></td>
  <td class=xl50>Date</td>
  <td class=xl27></td>
  <td class=xl79 align=right x:num><% = dt.Rows[i][3].ToString()%></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td height=21 class=xl78 colspan=4 style='height:15.75pt;mso-ignore:colspan'>Name,
  code, model (grade) of fixed asset</td>
  <td class=xl27></td>
  <td class=xl27><% = dt.Rows[i][4].ToString()%></td>
  <td class=xl50 colspan=2 style='mso-ignore:colspan'>Series No. of fixed asset</td>
  <td class=xl79 align=right x:num><% = dt.Rows[i][5].ToString()%></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td height=21 class=xl78 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Country
  product/ made in</td>
  <td colspan=3 class=xl27><% = dt.Rows[i][6].ToString()%></td>
  <td class=xl50 colspan=2 style='mso-ignore:colspan'>Year produced</td>
  <td class=xl79 align=right x:num><% = dt.Rows[i][7].ToString()%></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td height=21 class=xl78 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Using
  department</td>
  <td class=xl30></td>
  <td colspan=3 class=xl27><% = dt.Rows[i][2].ToString()%></td>
  <td colspan=2 class=xl50>Year used</td>
  <td class=xl79 align=right x:num><% = dt.Rows[i][8].ToString()%></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl78 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Power
  designed</td>
  <td class=xl27></td>
  <td colspan=3 class=xl27><% = dt.Rows[i][9].ToString()%></td>
  <td colspan=2 class=xl102>Reason for not using</td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td height=21 class=xl78 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Date
  ceased using fixed asset</td>
  <td colspan=3 class=xl27><% = dt.Rows[i][10].ToString()%></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 
  <%
     } %>
 <tr class=xl31 height=22 style='height:16.5pt'>
  <td height=22 class=xl78 style='height:16.5pt'>&nbsp;</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl80>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl66 style='height:16.5pt'>Document</td>
  <td class=xl39 style='border-left:none'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl52>Cost of fixed asset</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td colspan=3 class=xl114 style='border-right:1.0pt solid black;border-left:
  none'><span style='mso-spacerun:yes'>        </span>Accumulated Depreciation
  of Fixed asset</td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=21 style='height:15.75pt'>
  <td height=21 class=xl51 style='height:15.75pt'>No.</td>
  <td class=xl55 width=62 style='border-top:none;border-left:none;width:47pt'>Date</td>
  <td colspan=2 class=xl53 style='border-left:none'><span
  style='mso-spacerun:yes'>      </span>Description</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>Cost</td>
  <td class=xl53 style='border-top:none;border-left:none'>Year</td>
  <td class=xl53 style='border-top:none;border-left:none'>Depreciation</td>
  <td class=xl56 style='border-top:none;border-left:none'>Accumulated total</td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=21 style='height:15.75pt'>
  <td height=21 class=xl57 style='height:15.75pt;border-top:none'>A</td>
  <td class=xl53 style='border-top:none;border-left:none'>B</td>
  <td class=xl48 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'>                        </span><span
  style='display:none'><span style='mso-spacerun:yes'> </span>C</span></td>
  <td class=xl58 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none' x:num>1</td>
  <td class=xl53 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl53 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>4</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=17 style='height:12.75pt'>
  <td height=17 class=xl94 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl119 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl49 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl97 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=16 style='height:12.0pt'>
  <td height=16 class=xl82 style='height:12.0pt'>&nbsp;</td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl83>&nbsp;</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=26 style='height:19.5pt'>
  <td colspan=9 height=26 class=xl72 style='border-right:1.0pt solid black;
  height:19.5pt'>MODE OF TOOLS AND ACCESSORIES</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=27 style='height:20.25pt'>
  <td height=27 class=xl72 style='height:20.25pt'>&nbsp;</td>
  <td colspan=7 class=xl84 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=21 style='height:15.75pt'>
  <td height=21 class=xl60 style='height:15.75pt'>No.</td>
  <td colspan=3 class=xl61 style='border-left:none'>Name, mode of tools and
  accessories</td>
  <td class=xl62 style='border-left:none'>&nbsp;</td>
  <td class=xl61 style='border-left:none'>Unit</td>
  <td colspan=2 class=xl61 style='border-left:none'>Quantity</td>
  <td class=xl63 style='border-left:none'>Value</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=21 style='height:15.75pt'>
  <td height=21 class=xl57 style='height:15.75pt;border-top:none'>A</td>
  <td colspan=3 class=xl59 style='border-left:none'>B</td>
  <td class=xl54 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl59 style='border-top:none;border-left:none'>C</td>
  <td colspan=2 class=xl59 style='border-left:none' x:num>1</td>
  <td class=xl64 style='border-top:none;border-left:none' x:num>2</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=27 style='height:20.25pt'>
  <td height=27 class=xl42 style='height:20.25pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=21 style='height:15.75pt'>
  <td height=21 class=xl85 colspan=4 style='height:15.75pt;mso-ignore:colspan'>Account
  for reducing FA according to doc. No.</td>
  <td class=xl27></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl87>Date</td>
  <td class=xl79>&nbsp;</td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=21 style='height:15.75pt'>
  <td height=21 class=xl85 style='height:15.75pt'>&nbsp;</td>
  <td class=xl50></td>
  <td class=xl86></td>
  <td class=xl30></td>
  <td class=xl27></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl87></td>
  <td class=xl79>&nbsp;</td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl85 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Reason
  for decreasing</td>
  <td class=xl30></td>
  <td class=xl27></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl79>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl85 style='height:12.0pt'>&nbsp;</td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl79>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl73 style='height:15.75pt'>&nbsp;</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl87>Date</td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl73 style='height:15.75pt'>&nbsp;</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl87></td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl73 style='height:15.75pt'>&nbsp;</td>
  <td colspan=2 class=xl104>Prepared by</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl104>Chief Accountant</td>
  <td class=xl25></td>
  <td class=xl88><span style='mso-spacerun:yes'>        </span>Director</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl73 style='height:12.75pt'>&nbsp;</td>
  <td colspan=2 class=xl107><span style='mso-spacerun:yes'>  
  </span>(Signature)</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl89>(Signature)</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl90>(Signature and seal)</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'>&nbsp;</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl77>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl91 style='height:15.75pt'>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl92>&nbsp;</td>
  <td class=xl93>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=66 style='width:50pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=0></td>
  <td width=109 style='width:82pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=169 style='width:127pt'></td>
  <td width=10 style='width:8pt'></td>
  <td width=90 style='width:68pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
