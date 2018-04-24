<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_company = Request["company"];
    string p_month = Request["month"];
    string p_depr_ac_pk = Request["depr_ac_pk"];
    string p_expe_ac_pk = Request["expe_ac_pk"];
    string p_abtrtype_pk = Request["abtrtype_pk"];
    string p_type = Request["type"];
    string p_asset = Request["asset"];

    string l_parameter = "'" + p_company + "', ";
    l_parameter += "'" + p_month + "', ";
    l_parameter += "'" + p_depr_ac_pk + "', ";
    l_parameter += "'" + p_expe_ac_pk + "', ";
    l_parameter += "'" + p_abtrtype_pk + "', ";
    l_parameter += "'" + p_type + "', ";
    l_parameter += "'" + p_asset + "' ";

    DataTable dt = ESysLib.TableReadOpenCursor("ACNT.SP_SEL_FA_DEPRECIATED_chg", l_parameter);
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
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>kenzie</o:Author>
  <o:LastAuthor>kenzie</o:LastAuthor>
  <o:LastPrinted>2011-06-30T09:26:22Z</o:LastPrinted>
  <o:Created>2011-06-30T06:53:05Z</o:Created>
  <o:LastSaved>2011-06-30T09:29:41Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.51in .26in .51in 0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style16;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
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
      <x:Scale>63</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1123 style='border-collapse:
 collapse;table-layout:fixed;width:843pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=250 style='mso-width-source:userset;mso-width-alt:9142;width:188pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=89 span=2 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col width=131 span=4 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=110 style='height:12.75pt;width:83pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
 </tr>
 <tr height=50 style='height:37.5pt'>
  <td colspan=9 height=50 class=xl32 style='height:37.5pt'>Depreciation Change</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl25 style='height:15.0pt'>Asset</td>
  <td rowspan=2 class=xl25>Kind</td>
  <td colspan=2 class=xl25 style='border-left:none'>Account Code</td>
  <td rowspan=2 class=xl25>Original</td>
  <td rowspan=2 class=xl25>Depr. Amount</td>
  <td rowspan=2 class=xl25>Accumulation</td>
  <td rowspan=2 class=xl25>Remain</td>
 </tr>
 <tr class=xl24 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl25 style='height:14.1pt;border-top:none'>Code</td>
  <td class=xl25 style='border-top:none;border-left:none'>Name</td>
  <td class=xl25 style='border-top:none;border-left:none'>Depreciation</td>
  <td class=xl25 style='border-top:none;border-left:none'>Expense</td>
 </tr>
 <%
     decimal _1 = 0, _2 = 0, _3 = 0, _4 = 0;
     int i = 0;
     for (i = 1; i < dt.Rows.Count;i++)
     {
         if (dt.Rows[i][7].ToString().Trim() != "")
         {
             _1 += decimal.Parse(dt.Rows[i][7].ToString());
         }
         else
         {
             _1 += 0;
         }

         if (dt.Rows[i][11].ToString().Trim() != "")
         {
             _2 += decimal.Parse(dt.Rows[i][11].ToString());
         }
         else
         {
             _2 += 0;
         }

         if (dt.Rows[i][13].ToString().Trim() != "")
         {
             _3 += decimal.Parse(dt.Rows[i][13].ToString());
         }
         else
         {
             _3 += 0;
         }

         if (dt.Rows[i][15].ToString().Trim() != "")
         {
             _4 += decimal.Parse(dt.Rows[i][15].ToString());
         }
         else
         {
             _4 += 0;
         }
      %>
 <tr class=xl26 height=20 style='mso-height-source:auto;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none' x:num><%=dt.Rows[i][1]%></td>
  <td class=xl28 width=250 style='border-top:none;border-left:none;width:188pt'><%=dt.Rows[i][2]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][7]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][11]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][13]%></td>
  <td class=xl31 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][15]%></td>
 </tr>
 <%} %>
 <tr class=xl37 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl33 style='border-right:.5pt solid black;  height:15.0pt'>Total</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 align=right style='border-top:none;border-left:none'  x:num><%=_1%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none'  x:num><%=_2%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none'  x:num><%=_3%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none'  x:num><%=_4%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=110 style='width:83pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
