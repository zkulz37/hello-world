<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("ec111");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string tecps_projectsumm_pk = Request["p_tecps_projectsumm_pk"];
    string p_month = Request["p_month"];
    string l_parameter = "", l_project_name = "", strdt_month = "";
    l_parameter = "'" + tecps_projectsumm_pk + "','" + p_month + "'";

    DataTable dt = ESysLib.TableReadOpenCursor("ec111.sp_rpt_kpcs315", l_parameter);
    if (dt.Rows.Count == 1)
    {
        Response.Write("There is no data");
        Response.End();
    }
    strdt_month = p_month.Substring(4, 2) + "/" + p_month.Substring(0, 4);//2009.08
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpcs315_rpt_files/filelist.xml">
<link rel=Edit-Time-Data href="kpcs315_rpt_files/editdata.mso">
<link rel=OLE-Object-Data href="kpcs315_rpt_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-06-13T09:01:21Z</o:LastPrinted>
  <o:Created>2011-06-13T02:59:11Z</o:Created>
  <o:LastSaved>2011-06-13T09:03:01Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
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
.xl76
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-rotate:-90;}
.xl81
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style43;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl88
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl89
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	color:#003366;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet5</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>53</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>51</x:TabColorIndex>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7110</x:WindowHeight>
  <x:WindowWidth>18735</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>360</x:WindowTopY>
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

