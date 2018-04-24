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
    string p_user,p_tco_dept_pk,p_thr_group_pk,p_search_by,p_search_temp,p_type;
    string p_from_dt, p_to_dt, p_month, p_return_card, p_health_card, p_health_yn;
     
  
    p_tco_dept_pk       = Request["p_tco_dept_pk"].ToString();
    p_thr_group_pk = Request["p_thr_wgroup_pk"].ToString();
    p_search_by         = Request["p_search"].ToString();
    p_search_temp       = Request["p_input"].ToString();
    p_from_dt           = Request["p_from"].ToString();
    p_to_dt             = Request["p_to"].ToString();
    p_month             = Request["p_month"].ToString();
    p_return_card       = Request["p_return_card"].ToString();
    p_health_card       = Request["p_health_card"].ToString();
    p_health_yn         = Request["p_health_yn"].ToString();
    //p_cal_salary        = Request["p_cal_salary"].ToString();
    p_type = Request["p_type"].ToString();
   
    if (p_from_dt == "" && p_to_dt == "")
    {
        p_from_dt = p_month + "01";
        p_to_dt = p_month + "31";
    } 
    
    string SQL
    = "SELECT   b.org_nm dept_nm_0, c.workgroup_nm grp_nm_1, a.emp_id emp_id_2, a.full_name full_nm_3, " + 
        "               TO_CHAR (TO_DATE (a.join_dt, 'yyyymmdd'), 'dd/mm/yyyy') join_dt_4, " +
        "               TO_CHAR (TO_DATE (a.left_dt, 'yyyymmdd'), 'dd/mm/yyyy') left_dt_5, " +
        "               (select CODE_NM from vhr_hr_code where id='HR0004' and code(+) = a.RESIGN_TYPE ) resign_type_6, " +
        "               d.ale_last_year as ale_last_year_7, d.annual_stop ale_stop_8,d.annual_stop_amt ale_stop_amt_9, " +
        "               ( case when nvl(d.severance_flag,'N')='Y' then 'YES' else 'NO' end) ser_flag_10, NVL(D.SEVERANCE_MONTH,0) + NVL(D.NOT_UNEMP_MON,0) ser_month_11, " +
        "               d.severance_amt ser_amt_12, ( case when nvl(d.return_health_card,'C')='Y' then 'YES' WHEN nvl(d.return_health_card,'C')='N' THEN 'NO' else 'NOT YET' end) ret_health_card_13 " +
        "               , ( case when nvl(d.return_card,'N')='Y' then 'YES' else 'NO' end) return_card_14 " +
        //"                ( case when nvl(d.cal_salary,'N')='Y' then 'YES' else 'NO' end) cal_sal_15 " +
        " ,nvl(d.EQUIP1_AMT,0),nvl(d.EQUIP2_AMT,0),nvl(EQUIP3_AMT,0),nvl(EQUIP4_AMT,0),nvl(EQUIP5_AMT,0),nvl(d.EQUIP6_AMT,0),nvl(d.EQUIP7_AMT,0),nvl(d.EQUIP8_AMT,0),nvl(d.SENIORITY_AMT,0) FROM thr_employee a, tco_org b, thr_work_group c,thr_employee_resign d " +
        "         WHERE a.del_if = 0 and d.del_if=0 " +
        "           AND b.del_if = 0 and a.pk=d.thr_emp_pk " +
        "           AND c.del_if = 0 " +
        "           AND a.thr_wg_pk = c.pk " +
        "           AND a.tco_org_pk = b.pk " +
        "           AND DECODE ('"+ p_thr_group_pk +"', 'ALL', 'ALL', a.thr_wg_pk) = '"+ p_thr_group_pk +"' " +
        "           AND DECODE ('" + p_health_yn + "', 'ALL', 'ALL', A.HEALTH_YN) = '" + p_health_yn + "' " +
        "           AND (a.tco_org_pk IN (SELECT g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = DECODE ('"+ p_tco_dept_pk +"','ALL', 0,'"+ p_tco_dept_pk +"') " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '"+ p_tco_dept_pk +"' = 'ALL') " +
        "           AND UPPER (DECODE ('"+ p_search_by +"',1, a.full_name,2, a.emp_id,a.id_num)) LIKE '%' || UPPER ('"+ p_search_temp +"') || '%' " +
        "           AND a.left_dt BETWEEN '"+ p_from_dt +"' AND '"+ p_to_dt +"' " +
        "           AND DECODE ('" + p_type + "', 'ALL', 'ALL', d.resign_type) = '" + p_type + "' " +
        "           AND DECODE ('"+ p_return_card +"', 'ALL', 'ALL', d.return_card) = '"+ p_return_card +"' " +
        "           AND DECODE ('"+ p_health_card +"','ALL', 'ALL',d.return_health_card) = '"+ p_health_card +"' " +
        //"           AND DECODE ('"+ p_cal_salary +"', 'ALL', 'ALL', d.cal_salary) = '"+ p_cal_salary +"' " +
        "      ORDER BY nvl(b.seq,0), org_nm, workgroup_nm, emp_id " ;

        
        
        
