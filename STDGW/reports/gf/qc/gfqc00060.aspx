<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("genuwin");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_tac_subcontract_pk = Request["p_tac_subcontract_pk"];
    string l_company = Request["p_company"];
    string l_parameter = "'" + l_tac_subcontract_pk + "', ";
//----------------------------------------------------------------------------------------------------------------   
    string ls_datefrom = "";
    string ls_dateto = "";
    DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_gfqc00060_2_report", l_tac_subcontract_pk);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    ls_datefrom = dt.Rows[0][6].ToString().Trim();
    if (ls_datefrom.Length == 8)
    {
        ls_datefrom = ls_datefrom.Substring(6, 2) + "/" + ls_datefrom.Substring(4, 2) + "/" + ls_datefrom.Substring(0, 4);
    }
    else
    {
        ls_datefrom = "";
    }
    ls_dateto = dt.Rows[0][7].ToString().Trim();
    if (ls_dateto.Length == 8)
    {
        ls_dateto = ls_dateto.Substring(6, 2) + "/" + ls_dateto.Substring(4, 2) + "/" + ls_dateto.Substring(0, 4);
    }
    else
    {
        ls_dateto = ""; 
    }
//------------------------------------------------------------------------------------------------------------------
    string l_taxcode = "";
    string l_compa = "";
    string l_address = "";
    
    string SQL1 = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);

    if (dt_f.Rows.Count > 0)
    {
        l_compa = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
        l_taxcode = dt_f.Rows[0][3].ToString();
    }

//------------------------------------------------------------------------------------------------------------------------------   
    
    DataTable dt2 = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfqc00060_1_report", l_tac_subcontract_pk);
    
    if (dt2.Rows.Count > 0)
    {
       
    }
//---------------------------------------------------------------------------------------------------------------------------
    decimal l_Remain = 0;
    
     
//-------------------------------------------------------------------------------------------------------------------------
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
<link rel=File-List href="gfqc00060_print_comment_files/filelist.xml">
<link rel=Edit-Time-Data href="gfqc00060_print_comment_files/editdata.mso">
<link rel=OLE-Object-Data href="gfqc00060_print_comment_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2009-02-17T09:21:59Z</o:LastPrinted>
  <o:Created>2007-09-13T09:21:45Z</o:Created>
  <o:LastSaved>2010-01-12T07:12:53Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in 0in 0in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
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
.xl24
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style16;
	color:red;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	color:red;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
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
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	
	}
