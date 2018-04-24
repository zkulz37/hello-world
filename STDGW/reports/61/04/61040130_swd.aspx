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
	string l_project_pk = Request["p_project_pk"];
    string l_project_nm = Request["p_project_nm"];
	string l_budget_pk  = Request["p_budget_pk"];
    string l_budget_no  = Request["p_budget_no"];
	string l_level_pk	= Request["p_desc_pk"];
    //Response.Write(l_project_nm + " - " + l_budget_no);
    //Response.End();
    
	string l_parameter = "";
	l_parameter = "'" + l_project_pk + "','" + l_budget_pk + "','" + l_level_pk + "'";
	DataTable dt = ESysLib.TableReadOpenCursor("SP_SEL_2113_SUMWKDIVISION", l_parameter);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="New%20Microsoft%20Excel%20Worksheet_files/filelist.xml">
<link rel=Edit-Time-Data
href="New%20Microsoft%20Excel%20Worksheet_files/editdata.mso">
<link rel=OLE-Object-Data
href="New%20Microsoft%20Excel%20Worksheet_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>SVPOSLILAMA</o:LastAuthor>
  <o:LastPrinted>2011-06-16T07:40:55Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-06-16T08:47:02Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
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
	white-space:nowrap;
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
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	white-space:normal;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:Standard;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:28.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Summary Work Division</x:Name>
    <x:WorksheetOptions>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>2</x:SplitVertical>
     <x:LeftColumnRightPane>2</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>41</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Summary Work Division'!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2303 style='border-collapse:
 collapse;table-layout:fixed;width:1733pt'>
 <col width=198 style='mso-width-source:userset;mso-width-alt:7241;width:149pt'>
 <col width=497 style='mso-width-source:userset;mso-width-alt:9176;width:373pt'>
 <col width=129 style='mso-width-source:userset;mso-width-alt:4717;width:97pt'>
 <col width=64 style='width:48pt'>
 <col width=110 span=4 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt'>
 <col width=110 span=4 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:5302;width:109pt'>
 <col width=114 style='mso-width-source:userset;mso-width-alt:4169;width:86pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <tr height=47 style='height:35.25pt'>
  <td colspan=16 height=47 class=xl31 width=2303 style='height:35.25pt;
  width:1733pt'>Summary Work Division</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl26 style='height:13.5pt'>PROJECT : <%=l_project_nm %></td>
  <td colspan=13 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27 x:str="BUDGET : ">BUDGET :</td>
  <td class=xl26> <%=l_budget_no%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=3 height=60 class=xl25 style='height:45.0pt'>CODE</td>
  <td rowspan=3 class=xl25>NAME</td>
  <td rowspan=3 class=xl25>ACCOUNT CODE</td>
  <td rowspan=3 class=xl25>UNIT</td>
  <td colspan=5 class=xl25 style='border-left:none'>CONTRACT (A)</td>
  <td colspan=5 class=xl25 style='border-left:none'>CONTRACT (B)</td>
  <td rowspan=3 class=xl25>BALANCE (A-B)</td>
  <td rowspan=3 class=xl25>REMARK</td>
 </tr>
 <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt;border-top:none;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl25 style='border-left:none'>UNIT PRICE</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=3 class=xl25 style='border-left:none'>UNIT PRICE</td>
  <td class=xl25 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt;border-top:none;border-left:
  none'>QTY</td>
  <td class=xl25 style='border-top:none;border-left:none'>MATERIAL</td>
  <td class=xl25 style='border-top:none;border-left:none'>LABOR</td>
  <td class=xl25 style='border-top:none;border-left:none'>EQUIMENT</td>
  <td class=xl25 style='border-top:none;border-left:none'>TOTAL AMT</td>
  <td class=xl25 style='border-top:none;border-left:none'>QTY</td>
  <td class=xl25 style='border-top:none;border-left:none'>MATERIAL</td>
  <td class=xl25 style='border-top:none;border-left:none'>LABOR</td>
  <td class=xl25 style='border-top:none;border-left:none'>EQUIMENT</td>
  <td class=xl25 style='border-top:none;border-left:none'>TOTAL AMT</td>
 </tr>
    <%
        string strBegin = "", strEnd = "";
        string _space = "";
        
        for(int row = 2; row < dt.Rows.Count; row++)
        {
            if (dt.Rows[row]["leaf_yn"].ToString() == "F")
            {
                strBegin = "<b>";
                strEnd = "</b>";
            }
            else
            {
                strBegin = "";
                strEnd = "";
            }

            switch (dt.Rows[row]["undertakelevel"].ToString())
            {
                case "2":
                    _space = "&nbsp;&nbsp;&nbsp;&nbsp;";
                    break;
                case "3":
                    _space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    break;
                case "4":
                    _space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    break;
                case "5":
                    _space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    break;
                case "6":
                    _space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    break;
                case "7":
                    _space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    break;
                case "8":
                    _space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
                    break;
                case "9":
                    _space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;";
                    break;
                case "10":
                    _space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;";
                    break;
            }
     %>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:30.0pt'>
  <td height=20 class=xl28 style='height:30.0pt;border-top:none' x:str><%=strBegin%><%=_space%><%=dt.Rows[row]["undertakelevelcode"].ToString()%><%=strEnd%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=strBegin%><%=dt.Rows[row]["undertakelevelname"].ToString()%><%=strEnd%></td>
  <td class=xl28 style='border-top:none;border-left:none' x:str><%=strBegin%><%=dt.Rows[row]["account_code"].ToString()%><%=strEnd%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=strBegin%><%=dt.Rows[row]["changeunit"].ToString()%><%=strEnd%></td>
  <td class=xl29   x:num><%=strBegin%><%=dt.Rows[row]["undertakeqty"].ToString()%><%=strEnd%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=strBegin%><%=dt.Rows[row]["undertakematerialamt"].ToString()%><%=strEnd%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=strBegin%><%=dt.Rows[row]["undertakelaboramt"].ToString()%><%=strEnd%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=strBegin%><%=dt.Rows[row]["undertakecostamt"].ToString()%><%=strEnd%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=strBegin%><%=dt.Rows[row]["undertakeamt"].ToString()%><%=strEnd%></td>
  <td class=xl28 align=right style='border-top:none;border-left:none'  x:num><%=strBegin%><%=dt.Rows[row]["changeqty"].ToString()%><%=strEnd%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=strBegin%><%=dt.Rows[row]["performmaterialamt"].ToString()%><%=strEnd%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=strBegin%><%=dt.Rows[row]["performlaboramt"].ToString()%><%=strEnd%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=strBegin%><%=dt.Rows[row]["performcostamt"].ToString()%><%=strEnd%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=strBegin%><%=dt.Rows[row]["performamt"].ToString()%><%=strEnd%></td>
  <td class=xl29 align=right style='border-top:none;border-left:none'  x:num><%=strBegin%><%=dt.Rows[row]["balance"].ToString()%><%=strEnd%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=strBegin%><%=dt.Rows[row]["description"].ToString()%><%=strEnd%></td>
 </tr><%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=198 style='width:149pt'></td>
  <td width=497 style='width:373pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=131 style='width:98pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
