<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%   ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string p_work_dt, p_ext_rate, p_nation, p_org_pk;
    string p_status;
    p_status = Request["p_status"].ToString(); 
  
    p_work_dt       = Request["p_1"].ToString();
    p_nation = Request["p_nation"].ToString();
    p_org_pk = Request["p_org"].ToString();



    string SQL
    = "select  pl.pl_nm c3,count(*) c4 " +
        ",round(sum(nvl(a.SALARY,0))) c5, round(sum(nvl(a.TOTAL_ALLOWANCE,0))) c6,round(sum(nvl(a.WT,0)),2) c7,round(sum(nvl(a.ABS_PAY,0)),2) c8 " +
        ",round(sum(nvl(a.WT_AMT,0)+nvl(a.ABS_PAY_AMT,0))) c9 " +
        ",round(sum(nvl(a.TOTAL_OT,0)),2) c10,round(sum(nvl(a.TOTAL_OT_AMT,0))) c11 " +
        ",round(sum(nvl(a.INS_EMPLOYEE,0))) c12,round(sum(nvl(a.INS_COMPANY,0))) c13 " +
        ",round(sum(nvl(a.COMPANY_COST,0))) c14,max(A.EX_RATE),to_char(to_date('20100616','yyyymmdd'),'DD-MON-YYYY') " +
        " from thr_daily_cost a,tco_org b,thr_employee c,(SELECT e.pk as pk,D.PL_NM||' - '||B.PLC_NM as pl_nm " +
        "                         FROM TAC_ABPL D, TAC_ABPLCENTER E, TAC_ABCENTER B " +
        "                        WHERE D.DEL_IF    = 0 " +
        "                          AND E.DEL_IF    = 0 " +
        "                          AND E.TAC_ABPL_PK = D.PK " +
        "                          AND E.TAC_ABCENTER_PK = B.PK) pl " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
        "and a.thr_emp_pk=c.pk and a.tco_org_pk=b.pk and a.TAC_ABPL_PK=pl.pk(+) " +
         " and decode('" + p_nation + "','ALL','ALL',c.nation)='" + p_nation + "' " +
         " and decode('" + p_status + "','ALL','ALL',c.status)='" + p_status + "' " +
         " AND (   c.tco_org_pk IN ( " +
         "                         SELECT     g.pk " +
         "                               FROM tco_org g " +
         "                              WHERE g.del_if = 0 " +
         "                         START WITH g.pk = " +
         "                                       DECODE ('" + p_org_pk + "', " +
         "                                               'ALL', 0, " +
         "                                               '" + p_org_pk + "'" +
         "                                              ) " +
         "                         CONNECT BY PRIOR g.pk = g.p_pk) " +
         "                   OR '" + p_org_pk + "' = 'ALL') " +
        "and a.work_dt='" + p_work_dt + "' " +
        "group by pl.pl_nm " +
        "order by pl.pl_nm ";






    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count-2;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
   
   
    
    
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_daily_cost_detail_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_daily_cost_detail_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_daily_cost_detail_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2008-09-10T02:44:10Z</o:LastPrinted>
  <o:Created>2008-09-06T07:03:32Z</o:Created>
  <o:LastSaved>2010-07-19T06:25:27Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.28in .19in .41in .2in;
	mso-header-margin:.3in;
	mso-footer-margin:.19in;
	mso-page-orientation:landscape;}
