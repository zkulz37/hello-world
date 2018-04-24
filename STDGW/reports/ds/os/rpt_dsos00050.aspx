﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
    
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_warehouse = Request.QueryString["p_ware_house"];
    string p_item_group = Request.QueryString["p_item_group"];
    string p_item = Request.QueryString["p_item"];
    string p_bal_yn = Request.QueryString["p_bal_yn"];
    DataTable dt, dt1;
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM comm.tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM comm.tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    dt = ESysLib.TableReadOpen(str_sql);
    dt1 = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsos00050", "'" + p_warehouse + "','" + p_item_group + "','" + p_item + "','" + p_bal_yn + "'");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsos00050_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsos00050_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsos00050_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Lee</o:Author>
  <o:LastAuthor>Trung</o:LastAuthor>
  <o:LastPrinted>2012-02-02T06:47:56Z</o:LastPrinted>
  <o:Created>2011-06-10T03:14:58Z</o:Created>
  <o:LastSaved>2012-02-02T06:50:19Z</o:LastSaved>
  <o:Company>Prive</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:0in .05in .37in .05in;
	mso-header-margin:0in;
	mso-footer-margin:.16in;
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
.style22
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
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
td
	{mso-style-parent:style0;
	padding:0px;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style22;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style22;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style22;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style22;
	color:black;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
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
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9450</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$6:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1329 style='border-collapse:
 collapse;table-layout:fixed;width:997pt'>
 <col class=xl25 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl25 width=91 span=5 style='mso-width-source:userset;mso-width-alt:
 3328;width:68pt'>
 <col class=xl25 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl25 width=205 style='mso-width-source:userset;mso-width-alt:7497;
 width:154pt'>
 <col class=xl25 width=90 span=3 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <col class=xl25 width=64 span=3 style='width:48pt'>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 width=100 style='height:18.0pt;width:75pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:4.5pt;margin-top:4.5pt;width:68.25pt;height:42pt;z-index:1'>
   <v:imagedata src="rpt_dsos00050_files/image001.jpg" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:6px;margin-top:6px;width:91px;
  height:56px'><img width=91 height=56 src="rpt_dsos00050_files/image002.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl26 width=100 style='height:18.0pt;width:75pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 width=91 style='width:68pt'><%=dt.Rows[0]["partner_name"]%></td>
  <td class=xl27 width=91 style='width:68pt'></td>
  <td class=xl27 width=91 style='width:68pt'></td>
  <td class=xl27 width=91 style='width:68pt'></td>
  <td class=xl27 width=91 style='width:68pt'></td>
  <td class=xl28 width=107 style='width:80pt'></td>
  <td class=xl28 width=205 style='width:154pt'></td>
  <td class=xl25 width=90 style='width:68pt'></td>
  <td class=xl27 colspan=2 width=180 style='mso-ignore:colspan;width:136pt'>Tel:
  <%=dt.Rows[0]["phone_no"]%></td>
  <td class=xl29 width=64 style='width:48pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 style='height:18.0pt'></td>
  <td class=xl27 colspan=4 style='mso-ignore:colspan'><%=dt.Rows[0]["addr1"]%></td>
  <td class=xl27></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>Fax: <%=dt.Rows[0]["fax_no"]%></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 style='height:18.0pt'></td>
  <td class=xl27 colspan=2 style='mso-ignore:colspan'>MST: <%=dt.Rows[0]["tax_code"]%></td>
  <td class=xl28></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'>Print Date: <%=DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=11 height=40 class=xl34 style='height:30.0pt'>Cons/Stock Shortage</td>
  <td class=xl25></td>
  <td class=xl31></td>
  <td class=xl29></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl32 style='height:21.0pt'></td>
  <td colspan=5 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl33 style='height:21.0pt'>Group</td>
  <td class=xl33 style='border-left:none'>Spec 01</td>
  <td class=xl33 style='border-left:none'>Spec 02</td>
  <td class=xl33 style='border-left:none'>Spec 03</td>
  <td class=xl33 style='border-left:none'>Spec 04</td>
  <td class=xl33 style='border-left:none'>Spec 05</td>
  <td class=xl33 style='border-left:none'>Item Code</td>
  <td class=xl33 style='border-left:none'>Item Name</td>
  <td class=xl33 style='border-left:none'>Stock Qty</td>
  <td class=xl33 style='border-left:none'>Req Qty</td>
  <td class=xl33 style='border-left:none'>Pre Qty</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <%
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
        %>
<tr class=xl28 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl39 width=100 style='height:27.0pt;border-top:none;
  width:75pt'><%=dt1.Rows[i]["grp_cd"] %></td>
  <td class=xl36 width=91 style='border-top:none;border-left:none;width:68pt'><%=dt1.Rows[i]["spec01"]%></td>
  <td class=xl36 width=91 style='border-top:none;border-left:none;width:68pt'><%=dt1.Rows[i]["spec02"]%></td>
  <td class=xl36 width=91 style='border-top:none;border-left:none;width:68pt'><%=dt1.Rows[i]["spec03"]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'><%=dt1.Rows[i]["spec04"]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'><%=dt1.Rows[i]["spec05"]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'><%=dt1.Rows[i]["item_code"]%></td>
  <td class=xl37 style='border-top:none;border-left:none'><%=dt1.Rows[i]["item_name"]%></td>
  <td class=xl38 align=right style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["stock_qty"]%></td>
  <td class=xl38 align=right style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["req_qty"]%></td>
  <td class=xl38 align=right style='border-top:none;border-left:none' x:num><%=dt1.Rows[i]["pre_stock"]%></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
        <% 
     }
      %>
 
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=100 style='width:75pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=205 style='width:154pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>