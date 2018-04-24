﻿<%@ Page Language="C#"%>
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
    
    string p_dept,p_group,p_status,p_type,p_pay_type,p_emp_id,p_work_mon;
     
  
    p_dept       = Request["l_dept"].ToString();
    p_group      = Request["l_group"].ToString();
    p_status      = Request["l_status"].ToString();
    p_type       = Request["l_type"].ToString();
    p_pay_type   = Request["l_pay_type"].ToString();
    p_emp_id     = Request["l_emp_id"].ToString();
    p_work_mon   = Request["l_work_mon"].ToString();
    string p_m_type = Request.QueryString["l_m_type"].ToString();
    string p_sal_type = Request.QueryString["l_sal_type"].ToString();
    
    //-------------------department summary--------------------------

    string SQL
    = "select 1 as stt_0,f.PL_CD||' - '||f.PL_NM a1,max(v.code_nm)  " +
        ",count(a.thr_emp_pk) as count_emp_3  " +
        ",round(sum(NVL(A.WORK_PAYMENT,0) + nvl(a.ADDITION_PAYMENT,0)+ nvl(a.crane_PAYMENT,0) + nvl(a.ABS_ALE_L1_AMT,0) +nvl(a.ABS_ALE_L2_AMT,0) + nvl(a.HOL_DAY_L1_AMT,0) + nvl(a.HOL_DAY_L2_AMT,0)),3) wd4 " + 
        ",round(sum(nvl(a.TOTAL_OT_L1_AMT,0) + nvl(a.TOTAL_OT_L2_AMT,0)),3) ot_5 " +
        ",round(sum(nvl(a.ALLOW_K1_AMT,0) + nvl(a.ALLOW_K2_AMT,0)+ nvl(a.ALLOW_K3_AMT,0)+ nvl(a.ALLOW_K4_AMT,0)+ nvl(a.ALLOW_K5_AMT,0)+ nvl(a.ALLOW_K7_AMT,0)+ nvl(a.ALLOW_K8_AMT,0)),3) all_6 " +
        ",round(sum(NVL(a.RETURN_AMT,0)+NVL(a.INC_AMT,0)+NVL(a.ALE_STOP_AMT,0)+NVL(a.ALE_PIT_AMT,0)+ NVL(a.MEAL,0)+ NVL(a.NUM_TMP1,0)+ NVL(a.NUM_TMP2,0)+NVL(a.SEVERANCE_AMT,0)+NVL(a.NUM_TMP3,0)+NVL(a.RETURN_HEALTH_INS,0)+NVL(a.RETURN_SOCIAL_INS,0)+NVL(a.RETURN_UNEMP_INS,0)),3) oth_7 " +
        ",round(sum(nvl(a.income_tax,0)),3) pit_8 " +
        ",round(sum(nvl(a.SOCIAL_COMPANY,0)+nvl(a.HEALTH_COMPANY,0)+nvl(a.UNEMP_COM_INS,0)),3) ins_9  " +
        ",round(max(a.exchange_rate),3) as rate_10   " +
        ",to_char(to_date(max(a.work_mon),'yyyymm'),'MON - yyyy') "+
        " from thr_month_salary a, tco_org b,thr_employee e,acnt.tac_abpl f,vhr_hr_code v  " +
         " where a.del_if=0 and e.del_if=0 and f.del_if=0 and a.cost_group=v.code and v.id='HR0092'" +
        " and a.work_mon='" + p_work_mon + "' " +
        " and b.del_if=0 and e.pk=a.thr_emp_pk and e.tco_org_pk=b.pk and a.tac_abpl_pk=f.pk " +
        " and (e.tco_org_pk in ( " +
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
        " and decode('" + p_group + "','ALL','ALL',e.thr_wg_pk)='" + p_group + "'" +
        " and a.emp_id like '%" + p_emp_id + "%' " +
        " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
        " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
        " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
        " and decode('" + p_sal_type + "','ALL','ALL',a.SALARY_TYPE)='" + p_sal_type + "'" +
        " and nvl(a.nation,'01')='01' " +
        " and nvl(a.net_amt,0) " + p_type +
        " group by f.PL_CD||' - '||f.PL_NM " +
        " order by f.PL_CD||' - '||f.PL_NM ";



