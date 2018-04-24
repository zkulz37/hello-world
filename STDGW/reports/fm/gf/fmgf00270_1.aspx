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
	string l_dt_from = "", l_dt_to = "" ;
	l_dt_from = Request["dt_from"];
	l_dt_to = Request["dt_to"];
	string l_yyear = "", l_mmonth = "", l_dday = "" ;
	string SQL = "";
	SQL
	= "			select tbl_m.sizea, tbl_m.b_qty, tbl_d.i_qty rcpt_qty, tbl_d.c1_qty pack_qty, tbl_d.c2_qty repack_qty,  " + 
        "							 tbl_d.c3_qty reprint_qty, nvl(tbl_d.c1_qty, 0) + nvl(tbl_d.c2_qty, 0) + nvl(tbl_d.c3_qty, 0) sub_total, " +
        "							 tbl_d.c22_qty loss_qty, tbl_d.c_qty issue_tot, " +
        "							 nvl(tbl_m.b_qty, 0) + nvl(tbl_d.i_qty, 0) - nvl(tbl_d.c_qty, 0) end_qty " +
        "			from ( Select 	 " +
        "				mafg.sf_get_size(a.matno) sizea, " +
        "				sum(decode(a.iogu,'1',decode(a.iotype,'01',nvl(a.rec_qty,0),0))) i_qty, " +
        "			    sum(decode(a.iogu,'2',decode(a.iotype,'01',nvl(a.rec_qty,0),0))) c1_qty, " +
        "			    sum(decode(a.iogu,'2',decode(a.iotype,'02',nvl(a.rec_qty,0),0))) c2_qty,                         " +
        "			    sum(decode(a.iogu,'2',decode(a.iotype,'03',nvl(a.rec_qty,0),0))) c3_qty,                         " +
        "			    sum(decode(a.iogu,'2',decode(a.iotype,'04',nvl(a.rec_qty,0),0))) c4_qty,                         " +
        "			    sum(decode(a.iogu,'2',decode(a.iotype,'22',nvl(a.rec_qty,0),0))) +                         " +
        "			                    nvl(sum(decode(a.iogu,'1',decode(a.iotype,'99',nvl(a.rec_qty,0) * -1,0))),0) c22_qty,                            " +
        "			    sum(decode(a.iogu,'2',decode(a.iotype,'01',nvl(a.rec_qty,0),0)) +                         " +
        "			        decode(a.iogu,'2',decode(a.iotype,'02',nvl(a.rec_qty,0),0)) +                     " +
        "			        decode(a.iogu,'2',decode(a.iotype,'03',nvl(a.rec_qty,0),0)) +                     " +
        "			        decode(a.iogu,'2',decode(a.iotype,'04',nvl(a.rec_qty,0),0)) +                     " +
        "			        decode(a.iogu,'2',decode(a.iotype,'22',nvl(a.rec_qty,0),0))   )  +                     " +
        "			                      nvl(sum(decode(a.iogu,'1',decode(a.iotype,'99',nvl(a.rec_qty,0) * -1,0))),0) c_qty                               " +
        "			From   onhd_d a                              " +
        "			Where     to_char(a.idate,'yyyymmdd') between '" + l_dt_from + "' and '" + l_dt_to + "' " +
        "			group by mafg.sf_get_size(a.matno)                             " +
        "			order by mafg.sf_get_size(a.matno) " +
        "			) tbl_d, " +
        "					( " +
        "						SELECT mafg.sf_get_size(a.matno) sizea, NVL (SUM (bas_qty), 0) b_qty                                    " +
        "						  FROM onhd_m a, mafg.s_prod b " +
        "						 WHERE yymm = substr(p_dt_fr, 1, 6) AND a.matno = b.matno " +
        "						group by mafg.sf_get_size(a.matno)                             " +
        "						order by mafg.sf_get_size(a.matno) " +
        "						) tbl_m " +
        "			where tbl_m.sizea = tbl_d.sizea ; " ;
    DataTable dt = new DataTable();
	dt = ESysLib.TableReadOpen(SQL) ;
    
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="In-Process%20Pro_files/filelist.xml">

