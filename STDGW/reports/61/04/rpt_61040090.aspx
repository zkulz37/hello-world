<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string tecps_projectsumm_pk = Request["p_tecps_projectsumm_pk"];
	string tecps_performbudgetbasc_pk = Request["p_tecps_performbudgetbasc_pk"];
	string l_parameter="",l_budgetno="",l_project_name="",l_total="";
	 l_parameter = "'" + tecps_projectsumm_pk + "','" + tecps_performbudgetbasc_pk + "'";

    DataTable dt = ESysLib.TableReadOpenCursor("sp_rpt_kpbm00080",l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string SQL2 = " SELECT  a.budgetdocnum FROM tecps_performbudgetbasc a WHERE  a.del_if = 0 AND a.pk ='" + tecps_performbudgetbasc_pk+ "'";
    DataTable dtBudgetNo = ESysLib.TableReadOpen(SQL2);
    if (dtBudgetNo.Rows.Count > 0)
    {
        l_budgetno = dtBudgetNo.Rows[0][0].ToString();
    }
     string SQL3 = " select PROJECTCODE||'-'|| PROJECTNAME    from TECPS_PROJECTSUMM where del_if=0 and pk='" + tecps_projectsumm_pk+ "'";
    DataTable dtproject_name = ESysLib.TableReadOpen(SQL3);
    if (dtproject_name.Rows.Count > 0)
    {
        l_project_name = dtproject_name.Rows[0][0].ToString();
    }	
    string SQL4 = " SELECT 'Original Amt(A): ' || to_char(SUM (a.ORIGINALAMT), '999,999,999,999,999,999.99') || ' ; ' || 'Change Amt(D):'  || to_char(SUM (a.CHANGEAMT), '999,999,999,999,999,999.99') || ' ; ' || 'I/D(E):' ||  to_char(SUM (a.INCR_DECR_AMT), '999,999,999,999,999,999.99') FROM TECPS_PERFORMCOSTRMRK a where a.del_if = 0 AND A.TECPS_PERFORMBUDGETBASC_PK = '" + tecps_performbudgetbasc_pk+ "' and A.TECPS_PROJECTSUMM_PK = '" + tecps_projectsumm_pk+ "' group by a.TECPS_PERFORMBUDGETBASC_PK";
    DataTable  dt_total = ESysLib.TableReadOpen(SQL4);
    if (dt_total.Rows.Count > 0)
    {
        l_total = dt_total.Rows[0][0].ToString();
    }		
	 
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_kpbm00080_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_kpbm00080_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_kpbm00080_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2011-05-04T06:47:29Z</o:LastPrinted>
  <o:Created>2008-09-17T04:07:31Z</o:Created>
  <o:LastSaved>2011-05-04T06:48:04Z</o:LastSaved>
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
	margin:.19in .17in .17in .17in;
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
	font-size:6.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style16;
	font-size:6.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style16;
	font-size:6.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl35
	{mso-style-parent:style16;
	font-size:6.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style16;
	font-size:6.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#339966;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	color:red;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>WorkingExpenseRegistration</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
       <x:ActiveCol>18</x:ActiveCol>
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
  <x:Formula>=WorkingExpenseRegistration!$1:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1055 style='border-collapse:
 collapse;table-layout:fixed;width:792pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl24 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl24 width=130 style='mso-width-source:userset;mso-width-alt:4754;
 width:98pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1133'>
 <col class=xl24 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl24 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl45 width=301 style='height:15.75pt;
  width:226pt'>POSCO E&amp;C-VIETNAM CO.,LTD</td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=41 style='width:31pt'></td>
  <td class=xl24 width=38 style='width:29pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl25 width=86 style='width:65pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=83 style='width:62pt'></td>
  <td class=xl25 width=39 style='width:29pt'></td>
  <td class=xl25 width=0></td>
  <td class=xl24 width=56 style='width:42pt'></td>
  <td class=xl24 width=84 style='width:63pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=34 style='width:26pt'></td>
  <td class=xl24 width=39 style='width:29pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl46 style='height:15.75pt'>Address:</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl46 style='height:15.75pt'>M� s&#7889;
  thu&#7871;:</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=18 height=32 class=xl40 style='height:24.0pt'>Working Expense
  Registration</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl47 style='height:16.5pt'>Project :</td>
  <td colspan=8 class=xl44><%=l_project_name%></td>
  <td colspan=4 class=xl41>Budget Statement No:</td>
  <td colspan=4 class=xl42><%=l_budgetno%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl47 style='height:16.5pt'>Total:</td>
  <td colspan=16 class=xl43><%=l_total%></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=2 rowspan=2 height=54 class=xl31 width=68 style='height:40.5pt;
  width:51pt'>Budget Item Code</td>
  <td rowspan=2 class=xl31 width=130 style='border-top:none;width:98pt'>Budget
  Item Name</td>
  <td rowspan=2 class=xl31 width=103 style='border-top:none;width:77pt'>Name</td>
  <td rowspan=2 class=xl31 width=55 style='border-top:none;width:41pt'>Currency</td>
  <td colspan=4 class=xl38 style='border-left:none'>Working [Original](A)</td>
  <td rowspan=2 class=xl39 width=80 style='border-top:none;width:60pt'>Wkng
  Bal<span style='mso-spacerun:yes'>� </span>C=(A-B)</td>
  <td rowspan=2 class=xl31 width=83 style='border-top:none;width:62pt'>Actual
  Result<span style='mso-spacerun:yes'>� </span>Amount (B)</td>
  <td colspan=4 class=xl38 style='border-left:none'>Working [Changed](D)</td>
  <td rowspan=2 class=xl31 width=64 style='border-top:none;width:48pt'>Incr/Decr<span
  style='mso-spacerun:yes'>� </span>E=(D-A)</td>
  <td rowspan=2 class=xl39 width=34 style='border-top:none;width:26pt'>Exec
  (Y/N)</td>
  <td rowspan=2 class=xl39 width=39 style='border-top:none;width:29pt'>Calc
  Basis</td>
 </tr>
 <tr class=xl28 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl31 width=41 style='height:20.25pt;border-top:none;
  border-left:none;width:31pt'>Unit</td>
  <td class=xl31 width=38 style='border-top:none;border-left:none;width:29pt'>Q'ty</td>
  <td class=xl31 width=55 style='border-top:none;border-left:none;width:41pt'>Unit
  Price</td>
  <td class=xl31 width=86 style='border-top:none;border-left:none;width:65pt'>Amount</td>
  <td class=xl31 width=39 style='border-top:none;border-left:none;width:29pt'>Unit</td>
  <td class=xl31 width=0 style='border-top:none;border-left:none'>Q'ty</td>
  <td class=xl31 width=56 style='border-top:none;border-left:none;width:42pt'>Unit
  Price</td>
  <td class=xl31 width=84 style='border-top:none;border-left:none;width:63pt'>Amount</td>
 </tr>
 <%
 string l_xls_format = "";
     for (int i = 1; i < dt.Rows.Count; i++)
     {
		if(dt.Rows[i][3].ToString() != "VND")
		{
			l_xls_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
		}
		else 
		{
			l_xls_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
		}
          %>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl29 style='height:15.75pt'><%=dt.Rows[i][0]%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt.Rows[i][1]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][3]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][4]%></td>
  <td class=xl33 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl32 style="mso-number-format:'<%=l_xls_format%>';" x:num><%=dt.Rows[i][6]%></td>
  <td class=xl35 style="mso-number-format:'<%=l_xls_format%>';" x:num><%=dt.Rows[i][7]%></td>
  <td class=xl35 style="mso-number-format:'<%=l_xls_format%>';" x:num><%=dt.Rows[i][8]%></td>
  <td class=xl35 style="mso-number-format:'<%=l_xls_format%>';" x:num><%=dt.Rows[i][9]%></td>
  <td class=xl30 style='border-top:none;border-left:none'><%=dt.Rows[i][10]%></td>
  <td class=xl30 style="mso-number-format:'<%=l_xls_format%>';" x:num><%=dt.Rows[i][11]%></td>
  <td class=xl32 style="mso-number-format:'<%=l_xls_format%>';" x:num><%=dt.Rows[i][12]%></td>
  <td class=xl35 style="mso-number-format:'<%=l_xls_format%>';" x:num><%=dt.Rows[i][13]%></td>
  <td class=xl35 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][14]%></td>
  <td class=xl36 style='border-top:none;border-left:none'><%=dt.Rows[i][15]%></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][16]%></td>
 </tr>
 <%}%>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=18 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=18 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=18 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=18 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=18 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=18 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=8 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=130 style='width:98pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=0></td>
  <td width=56 style='width:42pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=39 style='width:29pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
