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
    = "select 1 " + 
        ",(select v.code_nm from vhr_hr_code v where v.id='HR0008' and v.code = b.POS_TYPE) position_nm " +
        ",count(b.pk) " +
        ",min(min.minsal)  " +
        ",round((min(min.minsal) + round(max(a.net_amt),0))/2,0) mid " +
        ",round(max(a.net_amt),0) " +
        ",round(sum(nvl(a.net_amt,0)),0) total1 " +
        ",round(round(sum(nvl(a.net_amt,0)),0)/count(b.pk),0) total2 " +
        ",round(sum(nvl(a.net_amt,0)),0) - round(sum(nvl(a.total_ot_l1_amt,0)) + sum(nvl(a.total_ot_l2_amt,0)),0) total3 " +
        ",round((round(sum(nvl(a.net_amt,0)),0) - round(sum(nvl(a.total_ot_l1_amt,0)) + sum(nvl(a.total_ot_l2_amt,0)),0))/count(b.pk),0) total4 " +
        "from thr_month_salary a, thr_employee b, " +
        "(select s.POS_TYPE, round(min(nvl(s.net_amt,0)),0) minsal from thr_month_salary s , thr_employee e " +
		"	where s.del_if=0 and e.del_if=0 and S.THR_EMP_PK = e.pk  " + 
		"	and (('"+ p_contract +"' = '1' and  e.END_PROBATION > '"+ p_to +"' and e.BEGIN_CONTRACT is null) " +
		"	or('"+ p_contract +"' ='2' and  nvl(e.BEGIN_CONTRACT,'"+ p_from +"') <= '"+ p_from +"')   " +
		"   or '"+ p_contract +"' = 'ALL' ) " +
		"  and decode('"+ p_nation +"','ALL', 'ALL',e.nation) ='"+ p_nation +"' " +
		"   and decode('"+ p_status +"','ALL', 'ALL',e.status) ='"+ p_status +"' " +
		"   and s.work_mon='201109' and nvl(s.NET_AMT,0)>0 " +
		"   group by s.POS_TYPE ) min " +
        "where a.del_if=0 and b.del_if=0 " +
        "and a.THR_EMP_PK = b.pk " +
        "and min.pos_type = b.pos_type " +
        "and a.WORK_MON= '"+ p_month +"' " +
        "and (('"+ p_contract +"' = '1' and  b.END_PROBATION > '"+ p_to +"' and b.BEGIN_CONTRACT is null) " +
        "    or('"+ p_contract +"' ='2' and  nvl(b.BEGIN_CONTRACT,'"+ p_from +"') <= '"+ p_from +"')   " +
        "    or '"+ p_contract +"' = 'ALL' ) " +
        "and decode('"+ p_nation +"','ALL', 'ALL',b.nation) ='"+ p_nation +"' " +
        "and decode('"+ p_status +"','ALL', 'ALL',b.status) ='"+ p_status +"' " +
        "group by b.POS_TYPE " +
        "order by 2 " ;



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
<link rel=File-List href="rpt_position_salary_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_position_salary_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_position_salary_vhpc_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>user</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-06-25T03:47:47Z</o:LastPrinted>
  <o:Created>2011-04-29T07:53:22Z</o:Created>
  <o:LastSaved>2011-06-25T03:49:34Z</o:LastSaved>
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
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl78
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
.xl79
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
.xl80
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
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
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
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl83
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
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl87
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
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Position</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>77</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1182 style='border-collapse:
 collapse;table-layout:fixed;width:884pt'>
 <col width=64 style='width:48pt'>
 <col width=227 style='mso-width-source:userset;mso-width-alt:8301;width:170pt'>
 <col width=99 span=9 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 colspan=3 width=390 style='height:15.75pt;
  mso-ignore:colspan;width:292pt'>POSCO VIETNAM PROCESSING CENTER CO.,Ltd</td>
  <td class=xl66 width=99 style='width:74pt'></td>
  <td class=xl66 width=99 style='width:74pt'></td>
  <td class=xl66 width=99 style='width:74pt'></td>
  <td class=xl66 width=99 style='width:74pt'></td>
  <td class=xl66 width=99 style='width:74pt'></td>
  <td class=xl66 width=99 style='width:74pt'></td>
  <td class=xl66 width=99 style='width:74pt'></td>
  <td class=xl66 width=99 style='width:74pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=65 style='mso-height-source:userset;height:48.75pt'>
  <td colspan=11 height=65 class=xl76 width=1182 style='height:48.75pt;
  width:884pt'>TH&#7888;NG<span style='mso-spacerun:yes'>  </span>KÊ
  L&#431;&#416;NG THEO CH&#7912;C V&#7908; <%= p_month.Substring(4,2).ToString() %>/<%= p_month.Substring(0,4).ToString() %> <br>
    SUMMARIZE INCOME POSITION IN <%= p_month.Substring(4,2).ToString() %>/<%= p_month.Substring(0,4).ToString() %></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=11 class=xl66 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=84 style='height:63.0pt'>
  <td height=84 class=xl78 style='height:63.0pt'>No</td>
  <td class=xl78 style='border-left:none'>POSITION</td>
  <td class=xl79 width=99 style='border-left:none;width:74pt'>Total Employee</td>
  <td class=xl80 width=99 style='border-left:none;width:74pt' x:str="Min ">Min<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl80 width=99 style='border-left:none;width:74pt'>Mid point</td>
  <td class=xl80 width=99 style='border-left:none;width:74pt' x:str="Max ">Max<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl80 width=99 style='border-left:none;width:74pt'>Total Of
  Income<span style='mso-spacerun:yes'>                  </span>(<span
  style='mso-spacerun:yes'>  </span>Have Overtime)</td>
  <td class=xl80 width=99 style='border-left:none;width:74pt'>Average Income
  (Have Ovetime)</td>
  <td class=xl80 width=99 style='border-left:none;width:74pt'>Total Of Income
  (Not Overtime)</td>
  <td class=xl80 width=99 style='border-left:none;width:74pt'>Average Income
  (Not Ovetime)</td>
  <td class=xl80 width=99 style='border-left:none;width:74pt'>Remark</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl67 style='height:15.75pt'>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
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
     double[] total = new double[8];
     for (int k=0 ; k<8; k++)
         total[k] =0;
	int count=0;
    for (int i = 0; i < irow_emp; i++)
    {
		count++;
        for(int j=2; j< dt_Emp.Columns.Count; j++)
            total[j-2] += Double.Parse(dt_Emp.Rows[i][j].ToString());
  %>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl71 style='height:27.0pt;border-top:none' x:num><%= count %></td>
  <td class=xl72 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%= dt_Emp.Rows[i][2].ToString()%> </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][3].ToString()%> </td>
  <td class=xl86 style='border-top:none;border-left:none' x:num>
  <span style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][4].ToString()%> </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][5].ToString()%> </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][6].ToString()%> </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][7].ToString()%> </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][8].ToString()%> </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][9].ToString()%> </td>
  <td class=xl71 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%} %>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=2 height=36 class=xl81 style='border-right:.5pt solid black;
  height:27.0pt'>Total</td>
  <td class=xl87 style='border-top:none;border-left:none' x:num>
  <span style='mso-spacerun:yes'>                   
  </span><%= total[0] %> </td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= total[4] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= total[4]/total[0] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= total[6] %> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= total[6]/total[0] %> </td>
  <td class=xl83 style='border-top:none;border-left:none'>&nbsp;</td>
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
  <td colspan=9 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=227 style='width:170pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
