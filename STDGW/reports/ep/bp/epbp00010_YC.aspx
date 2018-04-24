<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("prod");%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string master_pk="";
	master_pk	=	Request["master_pk"];
	
    string SQL
	= "select a.MR_NO , c.ITEM_NAME, b.SPEC, b.ITEM_UNIT, b.REQ_QTY,b.DESCRIPTION,to_char(to_date(a.DOC_DATE,'YYYYMMDD'),'dd/mm/yyyy'),d.DEPT_NM " + 
        "from prod.tpr_poreq a, prod.tpr_poreqd b, " +
        "comm.tco_item c,comm.tco_dept d " +
        "where a.DEL_IF =0 and b.DEL_IF =0 " +
        "and c.DEL_IF =0 " +
        "and d.DEL_IF =0 " +
        "and b.TCO_ITEM_PK = c.PK " +
        "and a.pk = b.TPR_POREQ_PK " +
        "and a.TCO_DEPT_PK = d.pk " +
        "and a.pk = " + master_pk  ;
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if ( dt.Rows.Count < 1 )
        {
            return ;
        }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="epbp00010_YC_files/filelist.xml">
<link rel=Edit-Time-Data href="epbp00010_YC_files/editdata.mso">
<link rel=OLE-Object-Data href="epbp00010_YC_files/oledata.mso">
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
  <o:LastPrinted>2009-04-21T06:02:58Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2009-04-23T01:57:12Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .5in .5in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-horizontal-page-align:center;}
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
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl47
	{mso-style-parent:style0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>259</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>36</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>57</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=711 style='border-collapse:
 collapse;table-layout:fixed;width:535pt'>
 <col width=35 style='mso-width-source:userset;mso-width-alt:1280;width:26pt'>
 <col width=160 style='mso-width-source:userset;mso-width-alt:5851;width:120pt'>
 <col width=174 style='mso-width-source:userset;mso-width-alt:6363;width:131pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=142 style='mso-width-source:userset;mso-width-alt:5193;width:107pt'>
 <col width=64 style='width:48pt'>
 
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 colspan=3 width=369 style='height:12.95pt;mso-ignore:colspan;
  width:277pt'>CÔNG TY CỔ PHẦN NHỰA YOUL CHON VINA</td>
  <td width=54 style='width:41pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 style='height:12.95pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
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
   margin-left:0;margin-top:0;width:205.5pt;height:24pt;z-index:1'>
   <v:imagedata src="epbp00010_YC_files/image002.gif" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:274px;
  height:32px'><img width=274 height=32 src="epbp00010_YC_files/image002.gif"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=35 style='height:12.95pt;width:26pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td>BM 07 /KHVT</td>
  <td></td>
 </tr>
 <tr height=34 style='height:25.9pt;mso-xlrowspan:2'>
  <td height=34 colspan=7 style='height:25.9pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=6 height=17 class=xl46 style='height:12.95pt'>PHIẾU ĐỀ NGHỊ MUA
  HÀNG</td>
  <td></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=6 height=17 class=xl46 style='height:12.95pt'>PURCHASING REQUEST
  FORM</td>
  <td></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=6 height=17 class=xl47 style='height:12.95pt'>Số/ No:<%=dt.Rows[0][0] %></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.95pt'>
  <td height=17 colspan=7 style='height:12.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td colspan=6 height=17 class=xl41 style='border-right:.5pt solid black;
  height:12.95pt'>Đơn vị yêu cầu - Department:<%=dt.Rows[0][7] %></td>
  <td></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl36 style='height:12.95pt'>Stt</td>
  <td class=xl33>Tên vật tư</td>
  <td class=xl32>Thông số kỹ thuật</td>
  <td class=xl32>Đvt</td>
  <td class=xl32>Số lượng</td>
  <td class=xl36>Lý do sử dụng</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl37 style='height:12.95pt'>No</td>
  <td class=xl35>Item</td>
  <td class=xl34>Specification</td>
  <td class=xl34>Unit</td>
  <td class=xl34>Quantity</td>
  <td class=xl37>Purchasing Reason</td>
  <td></td>
 </tr>
 <%
    for(int i =0 ; i< dt.Rows.Count ; i++)
    {
 %>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl29 style='height:12.95pt;border-top:none'><%=i+1%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt.Rows[i][1] %></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][2] %></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][3] %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=dt.Rows[i][4] %></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i][5] %></td>
  <td></td>
 </tr>
  <%
    }
    int remain =0;
    remain = 10 - dt.Rows.Count ;
    if(remain >0)
    {
    for(int j =0 ; j< remain ; j ++)
        {
      %>
     <tr height=17 style='mso-height-source:userset;height:12.95pt'>
      <td height=17 class=xl29 style='height:12.95pt;border-top:none'>&nbsp;</td>
      <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
      <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
      <td class=xl29 style='border-top:none;border-left:none'>&nbsp;</td>
      <td class=xl40 style='border-top:none;border-left:none'>&nbsp;</td>
      <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
      <td></td>
     </tr>
     <%
        }
    }
 %>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl28 style='height:12.95pt;border-top:none'>Ngày/<span
  style='display:none'> Date:<%=dt.Rows[0][6] %></span></td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>Ngày/Date</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>Ngày/Date:</td>
  <td></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl30 colspan=2 style='height:12.95pt;mso-ignore:colspan;
  border-right:.5pt solid black'>Người đề nghị/ Requested by</td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>Người
  kiểm tra/ Head of Department</td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'>Người
  xét duyệt/ Approved by</td>
  <td></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl24 style='height:12.95pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl24 style='height:12.95pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl24 style='height:12.95pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl24 style='height:12.95pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl26 style='height:12.95pt'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl26 style='border-left:none'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.95pt'>
  <td height=17 class=xl38 style='height:12.95pt;border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.95pt'>
  <td height=17 colspan=7 style='height:12.95pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=35 style='width:26pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
