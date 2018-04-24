<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("crm");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string name = Request.QueryString["p_name"];
    DataTable dt;
    dt = ESysLib.TableReadOpenCursor("CRM.sp_sel_jast00070_rpt", "'" + name + "'");
    //string sql = "select to_char(to_date('" + dtbook + "','yyyymmdd'),'dd/mm/yyyy'),to_char(to_date('" + today + "','yyyymmdd'),'dd/mm/yyyy') from dual";
    //dt1 = ESysLib.TableReadOpen(sql);
    //string booking_dt = dt1.Rows[0][0].ToString();
    //string to_day = dt1.Rows[0][1].ToString();
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_golfer_profile1_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_golfer_profile1_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_golfer_profile1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2010-07-23T02:30:10Z</o:LastPrinted>
  <o:Created>2010-07-23T01:25:37Z</o:Created>
  <o:LastSaved>2010-07-23T02:53:47Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.51in .17in .5in .17in;
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
	font-size:16.0pt;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1654 style='border-collapse:
 collapse;table-layout:fixed;width:1242pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=163 style='mso-width-source:userset;mso-width-alt:5961;width:122pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=146 style='mso-width-source:userset;mso-width-alt:5339;width:110pt'>
 <col width=166 style='mso-width-source:userset;mso-width-alt:6070;width:125pt'>
 <col width=163 style='mso-width-source:userset;mso-width-alt:5961;width:122pt'>
 <col width=179 style='mso-width-source:userset;mso-width-alt:6546;width:134pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=64 span=4 style='width:48pt'>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=12 height=31 class=xl28 width=1398 style='height:23.25pt;
  width:1050pt'>Golfer Profile List</td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>No</td>
  <td class=xl25 style='border-left:none'>Golfer Name</td>
  <td class=xl25 style='border-left:none'>Birthday</td>
  <td class=xl25 style='border-left:none'>Mobile Phone</td>
  <td class=xl25 style='border-left:none'>Telephone</td>
  <td class=xl25 style='border-left:none'>Home Address</td>
  <td class=xl25 style='border-left:none'>Company Name</td>
  <td class=xl25 style='border-left:none'>Company Address</td>
  <td class=xl25 style='border-left:none'>Comp. Phone</td>
  <td class=xl25 style='border-left:none'>Hoby</td>
  <td class=xl25 style='border-left:none'>Tax code</td>
  <td class=xl25 style='border-left:none'>Description</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][0]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][5]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][6]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][7]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][8]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][9]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][11]%></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=163 style='width:122pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=146 style='width:110pt'></td>
  <td width=166 style='width:125pt'></td>
  <td width=163 style='width:122pt'></td>
  <td width=179 style='width:134pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
