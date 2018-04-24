<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string ymd_today = DateTime.Now.ToString("yyyyMMdd");
    ymd_today = ymd_today.Substring(0, 4) + "/" + ymd_today.Substring(4, 2) + "/" + ymd_today.Substring(6, 2);
    string l_std_ym = Request["p_std_ym"];
    string l_tco_company_pk = Request["p_tco_company_pk"];
    string l_mat_grp = Request["p_mat_grp"];
    string l_parameter = "'" + l_std_ym + "','" + l_tco_company_pk + "','" + l_mat_grp + "'";
    DataTable dt = ESysLib.TableReadOpenCursor("acnt.sp_sel_fmgf00230_1", l_parameter);

    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	
	string SQL = "select to_char(last_day(to_date('" + l_std_ym + "' || '01', 'YYYYMMDD')), 'DD/MM/YYYY') from dual ";
	DataTable dtLastDay = ESysLib.TableReadOpen(SQL);

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Goods%20Allocation_files/filelist.xml">
<link rel=Edit-Time-Data href="Goods%20Allocation_files/editdata.mso">
<link rel=OLE-Object-Data href="Goods%20Allocation_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2009-10-01T03:07:16Z</o:LastPrinted>
  <o:Created>2009-10-01T03:18:14Z</o:Created>
  <o:LastSaved>2009-10-01T03:18:14Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
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
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;}
.xl27
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:바탕체, serif;
	mso-font-charset:129;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:바탕체, serif;
	mso-font-charset:129;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"Short Date";
	text-align:right;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:바탕체, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"_ * \#\,\#\#0_ \;_ * \\-\#\,\#\#0_ \;_ * \0022-\0022_ \;_ \@_ ";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0\.000_-\;\\-* \#\,\#\#0\.000_-\;_-* \0022-\0022??_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"_ * \#\,\#\#0_ \;_ * \\-\#\,\#\#0_ \;_ * \0022-\0022_ \;_ \@_ ";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"_ * \#\,\#\#0_ \;_ * \\-\#\,\#\#0_ \;_ * \0022-\0022_ \;_ \@_ ";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"_ * \#\,\#\#0_ \;_ * \\-\#\,\#\#0_ \;_ * \0022-\0022_ \;_ \@_ ";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"0\.000";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0\.000_-\;\\-* \#\,\#\#0\.000_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:바탕체, serif;
	mso-font-charset:129;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Goods Allocation</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>270</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:RangeSelection>$A$2:$L$2</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10065</x:WindowHeight>
  <x:WindowWidth>17145</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.--><!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.--><!-----------------------------><!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD --><!----------------------------->

