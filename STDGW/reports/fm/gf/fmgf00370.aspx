<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string ls_compk = "";
	string ls_from_dt = "", ls_to_dt = "";
	ls_compk = Request["company_pk"];
	ls_from_dt = Request["from_dt"]; 
	ls_to_dt = Request["to_dt"];
	string ls_param = "";
	ls_param = "'" + ls_compk + "', '" + ls_from_dt + "', '" + ls_to_dt + "', '', '', ''" ;
	DataTable dt = ESysLib.TableReadOpenCursor("acnt.sp_sel_fmgf00370", ls_param);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Rpt_Return%20Goods_files/filelist.xml">
<link rel=Edit-Time-Data href="Rpt_Return%20Goods_files/editdata.mso">
<link rel=OLE-Object-Data href="Rpt_Return%20Goods_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2010-04-17T08:18:11Z</o:LastPrinted>
  <o:Created>2010-04-17T08:10:47Z</o:Created>
  <o:LastSaved>2010-04-17T08:20:53Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .25in 1.0in .25in;
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
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
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
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10065</x:WindowHeight>
  <x:WindowWidth>17145</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=728 style='border-collapse:
 collapse;table-layout:fixed;width:547pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <col width=207 style='mso-width-source:userset;mso-width-alt:7570;width:155pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=150 style='mso-width-source:userset;mso-width-alt:5485;width:113pt'>
 <col width=64 span=3 style='width:48pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 width=101 style='height:12.75pt;mso-ignore:colspan;
  width:76pt'>Công Ty TNHH SUHEUNG Việt Nam</td>
  <td width=207 style='width:155pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=150 style='width:113pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'>KCN Long Thành, xã Tam An, huyện Long Thành, tỉnh Đồng Nai</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td colspan=8 height=31 class=xl24 style='height:23.25pt'>RETURN GOODS</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl26 style='height:25.5pt'>No</td>
  <td colspan=2 class=xl27 style='border-left:none'>Product</td>
  <td colspan=2 class=xl27 style='border-left:none'>Customer</td>
  <td colspan=2 class=xl30 style='border-right:.5pt solid black;border-left:
  none'>Qty</td>
  <td class=xl28></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none;border-left:
  none'>Code</td>
  <td class=xl27 style='border-top:none;border-left:none'>Name of goods</td>
  <td class=xl27 style='border-top:none;border-left:none'>Code</td>
  <td class=xl27 style='border-top:none;border-left:none' x:str>Name<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29 style='border-left:none'>Qty</td>
  <td class=xl29 style='border-left:none'>Amount</td>
  <td class=xl28></td>
 </tr>
 <%
	int i;
	decimal l_tot_qty = 0;
	decimal l_tot_amt = 0;
	for(i = 0; i < dt.Rows.Count; i++)
	{
 %>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][6]%></td>
  <td class=xl32 align=right x:num><%=dt.Rows[i][7]%></td>
  <td class=xl28></td>
 </tr>
 <%
		l_tot_qty += decimal.Parse(dt.Rows[i][6].ToString());
		l_tot_amt += decimal.Parse(dt.Rows[i][7].ToString());
	}
 %>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl38 style='border-right:.5pt solid black;
  height:12.75pt'>Total</td>
  <td colspan=3 class=xl35 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl34 align=right style='border-top:none;border-left:none'
  x:num><%=l_tot_qty%></td>
  <td class=xl34 align=right style='border-top:none;border-left:none'
  x:num><%=l_tot_amt%></td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=207 style='width:155pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=150 style='width:113pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
