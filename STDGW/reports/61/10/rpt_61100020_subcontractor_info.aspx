<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string  tecps_projectsumm_pk = Request["p_tecps_projectsumm_pk"];
	string l_parameter="",l_budgetno="",l_project_name="",l_total="";
	 l_parameter = "'" + tecps_projectsumm_pk + "'";

     DataTable dt = ESysLib.TableReadOpenCursor("pm_rpt_61100020_tab3", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
     string SQL3 = " select PROJECTCODE||'-'|| PROJECTNAME    from TECPS_PROJECTSUMM where del_if=0 and pk='" + tecps_projectsumm_pk+ "'";
    DataTable dtproject_name = ESysLib.TableReadOpen(SQL3);
    if (dtproject_name.Rows.Count > 0)
    {
        l_project_name = dtproject_name.Rows[0][0].ToString();
    }	
	 
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_kpbp913_subcontractor_info_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_kpbp913_subcontractor_info_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_kpbp913_subcontractor_info_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-05-06T02:12:37Z</o:LastPrinted>
  <o:Created>2011-05-06T01:01:01Z</o:Created>
  <o:LastSaved>2011-05-06T02:12:51Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.21in .17in .17in .17in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
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
	font-family:Tahoma;
	mso-generic-font-family:auto;
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
	font-size:8.0pt;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style16;
	font-size:8.0pt;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	border:.5pt solid windowtext;
	white-space:normal;
	}
.xl34
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	text-align:left;}
.xl36
	{mso-style-parent:style0;
	color:red;
	font-size:16.0pt;
	vertical-align:middle;
	text-align:center;}
.xl37
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>ContractStatus</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=ContractStatus!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1094 style='border-collapse:
 collapse;table-layout:fixed;width:820pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=228 style='mso-width-source:userset;mso-width-alt:8338;width:171pt'>
 <col width=123 style='mso-width-source:userset;mso-width-alt:4498;width:92pt'>
 <col width=196 style='mso-width-source:userset;mso-width-alt:7168;width:147pt'>
 <col width=107 style='mso-width-source:userset;mso-width-alt:3913;width:80pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=192 style='mso-width-source:userset;mso-width-alt:7021;width:144pt'>
 <col width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl34 width=631 style='height:15.75pt;
  width:473pt'>POSCO E&amp;C-VIETNAM CO.,LTD</td>
  <td width=107 style='width:80pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=192 style='width:144pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Address:</td>
  <td colspan=4 class=xl35></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl36 colspan=7 style='height:23.25pt;'>Project
  OutSourcing(Subcontract info)</td>
  <td></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl32 style='height:14.25pt'>Project:</td>
  <td class=xl37><%=l_project_name%></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl29 style='height:27.0pt'>Bus.No</td>
  <td class=xl29 style='border-top:none;border-left:none'>SubCont.Name</td>
  <td class=xl30 style='border-top:none;border-left:none'>Reg.W.Div</td>
  <td class=xl30 style='border-top:none;border-left:none'>CEO'S Name</td>
  <td class=xl30 style='border-top:none;border-left:none'>Tel.No</td>
  <td class=xl30 style='border-left:none'>Fax No</td>
  <td class=xl31 width=192 style='border-left:none;width:144pt'>Head Office
  Address</td>
  <td></td>
 </tr>
 <%
	for (int i = 0; i < dt.Rows.Count; i++)
     {
 %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl33 width=228 style='border-top:none;border-left:none;width:171pt'><%=dt.Rows[i][1]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl33 width=107 style='border-top:none;border-left:none;width:80pt'><%=dt.Rows[i][4]%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:str><%=dt.Rows[i][5]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][6]%></td>
  <td class=xl25></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=84 style='width:63pt'></td>
  <td width=228 style='width:171pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=196 style='width:147pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=192 style='width:144pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
