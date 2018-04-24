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
    string P_Project_Pk = Request["Project_Pk"];
    string P_Budget_Pk = Request["Budget_Pk"];
    string P_Report_Type = Request["Report_Type"];
    string p_Project_Nm = Request["Project_Nm"];
    string p_Budget_Cd = Request["Budget_Cd"];
    string l_parameter = "'" + P_Project_Pk + "','" + P_Budget_Pk + "','" + P_Report_Type + "'";

    DataTable dt = ESysLib.TableReadOpenCursor("sp_sel_2116_costsummary", l_parameter);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    string p_CCY_Trans = "";
    string p_CCY_Book = "";
    string p_CCY_Book_Sys = "";
    string SQL_CCY  = " SELECT tran_ccy, book_ccy, ( SELECT CODE " +
         "          FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B " +
         "         WHERE A.PK     = B.TAC_COMMCODE_MASTER_PK " +
         "           AND A.ID     = 'ACBG0040' " +
         "           AND A.DEL_IF = 0 " +
         "           AND B.DEL_IF = 0 " +
         "           AND B.USE_YN ='Y') sys_book_ccy " +
         "    FROM tecps_undertakectrtbasc a " +
         "   WHERE a.del_if = 0 AND a.tecps_projectsumm_pk = '"+P_Project_Pk+"' ";
    DataTable dt_ccy = ESysLib.TableReadOpen(SQL_CCY);

    if (dt_ccy.Rows.Count > 0)
    {
        p_CCY_Trans = dt_ccy.Rows[0][0].ToString();
        p_CCY_Book = dt_ccy.Rows[0][1].ToString();
        p_CCY_Book_Sys = dt_ccy.Rows[0][2].ToString();
    }
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="2113_summary1_files/filelist.xml">
<link rel=Edit-Time-Data href="2113_summary1_files/editdata.mso">
<link rel=OLE-Object-Data href="2113_summary1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-08-12T03:12:02Z</o:LastPrinted>
  <o:Created>2011-07-07T11:27:01Z</o:Created>
  <o:LastSaved>2011-08-12T06:09:40Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.51in .28in .38in .9in;
	mso-header-margin:.3in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style247
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
.style248
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style502
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"표준_A-2\) Total price and analysis";}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
.xl519
	{mso-style-parent:style502;
	font-size:28.0pt;
	font-weight:700;
	font-family:"MS Mincho", monospace;
	mso-font-charset:128;
	text-align:center;
	vertical-align:middle;}
