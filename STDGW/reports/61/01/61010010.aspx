<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%
   /*string l_company;
    
    l_company   = Request["company"];
 */
	
	string SQL = " select partner_id, partner_name, partner_lname, partner_fname,addr1,phone_no,fax_no,web_site,tax_code from tco_buspartner where del_if =0";
	DataTable dt = ESysLib.TableReadOpen(SQL);
   
Response.ContentType = "application/vnd.ms-excel";
//Response.ContentType = "application/x-excel";    
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html;  charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="agic00010.aspx_files/filelist.xml">
<link rel=Edit-Time-Data href="agic00010.aspx_files/editdata.mso">
<link rel=OLE-Object-Data href="agic00010.aspx_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AILINH</o:Author>
  <o:LastAuthor>AILINH</o:LastAuthor>
  <o:LastPrinted>2008-06-27T08:58:06Z</o:LastPrinted>
  <o:Created>2008-06-27T08:12:14Z</o:Created>
  <o:LastSaved>2008-06-27T08:59:13Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.6360</o:Version>
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
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
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt hairline windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
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
       <x:ActiveRow>11</x:ActiveRow>
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
  <x:WindowHeight>8580</x:WindowHeight>
  <x:WindowWidth>19020</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1984 style='border-collapse:
 collapse;table-layout:fixed;width:1488pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=263 style='mso-width-source:userset;mso-width-alt:9618;width:197pt'>
 <col width=177 style='mso-width-source:userset;mso-width-alt:6473;width:133pt'>
 <col width=199 style='mso-width-source:userset;mso-width-alt:7277;width:149pt'>
 <col width=205 style='mso-width-source:userset;mso-width-alt:7497;width:154pt'>
 <col width=120 style='mso-width-source:userset;mso-width-alt:4388;width:90pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=148 style='mso-width-source:userset;mso-width-alt:5412;width:111pt'>
 <col width=129 style='mso-width-source:userset;mso-width-alt:4717;width:97pt'>
 <col width=64 span=8 style='width:48pt'>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td colspan=10 height=49 class=xl27 width=1472 style='height:36.75pt;
  width:1104pt'>LIST OF BUSINESS PARTNER</td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
  <td class=xl26 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt;border-top:none'>No</td>
  <td class=xl25 style='border-top:none;border-left:none'>Partner ID</td>
  <td class=xl25 style='border-top:none;border-left:none'>Partner Name</td>
  <td class=xl25 style='border-top:none;border-left:none'>Local Name</td>
  <td class=xl25 style='border-top:none;border-left:none'>Foreign name</td>
  <td class=xl25 style='border-top:none;border-left:none'>Address</td>
  <td class=xl25 style='border-top:none;border-left:none'>Phone</td>
  <td class=xl25 style='border-top:none;border-left:none'>Fax</td>
  <td class=xl25 style='border-top:none;border-left:none'>Website</td>
  <td class=xl25 style='border-top:none;border-left:none'>Taxcode</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
  <%
 for (int i = 0; i < dt.Rows.Count; i++)
{
 %> 
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 align=right style='height:15.75pt' x:num><%= i+1 %></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][0]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][5]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][6]%></td>
  <td class=xl29 style='border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl30 style='border-left:none'><%=dt.Rows[i][8]%></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <%
    }
 %> 

 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl34 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=263 style='width:197pt'></td>
  <td width=177 style='width:133pt'></td>
  <td width=199 style='width:149pt'></td>
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