<link rel=Edit-Time-Data href="In-Process%20Pro_files/editdata.mso">
<link rel=OLE-Object-Data href="In-Process%20Pro_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2009-08-31T03:06:17Z</o:LastPrinted>
  <o:Created>2009-08-31T02:08:58Z</o:Created>
  <o:LastSaved>2009-08-31T03:17:41Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
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
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000000";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000000";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.000000";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>In-process Products Inventory</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10065</x:WindowHeight>
  <x:WindowWidth>13305</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=870 style='border-collapse:
 collapse;table-layout:fixed;width:654pt'>
 <col width=41 style='mso-width-source:userset;mso-width-alt:1499;width:31pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3181;width:65pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=41 style='height:12.75pt;width:31pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=99 style='width:74pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'>In-process Products
  Inventory Values</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'>Program ID:
  PAADR180</td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl25 colspan=3 style='height:24.0pt;mso-ignore:colspan'>Plant:
  Suheung Vietnam</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl25 colspan=3 style='mso-ignore:colspan'>[ Period: 2009.07.01 ~
  2009.07.31 ]</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=2 height=41 class=xl48 style='border-bottom:.5pt solid black;
  height:30.75pt'>Size</td>
  <td rowspan=2 class=xl40 width=93 style='border-bottom:.5pt solid black;
  width:70pt'>Beginning Inventory</td>
  <td rowspan=2 class=xl38 style='border-bottom:.5pt solid black'>Receipts</td>
  <td colspan=5 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Issues</td>
  <td rowspan=2 class=xl38 style='border-bottom:.5pt solid black'>Issue Total</td>
  <td rowspan=2 class=xl40 width=99 style='border-bottom:.5pt solid black;
  width:74pt'>Ending Inventory</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt;border-top:none;border-left:
  none'>Packaging</td>
  <td class=xl27 style='border-top:none'>Repackaging</td>
  <td class=xl27 style='border-top:none'>Reprinting</td>
  <td class=xl27 style='border-top:none'>Sub-Total</td>
  <td class=xl28 style='border-top:none'>Loss</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>#OO</td>
  <td class=xl30 align=right style='border-top:none;border-left:none'
  x:num="1000">1,000</td>
  <td class=xl30 align=right style='border-top:none;border-left:none'
  x:num="2000">2,000</td>
  <td class=xl30 align=right style='border-top:none;border-left:none'
  x:num="3000">3,000</td>
  <td class=xl30 align=right style='border-top:none;border-left:none'
  x:num="4000">4,000</td>
  <td class=xl30 align=right style='border-top:none;border-left:none'
  x:num="5000">5,000</td>
  <td class=xl30 align=right style='border-top:none;border-left:none'
  x:num="6000">6,000</td>
  <td class=xl30 align=right style='border-top:none;border-left:none'
  x:num="7000">7,000</td>
  <td class=xl30 align=right style='border-top:none;border-left:none'
  x:num="8000">8,000</td>
  <td class=xl30 align=right style='border-top:none;border-left:none'
  x:num="9000">9,000</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl30 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=2 height=43 class=xl42 style='border-bottom:.5pt solid black;
  height:32.25pt'>Size</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Gelatin</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Trimming</td>
  <td rowspan=2 class=xl46 width=93 style='border-bottom:.5pt solid black;
  width:70pt'>Subsidiary Raw Material</td>
  <td rowspan=2 class=xl46 width=97 style='border-bottom:.5pt solid black;
  width:73pt'>Total Raw Material Weight</td>
  <td rowspan=2 class=xl46 width=93 style='border-bottom:.5pt solid black;
  width:70pt'>Dip Weight</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Sol. Left</td>
  <td rowspan=2 class=xl44 style='border-bottom:.5pt solid black'>Scrap</td>
  <td colspan=2 rowspan=2 class=xl35 width=188 style='width:141pt'>Raw Material
  Used</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>#OO</td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num="1000">1,000.000</td>
  <td class=xl31 align=right style='border-top:none;border-left:none'
  x:num="2000">2,000.000</td>
  <td class=xl32 align=right style='border-top:none;border-left:none' x:num>100.000000</td>
  <td class=xl32 align=right style='border-top:none;border-left:none' x:num>200.000000</td>
  <td class=xl32 align=right style='border-top:none;border-left:none' x:num>300.000000</td>
  <td class=xl33 align=right style='border-top:none;border-left:none' x:num>100.000</td>
  <td class=xl32 align=right style='border-top:none;border-left:none' x:num>110.000000</td>
  <td colspan=2 class=xl36 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 align=right style='border-top:none;border-left:none' x:num>144.000000</td>
  <td class=xl32 align=right style='border-top:none;border-left:none' x:num>145.000000</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl34 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl34 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl34 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl34 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl29 style='height:18.75pt;border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl34 style='border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=41 style='width:31pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=99 style='width:74pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
