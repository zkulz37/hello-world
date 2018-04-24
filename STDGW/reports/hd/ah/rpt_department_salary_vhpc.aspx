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

    string p_to, p_from, p_contract, p_status, p_nation, p_month;


    p_contract = Request["p_contract"].ToString();
    p_status = Request["p_status"].ToString();
    p_nation = Request["p_nation"].ToString();
    p_from = Request["p_from"].ToString();
    p_to = Request["p_to"].ToString();
    p_month = Request["p_month"].ToString();

   string SQL
    = "select (select o.org_nm from comm.tco_org o where o.pk = nvl(c.P_PK,c.pk)) as fac " + 
        ",c.org_nm " +
        ",count(b.pk) " +
        ",min(min.minsal)  " +
        ",round((min(min.minsal) + round(max(a.net_amt),0))/2,0) mid " +
        ",round(max(a.net_amt),0) " +
        ",round(sum(nvl(a.net_amt,0)),0) total1 " +
        ",round(round(sum(nvl(a.net_amt,0)),0)/count(b.pk),0) total2 " +
        ",round(sum(nvl(a.net_amt,0)),0) - round(sum(nvl(a.total_ot_l1_amt,0)) + sum(nvl(a.total_ot_l2_amt,0)),0) total3 " +
        ",round((round(sum(nvl(a.net_amt,0)),0) - round(sum(nvl(a.total_ot_l1_amt,0)) + sum(nvl(a.total_ot_l2_amt,0)),0))/count(b.pk),0) total4 " +
        "from thr_month_salary a, thr_employee b, comm.tco_org c, " +
        "(select s.TCO_DEPT_PK , round(min(nvl(s.net_amt,0)),0) minsal from thr_month_salary s, thr_employee e " +
        "    where s.del_if=0 and e.del_if=0 and s.thr_emp_pk = e.pk " +
		"and (('"+ p_contract +"' = '1' and  e.END_PROBATION > '"+ p_to +"' and e.BEGIN_CONTRACT is null) " +
        "    or('"+ p_contract +"' ='2' and  nvl(e.BEGIN_CONTRACT,'"+ p_from +"') <= '"+ p_from +"')   " +
        "    or '"+ p_contract +"' = 'ALL' ) " +
        "and decode('"+ p_nation +"','ALL', 'ALL',e.nation) ='"+ p_nation +"' " +
        "and decode('"+ p_status +"','ALL', 'ALL',e.status) ='"+ p_status +"' " +
        "    and s.work_mon='"+ p_month +"' and nvl(s.NET_AMT,0)>0 " +
        "    group by s.tco_dept_pk ) min " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
        "and b.tco_org_pk = c.pk " +
        "and a.THR_EMP_PK = b.pk " +
        "and min.tco_dept_pk = b.tco_org_pk " +
        "and a.WORK_MON= '"+ p_month +"' " +
        "and (('"+ p_contract +"' = '1' and  b.END_PROBATION > '"+ p_to +"' and b.BEGIN_CONTRACT is null) " +
        "    or('"+ p_contract +"' ='2' and  nvl(b.BEGIN_CONTRACT,'"+ p_from +"') <= '"+ p_from +"')   " +
        "    or '"+ p_contract +"' = 'ALL' ) " +
        "and decode('"+ p_nation +"','ALL', 'ALL',b.nation) ='"+ p_nation +"' " +
        "and decode('"+ p_status +"','ALL', 'ALL',b.status) ='"+ p_status +"' " +
        "group by c.pk, c.org_nm, c.p_pk " +
        "order by c.P_PK " ;


    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp, icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp = dt_Emp.Columns.Count;
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
<link rel=File-List href="rpt_position_department_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_position_department_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_position_department_vhpc_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>user</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-06-25T06:55:56Z</o:LastPrinted>
  <o:Created>2011-04-29T07:53:22Z</o:Created>
  <o:LastSaved>2011-06-25T06:56:04Z</o:LastSaved>
  <o:Company>Hewlett-Packard Company</o:Company>
  <o:Version>11.5606</o:Version>
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCCCFF;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCCCFF;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCCCFF;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl93
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
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl94
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
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Department</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>74</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11760</x:WindowHeight>
  <x:WindowWidth>19095</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl76>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1238 style='border-collapse:
 collapse;table-layout:fixed;width:926pt'>
 <col class=xl76 width=64 style='width:48pt'>
 <col class=xl76 width=175 style='mso-width-source:userset;mso-width-alt:6400;
 width:131pt'>
 <col class=xl76 width=111 span=9 style='mso-width-source:userset;mso-width-alt:
 4059;width:83pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 colspan=4 width=461 style='height:15.75pt;
  mso-ignore:colspan;width:345pt'>POSCO VIETNAM PROCESSING CENTER CO.,Ltd</td>
  <td class=xl66 width=111 style='width:83pt'></td>
  <td class=xl66 width=111 style='width:83pt'></td>
  <td class=xl66 width=111 style='width:83pt'></td>
  <td class=xl66 width=111 style='width:83pt'></td>
  <td class=xl66 width=111 style='width:83pt'></td>
  <td class=xl66 width=111 style='width:83pt'></td>
  <td class=xl66 width=111 style='width:83pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=56 style='mso-height-source:userset;height:42.0pt'>
  <td colspan=11 height=56 class=xl91 width=1238 style='height:42.0pt;
  width:926pt'>TH&#7888;NG KÊ L&#431;&#416;NG THEO B&#7896; PH&#7852;N
  <%= p_month.Substring(4,2).ToString() %>/<%= p_month.Substring(0,4).ToString() %><br>
    <span style='mso-spacerun:yes'> </span>SUMMARIZE INCOME BY DEPARTMENT
  <%= p_month.Substring(4,2).ToString() %>/<%= p_month.Substring(0,4).ToString() %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=84 style='height:63.0pt'>
  <td height=84 class=xl93 style='height:63.0pt'>No</td>
  <td class=xl93 style='border-left:none'>Department</td>
  <td class=xl94 width=111 style='border-left:none;width:83pt'>Total Employee</td>
  <td class=xl95 width=111 style='border-left:none;width:83pt'>Min Salary</td>
  <td class=xl95 width=111 style='border-left:none;width:83pt'>Mid Point</td>
  <td class=xl95 width=111 style='border-left:none;width:83pt'>Max Salary</td>
  <td class=xl95 width=111 style='border-left:none;width:83pt'>Total Of
  Income<span style='mso-spacerun:yes'>                  </span>(<span
  style='mso-spacerun:yes'>  </span>Have Overtime)</td>
  <td class=xl95 width=111 style='border-left:none;width:83pt'>Average Income
  (Have Ovetime)</td>
  <td class=xl95 width=111 style='border-left:none;width:83pt'>Total Of
  Salary<span style='mso-spacerun:yes'>            </span>(Not Overtime)</td>
  <td class=xl95 width=111 style='border-left:none;width:83pt'>Average Income
  (Not Ovetime)</td>
  <td class=xl95 width=111 style='border-left:none;width:83pt'>Remark</td>
 </tr>
  <%
 
    int i;
    int count=1;
    Boolean flag = true;
    string emp_type_old, emp_type_new;
    
    double[] total = new double[8];
    double[] gtotal = new double[8];
     for (int k=0 ; k<8; k++)
     {
         total[k] =0;
         gtotal[k] =0;
     }   
    for (i = 0; i < irow_emp; i++)
    {

        emp_type_old = dt_Emp.Rows[i][0].ToString();
        
        for(int j=2; j< dt_Emp.Columns.Count; j++)
        {
            total[j-2] += Double.Parse(dt_Emp.Rows[i][j].ToString());
            gtotal[j-2] += Double.Parse(dt_Emp.Rows[i][j].ToString());
        }
        if (flag)
        {
  %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl67 style='height:24.0pt'>I</td>
  <td class=xl68><%= dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none'>&nbsp;</td>
 </tr>
  <%	
           flag = false;
         }
 %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl71 style='height:24.0pt;border-top:none' x:num><%= count %></td>
  <td class=xl72 style='border-top:none;border-left:none' x:str><%= dt_Emp.Rows[i][1].ToString() %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][2].ToString() %> </td>
  <td class=xl78 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= dt_Emp.Rows[i][3].ToString() %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= dt_Emp.Rows[i][4].ToString() %> </td>
  <td class=xl79 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl79 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= dt_Emp.Rows[i][6].ToString() %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= dt_Emp.Rows[i][7].ToString() %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= dt_Emp.Rows[i][8].ToString() %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= dt_Emp.Rows[i][9].ToString() %> </td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
     
     if (i < irow_emp - 1)
     {
         count = count + 1;
         emp_type_new = dt_Emp.Rows[i + 1][0].ToString();
         if (emp_type_new != emp_type_old)
         {
             flag = true;
         }
     }
     else
     {
         flag = true;
     }
     if (flag)
     {
  %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=2 height=32 class=xl81 style='border-right:.5pt solid black;
  height:24.0pt'>TOTAL <%= dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%= total[0] %> </td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= total[4] %> </td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= total[4]/total[0] %> </td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= total[6] %> </td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= total[6]/total[0] %> </td>
  <td class=xl85 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
        for(int k=0; k<8; k++)
        {
            total[k]=0;
        }
    }
   } %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=2 height=32 class=xl86 style='border-right:.5pt solid black;
  height:24.0pt'>GRAND TOTAL</td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><%= gtotal[0] %> </td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%= gtotal[4] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= gtotal[4]/gtotal[0] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= gtotal[6] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%= gtotal[6]/gtotal[0] %> </td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'></td>
  <td class=xl73></td>
  <td colspan=8 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl75 style='height:15.75pt'></td>
  <td colspan=10 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'></td>
  <td class=xl75></td>
  <td colspan=9 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'></td>
  <td class=xl75></td>
  <td class=xl66></td>
  <td colspan=8 class=xl76 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'></td>
  <td class=xl75></td>
  <td class=xl66></td>
  <td colspan=8 class=xl76 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=175 style='width:131pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=111 style='width:83pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
