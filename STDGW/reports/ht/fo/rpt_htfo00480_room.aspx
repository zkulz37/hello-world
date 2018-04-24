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
	string l_dtfrm =Request["p_dt_from"]; 
	string l_dtto =Request["p_dt_to"];
	string l_fee_type =Request["p_fee_type"];
	string l_room_no =Request["p_room_no"];
	
	string l_parameter="";
     l_parameter = "'" + l_dtfrm + "','" + l_dtto + "','" + l_fee_type + "','" + l_room_no + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("crm.sp_sel_htfo00480", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string l_print_date="",l_dtfrm_dtto="";
	string SQL3 = "select to_char(sysdate,'dd-Mon-yyyy hh24:mi') print_date from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_print_date = dt_sysdate.Rows[0][0].ToString();
    }
	l_dtfrm_dtto = "   " + l_dtfrm.Substring(6, 2) + "/" + l_dtfrm.Substring(4, 2) + "/" + l_dtfrm.Substring(0, 4) + "  ~  " + l_dtto.Substring(6, 2) + "/" + l_dtto.Substring(4, 2) + "/" + l_dtto.Substring(0, 4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htfo00480_room_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_htfo00480_room_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_htfo00480_room_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr.Quyen</o:Author>
  <o:LastAuthor>Mr.Quyen</o:LastAuthor>
  <o:LastPrinted>2011-08-02T06:16:18Z</o:LastPrinted>
  <o:Created>2011-07-23T08:04:51Z</o:Created>
  <o:LastSaved>2011-08-02T06:16:30Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.42in .26in .28in .31in;
	mso-header-margin:.41in;
	mso-footer-margin:.28in;
	mso-page-orientation:landscape;}
.font7
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Arial Narrow", sans-serif;
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
.xl24
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl26
	{mso-style-parent:style0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	color:red;
	font-size:16.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl31
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.0";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
      <x:Scale>78</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
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
  <x:WindowHeight>8745</x:WindowHeight>
  <x:WindowWidth>20490</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1212 style='border-collapse:
 collapse;table-layout:fixed;width:911pt'>
 <col width=35 style='mso-width-source:userset;mso-width-alt:1280;width:26pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:4425;width:91pt'>
 <col width=113 style='mso-width-source:userset;mso-width-alt:4132;width:85pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=121 style='mso-width-source:userset;mso-width-alt:4425;width:91pt'>
 <col width=239 style='mso-width-source:userset;mso-width-alt:8740;width:179pt'>
 <tr height=110 style='mso-height-source:userset;height:82.5pt'>
  <td colspan=3 height=110 width=269 style='height:82.5pt;width:202pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
   margin-left:3pt;margin-top:3.75pt;width:142.5pt;height:72.75pt;z-index:1'>
   <v:imagedata src="rpt_htfo00480_room_files/image001.jpg" o:title="AMCO"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:4px;margin-top:5px;width:190px;
  height:97px'><img width=190 height=97
  src="rpt_htfo00480_room_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=3 height=110 class=xl26 width=269 style='height:82.5pt;
    width:202pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=9 class=xl27 width=704 style='width:530pt'>Day Use Fee</td>
  <td width=239 style='width:179pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1027" type="#_x0000_t75" style='position:absolute;margin-left:60pt;
   margin-top:3pt;width:116.25pt;height:75.75pt;z-index:2'>
   <v:imagedata src="rpt_htfo00480_room_files/image003.jpg" o:title="image002"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:80px;margin-top:4px;width:155px;
  height:101px'><img width=155 height=101
  src="rpt_htfo00480_room_files/image004.jpg" v:shapes="_x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=110 width=239 style='height:82.5pt;width:179pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl28 style='height:12.75pt'>Date:<font
  class="font7"> <%=l_dtfrm_dtto%></font></td>
  <td colspan=2 class=xl30></td>
  <td class=xl25>Fee Type :</td>
  <td colspan=4 class=xl29><%=dt.Rows[0][13]%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'>Total:<%=dt.Rows.Count%> Rows.</td>
  <td class=xl25>Print Time:<font class="font7"><span
  style='mso-spacerun:yes'>  </span><%=l_print_date%></font></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl37 style='height:12.75pt;border-top:none'>RM#</td>
  <td class=xl37 style='border-top:none;border-left:none'>Last Name</td>
  <td class=xl37 style='border-top:none;border-left:none'>First Name</td>
  <td class=xl37 style='border-left:none'>Checkin Date</td>
  <td class=xl37 style='border-left:none'>Checkout Date</td>
  <td class=xl37 style='border-left:none'>Fee Amt(VND)</td>
  <td class=xl37 style='border-top:none;border-left:none'>SVC</td>
  <td class=xl37 style='border-top:none;border-left:none'>VAT</td>
  <td class=xl37 style='border-top:none;border-left:none'>Rate</td>
  <td class=xl37 style='border-top:none;border-left:none'>Total Amt</td>
  <td class=xl37 style='border-left:none'>Fee Amt(USD)</td>
  <td class=xl37 style='border-left:none'>Fee Type</td>
  <td class=xl37 style='border-left:none'>Description</td>
 </tr>
  <%
	 decimal l_sum_fee_amt_vnd=0,l_sum_svc=0,l_vat=0,l_amt_total=0,l_sum_fee_amt_usd=0;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
			if(dt.Rows[i][0].ToString() !="")
			{
				l_sum_fee_amt_vnd =l_sum_fee_amt_vnd +decimal.Parse(dt.Rows[i][5].ToString());
				l_sum_svc=l_sum_svc +decimal.Parse(dt.Rows[i][6].ToString());
				l_vat=l_vat +decimal.Parse(dt.Rows[i][7].ToString());
				l_amt_total=l_amt_total +decimal.Parse(dt.Rows[i][9].ToString());
				l_sum_fee_amt_usd=l_sum_fee_amt_usd +decimal.Parse(dt.Rows[i][10].ToString());
			}
          %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl38 style='height:13.5pt;border-top:none' x:num><%=dt.Rows[i][0]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl41 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl41 style='border-top:none;border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][5]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][6]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][7]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][8]%></td>
  <td class=xl40 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][9]%></td>
  <td class=xl42 align=right style='border-top:none;border-left:none'
  x:num><%=dt.Rows[i][10]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt.Rows[i][11]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt.Rows[i][12]%></td>
 </tr>
 <%}%>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl32 style='border-right:.5pt solid black;
  height:12.75pt'>Total:</td>
  <td class=xl35 align=right style='border-top:none;border-left:none'
  x:num><%=l_sum_fee_amt_vnd%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none'
  x:num><%=l_sum_svc%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none'
  x:num><%=l_vat%></td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 align=right style='border-top:none;border-left:none'
  x:num><%=l_amt_total%></td>
  <td class=xl36 align=right style='border-top:none;border-left:none'
  x:num><%=l_sum_fee_amt_usd%></td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=35 style='width:26pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=239 style='width:179pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
