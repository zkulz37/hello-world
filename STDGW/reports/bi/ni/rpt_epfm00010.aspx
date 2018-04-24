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
    string  l_voucherlist = "", l_voucher_pk="";
    string l_PurchsingDept = "", l_Storekeeper = "", l_FactManager = "";
    l_voucherlist = Request.QueryString["voucherlist"];
    DataTable dtDlt, dtSng;
    
    string SQL
    = "SELECT a.pk, a.tco_company_pk, a.slip_no,  " +
        "        to_char(to_date(a.doc_date,'yyyymmdd'),'yyyy/MM/dd') doc_date, " +
        "        tco_bpphoto_pk, partner_name " +
        "        FROM inv.tin_mattakein a, comm.tco_company b " +
        "       WHERE a.del_if = 0 " +
        "         AND b.del_if(+) = 0 " +
        "         and a.tco_company_pk = b.pk(+) " +
        "         AND a.pk in (" + l_voucherlist + ")";
    DataTable dt = ESysLib.TableReadOpen(SQL);
    dtSng = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00010_4");
    if (dtSng.Rows.Count > 0)
    {
        l_FactManager = dtSng.Rows[0]["FactManager"].ToString();
        l_PurchsingDept = dtSng.Rows[0]["PurchsingDept"].ToString();
        l_Storekeeper = dtSng.Rows[0]["Storekeeper"].ToString();
    }
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epfm00010_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epfm00010_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epfm00010_files/oledata.mso">
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
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2009-11-27T02:37:35Z</o:LastPrinted>
  <o:Created>2009-11-27T02:27:41Z</o:Created>
  <o:LastSaved>2009-11-27T02:41:20Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .25in .28in .52in;
	mso-header-margin:.28in;
	mso-footer-margin:.21in;}
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
	mso-style-id:0;
	}
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
	font-size:16.0pt;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
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
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	text-align:center;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	text-align:center;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dot-dot-dash windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dot-dot-dash windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	mso-number-format:"_\(* \#\,\#\#0\_\)\;_\(* \\\(\#\,\#\#0\\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}	
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
      <x:Scale>93</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>39</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>46</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$47:$E$47</x:RangeSelection>
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
        irow=irow+60;
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1029"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=734 style='border-collapse:
 collapse;table-layout:fixed;width:551pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=64 style='width:48pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=112 style='mso-width-source:userset;mso-width-alt:4096;width:84pt'>
 <%
     for (int i = 0; i < dt.Rows.Count; i += 2)
     {
  %>
  <%
      l_voucher_pk = dt.Rows[i]["pk"].ToString();
       dtDlt = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00010_3", l_voucher_pk);
   %>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl24 colspan=4 width=302 style='height:14.25pt;
  mso-ignore:colspan;width:227pt'><%=dt.Rows[i]["partner_name"]%></td>
  <td width=88 style='width:66pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=112 style='width:84pt'></td>
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
   margin-left:0;margin-top:1.5pt;width:217.5pt;height:30pt;z-index:1;
   mso-position-horizontal-relative:char;mso-position-vertical-relative:line'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:2px;width:290px;
  height:40px'><img width=290 height=40 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=58 style='height:12.75pt;width:44pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=9 style='height:14.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=9 height=27 class=xl25 style='height:20.25pt'>PHI&#7870;U
  NH&#7852;P KHO</td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=9 height=27 class=xl25 style='height:20.25pt'>MATERIAL INCOMING</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 colspan=2 style='height:14.25pt;mso-ignore:colspan'
  x:str>S&#7889; /No :<%=dt.Rows[i]["slip_no"]%></td>
  <td class=xl27></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=2 style='height:15.0pt;mso-ignore:colspan'
  x:str>Ngày/Date :<%=dt.Rows[i]["doc_date"]%></td>
  <td class=xl27></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl29 style='height:9.0pt'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl30 style='height:14.1pt'>STT</td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black;border-left:
  none'>Mã hàng</td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black;border-left:
  none'>Lo&#7841;i hàng</td>
  <td class=xl30 style='border-left:none'>&#272;vt</td>
  <td class=xl30 style='border-left:none'>S&#7889; l&#432;&#7907;ng</td>
  <td class=xl30 style='border-left:none'>Ngày nh&#7853;p</td>
  <td class=xl30 style='border-left:none'>Ghi chú</td>
 </tr>
 <tr class=xl27 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl33 style='height:14.1pt'>No</td>
  <td colspan=2 class=xl34 style='border-right:.5pt solid black;border-left:
  none'>Item Code</td>
  <td colspan=2 class=xl34 style='border-right:.5pt solid black;border-left:
  none'>Item Name</td>
  <td class=xl33 style='border-left:none'>Unit</td>
  <td class=xl33 style='border-left:none'>Quantity</td>
  <td class=xl33 style='border-left:none'>Date</td>
  <td class=xl33 style='border-left:none'>Note</td>
 </tr>
 <%
         int k;
    for( k=0;k<dtDlt.Rows.Count;k++)
    {
  %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl36 style='height:13.5pt;border-top:none' x:num><%=k+1 %></td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'><%=dtDlt.Rows[k]["item_code"] %></td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'><%=dtDlt.Rows[k]["item_name"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dtDlt.Rows[k]["item_unit"]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=dtDlt.Rows[k]["takein_qty"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dtDlt.Rows[k]["takein_date"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dtDlt.Rows[k]["description"]%></td>
 </tr>
 <%} %>
 <%
    for(int j=k; j<12;j++)
    {
  %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl36 style='height:13.5pt;border-top:none' x:num></td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%} %>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl40 width=58 style='height:9.0pt;width:44pt'><!--[if gte vml 1]><v:shape
   id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;margin-left:0;
   margin-top:0;width:367.5pt;height:0;z-index:2'>
   <v:imagedata croptop="-65520f" cropbottom="65520f"/>
  </v:shape><![endif]--></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 style='height:27.0pt'></td>
  <td colspan=3 class=xl41 width=244 style='width:183pt'>Phòng k&#7871;
  ho&#7841;ch v&#7853;t t&#432; <br>
    Purchasing Dept</td>
  <td colspan=3 class=xl41 width=241 style='width:181pt'>Th&#7911; kho<br>
    Storekeeper</td>
  <td colspan=2 class=xl41 width=191 style='width:143pt'>Th&#7911; kho<br>
    Warehouse Supervisor</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td colspan=3 class=xl41 width=244 style='width:183pt'><%=l_PurchsingDept %></td>
  <td colspan=3 class=xl41 width=241 style='width:181pt'><%=l_Storekeeper %></td>
  <td colspan=2 class=xl41 width=191 style='width:143pt'><%=l_FactManager %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt'>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <%
    if(i<dt.Rows.Count-1)
    {
        l_voucher_pk = dt.Rows[i+1]["pk"].ToString();
         dtDlt = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00010_3", l_voucher_pk);    
 %>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl24 colspan=4 style='height:30.0pt;mso-ignore:colspan'><%=dt.Rows[i + 1]["partner_name"]%></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1027" type="#_x0000_t75" style='position:absolute;margin-left:0;
   margin-top:1.5pt;width:217.5pt;height:30pt;z-index:3;
   mso-position-horizontal-relative:char;mso-position-vertical-relative:line'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:3;margin-left:0px;margin-top:2px;width:290px;
  height:40px'><img width=290 height=40 src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[i]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto"
  v:shapes="_x0000_s1027"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=58 style='height:12.75pt;width:44pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=9 style='height:14.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=9 height=27 class=xl25 style='height:20.25pt'>PHI&#7870;U
  NH&#7852;P KHO</td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=9 height=27 class=xl25 style='height:20.25pt'>MATERIAL INCOMING</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 colspan=2 style='height:14.25pt;mso-ignore:colspan'
  x:str>S&#7889; /No :<%=dt.Rows[i + 1]["slip_no"]%></td>
  <td class=xl27></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=2 style='height:15.0pt;mso-ignore:colspan'
  x:str>Ngày/Date :<%=dt.Rows[i + 1]["doc_date"]%></td>
  <td class=xl27></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl29 style='height:9.0pt'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl30 style='height:14.1pt'>STT</td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black;border-left:
  none'>Mã hàng</td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black;border-left:
  none'>Lo&#7841;i hàng</td>
  <td class=xl30 style='border-left:none'>&#272;vt</td>
  <td class=xl30 style='border-left:none'>S&#7889; l&#432;&#7907;ng</td>
  <td class=xl30 style='border-left:none'>Ngày nh&#7853;p</td>
  <td class=xl30 style='border-left:none'>Ghi chú</td>
 </tr>
 <tr class=xl27 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl33 style='height:14.1pt'>No</td>
  <td colspan=2 class=xl34 style='border-right:.5pt solid black;border-left:
  none'>Item Code</td>
  <td colspan=2 class=xl34 style='border-right:.5pt solid black;border-left:
  none'>Item Name</td>
  <td class=xl33 style='border-left:none'>Unit</td>
  <td class=xl33 style='border-left:none'>Quantity</td>
  <td class=xl33 style='border-left:none'>Date</td>
  <td class=xl33 style='border-left:none'>Note</td>
 </tr>
 <%
    
    for( k=0;k<dtDlt.Rows.Count;k++)
    {
  %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl36 style='height:13.5pt;border-top:none' x:num><%=k+1 %></td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'><%=dtDlt.Rows[k]["item_code"] %></td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'><%=dtDlt.Rows[k]["item_name"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dtDlt.Rows[k]["item_unit"]%></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%=dtDlt.Rows[k]["takein_qty"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dtDlt.Rows[k]["takein_date"]%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dtDlt.Rows[k]["description"]%></td>
 </tr>
 <%} %>
 <%
    for(int j=k; j<12;j++)
    {
  %>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl36 style='height:13.5pt;border-top:none' x:num></td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%} %>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl40 width=58 style='height:9.0pt;width:44pt'><!--[if gte vml 1]><v:shape
   id="_x0000_s1028" type="#_x0000_t75" style='position:absolute;margin-left:0;
   margin-top:0;width:367.5pt;height:0;z-index:4'>
   <v:imagedata croptop="-65520f" cropbottom="65520f"/>
  </v:shape><![endif]--></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 style='height:27.0pt'></td>
  <td colspan=3 class=xl41 width=244 style='width:183pt'>Phòng k&#7871;
  ho&#7841;ch v&#7853;t t&#432; <br>
    Purchasing Dept</td>
  <td colspan=3 class=xl41 width=241 style='width:181pt'>Th&#7911; kho<br>
    Storekeeper</td>
  <td colspan=2 class=xl41 width=191 style='width:143pt'>Th&#7911; kho<br>
    Warehouse Supervisor</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td class=xl43></td>
  <td colspan=2 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td colspan=3 class=xl41 width=244 style='width:183pt'><%=l_PurchsingDept %></td>
  <td colspan=3 class=xl41 width=241 style='width:181pt'><%=l_Storekeeper %></td>
  <td colspan=2 class=xl41 width=191 style='width:143pt'><%=l_FactManager %></td>
 </tr>
    <%
        } //  close if statement 
     %>
 <%
     }     
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=58 style='width:44pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=112 style='width:84pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
