<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";	
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    DataTable dt_dtl;
    string payment, etd, eta, sSQL3, poPK, sPODate, poid, sPOStaff, arrPK, amount, supplier, emp_name, deliver, currency;
    int fee, row_seq = 0, page_seq = 0, total_page, total = 0, row_page_break;
    double AMT, VAT, ttAMT;
    AMT  = 0;
    VAT = 0;
    ttAMT = 0;
	
	row_seq = 0;
    page_seq = 0;
	  
	payment  = Request["payment"];
	fee      = int.Parse(Request["fee"]);
	amount   = Request["amount"] ;
	etd      = Request["etd"] ;
	eta      = Request["eta"] ;
	poPK     = Request["PO_PK"];
	sPODate  = Request["poDate"];
	poid     = Request["poid"];
	sPOStaff = Request["StaffPO"];
    deliver  = Request["Deliver"];
    supplier = Request["supplier"];
    currency = Request["currency"];

    if (etd != "")
        etd = etd.Substring(5, 2).ToString() + "/" + etd.Substring(4, 2).ToString() + "/" + etd.Substring(0, 4).ToString();

    if (eta != "")
        eta = eta.Substring(5, 2).ToString() + "/" + eta.Substring(4, 2).ToString() + "/" + eta.Substring(0, 4).ToString();

    if (sPODate != "")
        sPODate = sPODate.Substring(5, 2).ToString() + "/" + sPODate.Substring(4, 2).ToString() + "/" + sPODate.Substring(0, 4).ToString();
	
%>


