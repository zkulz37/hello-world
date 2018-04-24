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
                string p_Level_Pk = Request["Level_Pk"];
                string p_Project_Pk = Request["Project_Pk"];
                string p_Field = Request["Field"];
                string p_Version = Request["Version"];
                string p_Confirm_YN = Request["Confirm_YN"];
                string l_parameter = "'" + p_Project_Pk + "', ";
                l_parameter += "'" + p_Field + "', ";
                l_parameter += "'" + p_Level_Pk + "', ";
                l_parameter += "'" + p_Version + "', ";
                l_parameter += "'" + p_Confirm_YN + "' ";

                DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_kpbp122_rpt", l_parameter);
                if (dt.Rows.Count == 0)
                {
                    Response.Write("There is no data!!");
                    Response.End();
                }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="aaaaaaa_files/filelist.xml">
<link rel=Edit-Time-Data href="aaaaaaa_files/editdata.mso">
<link rel=OLE-Object-Data href="aaaaaaa_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>LONG</o:Author>
  <o:LastAuthor>kenzie</o:LastAuthor>
  <o:LastPrinted>2011-06-23T02:05:41Z</o:LastPrinted>
  <o:Created>2011-01-12T03:58:08Z</o:Created>
  <o:LastSaved>2011-06-23T02:10:37Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.53in .5in .51in 0in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;
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
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
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
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
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
      <x:Scale>42</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>8</x:SplitVertical>
     <x:LeftColumnRightPane>8</x:LeftColumnRightPane>
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
       <x:ActiveRow>3</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>23</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6360</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1485</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2378 style='border-collapse:
 collapse;table-layout:fixed;width:1787pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=134 style='mso-width-source:userset;mso-width-alt:4900;width:101pt'>
 <col width=127 style='mso-width-source:userset;mso-width-alt:4644;width:95pt'>
 <col width=34 style='mso-width-source:userset;mso-width-alt:1243;width:26pt'>
 <col width=215 style='mso-width-source:userset;mso-width-alt:7862;width:161pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=135 style='mso-width-source:userset;mso-width-alt:4937;width:101pt'>
 <col width=118 style='mso-width-source:userset;mso-width-alt:4315;width:89pt'>
 <col width=145 span=8 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=64 style='height:12.75pt;width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
 </tr>
 <tr height=45 style='height:33.75pt'>
  <td colspan=19 height=45 class=xl42 style='height:33.75pt'>CONTRACT DETAILS EXCEL UPLOAD</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'>Seq. No.</td>
  <td class=xl25>Level</td>
  <td class=xl25>Level Code</td>
  <td class=xl25>Details Seq. No.</td>
  <td class=xl25>Contract Details No.</td>
  <td class=xl25>Details Description</td>
  <td class=xl25>Ccy</td>
  <td class=xl25>Name</td>
  <td class=xl25>Standard</td>
  <td class=xl25>Unit</td>
  <td class=xl26>Contract Quantity</td>
  <td class=xl26>Raw Mtrl. Cost U/P</td>
  <td class=xl26>Raw Mtrl. Cost Amt</td>
  <td class=xl26>Labor Cost U/P</td>
  <td class=xl26>Labor Cost Amt</td>
  <td class=xl26>Exp. U/P</td>
  <td class=xl26>Exp. Amt</td>
  <td class=xl25>Unit Price</td>
  <td class=xl25>Contract Amt</td>
 </tr>
 <%
     int i = 0;
     decimal _M_Amt = 0;
     decimal _L_Amt = 0;
     decimal _E_Amt = 0;
     decimal _Tot_Amt = 0;
     for (i = 0; i < dt.Rows.Count; i++)
     {
         if (dt.Rows[i][12].ToString().Trim() != "")
         {
             _M_Amt += decimal.Parse(dt.Rows[i][12].ToString());
         }
         else
         {
             _M_Amt += 0;
         }
         //===================================================
         if (dt.Rows[i][14].ToString().Trim() != "")
         {
             _L_Amt += decimal.Parse(dt.Rows[i][14].ToString());
         }
         else
         {
             _L_Amt += 0;
         }
         //===================================================
         if (dt.Rows[i][16].ToString().Trim() != "")
         {
             _E_Amt += decimal.Parse(dt.Rows[i][16].ToString());
         }
         else
         {
             _E_Amt += 0;
         }
         //===================================================
         if (dt.Rows[i][18].ToString().Trim() != "")
         {
             _Tot_Amt += decimal.Parse(dt.Rows[i][18].ToString());
         }
         else
         {
             _Tot_Amt += 0;
         }
      %>
 <tr class=xl33 height=23 style='mso-height-source:auto;height:17.25pt'>
  <td height=23 class=xl30 style='height:17.25pt' x:num><%=dt.Rows[i][0]%></td>
  <td class=xl31><%=dt.Rows[i][1]%></td>
  <td class=xl27><%=dt.Rows[i][2]%></td>
  <td class=xl31 x:num><%=dt.Rows[i][3]%></td>
  <td class=xl31 x:num><%=dt.Rows[i][4]%></td>
  <td class=xl27><%=dt.Rows[i][5]%></td>
  <td class=xl27><%=dt.Rows[i][6]%></td>
  <td class=xl32 width=215 style='width:161pt'><%=dt.Rows[i][7]%></td>
  <td class=xl28><%=dt.Rows[i][8]%></td>
  <td class=xl34><%=dt.Rows[i][9]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][10]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][11]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][12]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][13]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][14]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][15]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][16]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][17]%></td>
  <td class=xl29 x:num><%=dt.Rows[i][18]%></td>
 </tr>
 <%} %>
 <tr class=xl38 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=8 height=23 class=xl35 style='height:17.25pt'>Grand Total</td>
  <td class=xl40 style='border-top:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 align=right style='border-top:none;border-left:none'  x:num><%=_M_Amt%></td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 align=right style='border-top:none;border-left:none'  x:num><%=_L_Amt%></td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 align=right style='border-top:none;border-left:none'  x:num><%=_E_Amt%></td>
  <td class=xl37 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 align=right style='border-top:none;border-left:none'  x:num><%=_Tot_Amt%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=127 style='width:95pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
