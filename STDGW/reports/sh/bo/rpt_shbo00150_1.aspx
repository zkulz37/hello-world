﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string dtForm=Request["dtform"];
    string dtTo= Request["dtto"];
    string dtToday = Request["dttoday"];
    string type = Request["type"];
    string hoki = Request["hoki"];
    string sql = "select to_char(to_date(" + dtForm + ",'yyyymmdd'),'yyyy.mm.dd'),to_char(to_date(" + dtTo + ",'yyyymmdd'),'yyyy.mm.dd'),to_char(to_date(" + dtToday + ",'yyyymmdd'),'yyyy.mm.dd') from dual";
    DataTable dt = ESysLib.TableReadOpen(sql);
    string a = dt.Rows[0][0].ToString();
    string b = dt.Rows[0][1].ToString();
    string c = dt.Rows[0][2].ToString();
    DataTable dt1 = ESysLib.TableReadOpenCursor("prod.sp_rpt_shbo00150_1", "'" + dtForm + "','" + dtTo + "','" + hoki + "'");
    DataTable dt2 = ESysLib.TableReadOpenCursor("prod.sp_rpt_shbo00150_1_total", "'" + dtForm + "','" + dtTo + "','" + hoki + "'");
    DataTable dt3 = ESysLib.TableReadOpenCursor("prod.sp_rpt_shbo00150_1_total2", "'" + dtForm + "','" + dtTo + "','" + hoki + "'");
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_shbo00150_2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_shbo00150_2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_shbo00150_2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Trung</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2010-03-31T06:06:53Z</o:LastPrinted>
  <o:Created>2010-03-30T02:19:16Z</o:Created>
  <o:LastSaved>2010-03-31T06:10:30Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.66in .25in 1.0in .22in;
	mso-header-margin:.46in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
.font6
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-size:12.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:left;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:right;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-align:left;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>86</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:RangeSelection>$A$1:$R$1</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$1:$R$29</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1179 style='border-collapse:
 collapse;table-layout:fixed;width:884pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=76 style='mso-width-source:userset;mso-width-alt:2779;width:57pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=67 span=2 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=18 height=30 class=xl30 width=1179 style='height:22.5pt;
  width:884pt'><a name="Print_Area"><span style='mso-spacerun:yes'> </span>Lot
  No. Register</a></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=9 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl26></td>
  <td colspan=2 class=xl41></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31>Date : <font class="font8"><%=c %></font></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl32 style='height:18.75pt'>Machine : <%=hoki %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl27>Period:</td>
  <td colspan=3 class=xl25><%=a %><span style='mso-spacerun:yes'>  
  </span>-<span style='mso-spacerun:yes'>   </span><%=b %></td>
  <td colspan=2 class=xl41></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31>Page :<font class="font6"><span
  style='mso-spacerun:yes'>  </span>1<span style='mso-spacerun:yes'>     
  </span>/<span style='mso-spacerun:yes'>  </span>1</font></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=18 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl29 style='height:19.5pt'>Issue No</td>
  <td colspan=2 class=xl29>Issued<span style='mso-spacerun:yes'>  </span>Date</td>
  <td colspan=2 class=xl29>Entered Date</td>
  <td colspan=2 class=xl29>Customer</td>
  <td colspan=2 class=xl29>Product Name</td>
  <td colspan=2 class=xl29>Lot No.</td>
  <td colspan=2 class=xl29>Estimated Q'ty</td>
  <td colspan=2 class=xl29>Type</td>
  <td colspan=2 class=xl29>Remark</td>
 </tr>
 <%
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
         %>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl36 style='height:19.5pt'><%=dt1.Rows[i][0] %></td>
  <td colspan=2 class=xl36><%=dt1.Rows[i][1] %></td>
  <td colspan=2 class=xl36><%=dt1.Rows[i][2] %></td>
  <td colspan=2 class=xl37><%=dt1.Rows[i][3] %></td>
  <td colspan=2 class=xl37><%=dt1.Rows[i][4] %></td>
  <td colspan=2 class=xl36><%=dt1.Rows[i][5] %></td>
  <td colspan=2 class=xl38 x:num><%=dt1.Rows[i][6] %></td>
  <td colspan=2 class=xl36><%=dt1.Rows[i][7] %></td>
  <td colspan=2 class=xl36><%=dt1.Rows[i][8] %></td>
 </tr>
         <% 
     }
  %>
 <%
     for (int j = 0; j < dt2.Rows.Count; j++)
     {
         if (j == 0)
         {
             %>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl39 style='height:19.5pt'>&nbsp;</td>
  <td colspan=2 class=xl39>&nbsp;</td>
  <td colspan=2 class=xl39>&nbsp;</td>
  <td colspan=2 class=xl39>&nbsp;</td>
  <td colspan=2 class=xl39>&nbsp;</td>
  <td colspan=2 class=xl39><%=dt2.Rows[j][0] %></td>
  <td colspan=2 class=xl40 x:num><%=dt2.Rows[j][1] %></td>
  <td colspan=2 class=xl39>&nbsp;</td>
  <td colspan=2 class=xl39>&nbsp;</td>
 </tr>
             <% 
         } 
         else
         {
             %>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl36 style='height:19.5pt'></td>
  <td colspan=2 class=xl36></td>
  <td colspan=2 class=xl36></td>
  <td colspan=2 class=xl36></td>
  <td colspan=2 class=xl36></td>
  <td colspan=2 class=xl36><%=dt2.Rows[j][0] %></td>
  <td colspan=2 class=xl38 x:num><%=dt2.Rows[j][1] %></td>
  <td colspan=2 class=xl36></td>
  <td colspan=2 class=xl36></td>
 </tr>
             <%
         }
     }
  %>
 <%
     for (int k = 0; k < dt3.Rows.Count; k++)
     {
         %>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl39 style='height:19.5pt'>&nbsp;</td>
  <td colspan=2 class=xl39>&nbsp;</td>
  <td colspan=2 class=xl39>&nbsp;</td>
  <td colspan=2 class=xl39>&nbsp;</td>
  <td colspan=2 class=xl39>&nbsp;</td>
  <td colspan=2 class=xl42>Total</td>
  <td colspan=2 class=xl40 x:num><%=dt3.Rows[k][0] %></td>
  <td colspan=2 class=xl39>&nbsp;</td>
  <td colspan=2 class=xl39>&nbsp;</td>
 </tr>
         <% 
     }
  %>

 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=416 style='mso-height-source:userset;height:312.0pt;
  mso-xlrowspan:16'>
  <td height=416 colspan=18 class=xl28 style='height:312.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=18 class=xl28 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=59 style='width:44pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
