﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string p_tin_wh = Request.QueryString["p_tin_warehouse_pk"];
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];

    string para = " '" + p_tin_wh + "','" + p_from_date + "','" + p_to_date + "'";
    DataTable dt, dt1, dt2;
    dt = ESysLib.TableReadOpenCursor("LG_RPT_BIMC00042", para);

    para = " '" + p_tin_wh + "','" + p_from_date + "','" + p_to_date + "'";
    dt1 = ESysLib.TableReadOpenCursor("LG_RPT_BIMC00042_1", para);

    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    dt2 = ESysLib.TableReadOpen(str_sql);
   //----
    int count = dt.Rows.Count > 0 ? 6 : 5;
    int row_no = dt.Rows.Count > 0 ? 7 : 6;
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bisc00012_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bisc00012_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bisc00012_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-10-05T09:19:58Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-10-05T09:20:10Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.1in .1in .4in .1in;
	mso-header-margin:0in;
	mso-footer-margin:0in;}
.font5
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font6
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
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
.style21
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl30
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:right;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl37
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	text-align:center;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>210</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:WindowHeight>12825</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$6:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1033 style='border-collapse:
 collapse;table-layout:fixed;width:777pt'>
 <col class=xl25 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl25 width=142 style='mso-width-source:userset;mso-width-alt:5193;
 width:107pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl25 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl25 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl25 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl25 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl25 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 width=76 style='height:15.0pt;width:57pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:40.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt2.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl27 width=142 style='width:107pt'></td>
  <td class=xl27 width=61 style='width:46pt'><%= dt2.Rows[0]["partner_name"]%></td>
  <td class=xl27 width=65 style='width:49pt'></td>
  <td class=xl26 width=61 style='width:46pt'></td>
  <td class=xl25 width=65 style='width:49pt'></td>
  <td class=xl28 width=61 style='width:46pt'></td>
  <td colspan=3 class=xl36 width=191 style='width:144pt'>Tel: <%= dt2.Rows[0]["phone_no"]%></td>
  <td class=xl28 width=55 style='width:41pt'></td>
  <td class=xl28 width=56 style='width:42pt'></td>
  <td class=xl28 width=71 style='width:53pt'></td>
  <td class=xl28 width=56 style='width:42pt'></td>
  <td class=xl25 width=73 style='width:55pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl26><%= dt2.Rows[0]["addr1"]%></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td colspan=3 class=xl36 width=191 style='width:144pt'>Fax: <%= dt2.Rows[0]["fax_no"]%></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Tax code: <%= dt2.Rows[0]["tax_code"]%></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl29 width=61 style='width:46pt'>&nbsp;</td>
  <td colspan=3 class=xl37 width=191 style='width:144pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
 </tr>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=10 height=48 class=xl38 width=722 style='height:36.0pt;
  width:544pt'>REPORT W/H CLOSING CHECKING</td>
 </tr>
    <%
        for (int i = 0; i < dt.Rows.Count; i++)
        {
    %>
<tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl26 style='height:21.0pt'></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>W/H Name : <font
  class="font6"><%= dt.Rows[i]["wh_name"] %></font><font class="font5"><span
  style='mso-spacerun:yes'>  </span></font></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl32>Date:</td>
  <td class=xl33 colspan=3 style='mso-ignore:colspan'><%= dt.Rows[i]["t_month"] %></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
    <% } %>
 <tr height=28 style='height:21.0pt'>
  <td height=28 class=xl34 width=76 style='height:21.0pt;width:57pt'>Group CD</td>
  <td class=xl34 width=142 style='border-left:none;width:107pt'>Group NM</td>
  <td class=xl34 width=61 style='border-left:none;width:46pt'>Begin Qty</td>
  <td class=xl34 width=65 style='border-left:none;width:49pt'>Begin Amount</td>
  <td class=xl34 width=61 style='border-left:none;width:46pt'>In Qty</td>
  <td class=xl34 width=65 style='border-left:none;width:49pt'>In Amount</td>
  <td class=xl34 width=61 style='border-left:none;width:46pt'>Out Qty</td>
  <td class=xl34 width=65 style='border-left:none;width:49pt'>Out Amount</td>
  <td class=xl34 width=61 style='border-left:none;width:46pt'>End Qty</td>
  <td class=xl34 width=65 style='border-left:none;width:49pt'>End Amount</td>
  <td colspan=4 class=xl41 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
    <%for (int i = 0; i < dt1.Rows.Count; i++)
      {%>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl45 style='height:24.0pt;border-top:none'><%= dt1.Rows[i]["group_cd"]%></td>
  <td class=xl46 width=142 style='border-top:none;border-left:none;width:107pt'><%= dt1.Rows[i]["group_nm"]%></td>
  <td class=xl45 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["begin_qty"]%></td>
  <td class=xl47 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["begin_amount"]%></td>
  <td class=xl45 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["in_qty"]%></td>
  <td class=xl47 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["in_amount"]%></td>
  <td class=xl45 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["out_qty"]%></td>
  <td class=xl47 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["out_amount"]%></td>
  <td class=xl45 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["end_qty"]%></td>
  <td class=xl47 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["end_amount"]%></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
    <%} %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl39 style='border-right:.5pt solid black;
  height:18.75pt'>Total</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>C<%= row_no %>:C<%= dt1.Rows.Count+count%><%}else{%>C8:C8<%}%>)"></td>
  <td class=xl48 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>D<%= row_no %>:D<%= dt1.Rows.Count+count%><%}else{%>D8:D8<%}%>)"></td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>E<%= row_no %>:E<%= dt1.Rows.Count+count%><%}else{%>E8:E8<%}%>)"></td>
  <td class=xl48 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>F<%= row_no %>:F<%= dt1.Rows.Count+count%><%}else{%>F8:F8<%}%>)"></td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>G<%= row_no %>:G<%= dt1.Rows.Count+count%><%}else{%>G8:G8<%}%>)"></td>
  <td class=xl48 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>H<%= row_no %>:H<%= dt1.Rows.Count+count%><%}else{%>H8:H8<%}%>)"></td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>I<%= row_no %>:I<%= dt1.Rows.Count+count%><%}else{%>I8:I8<%}%>)"></td>
  <td class=xl48 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>J<%= row_no %>:J<%= dt1.Rows.Count+count%><%}else{%>J8:J8<%}%>)"></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=76 style='width:57pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=73 style='width:55pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
