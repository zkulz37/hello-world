<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("inv");%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	
 %>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_takeout_pk = "", pk_takeout = "", takeout = "", l_Delivered = "", l_Recieved = "", l_Accountant = "", l_Warehouse="";
    DataTable dt,dt1,dt2;
    l_takeout_pk  = Request.QueryString["takeout_pk"]; 
    string sql= " SELECT a.pk, a.tco_company_pk, a.slip_no, to_char(to_date(a.doc_date,'yyyymmdd'),'yyyy/MM/dd') doc_date," +
                " a.linetakein_emp_pk,"+
                " hr.sf_get_emp_id_name (a.linetakein_emp_pk, 1) linein_emp,"+
                " a.description,tco_bpphoto_pk, partner_name"+
                " FROM inv.tin_linemattakeout a, comm.tco_company b"+
                " WHERE a.del_if = 0 "+
                "       AND a.pk IN ("+l_takeout_pk+")"+
                "       AND b.del_if(+) = 0 " +
                "       and a.tco_company_pk = b.pk(+) " ;
    dt = ESysLib.TableReadOpen(sql);
    dt2 = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00050_4", "'"+l_Delivered+"'");
    if (dt2.Rows.Count > 0)
    {
        l_Delivered = dt2.Rows[0]["Deliveredby"].ToString();
        l_Recieved = dt2.Rows[0]["Receivedby"].ToString();
        l_Accountant = dt2.Rows[0]["Accountant"].ToString();
        l_Warehouse = dt2.Rows[0]["Warehouse"].ToString();
    }     
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epfm00050_YC_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epfm00050_YC_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epfm00050_YC_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>HRSV1</o:LastAuthor>
  <o:LastPrinted>2009-11-28T04:10:01Z</o:LastPrinted>
  <o:Created>2009-11-26T10:00:35Z</o:Created>
  <o:LastSaved>2009-11-28T04:12:26Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in .24in .17in .62in;
	mso-header-margin:.17in;
	mso-footer-margin:.17in;}
.font7
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-size:11.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dot-dot-dash windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dot-dot-dash windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;}
.xl45
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>94</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <% 
        int irow=0;
        for(int k=0; k<dt.Rows.Count;k+=2) 
        {
        irow=irow+59;
     %> 
      <x:RowBreak>
       <x:Row><%=irow %></x:Row>
      </x:RowBreak>
      <%} %> 
     </x:RowBreaks>
    </x:PageBreaks>
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
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>14715</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>615</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=713 style='border-collapse:
 collapse;table-layout:fixed;width:535pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=64 span=2 style='width:48pt'>
 <col width=189 style='mso-width-source:userset;mso-width-alt:6912;width:142pt'>
 <col width=64 style='width:48pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=64 style='width:48pt'>
 <col width=132 style='mso-width-source:userset;mso-width-alt:4827;width:99pt'>
 <%
