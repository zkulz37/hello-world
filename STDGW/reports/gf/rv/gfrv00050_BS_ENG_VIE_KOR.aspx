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

        
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL1);
    if (dt.Rows.Count > 0)
    {
        l_cmp_name = dt.Rows[0][0].ToString();
        l_cmp_add = dt.Rows[0][1].ToString();
        l_cmp_taxcode = dt.Rows[0][3].ToString();
    }
    string para = "'" + l_form_type + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_Scale1 + "','" + l_ccy + "','" + l_exrate + "','" + l_month + "'";
    //Response.Write(para);
    //Response.End();
    string SQL_TEMP = "acnt.sp_sel_gfrv00050_1";
    
    DataTable dt_detail = ESysLib.TableReadOpenCursor(SQL_TEMP, para);
    l_date_to = l_date_to.Substring(6, 2) + "/" + l_date_to.Substring(4, 2) +"/" + l_date_to.Substring(0, 4);//2009.08.25  
       
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptENGVIEKOR_files/filelist.xml">
<link rel=Edit-Time-Data href="rptENGVIEKOR_files/editdata.mso">
<link rel=OLE-Object-Data href="rptENGVIEKOR_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2010-01-22T10:23:55Z</o:LastPrinted>
  <o:Created>2008-09-16T06:17:58Z</o:Created>
  <o:LastSaved>2010-01-22T10:46:24Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.5606</o:Version>
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
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
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
.xl45
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
.xl46
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
.xl47
	{mso-style-parent:style0;
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
.xl48
	{mso-style-parent:style0;
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
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl50
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
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
.xl63
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
.xl64
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl68
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl84
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl88
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;}
.xl91
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ \\ dd\\\,\\ \\ yyyy";
	text-align:left;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl93
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl100
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl103
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl104
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl105
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
.xl106
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
.xl107
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
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
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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
  <x:WindowHeight>8745</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1239 style='border-collapse:
 collapse;table-layout:fixed;width:929pt'>
 <col class=xl25 width=183 span=3 style='mso-width-source:userset;mso-width-alt:
 6692;width:137pt'>
 <col class=xl25 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl26 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl26 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl25 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl25 width=64 span=5 style='width:48pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 width=183 style='height:18.75pt;width:137pt'><%=l_cmp_name%></td>
  <td class=xl27 width=183 style='width:137pt'></td>
  <td class=xl27 width=183 style='width:137pt'></td>
  <td class=xl28 width=59 style='width:44pt'></td>
  <td colspan=3 class=xl72 width=296 style='width:223pt'>Form: B 01 - DN</td>
  <td class=xl25 width=15 style='width:11pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl29 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 colspan=2 style='height:15.0pt;mso-ignore:colspan'><%=l_cmp_add %></td>
  <td colspan=5 class=xl73
  x:str="(Issued with Decision No. 15/2006/QĐ-BTC/Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày ">(Issued
  with Decision No. 15/2006/QĐ-BTC/Ban hành theo Quyết định số 15/2006/QĐ-BTC
  ngày<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl32 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl73>dated March 20, 2006 by Ministry of Finance/20 tháng
  03 năm 2006 của Bộ trường Bộ Tài chính)</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 colspan=3 class=xl32 style='height:9.95pt;mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl36></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=7 height=26 class=xl74 style='height:19.5pt'>BALANCE SHEET/BẢNG
  CÂN ĐỐI KẾ TOÁN</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=22 style='height:16.5pt'>
  <td colspan=7 height=22 class=xl75 style='height:16.5pt'>As at/Tại ngày :
  <%=l_date_to %></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl37 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl36>(Unit :<%=trsScale %> VND)</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='height:31.5pt'>
  <td height=42 class=xl98 style='height:31.5pt'>ASSETS</td>
  <td class=xl98 style='border-left:none'>TÀI SẢN</td>
  <td class=xl99 style='border-left:none'>ASSETS(KOREAN)</td>
  <td class=xl100 width=59 style='border-left:none;width:44pt'>Code<br>
    Mã số</td>
  <td class=xl101 width=61 style='border-left:none;width:46pt'>Thuyết <br>
    minh</td>
  <td class=xl102 width=110 style='border-left:none;width:83pt'>Số cuối
  năm<br>
    </td>
  <td class=xl103 width=125 style='border-left:none;width:94pt'>Số đầu
  năm<br>
    </td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=20 style='height:15.0pt'>
  <td height=20 class=xl104 style='height:15.0pt;border-top:none' x:num>1</td>
  <td class=xl104 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl104 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl104 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl105 width=61 style='border-top:none;border-left:none;width:46pt'>5</td>
  <td class=xl106 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl106 style='border-top:none;border-left:none' x:num>7</td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
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
            if (dt_detail.Rows[i][10].ToString() == "I")
            {
                strBegin = "<i>";
                strEnd = "</i>";
            }
            if (dt_detail.Rows[i][10].ToString() == "B")
            {
                strBegin = "<b>";
                strEnd = "</b>";
            }
 %>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl93 style='height:19.5pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i][0].ToString() %><%=strEnd%></td>
  <td class=xl93 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl93 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][2].ToString() %><%=strEnd%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl87 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][7].ToString() %><%=strEnd%></td>
  <td class=xl88 align=right style='border-top:none;border-left:none'
  x:num><font color="#FF0000" style='mso-ignore:color'><%=strBegin%><%= dt_detail.Rows[i][8].ToString() %><%=strEnd%></font></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][9].ToString() %><%=strEnd%></td>
  <td class=xl38></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
    }
        } %>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl40 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl44 style='height:19.5pt'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl44><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl38></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl98 style='height:39.75pt'>RESOURCES</td>
  <td class=xl98 style='border-left:none'>NGUỒN VỐN</td>
  <td class=xl99 style='border-left:none'>RESOURCES(KOREAN)</td>
  <td class=xl100 width=59 style='border-left:none;width:44pt'>Mã<br>
    số</td>
  <td class=xl101 width=61 style='border-left:none;width:46pt'>Thuyết <br>
    minh</td>
  <td class=xl102 width=110 style='border-left:none;width:83pt'>Số cuối
  năm<br>
    </td>
  <td class=xl103 width=125 style='border-left:none;width:94pt'>Số đầu
  năm<br>
    </td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl99 style='height:15.75pt;border-top:none' x:num>1</td>
  <td class=xl99 style='border-top:none;border-left:none'>2</td>
  <td class=xl99 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl100 width=59 style='border-top:none;border-left:none;width:44pt'
  x:num>4</td>
  <td class=xl101 width=61 style='border-top:none;border-left:none;width:46pt'>5</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl107 style='border-top:none;border-left:none' x:num>7</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
    
    if (dt_detail.Rows.Count >0)
	{
        string strBegin = "";
        string strEnd = "";
        
	    for(i = 53; i < 90; i++)
	    {
            strBegin = "";
            strEnd = "";
            if (dt_detail.Rows[i][10].ToString() == "I")
            {
                strBegin = "<i>";
                strEnd = "</i>";
            }
            if (dt_detail.Rows[i][10].ToString() == "B")
            {
                strBegin = "<b>";
                strEnd = "</b>";
            }
 %> 
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl93 style='height:19.5pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i][0].ToString() %><%=strEnd%></td>
  <td class=xl93 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl93 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][2].ToString() %><%=strEnd%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl87 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][7].ToString() %><%=strEnd%></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][8].ToString() %><%=strEnd%></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][9].ToString() %><%=strEnd%></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
     }
        }
