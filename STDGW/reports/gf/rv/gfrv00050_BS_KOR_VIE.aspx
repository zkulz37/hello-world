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
<link rel=File-List href="rptENG_VIE_files/filelist.xml">
<link rel=Edit-Time-Data href="rptENG_VIE_files/editdata.mso">
<link rel=OLE-Object-Data href="rptENG_VIE_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2008-09-16T06:20:47Z</o:LastPrinted>
  <o:Created>2008-09-16T06:17:58Z</o:Created>
  <o:LastSaved>2010-01-22T08:40:24Z</o:LastSaved>
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
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl40
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
	mso-protection:unlocked visible;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl42
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
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl43
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
	mso-protection:unlocked visible;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl44
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
	border-left:.5pt solid windowtext;}
.xl45
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
	border-left:none;}
.xl46
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
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl47
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
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
.xl55
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
.xl56
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
.xl57
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
.xl58
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
.xl59
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
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl60
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
	mso-protection:unlocked visible;}
.xl61
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
	mso-protection:unlocked visible;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl63
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
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl65
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	text-align:center;
	vertical-align:middle;
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
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:2.0pt double windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
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
.xl74
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
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
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
.xl87
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
.xl88
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl89
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl90
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl91
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl92
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl94
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl95
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl96
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mmm\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl99
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl100
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl101
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmmm\\ \\ dd\\\,\\ \\ yyyy";
	text-align:center;
	vertical-align:middle;}
.xl102
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl103
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
.xl104
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl105
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl106
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl107
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
.xl108
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
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl109
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	mso-protection:unlocked visible;}
.xl110
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl111
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl112
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
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
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
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
  <x:WindowHeight>8355</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1980</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1236 style='border-collapse:
 collapse;table-layout:fixed;width:929pt'>
 <col class=xl25 width=285 span=2 style='mso-width-source:userset;mso-width-alt:
 10422;width:214pt'>
 <col class=xl25 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl26 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl25 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl25 width=64 span=5 style='width:48pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl27 width=285 style='height:18.75pt;width:214pt'><%=l_cmp_name%></td>
  <td class=xl27 width=285 style='width:214pt'></td>
  <td class=xl28 width=50 style='width:38pt'></td>
  <td colspan=3 class=xl96 width=281 style='width:212pt'>Form/Mẫu số: B03 - DN</td>
  <td class=xl25 width=15 style='width:11pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl29 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'><%=l_cmp_add %></td>
  <td colspan=5 class=xl97
  x:str="(Issued with Decision No. 15/2006/QĐ-BTC/Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày ">(Issued
  with Decision No. 15/2006/QĐ-BTC/Ban hành theo Quyết định số 15/2006/QĐ-BTC
  ngày<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt'></td>
  <td colspan=5 class=xl97>dated March 20, 2006 by Ministry of Finance/20 tháng
  03 năm 2006 của Bộ trường Bộ Tài chính)</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 colspan=2 class=xl32 style='height:9.95pt;mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl36></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=6 height=26 class=xl98 style='height:19.5pt'>BALANCE SHEET/BẢNG
  CÂN ĐỐI KẾ TOÁN</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=22 style='height:16.5pt'>
  <td colspan=6 height=22 class=xl99 style='height:16.5pt'>As at/Tại ngày :
  <%=l_date_to %></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl37 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl36>(Unit :<%=trsScale %> VND)</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='height:31.5pt'>
  <td height=42 class=xl38 style='height:31.5pt'>ASSETS(KOREAN)</td>
  <td class=xl39>Tài sản</td>
  <td class=xl40 width=50 style='width:38pt'>Code<br>
    Mã số</td>
  <td class=xl41 width=61 style='width:46pt'>Thuyết <br>
    minh</td>
  <td class=xl42 width=110 style='width:83pt'>Số cuối năm</td>
  <td class=xl43 width=110 style='width:83pt'>Số đầu năm</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=20 style='height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt' x:num>1</td>
  <td class=xl45 x:num>1</td>
  <td class=xl45 x:num>2</td>
  <td class=xl46 width=61 style='width:46pt'>3</td>
  <td class=xl47 x:num>4</td>
  <td class=xl47 x:num>5</td>
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
  <td height=26 class=xl104 style='height:19.5pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i][2].ToString() %><%=strEnd%></td>
  <td class=xl104 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl105 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl106 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][7].ToString() %><%=strEnd%></td>
  <td class=xl107 align=right style='border-top:none;border-left:none'
  x:num><font color="#FF0000" style='mso-ignore:color'><%=strBegin%><%= dt_detail.Rows[i][8].ToString() %><%=strEnd%></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][9].ToString() %><%=strEnd%></td>
  <td class=xl48></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
    }
        } %>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl50 style='height:19.5pt'></td>
  <td class=xl51></td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl54 style='height:19.5pt'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl55>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl48></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl38 style='height:39.75pt'>RESOURCES(KOREAN)</td>
  <td class=xl39>NGUỒN VỐN</td>
  <td class=xl40 width=50 style='width:38pt'>Mã<br>
    số</td>
  <td class=xl41 width=61 style='width:46pt'>Thuyết <br>
    minh</td>
  <td class=xl42 width=110 style='width:83pt'>Số cuối năm</td>
  <td class=xl43 width=110 style='width:83pt'>Số đầu năm</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl59 style='height:15.75pt' x:num>1</td>
  <td class=xl60 style='border-top:none' x:num>1</td>
  <td class=xl61 width=50 style='width:38pt' x:num>2</td>
  <td class=xl62 width=61 style='width:46pt'>3</td>
  <td class=xl63 x:num>4</td>
  <td class=xl63 x:num>5</td>
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
  <td height=26 class=xl104 style='height:19.5pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i][2].ToString() %><%=strEnd%></td>
  <td class=xl104 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl105 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl106 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][7].ToString() %><%=strEnd%></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][8].ToString() %><%=strEnd%></td>
  <td class=xl107 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][9].ToString() %><%=strEnd%></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
  <%
     }
        }
