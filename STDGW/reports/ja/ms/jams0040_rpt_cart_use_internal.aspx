<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("crm");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_dfr =Request["p_dt_frm"];
	string l_dtto =Request["p_dt_to"];
	string l_nam =Request["p_name"];
    string l_parameter="",l_print_date="";

    l_parameter = "'" + l_dfr + "','" + l_dtto + "','" + l_nam + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_jams0040_use_cart_rpt", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    string SQL3 = "select to_char(sysdate,'dd-Mon-yyyy') print_date from dual";
    DataTable dt_sysdate = ESysLib.TableReadOpen(SQL3);
    if (dt_sysdate.Rows.Count > 0)
    {
        l_print_date = dt_sysdate.Rows[0][0].ToString();
    }  
	 string dtfrm_para	  =  l_dfr.Substring(6, 2)+ "/" + l_dfr.Substring(4, 2) + "/" + l_dfr.Substring(0, 4);
	  string dtTo_para	  =  l_dtto.Substring(6, 2)+ "/" + l_dtto.Substring(4, 2) + "/" + l_dtto.Substring(0, 4);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="jams0040_rpt_cart_use_internal_files/filelist.xml">
<link rel=Edit-Time-Data
href="jams0040_rpt_cart_use_internal_files/editdata.mso">
<link rel=OLE-Object-Data
href="jams0040_rpt_cart_use_internal_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>dieu</o:Author>
  <o:LastAuthor>dieu</o:LastAuthor>
  <o:LastPrinted>2010-12-19T10:00:09Z</o:LastPrinted>
  <o:Created>2010-12-19T09:19:54Z</o:Created>
  <o:LastSaved>2010-12-19T10:02:21Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .2in .2in .2in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	text-align:right;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	text-align:left;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	}
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
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1008 style='border-collapse:
 collapse;table-layout:fixed;width:757pt'>
 <col width=64 style='width:48pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=138 style='mso-width-source:userset;mso-width-alt:5046;width:104pt'>
 <col width=126 style='mso-width-source:userset;mso-width-alt:4608;width:95pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:4059;width:83pt'>
 <col width=64 style='mso-width-source:userset;mso-width-alt:2662;width:61pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1818;width:35pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <tr height=78 style='mso-height-source:userset;height:58.5pt'>
  <td colspan=2 height=78 class=xl30 width=148 style='height:58.5pt;width:111pt'>AMB
  - VINA</td>
  <td colspan=9 class=xl32 width=729 style='width:548pt'>Cart  Internal  Use</td>
  <td width=131 style='width:98pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
   margin-left:.75pt;margin-top:0;width:95.25pt;height:58.5pt;z-index:1'>
   <v:imagedata src="jams0040_rpt_cart_use_internal_files/image001.png"
    o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:1px;margin-top:0px;width:127px;
  height:78px'><img width=127 height=78
  src="jams0040_rpt_cart_use_internal_files/image002.jpg" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=78 width=131 style='height:58.5pt;width:98pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'>Date :</td>
  <td colspan=2 class=xl31><%=dtfrm_para%>~<%=dtTo_para%></td>
  <td colspan=1 style='mso-ignore:colspan'>Total :<%=dt.Rows.Count%> <b> Cart</b></td>
  <td colspan=1 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl24>Print Date:</td>
  <td class=xl28><%=l_print_date%></td>
 </tr>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl26 style='height:22.5pt'>Date Use</td>
  <td class=xl26 style='border-left:none'>Item Code</td>
  <td class=xl26 style='border-left:none'>Item Name</td>
  <td class=xl26 style='border-left:none'>Operator</td>
  <td class=xl26 style='border-left:none'>Purpose</td>
  <td class=xl26 style='border-left:none' x:str="From Time ">From Time<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 style='border-left:none'>Time To</td>
  <td class=xl26 style='border-left:none'>Hole</td>
  <td class=xl26 style='border-left:none' x:str="Total ">Total<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 style='border-left:none'>Start Status</td>
  <td class=xl26 style='border-left:none'>Finish status</td>
  <td class=xl26 style='border-left:none'>Description</td>
 </tr>
  <%
	 for (int i = 0; i < dt.Rows.Count; i++)
     {
		  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][5]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][6]%></td>
  <td class=xl27 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][8]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][9]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][11]%></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=131 style='width:98pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
