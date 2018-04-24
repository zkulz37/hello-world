<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>f
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_company,p_work_mon,p_cost_center,p_cost_group,p_cost_type,p_dept;
    
    p_company = Request["p_1"].ToString();
    p_work_mon = Request["p_2"].ToString();
    p_cost_center = Request["p_3"].ToString();
    p_cost_group = Request["p_4"].ToString();
    p_cost_type = Request["p_5"].ToString();
    p_dept = Request["p_6"].ToString();
    
    string SQL
	= "SELECT TO_CHAR(TO_DATE(B.WORK_MON,'YYYYMM'),'MM/YYYY'),A.FULL_NAME,C.ORG_NM,A.EMP_ID,D.PL_CD||' - '||D.PL_NM " +
        ",ROUND(NVL(B.S01,0),10) AS SALARY,ROUND(NVL(B.S02,0),10) AS ANNUAL,ROUND(NVL(B.S06,0),10) AS OVERTIME " +
        ",ROUND(NVL(B.S07,0),10) AS NIGHT_ALLOWANCE,ROUND(NVL(B.S08,0),10) AS ALLOWANCE " +
        ",ROUND(NVL(B.S09,0),10) AS INCENTIVE,ROUND(NVL(B.S10,0),10) AS SER_VER " +
        ",ROUND(NVL(B.S11,0)+NVL(B.S25,0),10) AS OTHER_RETURN,ROUND(NVL(B.S12,0),10) AS SOCIAL " +
        ",ROUND(NVL(B.S13,0),10) AS HEALTH,ROUND(NVL(B.S14,0),10) AS UNEMP_INS,ROUND(NVL(B.S15,0),10) AS PIT " +
        ",ROUND(NVL(B.S16,0),10) AS SOCIAL_15,ROUND(NVL(B.S17,0),10) AS HEALTH_2 " +
        ",ROUND(NVL(B.S18,0),10) AS UN_EMP_CO,ROUND(NVL(B.S19,0),10) AS HEALTH_CARD,ROUND(NVL(B.S20,0)+NVL(B.S22,0)+NVL(B.S23,0)+NVL(B.S24,0),10) AS DEDUCT " +
        ",ROUND(NVL(B.S01,0)+NVL(B.S02,0)+NVL(B.S06,0)+NVL(B.S07,0) " +
        "+NVL(B.S08,0)+NVL(B.S09,0)+NVL(B.S10,0)+NVL(B.S11,0) " +
        "-NVL(B.S12,0)-NVL(B.S13,0)-NVL(B.S14,0)-NVL(B.S15,0)-NVL(B.S19,0)-NVL(B.S20,0)-NVL(B.S22,0)-NVL(B.S23,0)-NVL(B.S24,0)+NVL(B.S25,0),10) AS AMT " +
        ",0 " +
        "FROM THR_EMPLOYEE A,VHR_SAL_CUSTOM B,COMM.TCO_ORG C,ACNT.TAC_ABPL D " +
        "WHERE A.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0  " +
        "AND A.PK=B.THR_EMP_PK AND B.TCO_DEPT_PK=C.PK AND B.TAC_ABPL_PK=D.PK " +
        "AND B.WORK_MON = '" + p_work_mon + "' " +
        "AND C.TCO_COMPANY_PK = DECODE('" + p_company + "','ALL', C.TCO_COMPANY_PK, '" + p_company + "') " +
        "AND (A.TCO_ORG_PK IN ( " +
        "                  SELECT     G.PK " +
        "                        FROM COMM.TCO_ORG G " +
        "                       WHERE G.DEL_IF = 0 " +
        "                  START WITH G.PK = " +
        "                                DECODE ('" + p_dept + "', " +
        "                                        'ALL', 0, " +
        "                                        '" + p_dept + "' " +
        "                                       ) " +
        "                  CONNECT BY PRIOR G.PK = G.P_PK) " +
        "            OR '" + p_dept + "' = 'ALL' " +
        "    ) " +
 //       "AND B.COST_GROUP = DECODE('" + p_cost_group + "','ALL', B.COST_GROUP, '" + p_cost_group + "') " +
  //      "AND B.COST_KIND = DECODE('" + p_cost_type + "','ALL', B.COST_KIND, '" + p_cost_type + "') " +
        "AND B.TAC_ABPL_PK = DECODE('" + p_cost_center + "','ALL', B.TAC_ABPL_PK, '" + p_cost_center + "') " +
        "ORDER BY C.ORG_NM,A.EMP_ID " ;

    //Response.Write(SQL);
    //Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow, icol_emp;
    irow = dt_total.Rows.Count;
    icol_emp = dt_total.Columns.Count;
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
<link rel=File-List href="rpt_payroll_make_slip_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_payroll_make_slip_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_payroll_make_slip_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>htruong</o:Author>
  <o:LastAuthor>htruong</o:LastAuthor>
  <o:Created>2009-09-15T02:07:35Z</o:Created>
  <o:LastSaved>2009-09-15T04:14:09Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:22.0pt;
	text-align:center;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:13.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
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
  <x:WindowHeight>9855</x:WindowHeight>
  <x:WindowWidth>19020</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2552 style='border-collapse:
 collapse;table-layout:fixed;width:1918pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <col class=xl25 width=132 style='mso-width-source:userset;mso-width-alt:6827;
 width:99pt'>
 <col class=xl25 width=164 style='mso-width-source:userset;mso-width-alt:5997;
 width:123pt'>
 <col class=xl25 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl25 width=258 style='mso-width-source:userset;mso-width-alt:9435;
 width:194pt'>
 <col class=xl25 width=82 span=3 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <col class=xl25 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl25 width=82 span=2 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <col class=xl25 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl25 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl25 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl25 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl25 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl25 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl25 width=111 style='mso-width-source:userset;mso-width-alt:4059;
 width:83pt'>
 <col class=xl25 width=129 style='mso-width-source:userset;mso-width-alt:4717;
 width:97pt'>
 <col class=xl25 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl25 width=95 span=2 style='mso-width-source:userset;mso-width-alt:
 3474;width:71pt'>
 <col class=xl25 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl25 width=106 style='mso-width-source:userset;mso-width-alt:3876;
 width:80pt'>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=24 height=39 class=xl27 width=2552 style='height:29.25pt;
  width:1918pt' x:str="PAYROLL MAKE SLIP ">PAYROLL MAKE SLIP<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=24 height=39 class=xl28 style='height:29.25pt'>MONTH: <%=dt_total.Rows[0][0].ToString()%></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=4 height=39 class=xl24 style='height:29.25pt'>&nbsp;</td>
  <td colspan=20 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=78 style='mso-height-source:userset;height:58.5pt'>
  <td height=78 class=xl26 style='height:58.5pt;border-top:none'>No</td>
  <td class=xl26 style='border-top:none;border-left:none'>Name</td>
  <td class=xl26 style='border-top:none;border-left:none'>Dept</td>
  <td class=xl26 style='border-top:none;border-left:none'>Emp. No</td>
  <td class=xl26 style='border-left:none'>Cost center</td>
  <td class=xl26 style='border-left:none' x:str="Salary ">Salary<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl26 style='border-left:none'>Annual leave</td>
  <td class=xl26 style='border-left:none'>Overtime</td>
  <td class=xl26 style='border-left:none'>Night shift amount</td>
  <td class=xl26 style='border-left:none'>Allowance</td>
  <td class=xl26 style='border-left:none'>Incentive</td>
  <td class=xl26 style='border-left:none'>Serverance pay</td>
  <td class=xl26 style='border-left:none'>Other ( return)</td>
  <td class=xl32 width=104 style='border-left:none;width:78pt'>Social
  Insurance<br>
    <span style='mso-spacerun:yes'> </span>( 5%)</td>
  <td class=xl32 width=105 style='border-left:none;width:79pt'>Health
  Insurance<br>
    <span style='mso-spacerun:yes'> </span>(1%)</td>
  <td class=xl32 width=95 style='border-left:none;width:71pt'>Unemployment
  <br>
    Insurance (1%)</td>
  <td class=xl26 style='border-left:none'>PIT</td>
  <td class=xl32 width=111 style='border-left:none;width:83pt'>Social Ins
  15%<br>
    <span style='mso-spacerun:yes'> </span>( Company pays)</td>
  <td class=xl32 width=129 style='border-left:none;width:97pt'>Health Ins<br>
    <span style='mso-spacerun:yes'> </span>2%( company pays)</td>
  <td class=xl32 width=131 style='border-left:none;width:98pt'>Unemployment
  Ins<br>
    <span style='mso-spacerun:yes'> </span>1%( Company pays)</td>
  <td class=xl26 style='border-left:none'>Health Card</td>
  <td class=xl26 style='border-left:none'>Deduct others</td>
  <td class=xl26 style='border-left:none' x:str="Trans Amount ">Trans
  Amount<span style='mso-spacerun:yes'> </span></td>
  <td class=xl26 style='border-left:none'>Books amount</td>
 </tr>
 <% 
     double[] Total = new double[icol_emp];
     string s_format;
     for (int j = 0; j < icol_emp; j++)
     {
         Total[j] = 0;
     }
     
     for (int i = 0; i < irow; i++) 
    {
        for (int j = 5; j < icol_emp; j++)
        {
            Total[j - 5] += Double.Parse(dt_total.Rows[i][j].ToString());
        }
    %> 
 <tr class=xl31 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl29 style='height:28.5pt;border-top:none' x:num><%=i+1%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_total.Rows[i][1].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_total.Rows[i][2].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][3].ToString()%></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dt_total.Rows[i][4].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][5].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][6].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][7].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][8].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][9].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][10].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][11].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][12].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][13].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][14].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][15].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][16].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][17].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][18].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][19].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][20].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][21].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][22].ToString()%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[i][23].ToString()%></td>
 </tr>
 <%
    }
  %>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=5 height=38 class=xl33 style='border-right:.5pt solid black;
  height:28.5pt'>Total</td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[0]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[1]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[2]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[3]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[4]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[5]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[6]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[7]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[8]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[9]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[10]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[11]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[12]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[13]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[14]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[15]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[16]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[17]%></td>
  <td class=xl30 style='border-top:none;border-left:none' x:num><%=Total[18]%></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 colspan=24 class=xl25 style='height:28.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 colspan=24 class=xl25 style='height:28.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=164 style='width:123pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=258 style='width:194pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=106 style='width:80pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
