<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string p_company_pk = ""+Request["company_pk"];
	string p_kindCode = ""+Request["KindCode"];
	string p_DeptPK = ""+Request["DeptPK"];
	string p_Status = ""+Request["Status"];
	string p_AssetNo = ""+ Request["AssetNo"];
	string p_AssetName = ""+ Request["AssetName"]	;
	string p_date_from = ""+Request["dtFrom"];
	string p_date_to = ""+Request["dtTo"];
    string p_company_name = "";
    string p_rpt_date = "";
    string p_rpt_date2 = "";
    string p_open_date = "";
    string p_tax_code = "";
    string p_cmp_add = "";
    
    string l_parameter = "'" + p_company_pk + "', ";
    l_parameter += "'" + p_kindCode + "', ";
    l_parameter += "'" + p_DeptPK + "', ";
    l_parameter += "'" + p_Status + "', ";
    l_parameter += "'" + p_AssetNo + "', ";
    l_parameter += "'" + p_AssetName + "', ";
    l_parameter += "'" + p_date_from + "', ";
    l_parameter += "'" + p_date_to + "' ";
        
    DataTable dt = ESysLib.TableReadOpenCursor("ACNT.rpt_sel_gfgf00030", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
       
       string SQL = " SELECT partner_lname, ";
        SQL += "       tax_code,ADDR1,ADDR2,ADDR3 ";
        SQL += "  FROM tco_company ";
        SQL += " WHERE pk =" + p_company_pk;
        DataTable  dt2 = ESysLib.TableReadOpen(SQL);
        p_company_name = dt2.Rows[0][0].ToString();
        p_tax_code = dt2.Rows[0][1].ToString();
        p_cmp_add = dt2.Rows[0][2].ToString() + " " + dt2.Rows[0][3].ToString();
        p_date_from = p_date_from.Substring(6, 2) + "/" + p_date_from.Substring(4, 2) + "/" + p_date_from.Substring(0, 4);
        p_date_to = p_date_to.Substring(6, 2) + "/" + p_date_to.Substring(4, 2) + "/" + p_date_to.Substring(0, 4); 
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="Copy%20of%20report(fixed%20asset%20list)_files/filelist.xml">
<link rel=Edit-Time-Data
href="Copy%20of%20report(fixed%20asset%20list)_files/editdata.mso">
<link rel=OLE-Object-Data
href="Copy%20of%20report(fixed%20asset%20list)_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2011-04-15T04:24:46Z</o:LastPrinted>
  <o:Created>2011-04-07T09:32:55Z</o:Created>
  <o:LastSaved>2011-04-15T04:27:44Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in 0in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
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
.xl66
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	vertical-align:middle;
	font-weight:700;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	text-align:center;
	font-family:"Times New Roman", serif;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>fixed asset list</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>51</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
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
       <x:ActiveRow>33</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5010</x:WindowHeight>
  <x:WindowWidth>18975</x:WindowWidth>
  <x:WindowTopX>75</x:WindowTopX>
  <x:WindowTopY>7620</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1917 style='border-collapse:
 collapse;table-layout:fixed;width:1439pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=113 style='mso-width-source:userset;mso-width-alt:4132;width:85pt'>
 <col width=194 style='mso-width-source:userset;mso-width-alt:7094;width:146pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=63 style='mso-width-source:userset;mso-width-alt:2304;width:47pt'>
 <col width=96 span=14 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <tr class=xl73 height=22 style='height:16.5pt'>
  <td height=22 class=xl77 colspan=4 width=408 style='height:16.5pt;mso-ignore:  colspan;width:307pt'><%=p_company_name %></td>
  <td class=xl73 width=102 style='width:77pt'></td>
  <td class=xl73 width=63 style='width:47pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
  <td class=xl73 width=96 style='width:72pt'></td>
 </tr>
 <tr class=xl73 height=22 style='height:16.5pt'>
  <td height=22 class=xl77 colspan=6 style='height:16.5pt;mso-ignore:colspan'><%=p_cmp_add %></td>
  <td colspan=14 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl73 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl77 colspan=3 style='height:18.0pt;mso-ignore:colspan'>MST: <%=p_tax_code %></td>
  <td colspan=17 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=20 height=30 class=xl69 style='height:22.5pt'>LIST OF FIXED ASSETS</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=20 height=20 class=xl79 style='height:15.0pt'>FROM: <%=p_date_from%> TO: <%=p_date_to%></td>
 </tr>
 <tr class=xl71 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=2 height=39 class=xl67 style='border-bottom:.5pt solid black;  height:29.25pt;border-top:none'>No.</td>
  <td rowspan=2 class=xl88 width=59 style='border-bottom:.5pt solid black;  border-top:none;width:44pt'>Status<br>    <span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl67 style='border-bottom:.5pt solid black;border-top:  none'>Asset code</td>
  <td rowspan=2 class=xl67 style='border-bottom:.5pt solid black;border-top:  none'>Asset name</td>
  <td rowspan=2 class=xl67 style='border-bottom:.5pt solid black;border-top:  none'>Kind</td>
  <td rowspan=2 class=xl88 width=63 style='border-bottom:.5pt solid black;  border-top:none;width:47pt'>Service date<br><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl70 style='border-left:none'>Original cost</td>
  <td colspan=2 class=xl70 style='border-left:none'>Increase cost</td>
  <td colspan=2 class=xl70 style='border-left:none'>Decrease cost</td>
  <td colspan=2 class=xl70 style='border-left:none'>Ending cost</td>
  <td colspan=2 class=xl70 style='border-left:none'>Depreciated amount</td>
  <td colspan=2 class=xl70 style='border-left:none'>Accumation amount </td>
  <td colspan=2 class=xl70 style='border-left:none'>Remain amount</td>
 </tr>
 <tr class=xl71 height=17 style='height:12.75pt'>
  <td height=17 class=xl87 style='height:12.75pt;border-top:none;border-left: none'>VND</td>
  <td class=xl87 style='border-top:none;border-left:none'>USD</td>
  <td class=xl87 style='border-top:none;border-left:none'>VND</td>
  <td class=xl87 style='border-top:none;border-left:none'>USD</td>
  <td class=xl87 style='border-top:none;border-left:none'>VND</td>
  <td class=xl87 style='border-top:none;border-left:none'>USD</td>
  <td class=xl87 style='border-top:none;border-left:none'>VND</td>
  <td class=xl87 style='border-top:none;border-left:none'>USD</td>
  <td class=xl87 style='border-top:none;border-left:none'>VND</td>
  <td class=xl87 style='border-top:none;border-left:none'>USD</td>
  <td class=xl87 style='border-top:none;border-left:none'>VND</td>
  <td class=xl87 style='border-top:none;border-left:none'>USD</td>
  <td class=xl87 style='border-top:none;border-left:none'>VND</td>
  <td class=xl87 style='border-top:none;border-left:none'>USD</td>
 </tr>
<%
    double t1, t2, t3, t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14;
    t1 = 0;    t2 = 0;    t3 = 0;    t4 = 0;    t5 = 0;    t6= 0;    t7 = 0;    t8= 0;    t9 = 0;    t10 = 0;    t11 = 0;    t12 = 0;    t13 = 0;    t14 = 0;
            for(int i=0;i<dt.Rows.Count;i++)
            {
                t1 = t1 + double.Parse(dt.Rows[i][6].ToString());
                t2 = t2 + double.Parse(dt.Rows[i][7].ToString());
                t3 = t3 + double.Parse(dt.Rows[i][8].ToString());
                t4 = t4 + double.Parse(dt.Rows[i][9].ToString());
                t5 = t5 + double.Parse(dt.Rows[i][10].ToString());
                t6 = t6 + double.Parse(dt.Rows[i][11].ToString());
                t7 = t7 + double.Parse(dt.Rows[i][12].ToString());
                t8 = t8 + double.Parse(dt.Rows[i][13].ToString());
                t9 = t9 + double.Parse(dt.Rows[i][14].ToString());
                t10 = t10 + double.Parse(dt.Rows[i][15].ToString());
                t11 = t11 + double.Parse(dt.Rows[i][16].ToString());
                t12 = t12 + double.Parse(dt.Rows[i][17].ToString());
                t13 = t13 + double.Parse(dt.Rows[i][18].ToString());
                t14 = t14 + double.Parse(dt.Rows[i][19].ToString());      
%> 
 <tr class=xl78 height=21 style='mso-height-source:auto;height:15.95pt'>
  <td height=21 class=xl83 style='height:15.95pt' x:num><%= (i+1) %></td>
  <td class=xl80><%= dt.Rows[i][1].ToString() %></td>
  <td class=xl81><%= dt.Rows[i][2].ToString() %></td>
  <td class=xl84 width=194 style='width:146pt'><%= dt.Rows[i][3].ToString() %></td>
  <td class=xl81><%= dt.Rows[i][4].ToString() %></td>
  <td class=xl82><%= dt.Rows[i][5].ToString() %></td>
  <td class=xl85 align=right x:num><%= dt.Rows[i][6].ToString() %> </td>
  <td class=xl85 align=right x:num><%= dt.Rows[i][7].ToString() %></td>
  <td class=xl85 align=right x:num><%= dt.Rows[i][8].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][9].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][10].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][11].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][12].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][13].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][14].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][15].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][16].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][17].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][18].ToString() %></td>
  <td class=xl86 align=right style='border-top:none;border-left:none'  x:num><%= dt.Rows[i][19].ToString() %></td>
 </tr>
<%} %> 
 <tr class=xl73 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=6 height=21 class=xl74 style='border-right:.5pt solid black;  height:15.95pt'>Total</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t1 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t2 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t3 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t4 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t5 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t6 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t7 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t8 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t9 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t10 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t11 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t12 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t13 %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=t14 %></td>
 </tr>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=42 style='width:32pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
