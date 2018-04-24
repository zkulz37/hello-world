﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_date = Request.QueryString["p_date"];
    string p_dept = Request.QueryString["p_dept"];
    string p_item = Request.QueryString["p_item"];
    string para = " '" + p_date + "','" + p_dept + "','" + p_item + "' ";
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("prod.sp_rpt_epbp00130", para);
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM comm.tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM comm.tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    dt1 = ESysLib.TableReadOpen(str_sql);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="epbp00130_files/filelist.xml">
<link rel=Edit-Time-Data href="epbp00130_files/editdata.mso">
<link rel=OLE-Object-Data href="epbp00130_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-10-19T10:41:44Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-10-19T10:42:08Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.16in .1in .2in .08in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
.font5
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font12
	{color:navy;
	font-size:16.0pt;
	font-weight:400;
	font-style:italic;
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
.style20
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
	{mso-style-parent:style20;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	color:red;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style20;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
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
.xl36
	{mso-style-parent:style0;
	color:navy;
	font-size:22.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	color:navy;
	font-size:22.0pt;
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
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
  <x:WindowTopX>270</x:WindowTopX>
  <x:WindowTopY>2355</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1305 style='border-collapse:
 collapse;table-layout:fixed;width:982pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=125 style='mso-width-source:userset;mso-width-alt:4571;width:94pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=165 style='mso-width-source:userset;mso-width-alt:6034;width:124pt'>
 <col width=90 span=3 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=90 span=3 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col width=64 span=4 style='width:48pt'>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 width=84 style='height:15.0pt;width:63pt'><!--[if gte vml 1]><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:1.5pt;margin-top:1.5pt;width:75pt;height:42pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt1.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl26 width=125 style='width:94pt'><span
  style='mso-spacerun:yes'>           </span><%= dt1.Rows[0]["partner_name"] %></td>
  <td class=xl26 width=84 style='width:63pt'></td>
  <td class=xl26 width=165 style='width:124pt'></td>
  <td class=xl25 width=90 style='width:68pt'></td>
  <td class=xl27 width=90 style='width:68pt'></td>
  <td class=xl28 width=90 style='width:68pt'></td>
  <td class=xl28 width=51 style='width:38pt'></td>
  <td class=xl28 width=90 style='width:68pt'></td>
  <td colspan=2 class=xl31 width=180 style='width:136pt'>Tel: <%= dt1.Rows[0]["phone_no"]%></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
  <td class=xl28 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl25><span style='mso-spacerun:yes'>           </span><%= dt1.Rows[0]["addr1"]%></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 width=180 style='width:136pt'>Fax: <%= dt1.Rows[0]["fax_no"]%></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>           </span>Tax code: <%= dt1.Rows[0]["tax_code"]%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 width=180 style='width:136pt'>Print date :
  <%= DateTime.Now.ToString(" dd-MM-yy HH:mm") %></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=86 style='mso-height-source:userset;height:64.5pt'>
  <td colspan=11 height=86 class=xl38 width=1049 style='height:64.5pt;
  width:790pt'>Ngân sách mua hàng<br>
    <font class="font12">( Purchase Budget )</font></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl35 width=84 style='height:33.75pt;width:63pt'>Mã Phòng<font
  class="font5"><br>
    </font><font class="font11">Dept ID</font></td>
  <td class=xl35 width=125 style='border-left:none;width:94pt'>Tên Phòng<font
  class="font5"><br>
    </font><font class="font11">Dept Name</font></td>
  <td class=xl35 width=84 style='border-left:none;width:63pt'>Mã v&#7853;t
  t&#432;<font class="font5"><br>
    </font><font class="font11">Item Code</font></td>
  <td class=xl35 width=165 style='border-left:none;width:124pt'>Tên v&#7853;t
  t&#432;<font class="font5"><br>
    </font><font class="font11">Item Name</font></td>
  <td class=xl35 width=90 style='border-left:none;width:68pt'>Ngân sách<font
  class="font5"><br>
    </font><font class="font11">Budget Amount</font></td>
  <td class=xl35 width=90 style='border-left:none;width:68pt'>&#272;ã mua<font
  class="font5"><br>
    </font><font class="font11">P/O Amount</font></td>
  <td class=xl35 width=90 style='border-left:none;width:68pt'>Còn l&#7841;i<font
  class="font5"><br>
    </font><font class="font11">Amount Balance</font></td>
  <td class=xl37 style='border-left:none'>CCY</td>
  <td class=xl35 width=90 style='border-left:none;width:68pt'>S/L&#432;&#7907;ng
  t&#7889;i &#273;a<font class="font5"><br>
    </font><font class="font11">Budget Item</font></td>
  <td class=xl35 width=90 style='border-left:none;width:68pt'>&#272;ã mua<br>
    <font class="font11">P/O Qty</font></td>
  <td class=xl35 width=90 style='border-left:none;width:68pt'>Còn l&#7841;i<font
  class="font5"><br>
    </font><font class="font11">Item Balance</font></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <%
        for(int i = 0; i < dt.Rows.Count; i++)
        {
  %>
 <tr class=xl40 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl39 style='height:22.5pt;border-top:none'><%= dt.Rows[i]["dept_id"]%></td>
  <td class=xl33 width=125 style='border-top:none;border-left:none;width:94pt'><%= dt.Rows[i]["dept_name"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%= dt.Rows[i]["item_code"]%></td>
  <td class=xl33 width=165 style='border-top:none;border-left:none;width:124pt'><%= dt.Rows[i]["item_name"]%></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= dt.Rows[i]["budget_amount"]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl41 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt.Rows[i]["po_amount"]%></td>
  <td class=xl42 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                 </span><%= dt.Rows[i]["amount_balance"]%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%= dt.Rows[i]["tr_ccy"]%></td>
  <td class=xl43 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= dt.Rows[i]["budget_item"]%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl43 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt.Rows[i]["po_qty"]%></td>
  <td class=xl44 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                 </span><%= dt.Rows[i]["item_balance"]%></td>
  <td colspan=4 class=xl40 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=84 style='width:63pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=165 style='width:124pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>