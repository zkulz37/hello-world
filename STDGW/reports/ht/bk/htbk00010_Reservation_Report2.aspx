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
	string l_master_pk =Request["p_master_pk"];
	string l_parameter="";
     l_parameter = "'" + l_master_pk + "'";
    DataTable dtDTL = ESysLib.TableReadOpenCursor("CRM.SP_SEL_HTBK00010_DTL", l_parameter);
    if (dtDTL.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	DataTable dtMaster = ESysLib.TableReadOpenCursor("CRM.SP_SEL_HTBK00010_MST", l_parameter);
    if (dtMaster.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string l_print_date="";
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
<link rel=File-List href="htbk00010_Reservation_Report_files/filelist.xml">
<link rel=Edit-Time-Data href="htbk00010_Reservation_Report_files/editdata.mso">
<link rel=OLE-Object-Data href="htbk00010_Reservation_Report_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>dieu</o:LastAuthor>
  <o:LastPrinted>2010-11-11T01:56:50Z</o:LastPrinted>
  <o:Created>2010-11-10T11:03:55Z</o:Created>
  <o:LastSaved>2010-11-26T08:25:38Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style21
	{color:blue;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-style-name:Hyperlink;
	mso-style-id:8;}
a:link
	{color:blue;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
a:visited
	{color:purple;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
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
	text-align:left;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	text-align:right;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	text-align:left;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl43
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl45
	{mso-style-parent:style21;
	color:blue;
	text-decoration:underline;
	text-underline-style:single;
	text-align:left;}
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
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
  <x:WindowHeight>9180</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1635</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=653 style='border-collapse:
 collapse;table-layout:fixed;width:492pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <tr height=102 style='mso-height-source:userset;height:76.5pt'>
  <td height=102 width=117 style='height:76.5pt;width:88pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:0;width:87pt;height:75.75pt;z-index:1'>
   <v:imagedata src="htbk00010_Reservation_Report_files/image001.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:116px;
  height:101px'><img width=116 height=101
  src="htbk00010_Reservation_Report_files/image002.jpg" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=102 width=117 style='height:76.5pt;width:88pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 class=xl24 width=536 style='width:404pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>From :</td>
  <td colspan=3 class=xl24>Ms Nguyen Viet Huong</td>
  <td>To:</td>
  <td colspan=3 class=xl24><%=dtMaster.Rows[0][7]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Department:</td>
  <td colspan=3 class=xl24 x:str="Sales &amp; Marketing ">Sales &amp;
  Marketing<span style='mso-spacerun:yes'> </span></td>
  <td>Company:</td>
  <td colspan=3 class=xl24><%=dtMaster.Rows[0][34]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Tel:</td>
  <td colspan=3 class=xl24>(84 - 31) 396 3900</td>
  <td>Tel:</td>
  <td colspan=3 class=xl24 x:num><%=dtMaster.Rows[0][13]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Fax:</td>
  <td colspan=3 class=xl24>(84 - 31) 396 3909</td>
  <td>Fax:</td>
  <td colspan=3 class=xl24 x:num><%=dtMaster.Rows[0][18]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Email:</td>
  <td colspan=3 class=xl45><a href="mailto:marketing5@songgia.com">marketing5@songgia.com</a></td>
  <td>Email:</td>
  <td colspan=3 class=xl24><%=dtMaster.Rows[0][14]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Date :</td>
  <td colspan=3 class=xl24><%=l_print_date%></td>
  <td>Conf.# :</td>
  <td colspan=3 class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 height=17 class=xl24 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>Subject :</td>
  <td colspan=7 class=xl42>Booking Confirmation</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=8 height=18 class=xl43 style='height:13.5pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 height=17 class=xl44 style='height:12.75pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 height=17 class=xl24 style='height:12.75pt'>Dear……….....,</td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=8 height=39 class=xl36 width=653 style='height:29.25pt;
  width:492pt'>Thank you for your support to Song Gia Suites by Hyundai. We are
  pleased to confirm your company’s bookings as follows:</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 height=17 class=xl40 style='height:12.75pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt'>Guest Name</td>
  <td class=xl27>Room Type</td>
  <td class=xl27><span style='mso-spacerun:yes'> </span>Rate</td>
  <td class=xl27>Checkin Date</td>
  <td class=xl27>CheckOut Date</td>
  <td class=xl27>No Of Night</td>
  <td class=xl27>Total Guest</td>
  <td class=xl27>Remark</td>
 </tr>
 <%
     for (int i = 0; i < dtDTL.Rows.Count; i++)
     {
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'><%=dtDTL.Rows[i][2]%></td>
  <td class=xl29><%=dtDTL.Rows[i][10]%></td>
  <td class=xl29 align=right x:num><%=dtDTL.Rows[i][7]%></td>
  <td class=xl29><%=dtMaster.Rows[0][38]%></td>
  <td class=xl29><%=dtMaster.Rows[0][39]%></td>
  <td class=xl29 align=right x:num><%=dtMaster.Rows[0][10]%></td>
  <td class=xl29 align=right x:num><%=dtDTL.Rows[i][5]%></td>
  <td class=xl29>&nbsp;</td>
 </tr>
 <%
	}
	%>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 height=17 class=xl41 style='height:12.75pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 height=17 class=xl24 style='height:12.75pt'>Room rates are
  quoted in US Dollars, and subject to 5% for services charge and 10% for
  Government tax.</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 height=17 class=xl24 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt' x:str="Inclusions  :                    ">Inclusions<span
  style='mso-spacerun:yes'>  </span>:<span style='mso-spacerun:yes'>          
  </span><span style='display:none'><span
  style='mso-spacerun:yes'>         </span></span></td>
  <td colspan=7 class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Other requests :</td>
  <td colspan=7 class=xl24><%=dtMaster.Rows[0][20]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Payment</td>
  <td colspan=7 class=xl24><%=dtMaster.Rows[0][40]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 colspan=3 style='height:12.75pt;mso-ignore:colspan'>Payment
  and Guarantee Method:</td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Credit Owner :</td>
  <td colspan=7 style='mso-ignore:colspan' x:num><%=dtMaster.Rows[0][33]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Credit Card Type :</td>
  <td colspan=7 class=xl24><%=dtMaster.Rows[0][37]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'>Credit Card Number:</td>
  <td colspan=7 class=xl38 x:num><%=dtMaster.Rows[0][29]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Expiry Date :</td>
  <td colspan=7 class=xl39 x:num></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=7 class=xl37>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl34 style='height:12.75pt'>Cancellation
  policy:</td>
  <td colspan=6 class=xl24><%=dtMaster.Rows[0][23]%></td>
 </tr>
 <tr height=54 style='mso-height-source:userset;height:40.5pt'>
  <td colspan=8 height=54 class=xl36 width=653 style='height:40.5pt;width:492pt'>This
  reservation is confirmed and hold until 6:00 pm only unless guaranteed with a
  credit card deposit. Notice of cancellation must be received no later than 48
  hours from the arrival to avoid a cancellation penalty equivalent to a charge
  of one night's room and tax.</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl34 style='height:12.75pt'>Check in – check
  out policy:</td>
  <td colspan=6 class=xl35></td>
 </tr>
 <tr height=69 style='mso-height-source:userset;height:51.75pt'>
  <td colspan=8 height=69 class=xl36 width=653 style='height:51.75pt;
  width:492pt'>The hotel's check-in time is 14:00 hrs and check-out time is
  12:00 noon. A full day charge will apply if you require the hotel to
  pre-block the room one day in advance in order to guarantee early
  check-in.<br>
    We look forward to welcoming your guests to Song Gia Suites by Hyundai and
  wish them a pleasant stay. <br>
    </td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=5 class=xl24 x:str="Agreed to guarantee by / Company Stamp      ">Agreed
  to guarantee by / Company Stamp<span style='mso-spacerun:yes'>      </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl24 style='height:12.75pt'
  x:str="Sales &amp; Marketing Department ">Sales &amp; Marketing
  Department<span style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl24>Signature &amp; Company Stamp</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 rowspan=3 height=51 class=xl24 style='height:38.25pt'></td>
  <td colspan=2 class=xl33>Date:</td>
  <td colspan=3 class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 rowspan=2 height=34 class=xl24 style='height:25.5pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td colspan=8 height=53 class=xl32 width=653 style='height:39.75pt;
  width:492pt'>Luu Kiem Thuy Nguyen, Hai Phong City, Vietnam <br>
    Tel: (8431) 396 3900. Fax: (8431) 396 3909. Website:<span
  style='mso-spacerun:yes'>  </span>www.songgia.com<br>
    </td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=117 style='width:88pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=110 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
