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
    //Response.Write(dt_detail.Rows[0][9].ToString());
    //Response.End();
    string SQL_TEMP = "acnt.sp_sel_gfrv00050_1";
    
    DataTable dt_detail = ESysLib.TableReadOpenCursor(SQL_TEMP, para);
        //Response.Write(dt_detail.Rows[0][9].ToString());
       // Response.End();
    l_date_to = l_date_to.Substring(6, 2) + "/" + l_date_to.Substring(4, 2) +"/" + l_date_to.Substring(0, 4);//2009.08.25  
       
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptQD15_files/filelist.xml">
<link rel=Edit-Time-Data href="rptQD15_files/editdata.mso">
<link rel=OLE-Object-Data href="rptQD15_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2008-09-16T06:20:47Z</o:LastPrinted>
  <o:Created>2008-09-16T06:17:58Z</o:Created>
  <o:LastSaved>2010-01-22T03:35:39Z</o:LastSaved>
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
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style21;
	font-size:14.0pt;
	font-weight:700;
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl35
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl36
	{mso-style-parent:style21;
	font-size:12.0pt;
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
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
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
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl44
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl46
	{mso-style-parent:style16;
	font-size:11.0pt;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl48
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
	mso-protection:unlocked visible;
	white-space:normal;}
.xl49
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
.xl50
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
	border-left:none;
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
	mso-protection:unlocked visible;}
.xl52
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl55
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
.xl56
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
.xl57
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
.xl58
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
.xl59
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
.xl60
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
.xl61
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\ \\ \\ ";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
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
.xl67
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
.xl68
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
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
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
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl72
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl78
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl80
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style21;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl83
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style21;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl86
	{mso-style-parent:style21;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-protection:unlocked visible;}
.xl87
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
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
.xl89
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl91
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl92
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl93
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
.xl94
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	mso-protection:unlocked visible;}
.xl95
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;}
.xl96
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt solid windowtext;
	mso-protection:unlocked visible;}
.xl97
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	mso-protection:unlocked visible;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:2.0pt double windowtext;
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
       <x:ActiveRow>26</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1480 style='border-collapse:
 collapse;table-layout:fixed;width:1114pt'>
 <col class=xl25 width=334 style='mso-width-source:userset;mso-width-alt:12214;
 width:251pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl26 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl27 width=138 span=2 style='mso-width-source:userset;mso-width-alt:
 5046;width:104pt'>
 <col class=xl25 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl25 width=334 style='mso-width-source:userset;mso-width-alt:12214;
 width:251pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl27 width=138 span=2 style='mso-width-source:userset;mso-width-alt:
 5046;width:104pt'>
 <col class=xl25 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl28 width=334 style='height:18.75pt;width:251pt'><%=l_cmp_name%></td>
  <td class=xl28 width=54 style='width:41pt'></td>
  <td class=xl28 width=61 style='width:46pt'></td>
  <td class=xl28 width=138 style='width:104pt'></td>
  <td class=xl29 width=138 style='width:104pt'>Mẫu số: B01 - DN</td>
  <td class=xl25 width=15 style='width:11pt'></td>
  <td class=xl25 width=334 style='width:251pt'></td>
  <td class=xl25 width=54 style='width:41pt'></td>
  <td class=xl25 width=61 style='width:46pt'></td>
  <td class=xl27 width=138 style='width:104pt'></td>
  <td class=xl27 width=138 style='width:104pt'></td>
  <td class=xl25 width=15 style='width:11pt'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>Địa chỉ:&nbsp;<%=l_cmp_add %></td>
  <td class=xl34></td>
  <td colspan=3 class=xl84
  x:str="(Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày ">(Ban hành theo
  Quyết định số 15/2006/QĐ-BTC ngày<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl35 style='height:15.75pt'></td>
  <td class=xl36></td>
  <td colspan=3 class=xl84>20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl35 style='height:9.95pt'></td>
  <td class=xl36></td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td colspan=5 height=26 class=xl85 style='height:19.5pt'>BẢNG CÂN ĐỐI KẾ TOÁN</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl30 height=20 style='height:15.0pt'>
  <td colspan=5 height=20 class=xl86 style='height:15.0pt'>Tại ngày <%=l_date_to %></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl36 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl39></td>
  <td class=xl40 x:str><span
  style='mso-spacerun:yes'> </span>(Đơn vị tính:<%=trsScale %> VND)<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl30 height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl41 style='height:39.75pt'>TÀI SẢN</td>
  <td class=xl42 width=54 style='width:41pt'>Mã<br>
    số</td>
  <td class=xl44 width=61 style='width:46pt'>Thuyết <br>
    minh</td>
  <td class=xl45>Số dư cuối kỳ</td>
  <td class=xl46>Số đầu năm</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl30 height=20 style='height:15.0pt'>
  <td height=20 class=xl47 style='height:15.0pt' x:num>1</td>
  <td class=xl48 width=54 style='width:41pt' x:num>2</td>
  <td class=xl49 width=61 style='width:46pt'>3</td>
  <td class=xl50 x:num>4</td>
  <td class=xl50 x:num>5</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
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
 <tr class=xl30 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl90 style='height:19.5pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl92 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][7].ToString() %><%=strEnd%></td>
  <td class=xl93 align=right style='border-top:none;border-left:none'
  x:num><font color="#FF0000" style='mso-ignore:color'><%=strBegin%><%= dt_detail.Rows[i][8].ToString() %><%=strEnd%></font></td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][9].ToString() %><%=strEnd%></td>
  <td class=xl51></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <%
    }
        } %>
 <tr class=xl30 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl53 style='height:19.5pt'></td>
  <td class=xl54></td>
  <td class=xl43></td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'></td>
  <td class=xl52></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl30 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl56 style='height:19.5pt'>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl52></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl30 height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl41 style='height:39.75pt'>NGUỒN VỐN</td>
  <td class=xl42 width=54 style='width:41pt'>Mã<br>
    số</td>
  <td class=xl44 width=61 style='width:46pt'>Thuyết <br>
    minh</td>
  <td class=xl61 x:str="Số dư cuối kỳ" x:fmla="=+D8"><span
  style='mso-spacerun:yes'> </span>Số dư cuối kỳ<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl61 x:str="Số đầu năm" x:fmla="=+E8"><span
  style='mso-spacerun:yes'> </span>Số đầu năm<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl30 height=20 style='height:15.0pt'>
  <td height=20 class=xl47 style='height:15.0pt' x:num>1</td>
  <td class=xl48 width=54 style='width:41pt' x:num>2</td>
  <td class=xl49 width=61 style='width:46pt'>3</td>
  <td class=xl50 x:num>4</td>
  <td class=xl50 x:num>5</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
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
 <tr class=xl30 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl90 style='height:19.5pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl92 style='border-top:none;border-left:none'><%=strBegin%><%= dt_detail.Rows[i][7].ToString() %><%=strEnd%></td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][8].ToString() %><%=strEnd%></td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><%=strBegin%><%= dt_detail.Rows[i][9].ToString() %><%=strEnd%></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <%
     }
        }
