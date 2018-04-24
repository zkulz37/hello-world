<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%
    string slipno="",fullname="",doc_date="",description="";
    string Linemattakeout_pk="";
    
    Linemattakeout_pk = Request.QueryString["takeout_pk"];
    
    DataTable dt,dt1;
    
    dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00050_simone", "'" + Linemattakeout_pk + "'");
    if(dt.Rows.Count >0)
    {
        slipno=dt.Rows[0]["slip_no"].ToString();
        fullname=dt.Rows[0]["full_name"].ToString();
        doc_date=dt.Rows[0]["doc_date"].ToString();
        description=dt.Rows[0]["description"].ToString();
    }
    
    dt1 = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00050_simone_1", "'" + Linemattakeout_pk + "'");
 %>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epfm00050_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epfm00050_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epfm00050_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HRSV1</o:Author>
  <o:LastAuthor>HRSV1</o:LastAuthor>
  <o:LastPrinted>2009-11-17T06:24:58Z</o:LastPrinted>
  <o:Created>2009-11-17T03:55:28Z</o:Created>
  <o:LastSaved>2009-11-17T06:25:22Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.76in .13in 1.0in .23in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
.style22
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
.xl25
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl35
	{mso-style-parent:style22;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl37
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Delivery Order</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>84</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
       <x:RangeSelection>$G$14:$G$15</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Delivery Order'!$A$1:$M$41</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1143 style='border-collapse:
 collapse;table-layout:fixed;width:859pt'>
 <col width=75 span=2 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col width=143 style='mso-width-source:userset;mso-width-alt:5229;width:107pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=160 style='mso-width-source:userset;mso-width-alt:5851;width:120pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 colspan=5 width=440 style='height:12.75pt;
  mso-ignore:colspan;width:330pt'>SIMONE ACCESSORIES COLLECTION VIETNAM LIMITED</td>
  <td class=xl26 width=63 style='width:47pt'></td>
  <td class=xl26 width=74 style='width:56pt'></td>
  <td class=xl26 width=89 style='width:67pt'></td>
  <td class=xl26 width=61 style='width:46pt'></td>
  <td class=xl26 width=84 style='width:63pt'></td>
  <td class=xl26 width=90 style='width:68pt'></td>
  <td class=xl26 width=82 style='width:62pt'></td>
  <td class=xl26 width=160 style='width:120pt'></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td colspan=13 height=35 class=xl35 style='height:26.25pt'>Delivery Order</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl26 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=5 height=36 class=xl37 style='height:27.0pt'>Voucher No . <%= slipno %></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27>Charger</td>
  <td class=xl27 style='border-left:none'>Manager</td>
  <td class=xl27 style='border-left:none'>Chief</td>
  <td class=xl27 style='border-left:none'>Director</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=5 height=29 class=xl37 style='height:21.75pt'>Charger : <%= fullname %></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl28 style='border-top:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl28 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=5 height=27 class=xl37 style='height:20.25pt'>Takeout Date : <%= doc_date %></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
  <td class=xl29 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl26 style='height:21.0pt'>Remark :</td>
  <td colspan=5 class=xl36><%= description %></td>
  <td colspan=7 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl26 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=20 style='height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'>Order No.</td>
  <td class=xl32 style='border-left:none'>Style No.</td>
  <td class=xl32 style='border-left:none'>Vendor</td>
  <td class=xl32 style='border-left:none'>Item code</td>
  <td class=xl32 style='border-left:none'>Item Name</td>
  <td class=xl32 style='border-left:none'>Spec</td>
  <td class=xl32 style='border-left:none'>Color ID</td>
  <td class=xl32 style='border-left:none'>Color Name</td>
  <td class=xl32 style='border-left:none'>UOM</td>
  <td class=xl32 style='border-left:none'>Take in Qty</td>
  <td class=xl32 style='border-left:none'>Unit weight</td>
  <td class=xl32 style='border-left:none'>Weight</td>
  <td class=xl32 style='border-left:none'>Remark</td>
 </tr>
 
 <%
     for (int i = 0; i <= dt1.Rows.Count - 1; i++)
     {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl30 style='height:12.75pt;border-top:none'><%= dt1.Rows[i]["order_no"].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt1.Rows[i]["style_code"].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt1.Rows[i]["partner_name"].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%= dt1.Rows[i]["item_code"].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt1.Rows[i]["item_name"].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec"].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt1.Rows[i]["color_id"].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt1.Rows[i]["color_name"].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt1.Rows[i]["item_unit"].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'x:num><%= (dt1.Rows[i]["takeout_qty"].ToString()) %></td>
  <td class=xl30 style='border-top:none;border-left:none'x:num><%= dt1.Rows[i]["weight"].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'x:num><%= dt1.Rows[i]["total_weight"].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none'><%= dt1.Rows[i]["description"].ToString() %></td>
 </tr>
 
 
 <%
    }
  %>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl26 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=13 class=xl26 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl26 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl34>Takeout person:</td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>Udertake Person:</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=160 style='width:120pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
