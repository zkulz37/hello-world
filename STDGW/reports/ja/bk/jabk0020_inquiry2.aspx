<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string dtfrom = Request.QueryString["p_dtfrom"];
    string dtto = Request.QueryString["p_dtto"];
    string member_no = Request.QueryString["p_member_no"];
    string member_name = Request.QueryString["p_member_name"];
    string status = Request.QueryString["p_status"];
    string l_parameter = "'" + dtfrom + "','" + dtto + "','" + member_no + "','" + member_name + "','" + status + "'";
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_jabk0160",l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    dt1 = ESysLib.TableReadOpenCursor("CRM.sp_rpt_jabk0021_rpt", l_parameter);
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="jabk0020_inquiry2_files/filelist.xml">
<link rel=Edit-Time-Data href="jabk0020_inquiry2_files/editdata.mso">
<link rel=OLE-Object-Data href="jabk0020_inquiry2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>dieu</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-05-16T03:13:39Z</o:LastPrinted>
  <o:Created>2010-12-24T11:14:50Z</o:Created>
  <o:LastSaved>2011-05-16T03:13:56Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.2in .2in .16in .2in;
	mso-header-margin:.51in;
	mso-footer-margin:.21in;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	text-align:right;}
.xl26
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:6.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#33CCCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#33CCCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	color:red;
	font-size:14.0pt;
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:SplitVertical>9</x:SplitVertical>
     <x:LeftColumnRightPane>10</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
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
  <x:WindowTopY>0</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1028 style='border-collapse:
 collapse;table-layout:fixed;width:772pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:4425;width:91pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=2 style='mso-width-source:userset;mso-width-alt:73;width:2pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=156 style='mso-width-source:userset;mso-width-alt:5705;width:117pt'>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=15 height=29 class=xl53 width=1028 style='height:21.75pt;
  width:772pt'>Reservation Inquiry</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>Date:</td>
  <td colspan=3 class=xl54><%=dt.Rows[0][14]%></td>
  <td colspan=8 class=xl55>&nbsp;</td>
  <td colspan=2 class=xl56>Print Date:</td>
  <td class=xl25><%=dt.Rows[0][15]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Play Date</td>
  <td class=xl27>T.O.Time</td>
  <td class=xl26 style='border-top:none'>Member#</td>
  <td class=xl26 style='border-top:none'>Full Name</td>
  <td class=xl27>HDCP</td>
  <td class=xl27>Gender</td>
  <td class=xl27>Member Type</td>
  <td class=xl27>Golf Type</td>
  <td class=xl28 style='border-top:none;border-left:none'>Green fee</td>
  <td class=xl27 x:str="Status ">Status<span style='mso-spacerun:yes'> </span></td>
  <td class=xl27>Contact Person</td>
  <td class=xl27>Cart Book</td>
  <td class=xl27>Booking No</td>
  <td class=xl27>Book Date</td>
  <td class=xl26>Company Name</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
	 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'><%=dt.Rows[i][0]%></td>
  <td class=xl30><%=dt.Rows[i][1]%></td>
  <td class=xl31><%=dt.Rows[i][2]%></td>
  <td class=xl31><%=dt.Rows[i][3]%></td>
  <td class=xl32 x:num><%=dt.Rows[i][4]%></td>
  <td class=xl32><%=dt.Rows[i][5]%></td>
  <td class=xl32><%=dt.Rows[i][6]%></td>
  <td class=xl32><%=dt.Rows[i][7]%></td>
  <td class=xl33 style='border-top:none;border-left:none'><%=dt.Rows[i][8]%></td>
  <td class=xl31><%=dt.Rows[i][9]%></td>
  <td class=xl31><%=dt.Rows[i][10]%></td>
  <td class=xl32><%=dt.Rows[i][11]%></td>
  <td class=xl34><%=dt.Rows[i][12]%></td>
  <td class=xl35><%=dt.Rows[i][13]%></td>
  <td class=xl36><%=dt.Rows[i][16]%></td>
 </tr>
 <%}%>
 <tr height=17 style='height:12.75pt'>
  <td colspan=14 height=17 class=xl45 style='height:12.75pt'>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt'>&nbsp;</td>
  <td class=xl38>Morning</td>
  <td class=xl38>Afternoon</td>
  <td class=xl38>Total</td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl46 width=147 style='border-right:.5pt solid black;
  width:111pt'>No. of holes</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl41 style='height:12.75pt'>No of Team</td>
  <td class=xl42 x:num><%=dt1.Rows[0][0]%></td>
  <td class=xl42 x:num><%=dt1.Rows[0][1]%></td>
  <td class=xl42 x:num><%=dt1.Rows[0][2]%></td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td rowspan=2 class=xl49 width=91 style='border-bottom:.5pt solid black;
  border-top:none;width:68pt'>Chapion course</td>
  <td class=xl43>9 holes</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl41 style='height:12.75pt'>No of Play<span
  style='display:none'>er</span></td>
  <td class=xl42 x:num><%=dt1.Rows[1][0]%></td>
  <td class=xl42 x:num><%=dt1.Rows[1][1]%></td>
  <td class=xl42 x:num><%=dt1.Rows[1][2]%></td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl43>18 holes</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt'>Golf cart</td>
  <td class=xl42 x:num><%=dt1.Rows[2][0]%></td>
  <td class=xl42 x:num><%=dt1.Rows[2][1]%></td>
  <td class=xl42 x:num><%=dt1.Rows[2][2]%></td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td rowspan=2 class=xl51 width=91 style='border-bottom:.5pt solid black;
  border-top:none;width:68pt'>E9 course</td>
  <td class=xl43>9 holes</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt'>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'></td>
  <td class=xl43>18 holes</td>
  <td class=xl42>&nbsp;</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=55 style='width:41pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=2 style='width:2pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=156 style='width:117pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
