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
    string p_item = Request.QueryString["p_item"]; 
    string p_wh_name = Request.QueryString["p_wh_name"]; 
    string para = " '" + p_tin_wh + "','" + p_from_date + "','" + p_to_date + "'"; 
            DataTable dt,dt1,dt2;
            dt = ESysLib.TableReadOpenCursor("lg_RPT_BImC00041", para);
            
            para = " '" + p_tin_wh + "','" + p_from_date + "','" + p_to_date + "','" + p_item + "' ";           
            dt1 = ESysLib.TableReadOpenCursor("lg_RPT_BImC00041_1", para);    
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM  tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM  tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    dt2 = ESysLib.TableReadOpen(str_sql);
    int count = 6, row_no = 7;        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bisc00020_1_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bisc00020_1_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bisc00020_1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-10-05T08:36:59Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-10-05T08:37:33Z</o:LastSaved>
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
	text-align:right;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl31
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
.xl32
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
.xl33
	{mso-style-parent:style0;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
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
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl43
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
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
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=986 style='border-collapse:
 collapse;table-layout:fixed;width:740pt'>
 <col class=xl25 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl25 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl25 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl25 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl25 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
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
 <col class=xl25 width=64 style='width:48pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 width=66 style='height:15.0pt;width:50pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:15.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt2.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl27 width=83 style='width:62pt'></td>
  <td class=xl27 align=left width=41 style='width:31pt'><%= dt2.Rows[0]["partner_name"]%></td>
  <td class=xl27 width=56 style='width:42pt'></td>
  <td class=xl26 width=69 style='width:52pt'></td>
  <td class=xl25 width=52 style='width:39pt'></td>
  <td class=xl42 width=59 style='width:44pt'></td>
  <td class=xl42 width=56 style='width:42pt'></td>
  <td class=xl42 width=73 style='width:55pt'></td>
  <td colspan=3 class=xl30 width=167 style='width:125pt'>Tel: <%= dt2.Rows[0]["phone_no"]%></td>
  <td class=xl42 width=71 style='width:53pt'></td>
  <td class=xl42 width=56 style='width:42pt'></td>
  <td class=xl25 width=73 style='width:55pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 align=left style='mso-ignore:colspan'><%= dt2.Rows[0]["addr1"]%></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl30 width=167 style='width:125pt'>Fax: <%= dt2.Rows[0]["fax_no"]%></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl26 colspan=2 align=left style='mso-ignore:colspan'>Tax code: <%= dt2.Rows[0]["tax_code"]%></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td class=xl43 width=59 style='width:44pt'>&nbsp;</td>
  <td class=xl43 width=56 style='width:42pt'>&nbsp;</td>
  <td class=xl43 width=73 style='width:55pt'>&nbsp;</td>
  <td colspan=3 class=xl31 width=167 style='width:125pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=12 height=48 class=xl32 width=722 style='height:36.0pt;
  width:542pt'>REPORT W/H CLOSING CHECKING</td>
  <td colspan=3 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <%if(dt.Rows.Count > 0)
   { %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl26 style='height:21.0pt'></td>
  <td class=xl26 colspan=3 align=left style='mso-ignore:colspan'>W/H Name :<font
  class="font6"> <%= dt.Rows[0]["wh_name"]%></font><font class="font5"><span
  style='mso-spacerun:yes'>  </span></font></td>
  <td class=xl26></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl28>Date:</td>
  <td class=xl29 colspan=3 style='mso-ignore:colspan'><%= dt.Rows[0]["t_month"] %></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%}
   else
   {
       row_no = 6; count = 5;
   } %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl36 width=66 style='height:24.0pt;width:50pt'>Item Code</td>
  <td class=xl36 width=83 style='border-left:none;width:62pt'>Item Name</td>
  <td class=xl36 width=41 style='border-left:none;width:31pt'>UOM</td>
  <td class=xl36 width=56 style='border-left:none;width:42pt'>U/Price</td>
  <td class=xl36 width=69 style='border-left:none;width:52pt'>Begin Qty</td>
  <td class=xl36 width=52 style='border-left:none;width:39pt'>Begin Amount</td>
  <td class=xl36 width=59 style='border-left:none;width:44pt'>In Qty</td>
  <td class=xl36 width=56 style='border-left:none;width:42pt'>In Amount</td>
  <td class=xl36 width=73 style='border-left:none;width:55pt'>Out Qty</td>
  <td class=xl36 width=56 style='border-left:none;width:42pt'>Out Amount</td>
  <td class=xl36 width=55 style='border-left:none;width:41pt'>End Qty</td>
  <td class=xl36 width=56 style='border-left:none;width:42pt'>End Amount</td>
  <td colspan=4 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <%for (int i = 0; i < dt1.Rows.Count; i++)
   {
 %>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl37 align=left style='height:14.25pt;border-top:none'><%= dt1.Rows[i]["item_code"]%></td>
  <td class=xl38 align=left width=83 style='border-top:none;border-left:none;
  width:62pt'><%= dt1.Rows[i]["item_name"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%= dt1.Rows[i]["uom"]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["unit_price"]%></td>
  <td class=xl41 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["begin_qty"]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["begin_amount"]%></td>
  <td class=xl41 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["in_qty"]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["in_amount"]%></td>
  <td class=xl41 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["out_qty"]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["out_amount"]%></td>
  <td class=xl41 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["end_qty"]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["end_amount"]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=4 height=25 class=xl34 style='height:18.75pt'>Total</td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>E<%= row_no %>:E<%= dt1.Rows.Count+count%><%}else{%>E9:E9<%}%>)"></td>
  <td class=xl45 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>F<%= row_no %>:F<%= dt1.Rows.Count+count%><%}else{%>F9:F9<%}%>)"></td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>G<%= row_no %>:G<%= dt1.Rows.Count+count%><%}else{%>G9:G9<%}%>)"></td>
  <td class=xl45 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>H<%= row_no %>:H<%= dt1.Rows.Count+count%><%}else{%>H9:H9<%}%>)"></td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>I<%= row_no %>:I<%= dt1.Rows.Count+count%><%}else{%>I9:I9<%}%>)"></td>
  <td class=xl45 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>J<%= row_no %>:J<%= dt1.Rows.Count+count%><%}else{%>J9:J9<%}%>)"></td>
  <td class=xl44 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>K<%= row_no %>:K<%= dt1.Rows.Count+count%><%}else{%>K9:K9<%}%>)"></td>
  <td class=xl45 align=right style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt1.Rows.Count > 0){%>L<%= row_no %>:L<%= dt1.Rows.Count+count%><%}else{%>L9:L9<%}%>)"></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=66 style='width:50pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
