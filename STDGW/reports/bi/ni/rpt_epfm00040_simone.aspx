<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("inv");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<%
    string LineMatReqPK="";
    LineMatReqPK = Request.QueryString["LineReqMat_PK"];
    
    string slipno="",factory_name="",req_date="",description="";
    DataTable dt,dt1;
    dt = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00040_simone", "'" + LineMatReqPK + "'");
    if(dt.Rows.Count >0)
    {
        slipno=dt.Rows[0]["slip_no"].ToString();
        factory_name=dt.Rows[0]["factory_name"].ToString();
        req_date=dt.Rows[0]["req_date"].ToString();
        description=dt.Rows[0]["description"].ToString();
    }
    
    dt1 = ESysLib.TableReadOpenCursor("INV.sp_rpt_epfm00040_simone_1", "'" + LineMatReqPK + "'");
 %>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epfm00040_simone10_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epfm00040_simone10_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epfm00040_simone10_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HRSV1</o:Author>
  <o:LastAuthor>HRSV1</o:LastAuthor>
  <o:LastPrinted>2009-11-16T08:13:37Z</o:LastPrinted>
  <o:Created>2009-11-16T02:54:48Z</o:Created>
  <o:LastSaved>2009-11-16T08:14:13Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.54in .04in 1.0in .52in;
	mso-header-margin:.38in;
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
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
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
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:20.0pt;}
.xl46
	{mso-style-parent:style0;
	mso-number-format:0;
	text-align:left;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl51
	{mso-style-parent:style0;
	text-align:left;}
.xl52
	{mso-style-parent:style0;
	text-align:left;}
.xl53
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl54
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>MAT REQ Report</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>71</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9345</x:WindowHeight>
  <x:WindowWidth>11340</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='MAT REQ Report'!$A$1:$L$64</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1160 style='border-collapse:
 collapse;table-layout:fixed;width:874pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=126 style='mso-width-source:userset;mso-width-alt:4608;width:95pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2560;width:53pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=65 span=2 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <col width=64 style='width:48pt'>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=6 height=18 class=xl49 width=553 style='height:13.5pt;width:417pt'>SIMONE
  ACCESSORIES COLLECTION VIETNAM LIMITED</td>
  <td width=92 style='width:69pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=44 style='mso-height-source:userset;height:33.0pt'>
  <td colspan=11 height=44 class=xl54 style='height:33.0pt'>TAKE OUT MATERIAL
  REQUEST</td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 style='height:25.5pt'>Vorcher No:</td>
  <td></td>
  <td colspan=4 class=xl53>*<%= slipno %>*</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl28>&nbsp;</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl52 style='height:22.5pt'>Charger : <%= factory_name %></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl33>Charger</td>
  <td class=xl30 style='border-top:none'>Manager</td>
  <td class=xl37 style='border-left:none'>Chief</td>
  <td class=xl33 style='border-left:none'>Director</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl32></td>
  <td></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=2 height=32 class=xl52 style='height:24.0pt'>Takeout Date : <%= req_date %><span style='mso-spacerun:yes'> </span></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 style='height:22.5pt'>Remark:</td>
  <td colspan=5 class=xl51><%= description %></td>
  <td></td>
  <td class=xl27>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl27 style='border-left:none'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl47 style='height:19.5pt'>Order No.</td>
  <td class=xl47 style='border-left:none'>Style No.</td>
  <td class=xl47 style='border-left:none'>Item code</td>
  <td class=xl47 style='border-left:none'>Item Name</td>
  <td class=xl47 style='border-left:none'>Spec</td>
  <td class=xl47 style='border-left:none'>Color ID</td>
  <td class=xl47 style='border-left:none'>Color Name</td>
  <td class=xl47 style='border-left:none'>UOM</td>
  <td class=xl47 style='border-left:none'>Req Qty</td>
  <td class=xl47 style='border-left:none'>Modify_Qty</td>
  <td class=xl48 style='border-left:none'>Remark</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl38></td>
  <td></td>
 </tr>
 
  <%
     for (int i = 0; i <= dt1.Rows.Count - 1; i++)
     {
  %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl43 style='height:16.5pt;border-top:none'><%= dt1.Rows[i]["order_no"].ToString() %></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt1.Rows[i]["style_code"].ToString() %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["item_code"].ToString() %></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt1.Rows[i]["item_name"].ToString() %></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt1.Rows[i]["spec"].ToString() %></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt1.Rows[i]["color_id"].ToString() %></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt1.Rows[i]["color_name"].ToString() %></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt1.Rows[i]["item_unit"].ToString() %></td>
  <td class=xl43 align=right style='border-top:none;border-left:none' x:num><%= dt1.Rows[i]["req_qty"].ToString() %></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt1.Rows[i]["modify_qty"].ToString() %></td>
  <td class=xl43 style='border-top:none;border-left:none'><%= dt1.Rows[i]["description"].ToString() %></td>
  <td class=xl41 style='border-left:none'>&nbsp;</td>
  <td class=xl39></td>
  <td></td>
 </tr>
 
 <%
    }
  %>
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl51></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=2 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td></td>
  <td class=xl31></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl32></td>
  <td colspan=2 class=xl51></td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=86 style='width:65pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