%>
 <tr class=xl29 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl29 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl49></td>
  <td colspan=2 class=xl50 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'></td>
  <td class=xl53></td>
  <td colspan=2 class=xl54 style='mso-ignore:colspan'></td>
  <td class=xl38></td>
 </tr>
 <tr class=xl29 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=7 height=24 class=xl76 style='height:18.0pt'>OFF BALANCE SHEET
  ITEMS/TÀI KHOẢN NGOÀI BẢNG</td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=4 class=xl37 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl36></td>
  <td class=xl39></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=43 style='height:32.25pt'>
  <td height=43 class=xl78 style='height:32.25pt'>ITEMS</td>
  <td class=xl89>Khoản mục</td>
  <td class=xl79 style='border-left:none'>ITEMS(KOREAN)</td>
  <td class=xl97 width=59 style='border-left:none;width:44pt'>Mã<br>
    số</td>
  <td class=xl55 style='border-left:none'>Notes</td>
  <td class=xl80 width=110 style='border-left:none;width:83pt'>Số cuối
  năm<br>
    </td>
  <td class=xl81 width=125 style='border-left:none;width:94pt'>Số đầu năm<br>
    </td>
  <td class=xl39></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
 
 
    
     if (dt_detail.Rows.Count > 0)
     {
         string strBegin = "";
         string strEnd = "";
         //dt_detail.Rows.Count - 1
         for (i = 91; i < dt_detail.Rows.Count - 1; i++)
         {
             strBegin = "";
             strEnd = "";
             if (dt_detail.Rows[i][10].ToString() == "I")
             {
                 strBegin = "<i>";
                 strEnd = "</i>";
             }
             if (dt_detail.Rows[i][10].ToString() == "B")
             {
                 strBegin = "<b>";
                 strEnd = "</b>";
             }
      %>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl94 style='height:19.5pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i][0].ToString() %><%=strEnd%></td>
  <td class=xl95 style='border-top:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl96 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][2].ToString() %><%=strEnd%></td>
  <td class=xl82 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl83 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][7].ToString() %><%=strEnd%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][8].ToString() %><%=strEnd%> </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][9].ToString() %><%=strEnd%></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
    }
    } %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl37 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=3 class=xl91>dated/Ngày<span style='mso-spacerun:yes'> 
  </span><%=l_date_to %></td>
  <td class=xl39></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
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
                 case "KOR":
                     l_colK_1 = dt_EACAB044.Rows[j][0].ToString();
                     l_colK_2 = dt_EACAB044.Rows[j][1].ToString();
                     l_colK_3 = dt_EACAB044.Rows[j][2].ToString();
                     l_colK_4 = dt_EACAB044.Rows[j][3].ToString();
                     l_colK_5 = dt_EACAB044.Rows[j][5].ToString();
                     break;
                 case "VIE_SIG":
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
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl56 style='height:18.0pt'><%=l_colV_1%></td>
  <td class=xl56></td>
  <td class=xl56><%=l_colV_2%></td>
  <td class=xl57></td>
  <td colspan=3 class=xl56 x:str><%=l_colV_3%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl58></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl92 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=l_colE_1%></td>
  <td class=xl59><%=l_colE_2%></td>
  <td colspan=4 class=xl90
  x:str="(Sign, Fullname, Stamp)/(Ký, họ tên, đóng dấu)"><span
  style='mso-spacerun:yes'> </span><%=l_colE_3%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl37 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl37 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl37 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl37 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl60 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl61 style='height:15.75pt'><%=l_colN_1%></td>
  <td class=xl61></td>
  <td class=xl61><%=l_colN_1%></td>
  <td class=xl61></td>
  <td colspan=3 class=xl77 x:str><span
  style='mso-spacerun:yes'> </span><%=l_colN_1%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl58></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl62 style='height:15.75pt'>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl63>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl64 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td class=xl68></td>
  <td class=xl26></td>
  <td class=xl69></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl64 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td class=xl68></td>
  <td class=xl26></td>
  <td class=xl69></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl64 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td class=xl68></td>
  <td class=xl26></td>
  <td class=xl69></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl64 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
  <td class=xl66></td>
  <td class=xl67></td>
  <td class=xl68></td>
  <td class=xl26></td>
  <td class=xl69></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=183 style='width:137pt'></td>
  <td width=183 style='width:137pt'></td>
  <td width=183 style='width:137pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=15 style='width:11pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
