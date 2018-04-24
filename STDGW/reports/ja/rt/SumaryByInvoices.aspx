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
    string p1= Request.QueryString["dtfr"];
	string p2= Request.QueryString["dtTo"];
	string p3= Request.QueryString["loc"];
	string p4= Request.QueryString["golf"];
	string p5= Request.QueryString["pay"];
	string l_parameter = "'" +  p1 + "','" + p2 + "','" +  p3 + "','" +  p4 + "','" + p5 + "'";
	int ttcl2 = 0, ttcl3 = 0, ttcl4 = 0, ttcl5 = 0, ttcl7 = 0, ttcl8 = 0, ttcl9 = 0, ttcl11 = 0, ttcl12 = 0, ttcl13 = 0, ttcl14 = 0, ttcl15 = 0, ttcl16 = 0;
	int ttcl19 = 0, ttcl20 = 0, ttcl21 = 0, ttcl22 = 0, ttcl23 = 0, ttcl24 = 0, ttcl25 = 0, ttcl26 = 0, ttcl27 = 0;
	
	DataTable dt;
    dt = ESysLib.TableReadOpenCursor("crm.sp_sel_jart00060_rpt2",l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="SumaryByInvoices_files/filelist.xml">
<link rel=Edit-Time-Data href="SumaryByInvoices_files/editdata.mso">
<link rel=OLE-Object-Data href="SumaryByInvoices_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Le Huu Phuc</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-06-07T09:37:27Z</o:LastPrinted>
  <o:Created>2011-03-10T03:03:15Z</o:Created>
  <o:LastSaved>2011-06-07T09:38:38Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in 0in .75in .16in;
	mso-header-margin:.31in;
	mso-footer-margin:.31in;
	mso-page-orientation:landscape;}
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	font-size:8.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:right;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"Short Date";
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style16;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style16;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-align:center;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:left;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>46</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveCol>0</x:ActiveCol>
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
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
  <x:Formula>=Sheet1!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2172 style='border-collapse:
 collapse;table-layout:fixed;width:1630pt'>
 <col class=xl24 width=133 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <col class=xl25 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=72 span=2 style='mso-width-source:userset;mso-width-alt:
 2633;width:54pt'>
 <col class=xl24 width=73 span=3 style='mso-width-source:userset;mso-width-alt:
 2669;width:55pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=71 span=3 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=71 span=2 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=198 style='mso-width-source:userset;mso-width-alt:7241;
 width:149pt'>
 <col class=xl24 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <tr height=15 style='height:11.25pt'>
  <td colspan=26 rowspan=2 height=30 class=xl55 width=2027 style='height:22.5pt;
  width:1521pt'>SUMARY BY INVOICE</td>
  <td class=xl24 width=145 style='width:109pt'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl24 style='height:11.25pt'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=4 height=18 class=xl26 style='height:13.5pt'><%=dt.Rows[0][30]%></td>
  <td class=xl27 x:str="Location : ">Location :</td>
  <td colspan=3 class=xl56><%=dt.Rows[0][31]%></td>
  <td class=xl27>Customer :</td>
  <td colspan=2 class=xl56><%=dt.Rows[0][32]%></td>
  <td colspan=2 class=xl27>Payment Method :</td>
  <td colspan=2 class=xl56><%=dt.Rows[0][33]%></td>
  <td colspan=9 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl27>Print Date :</td>
  <td class=xl28><%=dt.Rows[0][34]%></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'></td>
  <td class=xl25></td>
  <td colspan=25 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl30 width=133 style='height:23.25pt;width:100pt'>LOCATION</td>
  <td class=xl31 width=73 style='width:55pt'>INVOICE NO.</td>
  <td class=xl31 width=63 style='width:47pt'>DATE</td>
  <td class=xl31 width=42 style='width:32pt'>GUEST</td>
  <td class=xl31 width=71 style='width:53pt'>FOOD AMB</td>
  <td class=xl31 width=72 style='width:54pt'>FOOD NOT AMB</td>
  <td class=xl31 width=72 style='width:54pt'>FOOD OTHER</td>
  <td class=xl31 width=73 style='width:55pt'>BVR AMB</td>
  <td class=xl31 width=73 style='width:55pt'>BVR<span
  style='mso-spacerun:yes'>  </span>NOT AMB</td>
  <td class=xl31 width=73 style='width:55pt'>BVR OTHER</td>
  <td class=xl31 width=72 style='width:54pt'>OTHERS</td>
  <td class=xl31 width=71 style='width:53pt'>SERVICES CHARGE</td>
  <td class=xl31 width=73 style='width:55pt'>VAT</td>
  <td class=xl31 width=72 style='width:54pt'>DISCOUNT (-)</td>
  <td class=xl31 width=71 style='width:53pt'>TOTAL</td>
  <td class=xl31 width=71 style='width:53pt'>ADJUST (+/-)</td>
  <td class=xl31 width=71 style='width:53pt'>CASH</td>
  <td class=xl31 width=73 style='width:55pt'>CREDIT CARD</td>
  <td class=xl31 width=71 style='width:53pt'>FO HOTEL</td>
  <td class=xl31 width=71 style='width:53pt'>FO CLUB</td>
  <td class=xl31 width=72 style='width:54pt'>DEBIT</td>
  <td class=xl31 width=71 style='width:53pt'>OFFICE CHECK</td>
  <td class=xl31 width=82 style='width:62pt'>ENTERTAINMENT</td>
  <td class=xl31 width=72 style='width:54pt'>TRANFER</td>
  <td class=xl31 width=71 style='width:53pt'>TOTAL BILL</td>
  <td class=xl31 width=198 style='width:149pt'>GUEST NAME</td>
  <td class=xl31 width=145 style='width:109pt'>COMPANY<span
  style='mso-spacerun:yes'>  </span>NAME</td>
 </tr>
 <% for (int idx = 0; idx < dt.Rows.Count; idx ++){ %>
 <%
	ttcl2 += int.Parse((dt.Rows[idx][2].ToString()== "")?"0":dt.Rows[idx][2].ToString());
	ttcl3 += int.Parse((dt.Rows[idx][3].ToString()== "")?"0":dt.Rows[idx][3].ToString());
	ttcl4 += int.Parse((dt.Rows[idx][4].ToString()== "")?"0":dt.Rows[idx][4].ToString());
	ttcl5 += int.Parse((dt.Rows[idx][5].ToString()== "")?"0":dt.Rows[idx][5].ToString());
	
	ttcl7 += int.Parse((dt.Rows[idx][7].ToString()== "")?"0":dt.Rows[idx][7].ToString());
	ttcl8 += int.Parse((dt.Rows[idx][8].ToString()== "")?"0":dt.Rows[idx][8].ToString());
	ttcl9 += int.Parse((dt.Rows[idx][9].ToString()== "")?"0":dt.Rows[idx][9].ToString());
	
	ttcl11 += int.Parse((dt.Rows[idx][11].ToString()== "")?"0":dt.Rows[idx][11].ToString());
	ttcl12 += int.Parse((dt.Rows[idx][12].ToString()== "")?"0":dt.Rows[idx][12].ToString());
	ttcl13 += int.Parse((dt.Rows[idx][13].ToString()== "")?"0":dt.Rows[idx][13].ToString());
	ttcl14 += int.Parse((dt.Rows[idx][14].ToString()== "")?"0":dt.Rows[idx][14].ToString());
	ttcl15 += int.Parse((dt.Rows[idx][15].ToString()== "")?"0":dt.Rows[idx][15].ToString());
	ttcl16 += int.Parse((dt.Rows[idx][16].ToString()== "")?"0":dt.Rows[idx][16].ToString());
	
	ttcl19 += int.Parse((dt.Rows[idx][19].ToString()== "")?"0":dt.Rows[idx][19].ToString());
	ttcl20 += int.Parse((dt.Rows[idx][20].ToString()== "")?"0":dt.Rows[idx][20].ToString());
	ttcl21 += int.Parse((dt.Rows[idx][21].ToString()== "")?"0":dt.Rows[idx][21].ToString());
	ttcl22 += int.Parse((dt.Rows[idx][22].ToString()== "")?"0":dt.Rows[idx][22].ToString());
	ttcl23 += int.Parse((dt.Rows[idx][23].ToString()== "")?"0":dt.Rows[idx][23].ToString());
	ttcl24 += int.Parse((dt.Rows[idx][24].ToString()== "")?"0":dt.Rows[idx][24].ToString());
	ttcl25 += int.Parse((dt.Rows[idx][25].ToString()== "")?"0":dt.Rows[idx][25].ToString());
	ttcl26 += int.Parse((dt.Rows[idx][26].ToString()== "")?"0":dt.Rows[idx][26].ToString());
	ttcl27 += int.Parse((dt.Rows[idx][27].ToString()== "")?"0":dt.Rows[idx][27].ToString());
 %>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl32 style='height:11.25pt'><%=dt.Rows[idx][35]%></td>
  <td class=xl33 x:num><%=dt.Rows[idx][0]%></td>
  <td class=xl34 x:num><%=dt.Rows[idx][1]%></td>
  <td class=xl35 x:num><%=dt.Rows[idx][2]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][3]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][4]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][5]%></td>
  
  <td class=xl36 x:num><%=dt.Rows[idx][7]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][8]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][9]%></td>
  
  <td class=xl36 x:num><%=dt.Rows[idx][11]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][12]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][13]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][14]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][15]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][16]%></td>
  
  <td class=xl36 x:num><%=dt.Rows[idx][19]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][20]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][21]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][22]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][23]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][24]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][25]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][26]%></td>
  <td class=xl36 x:num><%=dt.Rows[idx][27]%></td>
  
  <td class=xl37><%=dt.Rows[idx][28]%></td>
  <td class=xl37><%=dt.Rows[idx][36]%></td>
 </tr>
 <%}%>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=3 height=28 class=xl45 width=269 style='border-right:.5pt solid black;
  height:21.0pt;width:202pt'>SUM<span style='mso-spacerun:yes'>  </span>TOTAL</td>
  <td class=xl38 x:num><%=ttcl2 %></td>
  <td class=xl38 x:num><%=ttcl3 %> </td>
  <td class=xl38 x:num><%=ttcl4 %> </td>
  <td class=xl38 x:num><%=ttcl5 %> </td>
  
  <td class=xl38 x:num><%=ttcl7 %> </td>
  <td class=xl38 x:num><%=ttcl8 %> </td>
  <td class=xl38 x:num><%=ttcl9 %> </td>
  
  <td class=xl38 x:num><%=ttcl11 %> </td>
  <td class=xl38 x:num><%=ttcl12 %> </td>
  <td class=xl38 x:num><%=ttcl13 %> </td>
  <td class=xl38 x:num><%=ttcl14 %> </td>
  <td class=xl38 x:num><%=ttcl15 %> </td>
  <td class=xl38 x:num><%=ttcl16 %> </td>
  
  <td class=xl38 x:num><%=ttcl19 %> </td>
  <td class=xl38 x:num><%=ttcl20 %> </td>
  <td class=xl38 x:num><%=ttcl21 %> </td>
  <td class=xl38 x:num><%=ttcl22 %> </td>
  <td class=xl38 x:num><%=ttcl23 %> </td>
  <td class=xl38 x:num><%=ttcl24 %> </td>
  <td class=xl38 x:num><%=ttcl25 %> </td>
  <td class=xl38 x:num><%=ttcl26 %> </td>
  <td class=xl38 x:num><%=ttcl27 %> </td>
  
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl24 style='height:11.25pt'></td>
  <td class=xl25></td>
  <td colspan=25 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=6 height=17 class=xl48 style='border-right:.5pt solid black;
  height:12.75pt' x:str="F&amp;B ">F&amp;B<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl48 style='border-right:.5pt solid black'>Financial
  Department</td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td colspan=2 height=15 class=xl51 style='border-right:.5pt solid black;
  height:11.25pt'>In charge</td>
  <td colspan=4 class=xl53 style='border-right:.5pt solid black;border-left:
  none'>Dept Head</td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black'>In charge</td>
  <td colspan=2 class=xl53 style='border-right:.5pt solid black;border-left:
  none'>Chief Acc</td>
  <td class=xl39>Dept G/D</td>
 </tr>
 <tr height=98 style='mso-height-source:userset;height:73.5pt'>
  <td colspan=2 height=98 class=xl41 style='border-right:.5pt solid black;
  height:73.5pt'>&nbsp;</td>
  <td colspan=4 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl41 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl40 width=145 style='width:109pt'><br>
    </td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=133 style='width:100pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=198 style='width:149pt'></td>
  <td width=145 style='width:109pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
