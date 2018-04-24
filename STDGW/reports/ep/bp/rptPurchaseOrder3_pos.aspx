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
    DataTable dt_mst, dtl;
    
    string rs1, rs2, sSQL1, sSQL2, sSQL3, sUserID, poPK = "", sThu, wi;
	string sPONo, sCompanyName, sPODate, sAddress, sPhone, sFax, sTo, sPaymentType, sDeliveryTerm , sProject;
    int rows_seq = 0, page_rows = 18;
    
    double ttQTY, ttAMT;
    ttQTY = 0.0;
    ttAMT = 0.0;
    
    poPK = Request["PO_PK"];
      
    dt_mst = ESysLib.TableReadOpenCursor("PROD.SP_SEL_EPBP00130_10_1", poPK);
    dtl = ESysLib.TableReadOpenCursor("PROD.SP_SEL_EPBP00130_10_2", poPK);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rptPurchaseOrder3_pos_files/filelist.xml">
<link rel=Edit-Time-Data href="rptPurchaseOrder3_pos_files/editdata.mso">
<link rel=OLE-Object-Data href="rptPurchaseOrder3_pos_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>IT DEPT</o:Author>
  <o:LastAuthor>user</o:LastAuthor>
  <o:LastPrinted>2006-08-31T08:01:45Z</o:LastPrinted>
  <o:Created>2005-02-02T09:57:08Z</o:Created>
  <o:LastSaved>2007-08-17T02:56:59Z</o:LastSaved>
  <o:Company>ESTV</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .2in .5in .5in;
	mso-header-margin:.1in;
	mso-footer-margin:.1in;}
