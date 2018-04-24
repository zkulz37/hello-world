<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_pk = Request.QueryString["p_pk"];
	String l_print_date="";
    string l_parameter = "'" + l_pk + "'";
    DataTable dt, dt1;
    dt = ESysLib.TableReadOpenCursor("CRM.sp_rpt_htfo00010_advance",l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string SQL3 = "select to_char(sysdate,'dd-Mon-yyyy hh24:mi') print_date from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_print_date = dt_sysdate.Rows[0][0].ToString();
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="htfo00180_deposit_rpt_files/filelist.xml">
<link rel=Edit-Time-Data href="htfo00180_deposit_rpt_files/editdata.mso">
<link rel=OLE-Object-Data href="htfo00180_deposit_rpt_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Compaq-500B</o:Author>
  <o:LastAuthor>dieu</o:LastAuthor>
  <o:LastPrinted>2010-12-14T02:40:17Z</o:LastPrinted>
  <o:Created>2010-11-30T06:36:40Z</o:Created>
  <o:LastSaved>2010-12-14T02:40:23Z</o:LastSaved>
  <o:Company>HP Compaq</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .7in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
.font9
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:black;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style54
	{color:gray;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	mso-style-name:Hyperlink;
	mso-style-id:8;}
a:link
	{color:gray;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
a:visited
	{color:purple;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
.xl65
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl74
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl79
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl80
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl89
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl90
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl92
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl94
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl97
	{mso-style-parent:style54;
	color:gray;
	font-size:10.0pt;
	text-decoration:underline;
	text-underline-style:single;
	text-align:center;}
.xl98
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>htfo00180_deposit_rpt</x:Name>
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
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>4875</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="7169"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="4"/>
  <o:rules v:ext="edit">
   <o:r id="V:Rule1" type="connector" idref="#Straight_x0020_Connector_x0020_21"/>
   <o:r id="V:Rule2" type="connector" idref="#Straight_x0020_Connector_x0020_23"/>
  </o:rules>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=gray vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=987 style='border-collapse:
 collapse;table-layout:fixed;width:741pt'>
 <col class=xl65 width=40 style='mso-width-source:userset;mso-width-alt:1280;
 width:30pt'>
 <col class=xl65 width=295 style='mso-width-source:userset;mso-width-alt:9440;
 width:221pt'>
 <col class=xl65 width=177 style='mso-width-source:userset;mso-width-alt:5664;
 width:133pt'>
 <col class=xl65 width=67 style='mso-width-source:userset;mso-width-alt:2144;
 width:50pt'>
 <col class=xl65 width=43 style='mso-width-source:userset;mso-width-alt:1376;
 width:32pt'>
 <col class=xl65 width=73 span=251 style='mso-width-source:userset;mso-width-alt:
 2336;width:55pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl65 width=40 style='height:12.75pt;width:30pt'></td>
  <td class=xl65 width=295 style='width:221pt'></td>
  <td class=xl65 width=177 style='width:133pt'></td>
  <td class=xl65 width=67 style='width:50pt'></td>
  <td class=xl65 width=43 style='width:32pt'></td>
  <td class=xl65 width=73 style='width:55pt'></td>
  <td class=xl65 width=73 style='width:55pt'></td>
  <td class=xl65 width=73 style='width:55pt'></td>
  <td class=xl65 width=73 style='width:55pt'></td>
  <td class=xl65 width=73 style='width:55pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl67 style='height:12.75pt'>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl70 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl71>&nbsp;</td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl70 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl89><b>SONG GIA SUITE HOTEL BY HUYNDAI</b></td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl70 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl89><b>Luu Kiem, Thuy Nguyen, Hai Phong. Tel: +84 313963333
  Fax: +84 313963332</b></td>
  <td class=xl72>&nbsp;</td>
  <td colspan=5 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl70 style='height:17.25pt'>&nbsp;</td>
  <td colspan=3 class=xl97><a href="http://www.songgia@songgia.com/"><span
  style='font-size:10.0pt'><b>www.songgia@songgia.com</b></span></a></td>
  <td class=xl71>&nbsp;</td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td height=46 class=xl70 style='height:34.5pt'>&nbsp;</td>
  <td class=xl88><b>Official Receipt( Dep. Sit)</b></td>
  <td class=xl66><span style='mso-spacerun:yes'>      </span><b>No:</b> <%=dt.Rows[0][0]%></td>
  <td class=xl65></td>
  <td class=xl71>&nbsp;</td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl80 style='height:15.0pt'>&nbsp;</td>
  <td class=xl78><b>Room# : </b><%=dt.Rows[0][3]%></td>
  <td colspan=2 class=xl96><span style='mso-spacerun:yes'>      </span><font
  class="font10"><b>Date :</b><%=dt.Rows[0][9]%></font></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl80 style='height:16.5pt'>&nbsp;</td>
  <td class=xl79><b>Payment Method:</b> <%=dt.Rows[0][10]%></td>
  <td colspan=2 class=xl96></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl80 style='height:11.25pt'>&nbsp;</td>
  <td class=xl82>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl84 style='border-right:.5pt solid black'><span
  style='mso-spacerun:yes'>  </span><b>Received from :</b><%=dt.Rows[0][2]%></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl84 style='border-right:.5pt solid black'><span
  style='mso-spacerun:yes'>  </span><b>Dollars :</b><%=dt.Rows[0][5]%>$</td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl94 style='border-right:.5pt solid black'><%=CommondLib.Num2EngText (dt.Rows[0][5].ToString(),"USD") %></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl94 style='border-right:.5pt solid black'><span
  style='mso-spacerun:yes'> </span><font class="font10"><b>Equal to VND </b></font><font
  class="font9">:<%=dt.Rows[0][7]%></font></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl94 style='border-right:.5pt solid black'><%=CommondLib.Num2VNText(dt.Rows[0][7].ToString(),"VND") %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl84 style='border-right:.5pt solid black'><span
  style='mso-spacerun:yes'> </span><b>In payment of:</b></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt'>&nbsp;</td>
  <td class=xl84 style='border-top:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none'>&nbsp;</td>
  <td class=xl86 style='border-top:none'>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt'>&nbsp;</td>
  <td class=xl84 style='border-top:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none'>&nbsp;</td>
  <td class=xl86 style='border-top:none'>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl94 style='border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl80 style='height:12.75pt'>&nbsp;</td>
  <td colspan=3 class=xl94 style='border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl80 style='height:22.5pt'>&nbsp;</td>
  <td class=xl87 style='border-top:none'><b>Cash/ChequeAmount…………………………..</b></td>
  <td colspan=2 class=xl98><b>Cashier's Name</b> &amp; <b>Signature</b></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl80 style='height:25.5pt'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="Straight_x0020_Connector_x0020_21"
   o:spid="_x0000_s4097" style='position:absolute;z-index:1;visibility:visible'
   from="61.5pt,24.75pt" to="219pt,24.75pt" o:connectortype="straight"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:1;margin-left:81px;
  margin-top:32px;width:212px;height:2px'><img width=212 height=2
  src="htfo00180_deposit_rpt_files/image001.gif" v:shapes="Straight_x0020_Connector_x0020_21"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=34 class=xl78 width=295 style='height:25.5pt;width:221pt'><b>Cheque
    No.</b></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl91></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl79 height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl80 style='height:12.0pt'>&nbsp;</td>
  <td class=xl79></td>
  <td colspan=2 height=16 width=244 style='height:12.0pt;width:183pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="Straight_x0020_Connector_x0020_23"
   o:spid="_x0000_s4098" style='position:absolute;z-index:2;visibility:visible'
   from="22.5pt,.75pt" to="183.75pt,.75pt" o:connectortype="straight"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:2;margin-left:29px;
  margin-top:0px;width:217px;height:2px'><img width=217 height=2
  src="htfo00180_deposit_rpt_files/image002.gif" v:shapes="Straight_x0020_Connector_x0020_23"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=16 class=xl91 width=244 style='height:12.0pt;
    width:183pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl81>&nbsp;</td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl75 style='height:10.5pt'>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td colspan=2 class=xl90>&nbsp;</td>
  <td class=xl76>&nbsp;</td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl65 style='height:12.75pt'></td>
  <td class=xl77></td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=295 style='width:221pt'></td>
  <td width=177 style='width:133pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=73 style='width:55pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
