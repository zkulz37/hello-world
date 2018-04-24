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
	DataTable dt_mst, dt_dtl;
    string payment, etd, eta, poPK, sPODate, poid, sPOStaff, arrPK, amount, supplier, emp_name, deliver, currency, packing, bank, currency_rate, TotalInWord = "0";
    int fee, CurrencyRate, total_page, page_seq, row_seq, total;
    double TTAMTUSD, TTAMTVND, TTQTY, TTWEIGHT, TTUPRICE, AMTUSD, VATAMTUSD, VATAMTVND, GRDAMTUSD, GRDAMTVND, vatamount, AMTVND, UPRICE;

	UPRICE	   = 0;
    AMTUSD     = 0;
    
    TTAMTUSD   = 0;
    TTAMTVND   = 0;
    VATAMTUSD  = 0;
    VATAMTVND  = 0;
    GRDAMTUSD  = 0;
    GRDAMTVND  = 0;
    
    
    TTQTY      = 0;
    TTWEIGHT   = 0;
    TTUPRICE   = 0;
    
    total_page = 0;
    total      = 0;
    page_seq   = 0;
    row_seq    = 0;
    
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
    currency_rate = Request["CurrencyRate"];
    packing = Request["packing"];
	bank    = Request["Bank"];
    vatamount = double.Parse(Request["vatamount"]);

    if (sPODate != "")
        sPODate = sPODate.Substring(6, 2).ToString() + "/" + sPODate.Substring(4, 2).ToString() + "/" + sPODate.Substring(0, 4).ToString();
	
	if (currency_rate == "")
		currency_rate = "0";
           
%>


<%    
    dt_mst = ESysLib.TableReadOpenCursor("PROD.SP_SEL_EPBP00130", poPK);    
    dt_dtl = ESysLib.TableReadOpenCursor("PROD.SP_SEL_EPBP00130_60_1", poPK);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptOrderDomestic_files/filelist.xml">
<link rel=Edit-Time-Data href="rptOrderDomestic_files/editdata.mso">
<link rel=OLE-Object-Data href="rptOrderDomestic_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Linkto</o:Author>
  <o:LastAuthor>p2n</o:LastAuthor>
  <o:LastPrinted>2007-12-10T08:01:05Z</o:LastPrinted>
  <o:Created>2007-06-18T05:44:28Z</o:Created>
  <o:LastSaved>2007-12-10T08:23:40Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:DownloadComponents/>
  <o:LocationOfComponents HRef="file:///\\10.0.0.164\Data%20(D)\Software\MS%20Office%202k3\Office%202003\"/>
 </o:OfficeDocumentSettings>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in 0in 0in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-horizontal-page-align:center;}
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:1.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:Fixed;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl62
	{mso-style-parent:style16;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;}
.xl64
	{mso-style-parent:style16;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	vertical-align:middle;
	white-space:normal;}
