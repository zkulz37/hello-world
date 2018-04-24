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
	string l_project_pk =Request["p_project_pk"];
	string l_version  = Request["p_version"];
	string l_searchdes = Request["p_searchdes"];
    string l_parameter="",l_budgetno="";
     l_parameter = "'" + l_project_pk + "','" + l_version + "','" + l_searchdes + "'";
     DataTable dt = ESysLib.TableReadOpenCursor("EC111.sp_sel_kpbm2111", l_parameter);
    if (dt.Rows.Count == 1)
    {
        Response.Write("There is no data");
        Response.End();
    }
    string SQL2 = " SELECT  a.budgetdocnum FROM tecps_performbudgetbasc a WHERE  a.del_if = 0 AND a.pk ='" + l_version+ "'";
    DataTable dtBudgetNo = ESysLib.TableReadOpen(SQL2);
    if (dtBudgetNo.Rows.Count > 0)
    {
        l_budgetno = dtBudgetNo.Rows[0][0].ToString();
    }
    
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_kpbm2111_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_kpbm2111_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_kpbm2111_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCVINA002</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-07-06T03:12:45Z</o:LastPrinted>
  <o:Created>2011-03-24T12:11:25Z</o:Created>
  <o:LastSaved>2011-07-06T03:13:47Z</o:LastSaved>
  <o:Company>VINA</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P";
	margin:.17in .16in .16in .17in;
	mso-header-margin:.16in;
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
	color:red;
	font-size:28.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style16;
	font-size:11.0pt;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style16;
	font-size:11.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style16;
	font-size:11.0pt;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
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
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>53</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>200</x:VerticalResolution>
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
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>27</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
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
  <x:Formula>=Sheet1!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1944 style='border-collapse: collapse;table-layout:fixed;width:1456pt'>
 <col width=116 style='mso-width-source:userset;mso-width-alt:4242;width:87pt'>
 <col width=180  style='mso-width-source:userset;mso-width-alt:6582; width:135pt;'>
 <col width=180 style='mso-width-source:userset;mso-width-alt:6582; width:135pt;display:none'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=131 span=4 style='mso-width-source:userset;mso-width-alt:4790; width:98pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2633;width:54pt'>
 <col width=131 span=5 style='mso-width-source:userset;mso-width-alt:4790; width:98pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt;display:none'>
 <tr class=xl25 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td colspan=13 height=46 class=xl24 width=1668 style='height:34.5pt;
  width:1249pt'>WORKING DETAILS SEARCH BY WORK DIVISION</td>
  <td class=xl25 width=131 style='width:98pt'></td>
  <td class=xl25 width=145 style='width:109pt'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'>Project:</td>
  <td colspan=5 class=xl27><%=dt.Rows[1][13]%></td>
  <td colspan=3 class=xl28>Budget Statement No:</td>
  <td colspan=4 class=xl27><%=l_budgetno%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td rowspan=2 height=49 class=xl33 style='border-bottom:.5pt solid black;
  height:36.75pt'>Level Work Division Code</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black;border-top:
  none'>Level Work Division Name</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black;border-top:
  none'>Order Work Division</td>
  <td colspan=5 class=xl34 style='border-right:.5pt solid black;border-left:
  none'>Contract Amount</td>
  <td colspan=5 class=xl34 style='border-right:.5pt solid black;border-left:
  none'>Budget Cost Work Schedule(BCWS)</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black'>Balance</td>
  <td rowspan=2 class=xl33 style='border-bottom:.5pt solid black;display:none'>Remark</td>
 </tr>
 <tr class=xl32 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl38 style='height:18.0pt'>Currency</td>
  <td class=xl38>Raw Mtrl.Cost</td>
  <td class=xl38>Labor Cost</td>
  <td class=xl38>Expenses</td>
  <td class=xl38>Amount</td>
  <td class=xl38>Currency</td>
  <td class=xl38>Raw Mtrl.Cost</td>
  <td class=xl38>Labor Cost</td>
  <td class=xl38>Expenses</td>
  <td class=xl38>Amount</td>
 </tr>
 <%
string  vnd_usd="",vnd_usd1="";
     for (int i = 1; i < dt.Rows.Count; i++)
     {
	 if(dt.Rows[i][3].ToString()=="VND")
	 {
		vnd_usd= "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	 }
	 else  if(dt.Rows[i][3].ToString()=="USD")
	 {
		vnd_usd= "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	 }
	 if(dt.Rows[i][8].ToString()=="VND")
	 {
		vnd_usd1= "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	 }
	 else  if(dt.Rows[i][8].ToString()=="USD")
	 {
		vnd_usd1= "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	 }
          %>
 <tr class=xl25 height=25 style='mso-height-source:auto;height:18.75pt'>
  <td height=25 class=xl41 width=116 style='height:18.75pt;width:87pt'><%=dt.Rows[i][0]%></td>
  <td class=xl40 width=180 style='width:135pt'><%=dt.Rows[i][1]%></td>
  <td class=xl40 width=180 style='width:135pt'><%=dt.Rows[i][2]%></td>
  <td class=xl29><%=dt.Rows[i][3]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl30 x:str=""><%=dt.Rows[i][8]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][10]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][11]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][12]%></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][13]%></td>
  <td style="display:none" class=xl31></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=116 style='width:87pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=145 style='width:109pt'></td>
 </tr>
 <![endif]><%}%>
</table>

</body>

</html>
