<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% ESysLib.SetUser(Session["APP_DBUSER"].ToString());%>
<% 	
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_tin_warehouse_pk = Request.QueryString["p_tin_warehouse_pk"];
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];
    string p_po_vendor = Request.QueryString["p_po_vendor"];
    string p_item = Request.QueryString["p_item"];
    string p_tin_warehouse_name = Request.QueryString["p_tin_warehouse_name"];
    string ccy = Request.QueryString["ccy"];

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
<link rel=File-List href="rpt_bini00022_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_bini00022_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_bini00022_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-11-01T09:02:34Z</o:LastPrinted>
  <o:Created>2010-12-14T02:33:33Z</o:Created>
  <o:LastSaved>2011-11-01T09:02:35Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:0in .1in .39in .1in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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
	font-family:\B3CB\C6C0, monospace;
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
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
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
	color:red;
	font-size:18.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.000_\)\;_\(* \\\(\#\,\#\#0\.000\\\)\;_\(* \0022-\0022???_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.000";
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
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
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
  <x:WindowHeight>5745</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
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

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1354 style='border-collapse:
 collapse;table-layout:fixed;width:1017pt'>
 <col width=190 style='mso-width-source:userset;mso-width-alt:6948;width:143pt'>
 <col width=195 style='mso-width-source:userset;mso-width-alt:7131;width:146pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:1901;width:39pt'>
 <col width=91 style='mso-width-source:userset;mso-width-alt:3328;width:68pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=106 style='mso-width-source:userset;mso-width-alt:3876;width:80pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=106 style='mso-width-source:userset;mso-width-alt:3876;width:80pt'>
 <col width=64 span=5 style='width:48pt'>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 width=190 style='height:15.0pt;width:143pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:35pt;margin-top:.5pt;width:73pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl27 width=195 style='width:146pt'><%= dt1.Rows[0]["partner_name"] %></td>
  <td class=xl27 width=91 style='width:68pt'></td>
  <td class=xl27 width=52 style='width:39pt'></td>
  <td class=xl26 width=91 style='width:68pt'></td>
  <td class=xl25 width=66 style='width:50pt'></td>
  <td class=xl28 width=94 style='width:71pt'></td>
  <td colspan=3 class=xl36 width=255 style='width:192pt'>Tel: <%= dt1.Rows[0]["phone_no"] %></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26><%= dt1.Rows[0]["addr1"] %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl28></td>
  <td colspan=3 class=xl36 width=255 style='width:192pt'>Fax: <%= dt1.Rows[0]["fax_no"] %></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl26>Tax code: <%= dt1.Rows[0]["tax_code"] %></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl29></td>
  <td colspan=3 class=xl37 width=255 style='width:192pt'>Print date :
  <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=10 height=36 class=xl38 style='height:27.0pt'>Report Stock
  Incoming Checking</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>Ware house: <%= p_tin_warehouse_name %></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33 colspan=3 style='mso-ignore:colspan'>Date: <%= System.DateTime.ParseExact(p_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy") %>
                ~
                <%= System.DateTime.ParseExact(p_to_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td colspan=4 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt'>Supplier</td>
  <td class=xl35>Group</td>
  <td class=xl35>Quantity</td>
  <td class=xl35>UOM</td>
  <td class=xl35>Item Amount</td>
  <td class=xl35>Vat Rate</td>
  <td class=xl35>Vat Amt</td>
  <td class=xl35>Total Amt</td>
  <td class=xl35>CCY</td>
  <td class=xl35>Total <%=ccy%> Amt</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <%
            string para = "'" + p_tin_warehouse_pk + "','" + p_from_date + "','" +p_to_date + "','" + p_po_vendor+ "','" + p_item+ "','"+ccy+"'" ;
            DataTable dt = ESysLib.TableReadOpenCursor("lg_rpt_bini00022", para);
                        for (int i = 0; i < dt.Rows.Count; i++)
            { 
%>            
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 width=190 style='height:12.75pt;border-top:none;
  width:143pt'><%= dt.Rows[i]["partner_name"]%></td>
  <td class=xl40 width=195 style='border-top:none;border-left:none;width:146pt'><%= dt.Rows[i]["grp_nm"]%></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%= dt.Rows[i]["in_qty"]%></td>
  <td class=xl42 style='border-top:none;border-left:none'><%= dt.Rows[i]["in_uom"]%></td>
  <td class=xl43 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%= dt.Rows[i]["item_amount"]%><span
  style='mso-spacerun:yes'></span></td>
  <td class=xl43 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%= dt.Rows[i]["vat_rate"]%><span
  style='mso-spacerun:yes'></span></td>
  <td class=xl43 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%= dt.Rows[i]["vat_amount"]%><span
  style='mso-spacerun:yes'></span></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%= dt.Rows[i]["total_amount"]%></td>
  <td class=xl44 style='border-top:none;border-left:none'><%= dt.Rows[i]["ccy"]%></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'></span><%= dt.Rows[i]["dis_amount"]%><span
  style='mso-spacerun:yes'></span></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <%} %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl45 style='height:12.75pt;border-top:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>C7:C<%= dt.Rows.Count+6%><%}else{%>C8:C8<%}%>)"><span
  style='mso-spacerun:yes'>       </span></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>G7:G<%= dt.Rows.Count+6%><%}else{%>G8:G8<%}%>)"><span
  style='mso-spacerun:yes'>     </span></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>H7:H<%= dt.Rows.Count+6%><%}else{%>H8:H8<%}%>)"><span
  style='mso-spacerun:yes'>      </span>9,396,000.000 </td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 align=right style='border-top:none;border-left:none'
  x:num x:fmla="=SUM(<% if(dt.Rows.Count > 0){%>J7:J<%= dt.Rows.Count+6%><%}else{%>J8:J8<%}%>)">272.252</td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=190 style='width:143pt'></td>
  <td width=195 style='width:146pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
