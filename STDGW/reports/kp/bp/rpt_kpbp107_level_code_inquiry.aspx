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
                string  p_company = Request["p_company"];
                string  p_Project_pk = Request["p_Project_pk"];
                string  p_level_code = Request["p_level_code"];
				
                string l_parameter = "'" +  p_company + "','" +  p_Project_pk + "','" +  p_level_code + "'";
                DataTable dt = ESysLib.TableReadOpenCursor("EC111.sp_rpt_kpbp107_1", l_parameter);
                if (dt.Rows.Count == 0)
                {
                    Response.Write("There is no data!!");
                    Response.End();
                }
				
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_kpbp107_level_code_inquiry_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_kpbp107_level_code_inquiry_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_kpbp107_level_code_inquiry_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-04-26T10:09:37Z</o:LastPrinted>
  <o:Created>2008-09-17T04:07:31Z</o:Created>
  <o:LastSaved>2011-04-26T10:10:01Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.24in .16in .17in .16in;
	mso-header-margin:.16in;
	mso-footer-margin:.16in;}
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
	font-family:Tahoma;
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
	font-family:Tahoma;
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	white-space:normal;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	color:red;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	vertical-align:middle;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;
	mso-pattern:auto none;}	
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Level Code List</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
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
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9000</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>0</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Level Code List'!$1:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=887 style='border-collapse:
 collapse;table-layout:fixed;width:666pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=170 style='mso-width-source:userset;mso-width-alt:6217;
 width:128pt'>
 <col class=xl24 width=169 style='mso-width-source:userset;mso-width-alt:6180;
 width:127pt'>
 <col class=xl24 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl24 width=64 style='mso-width-source:userset;mso-width-alt:2340;
 width:48pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1133'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl32 width=370 style='height:15.75pt;
  width:278pt'><%=dt.Rows[0][9]%></td>
  <td class=xl24 width=169 style='width:127pt'></td>
  <td class=xl24 width=137 style='width:103pt'></td>
  <td class=xl25 width=40 style='width:30pt'></td>
  <td class=xl25 width=43 style='width:32pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=0></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl33 style='height:15.75pt'>Address:</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl33 style='height:15.75pt'>M s&#7889;
  thu&#7871;:</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=10 height=31 class=xl34 style='height:23.25pt'>LEVEL CODE LIST</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=5 height=21 class=xl27 style='height:15.75pt' x:str>Project:&nbsp;&nbsp;<%=dt.Rows[0][8]%></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=64 style='mso-height-source:userset;height:48.0pt'>
  <td height=64 class=xl29 width=31 style='height:48.0pt;width:23pt'>No.</td>
  <td class=xl29 width=80 style='border-left:none;width:60pt'>Upper Level
  Code</td>
  <td class=xl29 width=89 style='border-left:none;width:67pt'>Level Code</td>
  <td class=xl29 width=170 style='border-left:none;width:128pt'>Level Name</td>
  <td class=xl29 width=169 style='border-left:none;width:127pt'>Local Level
  Name</td>
  <td class=xl29 width=137 style='border-left:none;width:103pt'>Korean Level
  Name</td>
  <td class=xl29 width=40 style='border-left:none;width:30pt'>Level</td>
  <td class=xl29 width=43 style='border-left:none;width:32pt'
  x:str="Leaf  Y/N  ">Leaf<span style='mso-spacerun:yes'> </span>Y/N<span
  style='mso-spacerun:yes'>㠠�</span></td>
  <td class=xl37></td>
  <td class=xl35 width=0>&nbsp;</td>
  <td class=xl28></td>
 </tr>
 <%
 	string  strColor = "";
	string  strBegin="";
	string  strEnd="";
			for(int i = 0; i<dt.Rows.Count;i++)
			{
				strBegin="";
				strEnd="";
				strColor = "";
				if ( dt.Rows[i][7].ToString()== "No") 
				{
					strBegin="<b>";
					strEnd="</b>";
					strColor = "background:#FFCC99";
				}
				if (dt.Rows[i][6].ToString()=="2"&&  dt.Rows[i][7].ToString()== "No") 
				{
					strBegin="<b>";
					strEnd="</b>";
					strColor = "background:#99CCFF";
				}
				if (dt.Rows[i][6].ToString()=="3"&&  dt.Rows[i][7].ToString()== "No") 
				{
					strColor = "background:#00FFCC";
				}
				if (dt.Rows[i][6].ToString()=="4"&&  dt.Rows[i][7].ToString()== "No") 
				{
					strColor = "background:#CC99FF";
				}
				if (dt.Rows[i][6].ToString()=="5"&&  dt.Rows[i][7].ToString()== "No") 
				{
					strColor = "background:#9999CC";
				}
				if (dt.Rows[i][6].ToString()==" 6"&&  dt.Rows[i][7].ToString()== "No") 
				{
					strColor = "background:#339900";
				}
				if (dt.Rows[i][6].ToString()==" 7"&&  dt.Rows[i][7].ToString()== "No") 
				{
					strColor = "background:#3366CC";
				}
				if (dt.Rows[i][6].ToString()==" 8"&&  dt.Rows[i][7].ToString()== "No") 
				{
					strColor = "background:#666600";
				}
				if (  dt.Rows[i][7].ToString()== "Yes") 
				{
					strColor = "background:#FFFFFF";
				}
				
 %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl39  style='height:15.75pt;border-top:none;<%= strColor %>' x:num><%= strBegin %><%=i+1%><%= strEnd %></td>
  <td class=xl31 style='border-top:none;border-left:none;<%= strColor %>'><%= strBegin %><%=dt.Rows[i][1]%><%= strEnd %></td>
  <td class=xl31  style='border-top:none;border-left:none;<%= strColor %>'><%= strBegin %><%=dt.Rows[i][2]%><%= strEnd %></td>
  <td class=xl30  style='border-top:none;border-left:none;<%= strColor %>'><%= strBegin %><%=dt.Rows[i][3]%><%= strEnd %></td>
  <td class=xl30  style='border-top:none;border-left:none;<%= strColor %>'><%= strBegin %><%=dt.Rows[i][4]%><%= strEnd %></td>
  <td class=xl30  style='border-top:none;border-left:none;<%= strColor %>'><%= strBegin %><%=dt.Rows[i][5]%><%= strEnd %></td>
  <td class=xl39  style='border-top:none;border-left:none;<%= strColor %>'><%= strBegin %><%=dt.Rows[i][6]%><%= strEnd %></td>
  <td class=xl39  style='border-top:none;border-left:none;<%= strColor %>'><%= strBegin %><%=dt.Rows[i][7]%><%= strEnd %></td>
  <td class=xl38></td>
  <td class=xl36 style='border-top:none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <%}%>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=170 style='width:128pt'></td>
  <td width=169 style='width:127pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=0></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
