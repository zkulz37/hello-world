<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("ec111");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
        string p_Project_Pk = Request["Project_Pk"];
        string p_Year = Request["Year"];
        string p_Budget_Pk = Request["Budget_Pk"];
        string l_parameter = "'" + p_Project_Pk + "', ";
        l_parameter += "'" + p_Year + "', ";
        l_parameter += "'" + p_Budget_Pk + "' ";
        DataTable dt = ESysLib.TableReadOpenCursor("ec111.sp_sel_kpbp612", l_parameter);
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="6.1.2_files/filelist.xml">
<link rel=Edit-Time-Data href="6.1.2_files/editdata.mso">
<link rel=OLE-Object-Data href="6.1.2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>kenzie</o:Author>
  <o:LastAuthor>kenzie</o:LastAuthor>
  <o:LastPrinted>2011-06-23T10:09:08Z</o:LastPrinted>
  <o:Created>2011-06-23T09:21:50Z</o:Created>
  <o:LastSaved>2011-06-23T10:11:02Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.51in .5in .51in 0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	font-size:36.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;}
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
      <x:Scale>43</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
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
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9720</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2465 style='border-collapse:
 collapse;table-layout:fixed;width:1857pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt'>
 <col width=250 style='mso-width-source:userset;mso-width-alt:9142;width:188pt'>
 <col width=138 span=15 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <tr height=60 style='height:45.0pt'>
  <td colspan=18 height=60 class=xl24 width=2298 style='height:45.0pt;
  width:1730pt'>Inputed Actual Cost Search</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>

 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>Budget Code</td>
  <td height=20 class=xl25 style='height:15.0pt'>Budget Name</td>
  <td class=xl25 style='border-left:none'>Budget Amt.(A)</td>
  <td class=xl25 style='border-left:none'>Accu. Amt. (B)</td>
  <td class=xl25 style='border-left:none'>Balance(A-B)</td>
  <td class=xl25 style='border-left:none'>This year(<%=p_Year%>)</td>
  <td class=xl26 style='border-left:none'>01/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>02/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>03/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>04/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>05/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>06/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>07/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>08/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>09/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>10/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>11/<%=p_Year%></td>
  <td class=xl26 style='border-left:none'>12/<%=p_Year%></td>
 </tr>
 <%
     //Response.Write("");
     //Response.End();
     int i = 0;
     decimal _1=0, _2=0, _3=0, _4=0, _5=0, _6=0, _7=0, _8=0, _9=0, _10=0, _11=0, _12=0, _13=0, _14=0, _15=0,_16=0;
     for (i = 0; i < dt.Rows.Count; i++)
     {
         if (dt.Rows[i][2].ToString().Trim() != "")
         {
             _1 += decimal.Parse(dt.Rows[i][2].ToString());
         }
         else
         {
             _1 += 0;
         }
         //==================================================================
         if (dt.Rows[i][3].ToString().Trim() != "")
         {
             _2 += decimal.Parse(dt.Rows[i][3].ToString());
         }
         else
         {
             _2 += 0;
         }
         //==================================================================
         if (dt.Rows[i][4].ToString().Trim() != "")
         {
             _3 += decimal.Parse(dt.Rows[i][4].ToString());
         }
         else
         {
             _3 += 0;
         }
         //==================================================================
         if (dt.Rows[i][5].ToString().Trim() != "")
         {
             _4 += decimal.Parse(dt.Rows[i][5].ToString());
         }
         else
         {
             _4 += 0;
         }
         //==================================================================
         if (dt.Rows[i][6].ToString().Trim() != "")
         {
             _5 += decimal.Parse(dt.Rows[i][6].ToString());
         }
         else
         {
             _5 += 0;
         }
         //==================================================================
         if (dt.Rows[i][7].ToString().Trim() != "")
         {
             _6 += decimal.Parse(dt.Rows[i][7].ToString());
         }
         else
         {
             _6 += 0;
         }
         //==================================================================
         if (dt.Rows[i][8].ToString().Trim() != "")
         {
             _7 += decimal.Parse(dt.Rows[i][8].ToString());
         }
         else
         {
             _7 += 0;
         }
         //==================================================================
         if (dt.Rows[i][9].ToString().Trim() != "")
         {
             _8 += decimal.Parse(dt.Rows[i][9].ToString());
         }
         else
         {
             _8 += 0;
         }
         //==================================================================
         if (dt.Rows[i][10].ToString().Trim() != "")
         {
             _9 += decimal.Parse(dt.Rows[i][10].ToString());
         }
         else
         {
             _9 += 0;
         }
         //==================================================================
         if (dt.Rows[i][11].ToString().Trim() != "")
         {
             _10 += decimal.Parse(dt.Rows[i][11].ToString());
         }
         else
         {
             _10 += 0;
         }
         //==================================================================
         if (dt.Rows[i][12].ToString().Trim() != "")
         {
             _11 += decimal.Parse(dt.Rows[i][12].ToString());
         }
         else
         {
             _11 += 0;
         }
         //==================================================================
         if (dt.Rows[i][13].ToString().Trim() != "")
         {
             _12 += decimal.Parse(dt.Rows[i][13].ToString());
         }
         else
         {
             _12 += 0;
         }
         //==================================================================
         if (dt.Rows[i][14].ToString().Trim() != "")
         {
             _13 += decimal.Parse(dt.Rows[i][14].ToString());
         }
         else
         {
             _13 += 0;
         }
         //==================================================================
         if (dt.Rows[i][15].ToString().Trim() != "")
         {
             _14 += decimal.Parse(dt.Rows[i][15].ToString());
         }
         else
         {
             _14 += 0;
         }
         //==================================================================
         if (dt.Rows[i][16].ToString().Trim() != "")
         {
             _15 += decimal.Parse(dt.Rows[i][16].ToString());
         }
         else
         {
             _15 += 0;
         }
		 //==================================================================
         if (dt.Rows[i][17].ToString().Trim() != "")
         {
             _16 += decimal.Parse(dt.Rows[i][17].ToString());
         }
         else
         {
             _16 += 0;
         }
         
      %>
 <tr class=xl30 height=20 style='mso-height-source:auto;height:15.0pt'>
  <td height=20 class=xl28 width=215 style='height:15.0pt;border-top:none;  width:161pt'><%=dt.Rows[i][0]%></td>
  <td height=20 class=xl28 width=215 style='height:15.0pt;border-top:none;  width:161pt'><%=dt.Rows[i][1]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][2]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][3]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][4]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][5]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][6]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][7]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][8]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][9]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][10]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][11]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][12]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][13]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][14]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][15]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][16]%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][17]%></td>
  
 </tr>
 <%} %>
 <tr class=xl32 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 colspan="2" style='height:15.0pt;border-top:none'>Grand Total</td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_1%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_2%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_3%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_4%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_5%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_6%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_7%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_8%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_9%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_10%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_11%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_12%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_13%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_14%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_15%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=_16%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=215 style='width:161pt'></td>
  <td width=151 style='width:113pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=138 style='width:104pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
