<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
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
    string l_parameter = "'" + l_pk + "'";
	string l_print_date="";
    DataTable dtMaster,dt_Food,dt_Beverage,dt_service_Other,dt_Promotion;
    dtMaster = ESysLib.TableReadOpenCursor("CRM.sp_sel_htrt00060_1_rpt",l_parameter);
    if (dtMaster.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	dt_Food = ESysLib.TableReadOpenCursor("CRM.sp_sel_htrt00060_2_food",l_parameter);
	dt_Beverage = ESysLib.TableReadOpenCursor("CRM.sp_sel_htrt00060_3_bever",l_parameter);
	dt_service_Other = ESysLib.TableReadOpenCursor("CRM.sp_sel_htrt00060_4_other",l_parameter);
	dt_Promotion = ESysLib.TableReadOpenCursor("CRM.sp_sel_htrt00060_5_promotion",l_parameter);
	
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
<link rel=File-List href="htrt00130_files/filelist.xml">
<link rel=Edit-Time-Data href="htrt00130_files/editdata.mso">
<link rel=OLE-Object-Data href="htrt00130_files/oledata.mso">
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
  <o:LastPrinted>2010-12-23T09:34:25Z</o:LastPrinted>
  <o:Created>2010-12-23T07:52:37Z</o:Created>
  <o:LastSaved>2010-12-23T09:52:58Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .2in .2in 1.18in;
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
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:right;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Scientific;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	color:white;}
.xl42
	{mso-style-parent:style0;
	color:white;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:red;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#33CCCC;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	color:white;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:red;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
      </x:Pane>
     </x:Panes>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=849 style='border-collapse:
 collapse;table-layout:fixed;width:637pt'>
 <col width=35 style='mso-width-source:userset;mso-width-alt:1280;width:26pt'>
 <col width=84 span=2 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=112 style='mso-width-source:userset;mso-width-alt:4096;width:84pt'>
 <tr height=85 style='mso-height-source:userset;height:63.75pt'>
  <td colspan=2 height=85 class=xl53 width=119 style='height:63.75pt;
  width:89pt'>AMB - VINA</td>
  <td colspan=7 class=xl54 width=618 style='width:464pt'>BANQUET INQUIRY</td>
  <td width=112 style='width:84pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
   margin-left:1.5pt;margin-top:0;width:81.75pt;height:62.25pt;z-index:1'>
   <v:imagedata src="htrt00130_files/image001.png" o:title="image001"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:2px;margin-top:0px;width:109px;
  height:83px'><img width=109 height=83 src="htrt00130_files/image002.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=85 width=112 style='height:63.75pt;width:84pt'></td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl55 style='height:12.75pt'><b>Customer Name:</b></td>
  <td colspan=3 style='mso-ignore:colspan'><%=dtMaster.Rows[0]["CUSTOMER_NAME"].ToString()%></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl24>Print Date:</td>
  <td class=xl28>ddxmmsyyyy 11x12</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl26 style='height:12.75pt'>Slip No:</td>
  <td class=xl30 style='border-left:none'><%=dtMaster.Rows[0]["SLIP_NO"].ToString()%></td>
  <td class=xl26 style='border-left:none'>Total Person:</td>
  <td class=xl32 style='border-left:none' x:num="12312">12,312</td>
  <td colspan=2 class=xl26 style='border-left:none'>Book Date:</td>
  <td class=xl30 style='border-left:none'><%=dtMaster.Rows[0]["BOOK_DATE"].ToString()%></td>
  <td class=xl26 style='border-left:none'>Creator:</td>
  <td class=xl29 align=right style='border-left:none' x:str><%=dtMaster.Rows[0]["CRT_BY"].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl26 style='height:12.75pt'>Reserve:</td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dtMaster.Rows[0]["BACKUP_TABLE"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Book Time:</td>
  <td class=xl33 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["BOOK_TIME"].ToString()%></td>
  <td colspan=2 class=xl26 style='border-left:none'>Person/Table:</td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dtMaster.Rows[0]["PERSONS_TABLES"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Sum Table:</td>
  <td class=xl29 align=right style='border-top:none;border-left:none'
  x:num><%=dtMaster.Rows[0]["TOTAL_TABLE"].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl26 style='height:12.75pt'>Open Date:</td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["OPEN_DATE"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Price/Person:</td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dtMaster.Rows[0]["PRICE_PER_GUEST"].ToString()%></td>
  <td colspan=2 class=xl26 style='border-left:none'>Amount Food:</td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dtMaster.Rows[0]["FOOD_AMT"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Begin Time:</td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["BEGIN_TIME"].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl26 style='height:12.75pt'>Amount service:</td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dtMaster.Rows[0]["SERVICE_AMT"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Amount Bvg:</td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dtMaster.Rows[0]["SOFT_DRINK_AMT"].ToString()%></td>
  <td colspan=2 class=xl26 style='border-left:none'>Detail Time:</td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["DETAIL_TIME"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Amount Total:</td>
  <td class=xl29 align=right style='border-top:none;border-left:none'
  x:num><%=dtMaster.Rows[0]["TOT_AMT_BEFORE_DEPOSIT"].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl26 style='height:12.75pt'>Currentcy:</td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["CCY"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Party Type:</td>
  <td class=xl33 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["PARTY_TYPE"].ToString()%></td>
  <td colspan=2 class=xl26 style='border-left:none'>Advance:</td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num><%=dtMaster.Rows[0]["DEPOSIT_AMT"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Debt:</td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["REMAIN_AMT"].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl26 style='height:12.75pt'>Customer ID:</td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["CUSTOMER_ID"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Promotion:</td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dtMaster.Rows[0]["PROMOTION_AMT"].ToString()%></td>
  <td colspan=2 class=xl26 style='border-left:none'>Mobile:</td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["MOBILE"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Telehhone:</td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["PHONE"].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl26 style='height:12.75pt'>Status:</td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["STATUS"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Email:</td>
  <td class=xl33 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["EMAIL"].ToString()%></td>
  <td colspan=2 class=xl26 style='border-left:none'>Contact:</td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["CONTACT_PERSON"].ToString()%></td>
  <td class=xl26 style='border-top:none;border-left:none'>Fax:</td>
  <td class=xl25 style='border-top:none;border-left:none'><%=dtMaster.Rows[0]["FAX"].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl26 style='height:12.75pt'>Address:</td>
  <td colspan=7 class=xl50 style='border-left:none'><%=dtMaster.Rows[0]["ADDRESS"].ToString()%></td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl26 style='height:12.75pt'>Description:</td>
  <td colspan=8 class=xl50 style='border-left:none'><%=dtMaster.Rows[0]["DESCRIPTION"].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl51 style='height:12.75pt'>Menu Food:</td>
  <td colspan=8 class=xl52>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none'>No</td>
  <td class=xl27 style='border-top:none;border-left:none'>Item Code</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>Item Name</td>
  <td class=xl27 style='border-top:none;border-left:none'>Unit</td>
  <td class=xl27 style='border-top:none;border-left:none'>Price</td>
  <td class=xl27 style='border-top:none;border-left:none'>Quantity</td>
  <td class=xl27 style='border-top:none;border-left:none' x:str="Amount ">Amount<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27 style='border-top:none;border-left:none'>Description</td>
 </tr>
 <%
     for (int i = 0; i < dt_Food.Rows.Count; i++)
     {
          %>  
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt;border-top:none' x:num><%=i+1%></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt_Food.Rows[i][4]%></td>
  <td colspan=3 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Food.Rows[i][5]%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%=dt_Food.Rows[i][7]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Food.Rows[i][8]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Food.Rows[i][10]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt_Food.Rows[i][11]%></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_Food.Rows[i][12]%></td>
 </tr>
 <%}%>
 <tr height=17 style='height:12.75pt'>   
  <td colspan=2 height=17 class=xl42 style='height:12.75pt'>Beverages</td>
  <td colspan=8 class=xl49>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none'>No</td>
  <td class=xl27 style='border-top:none;border-left:none'>Item Code</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>Item Name</td>
  <td class=xl27 style='border-top:none;border-left:none'>Unit</td>
  <td class=xl27 style='border-top:none;border-left:none'>Price</td>
  <td class=xl27 style='border-top:none;border-left:none'>Quantity</td>
  <td class=xl27 style='border-top:none;border-left:none' x:str="Amount ">Amount<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27 style='border-top:none;border-left:none'>Description</td>
 </tr>
 <%
     for (int j = 0; j < dt_Beverage.Rows.Count; j++)
     {
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt;border-top:none' x:num><%=j+1%></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt_Beverage.Rows[j][3]%></td>
  <td colspan=3 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Beverage.Rows[j][4]%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%=dt_Beverage.Rows[j][6]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Beverage.Rows[j][7]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Beverage.Rows[j][9]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt_Beverage.Rows[j][10]%></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_Beverage.Rows[j][11]%></td>
 </tr>
 <%}%>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl42 style='height:12.75pt'>Service Other</td>
  <td colspan=8 class=xl49>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none'>No</td>
  <td class=xl27 style='border-top:none;border-left:none'>Item Code</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>Item Name</td>
  <td class=xl27 style='border-top:none;border-left:none'>Unit</td>
  <td class=xl27 style='border-top:none;border-left:none'>Price</td>
  <td class=xl27 style='border-top:none;border-left:none'>Quantity</td>
  <td class=xl27 style='border-top:none;border-left:none' x:str="Amount ">Amount<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27 style='border-top:none;border-left:none'>Description</td>
 </tr>
 <%
     for (int k = 0; k < dt_service_Other.Rows.Count; k++)
     {
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt;border-top:none' x:num><%=k+1%></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt_service_Other.Rows[k][3]%></td>
  <td colspan=3 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%=dt_service_Other.Rows[k][4]%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%=dt_service_Other.Rows[k][6]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'
  x:num><%=dt_service_Other.Rows[k][7]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'
  x:num><%=dt_service_Other.Rows[k][9]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt_service_Other.Rows[k][10]%></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_service_Other.Rows[k][11]%></td>  
 </tr>
 <%}%>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl42 style='height:12.75pt'>Promotion</td>
  <td colspan=8 class=xl49>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none'>No</td>
  <td class=xl27 style='border-top:none;border-left:none'>Item Code</td>
  <td colspan=3 class=xl43 style='border-right:.5pt solid black;border-left:
  none'>Item Name</td>
  <td class=xl27 style='border-top:none;border-left:none'>Unit</td>
  <td class=xl27 style='border-top:none;border-left:none'>Price</td>
  <td class=xl27 style='border-top:none;border-left:none'>Quantity</td>
  <td class=xl27 style='border-top:none;border-left:none' x:str="Amount ">Amount<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl27 style='border-top:none;border-left:none'>Description</td>
 </tr>
  <%
     for (int h = 0; h < dt_Promotion.Rows.Count; h++)
     {
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl35 style='height:12.75pt;border-top:none' x:num><%=h+1%></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt_Promotion.Rows[h][3]%></td>
  <td colspan=3 class=xl46 style='border-right:.5pt solid black;border-left:
  none'><%=dt_Promotion.Rows[h][4]%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%=dt_Promotion.Rows[h][6]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Promotion.Rows[h][7]%></td>
  <td class=xl37 align=right style='border-top:none;border-left:none'
  x:num><%=dt_Promotion.Rows[h][9]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt_Promotion.Rows[h][10]%></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_Promotion.Rows[h][11]%></td>
 </tr>
 <%}%>
 <tr height=85 style='height:63.75pt;mso-xlrowspan:5'>
  <td height=85 colspan=10 style='height:63.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=35 style='width:26pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=112 style='width:84pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