%>
 <tr class=xl30 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl30 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl62 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td colspan=2 class=xl63 style='mso-ignore:colspan'></td>
  <td class=xl64></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
 </tr>
 <tr class=xl30 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl54 style='height:18.0pt'>TÀI KHOẢN NGOÀI BẢNG</td>
  <td class=xl51></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl30 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl30 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl62 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl30 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl66 style='height:18.0pt'>Khoản mục</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>TM</td>
  <td class=xl68 x:str="Số dư cuối kỳ" x:fmla="=+D13"><span
  style='mso-spacerun:yes'> </span>Số dư cuối kỳ<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl69 x:str="Số đầu năm" x:fmla="=+E13"><span
  style='mso-spacerun:yes'> </span>Số đầu năm<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl51></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
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
 <tr class=xl30 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl94 style='height:18.0pt;border-top:none'><%=strBegin%><%= dt_detail.Rows[i][1].ToString() %><%=strEnd%></td>
  <td class=xl95 style='border-top:none'><%=strBegin%><%= dt_detail.Rows[i][6].ToString() %><%=strEnd%></td>
  <td class=xl96 style='border-top:none'><%=strBegin%><%= dt_detail.Rows[i][7].ToString() %><%=strEnd%></td>
  <td class=xl97 style='border-top:none' x:num><%=strBegin%><%= dt_detail.Rows[i][8].ToString() %><%=strEnd%> </td>
  <td class=xl98 style='border-top:none' x:num><%=strBegin%><%= dt_detail.Rows[i][9].ToString() %><%=strEnd%></td>
  <td class=xl51></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <%
    }
    } %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl25 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl71></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl72 style='height:18.0pt'></td>
  <td colspan=2 class=xl73 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl87>Tại ngày <%=l_date_to %></td>
  <td class=xl71></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
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
  <td height=24 class=xl74 style='height:18.0pt'><%=l_colV_1%></td>
  <td class=xl75 colspan=2 style='mso-ignore:colspan'><%=l_colV_2%></td>
  <td colspan=2 class=xl88 x:str><span
  style='mso-spacerun:yes'> </span><%=l_colV_3%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl76></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl77 height=21 style='height:15.75pt'>
  <td height=21 class=xl78 style='height:15.75pt'><%=l_colE_1%></td>
  <td colspan=2 class=xl78><%=l_colE_2%></td>
  <td colspan=2 class=xl89 x:str><span
  style='mso-spacerun:yes'> </span><%=l_colE_3%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl77></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl72 style='height:15.75pt'></td>
  <td class=xl79></td>
  <td class=xl73></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl81></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl72 style='height:15.75pt'></td>
  <td class=xl79></td>
  <td class=xl73></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl81></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl72 style='height:15.75pt'></td>
  <td class=xl79></td>
  <td class=xl73></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl81></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl72 style='height:18.0pt'></td>
  <td class=xl79></td>
  <td class=xl73></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl81></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl83 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl77 height=21 style='height:15.75pt'>
  <td height=21 class=xl78 style='height:15.75pt'><%=l_colN_1%></td>
  <td colspan=2 class=xl78><%=l_colN_2%></td>
  <td colspan=2 class=xl89 x:str><span
  style='mso-spacerun:yes'> </span><%=l_colN_3%><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl77></td>
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