for(int i=0;i<dt.Rows.Count;i += 2)
{
    takeout=dt.Rows[i]["pk"].ToString();
    dt1= ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00050_3", takeout);
 %>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 colspan=4 width=366 style='height:14.25pt;
  mso-ignore:colspan;width:275pt'><%=dt.Rows[i]["partner_name"] %></td>
  <td width=64 style='width:48pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=132 style='width:99pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
   margin-left:0;margin-top:1.5pt;width:199.5pt;height:30pt;z-index:1;
   mso-position-horizontal-relative:char;mso-position-vertical-relative:line'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:2px;width:266px;
  height:40px'><img width=266 height=40 
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=49 style='height:12.75pt;width:37pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=8 style='height:14.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=8 height=27 class=xl44 style='height:20.25pt'>PHI&#7870;U
  XU&#7844;T KHO</td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=8 height=27 class=xl44 style='height:20.25pt'>MATERIAL OUTGOING</td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=8 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl25 colspan=2 style='height:14.25pt;mso-ignore:colspan'>S&#7889; /No :<%=dt.Rows[i]["slip_no"] %><span
  style='mso-spacerun:yes'>        </span></td>
  <td class=xl26></td>
  <td class=xl27></td>
  <td class=xl26></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Date<span style='mso-spacerun:yes'>   </span>:<%=dt.Rows[i]["doc_date"]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26></td>
  <td class=xl27></td>
  <td class=xl26></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=4 style='height:15.0pt;mso-ignore:colspan'>Xu&#7845;t
  cho BP<font class="font7"> Delivery to :<%=dt.Rows[i]["linein_emp"] %></font></td>
  <td class=xl26></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=3 style='height:15.0pt;mso-ignore:colspan'>M&#7909;c
  &#273;ích <font class="font7">Purpose<span style='mso-spacerun:yes'>         
  </span>:<%=dt.Rows[i]["description"] %></font></td>
  <td class=xl27></td>
  <td class=xl26></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl30 style='height:12.95pt'>STT</td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black;border-left:
  none'>Mã hàng</td>
  <td class=xl31 style='border-left:none'>Lo&#7841;i hàng</td>
  <td class=xl30>&#272;vt</td>
  <td class=xl30 style='border-left:none'>S&#7889; l&#432;&#7907;ng</td>
  <td class=xl30 style='border-left:none'>Lô</td>
  <td class=xl30 style='border-left:none'>Ghi chú</td>
 </tr>
 <tr class=xl26 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl32 style='height:12.95pt'>No</td>
  <td colspan=2 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>Item Code</td>
  <td class=xl33 style='border-left:none'>Item Name</td>
  <td class=xl32>Unit</td>
  <td class=xl32 style='border-left:none'>Quantity</td>
  <td class=xl32 style='border-left:none'>Lot no</td>
  <td class=xl32 style='border-left:none'>Note</td>
 </tr>
 <%
    int k;
    for( k=0;k<dt1.Rows.Count;k++)
    {
 %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl34 style='height:13.5pt;border-top:none' x:num><%=k+1 %></td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'><%= dt1.Rows[k]["item_code"] %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%= dt1.Rows[k]["item_name"] %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%= dt1.Rows[k]["item_unit"] %></td>
  <td class=xl35 style='border-top:none;border-left:none'x:num><%= dt1.Rows[k]["takeout_qty"] %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%= dt1.Rows[k]["lot_no"] %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%= dt1.Rows[k]["description"] %></td>
 </tr>
 <%   
    }
  %>
 <%
    for(int j=k; j<10;j++)
    {
  %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl34 style='height:13.5pt;border-top:none' x:num></td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
 }
  %>
 
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl36 width=49 style='height:9.0pt;width:37pt'><!--[if gte vml 1]><v:shape
   id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;margin-left:0;
   margin-top:0;width:341.25pt;height:0;z-index:2'>
   <v:imagedata croptop="-65520f" cropbottom="65520f"/>
  </v:shape><![endif]--></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=3 height=34 class=xl37 width=177 style='height:25.5pt;width:133pt'>Ng&#432;&#7901;i
  Xu&#7845;t <br>
    Delivered by</td>
  <td class=xl38 width=189 style='width:142pt'>Ng&#432;&#7901;i
  nh&#7853;n<br>
    Received by</td>
  <td colspan=2 class=xl37 width=151 style='width:113pt'>K&#7871; toán<br>
    Accountant</td>
  <td colspan=2 class=xl37 width=196 style='width:147pt'>Th&#7911; kho<br>
    Warehouse Supervisor</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl37 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl37></td>
  <td class=xl39></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl37 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl37></td>
  <td class=xl39></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=1 style='mso-height-source:userset;height:.75pt'>
  <td height=1 colspan=3 class=xl37 style='height:.75pt;mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl37></td>
  <td class=xl39></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl37 width=177 style='height:15.0pt;width:133pt'><%=l_Delivered %></td>
  <td class=xl38 width=189 style='width:142pt'><%=l_Recieved %></td>
  <td colspan=2 class=xl37 width=151 style='width:113pt'><%=l_Accountant %></td>
  <td colspan=2 class=xl37 width=196 style='width:147pt'><%=l_Warehouse %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl36 style='height:15.0pt'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=1 style='mso-height-source:userset;height:.75pt'>
  <td height=1 class=xl40 style='height:.75pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <%
    if(i<dt.Rows.Count-1)
    {
        takeout=dt.Rows[i+1]["pk"].ToString();
        dt1= ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00050_3", takeout);
 %>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 colspan=4 style='height:14.25pt;mso-ignore:colspan'><%=dt.Rows[i+1]["partner_name"] %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1027" type="#_x0000_t75" style='position:absolute;margin-left:0;
   margin-top:1.5pt;width:199.5pt;height:30pt;z-index:3;
   mso-position-horizontal-relative:char;mso-position-vertical-relative:line'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:2px;width:266px;
  height:40px'><img width=266 height=40 
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i+1]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=49 style='height:12.75pt;width:37pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=8 style='height:14.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=8 height=27 class=xl44 style='height:20.25pt'>PHI&#7870;U
  XU&#7844;T KHO</td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=8 height=27 class=xl44 style='height:20.25pt'>MATERIAL OUTGOING</td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=8 style='height:6.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl25 colspan=2 style='height:14.25pt;mso-ignore:colspan'>S&#7889; /No :<%=dt.Rows[i+1]["slip_no"] %><span
  style='mso-spacerun:yes'>        </span></td>
  <td class=xl26></td>
  <td class=xl27></td>
  <td class=xl26></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl28 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Date<span style='mso-spacerun:yes'>   </span>:<%=dt.Rows[i+1]["doc_date"]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26></td>
  <td class=xl27></td>
  <td class=xl26></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=4 style='height:15.0pt;mso-ignore:colspan'>Xu&#7845;t
  cho BP<font class="font7"> Delivery to :<%=dt.Rows[i+1]["linein_emp"] %></font></td>
  <td class=xl26></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=3 style='height:15.0pt;mso-ignore:colspan'>M&#7909;c
  &#273;ích <font class="font7">Purpose<span style='mso-spacerun:yes'>         
  </span>:<%=dt.Rows[i+1]["description"] %></font></td>
  <td class=xl27></td>
  <td class=xl26></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl30 style='height:12.95pt'>STT</td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black;border-left:
  none'>Mã hàng</td>
  <td class=xl31 style='border-left:none'>Lo&#7841;i hàng</td>
  <td class=xl30>&#272;vt</td>
  <td class=xl30 style='border-left:none'>S&#7889; l&#432;&#7907;ng</td>
  <td class=xl30 style='border-left:none'>Lô</td>
  <td class=xl30 style='border-left:none'>Ghi chú</td>
 </tr>
 <tr class=xl26 height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl32 style='height:12.95pt'>No</td>
  <td colspan=2 class=xl33 style='border-right:.5pt solid black;border-left:
  none'>Item Code</td>
  <td class=xl33 style='border-left:none'>Item Name</td>
  <td class=xl32>Unit</td>
  <td class=xl32 style='border-left:none'>Quantity</td>
  <td class=xl32 style='border-left:none'>Lot no</td>
  <td class=xl32 style='border-left:none'>Note</td>
 </tr>
 <%
    for( k=0;k<dt1.Rows.Count;k++)
    {
  %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl34 style='height:13.5pt;border-top:none' x:num><%=k+1 %></td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'><%= dt1.Rows[k]["item_code"] %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%= dt1.Rows[k]["item_name"] %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%= dt1.Rows[k]["item_unit"] %></td>
  <td class=xl35 style='border-top:none;border-left:none'x:num><%= dt1.Rows[k]["takeout_qty"] %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%= dt1.Rows[k]["lot_no"] %></td>
  <td class=xl35 style='border-top:none;border-left:none'><%= dt1.Rows[k]["description"] %></td>
 </tr>
 <%
    }
  %>
  <%
    for(int j=k; j<10;j++)
    {
  %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl34 style='height:13.5pt;border-top:none' x:num></td>
  <td colspan=2 class=xl42 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%} %>
 
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl36 width=49 style='height:9.0pt;width:37pt'><!--[if gte vml 1]><v:shape
   id="_x0000_s1028" type="#_x0000_t75" style='position:absolute;margin-left:0;
   margin-top:0;width:341.25pt;height:0;z-index:4'>
   <v:imagedata croptop="-65520f" cropbottom="65520f"/>
  </v:shape><![endif]--></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=3 height=34 class=xl37 width=177 style='height:25.5pt;width:133pt'>Ng&#432;&#7901;i
  Xu&#7845;t <br>
    Delivered by</td>
  <td class=xl38 width=189 style='width:142pt'>Ng&#432;&#7901;i
  nh&#7853;n<br>
    Received by</td>
  <td colspan=2 class=xl37 width=151 style='width:113pt'>K&#7871; toán<br>
    Accountant</td>
  <td colspan=2 class=xl37 width=196 style='width:147pt'>Th&#7911; kho<br>
    Warehouse Supervisor</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl37 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl37></td>
  <td class=xl39></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl37 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl37></td>
  <td class=xl39></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=1 style='mso-height-source:userset;height:.75pt'>
  <td height=1 colspan=3 class=xl37 style='height:.75pt;mso-ignore:colspan'></td>
  <td class=xl38></td>
  <td class=xl37></td>
  <td class=xl39></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=3 height=20 class=xl37 width=177 style='height:15.0pt;width:133pt'><%=l_Delivered%></td>
  <td class=xl38 width=189 style='width:142pt'><%=l_Recieved%></td>
  <td colspan=2 class=xl37 width=151 style='width:113pt'><%=l_Accountant%></td>
  <td colspan=2 class=xl37 width=196 style='width:147pt'><%=l_Warehouse%></td>
 </tr>
 <%
        } 
     %>
 <%
}
 %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=49 style='width:37pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=189 style='width:142pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=132 style='width:99pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