<table x:str border=0 cellpadding=0 cellspacing=0 width=1293 style='border-collapse:
 collapse;table-layout:fixed;width:972pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=126 style='mso-width-source:userset;mso-width-alt:4608;
 width:95pt'>
 <col class=xl25 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl24 width=82 span=2 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <col class=xl24 width=125 style='mso-width-source:userset;mso-width-alt:4571;
 width:94pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <tr class=xl26 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl24 width=44 style='height:30.75pt;width:33pt'></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=73 style='width:55pt'></td>
  <td class=xl24 width=67 style='width:50pt'></td>
  <td class=xl24 width=126 style='width:95pt'></td>
  <td class=xl25 width=107 style='width:80pt'></td>
  <td class=xl24 width=80 style='width:60pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=125 style='width:94pt'></td>
  <td class=xl24 width=73 style='width:55pt'></td>
  <td class=xl24 width=108 style='width:81pt'></td>
  <td class=xl24 width=124 style='width:93pt'></td>
  <td class=xl24 width=105 style='width:79pt'></td>
 </tr>
 <tr class=xl27 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=12 height=41 class=xl48 width=1064 style='height:30.75pt;
  width:800pt'>Step 3 : Allocation Cost (Goods)</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 colspan=5 class=xl24 style='height:30.75pt;mso-ignore:colspan'></td>
  <td class=xl25><span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td class=xl29 x:num><%=dtLastDay.Rows[0][0]%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=56 style='mso-height-source:userset;height:42.0pt'>
  <td height=56 class=xl31 width=44 style='height:42.0pt;width:33pt'>SIZE</td>
  <td class=xl32 width=97 style='width:73pt'>(1)PRODUCT QUANTITY</td>
  <td class=xl32 width=73 style='width:55pt'>(2)STANDARD WEIGHT</td>
  <td class=xl32 width=67 style='width:50pt'>(3)YIELD</td>
  <td class=xl32 width=126 style='width:95pt'>(4)적수=(1)*(2)/(3)</td>
  <td class=xl33 width=107 style='width:80pt'>(5)Allocation material Cost</td>
  <td class=xl32 width=80 style='width:60pt'>(6)Unit1(Materials)</td>
  <td class=xl34 width=82 style='width:62pt'>(7)Quantity/HR</td>
  <td class=xl32 width=82 style='width:62pt'>(8)Operating time</td>
  <td class=xl33 width=125 style='width:94pt'>(9)Allocation Conversion Cost</td>
  <td class=xl32 width=73 style='width:55pt'>Unit2(OVERHEAD COST)</td>
  <td class=xl35 width=108 style='width:81pt'>UNIT-PRICE<span
  style='mso-spacerun:yes'>        </span>(unit1+unit2)</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <%
	int i ;
	decimal l_sum_qty = 0, l_sum_cost_amt = 0, l_sum_mat_cost = 0, l_unit_1 = 0;
	decimal l_sum_time = 0, l_sum_conver_cost = 0, l_unit_2 = 0, l_price = 0;
	for(i = 0; i < dt.Rows.Count; i++)
	{
		if(dt.Rows[i][1].ToString() != "")
		{
			l_sum_qty += decimal.Parse(dt.Rows[i][1].ToString());
			l_sum_cost_amt += decimal.Parse(dt.Rows[i][4].ToString());
			l_sum_mat_cost += decimal.Parse(dt.Rows[i][5].ToString());
			l_sum_time += decimal.Parse(dt.Rows[i][8].ToString());
			l_sum_conver_cost += decimal.Parse(dt.Rows[i][9].ToString());
		}
%>	
 <tr class=xl26 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl36 style='height:30.75pt'><%=dt.Rows[i][0]%></td>
  <td class=xl37 align=center x:num><%=dt.Rows[i][1]%></td>
  <td class=xl38 x:num><%=dt.Rows[i][2]%></td>
  <td class=xl39 x:num><%=dt.Rows[i][3]%></td>
  <td class=xl40 x:num><span style='mso-spacerun:yes'>       
  </span><%=dt.Rows[i][4]%></td>
  <td class=xl41 align=right x:num><%=dt.Rows[i][5]%></td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'> </span><%=dt.Rows[i][6]%></td>
  <td class=xl43 x:num><span style='mso-spacerun:yes'>   </span><%=dt.Rows[i][7]%></td>
  <td class=xl44 x:num><span style='mso-spacerun:yes'>   </span><%=dt.Rows[i][8]%></td>
  <td class=xl45 x:num><span style='mso-spacerun:yes'>        
  </span><%=dt.Rows[i][9]%></td>
  <td class=xl46 align=right x:num><%=dt.Rows[i][10]%></td>
  <td class=xl47 x:num><span style='mso-spacerun:yes'>    </span><%=dt.Rows[i][11]%></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <%
	}
	l_unit_1 = l_sum_mat_cost / l_sum_qty ;
	l_unit_2 = l_sum_conver_cost / l_sum_qty ;
	l_price = l_unit_1 + l_unit_2 ;
 %>
 <tr class=xl26 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl36 style='height:30.75pt'>Total</td>
  <td class=xl37 align=center x:num><%=l_sum_qty%></td>
  <td class=xl38 x:num>&nbsp;</td>
  <td class=xl39 x:num>&nbsp;</td>
  <td class=xl40 x:num><span style='mso-spacerun:yes'>       
  </span><%=l_sum_cost_amt%></td>
  <td class=xl41 align=right x:num><%=l_sum_mat_cost%></td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'> </span><%=l_unit_1%></td>
  <td class=xl43 x:num><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl44 x:num><span style='mso-spacerun:yes'>   </span><%=l_sum_time%></td>
  <td class=xl45 x:num><span style='mso-spacerun:yes'>        
  </span><%=l_sum_conver_cost%></td>
  <td class=xl46 align=right x:num><%=l_unit_2%></td>
  <td class=xl47 x:num><span style='mso-spacerun:yes'>    </span><%=l_price%></td>
  <td class=xl25></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl26 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 colspan=5 class=xl24 style='height:30.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25><!-----------------------------><!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD--><!-----------------------------></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=44 style='width:33pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=105 style='width:79pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