%>
 <tr class=xl29 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl29 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl64></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
 </tr>
 <tr class=xl29 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl100 style='height:18.0pt'>OFF BALANCE SHEET(KOREAN)
  ITEMS/TÀI KHOẢN NGOÀI BẢNG</td>
  <td class=xl66></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 class=xl37 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl36></td>
  <td class=xl49></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=43 style='height:32.25pt'>
  <td height=43 class=xl70 style='height:32.25pt'>ITEMS(KOREAN)</td>
  <td class=xl71>Khoản mục</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>Notes</td>
  <td class=xl74 width=110 style='width:83pt'>Số cuối năm</td>
  <td class=xl108 width=110 style='width:83pt'>Số đầu năm<</td>
  <td class=xl49></td>
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
  <td height=26 class=xl109 style='height:19.5pt'><%=strBegin%><%= dt_detail.Rows[i][2].ToString() %><%=strEnd%></td>
  <td class=xl75 style='border-left:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl76><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl110><%=strBegin%><%= dt_detail.Rows[i][7].ToString() %><%=strEnd%></td>
  <td class=xl111 x:num><%=strBegin%><%= dt_detail.Rows[i][8].ToString() %><%=strEnd%></td>
  <td class=xl112 x:num><%=strBegin%><%= dt_detail.Rows[i][9].ToString() %><%=strEnd%></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <%
    }
    } %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl25 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl77></td>
  <td colspan=2 class=xl78 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl37 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=3 class=xl101>dated/Ngày<span style='mso-spacerun:yes'> 
  </span><%=l_date_to %></td>
  <td class=xl49></td>
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
  <td height=24 class=xl80 style='height:18.0pt'><%=l_colV_1%></td>
  <td class=xl80><%=l_colV_2%></td>
  <td class=xl81></td>
  <td colspan=3 class=xl80 x:str><%=l_colV_3%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl82></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl83 style='height:15.75pt'><%=l_colE_1%></td>
  <td class=xl83><%=l_colE_2%></td>
  <td colspan=4 class=xl102
  x:str><span
  style='mso-spacerun:yes'> </span><%=l_colE_3%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl37 style='height:18.0pt'></td>
  <td colspan=3 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl84 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl85 style='height:15.75pt'><%=l_colN_1%></td>
  <td class=xl85><%=l_colN_2%></td>
  <td class=xl85></td>
  <td colspan=3 class=xl103 x:str><span
  style='mso-spacerun:yes'> </span><%=l_colN_3%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl82></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl86 style='height:15.75pt'>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl86>&nbsp;</td>
  <td class=xl87>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl88 style='height:15.75pt'></td>
  <td class=xl89></td>
  <td class=xl90></td>
  <td class=xl91></td>
  <td class=xl92></td>
  <td class=xl26></td>
  <td class=xl93></td>
  <td colspan=2 class=xl94 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl95 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl88 style='height:15.75pt'></td>
  <td class=xl89></td>
  <td class=xl90></td>
  <td class=xl91></td>
  <td class=xl92></td>
  <td class=xl26></td>
  <td class=xl93></td>
  <td colspan=2 class=xl94 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl95 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl88 style='height:15.75pt'></td>
  <td class=xl89></td>
  <td class=xl90></td>
  <td class=xl91></td>
  <td class=xl92></td>
  <td class=xl26></td>
  <td class=xl93></td>
  <td colspan=2 class=xl94 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl95 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl88 style='height:18.0pt'></td>
  <td class=xl89></td>
  <td class=xl90></td>
  <td class=xl91></td>
  <td class=xl92></td>
  <td class=xl26></td>
  <td class=xl93></td>
  <td colspan=2 class=xl94 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl95 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=285 style='width:214pt'></td>
  <td width=285 style='width:214pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
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
