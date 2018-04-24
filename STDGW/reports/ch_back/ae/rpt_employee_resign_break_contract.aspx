<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_user,p_tco_dept_pk,p_thr_group_pk,p_search_by,p_search_temp;
    string p_from_dt,p_to_dt,p_month,p_contract_type,p_break_contract;
     
  
    p_tco_dept_pk       = Request["p_tco_dept_pk"].ToString();
    p_thr_group_pk      = Request["p_thr_wgroup_pk"].ToString();
    p_search_by         = Request["p_search"].ToString();
    p_search_temp       = Request["p_input"].ToString();
    p_from_dt           = Request["p_from"].ToString();
    p_to_dt             = Request["p_to"].ToString();
    p_month             = Request["p_month"].ToString();
    p_contract_type     = Request["p_contract_type"].ToString();
    p_break_contract    = Request["p_break_contract"].ToString();
    //p_cal_salary        = Request["p_cal_salary"].ToString();
   
    if (p_from_dt == "" && p_to_dt == "")
    {
        p_from_dt = p_month + "01";
        p_to_dt = p_month + "31";
    } 
    
string SQL
    = "SELECT   b.thr_emp_pk AS emp_pk_0, e.org_nm AS dept_nm_1, " + 
        "         c.workgroup_nm grp_nm_2, a.emp_id emp_id_3, a.full_name full_nm_4, " +
        "         TO_CHAR (TO_DATE (a.join_dt, 'yyyymmdd'), 'dd/mm/yyyy') AS join_dt_5, " +
        "         TO_CHAR (TO_DATE (a.left_dt, 'yyyymmdd'), 'dd/mm/yyyy') AS left_dt_6, " +
        "         (SELECT code_nm " +
        "            FROM vhr_hr_code " +
        "           WHERE ID = 'HR0004' AND code(+) = a.resign_type) resign_type_7, " +
        "         d.code_nm AS contract_type_8, d.num_4 AS deduct_days_rule_9, " +
        "         DECODE (NVL (b.break_contract_yn, 'N'), " +
        "                 'N', 'NO', " +
        "                 'YES' " +
        "                ) break_contract_10, " +
        "         TO_CHAR (TO_DATE (b.notice_dt, 'yyyymmdd'), 'dd/mm/yyyy') AS notice_dt_11, b.deduct_days deduct_day_12, " +
        "         a.basic_sal basic_sal_13, round(b.deduct_amt,10) deduct_amt_14, " +
        "         (CASE " +
        "             WHEN NVL (b.deduct_break_contract_yn, 'N') = 'Y' " +
        "                THEN 'YES' " +
        "             ELSE 'NO' " +
        "          END " +
        "         ) AS cal_sal_15 " +
        "    FROM thr_employee a, " +
        "         thr_employee_resign b, " +
        "         thr_work_group c, " +
        "         vhr_hr_code d, " +
        "         tco_org e " +
        "   WHERE a.del_if = 0 " +
        "     AND b.del_if = 0 " +
        "     AND c.del_if = 0 " +
        "     AND e.del_if = 0 " +
        "     AND d.ID = 'HR0001' " +
        "     AND a.tco_org_pk = e.pk " +
        "     AND b.thr_emp_pk = a.pk " +
        "     AND a.thr_wg_pk = c.pk " +
        "     AND a.contract_type = d.code " +
        "     AND DECODE ('"+ p_thr_group_pk +"', 'ALL', 'ALL', a.thr_wg_pk) = '"+ p_thr_group_pk +"' " +
        "     AND (   a.tco_org_pk IN ( " +
        "                             SELECT     g.pk " +
        "                                   FROM tco_org g " +
        "                                  WHERE g.del_if = 0 " +
         "                             START WITH g.pk = DECODE ('"+ p_tco_dept_pk +"', " +
        "                                                       'ALL', 0, " +
        "                                                       '"+ p_tco_dept_pk +"' " +
        "                                                      ) " +
        "                             CONNECT BY PRIOR g.pk = g.p_pk) " +
        "          OR '"+ p_tco_dept_pk +"' = 'ALL' " +
        "         ) " +
        "     AND UPPER (DECODE ('"+ p_search_by +"', 1, a.full_name, 2, a.emp_id, a.id_num)) LIKE " +
        "                                                       '%' || UPPER ('"+ p_search_temp +"') " +
        "                                                       || '%' " +
        "     AND a.left_dt BETWEEN '"+ p_from_dt +"' AND '"+ p_to_dt +"' " +
        "     AND DECODE ('"+ p_contract_type +"', 'ALL', 'ALL', a.contract_type) = '"+ p_contract_type +"' " +
        "     AND DECODE ('"+ p_break_contract +"', 'ALL', 'ALL', b.break_contract_yn) = '"+ p_break_contract +"' " +
        //"     AND DECODE ('"+ p_cal_salary +"', 'ALL', 'ALL', b.cal_salary) = '"+ p_cal_salary +"' " +
        "ORDER BY e.org_nm,workgroup_nm, emp_id " ;
        
        
        
