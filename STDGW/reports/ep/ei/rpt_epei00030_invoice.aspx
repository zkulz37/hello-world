﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("imex");%>

<%
    if (Request.QueryString["random"] == null) return;
    
    string l_invoice_pk = Request.QueryString["invoice_pk"];
    string SQL;
    DataTable dtTT, dtItem;
	SQL = " select co_invoice_no , to_char(to_date(co_invoice_date ,'yyyymmdd'),'dd/mm/yyyy') as inv_date    " + 
        "        , vendor.partner_name, vendor.addr1, vendor.fax_no, vendor.phone_no, vendor.email_address    " +
        "        , nvl(ship.partner_name,comp.partner_name), nvl(ship.addr1,comp.addr1)  " +
        "        , nvl(ship.fax_no,comp.fax_no), nvl(ship.phone_no  ,comp.phone_no)  " +
        "from imex.tex_cinv_mst_a v, comm.tco_buspartner ship, comm.tco_buspartner vendor ,tco_company comp  " +
        "where v.del_if=0     " +
        "    and tco_buspartner_pk1 = ship.pk (+)   " +
        "    and tco_buspartner_pk = vendor.pk  (+)   " +
        "    and v.tco_buspartner_pk1=comp.pk(+)  " +
        "    and comp.del_if(+)=0  " +
        "    and v.pk='" + l_invoice_pk + "'" ;
    
    dtTT= ESysLib.TableReadOpen(SQL);
    
    SQL	= "select item_code, item_name,  v.unit_cd, v.u_price, v.qty  " + 
        "                , nvl(v.u_price,0)* nvl(v.qty,0)  " +
        "        from imex.tex_cinv_dtl v, comm.tco_item v2  " +
        "        where v.del_if=0   " +
        "            and v.tco_item_pk=v2.pk  " +
        "            and v.tex_cinv_mst_a_pk = '"  +  l_invoice_pk + "'"  ;
    dtItem = ESysLib.TableReadOpen(SQL);

    Response.ContentType = "application/vnd.ms-excel";
    
    Response.Buffer = false;   
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epei00030_invoice_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epei00030_invoice_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epei00030_invoice_files/oledata.mso">
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
  <o:LastPrinted>2008-06-17T09:15:35Z</o:LastPrinted>
  <o:Created>2008-06-16T09:31:43Z</o:Created>
  <o:LastSaved>2008-07-28T06:12:58Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.69in .41in 1.0in .75in;
	mso-header-margin:.41in;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
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
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>93</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=718 style='border-collapse:
 collapse;table-layout:fixed;width:540pt'>
 <col class=xl24 width=41 span=2 style='mso-width-source:userset;mso-width-alt:
 1499;width:31pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=121 style='mso-width-source:userset;mso-width-alt:4425;
 width:91pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 width=41 style='height:15.75pt;width:31pt' align=left
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
   margin-left:0;margin-top:0;width:84pt;height:45.75pt;z-index:1'>
   <v:imagedata src="rpt_epei00010_invoice_files/image001.gif" o:title="genuwin_logo"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:112px;
  height:61px'><img width=112 height=61
  src="rpt_epei00010_invoice_files/image001.gif" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl24 width=41 style='height:15.75pt;width:31pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=41 style='width:31pt'></td>
  <td class=xl24 width=72 style='width:54pt'></td>
  <td class=xl25 colspan=4 width=296 style='mso-ignore:colspan;width:222pt'><%=dtTT.Rows[0][2]%></td>
  <td class=xl24 width=57 style='width:43pt'></td>
  <td class=xl24 width=110 style='width:83pt'></td>
  <td class=xl24 width=121 style='width:91pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'><%=dtTT.Rows[0][3]%></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24>Tel:</td>
  <td class=xl24><%=dtTT.Rows[0][4]%></td>
  <td class=xl26>Fax:</td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'><%=dtTT.Rows[0][5]%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=3 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 x:str="Email: ">Email:<span style='mso-spacerun:yes'>�</span></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'><%=dtTT.Rows[0][6]%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=10 height=41 class=xl36 style='height:30.75pt'>INVOICE</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Company:</td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><%=dtTT.Rows[0][7]%></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25>Date:</td>
  <td class=xl27 ><%=dtTT.Rows[0][1]%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Address:</td>
  <td class=xl25><%=dtTT.Rows[0][8]%></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25>Invoice No:</td>
  <td class=xl25><%=dtTT.Rows[0][0]%></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'>Tel:</td>
  <td class=xl24></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><%=dtTT.Rows[0][9]%></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'>Fax:</td>
  <td class=xl24></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><%=dtTT.Rows[0][10]%></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl28 style='height:16.5pt'>NO</td>
  <td colspan=2 class=xl28 style='border-left:none'>Item Code</td>
  <td colspan=2 class=xl28 style='border-left:none'>Item Name</td>
  <td class=xl28 style='border-left:none'>Unit</td>
  <td class=xl28 style='border-left:none'>Price</td>
  <td class=xl28 style='border-left:none'>Qty</td>
  <td class=xl28 style='border-left:none'>Amount</td>
  <td class=xl28 style='border-left:none'>Remark</td>
 </tr>
  <%
    int i;
    for (i = 0; i < dtItem.Rows.Count; i++)
    {
 %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl30 style='height:17.25pt;border-top:none'><%=i + 1%></td>
  <td colspan=2 class=xl31 style='border-left:none'><%=dtItem.Rows[i][0]%></td>
  <td colspan=2 class=xl31 style='border-left:none'><%=dtItem.Rows[i][1]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dtItem.Rows[i][2]%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][3]%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][4]%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dtItem.Rows[i][5]%></td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
  <% } %>  
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=8 height=25 class=xl33 style='border-right:.5pt solid black;
  height:18.75pt'>TOTAL</td>
  <td class=xl32 style='border-top:none;border-left:none' x:num="0"
  x:fmla="=SUM(I15:I<%=14+ dtItem.Rows.Count %>)"><span style='mso-spacerun:yes'>��������������������
  </span>-<span style='mso-spacerun:yes'>�� </span></td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=121 style='width:91pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=121 style='width:91pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