//Response.Write(SQL);
//Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary this month");
        Response.End();
    }
   
    
    
       
   
    
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_payroll_summary_posco_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_payroll_summary_posco_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_payroll_summary_posco_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>User</o:Author>
  <o:LastAuthor>banana</o:LastAuthor>
  <o:LastPrinted>2009-04-01T06:44:14Z</o:LastPrinted>
  <o:Created>2009-04-01T01:34:46Z</o:Created>
  <o:LastSaved>2009-04-01T06:50:58Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.33in .17in .25in .25in;
	mso-header-margin:.16in;
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
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1350 style='border-collapse:
 collapse;table-layout:fixed;width:1015pt'>
 <col class=xl24 width=128 style='mso-width-source:userset;mso-width-alt:12000;
 width:96pt'>
 <col class=xl24 width=128 style='mso-width-source:userset;mso-width-alt:4000;
 width:96pt'>
 <col class=xl24 width=110 span=5 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl24 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:4000;
 width:70pt'>
 <col class=xl24 width=95 style='mso-width-source:userset;mso-width-alt:4000;
 width:71pt'>
 <col class=xl24 width=128 style='mso-width-source:userset;mso-width-alt:4681;
 width:96pt'>
 <col class=xl24 width=117  style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 
 <tr height=82 style='mso-height-source:userset;height:61.5pt'>
  <td colspan=12 height=82 class=xl44 width=1350 style='height:61.5pt;
  width:1015pt'>SUMMARY SALARY <%=dt_Emp.Rows[0][11].ToString()%></td>
 </tr>
 <tr class=xl27 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl25 style='height:18.75pt'>Date:</td>
  <td class=xl26 x:num="39904" x:fmla="=TODAY()">4/1/2009</td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td class=xl27></td>
  <td class=xl27></td>
  <td class=xl27></td>
  <td class=xl28>Ex:</td>
  <td class=xl43 x:num><%=dt_Emp.Rows[0][10].ToString()%></td>
 </tr>
 <tr class=xl35 height=76 style='mso-height-source:userset;height:57.0pt'>
  <td height=76 class=xl33 style='height:57.0pt'>Cost Center Name</td>
  <td height=76 class=xl33 style='height:57.0pt'>Cost Kind </td>
  <td class=xl34 width=110 style='border-left:none;width:83pt'>Quantities
  <br>
    of Employees</td>
  <td class=xl34 width=110 style='border-left:none;width:83pt'>Working time payment<br />(VND)</td>
  <td class=xl34 width=110 style='border-left:none;width:83pt'>Overtime payment<br />(VND)</td>
  <td class=xl34 width=110 style='border-left:none;width:83pt'>Allowance<br />(VND)</td>
  <td class=xl34 width=111 style='border-left:none;width:83pt'>Other payment<br />(VND)</td>
  <td class=xl34 width=110 style='border-left:none;width:83pt'>Total payment<br />(VND)</td>
  <td class=xl34 width=110 style='border-left:none;width:83pt'>PIT<br />(VND)</td>
  <td class=xl34 width=110 style='border-left:none;width:83pt'>Average salary<br>
    /Person<br />(VND)</td>
  <td class=xl34 width=110 style='border-left:none;width:83pt'>Percent<br />(VND)</td>    
  <td class=xl34 width=93 style='border-left:none;width:70pt'>Company Cost<br />(VND)</td>
  
 </tr>
 <%
    string sstyle=";";
    double[] Total = new double[16];
    double col10, col11, col12,col13;
    col10 = col11 = col12 = col13=0; 
    for (int i = 0; i <= 15; i++)
    {
        Total[i] = 0;
    }
    for (int i = 0; i < irow_emp; i++)
    {
        Total[10] += Double.Parse(dt_Emp.Rows[i][4].ToString()) + Double.Parse(dt_Emp.Rows[i][5].ToString())
            + Double.Parse(dt_Emp.Rows[i][6].ToString()) + Double.Parse(dt_Emp.Rows[i][7].ToString());
            
    }    
    for (int i=0;i<irow_emp;i++)
    {
        col10 = Double.Parse(dt_Emp.Rows[i][4].ToString()) + Double.Parse(dt_Emp.Rows[i][5].ToString())
            + Double.Parse(dt_Emp.Rows[i][6].ToString()) + Double.Parse(dt_Emp.Rows[i][7].ToString());
            
        col11 = col10 / Double.Parse(dt_Emp.Rows[i][3].ToString());
        col12 = col10 / Total[10];
        col13 = col10 + Double.Parse(dt_Emp.Rows[i][8].ToString())+Double.Parse(dt_Emp.Rows[i][9].ToString());
        Total[3] += Double.Parse(dt_Emp.Rows[i][3].ToString());
        Total[4] += Double.Parse(dt_Emp.Rows[i][4].ToString());
        Total[5] += Double.Parse(dt_Emp.Rows[i][5].ToString());
        Total[6] += Double.Parse(dt_Emp.Rows[i][6].ToString());
        Total[7] += Double.Parse(dt_Emp.Rows[i][7].ToString());
        Total[8] += Double.Parse(dt_Emp.Rows[i][8].ToString());
        Total[9] += Double.Parse(dt_Emp.Rows[i][9].ToString());
        Total[11] += col12;
        Total[13] += col13;
        
        //Total[15] += Double.Parse(dt_Emp.Rows[i][13].ToString()) / Double.Parse(dt_Emp2.Rows[0][0].ToString());
            sstyle=";font-weight:700";
           
  %>
 <tr class=xl27 height=84 style='mso-height-source:userset;height:63.0pt'>
  <td height=84 class=xl30 width=128 style='height:63.0pt;border-top:none;
  width:96pt<%=sstyle %>' x:num><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td height=84 class=xl30 width=128 style='height:63.0pt;border-top:none;
    width:96pt<%=sstyle %>' x:num><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none<%=sstyle %>' x:num><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                       </span><%=dt_Emp.Rows[i][4].ToString()%> </td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                  </span><%=dt_Emp.Rows[i][5].ToString()%> </td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                       </span><%=dt_Emp.Rows[i][6].ToString()%> </td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                  </span><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>              </span><%=col10 %></td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                   </span><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                           </span><%=col11 %></td>
  <td class=xl41 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                  </span><%=col12 %></td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                  </span><%=col13 %></td>
  
 </tr>
<%
    }
 %>
 <tr class=xl27 height=84 style='mso-height-source:userset;height:63.0pt'>
  <td height=84 class=xl30 width=128 style='height:63.0pt;border-top:none;
  width:96pt<%=sstyle %>' x:num>Total</td>
  <td height=84 class=xl30 width=128 style='height:63.0pt;border-top:none;
    width:96pt<%=sstyle %>' x:num></td>
  <td class=xl29 style='border-top:none;border-left:none<%=sstyle %>' x:num><%=Total[3]%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                       </span><%=Total[4]%> </td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                  </span><%=Total[5]%> </td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                       </span><%=Total[6]%> </td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                  </span><%=Total[7]%></td>
   <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>              </span><%=Total[10]%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                   </span><%=Total[8]%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                           </span><%=Total[10]/Total[3]%></td>
  <td class=xl41 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                  </span><%=Total[11]%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=sstyle %>' x:num><span
  style='mso-spacerun:yes'>                  </span><%=Total[13]%></td>
 
  
 
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 class=xl24 style='height:47.25pt'></td>
  <td colspan=7 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 class=xl24 style='height:47.25pt'></td>
  <td colspan=5 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 colspan=12 class=xl24 style='height:47.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 colspan=12 class=xl24 style='height:47.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 colspan=12 class=xl24 style='height:47.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 colspan=12 class=xl24 style='height:47.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 colspan=12 class=xl24 style='height:47.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 colspan=12 class=xl24 style='height:47.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 colspan=12 class=xl24 style='height:47.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 colspan=12 class=xl24 style='height:47.25pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=128 style='width:96pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=121 style='width:91pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
