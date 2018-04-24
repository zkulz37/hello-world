<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_ts2_line_result_m_pk = Request.QueryString["p_ts2_line_result_m_pk"];
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fpps00050_files/filelist.xml">
<link rel=Edit-Time-Data href="fpps00050_files/editdata.mso">
<link rel=OLE-Object-Data href="fpps00050_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Lee</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:Created>2010-11-09T03:32:56Z</o:Created>
  <o:LastSaved>2010-11-15T07:07:52Z</o:LastSaved>
  <o:Company>Prive</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>18</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>18795</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>345</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1560 style='border-collapse:
 collapse;table-layout:fixed;width:1170pt'>
 <col width=64 style='width:48pt'>
 <col width=68 span=22 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <tr height=35 style='height:26.25pt'>
  <td height=35 width=64 style='height:26.25pt;width:48pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td class=xl24 colspan=8 width=544 style='mso-ignore:colspan;width:408pt'>HOURLY
  SEWING RESULT BY STYLE</td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td height=35 colspan=5 style='height:26.25pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=9 style='mso-ignore:colspan'
  x:str="( K&#7870;T QU&#7842; MAY HÀNG GI&#7900; THEO STYLE) ">( K&#7870;T
  QU&#7842; MAY HÀNG GI&#7900; THEO STYLE)<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td height=35 colspan=5 style='height:26.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=15 style='mso-ignore:colspan'></td>
 </tr>
  <%
        string para = "'" + p_ts2_line_result_m_pk + "'";
        DataTable dt1 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpps00050", para);
        DataTable dt2 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpps00050_1", para);
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>FAC</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'><%= dt1.Rows[0]["factory"]%></td>
  <td class=xl25>LINE</td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'><%= dt1.Rows[0]["line"]%></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>STYLE</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'><%= dt1.Rows[0]["style"]%></td>
  <td class=xl25>COLOR</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'><%= dt1.Rows[0]["color"]%></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>PLAN QTY</td>
  <td class=xl25><%= dt1.Rows[0]["plan_qty"]%></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>SEWING SUM QTY</td>
  <td colspan=7 style='mso-ignore:colspan'><%= dt1.Rows[0]["sewing_qty"]%></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=15 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl27 style='height:35.25pt'>SIZE</td>
  <td colspan=2 class=xl33 style='border-left:none'>SUM</td>
  <td colspan=2 class=xl32 style='border-left:none'>7:30~8:29</td>
  <td colspan=2 class=xl32 style='border-left:none'>8:30~9:29</td>
  <td colspan=2 class=xl32 style='border-left:none'>9:30~10:29</td>
  <td colspan=2 class=xl32 style='border-left:none'>10:30~11:29</td>
  <td colspan=2 class=xl32 style='border-left:none'>12:30~13:29</td>
  <td colspan=2 class=xl32 style='border-left:none'>13:30~14:29</td>
  <td colspan=2 class=xl32 style='border-left:none'>14:30~15:29</td>
  <td colspan=2 class=xl32 style='border-left:none'>15:30~16:29</td>
  <td colspan=2 class=xl32 style='border-left:none'>16:30~18:20</td>
  <td colspan=2 class=xl32 style='border-left:none'>18:50~20:20</td>
 </tr>
<%
    int Prod_7_8 = 0;
    int Def_7_8 = 0;
    //----
    int Prod_8_9 = 0;
    int Def_8_9 = 0;
    //-----
    int Prod_9_10 = 0;
    int Def_9_10 = 0;
    //-----
    int Prod_10_11 = 0;
    int Def_10_11 = 0;
    //-----
    int Prod_11_13 = 0;
    int Def_11_13 = 0;
    //-----
    int Prod_13_14 = 0;
    int Def_13_14 = 0;
    //-----
    int Prod_14_15 = 0;
    int Def_14_15 = 0;
    //-----
    int Prod_15_16 = 0;
    int Def_15_16 = 0;
    //-----
    int Prod_16_18 = 0;
    int Def_16_18 = 0;
    //-----
    int Prod_18_20 = 0;
    int Def_18_20 = 0;
    //-----
    int Total_Prod = 0, Total_Def = 0;
    for (int j = 0; j < dt2.Rows.Count; j++)
    {
 %>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl27 style='height:35.25pt;border-top:none' x:string><%= dt2.Rows[j]["spec_seq"].ToString() + dt2.Rows[j]["spec_id"].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_total"]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_total"]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_7_8"]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_7_8"]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_8_9"]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_8_9"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_9_10"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_9_10"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_10_11"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_10_11"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_11_13"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_11_13"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_13_14"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_13_14"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_14_15"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_14_15"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_15_16"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_15_16"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_16_18"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_16_18"]%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["prod_18_20"]%></td>
  <td class=xl30 align=right style='border-top:none;border-left:none' x:num><%= dt2.Rows[j]["def_18_20"]%></td>
 </tr>
 <% 
     Prod_7_8   += Convert.ToInt32(dt2.Rows[j]["prod_7_8"]);
     Prod_8_9   += Convert.ToInt32(dt2.Rows[j]["prod_8_9"]);
     Prod_9_10  += Convert.ToInt32(dt2.Rows[j]["prod_9_10"]);
     Prod_10_11 += Convert.ToInt32(dt2.Rows[j]["prod_10_11"]);
     Prod_11_13 += Convert.ToInt32(dt2.Rows[j]["prod_11_13"]);
     Prod_13_14 += Convert.ToInt32(dt2.Rows[j]["prod_13_14"]);
     Prod_14_15 += Convert.ToInt32(dt2.Rows[j]["prod_14_15"]);
     Prod_15_16 += Convert.ToInt32(dt2.Rows[j]["prod_15_16"]);
     Prod_16_18 += Convert.ToInt32(dt2.Rows[j]["prod_16_18"]);
     Prod_18_20 += Convert.ToInt32(dt2.Rows[j]["prod_18_20"]);
        //-------------
     Def_7_8   += Convert.ToInt32(dt2.Rows[j]["def_7_8"]); 
     Def_8_9   += Convert.ToInt32(dt2.Rows[j]["def_8_9"]);
     Def_9_10  += Convert.ToInt32(dt2.Rows[j]["def_9_10"]);
     Def_10_11 += Convert.ToInt32(dt2.Rows[j]["def_10_11"]);
     Def_11_13 += Convert.ToInt32(dt2.Rows[j]["def_11_13"]);
     Def_13_14 += Convert.ToInt32(dt2.Rows[j]["def_13_14"]);
     Def_14_15 += Convert.ToInt32(dt2.Rows[j]["def_14_15"]);
     Def_15_16 += Convert.ToInt32(dt2.Rows[j]["def_15_16"]);
     Def_16_18 += Convert.ToInt32(dt2.Rows[j]["def_16_18"]);
     Def_18_20 += Convert.ToInt32(dt2.Rows[j]["def_18_20"]);
        //-----------        
     Total_Prod += Convert.ToInt32(dt2.Rows[j]["prod_total"]);
     Total_Def += Convert.ToInt32(dt2.Rows[j]["def_total"]); 
    } %>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl27 style='height:35.25pt;border-top:none'>TOTAL</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><%= Total_Prod %></td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><%= Total_Def %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Prod_7_8 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Def_7_8 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Prod_8_9 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Def_8_9 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Prod_9_10 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Def_9_10 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Prod_10_11 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Def_10_11 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Prod_11_13 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Def_11_13 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Prod_13_14 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Def_13_14 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Prod_14_15 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Def_14_15 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Prod_15_16 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Def_15_16 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Prod_16_18 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Def_16_18 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Prod_18_20 %></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%= Def_18_20 %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
