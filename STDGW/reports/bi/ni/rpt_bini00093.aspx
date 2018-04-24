<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
	string p_in_type = Request.QueryString["p_in_type"];
	string p_from_date = Request.QueryString["p_from_date"];
	string p_to_date = Request.QueryString["p_to_date"];
	string ccy = Request.QueryString["ccy"];
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Stock%20Incoming%20Checking_files/filelist.xml">
<link rel=Edit-Time-Data href="Stock%20Incoming%20Checking_files/editdata.mso">
<link rel=OLE-Object-Data href="Stock%20Incoming%20Checking_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-03-29T07:17:51Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-03-29T07:30:06Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
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
	color:purple;
	font-size:22.0pt;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"Short Date";
	text-align:center;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>17</x:ActiveCol>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1766 style='border-collapse:
 collapse;table-layout:fixed;width:1328pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=208 style='mso-width-source:userset;mso-width-alt:7606;width:156pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=64 style='width:48pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=45 style='mso-width-source:userset;mso-width-alt:1645;width:34pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=149 style='mso-width-source:userset;mso-width-alt:5449;width:112pt'>
 <col width=64 style='width:48pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td colspan=20 height=46 class=xl24 width=1766 style='height:34.5pt;
  width:1328pt'>STOCK INCOMING CHECKING</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=20 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl32 style='height:20.25pt'>WH ID</td>
  <td class=xl32 style='border-left:none'>Date</td>
  <td class=xl32 style='border-left:none'>Slip No</td>
  <td class=xl32 style='border-left:none'>In Type</td>
  <td class=xl32 style='border-left:none'>Ref No</td>
  <td class=xl32 style='border-left:none'>Seq</td>
  <td class=xl32 style='border-left:none'>Item Code</td>
  <td class=xl32 style='border-left:none'>Item Name</td>
  <td class=xl32 style='border-left:none'>In Qty</td>
  <td class=xl32 style='border-left:none'>UOM</td>
  <td class=xl32 style='border-left:none'>Unit Price</td>
  <td class=xl32 style='border-left:none'>Item Amt</td>
  <td class=xl32 style='border-left:none'>Vat Rate</td>
  <td class=xl32 style='border-left:none'>Vat Amt</td>
  <td class=xl32 style='border-left:none'>Total Amt</td>
  <td class=xl32 style='border-left:none'>CCY</td>
  <td class=xl32 style='border-left:none' x:str="Dis Amt ">Dis Amt<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl32 style='border-left:none'>Partner Name</td>
  <td class=xl32 style='border-left:none'>PL</td>
  <td class=xl32 style='border-left:none'>Description</td>
 </tr>
 <%   
     string para = " '" + p_from_date + "','" + p_to_date + "','" + ccy + "','" + p_in_type + "'";;
     DataTable dt;
     dt = ESysLib.TableReadOpenCursor("lg_rpt_bini00090_1", para);
     if (dt.Rows.Count == 0) { Response.Write("There is no data"); Response.End(); }
     for (int i = 0; i < dt.Rows.Count; i++)
     {      
%>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none'><%=dt.Rows[i]["wh_id"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=System.DateTime.ParseExact(dt.Rows[i]["in_date"].ToString(), "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["slip_no"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["in_type"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["ref_no"].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:num><%=dt.Rows[i]["seq"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["item_code"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["item_name"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>   </span><%=dt.Rows[i]["in_qty"].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i]["in_uom"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt.Rows[i]["unit_price"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%=dt.Rows[i]["item_amount"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt.Rows[i]["vat_rate"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%=dt.Rows[i]["vat_amount"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt.Rows[i]["total_amount"].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i]["ccy"].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dt.Rows[i]["dis_amount"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["partner_name"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["pl"].ToString()%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i]["description"].ToString()%></td>
 </tr>
    <% } %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(I4:I<%= dt.Rows.Count + 3 %>)"></td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(K4:K<%= dt.Rows.Count + 3 %>)"></td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(M4:M<%= dt.Rows.Count + 3 %>)"></td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(N4:N<%= dt.Rows.Count + 3 %>)"></td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(O4:O<%= dt.Rows.Count + 3 %>)"></td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(I4:I<%= dt.Rows.Count + 3 %>)"></td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(Q4:Q<%= dt.Rows.Count + 3 %>)"></td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=96 style='width:72pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=208 style='width:156pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=149 style='width:112pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=89 style='width:67pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
