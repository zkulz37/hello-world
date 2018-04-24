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
    int fee, CurrencyRate, total_page, page_seq, row_seq, total, vatamount;
    double TTAMTUSD, TTAMTVND, TTQTY, TTWEIGHT, TTUPRICE, AMTUSD ;
    
    TTAMTUSD   = 0;
    TTAMTVND   = 0;
    TTQTY      = 0;
    TTWEIGHT   = 0;
    TTUPRICE   = 0;
    AMTUSD     = 0;
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
    vatamount = int.Parse(Request["vatamount"]);

    if (etd != "")
        etd = etd.Substring(5, 2).ToString() + "/" + etd.Substring(4, 2).ToString() + "/" + etd.Substring(0, 4).ToString();
    
    if (eta != "")
        eta     = eta.Substring(5, 2).ToString() + "/" + eta.Substring(4, 2).ToString() + "/" + eta.Substring(0, 4).ToString();
    
    if (sPODate != "")
        sPODate = sPODate.Substring(5, 2).ToString() + "/" + sPODate.Substring(4, 2).ToString() + "/" + sPODate.Substring(0, 4).ToString();
	
	if (currency_rate == "")
		currency_rate = "0";
           
%>


<%    
    dt_dtl = ESysLib.TableReadOpenCursor("PROD.SP_SEL_EPBP00130_50_1", poPK);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptFormPAPO_ApprovalImport_files/filelist.xml">
