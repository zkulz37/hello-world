﻿<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("sale");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%    
    string strSQL = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                      FROM comm.tco_company
                      WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                 FROM comm.tco_company
                                                 WHERE del_if = 0 AND active_yn = 'Y')";
    string p_from_dt = Request.QueryString["p_from_dt"];
    string p_to_dt = Request.QueryString["p_to_dt"];
    string p_partner = Request.QueryString["p_partner"];
    string p_slip_no = Request.QueryString["p_slip_ref_no"];
    string p_bal_yn = Request.QueryString["p_bal_yn"];
    string para = "'" + p_from_dt + "','" + p_to_dt + "','" + p_partner + "','" + p_slip_no + "','" + p_bal_yn + "'";
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpen(strSQL);
    dt1 = ESysLib.TableReadOpenCursor("sale.sp_rpt_dsap00100_1", para);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_dsap00100_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_dsap00100_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_dsap00100_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2011-10-20T06:07:24Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-10-20T06:07:28Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&L&G&CPage &P of &N";
	margin:.33in .28in .4in .32in;
	mso-header-margin:.26in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
.font8
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font13
	{color:black;
	font-size:8.0pt;
	font-weight:400;
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
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
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
	mso-font-charset:0;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl41
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
.xl42
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl43
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl46
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid black;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl53
	{mso-style-parent:style21;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style21;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
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
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9150</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$6:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1110 style='border-collapse:
 collapse;table-layout:fixed;width:836pt'>
 <col class=xl25 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col class=xl25 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl25 width=90 span=2 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <col class=xl25 width=85 span=5 style='mso-width-source:userset;mso-width-alt:
 3108;width:64pt'>
 <col class=xl25 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl25 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl25 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 rowspan=3 height=20 class=xl39 width=205 style='border-bottom:
  2.0pt double black;height:15.0pt;width:154pt'><!--[if gte vml 1]><v:shape
   id="_x0000_s1025" style='position:absolute;margin-left:67.5pt;margin-top:4.5pt;
   width:81pt;height:37.5pt;z-index:1;visibility:visible' coordsize="21600,21600"
   o:spt="100" o:preferrelative="t" adj="0,,0" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title="img00001"/>
   <v:formulas/>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--></td>
  <td class=xl27 colspan=3 width=260 style='mso-ignore:colspan;width:196pt'><%=dt.Rows[0]["partner_name"]%></td>
  <td class=xl26 width=85 style='width:64pt'></td>
  <td class=xl26 width=85 style='width:64pt'></td>
  <td class=xl28 width=85 style='width:64pt'></td>
  <td class=xl26 width=85 style='width:64pt'></td>
  <td class=xl26 colspan=2 width=135 style='mso-ignore:colspan;width:102pt'>Tel: <%=dt.Rows[0]["phone_no"]%></td>
  <td class=xl26 width=80 style='width:60pt'></td>
  <td class=xl26 width=90 style='width:68pt'></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 colspan=2 style='height:15.0pt;mso-ignore:colspan'><%=dt.Rows[0]["addr1"]%></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl26></td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>Fax: <%=dt.Rows[0]["fax_no"]%></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl29 colspan=2 style='height:15.0pt;mso-ignore:colspan'>MST: <%=dt.Rows[0]["tax_code"]%></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31 width=85 style='width:64pt'>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30 colspan=3 style='mso-ignore:colspan'>Print date : <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <tr height=70 style='mso-height-source:userset;height:52.5pt'>
  <td colspan=13 height=70 class=xl41 width=1110 style='height:52.5pt;
  width:836pt'>BÁO CÁO THU CHI TIẾT<br>
    <font class="font10">( DETAIL COLLECTION REPORT )</font></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl32 style='height:7.5pt'>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td rowspan=2 height=45 class=xl42 width=25 style='border-bottom:.5pt solid black;
  height:33.75pt;border-top:none;width:19pt'>STT</td>
  <td rowspan=2 class=xl44 width=180 style='border-bottom:.5pt solid black;
  border-top:none;width:135pt'>Khách hàng<font class="font13"><br>
    </font><font class="font8">Customer</font></td>
  <td rowspan=2 class=xl46 width=80 style='border-bottom:.5pt solid black;
  border-top:none;width:60pt'>Ngày<font class="font13"><br>
    </font><font class="font8">Req Date</font></td>
  <td rowspan=2 class=xl48 width=90 style='border-bottom:.5pt solid black;
  border-top:none;width:68pt'>Số tham chiếu<font class="font13"><br>
    </font><font class="font8">Ref No</font></td>
  <td rowspan=2 class=xl44 width=90 style='border-bottom:.5pt solid black;
  border-top:none;width:68pt'>Số phiếu<font class="font13"><br>
    </font><font class="font8">Slip No</font></td>
  <td rowspan=2 class=xl44 width=85 style='border-bottom:.5pt solid black;
  border-top:none;width:64pt'>Thành tiền<br>
    <font class="font8">Item Amount</font></td>
  <td rowspan=2 class=xl44 width=85 style='border-bottom:.5pt solid black;
  border-top:none;width:64pt'>Thuế<br>
    <font class="font8">Tax Amount</font></td>
  <td rowspan=2 class=xl54 width=85 style='border-bottom:.5pt solid black;
  border-top:none;width:64pt'>Tổng tiền<br>
    <font class="font8">Total Amount</font></td>
  <td rowspan=2 class=xl54 width=85 style='border-bottom:.5pt solid black;
  width:64pt'>Thanh toán<br>
    <font class="font8">Pay Amount</font></td>
  <td rowspan=2 class=xl54 width=85 style='border-bottom:.5pt solid black;
  width:64pt'>Còn lại<br>
    <font class="font8">Pay Amount</font></td>
  <td rowspan=2 class=xl44 width=50 style='border-bottom:.5pt solid black;
  width:38pt'>CCY</td>
  <td rowspan=2 class=xl44 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>Tỉ giá<br>
    <font class="font8">Ex Rate</font></td>
  <td rowspan=2 class=xl44 width=90 style='border-bottom:.5pt solid black;
  width:68pt'>Ghi chú<br>
    <font class="font8">Remark</font></td>
 </tr>
 <tr class=xl34 height=30 style='mso-height-source:userset;height:22.5pt'>
 </tr>
 <%
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
         %>
<tr class=xl35 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl36 width=25 style='height:30.0pt;width:19pt' x:num><%=i+1 %></td>
  <td class=xl37 width=180 style='width:135pt'><%=dt1.Rows[i]["partner_name"]%></td>
  <td class=xl51 width=80 style='width:60pt' x:num><%=dt1.Rows[i]["req_date"]%></td>
  <td class=xl38 width=90 style='width:68pt' x:num><%=dt1.Rows[i]["ref_no"]%></td>
  <td class=xl53 width=90 style='width:68pt' x:num><%=dt1.Rows[i]["slip_no"]%></td>
  <td class=xl50 width=85 style='width:64pt' x:num><%=dt1.Rows[i]["item_amount"]%></td>
  <td class=xl50 width=85 style='width:64pt' x:num><%=dt1.Rows[i]["vat_amount"]%></td>
  <td class=xl52 width=85 style='width:64pt' x:num><%=dt1.Rows[i]["total_amount"]%></td>
  <td class=xl52 width=85 style='width:64pt' x:num><%=dt1.Rows[i]["pay_amount"]%></td>
  <td class=xl52 width=85 style='width:64pt' x:num><%=dt1.Rows[i]["bal_amount"]%></td>
  <td class=xl38 width=50 style='width:38pt'><%=dt1.Rows[i]["tr_ccy"]%></td>
  <td class=xl50 width=80 style='width:60pt' x:num><%=dt1.Rows[i]["ex_rate"]%></td>
  <td class=xl38 width=90 style='width:68pt'><%=dt1.Rows[i]["payment_desc"]%></td>
 </tr>
         <% 
     }
  %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=25 style='width:19pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=90 style='width:68pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
