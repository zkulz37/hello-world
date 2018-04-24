<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("crm");%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_dt_para = Request["p_dt_para"];
	string l_am= Request["p_am"];
	string l_course = Request["p_course"];
	
	string l_parameter = "'" + l_dt_para + "','" + l_am + "','"+l_course+"'";
    DataTable dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_jabk0090_rpt", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string print_date_system="";
    string SQL2 = " select TO_CHAR(sysdate,'dd/mm/yyyy hh24:mi') dt_print  from dual ";
    DataTable dt2 = ESysLib.TableReadOpen(SQL2);
    if (dt2.Rows.Count > 0)
    {
        print_date_system = dt2.Rows[0][0].ToString();
    }
	string strdt_para = l_dt_para.Substring(6, 2) + "/" + l_dt_para.Substring(4, 2)+ "/" +l_dt_para.Substring(0, 4);//2009.08
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="jabk0090_files/filelist.xml">
<link rel=Edit-Time-Data href="jabk0090_files/editdata.mso">
<link rel=OLE-Object-Data href="jabk0090_files/oledata.mso">
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
  <o:LastPrinted>2010-12-24T14:05:12Z</o:LastPrinted>
  <o:Created>2010-12-24T13:34:44Z</o:Created>
  <o:LastSaved>2010-12-24T14:05:32Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&RPage  &P  ";
	margin:.2in .12in .2in .12in;
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
	text-align:right;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-size:7.0pt;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
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
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$2:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1014 style='border-collapse:
 collapse;table-layout:fixed;width:764pt'>
 <col width=35 style='mso-width-source:userset;mso-width-alt:1280;width:26pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <tr height=94 style='mso-height-source:userset;height:70.5pt'>
  <td colspan=2 height=94 class=xl33 width=86 style='height:70.5pt;width:64pt'>AMB
  - VINA</td>
  <td colspan=10 class=xl29 width=810 style='width:611pt'>BOOKING SHEET OUT
  COURSE - MORNING</td>
  <td colspan=2 height=94 width=118 style='height:70.5pt;width:89pt'
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
   margin-left:.75pt;margin-top:1.5pt;width:86.25pt;height:69pt;z-index:1'>
   <v:imagedata src="jabk0090_files/image001.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:1px;margin-top:2px;width:115px;
  height:92px'><img width=115 height=92 src="jabk0090_files/image002.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=94 class=xl28 width=118 style='height:70.5pt;
    width:89pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl30 style='height:15.75pt'>Date:</td>
  <td colspan=9 class=xl32><%=strdt_para%></td>
  <td class=xl24>Print Date:</td>
  <td colspan=2 class=xl31><%=print_date_system%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl27 style='height:18.0pt;border-top:none'>Group</td>
  <td class=xl27 style='border-top:none;border-left:none'>T.O.Time</td>
  <td class=xl27 style='border-top:none;border-left:none'>Player A</td>
  <td class=xl27 style='border-top:none;border-left:none'>Member No</td>
  <td class=xl27 style='border-top:none;border-left:none'>CD#</td>
  <td class=xl27 style='border-top:none;border-left:none'>Player B</td>
  <td class=xl27 style='border-top:none;border-left:none'>Member No</td>
  <td class=xl27 style='border-top:none;border-left:none'>CD#</td>
  <td class=xl27 style='border-top:none;border-left:none'>Player C</td>
  <td class=xl27 style='border-top:none;border-left:none'>Member No</td>
  <td class=xl27 style='border-top:none;border-left:none'>CD#</td>
  <td class=xl27 style='border-left:none'>Player D</td>
  <td class=xl27 style='border-top:none;border-left:none'>Member No</td>
  <td class=xl27 style='border-top:none;border-left:none'>CD#</td>
 </tr>
  <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt;border-top:none' x:num><%=dt.Rows[i][0]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][5]%> </td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][6]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][8]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][9]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][11]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][12]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][13]%></td>
 </tr>
 <%
     } %>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=14 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=35 style='width:26pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=53 style='width:40pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
