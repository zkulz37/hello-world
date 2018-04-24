<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("ec111");
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

    DataTable dt = ESysLib.TableReadOpenCursor("ec111.sp_rpt_kpbp913_tab2",l_parameter);
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
<link rel=File-List href="rpt_kpbp913_contract_status_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_kpbp913_contract_status_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_kpbp913_contract_status_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-05-06T01:35:57Z</o:LastPrinted>
  <o:Created>2011-05-06T01:01:01Z</o:Created>
  <o:LastSaved>2011-05-06T01:37:07Z</o:LastSaved>
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
.style23
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
	{mso-style-parent:style23;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	border:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style16;
	font-size:8.0pt;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
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
	mso-pattern:auto none;}
.xl32
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
.xl33
	{mso-style-parent:style0;
	text-align:left;}
.xl34
	{mso-style-parent:style0;
	color:red;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	border:.5pt solid windowtext;
	white-space:normal;}
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
      <x:Scale>89</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
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
       <x:ActiveRow>5</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>28</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1213 style='border-collapse:
 collapse;table-layout:fixed;width:912pt'>
 <col width=64 style='width:48pt'>
 <col width=157 style='mso-width-source:userset;mso-width-alt:5741;width:118pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=130 style='mso-width-source:userset;mso-width-alt:4754;width:98pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=111 style='mso-width-source:userset;mso-width-alt:4059;width:83pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=64 style='mso-width-source:userset;mso-width-alt:2340;width:48pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=64 style='mso-width-source:userset;mso-width-alt:2340;width:48pt'>
 <col width=62 style='mso-width-source:userset;mso-width-alt:2267;width:47pt'>
 <col width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl25 width=354 style='height:15.75pt;
  width:266pt'>POSCO E&amp;C-VIETNAM CO.,LTD</td>
  <td width=130 style='width:98pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'>Address:</td>
  <td colspan=5 class=xl33></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=14 height=31 class=xl34 style='height:23.25pt'>Project
  OutSourcing(Contract Status)</td>
  <td></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl35 style='height:14.25pt'>Project:</td>
  <td colspan=6 class=xl36><%=l_project_name%></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl30 style='height:27.0pt'>Code</td>
  <td class=xl30 style='border-top:none;border-left:none'>Order W.Div.Name</td>
  <td class=xl31 style='border-top:none;border-left:none'>Prog.Status</td>
  <td class=xl31 style='border-top:none;border-left:none'>Detail S/No</td>
  <td class=xl31 style='border-top:none;border-left:none'>SubCont.Name</td>
  <td class=xl31 style='border-top:none;border-left:none'>Currency</td>
  <td class=xl31 style='border-top:none;border-left:none'>BCWS(adj)</td>
  <td class=xl32 width=104 style='border-left:none;width:78pt'>Cont.Adw.amt
  Orig.Cont.Amt</td>
  <td class=xl31 style='border-left:none'>Change.Cont.Amt</td>
  <td class=xl32 width=40 style='border-left:none;width:30pt'>settle (Y/N)</td>
  <td class=xl31 style='border-left:none'>Reg.W.Div</td>
  <td class=xl31 style='border-left:none'>Cont.Type</td>
  <td class=xl31 style='border-left:none'>Start Date</td>
  <td class=xl31 style='border-left:none'>Exp.Date</td>
  <td></td>
 </tr>
 <%
 string  vnd_usd="";
     for (int i = 0; i < dt.Rows.Count; i++)
     {
	  if(dt.Rows[i][5].ToString()=="VND")
	 {
		vnd_usd= "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	 }
	 else  if(dt.Rows[i][5].ToString()=="USD")
	 {
		vnd_usd= "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	 }
          %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-top:none'><%=dt.Rows[i][0]%></td>
  <td class=xl37 width=157 style='border-top:none;border-left:none;width:118pt'><%=dt.Rows[i][1]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl37 width=130 style='border-top:none;border-left:none;width:98pt'><%=dt.Rows[i][4]%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i][5]%></td>
  <td class=xl29 style="mso-number-format:'<%=vnd_usd%>'" x:num><%=dt.Rows[i][6]%></td>
  <td class=xl29 style="mso-number-format:'<%=vnd_usd%>'" x:num><%=dt.Rows[i][7]%></td>
  <td class=xl29 style="mso-number-format:'<%=vnd_usd%>'" x:num><%=dt.Rows[i][8]%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i][9]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl27 style='border-top:none;border-left:none'><%=dt.Rows[i][11]%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i][12]%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dt.Rows[i][13]%></td>
  <td class=xl26></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=157 style='width:118pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
