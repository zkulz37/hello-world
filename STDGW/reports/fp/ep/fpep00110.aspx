<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
             ESysLib.SetUser("mafg");

             string l_dtfrom = Request["p_dtfrom"];
                
             string l_dtto = Request["p_dtto"];
                
             string l_lotno = Request["p_lotno"];
             string l_vendno = Request["p_vendno"];
             string l_size = Request["p_size"];
             string l_matno = Request["p_matno"];
             string l_parameter = "'" + l_dtfrom + "','" + l_dtto + "','" + l_lotno + "','" + l_vendno + "','" + l_matno + "','" + l_size + "'";

             DataTable dt = ESysLib.TableReadOpenCursor("mafg.sp_sel_fpep00110_1", l_parameter);
            
             if (dt.Rows.Count ==0)
             {
                 Response.Write("there are not data.");
                 Response.End();
             }
             l_dtfrom = l_dtfrom.Substring(0, 4) + "/" + l_dtfrom.Substring(4, 2) + "/" + l_dtfrom.Substring(6, 2);//2009/08/25
             l_dtto = l_dtto.Substring(0, 4) + "/" + l_dtto.Substring(4, 2) + "/" + l_dtto.Substring(6, 2);//2009/08/25   
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="report00070_files/filelist.xml">
<link rel=Edit-Time-Data href="report00070_files/editdata.mso">
<link rel=OLE-Object-Data href="report00070_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-09-05T08:27:25Z</o:LastPrinted>
  <o:Created>2009-09-05T06:58:25Z</o:Created>
  <o:LastSaved>2009-09-10T06:08:59Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.33in .19in .31in .2in;
	mso-header-margin:.24in;
	mso-footer-margin:.17in;
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
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl42
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl43
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;}
.xl44
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.4pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl48
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:#33CCCC;
	mso-pattern:auto none;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	}
.xl51
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:#33CCCC;
	mso-pattern:auto none;
	text-align:center;
	border:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:6.0pt;
	background:#33CCCC;
	mso-pattern:auto none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:6.0pt;
	background:#33CCCC;
	mso-pattern:auto none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.4pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:6.0pt;
	background:#33CCCC;
	mso-pattern:auto none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:silver;
	mso-pattern:auto none;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	}