<link rel=Edit-Time-Data href="rptFormPAPO_ApprovalImport_files/editdata.mso">
<link rel=OLE-Object-Data href="rptFormPAPO_ApprovalImport_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Linkto</o:Author>
  <o:LastAuthor>Tony Lee</o:LastAuthor>
  <o:LastPrinted>2007-12-12T09:44:49Z</o:LastPrinted>
  <o:Created>2007-06-18T05:44:28Z</o:Created>
  <o:LastSaved>2007-12-12T09:56:45Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in 0in 0in;
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
	{mso-style-parent:style0;
	mso-number-format:Standard;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl37
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
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
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
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\\-mm\\-yyyy";
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
	
.xl76
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>APPROVAL</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>10</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>33</x:ActiveRow>
       <x:ActiveCol>14</x:ActiveCol>
      </x:Pane>
     </x:Panes>
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
  <x:WindowHeight>5760</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2430</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=APPROVAL!$1:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=847 style='border-collapse:
 collapse;table-layout:fixed;width:638pt'>
 <col class=xl24 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl25 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl25 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=62 span=242 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 width=69 style='height:18.0pt;width:52pt'></td>
  <td class=xl24 width=53 style='width:40pt'></td>
  <td class=xl24 width=67 style='width:50pt'></td>
  <td class=xl24 width=78 style='width:59pt'></td>
  <td class=xl24 width=38 style='width:29pt'></td>
  <td class=xl24 width=42 style='width:32pt'></td>
  <td colspan=2 class=xl31 width=122 style='width:92pt'>Staff</td>
  <td colspan=2 class=xl47 width=137 style='border-left:none;width:103pt'>Job
  Leader</td>
  <td colspan=2 class=xl31 width=128 style='border-left:none;width:96pt'>T.
  Leader</td>
  <td class=xl31 width=113 style='border-left:none;width:85pt'>G.Director</td>
 </tr>
 <tr height=73 style='mso-height-source:userset;height:55.15pt'>
  <td height=73 colspan=6 class=xl24 style='height:55.15pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl46>&nbsp;</td>
  <td colspan=2 class=xl46 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl46 style='border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=6 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan' x:str="Prepared by: ">Prepared
  by:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=sPOStaff%></td>
  <td class=xl74 style='border-top:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=5 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=13 height=24 class=xl40 style='height:18.0pt'>PURCHASING APPROVAL</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl41 width=122 style='height:18.0pt;width:92pt'>Document
  No:</td>
  <td colspan=4 class=xl42 width=225 style='width:170pt'><%=poid%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl24></td>
  <td class=xl28 width=63 style='width:47pt'>Date :</td>
  <td class=xl28 width=113 style='width:85pt' ><%=sPODate%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 height=24 class=xl45 width=267 style='height:18.0pt;width:201pt'>Description
  and Specification:</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl43 style='height:18.0pt'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl44>Rate :</td>
  <td class=xl25 align=right style='mso-number-format:"\#\,\#\#0\.00";' x:num><%= currency_rate%></td>
 </tr>
 <tr class=xl30 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl31 width=69 style='height:30.0pt;width:52pt'>SPEC</td>
  <td colspan=3 class=xl31 width=198 style='border-left:none;width:149pt'>Iteam,
  Desc &amp; Material</td>
  <td class=xl31 width=38 style='border-left:none;width:29pt'>Unit</td>
  <td class=xl31 width=42 style='border-left:none;width:32pt'>Q'ty</td>
  <td class=xl31 width=60 style='border-left:none;width:45pt'>Weight (Kg)</td>
  <td class=xl31 width=62 style='border-left:none;width:47pt'>U.price (VND/kg)</td>
  <td class=xl47 width=69 style='border-left:none;width:52pt'>U.price (VND/pcs)</td>
  <td class=xl47 width=68 style='border-left:none;width:51pt'>Amount (VND)</td>
  <td class=xl47 width=65 style='border-left:none;width:49pt'>Amount (USD)</td>
  <td class=xl31 width=63 style='border-left:none;width:47pt'>MR No.</td>
  <td class=xl31 width=113 style='border-left:none;width:85pt'>Project</td>
 </tr>
 
 <%
     if (dt_dtl.Rows.Count > 0)
     {
         for (int i = 0; i < dt_dtl.Rows.Count; i++)
         {
             row_seq = row_seq + 1;
             if (double.Parse(currency_rate) > 0)
             {
                AMTUSD = double.Parse(dt_dtl.Rows[i][7].ToString()) / double.Parse(currency_rate) ;
             }
                
             TTAMTUSD = TTAMTUSD + AMTUSD;
             TTAMTVND = TTAMTVND + double.Parse(dt_dtl.Rows[i][7].ToString());
             TTQTY = TTQTY + double.Parse(dt_dtl.Rows[i][3].ToString());
             TTWEIGHT = TTWEIGHT + double.Parse(dt_dtl.Rows[i][4].ToString());
             TTUPRICE = TTUPRICE + double.Parse(dt_dtl.Rows[i][5].ToString());
             
 %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl60 style='height:18.0pt;border-top:none'><%=dt_dtl.Rows[i][0].ToString() %></td>
  <td colspan=3 class=xl61 style='border-left:none'><%=dt_dtl.Rows[i][1].ToString() %></td>
  <td class=xl62 style='border-top:none;border-left:none'><%=dt_dtl.Rows[i][2].ToString() %></td>
  <td class=xl63 style='border-top:none;border-left:none'><%=dt_dtl.Rows[i][3].ToString() %></td>
  <td class=xl64 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[i][4].ToString() %></td>
  <td class=xl65 width=62 style='border-top:none;border-left:none;width:47pt;mso-number-format:"\#\,\#\#0"'
  x:num><%=dt_dtl.Rows[i][5].ToString() %></td>
  <td class=xl63 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0"' x:num><%=dt_dtl.Rows[i][6].ToString() %></td>
  <td class=xl63 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[i][7].ToString() %></td>
  <td class=xl66 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=AMTUSD %></td>
  <td class=xl46 style='border-top:none;border-left:none'><%=dt_dtl.Rows[i][9].ToString() %></td>
  <td class=xl76 style='border-top:none;border-left:none'><%=dt_dtl.Rows[i][10].ToString() %></td>
 </tr>
 
 <%
         }
     }

     if (row_seq == dt_dtl.Rows.Count)
     {
         for (int j = 0; j < 17; j++)
         {
 %>
  <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl60 style='height:18.0pt;border-top:none'></td>
  <td colspan=3 class=xl61 style='border-left:none'></td>
  <td class=xl62 style='border-top:none;border-left:none'></td>
  <td class=xl63 style='border-top:none;border-left:none'></td>
  <td class=xl64 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num></td>
  <td class=xl65 width=62 style='border-top:none;border-left:none;width:47pt;mso-number-format:"\#\,\#\#0"'
  x:num></td>
  <td class=xl63 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0"' x:num></td>
  <td class=xl63 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num></td>
  <td class=xl66 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num></td>
  <td class=xl46 style='border-top:none;border-left:none'></td>
  <td class=xl76 style='border-top:none;border-left:none'></td>
 </tr>
 <%
        }
     }
 %>
 
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl31 width=305 style='height:18.0pt;width:230pt'></td>
  <td class=xl67 width=42 style='border-top:none;border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl67 width=60 style='border-top:none;border-left:none;width:45pt'>&nbsp;</td>
  <td class=xl67 width=62 style='border-top:none;border-left:none;width:47pt'>&nbsp;</td>
  <td class=xl67 width=69 style='border-top:none;border-left:none;width:52pt'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 
 
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl31 width=305 style='height:18.0pt;width:230pt'>GRAND
  TOTAL:</td>
  <td class=xl71 width=42 style='border-top:none;border-left:none;width:32pt'><%=TTQTY %></td>
  <td class=xl72 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTWEIGHT %></td>
  <td class=xl33 align=right width=62 style='border-top:none;border-left:none;
  width:47pt' style='mso-number-format:"\#\,\#\#0"' x:num><%=TTUPRICE %></td>
  <td class=xl67 width=69 style='border-top:none;border-left:none;width:52pt'></td>
  <td class=xl70 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTAMTVND %></td>
  <td class=xl34 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTAMTUSD %></td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Total
  in word:</td>
  <%
      if (currency == "VND")
      {
   %>
  <td class=xl24><%=CommondLib.Num2VNText(Math.Round(TTAMTVND, 2).ToString() , currency)%></td>
  <%
      }
         else if (currency == "USD")
      {     
  %>
  <td class=xl24><%=CommondLib.Num2VNText(Math.Round(TTAMTUSD, 2).ToString() , currency)%></td>
  <%
      }   
  %>
  
  
  
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 colspan=2 style='height:18.0pt;mso-ignore:colspan'>2.
  Supplier :</td>
  <td class=xl24 colspan=5 style='mso-ignore:colspan'><%= supplier%></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt'>3. Delivery:</td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'
  x:str="3.1 : Shipment date : ">3.1 : Shipment date :<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl39><%=etd%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'
  x:str="3.2 : Delivery place : ">3.2 : Delivery place :</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'><%= deliver%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt'>4. Parking:</td>
  <td class=xl35 colspan=2 style='mso-ignore:colspan' x:str="4.1. Payment: ">4.1.
  Payment:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl35></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><%=payment%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 style='height:18.0pt'></td>
  <td class=xl35 colspan=2 style='mso-ignore:colspan'>4.2. Packing :</td>
  <td class=xl35></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'><%=packing%></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 style='height:18.0pt'></td>
  <td class=xl35 colspan=3 style='mso-ignore:colspan'>4.3. The Buyer's bank :</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'><%=bank%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl32 style='height:18.0pt' x:str="5. Payment: ">5.
  Payment:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl35 colspan=11 style='mso-ignore:colspan'>( 100% ) total Amount
  shall be paid by Bank transfer within 30 days after receive material and red
  invoice.</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 colspan=6 style='height:18.0pt;mso-ignore:colspan'>6.
  result of Evaluation : Pls. see comparison table.</td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl38 width=122 style='height:18.0pt;width:92pt'>Supplier</td>
  <td colspan=4 rowspan=2 class=xl51 width=225 style='width:170pt'><%= supplier%></td>
  <td colspan=2 rowspan=2 class=xl52 width=122 style='width:92pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl31 width=137 style='width:103pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl31 width=128 style='width:96pt'>&nbsp;</td>
  <td rowspan=2 class=xl54 width=113 style='width:85pt'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl36 width=122 style='height:18.0pt;width:92pt'>Iteam</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl37 width=122 style='height:18.0pt;width:92pt'>&nbsp;</td>
  <td colspan=4 class=xl31 width=225 style='width:170pt'>&nbsp;</td>
  <td colspan=2 class=xl55 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl56 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl56 style='border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 colspan=9 style='height:18.0pt;mso-ignore:colspan'>7.
  Attchment: Quotation, Purchase order, Comparison table &amp; MPR. ( End./. )</td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='text-align:right;border-bottom:none'></td>
 </tr>
 
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=69 style='width:52pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=113 style='width:85pt'></td>
 </tr>
 <![endif]>
</table>
</body>

</html>
