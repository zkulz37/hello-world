<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
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
    string cur_date = "";
    cur_date = DateTime.Today.ToString("dd-MM-yyyy");
    //Response.Write(cur_date);
    //Response.End();
    DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfqc00090_2_report", l_tac_subcontract_pk);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
 /*   ls_datefrom = dt.Rows[0][6].ToString().Trim();
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
    }*/
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
    
    DataTable dt2 = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfqc00090_1_report", l_tac_subcontract_pk);
    
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
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Long</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-02-09T05:53:51Z</o:LastPrinted>
  <o:Created>2010-02-09T05:43:15Z</o:Created>
  <o:LastSaved>2010-02-09T05:54:57Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in 1.0in .25in;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl37
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
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl81
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl82
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl84
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl87
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
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
       <x:ActiveRow>23</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
       <x:RangeSelection>$E$24:$H$24</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12525</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>1035</x:WindowTopX>
  <x:WindowTopY>-90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=934 style='border-collapse:
 collapse;table-layout:fixed;width:701pt'>
 <col width=64 span=5 style='width:48pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=64 style='width:48pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 width=64 style='height:12.75pt;width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td colspan=9 class=xl40 width=678 style='width:509pt'><%=l_compa%></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl26></td>
  <td colspan=9 class=xl40><%=l_address%></td>
  <td colspan=2 class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl26></td>
  <td colspan=9 class=xl40>Tax code: <%=l_taxcode%></td>
  <td colspan=2 class=xl24></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'></td>
  <td class=xl25></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl27></td>
  <td colspan=8 class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl33 style='height:18.0pt'>&nbsp;</td>
  <td class=xl25></td>
  <td colspan=9 class=xl41>PROGRESS PAYMENT</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl27></td>
  <td colspan=6 class=xl24></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <%
     decimal total_VAT = 0;
     decimal vat_famt = 0;
     decimal Qty = 0;
     decimal vat_famt_adj = 0;
        for(int i = 0;i<dt.Rows.Count;i++)
        {
            if (dt.Rows[i][18].ToString().Trim() != "")
                {
                    vat_famt += decimal.Parse(dt.Rows[i][18].ToString());
                }
                else
                {
                    vat_famt = 0;
                }
            
            if (dt.Rows[i][14].ToString().Trim() != "")
                {
                    Qty += decimal.Parse(dt.Rows[i][14].ToString());
                }
                else
                {
                    Qty = 0;
                }
            
            if (dt.Rows[i][19].ToString().Trim() != "")
                {
                    vat_famt_adj += decimal.Parse(dt.Rows[i][19].ToString());
                }
                else
                {
                    vat_famt_adj = 0;
                }
          total_VAT = vat_famt * Qty + vat_famt_adj;
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44>Contract No :</td>
  <td colspan=7 class=xl35><%=dt.Rows[i][6]%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44>Sub contract Name :</td>
  <td colspan=2 class=xl42><%=dt.Rows[i][3]%></td>
  <td colspan=5 class=xl45><%=dt.Rows[i][4]%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44>Project Name :</td>
  <td colspan=2 class=xl42><%=dt.Rows[i][1]%></td>
  <td colspan=5 class=xl45><%=dt.Rows[i][2]%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44>Quantity :</td>
  <td colspan=2 class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][14]%></td>
  <td class=xl44 x:str="Quantity Adj: ">Quantity Adj:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span>1.00 </td>
  <td colspan=2 class=xl44></td>
  <td class=xl47></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44>Unit price:</td>
  <td colspan=2 class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][15]%></td>
  <td class=xl44 x:str="Unit price: ">Unit price:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl47></td>
  <td class=xl44>Total price:</td>
  <td class=xl44></td>
  <td class=xl47></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44>VAT :</td>
  <td colspan=2 class=xl46 x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][18]%></td>
  <td class=xl44 x:str="VAT Adj: ">VAT Adj:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][19]%></td>
  <td class=xl44>Total VAT:</td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=total_VAT%></td>
  <td class=xl47></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44>Contract Amount :</td>
  <td colspan=2 class=xl46 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][10]%></td>
  <td class=xl44 x:str="Adjust amount: ">Adjust amount:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][12]%></td>
  <td class=xl44 x:str="Final: ">Final:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][13]%></td>
  <td class=xl47></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44>Period of contract :</td>
  <td colspan=2 class=xl48 ></td>
  <td class=xl44></td>
  <td class=xl47></td>
  <td colspan=2 class=xl44></td>
  <td class=xl47></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <%
     for(int j = 0;j<dt2.Rows.Count;j++)
     {
      %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44><%=dt2.Rows[j][9]%></td>
  <td colspan=2 class=xl42><%=dt2.Rows[j][2]%></td>
  <td class=xl49 align=right ><%=dt2.Rows[j][3]%></td>
  <td class=xl47 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><span style='mso-spacerun:yes'> </span><%=dt2.Rows[j][4]%></td>
  <td colspan=3 class=xl43></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <%
 }
  %>
   <%} %>

 

 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl44></td>
  <td colspan=2 class=xl42></td>
  <td class=xl49></td>
  <td class=xl47></td>
  <td colspan=3 class=xl43></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl50>II. PROGRESS PAYMENT</td>
  <td colspan=2 class=xl51>&nbsp;</td>
  <td colspan=2 class=xl50>Openning A/P Amt:</td>
  <td class=xl52 x:num="345345"><span
  style='mso-spacerun:yes'> </span>345,345.00 </td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black'>VOUCHER</td>
  <td colspan=4 rowspan=2 class=xl57 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Description</td>
  <td rowspan=2 class=xl60 style='border-bottom:.5pt solid black;border-top:
  none'>A/P Amt</td>
  <td colspan=2 class=xl61 style='border-right:.5pt solid black;border-left:
  none' x:str="PAYMENT"><span style='mso-spacerun:yes'> </span>PAYMENT<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl63>No</td>
  <td class=xl64>Date</td>
  <td class=xl64>SEQ</td>
  <td class=xl64>Date</td>
  <td class=xl64>&nbsp;Amount</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl69 x:num>1</td>
  <td class=xl70 x:str="12/12/12/"><span
  style='mso-spacerun:yes'> </span>12/12/12/<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl71 x:num>345</td>
  <td colspan=4 class=xl72 style='border-right:.5pt solid black;border-left:
  none' x:str="rgesgsdfggggggggggggggggggggggggggggggggg"><span
  style='mso-spacerun:yes'> </span>rgesgsdfggggggggggggggggggggggggggggggggg<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl75>&nbsp;</td>
  <td class=xl76 align=right x:num="37602">12/12/2002</td>
  <td class=xl75 x:num="456456"><span
  style='mso-spacerun:yes'> </span>456,456.00 </td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=7 class=xl54 style='border-right:.5pt solid black'>Total Payment</td>
  <td class=xl78 x:num="345345"><span
  style='mso-spacerun:yes'> </span>345,345.00 </td>
  <td class=xl79 align=right x:num="37206">11/11/2001</td>
  <td class=xl78 x:num="345345"><span
  style='mso-spacerun:yes'> </span>345,345.00 </td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=7 class=xl54 style='border-right:.5pt solid black'>Total</td>
  <td class=xl78 x:num="3456345"><span
  style='mso-spacerun:yes'> </span>3,456,345.00 </td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78 x:num="23423"><span style='mso-spacerun:yes'> </span>23,423.00
  </td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=7 class=xl54 style='border-right:.5pt solid black'>Remain</td>
  <td class=xl78 x:num="36968468"><span
  style='mso-spacerun:yes'> </span>36,968,468.00 </td>
  <td class=xl78>&nbsp;</td>
  <td class=xl78 x:num="234234"><span
  style='mso-spacerun:yes'> </span>234,234.00 </td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl80></td>
  <td class=xl42></td>
  <td class=xl80></td>
  <td colspan=6 class=xl81>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl35>IV. TOTAL PAYMENT</td>
  <td colspan=2 class=xl43></td>
  <td colspan=2 class=xl35></td>
  <td class=xl82 x:num="456456"><span
  style='mso-spacerun:yes'> </span>456,456.00 </td>
  <td class=xl82></td>
  <td class=xl47 x:num="234"><span style='mso-spacerun:yes'> </span>234.00 </td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=2 class=xl35>V. REMAIN</td>
  <td class=xl35></td>
  <td colspan=2 class=xl43></td>
  <td colspan=2 class=xl35></td>
  <td class=xl82 x:num="36968468"><span
  style='mso-spacerun:yes'> </span>36,968,468.00 </td>
  <td class=xl82></td>
  <td class=xl47 x:num="234234"><span
  style='mso-spacerun:yes'> </span>234,234.00 </td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=2 class=xl83></td>
  <td class=xl84></td>
  <td colspan=4 class=xl83></td>
  <td colspan=3 class=xl82></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
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

 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=2 class=xl43></td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black'></td>
  <td colspan=5 class=xl86 style='border-right:.5pt solid black;border-left:
  none'>ACCOUNTING TEAM</td>
  <td class=xl42></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black'></td>
  <td class=xl64>Date</td>
  <td class=xl64>Checked by</td>
  <td class=xl64>Approved by</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Remark</td>
  <td class=xl43></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td rowspan=3 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none' x:num="36841">11/11/2000</td>
  <td rowspan=3 class=xl88 style='border-bottom:.5pt solid black;border-top:
  none'>nguyen van a</td>
  <td rowspan=3 class=xl88 style='border-bottom:.5pt solid black;border-top:
  none'>nguyen van b</td>
  <td colspan=2 rowspan=3 class=xl89 width=132 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:99pt'>asdfasdfa</td>
  <td class=xl43></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=2 class=xl83></td>
  <td class=xl84></td>
  <td colspan=4 class=xl83></td>
  <td colspan=3 class=xl82></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td colspan=2 class=xl43></td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black'></td>
  <td colspan=5 class=xl86 style='border-right:.5pt solid black;border-left:
  none'>CONTRACT TEAM</td>
  <td class=xl42></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black'></td>
  <td class=xl64>Date</td>
  <td class=xl64>Checked by</td>
  <td class=xl64>Approved by</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Remark</td>
  <td class=xl43></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>

 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td rowspan=3 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none' x:num="37237">12/12/2001</td>
  <td rowspan=3 class=xl88 style='border-bottom:.5pt solid black;border-top:
  none'>lam chi dinh</td>
  <td rowspan=3 class=xl88 style='border-bottom:.5pt solid black;border-top:
  none'>luu duc hoa</td>
  <td colspan=2 rowspan=3 class=xl89 width=132 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:99pt'>ergerge</td>
  <td class=xl43></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl36 style='height:13.5pt'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