.xl56
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:#33CCCC;
	background:silver;
	mso-pattern:auto none;
	border:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:6.0pt;
	background:silver;
	mso-pattern:auto none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:6.0pt;
	background:silver;
	mso-pattern:auto none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.4pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:6.0pt;
	background:silver;
	mso-pattern:auto none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
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
  <x:WindowHeight>8400</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1935</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1015 style='border-collapse:
 collapse;table-layout:fixed;width:763pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=53 span=2 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=44 style='mso-width-source:userset;mso-width-alt:1609;width:33pt'>
 <col width=44 style='mso-width-source:userset;mso-width-alt:1609;width:33pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=53 span=5 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=53 span=239 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=10 rowspan=4 height=68 class=xl26 width=530 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:51.0pt;width:398pt'><span
  style='mso-spacerun:yes'>  </span>PRINTING<span style='mso-spacerun:yes'> 
  </span>RESULT<span style='mso-spacerun:yes'>  </span>INQUIRY</td>
  <td colspan=2 class=xl47 width=80 style='border-right:.5pt solid black;
  border-left:none;width:60pt' x:str="Date ">Date<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=8 class=xl38 width=405 style='border-right:.5pt solid black;
  border-left:none;width:305pt'><%=l_dtfrom %><span style='mso-spacerun:yes'> 
  </span>~<span style='mso-spacerun:yes'>  </span><%=l_dtto %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl47 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none' x:str="Lot No ">Lot No<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=8 class=xl48 style='border-right:.5pt solid black;border-left:
  none'><%=l_lotno %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl47 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none' x:str="Vendor No ">Vendor No<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=8 class=xl48 style='border-right:.5pt solid black;border-left:
  none'><%=l_vendno %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl47 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Material No</td>
  <td colspan=8 class=xl48 style='border-right:.5pt solid black;border-left:
  none'><%=l_matno %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>Opera.Date</td>
  <td class=xl25>Mach.No</td>
  <td class=xl25>Start.Date</td>
  <td class=xl25>End.Date</td>
  <td class=xl25>Total.Time</td>
  <td class=xl25>Lot.No</td>
  <td class=xl25>Size</td>
  <td class=xl25>Vend.No</td>
  <td class=xl25>Vend.Name</td>
  <td class=xl25>Mat.No</td>
  <td class=xl25>Mat.Name</td>
  <td class=xl25>Drum</td>
  <td class=xl25>Inst.Qty</td>
  <td class=xl25>Print.Qty</td>
  <td class=xl25>Print.Type</td>
  <td class=xl25>Mach.Type</td>
  <td class=xl25>OP.ID</td>
  <td class=xl25>OP.Name</td>
  <td class=xl25>Dept.ID</td>
  <td class=xl25>Dept.Name</td>
 </tr>
 <%   
     decimal InstQty = 0, PrinQty = 0, InstQtyDate = 0, PrinQtyDate = 0;
     string dtime1 = "", dtime2 = "", dtime3="";
     int j, i;
     if (dt.Rows.Count > 0)
         dtime1 = dt.Rows[0][2].ToString();
     for (i = 0; i < dt.Rows.Count; i++)
     {
         InstQty += decimal.Parse(dt.Rows[i][14].ToString());
         PrinQty += decimal.Parse(dt.Rows[i][15].ToString());
         if (dtime1 == dt.Rows[i][2].ToString())
         {
             InstQtyDate += decimal.Parse(dt.Rows[i][14].ToString());
             PrinQtyDate += decimal.Parse(dt.Rows[i][15].ToString());
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'><%= dt.Rows[i][2].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i][3].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i][4].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i][5].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i][6].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][7].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][8].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:str><%= dt.Rows[i][9].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%= dt.Rows[i][10].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:str><%= dt.Rows[i][11].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%= dt.Rows[i][12].ToString()%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][13].ToString()%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][14].ToString()%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][15].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][17].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][18].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][19].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%= dt.Rows[i][20].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][21].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%= dt.Rows[i][22].ToString()%></td>
 </tr>
 <%
     }
     else
     {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl55 style='height:12.75pt;border-top:none'><%= dtime1%></td>
  <td class=xl56 style='border-top:none;border-left:none'></td>
  <td class=xl56 style='border-top:none;border-left:none'></td>
  <td class=xl56 style='border-top:none;border-left:none'></td>
  <td class=xl56 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl59 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%= InstQtyDate%></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%= PrinQtyDate%></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl59 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl59 style='border-top:none;border-left:none'></td>
 </tr>
  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'><%= dt.Rows[i][2].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i][3].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i][4].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i][5].ToString()%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i][6].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][7].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][8].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][9].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%= dt.Rows[i][10].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][11].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%= dt.Rows[i][12].ToString()%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][13].ToString()%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][14].ToString()%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt.Rows[i][15].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][17].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][18].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][19].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%= dt.Rows[i][20].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt.Rows[i][21].ToString()%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%= dt.Rows[i][22].ToString()%></td>
 </tr>
 <%             
     dtime1 = dt.Rows[i][2].ToString();            
     InstQtyDate = decimal.Parse(dt.Rows[i][14].ToString());
     PrinQtyDate = decimal.Parse(dt.Rows[i][15].ToString());
 }
}    
 %>    
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl55 style='height:12.75pt;border-top:none'><%= dtime1%></td>
  <td class=xl56 style='border-top:none;border-left:none'></td>
  <td class=xl56 style='border-top:none;border-left:none'></td>
  <td class=xl56 style='border-top:none;border-left:none'></td>
  <td class=xl56 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl59 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%= InstQtyDate%></td>
  <td class=xl58 style='border-top:none;border-left:none' x:num><%= PrinQtyDate%></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl59 style='border-top:none;border-left:none'></td>
  <td class=xl57 style='border-top:none;border-left:none'></td>
  <td class=xl59 style='border-top:none;border-left:none'></td>
 </tr>
             
  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl50 style='height:12.75pt;border-top:none'>Total</td>
  <td class=xl51 style='border-top:none;border-left:none'></td>
  <td class=xl51 style='border-top:none;border-left:none'></td>
  <td class=xl51 style='border-top:none;border-left:none'></td>
  <td class=xl51 style='border-top:none;border-left:none'></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl54 style='border-top:none;border-left:none'></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl51 style='border-top:none;border-left:none'></td>
  <td class=xl54 style='border-top:none;border-left:none'></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= InstQty%></td>
  <td class=xl53 style='border-top:none;border-left:none' x:num><%= PrinQty%></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl54 style='border-top:none;border-left:none'></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl54 style='border-top:none;border-left:none'></td>
 </tr>

 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl41 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl41 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=51 style='width:38pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=53 style='width:40pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