.xl520
	{mso-style-parent:style502;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl521
	{mso-style-parent:style502;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl522
	{mso-style-parent:style247;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\0022Exchange rate   \0022\#\,\#\#0\0022 VND\/USD\0022";
	text-align:right;
	vertical-align:middle;}
.xl523
	{mso-style-parent:style502;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl524
	{mso-style-parent:style502;
	color:white;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid gray;
	border-right:.5pt solid gray;
	border-bottom:.5pt solid #333333;
	border-left:.5pt solid gray;
	background:#333333;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl525
	{mso-style-parent:style502;
	font-size:16.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl526
	{mso-style-parent:style502;
	color:white;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid gray;
	border-right:.5pt solid gray;
	border-bottom:none;
	border-left:.5pt solid gray;
	background:#333333;
	mso-pattern:auto none;}
.xl527
	{mso-style-parent:style502;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl528
	{mso-style-parent:style502;
	color:white;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #333333;
	border-right:.5pt solid gray;
	border-bottom:none;
	border-left:.5pt solid gray;
	background:#333333;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl529
	{mso-style-parent:style502;
	font-size:16.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl530
	{mso-style-parent:style502;
	color:white;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid #333333;
	border-right:.5pt solid gray;
	border-bottom:1.0pt solid gray;
	border-left:.5pt solid gray;
	background:#333333;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl531
	{mso-style-parent:style502;
	font-size:16.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid gray;
	border-left:none;}
.xl532
	{mso-style-parent:style502;
	color:white;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid gray;
	border-right:.5pt solid gray;
	border-bottom:1.0pt solid gray;
	border-left:.5pt solid gray;
	background:#333333;
	mso-pattern:auto none;}
.xl533
	{mso-style-parent:style502;
	color:white;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid gray;
	border-right:1.0pt solid gray;
	border-bottom:1.0pt solid gray;
	border-left:.5pt solid gray;
	background:#333333;
	mso-pattern:auto none;}
.xl534
	{mso-style-parent:style502;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl535
	{mso-style-parent:style248;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:.5pt solid gray;
	border-bottom:.5pt solid gray;
	border-left:.5pt solid gray;
	mso-pattern:auto none;}
.xl536
	{mso-style-parent:style248;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:.5pt solid gray;
	border-bottom:.5pt solid gray;
	border-left:.5pt solid gray;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl537
	{mso-style-parent:style248;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\0022$ \0022\#\,\#\#0\.0\0022 \/㎡ \0022";
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:.5pt solid gray;
	border-bottom:.5pt solid gray;
	border-left:.5pt solid gray;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl538
	{mso-style-parent:style502;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl539
	{mso-style-parent:style248;
	font-size:15.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:.5pt solid gray;
	border-bottom:.5pt solid gray;
	border-left:.5pt solid gray;
	mso-pattern:auto none;}
.xl540
	{mso-style-parent:style248;
	color:blue;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\0022\(\0022\\-\0022\)\0022\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:.5pt solid gray;
	border-bottom:.5pt solid #969696;
	border-left:.5pt solid #969696;
	mso-pattern:auto none;
	padding-right:12px;
	mso-char-indent-count:1;}
.xl541
	{mso-style-parent:style248;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:1.0pt solid gray;
	border-bottom:.5pt solid gray;
	border-left:.5pt solid gray;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl542
	{mso-style-parent:style502;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl543
	{mso-style-parent:style248;
	color:blue;
	font-size:20.0pt;
	font-weight:700;
	font-family:돋움, monospace;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:left;
	vertical-align:middle;}
.xl544
	{mso-style-parent:style502;
	font-size:20.0pt;
	font-weight:700;
	font-family:돋움, monospace;
	mso-font-charset:129;
	vertical-align:middle;}
.xl545
	{mso-style-parent:style248;
	color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-family:돋움, monospace;
	mso-font-charset:129;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	vertical-align:middle;}
.xl546
	{mso-style-parent:style502;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:.5pt solid #969696;
	border-bottom:.5pt solid #969696;
	border-left:.5pt solid #969696;
	mso-pattern:auto none;
	white-space:normal;}
.xl547
	{mso-style-parent:style502;
	font-size:28.0pt;
	font-weight:700;
	font-family:HY헤드라인M, serif;
	mso-font-charset:129;
	text-align:center;
	vertical-align:middle;}
.xl548
	{mso-style-parent:style247;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\0022Exchange rate   \0022\#\,\#\#0\0022 VND\/USD\0022";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid gray;
	border-left:none;}
.xl549
	{mso-style-parent:style502;
	color:white;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:.5pt solid gray;
	border-bottom:.5pt solid gray;
	border-left:.5pt solid gray;
	background:#333333;
	mso-pattern:auto none;}
.xl550
	{mso-style-parent:style502;
	color:white;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:.5pt solid gray;
	border-bottom:.5pt solid gray;
	border-left:.5pt solid gray;
	background:#333333;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl551
	{mso-style-parent:style502;
	color:white;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid gray;
	border-right:1.0pt solid gray;
	border-bottom:.5pt solid gray;
	border-left:.5pt solid gray;
	background:#333333;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl552
	{mso-style-parent:style502;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid gray;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>summary</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>450</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:StandardWidth>2633</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>51</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>23</x:TabColorIndex>
     <x:Zoom>60</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7365</x:WindowHeight>
  <x:WindowWidth>18975</x:WindowWidth>
  <x:WindowTopX>-300</x:WindowTopX>
  <x:WindowTopY>390</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl520>

<table x:str border=0 cellpadding=0 cellspacing=0 width=3112 style='border-collapse:
 collapse;table-layout:fixed;width:2335pt'>
 <col class=xl520 width=299 style='mso-width-source:userset;mso-width-alt:10934;
 width:224pt'>
 <col class=xl520 width=4 style='mso-width-source:userset;mso-width-alt:146;
 width:3pt'>
 <col class=xl520 width=181 style='mso-width-source:userset;mso-width-alt:6619;
 width:136pt'>
 <col class=xl520 width=182 style='mso-width-source:userset;mso-width-alt:6656;
 width:137pt'>
 <col class=xl520 width=119 span=2 style='mso-width-source:userset;mso-width-alt:
 4352;width:89pt'>
 <col class=xl520 width=6 style='mso-width-source:userset;mso-width-alt:219;
 width:5pt'>
 <col class=xl520 width=181 style='mso-width-source:userset;mso-width-alt:6619;
 width:136pt'>
 <col class=xl520 width=182 style='mso-width-source:userset;mso-width-alt:6656;
 width:137pt'>
 <col class=xl520 width=119 span=2 style='mso-width-source:userset;mso-width-alt:
 4352;width:89pt'>
 <col class=xl520 width=4 style='mso-width-source:userset;mso-width-alt:146;
 width:3pt'>
 <col class=xl520 width=182 style='mso-width-source:userset;mso-width-alt:6656;
 width:137pt'>
 <col class=xl520 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <col class=xl520 width=72 span=18 style='width:54pt'>
 <tr height=60 style='mso-height-source:userset;height:45.0pt'>
  <td colspan=14 height=60 class=xl547 width=1816 style='height:45.0pt;
  width:1363pt'><a name="Print_Area">Cost Summary of <%=p_Project_Nm%></a></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
  <td class=xl520 width=72 style='width:54pt'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 colspan=14 class=xl519 style='height:30.0pt;mso-ignore:colspan'></td>
  <td colspan=18 class=xl520 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl521 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=4 height=40 class=xl552 style='height:30.0pt'>Budget No: <%=p_Budget_Cd%></td>
  <td colspan=9 class=xl548 x:num="19500">Exchange rate<span  style='mso-spacerun:yes'>   </span>19,500 VND/USD</td>
  <td class=xl522></td>
  <td colspan=18 class=xl521 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td rowspan=2 height=68 class=xl549 style='height:51.0pt;border-top:none'>Particulars</td>
  <td class=xl523 style='border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl550>Contract(A)</td>
  <td class=xl524 style='border-top:none;border-left:none'>Unit</td>
  <td class=xl525 style='border-top:none'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td colspan=3 class=xl550>Budget(B)</td>
  <td class=xl524 style='border-top:none;border-left:none'>Unit</td>
  <td class=xl525 style='border-top:none'><u style='visibility:hidden;
  mso-ignore:visibility'>&nbsp;</u></td>
  <td colspan=2 class=xl550 style='border-right:1.0pt solid gray'>Balance(A-B)</td>
  <td colspan=18 class=xl520 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl527 style='height:29.25pt'></td>
  <td class=xl526 style='border-top:none'>Original(<%=p_CCY_Trans%>)</td>
  <td class=xl526 style='border-top:none;border-left:none'>Booking(<%=p_CCY_Book%>)</td>
  <td class=xl526 style='border-top:none;border-left:none'>%</td>
  <td class=xl528 style='border-top:none;border-left:none'>price</td>
  <td class=xl529></td>
  <td class=xl526 style='border-top:none'>Original(<%=p_CCY_Trans %>)</td>
  <td class=xl526 style='border-top:none;border-left:none'>Booking(<%=p_CCY_Book%>)</td>
  <td class=xl526 style='border-top:none;border-left:none'>%</td>
  <td class=xl530 style='border-top:none;border-left:none'>price</td>
  <td class=xl531><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl532 style='border-top:none'><%=p_CCY_Book_Sys%></td>
  <td class=xl533 style='border-top:none;border-left:none'>%</td>
  <td colspan=18 class=xl520 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string _Color = "";
     string _Font = "";
     string _space = "";
        for(int i = 1; i < dt.Rows.Count; i++)
	{
        
            _Color = dt.Rows[i][15].ToString();

        if (dt.Rows[i][12].ToString() == "B")
        {
            _Font = "font-weight:700";
        }
        else if (dt.Rows[i][12].ToString() == "I")
        {
            _Font = "font-style:italic";
        }
        else
        {
            _Font = "";
        }
            
            switch(dt.Rows[i][16].ToString())
		   {    
			 case "2":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "3":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "4":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "5":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "6":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "7":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "8":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "9":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
			  case "10":
                _space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;;&nbsp;&nbsp;&nbsp;&nbsp;";
             break;
           }
  %>
 <tr height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl546 width=299 style='height:33.0pt;width:224pt;background:<%=_Color%>;<%=_Font%>'><%=_space%><%=dt.Rows[i][0]%></td>
  <td class=xl534>&nbsp;</td>
  <td class=xl535 style="background:<%=_Color%>;<%=_Font%>" x:num=><%=dt.Rows[i][1]%></td>
  <td class=xl535 style='border-left:none;background:<%=_Color%>;<%=_Font%>' x:num><%=dt.Rows[i][2]%></td>
  <td class=xl536 align=right style='border-left:none;background:<%=_Color%>;<%=_Font%>' x:num><%=dt.Rows[i][3]%></td>
  <td class=xl537 align=right style='border-left:none;background:<%=_Color%>;<%=_Font%>' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl538><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl539 style="background:<%=_Color%>;<%=_Font%>" x:num><%=dt.Rows[i][5]%></td>
  <td class=xl539 style='border-left:none;background:<%=_Color%>;<%=_Font%>' x:num><%=dt.Rows[i][6]%></td>
  <td class=xl536 align=right style='border-left:none;background:<%=_Color%>;<%=_Font%>' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl537 align=right style='border-top:none;border-left:none;background:<%=_Color%>;<%=_Font%>'  x:num><%=dt.Rows[i][8]%></td>
  <td class=xl538 style='border-top:none'><u style='visibility:hidden;  mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl540 style='border-top:none;background:<%=_Color%>;<%=_Font%>' x:num><%=dt.Rows[i][9]%></td>
  <td class=xl541 align=right style='border-top:none;border-left:none;background:<%=_Color%>;<%=_Font%>' x:num><%=dt.Rows[i][10]%></td>
  <td colspan=18 class=xl520 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=299 style='width:224pt'></td>
  <td width=4 style='width:3pt'></td>
  <td width=181 style='width:136pt'></td>
  <td width=182 style='width:137pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=6 style='width:5pt'></td>
  <td width=181 style='width:136pt'></td>
  <td width=182 style='width:137pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=4 style='width:3pt'></td>
  <td width=182 style='width:137pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