.font11
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
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
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>25</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
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
       <x:ActiveRow>5</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveCol>14</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$3:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025" u1:ext="edit"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=3722 style='border-collapse:
 collapse;table-layout:fixed;width:2792pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;width:33pt'>
 <col class=xl24 width=0 style='mso-width-source:userset;mso-width-alt:10240'>
 <col class=xl24 width=0 style='mso-width-source:userset;mso-width-alt:3000'>
 <col class=xl24 width=0 style='mso-width-source:userset;mso-width-alt:5000'>
 <col class=xl24 width=97 style='mso-width-source:userset;mso-width-alt:5000;width:73pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;width:58pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col class=xl24 width=108 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col class=xl24 width=108 span=4 style='mso-width-source:userset;mso-width-alt:3949;width:81pt'>
 <col class=xl24 width=64 span=12 style='width:48pt'>
 <col class=xl24 width=139 style='mso-width-source:userset;mso-width-alt:5083;width:104pt'>
 <col class=xl24 width=64 span=30 style='width:48pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 width=44 style='height:12.75pt;width:33pt'></td>
   <td class=xl24 width=0></td>
  <td class=xl24 width=0></td>
  <td class=xl24 width=97 style='width:73pt'></td>
  <td class=xl24 width=77 style='width:58pt'></td>
  <td class=xl24 width=66 style='width:50pt'></td>
  <td class=xl24 width=108 style='width:81pt'></td>
  <td class=xl24 width=71 style='width:53pt'></td>
  <td class=xl24 width=108 style='width:81pt'></td>
  <td class=xl24 width=108 style='width:81pt'></td>
  <td class=xl24 width=108 style='width:81pt'></td>
  <td class=xl24 width=108 style='width:81pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=139 style='width:104pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=41 style='mso-height-source:userset;height:30.75pt'>
  <td colspan=15 height=41 class=xl38 style='height:30.75pt'>DAILY COST DETAIL</td>
  <td colspan=43 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td colspan=3 height=35 class=xl39 style='height:26.25pt'>Work Date:<%=dt_Emp.Rows[0][13].ToString()%></td>
  <td class=xl25>Ex Rate:<%=dt_Emp.Rows[0][12].ToString()%></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td colspan=13 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=33 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=128 style='mso-height-source:userset;height:96.0pt'>
  <td height=128 class=xl28 width=44 style='height:96.0pt;width:33pt'>No.<br>
    <font class="font11">STT</font></td>
  <td class=xl30 width=0>Cost Center<br>
    <font class="font11">&nbsp;</font></td>
  <td class=xl31 width=0>Employee(s)<br>
    <font class="font11">Số NV</font></td>
  <td class=xl31 width=0>Salary<br>
    <font class="font11">Lương</font></td>
  <td class=xl31 width=97 style='width:73pt'>Allowance<br>
    <font class="font11">Phụ cấp</font></td>
  <td class=xl30 width=77 style='width:58pt'>Working hours<br>
    <font class="font11">Giờ công</font></td>
  <td class=xl30 width=66 style='width:50pt'>Abs pay<br>
    <font class="font11">Vắng hưởng lương</font></td>
  <td class=xl30 width=108 style='width:81pt'>Working Salary<br>
    <font class="font11">Lương ngày công</font></td>
  <td class=xl30 width=71 style='width:53pt'>Total OT <br>
    <font class="font11">Tổng giờ T.C</font></td>
  <td class=xl30 width=108 style='width:81pt'>OT Salary</td>
  <td class=xl30 width=108 style='width:81pt'>Insurance (Employee)<br>
    <font class="font11">BH NV Đóng</font></td>
  <td class=xl30 width=108 style='width:81pt'>Insurance (Company)<br>
    <font class="font11">BH C.Ty đóng</font></td>
  <td class=xl30 width=108 style='width:81pt'>Company Cost<br>
    <font class="font11">Chi phí</font></td>
  <td colspan=43 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <%
 int i;
    double[] Total = new double[icol_emp+1];
    for (i = 0; i <= icol_emp; i++)
     Total[i] = 0;
 for (i = 0; i < irow_emp; i++)
 {
     Total[1] += double.Parse(dt_Emp.Rows[i][1].ToString());
     Total[2] += double.Parse(dt_Emp.Rows[i][2].ToString());
     Total[3] += double.Parse(dt_Emp.Rows[i][3].ToString());
     Total[4] += double.Parse(dt_Emp.Rows[i][4].ToString());
     Total[5] += double.Parse(dt_Emp.Rows[i][5].ToString());
     Total[6] += double.Parse(dt_Emp.Rows[i][6].ToString());
     Total[7] += double.Parse(dt_Emp.Rows[i][7].ToString());
     Total[8] += double.Parse(dt_Emp.Rows[i][8].ToString());
     Total[9] += double.Parse(dt_Emp.Rows[i][9].ToString());
     Total[10] += double.Parse(dt_Emp.Rows[i][10].ToString());
     Total[11] += double.Parse(dt_Emp.Rows[i][11].ToString());
%>
 <tr class=xl32 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl33 style='height:17.25pt' x:num><%=i + 1%></td>
  <td class=xl34><%=dt_Emp.Rows[i][0].ToString()%></td>
  <td class=xl43 x:num><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl43 x:num><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl43 x:num><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl44 x:num><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl43 x:num><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl44 x:num><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl43 x:num><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl43 x:num><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl43 x:num><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl43 x:num><%=dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl43 x:num><%=dt_Emp.Rows[i][11].ToString()%></td>
  <td colspan=43 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr class=xl35 height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=2 height=39 class=xl40 style='border-right:.5pt solid black;
  height:29.25pt'>TOTAL</td>
  <td class=xl36 align=center x:num><%=Total[1]%></td>
  <td class=xl36 align=center x:num><%=Total[2]%></td>
  <td class=xl36 align=right x:num><%=Total[3]%></td>
  <td class=xl37 align=right x:num><%=Total[4]%></td>
  <td class=xl37 align=right x:num><%=Total[5]%></td>
  <td class=xl36 align=right x:num><%=Total[6]%></td>
  <td class=xl37 align=right x:num><%=Total[7]%></td>
  <td class=xl36 align=right x:num><%=Total[8]%></td>
  <td class=xl36 align=right x:num><%=Total[9]%></td>
  <td class=xl36 align=right x:num><%=Total[10]%></td>
  <td class=xl36 align=right x:num><%=Total[11]%></td>
  <td colspan=43 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=44 style='width:33pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=97 style='width:73pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=139 style='width:104pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
