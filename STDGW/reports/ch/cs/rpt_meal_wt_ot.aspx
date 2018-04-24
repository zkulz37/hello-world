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

    string p_user_id,p_menu_id;
    p_user_id=Session["USER_ID"].ToString();
   /* p_menu_id="10030007"; //menu salary report form (ko lay tu form truyen vao nhe)
    string SQL_USER="SELECT SYS_F_CHECK_USER('" + p_user_id + "','" + p_menu_id + "') FROM DUAL";
    
    DataTable data_user = ESysLib.TableReadOpen(SQL_USER);
    if (data_user.Rows[0][0].ToString()=="0")
    {
        Response.Write("you haven't got authorize to print this report (nhe thang nhoc, do an cap)");
        Response.End();
    }
    */

    string p_dept, p_group, p_status, p_type, p_bank_type, p_emp_id, p_work_mon, p_m_type,p_sal_period;


    p_dept = Request["l_dept"].ToString();
    p_group = Request["l_group"].ToString();
    p_status = Request["l_status"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    string SQL
    = "select A.DEPT_NM c00 " +
        "        , A.EMP_ID c01 " +
        "        , A.FULL_NAME c02 " +
        "        , nvl(A.MEAL_WT,0) c03 " +
        "        , nvl(A.MEAL_WT_AMT,0) c04 " +
        "        , nvl(A.MEAL_OT,0) c05 " +
        "        , nvl(A.MEAL_OT_AMT,0) c06 " +
        "        , nvl(A.MEAL_WT_CASH,0) c07 " +
        "        , nvl(A.MEAL_WT_CASH_AMT,0) c08 " +
        "        , nvl(A.MEAL_OT_CASH,0) c09 " +
        "        , nvl(A.MEAL_OT_CASH_AMT,0) c10 " +
        "        , nvl(A.MEAL_WT_DEDUCT,0) c11 " +
        "        , nvl(A.MEAL_WT_DEDUCT_AMT,0) c12 " +
        "        , nvl(A.MEAL_OT_DEDUCT,0) c13 " +
        "        , nvl(A.MEAL_OT_DEDUCT_AMT,0) c14 " +
        "        , nvl(b.seq,0) c15   "+
        "        , to_char(to_date(a.work_mon,'yyyymm'), 'mm/yyyy') c16   "+
        "from thr_month_salary a, tco_org b " +
        "where A.DEL_IF=0 and b.del_if=0 and a.TCO_DEPT_PK = b.pk " +
        "and A.WORK_MON = '" + p_work_mon + "' " +
        " and a.emp_id like '%" + p_emp_id + "%' " + 
        " and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
        " order by c15, c00, c01  ";

    //Response.Write(SQL);
    //Response.End();

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp, icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp = dt_Emp.Columns.Count-2;
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
<link rel=File-List href="rpt_meal_wt_ot_ens_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_meal_wt_ot_ens_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_meal_wt_ot_ens_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>SV108</o:Author>
  <o:LastAuthor>Hee Nguyen</o:LastAuthor>
  <o:LastPrinted>2014-09-26T06:45:17Z</o:LastPrinted>
  <o:Created>2014-09-18T02:11:07Z</o:Created>
  <o:LastSaved>2014-09-26T07:20:27Z</o:LastSaved>
  <o:Company>vina</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .7in .75in .7in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
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
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl68
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style43;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl80
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
.xl81
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
.xl82
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
.xl83
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CC99FF;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>73</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
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
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
       <x:RangeSelection>$A$4:$A$5</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>6285</x:WindowHeight>
  <x:WindowWidth>14220</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>705</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1244 style='border-collapse:
 collapse;table-layout:fixed;width:933pt'>
 <col class=xl66 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl66 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <col class=xl69 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl67 width=142 style='mso-width-source:userset;mso-width-alt:5193;
 width:107pt'>
 <col class=xl67 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl66 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl66 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl66 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl66 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl66 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl66 width=33 style='height:15.0pt;width:25pt'></td>
  <td class=xl66 width=119 style='width:89pt'></td>
  <td class=xl69 width=51 style='width:38pt'></td>
  <td class=xl67 width=142 style='width:107pt'></td>
  <td class=xl67 width=45 style='width:34pt'></td>
  <td class=xl66 width=103 style='width:77pt'></td>
  <td class=xl66 width=40 style='width:30pt'></td>
  <td class=xl66 width=103 style='width:77pt'></td>
  <td class=xl66 width=40 style='width:30pt'></td>
  <td class=xl66 width=103 style='width:77pt'></td>
  <td class=xl66 width=42 style='width:32pt'></td>
  <td class=xl66 width=103 style='width:77pt'></td>
  <td class=xl66 width=41 style='width:31pt'></td>
  <td class=xl66 width=103 style='width:77pt'></td>
  <td class=xl66 width=73 style='width:55pt'></td>
  <td class=xl66 width=103 style='width:77pt'></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td colspan=16 height=34 class=xl79 style='height:25.5pt'>MEAL THÁNG <%=dt_Emp.Rows[0]["c16"].ToString() %></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=2 class=xl66 style='height:12.0pt;mso-ignore:colspan'></td>
  <td class=xl69></td>
  <td colspan=2 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl70>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td class=xl71></td>
  <td colspan=5 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td rowspan=2 height=102 class=xl83 style='height:76.5pt'>No</td>
  <td rowspan=2 class=xl84 style='border-bottom:.5pt solid black'>Bộ phận</td>
  <td rowspan=2 class=xl85>ID</td>
  <td rowspan=2 class=xl84 style='border-bottom:.5pt solid black'>Employee name</td>
  <td colspan=4 class=xl86 style='border-right:.5pt solid black;border-left:
  none' x:str="Meal ">Meal<span style='mso-spacerun:yes'> </span></td>
  <td colspan=4 class=xl89 style='border-right:.5pt solid black;border-left:
  none'>Cash</td>
  <td colspan=4 class=xl89 style='border-right:.5pt solid black;border-left:
  none'>Deduct</td>
 </tr>
 <tr class=xl66 height=68 style='mso-height-source:userset;height:51.0pt'>
  <td height=68 class=xl93 width=45 style='height:51.0pt;border-left:none;
  width:34pt' x:str="Meal ">Meal<span style='mso-spacerun:yes'> </span></td>
  <td class=xl93 width=103 style='border-left:none;width:77pt'>Meal CĐ + ST +HT</td>
  <td class=xl93 width=40 style='border-left:none;width:30pt' x:str="Meal ">Meal<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl93 width=103 style='border-left:none;width:77pt'>Meal OT thường +
  OT vượt (ST, HT)</td>
  <td class=xl93 width=40 style='border-top:none;border-left:none;width:30pt'
  x:str="Meal ">Meal<span style='mso-spacerun:yes'> </span></td>
  <td class=xl93 width=103 style='border-top:none;border-left:none;width:77pt'>Meal
  CĐ + ST +HT</td>
  <td class=xl93 width=42 style='border-top:none;border-left:none;width:32pt'
  x:str="Meal ">Meal<span style='mso-spacerun:yes'> </span></td>
  <td class=xl93 width=103 style='border-top:none;border-left:none;width:77pt'>Meal
  OT thường + OT vượt (ST, HT)</td>
  <td class=xl93 width=41 style='border-top:none;border-left:none;width:31pt'>Meal</td>
  <td class=xl93 width=103 style='border-top:none;border-left:none;width:77pt'>Meal
  CĐ + ST +HT</td>
  <td class=xl93 width=73 style='border-top:none;border-left:none;width:55pt'>Meal</td>
  <td class=xl93 width=103 style='border-top:none;border-left:none;width:77pt'>Meal
  OT thường + OT vượt (ST, HT)</td>
 </tr>
    <%
        int i = 0, flag=0;
        double[] grp_ttl = new double[icol_emp];
        double[] grd_ttl = new double[icol_emp];   
        for(i=0;i<irow_emp;i++)
        {
            if (i < irow_emp - 1)
            {
                if (dt_Emp.Rows[i]["c00"].ToString() != dt_Emp.Rows[i + 1]["c00"].ToString())
                    flag = 1;
                else
                    flag = 0;
            }
            else
                flag = 1;
            for (int j = 3; j < icol_emp;j++ )
            {
                grp_ttl[j] += double.Parse(dt_Emp.Rows[i][j].ToString());
                grd_ttl[j] += double.Parse(dt_Emp.Rows[i][j].ToString());
            }
         %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl73 style='height:21.75pt;border-top:none' x:num><%=i + 1%></td>
  <td class=xl74 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i]["c00"].ToString() %></td>
  <td class=xl68 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i]["c01"].ToString() %></td>
  <td class=xl74 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i]["c02"].ToString() %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c03"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c04"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c05"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c06"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c07"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c08"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c09"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c10"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c11"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c12"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c13"].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i]["c14"].ToString() %><span style='mso-spacerun:yes'> </span></td>
 </tr>
    <%
        if(flag==1)
        { %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=4 height=29 class=xl80 style='border-right:.5pt solid black;
  height:21.75pt'>TOTAL OF <%=dt_Emp.Rows[i]["c00"].ToString() %></td>
  <%
      for(int j=3;j<icol_emp;j++)
      { %>
     <td class=xl75 style='border-top:none;border-left:none' x:num><%=grp_ttl[j] %></td>
    <%
          grp_ttl[j] = 0;
        } %>
 </tr>

    <%
        
        } %>

    <%
    }
         %>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=4 height=34 class=xl76 style='border-right:.5pt solid black;
  height:25.5pt'>GRAND TOTAL</td>
 <%
      for(int j=3;j<icol_emp;j++)
      { %>
     <td class=xl75 style='border-top:none;border-left:none' x:num><%=grd_ttl[j] %></td>
  <%
          grd_ttl[j] = 0;
        } %>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=142 style='width:107pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=103 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