.xl68
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:left;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	font-size:21.0pt;
	font-weight:700;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl87
	{mso-style-parent:style0;
	vertical-align:middle;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>ORDER_Domestic</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>15</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
       <x:RangeSelection>$G$17:$K$17</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:TopRowVisible>18</x:TopRowVisible>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8775</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1560</x:WindowTopY>
  <x:TabRatio>846</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=857 style='border-collapse:
 collapse;table-layout:fixed;width:645pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=82 span=4 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=62 span=245 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <tr height=27 style='height:20.25pt'>
  <td height=27 class=xl26 colspan=3 width=235 style='height:20.25pt;
  mso-ignore:colspan;width:177pt'>POSCO E &amp; C - VIETNAM</td>
  <td class=xl26 width=111 style='width:83pt'></td>
  <td class=xl24 width=53 style='width:40pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl25 width=75 style='width:56pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 colspan=4 style='height:15.75pt;mso-ignore:colspan'>Nhon
  Trach Zone Dong Nai Pro, Viet Nam</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Tel:
  +84(613)560-659/8</td>
  <td class=xl27></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl27 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Fax:
  +84(613)560-852</td>
  <td class=xl27></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
 <%
        if (dt_mst.Rows.Count > 0)
        {
    %>
  <td height=21 class=xl30 colspan=4 style='height:15.75pt;mso-ignore:colspan'>Contact
  Name: <%=dt_mst.Rows[0][3].ToString()%></td>
 <% }else { %>
     <td height=21 class=xl30 colspan=4 style='height:15.75pt;mso-ignore:colspan'>Contact
  Name: <%=sPOStaff %></td>
 <%} %>
  <td class=xl30></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=36 style='height:27.0pt'>
  <td colspan=11 height=36 class=xl77 style='height:27.0pt'>PURCHASE ORDER</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl79 style='height:15.75pt'>Vendor:</td>
  <%
        if (dt_mst.Rows.Count > 0)
        {
    %>
  <td colspan=5 rowspan=2 class=xl78 width=388 style='width:291pt'><%=dt_mst.Rows[0][4].ToString()%></td>
  <% }else { %>
      <td colspan=5 rowspan=2 class=xl78 width=388 style='width:291pt'><%=supplier%></td>
  <%} %>
  <td colspan=3 class=xl79 style='border-left:none'>PO No.</td>
  <td colspan=2 class=xl79 style='border-left:none'>PO Date</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl81 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl82 style='border-left:none'><%=poid%></td>
  <td colspan=2 class=xl83 style='border-left:none'><%=sPODate%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=11 height=17 class=xl24 style='height:12.75pt'
  x:str="We are pleased to place an order for the following described commodity ( ies ) on the term and conditions specified hereunder ">We
  are pleased to place an order for the following described commodity ( ies )
  on the term and conditions specified hereunder<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=10 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl32 colspan=4 style='height:17.25pt;mso-ignore:colspan'>1.
  Description and specification : Origine</td>
  <td class=xl32></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=9 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl35>Rate :</td>
  <td class=xl36 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%= currency_rate%></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=10 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.95pt'>
  <td height=37 class=xl79 style='height:27.95pt'>Project:</td>
    <%
        if (dt_mst.Rows.Count > 0)
        {
            GRDAMTVND = double.Parse(dt_mst.Rows[0]["TOTAL_AMT"].ToString());
            TTAMTVND = double.Parse(dt_mst.Rows[0]["PO_AMT"].ToString());
            if (double.Parse(currency_rate) > 0)
            {
                GRDAMTUSD = GRDAMTVND / double.Parse(currency_rate);
                TTAMTUSD = TTAMTVND/ double.Parse(currency_rate);
            }
            else
            {
                GRDAMTUSD = 0;
                TTAMTUSD = 0;
            }
    %>
  <td colspan=10 class=xl87 width=280 style='border-right:.5pt solid black;
  border-left:none;width:210pt'><%=dt_mst.Rows[0][0].ToString()%> - <%=dt_mst.Rows[0][1].ToString()%></td>
 </tr>
    <%
        }
        else
        {
    %>
    <td colspan=10 class=xl87 width=280 style='border-right:.5pt solid black;
  border-left:none;width:210pt'></td>
  <%} %>
 <tr height=36 style='mso-height-source:userset;height:27.6pt'>
  <td height=36 class=xl37 width=66 style='height:27.6pt;border-top:none;
  width:50pt'>No.</td>
  <td colspan=3 class=xl69 width=280 style='border-right:.5pt solid black;
  border-left:none;width:210pt'>Iteam, Desc &amp; Material</td>
  <td class=xl38 width=53 style='border-top:none;width:40pt'>Unit</td>
  <td class=xl38 width=55 style='border-top:none;width:41pt'>Q'ty</td>
  <td class=xl38 width=82 style='border-top:none;width:62pt'>Weight (Kg)</td>
  <td class=xl39 width=82 style='border-top:none;width:62pt'>U.price (VND/kg)</td>
  <td class=xl38 width=82 style='border-top:none;width:62pt'>U.Price (VND/pcs)</td>
  <td class=xl39 width=82 style='border-top:none;width:62pt'>Amount (VND)</td>
  <td class=xl40 width=75 style='border-top:none;width:56pt'>Amount (USD)</td>
 </tr>
 
 <%
		if (dt_dtl.Rows.Count > 0)
		{
			for (int i = 0; i < dt_dtl.Rows.Count; i++)
			{
			 row_seq++;

             if (double.Parse(currency_rate) > 0)
             {
                 AMTUSD = double.Parse(dt_dtl.Rows[i][7].ToString()) / double.Parse(currency_rate);                
             }
             else
             {
                 AMTUSD = 0;
                 
             }
			 
			
			 TTQTY    = TTQTY + double.Parse(dt_dtl.Rows[i][3].ToString());
			 TTWEIGHT = TTWEIGHT + double.Parse(dt_dtl.Rows[i][4].ToString());
			
			 if (double.Parse(dt_dtl.Rows[i][4].ToString()) > 0)
				 UPRICE   = double.Parse(dt_dtl.Rows[i][7].ToString())/double.Parse(dt_dtl.Rows[i][4].ToString());
			 else
				 UPRICE   = 0;

			 TTUPRICE = TTUPRICE + UPRICE;
             
 %>
  <tr class=xl33 height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl41 width=66 style='height:16.9pt;width:50pt'><%=i+1%></td>
  <td colspan=3 class=xl74 style='border-right:.5pt solid black;border-left:none'><%=dt_dtl.Rows[i][1].ToString()%></td>
  <td class=xl42><%=dt_dtl.Rows[i][2].ToString()%></td>
  <td class=xl43 style='mso-number-format:"\#\,\#\#0";' x:num><%=dt_dtl.Rows[i][3].ToString()%></td>
  <td class=xl44 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=dt_dtl.Rows[i][4].ToString()%></td>
  <td class=xl45 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=UPRICE%></td>
  <td class=xl45 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=dt_dtl.Rows[i][6].ToString()%></td>
  <td class=xl46 style='mso-number-format:"\#\,\#\#0";' x:num><%=dt_dtl.Rows[i][7].ToString()%></td>
  <td class=xl44 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=AMTUSD%></td>
 </tr>		
 <%
			}
		}
		if (row_seq == dt_dtl.Rows.Count )
		{
			for(int j = 0; j < 9; j++)
			{
 %>
			 <tr class=xl33 height=22 style='mso-height-source:userset;height:16.9pt'>
			  <td height=22 class=xl41 width=66 style='height:16.9pt;width:50pt'>&nbsp;</td>
			  <td colspan=3 class=xl74 style='border-right:.5pt solid black;border-left:
			  none'>&nbsp;</td>
			  <td class=xl47>&nbsp;</td>
			  <td class=xl43>&nbsp;</td>
			  <td class=xl48>&nbsp;</td>
			  <td class=xl48>&nbsp;</td>
			  <td class=xl49>&nbsp;</td>
			  <td class=xl50>&nbsp;</td>
			  <td class=xl51>&nbsp;</td>
			 </tr>	
 <%
			}
		}	
 %>

 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td colspan=4 height=22 class=xl69 width=346 style='border-right:.5pt solid black;
  height:16.9pt;width:260pt'>TOTAL :</td>
  <td class=xl53 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57 style='mso-number-format:"\#\,\#\#0"' x:num><%=TTAMTVND%></td>
  <td class=xl58 style='mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTAMTUSD%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td colspan=4 height=22 class=xl69 width=346 style='border-right:.5pt solid black;
  height:16.9pt;width:260pt'>VAT </td>
  <td class=xl53 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57 style='mso-number-format:"\#\,\#\#0";' x:num><%=dt_mst.Rows[0]["VAT_AMT"].ToString()%></td>
  <% if (double.Parse(currency_rate) > 0)
     { %>
  <td class=xl58 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=double.Parse(dt_mst.Rows[0]["VAT_AMT"].ToString()) / double.Parse(currency_rate)%></td>	    
  <% }
     else
     { %>
      <td class=xl58 style='mso-number-format:"\#\,\#\#0\.00";' x:num></td>	    
  <% } %>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td colspan=4 height=22 class=xl69 width=346 style='border-right:.5pt solid black;
  height:16.9pt;width:260pt'>GRAND TOTAL:</td>
  <td class=xl53 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl59 style='mso-number-format:"\#\,\#\#0";' x:num><%=TTQTY%></td>
  <td class=xl59 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=TTWEIGHT %></td>
  <td class=xl59 style='mso-number-format:"\#\,\#\#0\.00";' x:num></td>
  
  <td class=xl56>&nbsp;</td>
  <td class=xl59 style='mso-number-format:"\#\,\#\#0";' x:num><%=GRDAMTVND%></td>
  <td class=xl59 style='mso-number-format:"\#\,\#\#0\.00";' x:num><%=GRDAMTUSD%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=2 height=36 class=xl72 width=156 style='height:27.0pt;width:118pt'>2.
  Total order amount:</td>
 <td colspan=2 class=xl73 style='mso-number-format:"\#\,\#\#0";' x:num><%=GRDAMTVND%></td>
 <td class=xl32>VND</td>
  
  <td class=xl61></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl24 style='height:30.75pt'></td>
  <td class=xl33>Total in word:</td>
  <td class=xl33></td>
  <td colspan=8 class=xl67 width=622 style='width:468pt'><%=CommondLib.Num2VNText(Math.Round(GRDAMTVND, 2).ToString(), currency)%></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl32 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str="3. Delivery: ">3. Delivery:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl24 x:str="3.1 : Shipment date : ">3.1 : Shipment date
  :<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl68><%=eta%></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl62></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24>3.2 : Delivery place :</td>
  <td colspan=2 class=xl63 style='mso-ignore:colspan'><%= deliver%></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl32 colspan=2 style='height:15.75pt;mso-ignore:colspan'>4.
  Term and Conditions:</td>
  <td class=xl32></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl63 colspan=2 style='height:15.75pt;mso-ignore:colspan'
  x:str="4.1. Payment: ">4.1. Payment:<span style='mso-spacerun:yes'> </span></td>
  <td colspan=8 style='mso-ignore:colspan'>100% total amount shall be paid by
  T/T after receipt of all orgin shipping document &amp; material 30 days</td>
  <td class=xl64></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl63 colspan=2 style='height:15.75pt;mso-ignore:colspan'>4.2.
  Packing :</td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Attached Mill Certification (Giao hàng kèm theo chứng chỉ chất lượng)</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl62></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl63 colspan=2 style='height:15.75pt;mso-ignore:colspan'>4.3.
  Others :</td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>If Cargo's quality is not good, the buyer will return to suppliers , all of return or changing fee the sellers have to pay.
  </td>
 <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl62></td>  
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl63 colspan=2 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>0.1% of total PO amount per day shall be calculated as delay penalty from July 02, 2011
  </td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl62></td> 
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl63 colspan=2 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>and  10% penalty of total PO value will be set-off from seller’s account for any cancellation or non-performance to any terms 
  </td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl62></td> 
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl63 colspan=2 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>of the order from  the confirming.
  </td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl62></td> 
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl32 style='height:15.75pt'></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl65 style='height:15.75pt'>Confirm and
  accepted by Supplier</td>
  <td class=xl32></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl65>Issued by Posco E & C - Viet Nam</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 colspan=10 class=xl24 style='height:16.9pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 colspan=10 class=xl24 style='height:16.9pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 colspan=10 class=xl24 style='height:16.9pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.9pt'>
  <td height=22 class=xl34 style='height:16.9pt'>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=7 class=xl24 style='height:20.25pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl66>Mr. Byeon Ki Bong</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl65>Procurement Acting Group Leader</td>
 </tr>
  <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=7 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl65>For Mr. Oh Young Whan - General Director</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=66 style='width:50pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=75 style='width:56pt'></td>
 </tr>
 <![endif]>
</table>
</body>

</html>
