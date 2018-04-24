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
    string p_company, p_work_mon, p_cost_center, p_cost_group, p_cost_type, p_dept, p_apkind;
    
    p_company = Request["p_1"].ToString();
    p_work_mon = Request["p_2"].ToString();
    p_cost_center = Request["p_3"].ToString();
    p_cost_group = Request["p_4"].ToString();
    p_cost_type = Request["p_5"].ToString();
    p_apkind = Request["p_6"].ToString();


    string SQL
    = "select (select v.code_nm from hr.vhr_hr_code v where v.id='HR0092' and v.code=a.GRP_COST) as grp_cost  " +
        "        ,(select v.code_nm from hr.vhr_hr_code v where v.id='HR0093' and v.code=a.type_COST) as type_cost " +
        "        ,b.PL_NM||' - '||d.plc_nm " +
        "        ,e.emp_id,f.org_nm,round(nvl(a.NET_TRAMT,0),10) " +
        "        , TO_CHAR(TO_DATE(A.STD_YM,'YYYYMM'),'MM/YYYY')  " +
        "        from TAC_PMSAL_EMP a,TAC_ABPL b, TAC_ABPLCENTER c,TAC_ABCENTER d,hr.thr_employee e,comm.tco_org f  " +
        "        where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if=0 and e.del_if=0 and f.del_if=0 " +
        "        and c.TAC_ABPL_PK=b.pk and c.TAC_ABCENTER_PK=d.pk and a.vhr_emp_pk=e.pk and e.tco_org_pk=f.pk " +
        "        and a.TAC_ABPL_PK=c.pk  " +
       "        and a.tco_company_pk='" + p_company + "' " +
        "            AND A.AP_TYPE='" + p_apkind + "' " +
        "         AND A.STD_YM = '" + p_work_mon + "' " +
        "            AND A.GRP_COST = DECODE('" + p_cost_group + "','ALL', A.GRP_COST, '" + p_cost_group + "') " +
        "            AND A.TYPE_COST = DECODE('" + p_cost_type + "','ALL', A.TYPE_COST, '" + p_cost_type + "') " +
        "            AND A.TAC_ABPL_PK = DECODE('" + p_cost_center + "','ALL', A.TAC_ABPL_PK, '" + p_cost_center + "') " +
        "        order by a.GRP_COST,a.TYPE_COST,f.org_nm,e.emp_id ";
	

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
<link rel=File-List href="Copy%20of%20rpt_slip_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="Copy%20of%20rpt_slip_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="Copy%20of%20rpt_slip_summary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>htruong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:Created>2009-09-15T02:07:35Z</o:Created>
  <o:LastSaved>2010-06-18T02:37:30Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:13.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:26.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:22.0pt;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:20.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:left;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:13.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
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
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1173 style='border-collapse:
 collapse;table-layout:fixed;width:880pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=187 style='mso-width-source:userset;mso-width-alt:6838;
 width:140pt'>
 <col class=xl24 width=164 style='mso-width-source:userset;mso-width-alt:5997;
 width:123pt'>
 <col class=xl24 width=547 style='mso-width-source:userset;mso-width-alt:20004;
 width:410pt'>
 <col class=xl24 width=547 style='mso-width-source:userset;mso-width-alt:3000;
 width:410pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:15000;
 width:62pt'>
 <col class=xl24 width=129 style='mso-width-source:userset;mso-width-alt:4717;
 width:97pt'>
 <col class=xl24 width=78 span=18 style='mso-width-source:userset;mso-width-alt:
 2852;width:59pt'>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=5 height=39 class=xl32 width=1044 style='height:29.25pt;
  width:783pt' x:str="PAYROLL MAKE SLIP ">PAYROLL MAKE SLIP<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24 width=129 style='width:97pt'></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=5 height=39 class=xl33 style='height:29.25pt'>MONTH:<%=dt_total.Rows[0][6].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=4 height=39 class=xl34 style='height:29.25pt'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=78 style='mso-height-source:userset;height:58.5pt'>
  <td height=78 class=xl25 style='height:58.5pt'>No</td>
  <td class=xl26>Cost Group</td>
  <td class=xl26>Cost Type</td>
  <td class=xl26>Item</td>
  <td class=xl27>Emp ID</td>
  <td class=xl27>Organization</td>
  <td class=xl27>Trans Amt</td>
 </tr>
 <% 
     double[] Total = new double[2];
     string s_format;
     for (int j = 0; j < 1; j++)
     {
         Total[j] = 0;
     }
     
     for (int i = 0; i < irow; i++) 
    {
        Total[0] += Double.Parse(dt_total.Rows[i][5].ToString());
        
        
    %>
 <tr class=xl38 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl28 style='height:28.5pt' x:num><%=i+1%></td>
  <td class=xl29><%=dt_total.Rows[i][0].ToString()%></td>
  <td class=xl29><%=dt_total.Rows[i][1].ToString()%></td>
  <td class=xl30><%=dt_total.Rows[i][2].ToString()%></td>
  <td class=xl30><%=dt_total.Rows[i][3].ToString()%></td>
  <td class=xl39><%=dt_total.Rows[i][4].ToString()%></td>
  <td class=xl41 x:num><%=dt_total.Rows[i][5].ToString()%></td>
 </tr>
 <%
    }
  %>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=6 height=38 class=xl35 style='border-right:.5pt solid black;
  height:28.5pt'>Total</td>
  <td class=xl31 x:num><%=Total[0]%></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 colspan=6 class=xl24 style='height:28.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 colspan=6 class=xl24 style='height:28.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=164 style='width:123pt'></td>
  <td width=547 style='width:410pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=129 style='width:97pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
