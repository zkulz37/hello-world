<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  
    ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<% 
    string wi_pk = "", wi_no = "", wi_dt = "", po_no = "", charger = "", style = "", remark = "";
    DataTable dt,dt1;
    wi_pk = Request.QueryString["sopk"];
    dt = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsep00070", "'" + wi_pk + "'");
    if (dt.Rows.Count > 0)
    {
        wi_pk = dt.Rows[0]["pk"].ToString();
        wi_no = dt.Rows[0]["wi_no"].ToString();
        wi_dt = dt.Rows[0]["wi_date"].ToString();
        po_no = dt.Rows[0]["ref_po_no"].ToString();
        charger = dt.Rows[0]["full_name"].ToString();
        style = dt.Rows[0]["style"].ToString();
        remark = dt.Rows[0]["description"].ToString();
    }
    dt1 = ESysLib.TableReadOpenCursor("SALE.sp_rpt_dsep00070_2", "'" + wi_pk + "'");  
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="PackingWI_files/filelist.xml">
<link rel=Edit-Time-Data href="PackingWI_files/editdata.mso">
<link rel=OLE-Object-Data href="PackingWI_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>ISA_SERVER</o:LastAuthor>
  <o:LastPrinted>2009-10-20T02:25:14Z</o:LastPrinted>
  <o:Created>2009-10-19T07:09:08Z</o:Created>
  <o:LastSaved>2009-10-20T02:27:08Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in 1.2in;
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
.xl24
	{mso-style-parent:style0;
	font-size:14.0pt;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:36px;
	mso-char-indent-count:3;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	padding-left:24px;
	mso-char-indent-count:2;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;}
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
      <x:FitWidth>0</x:FitWidth>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$A$1:$E$10</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=649 style='border-collapse:
 collapse;table-layout:fixed;width:487pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:4352;width:89pt'>
 <col width=64 style='width:48pt'>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=5 height=32 class=xl30 width=585 style='height:24.0pt;width:439pt'><a
  name="Print_Area">PACKING WORK INSTRUCTION</a></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>WI NO</td>
  <td><%= wi_no %></td>
  <td></td>
  <td class=xl26>WI DATE</td>
  <td class=xl27 ><%= wi_dt %></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>P/O No</td>
  <td><%= po_no %></td>
  <td></td>
  <td class=xl26>Charger</td>
  <td><%= charger %></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>Style</td>
  <td colspan=4 style='mso-ignore:colspan'><%= style %></td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'>Remark</td>
  <td class=xl28><%= remark %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt'>Packing Type</td>
  <td class=xl29>Packages Type</td>
  <td class=xl29>Label Type</td>
  <td class=xl29>Package Qty</td>
  <td><span style='mso-spacerun:yes'> </span></td>
  <td></td>
 </tr>
 <%
     for (int i = 0; i <= dt1.Rows.Count - 1; i++)
     {
  %>
 
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 style='height:15.0pt'><%= dt1.Rows[i]["type_code"]%></td>
  <td><%= dt1.Rows[i]["cover_code"]%></td>
  <td><%= dt1.Rows[i]["label_code"]%></td>
  <td align=right x:num><%= dt1.Rows[i]["package_qty"]%></td>
  <td><span style='mso-spacerun:yes'> </span></td>
  <td></td>
 </tr>
 <%          
     }
   
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 style='height:12.75pt;mso-ignore:colspan'></td>
  <td><span style='mso-spacerun:yes'> </span></td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=114 style='width:86pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
