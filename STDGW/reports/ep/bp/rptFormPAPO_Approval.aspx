<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser("prod");%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
	DataTable dt_mst, dt_dtl;
    string payment, etd, eta, poPK, sPODate, poid, sPOStaff, arrPK, amount, supplier, emp_name, deliver, currency, packing, bank, currency_rate, TotalInWord = "0";
    int fee, CurrencyRate, total_page, page_seq, row_seq, total;
    double TTAMTUSD, TTAMTVND, TTQTY, TTWEIGHT, TTUPRICE, AMTUSD, vatamount;
    
    TTAMTUSD   = 0;
    TTAMTVND   = 0;
    TTQTY      = 0;
    TTWEIGHT   = 0;
    TTUPRICE   = 0;
    AMTUSD     = 0;
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
    dt_dtl = ESysLib.TableReadOpenCursor("PROD.SP_SEL_EPBP00130_40_1", poPK);

    total = 1;
    
    if (total / 20 > total / 20)
        total_page = total / 20;
    else
        total_page = total / 20 + 1;
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptFormPAPO_Approval_files/filelist.xml">
<link rel=Edit-Time-Data href="rptFormPAPO_Approval_files/editdata.mso">
<link rel=OLE-Object-Data href="rptFormPAPO_Approval_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Linkto</o:Author>
  <o:LastAuthor>Tony Lee</o:LastAuthor>
  <o:LastPrinted>2007-12-13T10:28:12Z</o:LastPrinted>
  <o:Created>2007-06-18T05:44:28Z</o:Created>
  <o:LastSaved>2007-12-13T10:41:06Z</o:LastSaved>
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;}
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl41
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
.xl42
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl54
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
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl56
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
.xl57
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl65
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
.xl66
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
.xl67
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
.xl68
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
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
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    
   <x:PageBreaks>
     <x:RowBreaks>
     <% 
        int i = 0;
        for (i = 0; i < total_page - 1; i ++)
        {
     %>
          <x:RowBreak>
           <x:Row><%=51 * i%></x:Row>
          </x:RowBreak>
      <% 
        }
      %>
     </x:RowBreaks>
    </x:PageBreaks>
    
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
  <x:WindowHeight>12180</x:WindowHeight>
  <x:WindowWidth>21000</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2430</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
  <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=APPROVAL!$1:$7</x:Formula>
 </x:ExcelName>

