<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string p_master_pk = Request.QueryString["p_master_pk"];
    string p_wh_name = Request.QueryString["p_wh_name"];
	DataTable dt     = ESysLib.TableReadOpenCursor("lg_rpt_bias00040", "'" + p_master_pk + "'");
    DataTable dt2    = ESysLib.TableReadOpenCursor("lg_rpt_bias00040_1", "'" + p_master_pk + "'");      
    
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    DataTable dt1 = ESysLib.TableReadOpen(str_sql);	    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_bias00040_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bias00040_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bias00040_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-10-11T03:22:54Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-10-11T03:22:56Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.1in .1in .25in .1in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
.font9
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:9.0pt;
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
.style47
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
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style47;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl43
	{mso-style-parent:style47;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	color:red;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
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
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
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
  <x:WindowHeight>6930</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1175 style='border-collapse:
 collapse;table-layout:fixed;width:883pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 width=32 style='height:15.0pt;width:24pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:8.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl26 width=93 style='width:70pt'></td>
  <td class=xl26 align=left width=145 style='width:109pt'><%= dt1.Rows[0]["partner_name"] %></td>
  <td class=xl26 width=98 style='width:74pt'></td>
  <td class=xl25 width=145 style='width:109pt'></td>
  <td class=xl27 width=83 style='width:62pt'></td>
  <td class=xl28 width=53 style='width:40pt'></td>
  <td class=xl28 width=83 style='width:62pt'></td>
  <td class=xl28 width=53 style='width:40pt'></td>
  <td colspan=3 class=xl29 width=262 style='width:197pt'>Tel: <%= dt1.Rows[0]["phone_no"] %></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25 align=left><%= dt1.Rows[0]["addr1"] %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29 width=262 style='width:197pt'>Fax: <%= dt1.Rows[0]["fax_no"] %></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25 align=left>Tax code: <%= dt1.Rows[0]["tax_code"] %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl43 width=262 style='width:197pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=12 height=48 class=xl44 style='height:36.0pt'>STOCK EXCHANGE
  ENTRY</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=15 style='height:11.25pt'>
  <td height=15 class=xl39 colspan=2 align=left style='height:11.25pt;
  mso-ignore:colspan'>Date<font class="font9">: </font><font class="font10"><%= dt.Rows[0]["ex_date"] %></font></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl41>Slip No:</td>
  <td class=xl42><%=  dt.Rows[0]["slip_no"]%></td>
  <td colspan=8 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=15 style='height:11.25pt'>
  <td height=15 class=xl39 colspan=3 align=left style='height:11.25pt;
  mso-ignore:colspan'>Charger<font class="font9">: </font><font class="font10"><%=  dt.Rows[0]["full_name"]%></font></td>
  <td class=xl40></td>
  <td class=xl41>Ref No:</td>
  <td class=xl42 x:string><%=  dt.Rows[0]["ref_no"]%></td>
  <td colspan=8 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=15 style='height:11.25pt'>
  <td height=15 class=xl39 colspan=2 align=left style='height:11.25pt;
  mso-ignore:colspan'>Remark<font class="font9">:<span
  style='mso-spacerun:yes'> </span><%=  dt.Rows[0]["description"]%></font></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl41>W/H:</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'><%= p_wh_name%></td>
  <td colspan=7 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=14 style='height:10.5pt'>
  <td height=14 colspan=14 class=xl27 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'>Seq</td>
  <td class=xl32>Req Item Code</td>
  <td class=xl32>Req Item Name</td>
  <td class=xl32>Trans Item Code</td>
  <td class=xl32>Trans Item Name</td>
  <td class=xl32>Req Qty</td>
  <td class=xl32>UOM</td>
  <td class=xl32>Trans Qty</td>
  <td class=xl32>UOM</td>
  <td class=xl32>Req Lot No<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl32>Lot No</td>
  <td class=xl32><span style='mso-spacerun:yes'> </span>Description</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
  <% 
     for (int i = 0; i < dt2.Rows.Count; i++ )
     {
 %>
 <tr class=xl27 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl33 style='height:12.75pt' x:num><%= dt2.Rows[i]["seq"]%></td>
  <td class=xl34 align=left><%= dt2.Rows[i]["item_code"] %></td>
  <td class=xl35 align=left width=145 style='width:109pt'><%= dt2.Rows[i]["item_name"] %></td>
  <td class=xl36 align=left><%= dt2.Rows[i]["ex_item_code"]%></td>
  <td class=xl35 align=left width=145 style='width:109pt'><%= dt2.Rows[i]["ex_item_name"]%></td>
  <td class=xl37 align=right x:num><%= dt2.Rows[i]["out_qty"]%></td>
  <td class=xl38><%= dt2.Rows[i]["out_uom"]%></td>
  <td class=xl37 align=right x:num><%= dt2.Rows[i]["ex_qty"]%></td>
  <td class=xl38><%= dt2.Rows[i]["ex_uom"]%></td>
  <td class=xl34 align=left><%= dt2.Rows[i]["out_lot_no"]%></td>
  <td class=xl34 align=left><%= dt2.Rows[i]["ex_lot_no"]%></td>
  <td class=xl34 align=left><%= dt2.Rows[i]["description"]%></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
  <% } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=32 style='width:24pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
