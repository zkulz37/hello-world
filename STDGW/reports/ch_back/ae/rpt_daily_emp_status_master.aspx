<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_date = Request.QueryString["p_date"].ToString();
    string SQL
    = "select fact, dept_nm, " +
        "    sum(yesterday), sum(today_male),sum(today_female), sum(today) " +
        "    ,sum(abs_male), sum(abs_female), sum(abs_total) " +
        "    ,ot_emp_yesterday,ot_hours_yesterday " +
        "    ,sum(att_male), sum(att_female), sum(att_total),d,dd " +
        "from " +
        "(SELECT   (SELECT d.dept_nm " +
        "            FROM tco_dept d " +
        "           WHERE d.del_if = 0 " +
        "             AND d.pk = (SELECT t.p_pk " +
        "                           FROM tco_dept t " +
        "                          WHERE t.del_if = 0 AND t.pk = a.pk)) AS fact, " +
        "         a.dept_nm, " +
        "         NVL (b.yesterday_male, 0) + NVL (b.yesterday_female, 0) AS yesterday, " +
        "         NVL (b.today_male, 0) as today_male, NVL (b.today_female, 0) as today_female, " +
        "         NVL (b.today_female, 0) + NVL (b.today_male, 0) AS today, " +
        "           NVL (b.abs_ale_male, 0) " +
        "         + NVL (b.abs_mle_male, 0) " +
        "         + NVL (b.abs_non_male, 0) " +
        "         + NVL (b.abs_per_male, 0) AS abs_male, " +
        "           NVL (b.abs_ale_female, 0) " +
        "         + NVL (b.abs_mle_female, 0) " +
        "         + NVL (b.abs_non_female, 0) " +
        "         + NVL (b.abs_per_female, 0) AS abs_female, " +
        "           NVL (b.abs_ale, 0) " +
        "         + NVL (b.abs_mle, 0) " +
        "         + NVL (b.abs_non, 0) " +
        "         + NVL (b.abs_per, 0) AS abs_total, " +
        "         NVL ((SELECT   SUM (NVL (c.ot_emp, 0)) " +
        "                   FROM thr_employee_daily c " +
        "                  WHERE c.del_if = 0 " +
        "                    AND c.tco_dept_pk = b.tco_dept_pk " +
        "                    AND c.daily_date = " +
        "                           TO_CHAR (TO_DATE ('" + p_date + "', 'yyyymmdd') - 1, " +
        "                                    'yyyymmdd' " +
        "                                   ) " +
        "               GROUP BY c.tco_dept_pk), " +
        "              0 " +
        "             ) AS ot_emp_yesterday, " +
        "         NVL ((SELECT   SUM (NVL (c.ot_hours, 0)) " +
        "                   FROM thr_employee_daily c " +
        "                  WHERE c.del_if = 0 " +
        "                    AND c.tco_dept_pk = b.tco_dept_pk " +
        "                    AND c.daily_date = " +
        "                           TO_CHAR (TO_DATE ('" + p_date + "', 'yyyymmdd') - 1, " +
        "                                    'yyyymmdd' " +
        "                                   ) " +
        "               GROUP BY c.tco_dept_pk), " +
        "              0 " +
        "             ) AS ot_hours_yesterday, " +
        "         NVL (b.attendence_male, 0) as att_male, NVL (b.attendence_female, 0) as att_female, " +
        "           NVL (b.attendence_female, 0) " +
        "         + NVL (b.attendence_male, 0) AS att_total, " +
        "         TO_CHAR (TO_DATE ('" + p_date + "', 'yyyymmdd'), 'Dy-DD-Mon-YYYY') as d, " +
        "         TO_CHAR (TO_DATE ('" + p_date + "', 'yyyymmdd')-1, 'DD Mon') as dd " +
        "    FROM tco_dept a, thr_employee_daily b " +
        "   WHERE a.del_if = 0 " +
        "     AND b.del_if = 0 " +
        "     AND a.pk = b.tco_dept_pk " +
        "     AND b.daily_date = '" + p_date + "' " +
        ") " +
        "group by fact,dept_nm,d,dd,ot_emp_yesterday,ot_hours_yesterday " +
        "order by 1,2 ";
            
    //Response.Write(SQL);
    //Response.End();

    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_daily_emp_status_master_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_daily_emp_status_master_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_daily_emp_status_master_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Namyang-songmay</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:LastPrinted>2009-05-11T07:19:38Z</o:LastPrinted>
  <o:Created>2009-04-24T03:24:46Z</o:Created>
  <o:LastSaved>2009-05-11T07:21:35Z</o:LastSaved>
  <o:Company>Namyang-songmay</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.35in .25in .32in .24in;
	mso-header-margin:.31in;
	mso-footer-margin:.27in;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:1.0pt solid windowtext;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid black;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
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
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
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
  <x:WindowHeight>5775</x:WindowHeight>
  <x:WindowWidth>7500</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1056 style='border-collapse:
 collapse;table-layout:fixed;width:792pt'>
 <col class=xl24 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col class=xl24 width=147 style='mso-width-source:userset;mso-width-alt:5376;
 width:110pt'>
 <col class=xl24 width=64 span=14 style='width:48pt'>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl24 width=13 style='height:18.0pt;width:10pt'></td>
  <td class=xl24 width=147 style='width:110pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td colspan=8 class=xl29 width=512 style='width:384pt'>DAILY MANPOWER REPORT</td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=3 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=8 class=xl30><%=dt.Rows[0][14].ToString() %></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=3 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td rowspan=2 class=xl40 style='border-bottom:1.0pt solid black'>Description</td>
  <td colspan=4 class=xl41 style='border-right:1.0pt solid black;border-left:
  none'>Total of Current Employees</td>
  <td colspan=3 class=xl44 style='border-right:1.0pt solid black;border-left:
  none'>Absent</td>
  <td colspan=2 class=xl44 style='border-right:1.0pt solid black;border-left:
  none'>O/T <%=dt.Rows[0][15].ToString() %></td>
  <td colspan=3 class=xl44 style='border-right:1.0pt solid black;border-left:
  none'>Attendance</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td class=xl47><%=dt.Rows[0][15].ToString() %></td>
  <td class=xl47>Male</td>
  <td class=xl47>Female</td>
  <td class=xl47>TTL</td>
  <td class=xl47>Male</td>
  <td class=xl47>Female</td>
  <td class=xl47>TTL</td>
  <td class=xl47>People</td>
  <td class=xl47>Hours</td>
  <td class=xl47>Male</td>
  <td class=xl47>Female</td>
  <td class=xl47>TTL</td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <%
     double[] sum = new double[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    double[] grand = new double[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
    for(int i=0;i<dt.Rows.Count;i++)
    {
        for (int l = 0; l < 12; l++)
        {
            sum[l] += double.Parse(dt.Rows[i][l + 2].ToString());
            grand[l] += double.Parse(dt.Rows[i][l + 2].ToString());
        }                        
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'></td>
  <td class=xl28 x:num ><%=dt.Rows[i][1].ToString() %></td>
  <td class=xl34 x:num ><%=dt.Rows[i][2].ToString() %></td>
  <td class=xl31 x:num ><%=dt.Rows[i][3].ToString() %></td>
  <td class=xl31 x:num ><%=dt.Rows[i][4].ToString() %></td>
  <td class=xl32 x:num ><%=dt.Rows[i][5].ToString() %></td>
  <td class=xl31 x:num ><%=dt.Rows[i][6].ToString() %></td>
  <td class=xl31 x:num ><%=dt.Rows[i][7].ToString() %></td>
  <td class=xl32 x:num ><%=dt.Rows[i][8].ToString() %></td>
  <td class=xl31 x:num ><%=dt.Rows[i][9].ToString() %></td>
  <td class=xl31 x:num ><%=dt.Rows[i][10].ToString() %></td>
  <td class=xl31 x:num ><%=dt.Rows[i][11].ToString() %></td>
  <td class=xl31 x:num ><%=dt.Rows[i][12].ToString() %></td>
  <td class=xl33 x:num ><%=dt.Rows[i][13].ToString() %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
     if (i < dt.Rows.Count - 1)
     {
         if (dt.Rows[i][0].ToString() != dt.Rows[i + 1][0].ToString())
         {
  %>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td class=xl37><%=dt.Rows[i][0].ToString()%></td>
  <td class=xl38 x:num><%=sum[0] %></td>
  <td class=xl38 x:num><%=sum[1] %></td>
  <td class=xl38 x:num><%=sum[2] %></td>
  <td class=xl38 x:num><%=sum[3] %></td>
  <td class=xl38 x:num><%=sum[4] %></td>
  <td class=xl38 x:num><%=sum[5] %></td>
  <td class=xl38 x:num><%=sum[6] %></td>
  <td class=xl38 x:num><%=sum[7] %></td>
  <td class=xl38 x:num><%=sum[8] %></td>
  <td class=xl38 x:num><%=sum[9] %></td>
  <td class=xl38 x:num><%=sum[10] %></td>
  <td class=xl39 x:num><%=sum[11] %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td> 
 </tr> <!-- -->
 
 <%
            for (int l = 0; l < 12; l++)
                sum[l] = 0;
        }
     }
     else
     {
             %>
             
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td class=xl37><%=dt.Rows[i][0].ToString()%></td>
  <td class=xl38 x:num><%=sum[0] %></td>
  <td class=xl38 x:num><%=sum[1] %></td>
  <td class=xl38 x:num><%=sum[2] %></td>
  <td class=xl38 x:num><%=sum[3] %></td>
  <td class=xl38 x:num><%=sum[4] %></td>
  <td class=xl38 x:num><%=sum[5] %></td>
  <td class=xl38 x:num><%=sum[6] %></td>
  <td class=xl38 x:num><%=sum[7] %></td>
  <td class=xl38 x:num><%=sum[8] %></td>
  <td class=xl38 x:num><%=sum[9] %></td>
  <td class=xl38 x:num><%=sum[10] %></td>
  <td class=xl39 x:num><%=sum[11] %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td> 
 </tr> <!-- -->           
             <%
         for (int l = 0; l < 12; l++)
             sum[l] = 0;
     }                                
        }
      %>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl24 style='height:22.5pt'></td>
  <td class=xl35 style='border-top:none'>GRAND TOTAL</td>
  <td class=xl36 x:num ><%=grand[0] %></td>
  <td class=xl36 x:num ><%=grand[1] %></td>
  <td class=xl36 x:num ><%=grand[2] %></td>
  <td class=xl36 x:num ><%=grand[3] %></td>
  <td class=xl36 x:num ><%=grand[4] %></td>
  <td class=xl36 x:num ><%=grand[5] %></td>
  <td class=xl36 x:num ><%=grand[6] %></td>
  <td class=xl36 x:num ><%=grand[7] %></td>
  <td class=xl36 x:num ><%=grand[8] %></td>
  <td class=xl36 x:num ><%=grand[9] %></td>
  <td class=xl36 x:num ><%=grand[10] %></td>
  <td class=xl36 x:num ><%=grand[11] %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