</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=985 style='border-collapse:
 collapse;table-layout:fixed;width:741pt'>
 <col class=xl24 width=69 style='mso-width-source:userset;mso-width-alt:2000;
 width:52pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:2000;
 width:32pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=154 style='mso-width-source:userset;mso-width-alt:5632;
 width:116pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=62 span=242 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
  
 <%
     for (i = 1; i < total + 1; i++)
     {
         if (row_seq == 0 || row_seq > 28)
         {
             page_seq = page_seq + 1;
             row_seq = 1;
 %>
 
 <tr height=24 style='page-break-before:always;mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 width=69 style='height:18.0pt;width:52pt'></td>
  <td class=xl24 width=53 style='width:40pt'></td>
  <td class=xl24 width=56 style='width:42pt'></td>
  <td class=xl24 width=78 style='width:59pt'></td>
  <td class=xl24 width=38 style='width:29pt'></td>
  <td class=xl24 width=42 style='width:32pt'></td>
  <td colspan=2 class=xl31 width=122 style='width:92pt'>Staff</td>
  <td colspan=2 class=xl50 width=155 style='border-left:none;width:116pt'>Job
  Leader</td>
  <td colspan=2 class=xl31 width=143 style='border-left:none;width:107pt'>T.
  Leader</td>
  <td class=xl31 width=154 style='border-left:none;width:116pt'>G.Director</td>
  <td class=xl24 width=75 style='width:56pt'></td>
 </tr>
 <tr height=73 style='mso-height-source:userset;height:55.15pt'>
  <td height=73 colspan=6 class=xl24 style='height:55.15pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl51>&nbsp;</td>
  <td colspan=2 class=xl51 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=6 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl27></td>
  <td class=xl25></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan' x:str="Prepared by: ">Prepared  by:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'><%=sPOStaff%></td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=13 height=24 class=xl47 style='height:18.0pt'>PURCHASING APPROVAL</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl48 width=122 style='height:18.0pt;width:92pt'>Document
  No:</td>
  <td colspan=4 class=xl49 width=214 style='width:162pt'><%=poid%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td class=xl24></td>
  <td class=xl28 width=71 style='width:53pt'>Date :</td>
  <td class=xl72 width=154 style='width:116pt'><%=sPODate%></td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=4 height=24 class=xl70 style='height:18.0pt'>Description and
  Specification:</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl29>Rate:</td>
  <td class=xl25 align=right style='mso-number-format:"\#\,\#\#0\.00"' x:num><%= currency_rate%></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl30 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl31 width=69 style='height:30.0pt;border-top:none;
  width:52pt'>SPEC</td>
  <td colspan=3 class=xl31 width=187 style='border-left:none;width:141pt'>Iteam,
  Desc &amp; Material</td>
  <td class=xl31 width=38 style='border-left:none;width:29pt'>Unit</td>
  <td class=xl31 width=42 style='border-left:none;width:32pt'>Q'ty</td>
  <td class=xl31 width=60 style='border-left:none;width:45pt'>Weight (Kg)</td>
  <td class=xl31 width=62 style='border-left:none;width:47pt'>U.price (VND/kg)</td>
  <td class=xl50 width=80 style='border-left:none;width:60pt'>U.price (VND/pcs)</td>
  <td class=xl50 width=75 style='border-left:none;width:56pt'>Amount (VND)</td>
  <td class=xl50 width=72 style='border-left:none;width:54pt'>Amount (USD)</td>
  <td class=xl50 width=71 style='border-left:none;width:53pt'>MR No.</td>
  <td class=xl50 width=154 style='border-left:none;width:116pt'>Project</td>
  <td class=xl30></td>
 </tr>
    <% } %>
    <% 
     if (dt_dtl.Rows.Count > 0)
     {
         for (int j = 0; j < dt_dtl.Rows.Count; j++)
         {
             if (double.Parse(currency_rate) > 0)
             {
                 AMTUSD = double.Parse(dt_dtl.Rows[j][7].ToString()) / double.Parse(currency_rate);
             }
             
             TTQTY    = TTQTY + double.Parse(dt_dtl.Rows[j][3].ToString());
             TTWEIGHT = TTWEIGHT + double.Parse(dt_dtl.Rows[j][4].ToString());
             TTUPRICE = TTUPRICE + double.Parse(dt_dtl.Rows[j][5].ToString());

             TTAMTVND = TTAMTVND + double.Parse(dt_dtl.Rows[j][7].ToString());
             TTAMTUSD = TTAMTUSD + AMTUSD;
 %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl63 style='height:18.0pt;border-top:none'><%=dt_dtl.Rows[j][0].ToString()%></td>
  <td colspan=3 class=xl64 style='border-left:none'><%=dt_dtl.Rows[j][1].ToString()%></td>
  <td class=xl65 style='border-top:none;border-left:none'><%=dt_dtl.Rows[j][2].ToString()%></td>
  <td class=xl66 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0"' x:num><%=dt_dtl.Rows[j][3].ToString()%></td>
  <td class=xl67 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[j][4].ToString()%></td>
  <td class=xl68 width=62 style='border-top:none;border-left:none;width:47pt;mso-number-format:"\#\,\#\#0"'
  x:num><%=dt_dtl.Rows[j][5].ToString()%></td>
  <td class=xl66 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0"' x:num><%=dt_dtl.Rows[j][6].ToString()%></td>
  <td class=xl66 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=dt_dtl.Rows[j][7].ToString()%></td>
  <td class=xl69 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=AMTUSD%></td>
  <td class=xl51 style='border-top:none;border-left:none'><%=dt_dtl.Rows[j][9].ToString()%></td>
  <td class=xl51 style='border-top:none;border-left:none'><%=dt_dtl.Rows[j][10].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <%
             row_seq = row_seq + 1;
         }
        }   
 %>
 <%
        if (i == total) 
        {
            int j = 0;
            for (j = 0; j < 20; j++)
            {
    %>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl63 style='height:18.0pt;border-top:none'></td>
  <td colspan=3 class=xl64 style='border-left:none'></td>
  <td class=xl65 style='border-top:none;border-left:none'></td>
  <td class=xl66 style='border-top:none;border-left:none'></td>
  <td class=xl67 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num></td>
  <td class=xl68 width=62 style='border-top:none;border-left:none;width:47pt;mso-number-format:"\#\,\#\#0"'
  x:num></td>
  <td class=xl66 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0"' x:num></td>
  <td class=xl66 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0"' x:num></td>
  <td class=xl69 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num></td>
  <td class=xl51 style='border-top:none;border-left:none'></td>
  <td class=xl51 style='border-top:none;border-left:none'></td>
  <td class=xl24></td>
 </tr>
 <%
            }
        }

        row_seq = row_seq + 1;
 %>
 
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl31 width=294 style='height:18.0pt;width:222pt'>SUB
  TOTAL:</td>
  <td class=xl52 width=42 style='border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl40 width=60 style='border-left:none;width:45pt'>&nbsp;</td>
  <td class=xl40 width=62 style='border-left:none;width:47pt'>&nbsp;</td>
  <td class=xl53 width=80 style='border-left:none;width:60pt'>&nbsp;</td>
  <td class=xl54 style='border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTAMTVND %></td>
  <td class=xl41 style='border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTAMTUSD %></td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl31 width=294 style='height:18.0pt;width:222pt'>VAT <%=vatamount %>% :</td>
  <td class=xl52 width=42 style='border-top:none;border-left:none;width:32pt'>&nbsp;</td>
  <td class=xl52 width=60 style='border-top:none;border-left:none;width:45pt'>&nbsp;</td>
  <td class=xl52 width=62 style='border-top:none;border-left:none;width:47pt'>&nbsp;</td>
  <td class=xl52 width=80 style='border-top:none;border-left:none;width:60pt'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTAMTVND * Math.Round((vatamount / 100),2)%></td>
  <td class=xl41 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTAMTUSD * Math.Round((vatamount / 100),2)%></td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 height=24 class=xl31 width=294 style='height:18.0pt;width:222pt'>GRAND
  TOTAL:</td>
  <td class=xl55 width=42 style='border-top:none;border-left:none;width:32pt;;mso-number-format:"\#\,\#\#0' x:num><%=TTQTY %></td>
  <td class=xl56 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTWEIGHT %></td>
  <td class=xl40 align=right width=62 style='border-top:none;border-left:none;
  width:47pt;mso-number-format:"\#\,\#\#0"' x:num><%=TTUPRICE %></td>
  <td class=xl52 width=80 style='border-top:none;border-left:none;width:60pt'>&nbsp;</td>
  <td class=xl54 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTAMTVND +(TTAMTVND * Math.Round((vatamount / 100),2))%></td>
  <td class=xl41 style='border-top:none;border-left:none;mso-number-format:"\#\,\#\#0\.00"' x:num><%=TTAMTUSD +(TTAMTUSD * Math.Round((vatamount / 100),2))%></td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Total
  in word:</td>
  <%
      if (currency == "VND")
      {
   %>
  <td class=xl24 colspan=5 style='mso-ignore:colspan'><%=CommondLib.Num2VNText(Math.Round(TTAMTVND,2).ToString(), currency)%></td>
  <%
      }
         else if (currency == "USD")
      {     
  %>
  <td class=xl24 colspan=5 style='mso-ignore:colspan'><%=CommondLib.Num2VNText(Math.Round(TTAMTUSD,2).ToString(), currency)%></td>
  <%
      }   
  %>
  
  
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 colspan=2 style='height:18.0pt;mso-ignore:colspan'>2.
  Supplier :</td>
  <td class=xl24 colspan=5 style='mso-ignore:colspan'><%=supplier %></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl33 style='height:18.0pt'>3. Delivery:</td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'
  x:str="3.1 : Shipment date : ">3.1 : Shipment date :<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl43><%=etd%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'
  x:str="3.2 : Delivery place : ">3.2 : Delivery place :<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'><%=deliver %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl33 style='height:18.0pt'>4. Parking:</td>
  <td class=xl42 colspan=2 style='mso-ignore:colspan' x:str="4.1. Payment: ">4.1.
  Payment:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl42></td>
  <td class=xl25><%=payment %></td>
  <td class=xl25></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 style='height:18.0pt'></td>
  <td class=xl42 colspan=2 style='mso-ignore:colspan'>4.2. Packing :</td>
  <td class=xl42></td>
  <td class=xl24 colspan=3 style='mso-ignore:colspan'><%=packing %></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 style='height:18.0pt'></td>
  <td class=xl42 colspan=3 style='mso-ignore:colspan'>4.3. The Buyer's bank :</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'><%=bank %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl33 style='height:18.0pt' x:str="5. Payment: ">5.
  Payment:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl42 colspan=10 style='mso-ignore:colspan'>( 100% ) total Amount
  shall be paid by Bank transfer within 30 days after receive material and red
  invoice.</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 colspan=6 style='height:18.0pt;mso-ignore:colspan'>6.
  Result of Evaluation : Pls. see comparison table.</td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=3 height=24 class=xl31 width=178 style='height:18.0pt;width:134pt'>Supplier</td>
  <td colspan=3 rowspan=2 class=xl57 width=158 style='width:120pt'><%=supplier %></td>
  <td colspan=2 rowspan=2 class=xl31 width=122 style='width:92pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl31 width=155 style='width:116pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl58 width=143 style='width:107pt'>&nbsp;</td>
  <td rowspan=2 class=xl51>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=3 height=24 class=xl31 width=178 style='height:18.0pt;width:134pt'>Iteam</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=3 height=24 class=xl31 width=178 style='height:18.0pt;width:134pt'>&nbsp;</td>
  <td colspan=3 class=xl59 width=158 style='border-left:none;width:120pt'><u
  style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td colspan=2 class=xl61 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl51 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl62 style='border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 colspan=9 style='height:18.0pt;mso-ignore:colspan'>7.
  Attchment: Quotation, Purchase order, Comparison table &amp; MPR. ( End./. )</td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 
 <%
    } 
    %>  
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=69 style='width:52pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=75 style='width:56pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