<body link=blue vlink=purple class=xl76>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1920 style='border-collapse:
 collapse;table-layout:fixed;width:1443pt'>
 <col class=xl76 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl76 width=139 style='mso-width-source:userset;mso-width-alt:9083;
 width:104pt'>
 <col class=xl76 width=363 style='mso-width-source:userset;mso-width-alt:13275;
 width:272pt'>
 <col class=xl76 width=87 style='mso-width-source:userset;mso-width-alt:5181;
 width:65pt'>
 <col class=xl76 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl76 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl76 width=110 span=5 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl76 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl76 width=110 span=3 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl76 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl76 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=63 style='height:12.75pt;width:47pt' align=left
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
  </v:shapetype><v:shape id="Picture_x0020_3" o:spid="_x0000_s1025" type="#_x0000_t75"
   alt="newlogo.JPG" style='position:absolute;margin-left:0;margin-top:0;
   width:104.25pt;height:30.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="kpcs315_rpt_files/image001.jpg" o:title="newlogo"/>
   <v:path arrowok="t"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:139px;
  height:41px'><img width=139 height=41 src="kpcs315_rpt_files/image002.jpg"
  alt=newlogo.JPG v:shapes="Picture_x0020_3"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl76 width=63 style='height:12.75pt;width:47pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl76 width=139 style='width:104pt'></td>
  <td class=xl76 width=363 style='width:272pt'></td>
  <td class=xl76 width=87 style='width:65pt'></td>
  <td class=xl76 width=75 style='width:56pt'></td>
  <td class=xl76 width=75 style='width:56pt'></td>
  <td class=xl76 width=54 style='width:41pt'></td>
  <td class=xl76 width=110 style='width:83pt'></td>
  <td class=xl76 width=110 style='width:83pt'></td>
  <td class=xl76 width=110 style='width:83pt'></td>
  <td class=xl76 width=110 style='width:83pt'></td>
  <td class=xl76 width=110 style='width:83pt'></td>
  <td class=xl76 width=75 style='width:56pt'></td>
  <td class=xl76 width=110 style='width:83pt'></td>
  <td class=xl76 width=110 style='width:83pt'></td>
  <td class=xl76 width=110 style='width:83pt'></td>
  <td class=xl76 width=61 style='width:46pt'></td>
  <td class=xl76 width=48 style='width:36pt'></td>
 </tr>
 <tr height=44 style='height:33.0pt'>
  <td colspan=18 height=44 class=xl88 style='height:33.0pt'>Progress payment
  inquiry</td>
 </tr>
 <tr class=xl78 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl77 style='height:17.25pt'>Project:</td>
  <td colspan=6 class=xl89><%=dt.Rows[1][0]%></td>
  <td colspan=2 class=xl90>Progress Month:</td>
  <td colspan=3 class=xl91><%=strdt_month%></td>
  <td colspan=6 class=xl78 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=44 style='mso-height-source:userset;height:33.0pt'>
  <td rowspan=2 height=164 class=xl79 width=63 style='height:123.0pt;
  width:47pt'>Sub contract <br>
    Work Code</td>
  <td rowspan=2 class=xl79 width=139 style='border-top:none;width:104pt'>Subcontract<br>
    Work Name</td>
  <td rowspan=2 class=xl81 style='border-top:none'>Subcontractor</td>
  <td rowspan=2 class=xl92 style='border-bottom:.5pt solid black;border-top:
  none'>Contract No</td>
  <td colspan=2 class=xl79 width=150 style='border-left:none;width:112pt'>Subcontract
  <br>
    Period</td>
  <td colspan=2 class=xl79 width=164 style='border-left:none;width:124pt'>Subcontract
  <br>
    Amount</td>
  <td colspan=4 class=xl81 style='border-left:none'>Advance Payment Amount</td>
  <td colspan=4 class=xl81 style='border-left:none'>Progress Payment Amount</td>
  <td colspan=2 class=xl79 width=109 style='border-left:none;width:82pt'>P/P
  Rate</td>
 </tr>
 <tr class=xl78 height=120 style='mso-height-source:userset;height:90.0pt'>
  <td height=120 class=xl79 width=75 style='height:90.0pt;border-top:none;
  border-left:none;width:56pt'>Start<br>Date</td>
  <td class=xl79 width=75 style='border-top:none;border-left:none;width:56pt'>Finish
  <br>
    Date</td>
  <td class=xl80 style='border-top:none;border-left:none'>Currency</td>
  <td class=xl81 style='border-top:none;border-left:none'>Amount</td>
  <td class=xl79 width=110 style='border-top:none;border-left:none;width:83pt'>Paid
  <br>
    Amount</td>
  <td class=xl79 width=110 style='border-top:none;border-left:none;width:83pt'>Deduction<br>Amount<br>
    (current)</td>
  <td class=xl79 width=110 style='border-top:none;border-left:none;width:83pt'>Cumulative
  <br>
    Deduction<br>Amount</td>
  <td class=xl79 width=110 style='border-top:none;border-left:none;width:83pt'>Remain
  <br>
    Advance<br>Payment</td>
  <td class=xl79 width=75 style='border-top:none;border-left:none;width:56pt'>Finish
  <br>
    Date</td>
  <td class=xl81 style='border-top:none;border-left:none'>Current</td>
  <td class=xl81 style='border-top:none;border-left:none'>Accumulation</td>
  <td class=xl81 style='border-top:none;border-left:none'>Remain</td>
  <td class=xl81 style='border-top:none;border-left:none'>Current</td>
  <td class=xl80 style='border-top:none;border-left:none'>Accumulation</td>
 </tr>
  <%
      for (int i = 1; i < dt.Rows.Count; i++)
      {
          %>
 <tr class=xl78 height=20 style='height:15.0pt'>
  <td height=20 class=xl82 style='height:15.0pt;border-top:none'><%=dt.Rows[i][1]%></td>
  <td class=xl82 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl82 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl82 style='border-top:none;border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl94 style='border-top:none;border-left:none'><%=dt.Rows[i][5]%></td>
  <td class=xl94 style='border-top:none;border-left:none'><%=dt.Rows[i][6]%></td>
  <td class=xl84 style='border-top:none;border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][8]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][10]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][11]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][12]%></td>
  <td class=xl83 style='border-top:none;border-left:none'><%=dt.Rows[i][13]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][14]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][15]%></td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][16]%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][17]%></td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][18]%></td>
 </tr>
 <%
      }        
 %>
 <tr class=xl78 height=20 style='height:15.0pt'>
  <td height=20 colspan=18 class=xl78 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl76 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl76 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl76 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl76 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl76 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl76 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 class=xl76 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl76 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl87></td>
  <td colspan=2 class=xl76 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=63 style='width:47pt'></td>
  <td width=139 style='width:104pt'></td>
  <td width=363 style='width:272pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=48 style='width:36pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</ht