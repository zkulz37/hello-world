<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("prod");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string _date = Request.QueryString["day"];

    string _prod_date = _date.Substring(0, 4) + "/" + _date.Substring(4, 2) + "/" + _date.Substring(6, 2);
    string _work_process_pk = Request.QueryString["work_process_pk"];
    string _work_process_name = Request.QueryString["work_process_name"];

    DataTable dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fppr00010", _date, _work_process_pk);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_fpgm00090_bkvina_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_fpgm00090_bkvina_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_fpgm00090_bkvina_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>QuangNguyen</o:LastAuthor>
  <o:LastPrinted>2010-05-04T05:45:54Z</o:LastPrinted>
  <o:Created>2008-11-04T04:34:59Z</o:Created>
  <o:LastSaved>2010-05-05T03:44:39Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&R&P\/&N";
	margin:.63in .59in .59in .59in;
	mso-header-margin:.31in;
	mso-footer-margin:.31in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style18
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma_Sheet1;}
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style23
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
	font-family:Arial, sans-serif;
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
.xl26
	{mso-style-parent:style23;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style23;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style23;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;}
.xl30
	{mso-style-parent:style23;
	color:#993366;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;}
.xl32
	{mso-style-parent:style23;
	font-size:11.0pt;
	text-align:center;}
.xl33
	{mso-style-parent:style23;
	font-size:11.0pt;}
.xl34
	{mso-style-parent:style23;
	font-size:11.0pt;
	text-align:left;}
.xl35
	{mso-style-parent:style23;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style23;
	font-size:11.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style23;
	font-size:11.0pt;
	mso-number-format:"\#\\ ?\/?";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style18;
	font-size:11.0pt;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style23;
	font-size:11.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style23;
	font-size:11.0pt;
	mso-number-format:"Medium Date";
	text-align:left;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl46
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;}
.xl49
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl50
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style23;
	font-size:11.0pt;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style23;
	font-size:11.0pt;
	font-weight:700;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style23;
	font-size:11.0pt;
	border-top:.5pt hairline windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl63
	{mso-style-parent:style23;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>72</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9285</x:WindowHeight>
  <x:WindowWidth>15375</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>270</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$7:$10</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1344 style='border-collapse:
 collapse;table-layout:fixed;width:1008pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:4059;width:83pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=96 span=4 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=64 span=7 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl26 width=330 style='height:15.75pt;
  width:247pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl27 width=96 style='width:72pt'></td>
  <td class=xl28 width=96 style='width:72pt'></td>
  <td class=xl28 width=89 style='width:67pt'></td>
  <td class=xl28 width=97 style='width:73pt'></td>
  <td class=xl28 width=92 style='width:69pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 class=xl26 style='height:23.25pt'></td>
  <td></td>
  <td colspan=5 class=xl63>DAILY PRODUCTION REPORT</td>
  <td colspan=7 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 colspan=2 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td></td>
 </tr>
 <tr class=xl31 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 colspan=2 class=xl31 style='height:21.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td rowspan=3 class=xl60 width=96 style='border-bottom:1.0pt solid black;
  width:72pt'>&#44208;&#51116;<br>
    (Decision)</td>
  <td class=xl42 style='border-left:none'>Charger</td>
  <td class=xl42 style='border-left:none'>Manager</td>
  <td class=xl43 style='border-left:none'>G. Manager</td>
  <td class=xl44 style='border-left:none'>G. Director</td>
  <td colspan=6 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 colspan=2 class=xl31 style='height:21.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td rowspan=2 class=xl56 style='border-bottom:1.0pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl56 style='border-bottom:1.0pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl56 style='border-bottom:1.0pt solid black;border-top:
  none'>&nbsp;</td>
  <td rowspan=2 class=xl58 style='border-bottom:1.0pt solid black;border-top:
  none'>&nbsp;</td>
  <td colspan=6 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 colspan=2 class=xl31 style='height:21.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl53 style='height:21.75pt'>Process:</td>
  <td class=xl34><%=_work_process_name%></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl55></td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl53 style='height:21.75pt' x:str="Date : ">Date :<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl40 ><%=_prod_date%></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl55></td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl33 style='height:21.75pt'></td>
  <td colspan=4 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=9 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl45 style='height:20.1pt'>LINE</td>
  <td class=xl46 style='border-left:none'>P/O</td>
  <td class=xl46 style='border-left:none'>STYLE</td>
  <td class=xl46 style='border-left:none'>Spec 1</td>
  <td class=xl46 style='border-left:none'>Spec 2</td>
  <td class=xl46 style='border-left:none'>Spec 3</td>
  <td class=xl46 style='border-left:none'>Prod. Qty</td>
  <td class=xl46 style='border-left:none'>Defect</td>
  <td class=xl47 style='border-left:none'>Remark</td>
  <td colspan=7 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     int i;
     
     for (i = 0; i < dt.Rows.Count; i++)
     {  
 %>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'><%=dt.Rows[i]["line_name"]%></td>
  <td class=xl35><%=dt.Rows[i]["ref_po_no"]%></td>
  <td class=xl36><%=dt.Rows[i]["item_code"]%></td>
  <td class=xl37><%=dt.Rows[i]["spec01"]%></td>
  <td class=xl37><%=dt.Rows[i]["spec02"]%></td>
  <td class=xl38><%=dt.Rows[i]["spec03"]%></td>
  <td class=xl39 x:num ><%=dt.Rows[i]["prod_qty"]%></td>
  <td class=xl39 x:num ><%=dt.Rows[i]["defect_qty"]%></td>
  <td class=xl52>&nbsp;</td>
  <td colspan=7 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <%
     }
 %>
 <%
     if (i > 0)
     {
 %>
 <tr class=xl31 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl49 style='height:20.1pt'>TOTAL</td>
  <td class=xl50 style='border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-left:none' x:num x:fmla="=SUM(G11:G<%=11+i-1%>)">9708</td>
  <td class=xl50 style='border-left:none' x:num x:fmla="=SUM(H11:H<%=11+i-1%>)">0</td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td colspan=6 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <%
     }
 %>
 <tr class=xl31 height=19 style='height:14.25pt'>
  <td height=19 colspan=16 class=xl31 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=111 style='width:83pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
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
