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
              
                string  p_Project_pk = Request["p_Project_pk"];
                string p_Project_Nm = Request["Project_Nm"];
                string  p_level_code = Request["p_level_code"];
				
                string l_parameter = "'" +  p_Project_pk + "','" +  p_level_code + "'";
                DataTable dt = ESysLib.TableReadOpenCursor("EC111.sp_sel_kpsh512_tab2", l_parameter);
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
<link rel=File-List href="kpsh512_item_code_inquiry_files/filelist.xml">
<link rel=Edit-Time-Data href="kpsh512_item_code_inquiry_files/editdata.mso">
<link rel=OLE-Object-Data href="kpsh512_item_code_inquiry_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-09-07T07:02:34Z</o:LastPrinted>
  <o:Created>2008-09-17T04:07:31Z</o:Created>
  <o:LastSaved>2011-09-07T07:04:20Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.9999</o:Version>
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
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
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	color:red;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Level Code List</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>67</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
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
       <x:ActiveRow>6</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
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
  <x:Formula>='Level Code List'!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1124 style='border-collapse:
 collapse;table-layout:fixed;width:843pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl24 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl24 width=180 span=3 style='mso-width-source:userset;mso-width-alt:
 6582;width:135pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1133'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl40 width=431 style='height:15.75pt;
  width:324pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl25 width=75 style='width:56pt'></td>
  <td class=xl25 width=43 style='width:32pt'></td>
  <td class=xl26 width=215 style='width:161pt'></td>
  <td class=xl26 width=0></td>
 </tr>
 <tr class=xl32 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=10 height=31 class=xl42 style='height:23.25pt'>PROGRESS ITEM CODE LIST</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=5 height=21 class=xl41 style='height:15.75pt'>Project: <%=p_Project_Nm %></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=64 style='mso-height-source:userset;height:48.0pt'>
  <td height=64 class=xl28 width=31 style='height:48.0pt;width:23pt'>No.</td>
  <td class=xl29 width=110 style='width:83pt'>Parent Code</td>
  <td class=xl29 width=110 style='width:83pt'>Progress Item Code</td>
  <td class=xl29 width=180 style='width:135pt'>Progress Item Name</td>
  <td class=xl29 width=180 style='width:135pt'>Local Name</td>
  <td class=xl30 width=180 style='width:135pt'>Foreign Name</td>
  <td class=xl30 width=75 style='width:56pt'>Level</td>
  <td class=xl30 width=43 style='width:32pt' x:str="Leaf  Y/N  ">Leaf<span
  style='mso-spacerun:yes'>  </span>Y/N<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl30 width=215 style='width:161pt'>Description</td>
  <td class=xl31 width=0>&nbsp;</td>
 </tr>
 <%
 	string  strColor = "";
	string  strBegin="";
	string  strEnd="";
    for (int i = 0; i < dt.Rows.Count; i++)
    {
        strBegin = "";
        strEnd = "";
        strColor = "";
        if (dt.Rows[i][9].ToString() == "0")
        {
            strBegin = "<b>";
            strEnd = "</b>";
            strColor = "background:#FFCC99";
        }
        if (dt.Rows[i][8].ToString() == "2" && dt.Rows[i][9].ToString() == "0")
        {
            strBegin = "<b>";
            strEnd = "</b>";
            strColor = "background:#CCFFCC";
        }
        if (dt.Rows[i][8].ToString() == "3" && dt.Rows[i][9].ToString() == "0")
        {
            strColor = "background:#00FFCC";
        }
        if (dt.Rows[i][8].ToString() == "4" && dt.Rows[i][9].ToString() == "0")
        {
            strColor = "background:#CC99FF";
        }
        if (dt.Rows[i][8].ToString() == "5" && dt.Rows[i][9].ToString() == "0")
        {
            strColor = "background:#9999CC";
        }
        if (dt.Rows[i][8].ToString() == "6" && dt.Rows[i][9].ToString() == "0")
        {
            strColor = "background:#339900";
        }
        if (dt.Rows[i][8].ToString() == "7" && dt.Rows[i][9].ToString() == "0")
        {
            strColor = "background:#3366CC";
        }
        if (dt.Rows[i][8].ToString() == "8" && dt.Rows[i][9].ToString() == "0")
        {
            strColor = "background:#666600";
        }
        if (dt.Rows[i][9].ToString() == "-1")
        {
            strColor = "background:#FFFFFF";
        }
				
 %>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt;<%= strColor %>'><%= strBegin%><%=i + 1%><%= strEnd%></td>
  <td class=xl34 width=110 style='width:83pt;<%= strColor %>'><%= strBegin%><%=dt.Rows[i][3]%><%= strEnd%></td>
  <td class=xl34 width=110 style='width:83pt;<%= strColor %>'><%= strBegin%><%=dt.Rows[i][4]%><%= strEnd%></td>
  <td class=xl35 width=180 style='width:135pt;<%= strColor %>'><%= strBegin%><%=dt.Rows[i][5]%><%= strEnd%></td>
  <td class=xl35 width=180 style='width:135pt;<%= strColor %>'><%= strBegin%><%=dt.Rows[i][6]%><%= strEnd%></td>
  <td class=xl35 width=180 style='width:135pt;<%= strColor %>'><%= strBegin%><%=dt.Rows[i][7]%><%= strEnd%></td>
  <td class=xl36 style='<%= strColor %>'><%= strBegin%><%=dt.Rows[i][12]%><%= strEnd%></td>
  <td class=xl37 style='<%= strColor %>'><%if (dt.Rows[i][9].ToString() == "-1")
                                           {%>þ<%}
                                           else
                                           { %>¨<%} %></td>
  <td class=xl35 width=215 style='width:161pt;<%= strColor %>'><%= strBegin%><%=dt.Rows[i][10]%><%= strEnd%></td>
  <td class=xl39>&nbsp;</td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=0></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