//Response.Write(SQL);
//Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_employee_resign_break_contract_files/filelist.xml">
<link rel=Edit-Time-Data
href="rpt_employee_resign_break_contract_files/editdata.mso">
<link rel=OLE-Object-Data
href="rpt_employee_resign_break_contract_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>EINSVINA</o:Author>
  <o:LastAuthor>baoky</o:LastAuthor>
  <o:LastPrinted>2008-10-03T02:34:16Z</o:LastPrinted>
  <o:Created>2006-12-21T09:46:33Z</o:Created>
  <o:LastSaved>2008-10-03T02:41:26Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.18in .2in .33in .2in;
	mso-header-margin:.17in;
	mso-footer-margin:.18in;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:#CCCCFF none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:#CCCCFF none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:#CCCCFF none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	color:black;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
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
      <x:Scale>63</x:Scale>
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
       <x:ActiveRow>3</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
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
  <x:WindowHeight>5550</x:WindowHeight>
  <x:WindowWidth>10770</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>180</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl47>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1613 style='border-collapse:
 collapse;table-layout:fixed;width:1213pt'>
 <col class=xl47 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl47 width=128 style='mso-width-source:userset;mso-width-alt:4681;
 width:96pt'>
 <col class=xl47 width=134 style='mso-width-source:userset;mso-width-alt:4900;
 width:101pt'>
 <col class=xl47 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl47 width=194 style='mso-width-source:userset;mso-width-alt:7094;
 width:146pt'>
 <col class=xl47 width=93 span=2 style='mso-width-source:userset;mso-width-alt:
 3401;width:70pt'>
 <col class=xl47 width=193 style='mso-width-source:userset;mso-width-alt:7058;
 width:145pt'>
 <col class=xl47 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl47 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl47 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl47 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl47 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl47 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl47 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl47 width=37 style='height:24.75pt;width:28pt'></td>
  <td class=xl27 width=128 style='width:96pt'></td>
  <td class=xl47 width=134 style='width:101pt'></td>
  <td class=xl26 width=94 style='width:71pt'></td>
  <td colspan=7 class=xl41 width=852 style='width:641pt'>REPORT BREAK OF
  CONTRACT SUMMARY</td>
  <td class=xl45 width=93 style='width:70pt'></td>
  <td class=xl45 width=87 style='width:65pt'></td>
  <td class=xl45 width=103 style='width:77pt'></td>
  <td class=xl47 width=85 style='width:64pt'></td>
 </tr>
 <tr class=xl48 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl25 style='height:26.25pt'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl43>DANH SÁCH NHÂN VIÊN VI PHẠM HỢP ĐỒNG</td>
  <td colspan=3 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
 </tr>
 <tr class=xl48 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl25 style='height:26.25pt'></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <%
    if (p_month == "")
    {
   %>
  <td colspan=4 class=xl42>From: <%=p_from_dt.Substring(6,2) + "/" + p_from_dt.Substring(4,2) + "/" + p_from_dt.Substring(0,4) %>    
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To: <%=p_to_dt.Substring(6,2) + "/" + p_to_dt.Substring(4,2) + "/" + p_to_dt.Substring(0,4) %></td>
  <%
    }
    else
    {
   %> 
  <td colspan=4 class=xl42>Month: <%=p_month.Substring(4,2) + "/" + p_month.Substring(0,4) %></td> 
  <%
    }
   %>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td colspan=3 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl49 height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl29 width=37 style='height:33.75pt;width:28pt'>No.</td>
  <td class=xl29 width=128 style='border-left:none;width:96pt'>Department</td>
  <td class=xl29 width=134 style='border-left:none;width:101pt'>Group</td>
  <td class=xl29 width=94 style='border-top:none;border-left:none;width:71pt'>Emp
  ID</td>
  <td class=xl29 width=194 style='border-top:none;border-left:none;width:146pt'>Full
  Name</td>
  <td class=xl29 width=93 style='border-top:none;border-left:none;width:70pt'>Join
  Date</td>
  <td class=xl28 width=93 style='border-top:none;border-left:none;width:70pt'>Left
  Date</td>
  <td class=xl28 width=193 style='border-top:none;width:145pt'>Resign Type</td>
  <td class=xl28 width=97 style='border-top:none;width:73pt'>Contract No.</td>
  <td class=xl28 width=96 style='border-top:none;width:72pt'>Deduct Days (Rule)</td>
  <td class=xl28 width=86 style='border-top:none;width:65pt'>Break Contract</td>
  <td class=xl28 width=93 style='border-top:none;width:70pt'>Notice Day</td>
  <td class=xl28 width=87 style='width:65pt'>Deduct Days</td>
  <td class=xl28 width=103 style='width:77pt'>Deduct Amount</td>
  <td class=xl32 width=85 style='width:64pt'>Input by Hand</td>
 </tr>
 <%
    for(int i=0;i<irow;i++)
    {
  %>
 <tr class=xl24 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl33 style='height:30.0pt' x:num><%=i+1 %></td>
  <td class=xl34><%=dt_total.Rows[i][1].ToString() %></td>
  <td class=xl34><%=dt_total.Rows[i][2].ToString() %></td>
  <td class=xl35 x:num><%=dt_total.Rows[i][3].ToString() %></td>
  <td class=xl36><%=dt_total.Rows[i][4].ToString() %></td>
  <td class=xl37 x:str><%=dt_total.Rows[i][5].ToString() %></td>
  <td class=xl37 x:str><%=dt_total.Rows[i][6].ToString() %></td>
  <td class=xl40 style='border-left:none'><%=dt_total.Rows[i][7].ToString() %></td>
  <td class=xl40 style='border-left:none'><%=dt_total.Rows[i][8].ToString() %></td>
  <td class=xl39 style='border-left:none' x:num><%=dt_total.Rows[i][9].ToString() %></td>
  <td class=xl44 style='border-left:none'><%=dt_total.Rows[i][10].ToString() %></td>
  <td class=xl37 x:str><%=dt_total.Rows[i][11].ToString() %></td>
  <td class=xl39 style='border-left:none' x:num><%=dt_total.Rows[i][12].ToString() %></td>
  <td class=xl39 style='border-left:none' x:num><%=dt_total.Rows[i][14].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none' x:str><span
  style='mso-spacerun:yes'> </span><%=dt_total.Rows[i][15].ToString() %><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=134 style='width:101pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=194 style='width:146pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=193 style='width:145pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=85 style='width:64pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