.xl77
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PROGRESS PAYMENT</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>86</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>24</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
       <x:RangeSelection>$C$20:$I$20</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=794 style='border-collapse:
 collapse;table-layout:fixed;width:597pt'>
 <col class=xl24 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl24 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col class=xl25 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <col class=xl24 width=124 span=3 style='mso-width-source:userset;mso-width-alt:
 4534;width:93pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 width=15 style='height:12.0pt;width:11pt'></td>
  <td class=xl24 width=13 style='width:10pt'></td>
  <td class=xl25 width=26 style='width:20pt'></td>
  <td colspan=7 class=xl26 width=724 style='width:544pt'>Tên công ty :
  <%=l_compa%></td>
  <td class=xl24 width=16 style='width:12pt'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=2 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=7 class=xl26>Địa chỉ : <%=l_address%></td>
  <td class=xl24></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=2 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=7 class=xl26>Mã số thuế : <%=l_taxcode%></td>
  <td class=xl24></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=2 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td colspan=4 class=xl64>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td colspan=7 class=xl63>PROGRESS PAYMENT</td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     decimal Final = 0;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         Final = decimal.Parse(dt.Rows[i][18].ToString());
  %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>Contract No :</td>
  <td class=xl48><%=dt.Rows[i][5]%></td>
  <td class=xl50>Contract Name :</td>
  <td class=xl48><%=dt.Rows[i][47]%></td>
  <td class=xl48 colspan=2 ><%=dt.Rows[i][48]%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>P/L Name :</td>
  <td class=xl24><%=dt.Rows[i][45]%></td>
  <td class=xl27><%=dt.Rows[i][46]%></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>Quantity :</td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][20]%></td>
  <td class=xl36 >Quantity Adj:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'> </span>                            </td>
  <td class=xl36>Currency:</td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][11]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>Unit price:</td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][19]%></td>
  <td class=xl36 >Unit price:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'> </span>                     </td>
  <td class=xl36>Total price:</td>
  <td class=xl37 x:num><span
  style='mso-spacerun:yes'> </span>                         </td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>VAT :</td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][35]%></td>
  <td class=xl36 >VAT Adj:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][36]%></td>
  <td class=xl36>Total VAT:</td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][34]%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36>Contract Amount :</td>
  <td class=xl53 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][16]%></td>
  <td class=xl36 >Adjust amount:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][17]%></td>
  <td class=xl36 >Final (1):<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl61 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][18]%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     
     for (int j = 0; j < dt2.Rows.Count; j++)
     {
         
%>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl24 style='height:14.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl36><%=dt2.Rows[j][9]%></td>
  <td class=xl24><%=dt2.Rows[j][2]%></td>
  <td class=xl38 align=right x:num><%=dt2.Rows[j][3]%>%</td>
  <td class=xl37 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt2.Rows[j][4]%></td>
  <% if (j == 0)
     { %>
  <td class=xl36><%=dt2.Rows[j][10]%></td>
  <td class=xl24 align=right x:num><%=ls_datefrom%>&nbsp;-&nbsp;<%=ls_dateto%></td>
  <%}
    else
    {     
  %>
    <td class=xl36></td>
  <td class=xl24 align=right x:num></td>
<% 
      }
%>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%} %>
 
 <%
} %>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl24 style='height:9.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl52 colspan=3 style='mso-ignore:colspan'>I. ADVANCE STATUS</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl39>No</td>
  <td class=xl40>Date</td>
  <td class=xl39>SEQ</td>
  <td class=xl39 style='border-left:none'>Voucher No</td>
  <td colspan=3 class=xl65 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl39 style='border-left:none'>Advance Amt</td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     int z = 0;
     decimal Advance = 0;
     string ls_date = "";
     DataTable dt3 = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfqc00060_5_adv", l_tac_subcontract_pk);
        if (dt3.Rows.Count == 0)
        {
           
        }
            for(int k=0;k<dt3.Rows.Count;k++)
            {
                if (dt3.Rows[k][5].ToString().Trim() != "")
                {
                    Advance += decimal.Parse(dt3.Rows[k][5].ToString());
                }
                else
                {
                    Advance = 0;
                }
                ls_date = dt3.Rows[k][1].ToString().Trim();
                ls_date = ls_date.Substring(6, 2) + "/" + ls_date.Substring(4, 2) + "/" + ls_date.Substring(0, 4);
  %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl45 style='border-top:none' x:num><%=z+1%></td>
  <td class=xl46 style='border-top:none;border-left:none'><%=ls_date%></td>
  <td class=xl47 style='border-top:none;border-left:none' x:num><%=dt3.Rows[k][2]%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=dt3.Rows[k][3]%></td>
  <td colspan=3 class=xl67 width=372 style='border-left:none;width:279pt'><%=dt3.Rows[k][4]%></td>
  <td class=xl54 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt3.Rows[k][5]%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     z += 1;
            } %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl65 style='border-right:.5pt solid black'>Total Advance
  (2)</td>
  <td class=xl55 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=Advance%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl52 colspan=3 style='mso-ignore:colspan'>II. DEDUCT STATUS</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl56></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl39>No</td>
  <td class=xl40>Date</td>
  <td class=xl39>SEQ</td>
  <td class=xl39 style='border-left:none'>Voucher No</td>
  <td colspan=3 class=xl65 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl57 style='border-left:none' x:str="Deduct Amt"><span
  style='mso-spacerun:yes'> </span>Deduct Amt<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     int g = 0;
     string ls_date4 = "";
     decimal Deduct=0;
    DataTable dt4 = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfqc00060_5_deduct", l_tac_subcontract_pk);
   
            for(int h=0;h<dt4.Rows.Count;h++)
            {
                if (dt4.Rows[h][5].ToString().Trim() != "")
                {
                    Deduct += decimal.Parse(dt4.Rows[h][5].ToString());
                }
                else
                {
                    Deduct = 0;
                }
                ls_date4 = dt4.Rows[h][1].ToString().Trim();
                
                ls_date4 = ls_date4.Substring(6, 2) + "/" + ls_date4.Substring(4, 2) + "/" + ls_date4.Substring(0, 4);
  %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl45 style='border-top:none' x:num><%=g+1 %></td>
  <td class=xl46 style='border-top:none;border-left:none'><%=ls_date%></td>
  <td class=xl47 style='border-top:none;border-left:none' x:num><%=dt4.Rows[h][2]%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=dt4.Rows[h][3]%></td>
  <td colspan=3 class=xl67 width=372 style='border-left:none;width:279pt'><%=dt4.Rows[h][4]%></td>
  <td class=xl54 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt4.Rows[h][5]%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
     g += 1;
            } %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl65 style='border-right:.5pt solid black'>Total Deduct
  (3)</td>
  <td class=xl55 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=Deduct%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <%
      l_Remain = Advance - Deduct;
      decimal Opening = 0;
      %>
  <td colspan=7 class=xl65 style='border-right:.5pt solid black'>Remain (4) =
  (2) - (3)</td>
  <td class=xl58 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=l_Remain%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl52 colspan=2 style='mso-ignore:colspan'>III. A/P Status</td>
  <td class=xl26></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Openning A/P Amt (5):</td>
  <td class=xl59 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=Opening%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl39>No</td>
  <td class=xl40>Date</td>
  <td class=xl39>SEQ</td>
  <td class=xl39 style='border-left:none'>Voucher No</td>
  <td colspan=3 class=xl65 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl57 style='border-top:none;border-left:none' x:str="A/P Amt"><span
  style='mso-spacerun:yes'> </span>A/P Amt<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
        
     int r = 0;
     string ls_date5 = "";
     decimal AP=0;
    DataTable dt5 = ESysLib.TableReadOpenCursor("ACNT.SP_SEL_GFQC00060_5_AP", l_tac_subcontract_pk);
    if (dt5.Rows.Count == 0)
    {
       
    }
            for(int u=0;u<dt5.Rows.Count;u++)
            {
                if (dt5.Rows[u][5].ToString().Trim() != "")
                {
                    AP += decimal.Parse(dt5.Rows[u][5].ToString());
                }
                else
                {
                    AP = 0;
                }
                ls_date5 = dt5.Rows[u][1].ToString().Trim();
                
                ls_date5 = ls_date5.Substring(6, 2) + "/" + ls_date5.Substring(4, 2) + "/" + ls_date5.Substring(0, 4);

      %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl45 style='border-top:none' x:num><%=r+1%></td>
  <td class=xl46 style='border-top:none;border-left:none'><%=ls_date%></td>
  <td class=xl47 style='border-top:none;border-left:none' x:num><%=dt5.Rows[u][2]%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=dt5.Rows[u][3]%></td>
  <td colspan=3 class=xl67 width=372 style='border-left:none;width:279pt'><%=dt5.Rows[u][4]%></td>
  <td class=xl54 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt5.Rows[u][5]%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
 r+=1;
            }
  %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl65 style='border-right:.5pt solid black'>Total A/P (6)</td>
  <td class=xl58 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=AP%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl65 style='border-right:.5pt solid black'>Grand Total
  A/P (7) = (2) + (5) + (6)</td>
  <%
      decimal Grand_Total = 0;
      Grand_Total = Advance + Opening + AP;
       %>
  <td class=xl58 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=Grand_Total%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl71 style='border-right:.5pt solid black'>REMAIN A/P (8)
  = (7) - (2)</td>
  <%
      decimal Remain_AP = 0;
      Remain_AP = Grand_Total - Advance;
       %>
  <td class=xl58 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=Remain_AP%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl52 colspan=3 style='mso-ignore:colspan'>IV. PAYMENT Status</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Openning Paymnent Amt
  (9):</td>
  <%decimal Opening_Payment = 0; %>
  <td class=xl59 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=Opening_Payment%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl39>No</td>
  <td class=xl40>Date</td>
  <td class=xl39>SEQ</td>
  <td class=xl39 style='border-left:none'>Voucher No</td>
  <td colspan=3 class=xl65 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl57 style='border-top:none;border-left:none' x:str="Payment Amt"><span
  style='mso-spacerun:yes'> </span>Payment Amt<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
 </tr>
  <%
        
     int p = 0;
     string ls_date6 = "";
     decimal Payment=0;
     DataTable dt6 = ESysLib.TableReadOpenCursor("ACNT.SP_SEL_GFQC00060_5_PAY", l_tac_subcontract_pk);
   
            for(int a=0;a<dt6.Rows.Count;a++)
            {
                if (dt6.Rows[a][5].ToString().Trim() != "")
                {
                    Payment += decimal.Parse(dt6.Rows[a][5].ToString());
                }
                else
                {
                    Payment = 0;
                }
                ls_date6 = dt6.Rows[a][1].ToString().Trim();
                
                ls_date6 = ls_date6.Substring(6, 2) + "/" + ls_date6.Substring(4, 2) + "/" + ls_date6.Substring(0, 4);

      %>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl45 style='border-top:none' x:num><%=p+1%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=ls_date%></td>
  <td class=xl47 style='border-top:none;border-left:none' x:num><%=dt6.Rows[a][2]%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%=dt6.Rows[a][3]%></td>
  <td colspan=3 class=xl68 width=372 style='border-right:.5pt solid black;
  border-left:none;width:279pt'><%=dt6.Rows[a][4]%></td>
  <td class=xl54 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dt6.Rows[a][5]%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <%
 p+=1;
            }
  %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl65 style='border-right:.5pt solid black'>Total Payment
  (10)</td>
  <td class=xl55 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=Payment%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl24 style='height:9.75pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=7 class=xl49 style='mso-ignore:colspan'></td>
  <td class=xl60></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl52 colspan=4 style='mso-ignore:colspan'>V. TOTAL PAYMENT (11) =
  (2) + (10)</td>
  <td class=xl24></td>
  <%decimal Total_payment = 0;
    Total_payment = Advance + Payment; %>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl60 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=Total_payment%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl52 colspan=4 style='mso-ignore:colspan'>VI. REMAIN CONTRACT (12)
  = (1) - (11)</td>
  <%decimal Remain_contract = 0;
    Remain_contract = Final - Total_payment; %>
  <td class=xl24></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl61 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span
  style='mso-spacerun:yes'> </span><%=Remain_contract%></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan' >Remark:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl24 style='height:24.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=4 class=xl65 style='border-right:.5pt solid black'>ACCOUNTING
  TEAM</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
  <%
     string SQL
    = "SELECT   " +
        "    D.CODE,  " +
        "    D.CHAR_1,   " +
        "    D.CHAR_2,   " +
        "    D.CHAR_3,   " +
        "    D.CHAR_4,   " +
        "    D.CHAR_5,   " +
        "    D.REMARK,  " +
        "   D.CODE_LNM, " +
        "   D.CODE_FNM " +
        " FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M  " +
        " WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK  " +
        " AND M.ID='EACAB012'  " +
        " order by D.ORD  ";

     DataTable dt9 = ESysLib.TableReadOpen(SQL);
     string n1 = "";
     string n2 = "";
     string n3 = "";
     string n4 = "";
     string n5 = "";
     string n6 = "";
     for (int k = 0; k < dt9.Rows.Count; k++)
     {

         string strTmp = dt9.Rows[k][0].ToString();
         if (strTmp == "VIE")
         {
             n1 = dt9.Rows[k][4].ToString();
             n2 = dt9.Rows[k][7].ToString();
             n3 = dt9.Rows[k][8].ToString();
             
             
         }
         else if (strTmp == "NAM")
         {
             n4 = dt9.Rows[k][4].ToString();
             n5 = dt9.Rows[k][7].ToString();
             n6 = dt9.Rows[k][8].ToString();
         }
     }
      %>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl24 style='height:15.95pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl39 style='border-top:none'>Date</td>
  <td class=xl41 style='border-top:none'><%=n1%></td>
  <td class=xl41 style='border-top:none'><%=n2%></td>
  <td class=xl41 style='border-top:none'><%=n3%></td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl42 style='border-top:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl43>                    </td>
  <td class=xl43 style='border-left:none'><%=n4%></td>
  <td class=xl43 style='border-left:none'><%=n5%></td>
  <td class=xl43 style='border-left:none'><%=n6%></td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl62 style='border-left:none'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl24 style='height:23.25pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl24 style='height:23.25pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=4 class=xl65 style='border-right:.5pt solid black'>CONTRACT TEAM</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>

 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl39 style='border-top:none'>Date</td>
  <td class=xl41 style='border-top:none'><%=n1 %></td>
  <td class=xl41 style='border-top:none'><%=n2 %></td>
  <td class=xl41 style='border-top:none'><%=n3 %></td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl42 style='border-top:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl43>                         </td>
  <td class=xl43 style='border-left:none'><%=n4 %></td>
  <td class=xl43 style='border-left:none'><%=n5 %></td>
  <td class=xl43 style='border-left:none'><%=n6 %></td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-left:none'>&nbsp;</td>
  <td class=xl62 style='border-left:none'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl24 style='height:17.1pt'></td>
  <td class=xl76>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl75>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=2 class=xl24 style='height:17.1pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=15 style='width:11pt'></td>
  <td width=13 style='width:10pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=16 style='width:12pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