.font8
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;}
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
	font-family:"Arial Unicode MS";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Arial Unicode MS";
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
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	font-size:21.0pt;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl50
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	text-align:center;
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
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Arial Unicode MS", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>12</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9105</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1410</x:WindowTopY>
  <x:TabRatio>345</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1032"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=735 style='border-collapse:
 collapse;table-layout:fixed;width:552pt'>
 
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:4425;width:91pt'>
 <col width=67 span=2 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:2048;width:42pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:2048;width:42pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=25 style='mso-width-source:userset;mso-width-alt:914;width:19pt'>
 <col width=30 style='mso-width-source:userset;mso-width-alt:1097;width:23pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 width=37 style='height:15.0pt;width:28pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=30 style='width:23pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=12 height=20 class=xl47 style='height:15.0pt'>POSLILAMA
  ENGINEERING &amp; CONSTRUCTION CO.,LTD</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=12 height=20 class=xl47 style='height:15.0pt'>NHON TRACH
  Industrial Park</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=12 height=20 class=xl47 style='height:15.0pt'>NHON TRACH IZ NO.1
  NHON TRACH DISTRICT, DONG NAI POVINCE VIET NAM</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td colspan=11 class=xl47>Tel 84-061-848633</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td colspan=11 class=xl47>Fax 84-061-848633</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=8 height=20 style='height:15.0pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=12 rowspan=2 height=34 class=xl48 style='height:25.5pt'>PURCHASE
  ORDER</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=8 height=20 style='height:15.0pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=4 height=22 class=xl24 style='height:16.5pt'>DATE<font
  class="font8"> : <%=dt_mst.Rows[0]["po_date"].ToString()%></font></td>
  <td class=xl24></td>
  <td colspan=7 class=xl24>TO<font class="font8"> : <%=dt_mst.Rows[0]["partner_name"].ToString()%></font></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=4 height=22 class=xl25 style='height:16.5pt'>PROJECT<font
  class="font8"> : </font><%=dt_mst.Rows[0]["pl_nm"].ToString()%></td>
  <td class=xl25></td>
  <td colspan=7 class=xl24>TEL<font class="font8"> : <%=dt_mst.Rows[0]["phone_no"].ToString()%></font></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=4 height=22 class=xl24 style='height:16.5pt'>PO NO<font
  class="font8"> : <%=dt_mst.Rows[0]["po_no"].ToString()%></font></td>
  <td class=xl24></td>
  <td colspan=7 class=xl24>FAX<font class="font8"> : <%=dt_mst.Rows[0]["fax_no"].ToString()%></font></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=4 height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=8 height=20 style='height:15.0pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=12 height=20 class=xl49 style='height:15.0pt'>Dear sirs,</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=12 height=20 class=xl49 style='height:15.0pt'>We hereby place
  purchase order with following specified term and condition.</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=8 height=20 class=xl50 style='height:15.0pt'>&nbsp;</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt;border-top:none'>NO</td>
  <td class=xl29 style='border-top:none'>P.NO</td>
  <td class=xl29 style='border-top:none'>P.NAME</td>
  <td class=xl29 style='border-top:none'>UNIT</td>
  <td class=xl29 style='border-top:none'>Weight</td>
  <td class=xl29 style='border-top:none'>Q'TY</td>
  <td class=xl29 style='border-top:none'>AMOUNT</td>
  <td class=xl29 style='border-top:none'>ETD</td>
  <td colspan=4 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:str="REMARK ">REMARK<span style='mso-spacerun:yes'> </span></td>
 </tr>
 
 <%
     if (dtl.Rows.Count > 0)
     {         
         for(int i = 0; i < dtl.Rows.Count; i++)
         {
             rows_seq++;
             ttQTY = ttQTY + double.Parse(dtl.Rows[i][5].ToString());
             ttAMT = ttAMT + double.Parse(dtl.Rows[i][6].ToString());
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt' x:num><%=dtl.Rows[i][0].ToString() %></td>
  <td class=xl31 x:string><%=dtl.Rows[i][1].ToString() %></td>
  <td class=xl31><%=dtl.Rows[i][2].ToString() %></td>
  <td class=xl32><%=dtl.Rows[i][3].ToString() %></td>
  <td class=xl33 style='mso-number-format:"\#\,\#\#0\.00";' align=right x:num><%=dtl.Rows[i][4].ToString() %></td>
  <td class=xl33 style='mso-number-format:"\#\,\#\#0\.00";' align=right x:num><%=dtl.Rows[i][5].ToString() %></td>
  <td class=xl33 style='mso-number-format:"\#\,\#\#0\.00";' align=right x:num><%=dtl.Rows[i][6].ToString() %></td>
  <td class=xl32><%=dtl.Rows[i][7].ToString() %></td>
  <td colspan=4 class=xl54 style='border-right:.5pt solid black;border-left:
  none'><%=dtl.Rows[i][8].ToString() %></td>
 </tr> 
 <%
        }
     }       
 %>
 
 <%
    if (rows_seq < page_rows)
    {
        for (int j = rows_seq + 1; j < page_rows; j++)
        {
 %>
    <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt' x:num><%=j%></td>
  <td class=xl31 x:string></td>
  <td class=xl31></td>
  <td class=xl32></td>
  <td class=xl33 style='mso-number-format:"\#\,\#\#0\.00";' align=right x:num></td>
  <td class=xl33 style='mso-number-format:"\#\,\#\#0\.00";' align=right x:num></td>
  <td class=xl33 style='mso-number-format:"\#\,\#\#0\.00";' align=right x:num></td>
  <td class=xl32></td>
  <td colspan=4 class=xl54 style='border-right:.5pt solid black;border-left:
  none'></td>
 </tr> 
 <%
        }
    }
 %>
 
 <tr height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl59 style='border-right:.5pt solid black;
  height:15.0pt'>&nbsp;</td>
  <td class=xl35>TOTAL:</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37 style='mso-number-format:"\#\,\#\#0\.00";' align=right x:num><%=ttQTY %></td>
  <td class=xl37 style='mso-number-format:"\#\,\#\#0\.00";' align=right x:num><%=ttAMT %></td>
  <td class=xl36>&nbsp;</td>
  <td colspan=4 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=12 height=20 class=xl64 style='border-right:1.0pt solid black;
  height:15.0pt'>REMARK:</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'>1)</td>
  <td colspan=11 class=xl67 style='border-right:1.0pt solid black'>Kindly
  acknowledge receipt acceptance of the above PO(s) by RETURN FAX WITHIN 1
  WORKING DAY from</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl42 style='height:15.0pt'>&nbsp;</td>
  <td colspan=11 class=xl67 style='border-right:1.0pt solid black'>this FAX
  (Otherwise consider accepted)</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'>2)</td>
  <td colspan=11 class=xl67 style='border-right:1.0pt solid black'>The ETD day
  is the above mentioned, please also inform earlier of any changes within the
  above time</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl41 style='height:15.0pt'>3)</td>
  <td colspan=11 class=xl67 style='border-right:1.0pt solid black'>Right after
  your delivery, please fax the Invoice, Packing list and B/L. The original
  will be sent by email express</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl42 style='height:15.0pt'>&nbsp;</td>
  <td colspan=11 class=xl67 style='border-right:1.0pt solid black'>(DHL) to our
  company as the above address</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'>4)</td>
  <td colspan=11 class=xl67 style='border-right:1.0pt solid black'>Please
  notice our PO Number in your tax invoice</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl43 style='height:15.0pt'>5)</td>
  <td class=xl44 x:str="Payment term: ">Payment term:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=10 class=xl69 style='border-right:1.0pt solid black'>paymenthere</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl45 style='height:15.75pt'>6)</td>
  <td class=xl46 x:str="Delivery term:  ">Delivery term:<span
  style='mso-spacerun:yes'>  </span></td>
  <td colspan=10 class=xl71 style='border-right:1.0pt solid black'>delivehare</td>
 </tr>
 <tr height=40 style='height:30.0pt;mso-xlrowspan:2'>
  <td height=40 colspan=12 style='height:30.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=12 height=20 class=xl73 style='height:15.0pt'>POSLILAMA CORP.
  Prepaired by POSLILAMA CORP. Approved by Confirmed by</td>
 </tr>
 <tr height=100 style='height:75.0pt;mso-xlrowspan:5'>
  <td height=100 colspan=12 style='height:75.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=12 height=20 width=735 style='height:15.0pt;width:552pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1026" style='position:absolute;
   z-index:1' from="285pt,6pt" to="385.5pt,6pt" strokecolor="windowText"
   o:insetmode="auto"/><v:line id="_x0000_s1030" style='position:absolute;
   z-index:5' from="61.5pt,5.25pt" to="137.25pt,5.25pt" strokecolor="windowText"
   o:insetmode="auto"/><v:line id="_x0000_s1027" style='position:absolute;
   z-index:2' from="456pt,5.25pt" to="513pt,5.25pt" strokecolor="windowText"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:81px;margin-top:6px;width:604px;
  height:3px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=103></td>
    <td width=195></td>
    <td width=136></td>
    <td width=92></td>
    <td width=78></td>
   </tr>
   <tr>
    <td height=1></td>
    <td rowspan=2 align=left valign=top><img width=103 height=2
    src="rptPurchaseOrder3_pos_files/image001.gif" v:shapes="_x0000_s1030"></td>
    <td colspan=3></td>
    <td rowspan=2 align=left valign=top><img width=78 height=2
    src="rptPurchaseOrder3_pos_files/image002.gif" v:shapes="_x0000_s1027"></td>
   </tr>
   <tr>
    <td height=1></td>
    <td></td>
    <td rowspan=2 align=left valign=top><img width=136 height=2
    src="rptPurchaseOrder3_pos_files/image003.gif" v:shapes="_x0000_s1026"></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=12 height=20 class=xl38 width=735 style='height:15.0pt;
    width:552pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=8 height=20 class=xl26 style='height:15.0pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt' align=left valign=top><!--[if gte vml 1]><v:line
   id="_x0000_s1028" style='position:absolute;z-index:3' from="27.75pt,2.25pt"
   to="27.75pt,2.25pt" strokecolor="windowText" o:insetmode="auto"/><v:line
   id="_x0000_s1029" style='position:absolute;z-index:4' from="27.75pt,2.25pt"
   to="27.75pt,2.25pt" strokecolor="windowText" o:insetmode="auto"/><v:line
   id="_x0000_s1031" style='position:absolute;z-index:6' from="27.75pt,2.25pt"
   to="27.75pt,2.25pt" strokecolor="windowText" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:3;margin-left:36px;
  margin-top:2px;width:2px;height:2px'><img width=2 height=2
  src="rptPurchaseOrder3_pos_files/image004.gif" v:shapes="_x0000_s1028 _x0000_s1029 _x0000_s1031"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 width=37 style='height:15.0pt;width:28pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=30 style='width:23pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>