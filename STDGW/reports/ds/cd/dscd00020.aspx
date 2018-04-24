<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
  <%
  string tsa_sotakeoutreq_pk ;
  string SQL ;
  int i;      
      tsa_sotakeoutreq_pk = "" +Request["req_pk"];   
	
      
  SQL = " SELECT '*W' || a.REQ_NO || '*', b.partner_name, b.addr1,to_char(to_Date(a.TAKEOUT_DATE,'yyyymmdd'),'dd/mm/yyyy') ";
  SQL += "  FROM tsa_sotakeoutreq a, comm.tco_buspartner b ";
  SQL += " WHERE a.del_if = 0 ";
  SQL += "   AND b.del_if = 0 ";
  SQL += "   AND a.tco_buspartner_pk = b.pk(+) ";
  SQL += "   AND a.pk = " + tsa_sotakeoutreq_pk;
  
  DataTable dt = ESysLib.TableReadOpen(SQL); 
	
    SQL = "";
    SQL += " SELECT   b.item_code, b.item_name, REQ_QTY, a.att11, ";
    SQL += "         ATT09 packing_roll, ";
    SQL += "          a.att03 || '(' || a.att04 || ')' rackno ";
    SQL += "    FROM tsa_sotakeoutreqd a, comm.tco_item b ";
    SQL += "   WHERE a.del_if = 0 ";
    SQL += "     AND b.del_if = 0 ";
    SQL += "     AND a.TCO_ITEM_PK = b.pk ";
    SQL += "     AND a.TSA_SOTAKEOUTREQ_PK = "+ tsa_sotakeoutreq_pk;
    
  DataTable dtDetail = ESysLib.TableReadOpen(SQL); 
      
  %>
    
   <head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="dscd00020_files/filelist.xml">
<link rel=Edit-Time-Data href="dscd00020_files/editdata.mso">
<link rel=OLE-Object-Data href="dscd00020_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2008-04-29T04:21:57Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2008-04-29T04:24:55Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .5in .75in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-size:18.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	text-align:center;}
.xl47
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl54
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
      <x:Scale>86</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>5</x:ActiveCol>
       <x:RangeSelection>$F$1:$G$1</x:RangeSelection>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=768 style='border-collapse:
 collapse;table-layout:fixed;width:577pt'>
 <col width=30 style='mso-width-source:userset;mso-width-alt:1097;width:23pt'>
 <col width=137 style='mso-width-source:userset;mso-width-alt:5010;width:103pt'>
 <col width=255 style='mso-width-source:userset;mso-width-alt:9325;width:191pt'>
 <col width=64 style='width:48pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=192 style='mso-width-source:userset;mso-width-alt:7021;width:144pt'>
   <% 
       if (dt.Rows.Count > 0)
       {
           for (i = 0; i < dt.Rows.Count; i++)
           {  %>
     
 <tr class=xl24 height=39 style='height:29.25pt'>
  <td height=39 width=30 style='height:29.25pt;width:23pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:9pt;margin-top:0;width:149.25pt;height:52.5pt;z-index:1'>
   <v:imagedata src="dscd00020_files/image001.jpg" o:title="18092007(014)"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:12px;margin-top:0px;width:199px;
  height:73px'><img width=199 height=73 src="dscd00020_files/image003.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=39 class=xl24 width=30 style='height:29.25pt;width:23pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 width=137 style='width:103pt'></td>
  <td colspan=3 class=xl47 width=352 style='width:264pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Y&#234;u c&#7847;u xu&#7845;t kho</td>
  <td colspan=2 class=xl54 width=249 style='width:187pt'><%=dt.Rows[i][0].ToString()%></td>
 </tr>
 <tr class=xl24 height=31 style='height:23.25pt'>
  <td height=31 colspan=2 class=xl24 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl48>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TAKE OUT REQUEST</td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>L&#244; K-3-CN,KCN M&#7929; Ph&#432;&#7899;c 2 Huy&#7879;n B&#7871;n C&#225;t
  T&#7881;nh B&#236;nh D&#432;&#417;ng</td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>&#272;T: 0650-3556017. Fax:
  0650-3556017</td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 colspan=3 style='height:12.75pt;mso-ignore:colspan'>T&#234;n
  kh&#225;ch h&#224;ng (Customer name):<%=dt.Rows[i][1].ToString()%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 colspan=3 style='height:12.75pt;mso-ignore:colspan'>&#272;&#7883;a
  ch&#7883;(Address): <%=dt.Rows[i][2].ToString()%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'>Ng&#224;y(Date):<%=dt.Rows[i][3].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>STT</td>
  <td class=xl29>M&#227; h&#224;ng ho&#225; </td>
  <td class=xl30>Chi ti&#7871;t h&#224;ng ho&#225;</td>
  <td rowspan=2 class=xl29 style='border-bottom:.5pt solid black'>Quantity</td>
  <td rowspan=2 class=xl29 style='border-bottom:.5pt solid black'>Unit</td>
  <td class=xl30 x:str="Packing ">Packing<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl29 style='border-bottom:.5pt solid black'>Rack No</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'>No.</td>
  <td class=xl32>Goods Code</td>
  <td class=xl33>Goods description</td>
  <td class=xl33>(Roll)</td>
 </tr>
 <% int j;
    double sumQty, sumPack, qty, pack;
    sumQty = 0;
    qty = 0;
    sumPack = 0;
    pack = 0;
    if (dtDetail.Rows.Count > 0)
    {
        for (j = 0; j < dtDetail.Rows.Count; j++)
        {

            if (dtDetail.Rows[j][2].ToString() != "")
                qty = double.Parse(dtDetail.Rows[j][2].ToString());
            else
                qty = 0;
            
            if (dtDetail.Rows[j][4].ToString() != "")
                pack = double.Parse(dtDetail.Rows[j][4].ToString());
            sumQty = sumQty + qty;
            sumPack = sumPack + pack;
      %>
  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt' x:num><%=j + 1%></td>
  <td class=xl36><%=dtDetail.Rows[j][0].ToString()%></td>
  <td class=xl36><%=dtDetail.Rows[j][1].ToString()%></td>
  <td class=xl36 align=right x:num><%=dtDetail.Rows[j][2].ToString()%></td>
  <td class=xl38><%=dtDetail.Rows[j][3].ToString()%></td>
  <td class=xl36 align=right x:num><%=dtDetail.Rows[j][4].ToString()%></td></td>
  <td class=xl36><%=dtDetail.Rows[j][5].ToString()%></td>
 </tr>
 <% 
       }
   }
        %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=3 height=27 class=xl50 style='border-right:.5pt solid black;
  height:20.25pt'>TOTAL</td>
  <td class=xl43 align=right x:num><%=sumQty%></td>
  <td class=xl44></td>
  <td class=xl43 align=right x:num><%=sumPack%></td>
  <td class=xl45>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl37 colspan=2 style='mso-ignore:colspan'>* X&#225;c nh&#7853;n/ confirmed by</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl37>Gi&#225;m &#273;&#7889;c/Manager</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td></td>
  <td class=xl46>B&#7843;o v&#7879;/ Security</td>
 </tr>
 <tr height=68 style='height:51.0pt;mso-xlrowspan:4'>
  <td height=68 colspan=7 style='height:51.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl46>B&#234;n v&#7853;n chuy&#7875;n/ Transporter</td>
 </tr>
 <%
       }
   }
        %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=255 style='width:191pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=192 style='width:144pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>