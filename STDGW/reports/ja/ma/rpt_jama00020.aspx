<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("CRM");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string p_Month = Request["p_Month"];
    string l_date_to;
    DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_jama00020", p_Month);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    l_date_to = p_Month.Substring(4, 2) + "/" + p_Month.Substring(0, 4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="aaab12_files/filelist.xml">
<link rel=Edit-Time-Data href="aaab12_files/editdata.mso">
<link rel=OLE-Object-Data href="aaab12_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2010-04-12T10:00:24Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2010-05-12T10:17:26Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .75in .5in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-horizontal-page-align:center;}
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
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-rotate:90;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-number-format:"\#\,\#\#0";}
.xl34
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-number-format:"\#\,\#\#0";}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-size:9.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\;\[Red\]0";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-number-format:"\#\,\#\#0";}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Calibri;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl51
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl52
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl53
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl54
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl55
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl56
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl57
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl58
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl59
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl60
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl61
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl62
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>FNB PNL</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>87</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8355</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1980</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='FNB PNL'!$2:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=704 style='border-collapse:
 collapse;table-layout:fixed;width:528pt'>
 <col class=xl24 width=277 style='mso-width-source:userset;mso-width-alt:10130;
 width:208pt'>
 <col class=xl25 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl25 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl25 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl26 width=55 span=2 style='mso-width-source:userset;mso-width-alt:
 2011;width:41pt'>
 <col class=xl25 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl26 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl26 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl26 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=10 height=38 class=xl49 width=704 style='height:28.5pt;
  width:528pt'>Food &amp; Beverage Statement of Income &amp; Expenses<br>
    Month : <%=l_date_to%></td>
 </tr>
 <tr height=145 style='mso-height-source:userset;height:108.75pt'>
  <td height=145 class=xl27 width=277 style='height:108.75pt;width:208pt'>Food
  &amp; Beverage Statement of Income &amp; Expenses</td>
  <td rowspan=3 class=xl50 width=48 style='border-bottom:.5pt solid black;
  width:36pt'>Account Code</td>
  <td rowspan=3 class=xl50 width=45 style='border-bottom:.5pt solid black;
  width:34pt'>Deapt Code</td>
  <td rowspan=2 class=xl53 width=55 style='border-bottom:.5pt solid black;
  width:41pt'>Golf Club Restaurant &amp; Tea Hse</td>
  <td rowspan=2 class=xl55 width=55 style='border-bottom:.5pt solid black;
  width:41pt'>Golf Academy Dinning Bar</td>
  <td rowspan=2 class=xl55 width=55 style='border-bottom:.5pt solid black;
  width:41pt'>Tower Restaurant, Pool &amp; Room Service</td>
  <td rowspan=2 class=xl57 width=43 style='border-bottom:.5pt solid black;
  width:32pt' x:str="Tower lobby Lounge ">Tower lobby Lounge<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl59 width=45 style='border-bottom:.5pt solid black;
  width:34pt'>Banquet</td>
  <td rowspan=2 class=xl59 width=40 style='border-bottom:.5pt solid black;
  width:30pt'>Mini Bar</td>
  <td rowspan=2 class=xl61 width=41 style='border-bottom:.5pt solid black;
  width:31pt'>F&amp;B Mgmt Office</td>
 </tr>
 <tr class=xl28 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt' x:str="'in Vietnam Dong">in
  Vietnam Dong</td>
 </tr>
 <tr class=xl28 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'>&nbsp;</td>
  <td colspan=6 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>Outlets Code</td>
  <td class=xl30 width=41 style='width:31pt'>&nbsp;</td>
 </tr>
 <%
     string strBegin = "";
     string strEnd = "";
     for (int i = 2; i < dt.Rows.Count; i++)
     {
         strBegin = "";
         strEnd = "";
         if (dt.Rows[i][11].ToString() == "B")
         {

             strBegin = "<b>";
             strEnd = "</b>";
         }
  %>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl39 style='height:14.25pt'><%=strBegin %><%= dt.Rows[i][0].ToString()%><%=strEnd%></td>
  <td class=xl31 x:str><%= dt.Rows[i][1].ToString()%></td>
  <td class=xl32 x:str><%= dt.Rows[i][2].ToString()%></td>
  <td class=xl33 x:num><%= dt.Rows[i][3].ToString()%></td>
  <td class=xl34 x:num><%= dt.Rows[i][4].ToString()%></td>
  <td class=xl34 x:num><%= dt.Rows[i][5].ToString()%></td>
  <td class=xl34 x:num><%= dt.Rows[i][6].ToString()%></td>
  <td class=xl34 x:num><%= dt.Rows[i][7].ToString()%></td>
  <td class=xl34 x:num><%= dt.Rows[i][8].ToString()%></td>
  <td class=xl35 x:num><%= dt.Rows[i][9].ToString()%></td>
 </tr>
 <%
     } %>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>Total Other Expenses</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>In US$</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>TOTAL COST &amp; EXPENSES</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>In US$</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>Outlet Profit</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>In US$</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl36 style='height:12.75pt'>STATISTICS</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>Number of Seats</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>Seat Turnover</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>No. of Covers</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>Average Covers Per Day</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>Food Spend (US$)</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>Beverage Spend (US$)</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>Combined Spend (US$)</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>Food Spend (VND)</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>Beverage Spend (VND)</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>Combined Spend (VND)</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl38 style='height:12.75pt'>No. of employee</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=6 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl38 style='height:14.25pt'>- Total</td>
  <td colspan=3 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl38 style='height:14.25pt'>- Service</td>
  <td colspan=3 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl38 style='height:14.25pt'>- Kitchen</td>
  <td colspan=3 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=277 style='width:208pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=41 style='width:31pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
