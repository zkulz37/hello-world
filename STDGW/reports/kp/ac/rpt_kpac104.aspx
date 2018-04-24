<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_TCO_COMPANY_PK = Request["p_company_pk"];
    string p_partner_pk = Request["p_partner_pk"];
    string p_capacity_type = Request["p_capacity_type"];
    string p_capacity_cdnm = Request["p_capacity_cdnm"];
    string p_construction = Request["p_construction"];
	string p_fabrication = Request["p_fabrication"];
	string p_equipment = Request["p_equipment"];
	string p_material = Request["p_material"];

	string l_parameter = "'" + p_TCO_COMPANY_PK + "', ";
    l_parameter += "'" + p_partner_pk + "', ";
    l_parameter += "'" + p_capacity_type + "', ";
    l_parameter += "'" + p_capacity_cdnm + "', ";
	l_parameter += "'" + p_construction + "', ";
	l_parameter += "'" + p_fabrication + "', ";
	l_parameter += "'" + p_equipment + "', ";
	l_parameter += "'" + p_material + "' ";

	
    DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_kpac104", l_parameter);
 %>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_kpac104_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_kpac104_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_kpac104_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AILINH</o:Author>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:LastPrinted>2008-06-27T08:58:06Z</o:LastPrinted>
  <o:Created>2008-06-27T08:12:14Z</o:Created>
  <o:LastSaved>2011-12-26T01:57:27Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.3in .2in .2in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;
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
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:justify;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:justify;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:justify;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	vertical-align:justify;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:justify;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:justify;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:justify;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
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
      <x:ValidPrinterInfo/>
      <x:Scale>62</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
  <x:WindowHeight>9630</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1813 style='border-collapse:
 collapse;table-layout:fixed;width:1360pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=263 style='mso-width-source:userset;mso-width-alt:9618;width:197pt'>
 <col width=205 span=2 style='mso-width-source:userset;mso-width-alt:7497;
 width:154pt'>
 <col width=120 style='mso-width-source:userset;mso-width-alt:4388;width:90pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=148 style='mso-width-source:userset;mso-width-alt:5412;width:111pt'>
 <col width=129 style='mso-width-source:userset;mso-width-alt:4717;width:97pt'>
 <col width=64 span=8 style='width:48pt'>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td colspan=9 height=49 class=xl31 width=1301 style='height:36.75pt;
  width:976pt'>LIST OF BUSINESS PARTNER</td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl28 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl32 width=40 style='height:23.25pt;border-top:none;
  width:30pt'>No</td>
  <td class=xl33 width=87 style='border-top:none;width:65pt'>Partner ID</td>
  <td class=xl33 width=263 style='border-top:none;width:197pt'>Partner Name</td>
  <td class=xl33 width=205 style='border-top:none;width:154pt'>Address</td>
  <td class=xl33 width=205 style='border-top:none;width:154pt'>Charger</td>
  <td class=xl33 width=120 style='border-top:none;width:90pt'>Phone</td>
  <td class=xl33 width=104 style='border-top:none;width:78pt'>Fax</td>
  <td class=xl33 width=148 style='border-top:none;width:111pt'>Website</td>
  <td class=xl33 width=129 style='border-top:none;width:97pt'>Taxcode</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
<%
 for (int i = 0; i < dt.Rows.Count; i++)
{
 %> 

	 <tr class=xl30 height=42 style='height:31.5pt'>
	  <td height=42 class=xl34 align=right width=40 style='height:31.5pt;
	  width:30pt' x:num><%= i+1 %></td>
	  <td class=xl35 width=87 style='width:65pt'><%=dt.Rows[i]["partner_id"]%></td>
	  <td class=xl35 width=263 style='width:197pt'><%=dt.Rows[i]["partner_name"]%></td>
	  <td class=xl35 width=205 style='width:154pt'><%=dt.Rows[i]["ADDR1"]%> </td>
	  <td class=xl35 width=205 style='width:154pt'><%=dt.Rows[i]["charger"]%></td>
	  <td class=xl35 width=120 style='width:90pt'><%=dt.Rows[i]["PHONE_NO"]%></td>
	  <td class=xl35 width=104 style='width:78pt'><%=dt.Rows[i]["FAX_NO"]%></td>
	  <td class=xl35 width=148 style='width:111pt'><%=dt.Rows[i]["WEB_SITE"]%></td>
	  <td class=xl36 width=129 style='width:97pt'><%=dt.Rows[i]["TAX_CODE"]%> </td>
	  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
	 </tr>
<% }%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=263 style='width:197pt'></td>
  <td width=205 style='width:154pt'></td>
  <td width=205 style='width:154pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=148 style='width:111pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
