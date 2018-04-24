<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("crm");%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string p_tht_shift_close_pk = Request.QueryString["tht_shift_close_pk"];
        
    DataTable dt01 = ESysLib.TableReadOpenCursor("crm.sp_rpt_htfo00120",  p_tht_shift_close_pk );    
    
    DataTable dt = ESysLib.TableReadOpenCursor("crm.sp_rpt_htfo00120_1", p_tht_shift_close_pk );
    
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
 %>
 
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_htfo00120_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_htfo00120_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_htfo00120_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>VINAGENUWIN</o:Author>
  <o:LastAuthor>VINAGENUWIN</o:LastAuthor>
  <o:LastPrinted>2010-12-18T02:45:50Z</o:LastPrinted>
  <o:Created>2010-12-18T02:36:11Z</o:Created>
  <o:LastSaved>2010-12-18T02:47:09Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .38in 1.0in .41in;
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
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
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowWidth>16155</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=694 style='border-collapse:
 collapse;table-layout:fixed;width:524pt'>
 <col width=90 span=7 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col width=64 style='width:48pt'>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=7 height=40 class=xl29 width=630 style='height:30.0pt;width:476pt'>SONG
  GIA Golf Resort</td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=80 style='mso-height-source:userset;height:60.0pt'>
  <td colspan=7 height=80 class=xl28 style='height:60.0pt'>Cashier Cloure</td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl30 style='height:18.75pt' x:str="Date : ">Date
  :<span style='mso-spacerun:yes'><%=dt01.Rows[0]["close_date"].ToString()%></span></td>
  <td colspan=2 class=xl30 x:str="Shift : ">Shift :<span
  style='mso-spacerun:yes'><%=dt01.Rows[0]["shift"].ToString()%></span></td>
  <td colspan=3 class=xl30 x:str="Crt Dt / By : ">Crt Dt / By :<span
  style='mso-spacerun:yes'><%=dt01.Rows[0]["crt_dt_by"].ToString()%></span></td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=3 height=25 class=xl27 style='height:18.75pt'>&nbsp;</td>
  <td colspan=2 class=xl31 style='border-left:none'>USD</td>
  <td colspan=2 class=xl31 style='border-left:none'>VND</td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=3 height=25 class=xl25 style='height:18.75pt'>Open</td>
  <td colspan=2 class=xl26 style='border-left:none' x:num="1224324">1,224,324.00</td>
  <td colspan=2 class=xl26 style='border-left:none' x:num="324325325">324,325,325.00</td>
  <td></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=3 height=25 class=xl25 style='height:18.75pt'>&nbsp;</td>
  <td colspan=2 class=xl26 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl26 style='border-left:none'>&nbsp;</td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
