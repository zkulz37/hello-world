<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
    ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
    ESysLib.SetUser("acnt");
        
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_tco_company_pk = Request["p_tco_company_pk"];
    string ls_date = Request["p_tr_date"];
   
    string[] ls_Month = new string[14];
    ls_Month[0] = " ";
    ls_Month[1] = "Jan";
    ls_Month[2] = "Feb";
    ls_Month[3] = "Mar";
    ls_Month[4] = "Apr";
    ls_Month[5] = "May";
    ls_Month[6] = "Jun";
    ls_Month[7] = "Jul";
    ls_Month[8] = "Aug";
    ls_Month[9] = "Sep";
    ls_Month[10] = "Oct";
    ls_Month[11] = "Nov";
    ls_Month[12] = "Dec";
    ls_Month[13] = ls_Month[int.Parse(ls_date.Substring(4, 2))] + "/" + ls_date.Substring(0, 4);
    
   // string l_tac_abcenter_pk = Request["p_tac_abcenter_pk"];
    
    string l_parameter = "'" + l_tco_company_pk + "', ";
    l_parameter += "'" + ls_date + "' ";
  //  l_parameter += "'" + l_tac_abcenter_pk + "' ";
    //----------------------------------------------------------------------------------------------
    string SQL1 = " SELECT PARTNER_NAME, ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_tco_company_pk + "'";
    string l_cmp_name = "", l_cmp_add = "", l_cmp_taxcode = "";
    DataTable dt1 = ESysLib.TableReadOpen(SQL1);
    if (dt1.Rows.Count > 0)
    {
        l_cmp_name = dt1.Rows[0][0].ToString();
        l_cmp_add = dt1.Rows[0][1].ToString();
        l_cmp_taxcode = dt1.Rows[0][3].ToString();
    }

    //----------------------------------------------------------------------------------------------
    DataTable dt = ESysLib.TableReadOpenCursor("acnt.sp_sel_gfca00070_4", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }

    String p_xls_ccy_format = "";
    String p_xls_ccy_format_usd = "";
    string l_book_ccy = "";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="project_status_files/filelist.xml">
<link rel=Edit-Time-Data href="project_status_files/editdata.mso">
<link rel=OLE-Object-Data href="project_status_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-01-07T07:30:23Z</o:LastPrinted>
  <o:Created>2008-03-01T06:24:58Z</o:Created>
  <o:LastSaved>2010-01-07T07:30:32Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .25in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
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
     <x:DefaultRowHeight>402</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>1200</x:HorizontalResolution>
      <x:VerticalResolution>1200</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9270</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1590</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1523 style='border-collapse:
 collapse;table-layout:fixed;width:1143pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col class=xl24 width=145 span=3 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=145 span=3 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=167 style='mso-width-source:userset;mso-width-alt:6107;
 width:125pt'>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl25 colspan=2 width=290 style='height:20.1pt;mso-ignore:
  colspan;width:217pt'><%=l_cmp_name%></td>
  <td class=xl25 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=81 style='width:61pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=145 style='width:109pt'></td>
  <td class=xl24 width=115 style='width:86pt'></td>
  <td class=xl24 width=167 style='width:125pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl25 colspan=2 style='height:20.1pt;mso-ignore:colspan'><%=l_cmp_add%></td>
  <td class=xl25></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl26 colspan=2 style='height:20.1pt;mso-ignore:colspan'>MST/Tax
  Code: <%=l_cmp_taxcode%></td>
  <td class=xl26></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=9 height=26 class=xl35 style='height:20.1pt'>PROJECT STATUS
  (<%=ls_Month[13]%>)</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=34 style='height:25.5pt'>
  <td height=34 class=xl28 style='height:25.5pt'>CODE</td>
  <td class=xl29>NAME</td>
  <td class=xl29>CONRACT AMT</td>
  <td class=xl29>BUDGET COST</td>
  <td class=xl29 width=145 style='width:109pt'>ACC. DIRECT COST<br>
    </td>
  <td class=xl30 width=81 style='width:61pt'>PROGRESS<br>
    RATIO</td>
  <td class=xl29 width=145 style='width:109pt'>ACC. TURNOVER<br>
    </td>
  <td class=xl29 width=145 style='width:109pt'>DIRECT CODE <br>
    </td>
  <td class=xl29 width=145 style='width:109pt'>TURNOVER <br>
    </td>
  <td class=xl30 width=115 style='width:86pt'>PROJECT TYPE</td>
  <td class=xl30 width=167 style='width:125pt'>TURNOVER ON PROGRESS</td>
 </tr>
 <%
     for (int i = 1; i < dt.Rows.Count; i++)
     {
  %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 style='height:20.1pt'><%=dt.Rows[i][3]%></td>
  <td class=xl32><%=dt.Rows[i][4]%></td>
  <td class=xl33 style="mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'></span><%=dt.Rows[i][6]%></td>
  <td class=xl33 style="mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'></span><%=dt.Rows[i][9]%></td>
  <td class=xl33 style="mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'></span><%=dt.Rows[i][7]%></td>
  <td class=xl33 style="mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][10]%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl33 style="mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][12]%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl33 style="mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][8]%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl33 style="mso-number-format:'<%= p_xls_ccy_format %>'"; x:num><span  style='mso-spacerun:yes'> </span><%=dt.Rows[i][13]%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl34 style='border-left:none' ><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][22]%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl34 style='border-left:none' ><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][11]%><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=75 style='width:56pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=167 style='width:125pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