//Response.Write(SQL);
//Response.End();
    string SQL2
    = "select * from ( " +
        "  (select t.code ,nvl(t.USE_YN,'N'),t.CODE_NM from thr_code_master m,thr_code_detail t  " +
        "  where m.del_if=0 and m.ID='HR0118' and m.pk=t.THR_CODE_MASTER_PK and t.del_if=0 ) " +
        "  union   all  (select t.code ,nvl(t.USE_YN,'N'),t.CODE_NM from thr_code_master m,thr_code_detail t  " +
        "  where m.del_if=0 and m.ID='HR0006' and m.pk = t.THR_CODE_MASTER_PK  and t.code ='10' and t.del_if=0))  " +
        "  order by code ";

    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    DataTable dt_equip = ESysLib.TableReadOpen(SQL2);
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
<link rel=File-List href="rpt_employee_resign_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_resign_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_resign_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>EINSVINA</o:Author>
  <o:LastAuthor>baoky</o:LastAuthor>
  <o:LastPrinted>2008-10-02T02:40:25Z</o:LastPrinted>
  <o:Created>2006-12-21T09:46:33Z</o:Created>
  <o:LastSaved>2008-10-02T03:52:03Z</o:LastSaved>
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
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
.xl34
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
.xl35
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
.xl36
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
.xl37
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
.xl38
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
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
.xl40
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
.xl41
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
.xl42
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
	border-left:none;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl49
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>57</x:Scale>
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
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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
  <x:WindowHeight>5475</x:WindowHeight>
  <x:WindowWidth>10770</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1907 style='border-collapse:
 collapse;table-layout:fixed;width:1433pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:2506;
 width:25pt'>
 <col class=xl24 width=128 style='mso-width-source:userset;mso-width-alt:4681;
 width:96pt'>
 <col class=xl24 width=134 style='mso-width-source:userset;mso-width-alt:4900;
 width:101pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=194 style='mso-width-source:userset;mso-width-alt:7094;
 width:146pt'>
 <col class=xl24 width=93 span=2 style='mso-width-source:userset;mso-width-alt:
 3401;width:70pt'>
 <col class=xl24 width=193 style='mso-width-source:userset;mso-width-alt:7058;
 width:145pt'>
 <%--<col class=xl24 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>--%>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl24 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl24 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl24 width=112 style='mso-width-source:userset;mso-width-alt:4096;
 width:84pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <%for (int i = 0; i < 9; i++)
   {%>
 <col class=xl24 width=64 style='mso-width-source:userset;mso-width-alt:2340;width:48pt;<%=(dt_equip.Rows[i][1].ToString()=="N")?"display:none":"" %>'>
 <%} %>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl24 width=33 style='height:24.75pt;width:25pt'></td>
  <td class=xl32 width=128 style='width:96pt'></td>
  <td class=xl24 width=134 style='width:101pt'></td>
  <td class=xl31 width=94 style='width:71pt'></td>
  <td class=xl31 width=194 style='width:146pt'></td>
  <td class=xl24 width=93 style='width:70pt'></td>
  <td colspan=6 class=xl47 width=612 style='width:460pt'>REPORT EMPLOYEE RESIGN
  SUMMARY</td>
  <td class=xl24 width=91 style='width:68pt'></td>
  <td class=xl24 width=112 style='width:84pt'></td>
  <td class=xl24 width=107 style='width:80pt'></td>
  <td class=xl24 width=87 style='width:65pt'></td>
  <td class=xl24 width=100 style='width:75pt'></td>
  <td colspan=9 class=xl24 width=100 style='width:75pt'></td>
 </tr>
 <tr class=xl28 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl27 style='height:26.25pt'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td class=xl28></td>
  <td colspan=6 class=xl48>DANH SÁCH CÔNG NHÂN THÔI VIỆC</td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl27 style='height:26.25pt'></td>
  <td class=xl28></td>
  <%
    if (p_month == "")
    {
   %>
  <td colspan=3 class=xl49>From: <%=p_from_dt.Substring(6,2) + "/" + p_from_dt.Substring(4,2) + "/" + p_from_dt.Substring(0,4) %>    
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To: <%=p_to_dt.Substring(6,2) + "/" + p_to_dt.Substring(4,2) + "/" + p_to_dt.Substring(0,4) %></td>
  <%
    }
    else
    {
   %> 
  <td colspan=3 class=xl49>Month: <%=p_month.Substring(4,2) + "/" + p_month.Substring(0,4) %></td>
  <%
    }
   %>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl30></td>
  <td colspan=16 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl34 width=33 style='height:33.75pt;width:25pt'>No.</td>
  <td class=xl34 width=128 style='border-left:none;width:96pt'>Department</td>
  <td class=xl34 width=134 style='border-top:none;border-left:none;width:101pt'>Group</td>
  <td class=xl34 width=94 style='border-top:none;border-left:none;width:71pt'>Emp
  ID</td>
  <td class=xl34 width=194 style='border-top:none;border-left:none;width:146pt'>Full
  Name</td>
  <td class=xl34 width=93 style='border-left:none;width:70pt'>Join Date</td>
  <td class=xl33 width=93 style='border-left:none;width:70pt'>Left Date</td>
  <td class=xl33 width=193 style='border-top:none;width:145pt'>Resign Type</td>
  <td class=xl33>Remark</td>
  <td class=xl33 width=83 style='border-top:.5pt;width:62pt'>ALE Last Year</td>
  <td class=xl33 width=70 style='width:53pt'>Remain ALE</td>
  <td class=xl33 width=87 style='width:65pt'>Remain ALE AMT</td>
  <td class=xl33 width=86 style='width:65pt'>Severance Flag</td>
  <td class=xl33 width=91 style='width:68pt'>Severance Month Total</td>
  <td class=xl33 width=112 style='width:84pt'>Severance AMT</td>
  <td class=xl33 width=107 style='width:80pt'>Return Health Tiket</td>
  <td class=xl33 width=87 style='width:65pt'>Return Card</td>
 <%-- <td class=xl37 width=100 style='width:75pt'>Calculate Salary</td>--%>
  
   <td class=xl37 width=100 style='width:75pt'><%=dt_equip.Rows[0][2].ToString()%></td>
   <td class=xl37 width=100 style='width:75pt'><%=dt_equip.Rows[1][2].ToString()%></td>
   <td class=xl37 width=100 style='width:75pt'><%=dt_equip.Rows[2][2].ToString()%></td>
   <td class=xl37 width=100 style='width:75pt'><%=dt_equip.Rows[3][2].ToString()%></td>
   <td class=xl37 width=100 style='width:75pt'><%=dt_equip.Rows[4][2].ToString()%></td>
   <td class=xl37 width=100 style='width:75pt'><%=dt_equip.Rows[5][2].ToString()%></td>
   <td class=xl37 width=100 style='width:75pt'><%=dt_equip.Rows[6][2].ToString()%></td>
   <td class=xl37 width=100 style='width:75pt'><%=dt_equip.Rows[7][2].ToString()%></td>
   <td class=xl37 width=100 style='width:75pt'>Seniority</td>
   
   
 </tr>
 <%
    for(int i=0;i<irow;i++)
    {
  %>
 <tr class=xl26 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl38 style='height:30.0pt' x:num><%=i+1 %></td>
  <td class=xl39><%=dt_total.Rows[i][0].ToString() %></td>
  <td class=xl39><%=dt_total.Rows[i][1].ToString() %></td>
  <td class=xl40 x:str><%=dt_total.Rows[i][2].ToString() %></td>
  <td class=xl41><%=dt_total.Rows[i][3].ToString() %></td>
  <td class=xl42 x:str><%=dt_total.Rows[i][4].ToString() %></td>
  <td class=xl42 x:str><%=dt_total.Rows[i][5].ToString() %></td>
  <td class=xl43 style='border-left:none'><%=dt_total.Rows[i][6].ToString() %></td>
  <td class=xl43 style='border-left:none'><%=dt_total.Rows[i][16].ToString() %></td>
  <td class=xl45 style='border-left:none' x:num><%=dt_total.Rows[i][7].ToString() %></td>
  <td class=xl45 style='border-left:none; display:none;' x:num><%=dt_total.Rows[i][8].ToString() %></td>
  <td class=xl44 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%=dt_total.Rows[i][9].ToString() %> </td>
  <td class=xl38 style='border-left:none'><%=dt_total.Rows[i][10].ToString() %></td>
  <td class=xl38 style='border-left:none' x:num><%=dt_total.Rows[i][11].ToString() %></td>
  <td class=xl46 style='border-left:none' x:num><%=dt_total.Rows[i][12].ToString() %></td>
  <td class=xl38 style='border-left:none'><%=dt_total.Rows[i][13].ToString() %></td>
  <td class=xl38 style='border-left:none'><%=dt_total.Rows[i][14].ToString() %></td>
  <%--<td class=xl38 style='border-top:none;border-left:none'><%=dt_total.Rows[i][15].ToString() %></td>--%>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_total.Rows[i][15].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_total.Rows[i][16].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_total.Rows[i][17].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_total.Rows[i][18].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_total.Rows[i][19].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_total.Rows[i][20].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_total.Rows[i][21].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_total.Rows[i][22].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'><%=dt_total.Rows[i][23].ToString() %></td>
 </tr>
 <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
 
 </tr>
 <![endif]>
</table>

</body>

</html>