<%
    dt_dtl = ESysLib.TableReadOpenCursor("PROD.SP_SEL_EPBP00130_20_1", poPK);

    total = dt_dtl.Rows.Count;
    row_page_break = 30;

    if ((int)(total / row_page_break) > total / row_page_break)
        total_page = (int)(total / row_page_break);
	else
        total_page = (int)(total / row_page_break) + 1;
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_proposalForPurchase_pos_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_proposalForPurchase_pos_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_proposalForPurchase_pos_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>aa</o:Author>
  <o:LastAuthor>administrator</o:LastAuthor>
  <o:LastPrinted>2007-12-17T03:16:29Z</o:LastPrinted>
  <o:Created>2006-09-19T01:46:15Z</o:Created>
  <o:LastSaved>2007-12-17T03:17:59Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in 0in 0in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
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
	font-size:9.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:Standard;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:Standard;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:Standard;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:Standard;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:Standard;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:Standard;
	border-top:.5pt solid black;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl101
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:justify;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:justify;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:justify;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:justify;
	vertical-align:middle;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl109
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:justify;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:justify;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl112
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl113
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl115
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>240</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>3</x:TopRowVisible>
     <x:LeftColumnVisible>3</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
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
  <x:WindowHeight>9000</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1485</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1205 style='border-collapse:
 collapse;table-layout:fixed;width:905pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=162 style='mso-width-source:userset;mso-width-alt:5924;
 width:122pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=55 span=2 style='mso-width-source:userset;mso-width-alt:
 2011;width:41pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl24 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl24 width=50 span=2 style='mso-width-source:userset;mso-width-alt:
 1828;width:38pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <%
     for (int i = 0; i < total; i++)
     {
         if (row_seq == 0 || row_seq > row_page_break)
         {
             page_seq = page_seq + 1;
             row_seq = 1;
 %>
 <tr height=9 style='page-break-before:always;mso-height-source:userset;height:6.75pt'>
  <td height=9 class=xl24 width=32 style='height:6.75pt;width:24pt'></td>
  <td class=xl24 width=162 style='width:122pt'></td>
  <td class=xl24 width=33 style='width:25pt'></td>
  <td class=xl24 width=44 style='width:33pt'></td>
  <td class=xl24 width=76 style='width:57pt'></td>
  <td class=xl24 width=65 style='width:49pt'></td>
  <td class=xl24 width=47 style='width:35pt'></td>
  <td class=xl24 width=52 style='width:39pt'></td>
  <td class=xl24 width=53 style='width:40pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=68 style='width:51pt'></td>
  <td class=xl24 width=51 style='width:38pt'></td>
  <td class=xl24 width=49 style='width:37pt'></td>
  <td class=xl24 width=56 style='width:42pt'></td>
  <td class=xl24 width=50 style='width:38pt'></td>
  <td class=xl24 width=50 style='width:38pt'></td>
  <td class=xl24 width=65 style='width:49pt'></td>
  <td class=xl24 width=47 style='width:35pt'></td>
  <td class=xl24 width=95 style='width:71pt'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=11 rowspan=2 height=54 class=xl84 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:40.5pt'>PROPOSAL FOR PURCHASE</td>
  <td class=xl57 style='border-left:none'>P/O No :</td>
  <td colspan=5 class=xl96 style='border-left:none'><%=poid%></td>
  <td class=xl59 style='border-left:none'>Date :</td>
  <td colspan=2 class=xl94 style='border-right:1.0pt solid black;border-left: none'><%=sPODate%></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl58 style='height:20.25pt;border-top:none;border-left:
  none'>Proposer :</td>
  <td colspan=5 class=xl98 style='border-left:none'><%=sPOStaff%></td>
  <td class=xl59 style='border-top:none;border-left:none'>Page:</td>
  <td colspan=2 class=xl94 style='border-right:1.0pt solid black;border-left:
  none'> <%=page_seq%> / <%=total_page%></td>
 </tr>
 <tr class=xl29 height=17 style='height:12.75pt'>
  <td rowspan=2 height=33 class=xl75 style='height:24.75pt'>No</td>
  <td rowspan=2 class=xl76>Item</td>
  <td rowspan=2 class=xl76>Unit</td>
  <td rowspan=2 class=xl76>Weight</td>
  <td colspan=3 class=xl41>Project Request</td>
  <td colspan=3 class=xl77 style='border-right:.5pt solid black;border-left:
  none'>Poslilama Price For 6 Months</td>
  <td colspan=2 class=xl41 style='border-left:none'>To Be Purchase</td>
  <td colspan=8 class=xl80 style='border-right:1.0pt solid black;border-left:
  none'>Purchase Revised</td>
 </tr>
 <tr class=xl29 height=16 style='height:12.0pt'>
  <td height=16 class=xl41 style='height:12.0pt;border-top:none;border-left:
  none'>PM Reg Qty</td>
  <td class=xl41 style='border-top:none;border-left:none'>PM Stock</td>
  <td class=xl41 style='border-top:none;border-left:none'>PO Bal</td>
  <td class=xl41 style='border-top:none;border-left:none'>AVG</td>
  <td class=xl41 style='border-top:none;border-left:none'>MAX</td>
  <td class=xl41 style='border-top:none;border-left:none'>MIN</td>
  <td class=xl41 style='border-top:none;border-left:none'>PO Qty</td>
  <td class=xl41 style='border-top:none;border-left:none'>Unit Price</td>
  <td class=xl41 style='border-top:none;border-left:none'>PO Qty</td>
  <td class=xl41 style='border-top:none;border-left:none'>U Price</td>
  <td class=xl41 style='border-top:none;border-left:none'>Amount</td>
  <td class=xl41 style='border-top:none;border-left:none'>VAT</td>
  <td class=xl41 style='border-top:none;border-left:none'>CO Fee</td>
  <td class=xl42 style='border-top:none;border-left:none'>Total AMT</td>
  <td class=xl41 style='border-top:none'>MR No.</td>
  <td class=xl50 style='border-top:none;border-left:none'>Project</td>
 </tr>
 <%
         }         
 %>
 
 <% 
     AMT = AMT + double.Parse(dt_dtl.Rows[0][14].ToString());
     VAT = VAT + double.Parse(dt_dtl.Rows[0][15].ToString());
    
 %>
 
 <tr class=xl30 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl51 style='height:15.95pt' x:num><%=row_seq%></td>
  <td class=xl31><%=dt_dtl.Rows[0][1].ToString() %></td>
  <td class=xl31><%=dt_dtl.Rows[0][2].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0"' x:num><%=dt_dtl.Rows[0][3].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0"' x:num><%=dt_dtl.Rows[0][4].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0"' x:num><%=dt_dtl.Rows[0][5].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0"' x:num><%=dt_dtl.Rows[0][6].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0"' x:num><%=dt_dtl.Rows[0][7].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0"' x:num><%=dt_dtl.Rows[0][8].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0"' x:num><%=dt_dtl.Rows[0][9].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[0][10].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[0][11].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[0][12].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[0][13].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[0][14].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[0][15].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[0][16].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[0][17].ToString() %></td>
  <td class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[0][18].ToString() %></td>
  <td class=xl52 style='border-top:none;border-left:none'><%=dt_dtl.Rows[0][19].ToString() %></td>
 </tr>
    
    <%
        if (i == total-1) 
        {
            int j = 0;
            for (j = row_seq + 1; j <= row_page_break; j++)
            {
    %>
 <tr class=xl30 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl51 style='height:15.95pt' x:num><%=j%></td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl45 style='border-top:none'>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
            }
        }

        row_seq = row_seq + 1;

        if (row_seq > row_page_break || i == total - 1)
        {
 %>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl25 style='height:12.0pt'>&nbsp;</td>
  <td colspan=17 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl46 style='border-top:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl35 style='height:12.0pt'>&nbsp;</td>
  <td class=xl36>Supplier : </td>
  <td colspan=4 class=xl67 style='border-right:.5pt solid black;border-left:none'><%=supplier%></td>
  <td colspan=2 class=xl60 style='border-left:none'>Amount :</td>
  <td colspan=2 class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=AMT%></td>
  <td class=xl37>Delivery :</td>
  <td colspan=3 class=xl68 style='border-right:.5pt solid black'><%=deliver%></td>
  <td colspan=2 class=xl60 style='border-left:none'>Transport Fee :</td>
  <td colspan=2 class=xl73 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num>???</td>
  <td class=xl46 style='border-top:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl38 style='height:12.0pt'>&nbsp;</td>
  <td class=xl39>Payment Term:</td>
  <td colspan=4 class=xl67 style='border-right:.5pt solid black;border-left:none'><%=payment%></td>
  <td colspan=2 class=xl60 style='border-left:none'>VAT :</td>
  <td colspan=2 class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=VAT%></td>
  <td class=xl40>BIA :</td>
  <td colspan=3 class=xl68 style='border-right:.5pt solid black'>???</td>
  <td colspan=2 class=xl60 style='border-left:none'>Total Cost :</td>
  <td colspan=2 class=xl70 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num>???</td>
  <td class=xl46 style='border-top:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl38 style='height:12.0pt'>&nbsp;</td>
  <td class=xl39 x:str="Currency: ">Currency:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl67 style='border-right:.5pt solid black;border-left:
  none'><%=currency%></td>
  <td colspan=2 class=xl60 style='border-left:none'>Total Amount :</td>
  <td colspan=2 class=xl45 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=AMT + VAT%></td>
  <td class=xl40>ETD :</td>
  <td colspan=3 class=xl61 style='border-right:.5pt solid black'><%=etd%></td>
  <td colspan=2 class=xl60 style='border-left:none'>ETA :</td>
  <td colspan=2 class=xl61><%=eta%></td>
  <td class=xl46 style='border-top:none'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='height:24pt'>
  <td height=25 class=xl25 style='height:24pt'>&nbsp;</td>
  <td colspan=17 class=xl24 style='mso-ignore:colspan;height:24pt'></td>
  <td class=xl46 style='border-top:none;height:24pt'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none;height:24pt'>&nbsp;</td>
 </tr>
  <tr height=25 style='height:24pt'>
  <td height=25 class=xl25 style='height:24pt'>&nbsp;</td>
  <td colspan=17 class=xl24 style='mso-ignore:colspan;height:24pt'></td>
  <td class=xl46 style='border-top:none;height:24pt'>&nbsp;</td>
  <td class=xl53 style='border-top:none;border-left:none;height:24pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 rowspan=6 height=99 class=xl102 width=347 style='border-right:
  .5pt solid black;border-bottom:1.0pt solid black;height:74.25pt;width:261pt'>We
  would like to get your approval for purchasing with the about mention price</td>
  <td colspan=3 class=xl100 style='border-right:.5pt solid black'>Prepared</td>
  <td colspan=3 class=xl113 style='border-right:.5pt solid black;border-left:
  none'>Checked</td>
  <td colspan=3 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>P/M</td>
  <td colspan=3 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>Reviewed</td>
  <td colspan=3 class=xl41 style='border-right:1.0pt solid black;border-left:
  none'>Approval</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl48 style='height:12.0pt;border-top:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none'>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl48 style='border-top:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none'>&nbsp;</td>
  <td class=xl49 style='border-top:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none'>&nbsp;</td>
  <td class=xl48 style='border-top:none'>&nbsp;</td>
  <td class=xl54 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=2 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl55>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=2 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl55>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl27 style='height:12.0pt'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=3 height=18 class=xl101 style='border-right:.5pt solid black;
  height:13.5pt'>/</td>
  <td colspan=3 class=xl64 style='border-right:.5pt solid black;border-left:
  none'>/</td>
  <td colspan=3 class=xl64 style='border-right:.5pt solid black;border-left:
  none'>/</td>
  <td colspan=3 class=xl64 style='border-right:.5pt solid black;border-left:
  none'>/</td>
  <td colspan=3 class=xl81 style='border-right:1.0pt solid black;border-left:
  none'>/</td>
 </tr>
 <%
     }
     }    
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=162 style='width:122pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=95 style='width:71pt'></td>
 </tr>
 <![endif]>
</table>
</body>

</html>
