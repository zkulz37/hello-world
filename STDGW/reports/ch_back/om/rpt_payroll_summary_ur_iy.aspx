<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string p_dept,p_group,p_status,p_type,p_pay_type,p_emp_id,p_work_mon,p_times;
     
  
    p_dept       = Request["l_dept"].ToString();
    p_group      = Request["l_group"].ToString();
    p_status      = Request["l_status"].ToString();
    p_type       = Request["l_type"].ToString();
    p_pay_type   = Request["l_pay_type"].ToString();
    p_emp_id     = Request["l_emp_id"].ToString();
    p_work_mon   = Request["l_work_mon"].ToString();
    p_times = Request["l_Times_r"].ToString();
    string p_m_type = Request.QueryString["l_m_type"].ToString();
	
	
	
	string SQL
	= "select max(a.DEPT_NM),count(*) " + 
        "    ,round(sum(nvl( a.WT_L1_AMT,0)+nvl( a.WT_L2_AMT,0) " +
        "        +nvl( a.HOL_DAY_L1_AMT,0)+nvl( a.HOL_DAY_L2_AMT,0)),3) wt " +
        "    ,round(sum(nvl( a.TOTAL_OT_L1_AMT,0)+nvl( a.TOTAL_OT_L2_AMT,0) " +
        "        -nvl( a.NT_30_L1_AMT,0)-nvl( a.NT_30_L2_AMT,0) " +
        "        -nvl( a.NT_45_L1_AMT,0)-nvl( a.NT_45_L2_AMT,0) " +
        "        -nvl( a.NT_60_L1_AMT,0)-nvl( a.NT_60_L2_AMT,0)),3) ot " +
        "    ,round(sum( nvl( a.NT_30_L1_AMT,0)+nvl( a.NT_30_L2_AMT,0) " +
        "        +nvl( a.NT_45_L1_AMT,0)+nvl( a.NT_45_L2_AMT,0) " +
        "        +nvl( a.NT_60_L1_AMT,0)+nvl( a.NT_60_L2_AMT,0) ) ,3) nt " +
        "    ,round(sum(nvl(a.ABS_POWER_LOST_L1_AMT,0)+nvl( a.ABS_POWER_LOST_L2_AMT,0) " +
        "        +nvl(a.ABS_TEMP_REST_L1_AMT,0)+nvl( a.ABS_TEMP_REST_L2_AMT,0)),3) abs_70  " +
        "    ,round(sum(nvl(a.TOTAL_ABS_PAY_L1_AMT,0)+nvl( a.TOTAL_ABS_PAY_L2_AMT,0)   " +
        "        -nvl(a.ABS_POWER_LOST_L1_AMT,0)-nvl( a.ABS_POWER_LOST_L2_AMT,0) " +
        "        -nvl(a.ABS_TEMP_REST_L1_AMT,0)-nvl( a.ABS_TEMP_REST_L2_AMT,0) ),3) abs_100   " +
        "    ,round(sum(nvl(a.ALLOW_K2_AMT,0)),3) house_renting " +
        "    ,round(sum(nvl(a.ALLOW_K3_AMT,0)),3) trans " +
        "    ,round(sum(nvl(a.ALLOW_K1_AMT,0)),3) indus " +
        "    ,round(sum(nvl(a.ALLOW_AMT1,0)),3)   toxic " +
        "    ,round(sum(nvl(a.ALLOW_AMT2,0)),3)   ability " +
        "    ,round(sum(nvl(a.ALLOW_AMT3,0)),3)   res " +
        "    ,round(sum(nvl(a.ALLOW_AMT4,0)),3)   manager  " +
        "    ,round(sum(nvl(a.ALLOW_K4_AMT,0)),3) senior " +
        "    ,round(sum(nvl(a.ALLOW_K5_AMT,0)),3) children " +
        "    ,round(sum(nvl(a.ALLOW_AMT5,0)),3)   other " +
        "    ,round(sum(nvl(a.INC_AMT,0)),3)     inc " +
        "    ,round(sum(nvl(a.SEVERANCE_AMT,0)),3) severance " +
        "    ,round(sum(nvl(a.RETURN_AMT,0)),3)  return " +
        "    ,round(sum(nvl(a.ALE_STOP_AMT,0)),3) ale_stop " +
        "    ,0 " +
        "    ,round(sum(nvl(a.GROSS_AMT,0)),3) gross " +
        "    ,round(sum(nvl(a.OT_TAX_L1_AMT,0)+nvl( a.OT_TAX_L2_AMT,0)),3) ot_tax " +
        "    ,round(sum(nvl(a.DEDUCT_PIT,0)),3)  family_deduct " +
        "    ,round(sum(nvl(a.ADVANCE_AMT,0)),3) advanced " +
        "    ,round(sum(nvl(a.INCOME_TAX,0)),3) income " +
        "    ,round(sum(nvl(a.SOCIAL_AMT,0)+nvl(a.HEALTH_AMT,0)+nvl(a.UNEMP_INS,0)),3) ins " +
        "    ,round(sum(nvl(a.UNION_AMT,0)),3) union_amt " +
        "    ,0,0 " +
        "    ,round(sum(nvl(a.NET_AMT,0)),3) net " +
        "from thr_month_salary_ur a " +         
        "where a.del_if=0 and a.work_mon='" + p_work_mon + "' " +
        " and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
        " and a.emp_id like '%" + p_emp_id + "%' " + 
        " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
        " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
        " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
        " and nvl(a.net_amt,0) " + p_type  +
        " and decode('" + p_times + "','ALL','ALL',a.times)='" + p_times + "'" +
        " group by a.tco_dept_pk,a.dept_nm,a.thr_group_pk,a.thr_group_nm "  +
        "order by a.dept_nm,a.thr_group_nm" ;
		
	//Response.Write(SQL);
	//Response.End();
	DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
	
	
	string SQL_Com
	= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY'),to_char(to_date('" + p_work_mon + "','yyyymm'),'MM-YYYY') " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               comm.tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        "and rownum=1 " ;

    
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="payroll%20summary_files/filelist.xml">
<link rel=Edit-Time-Data href="payroll%20summary_files/editdata.mso">
<link rel=OLE-Object-Data href="payroll%20summary_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2007-08-06T07:27:59Z</o:LastPrinted>
  <o:Created>2006-08-05T06:42:44Z</o:Created>
  <o:LastSaved>2011-05-15T08:32:51Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .5in 0in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
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
	padding:0px;
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
.xl65
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#9999FF;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#9999FF;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
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
      <x:Scale>50</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:SplitVertical>1</x:SplitVertical>
     <x:LeftColumnRightPane>1</x:LeftColumnRightPane>
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
       <x:ActiveCol>0</x:ActiveCol>
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
  <x:WindowHeight>8010</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2325</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$8:$10</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=3190 style='border-collapse:
 collapse;table-layout:fixed;width:2386pt'>
 <col class=xl66 width=143 style='mso-width-source:userset;mso-width-alt:5229;
 width:107pt'>
 <col class=xl65 width=103 span=21 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl65 width=103 span=5 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl66 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl65 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl65 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <tr height=17 style='height:12.75pt'>
  <td colspan=23 rowspan=6 height=102 width=2409 style='height:76.5pt;
  width:1801pt' align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1028" type="#_x0000_t75"
   alt="HEAD" style='position:absolute;margin-left:422.25pt;margin-top:7.5pt;
   width:1020.75pt;height:67.5pt;z-index:1;visibility:visible'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" o:title="vinagenuwin"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:563px;margin-top:10px;width:1361px;
  height:90px'><img width=1361 height=90
  src="payroll%20summary_files/image002.jpg" alt=HEAD v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=23 rowspan=6 height=102 class=xl74 width=2409 style='height:
    76.5pt;width:1801pt' x:str="                    "><span
    style='mso-spacerun:yes'>                    </span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl65 width=103 style='width:77pt'></td>
  <td class=xl65 width=103 style='width:77pt'></td>
  <td class=xl65 width=103 style='width:77pt'></td>
  <td class=xl65 width=103 style='width:77pt'></td>
  <td class=xl65 width=103 style='width:77pt'></td>
  <td class=xl66 width=103 style='width:77pt'></td>
  <td class=xl65 width=65 style='width:49pt'></td>
  <td class=xl65 width=98 style='width:74pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl65 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  12'>
  <td height=0 class=xl66></td>
  <td colspan=15 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=25 height=27 class=xl75 style='height:20.25pt'>PAYROLL SUMMARY
  FOR <%=dt_Com.Rows[0][4].ToString()%></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl67 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl73 width=143 style='height:30.75pt;width:107pt'>GROUP</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>WT.AMT</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt' x:str="OT AMT ">OT
  AMT<span style='mso-spacerun:yes'> </span></td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>NIGHT TIME</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>ABS 70%</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>ABSENT</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>HOUSE_ALL</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>TRANS_ALL</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>INDUS_ALL</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>TREAT_ALL</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>ABILITY_ALL</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>RESPON_ALL</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>MANAGER_ALL</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>SENIOR_ALL</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>CHILDREN_ALL</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>OTHER_ALL</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>INC AMT</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>SEVERANCE</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>RETURN</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>ANNUAL STOP</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>AL REMAIN <br>
    LAST YEAR</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>GROSS SALARY</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>OT NO TAX</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>FAMILY DEDUCTION</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>ADVANCE</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>INCOME TAX</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>INSURRANCE</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>UNION</td>
  <td class=xl73 width=103 style='border-left:none;width:77pt'>DEDUCT TET HOL</td>
  <td class=xl73 width=65 style='border-left:none;width:49pt'>ATM</td>
  <td class=xl73 width=98 style='border-left:none;width:74pt'>NETPAY</td>
 </tr>
 <%
	int i=0,j=0;
	double[] Grant_Total=new double[60];
	for( i=0;i<60;i++)
		Grant_Total[i]=0;
	for (i=0;i<irow_emp;i++)
    {
		j=0;
		for( int t=1;t<=31;t++)
			Grant_Total[t]+=double.Parse(dt_Emp.Rows[i][t].ToString());
	%>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl69 style='height:20.25pt;border-top:none'><%=dt_Emp.Rows[i][j++].ToString()%> (<%=dt_Emp.Rows[i][j++].ToString()%>)</td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl70 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
  <td class=xl71 style='border-top:none;border-left:none' x:num=""><%=dt_Emp.Rows[i][j++].ToString()%></td>
 </tr>
 <%
	}
	j=1;
 %>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl68 style='height:22.5pt;border-top:none'>GRAND TOTAL
  (<%=Grant_Total[j++]%>)</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
  <td class=xl72 style='border-top:none;border-left:none' x:num=""><%=Grant_Total[j++]%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt'></td>
  <td colspan=15 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt'></td>
  <td colspan=15 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl66 style='height:12.75pt'></td>
  <td colspan=15 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 class=xl66 style='height:20.25pt'></td>
  <td colspan=4 class=xl75>ACCOUNTING DEPARTMENT</td>
  <td colspan=11 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl75>GENERAL DIRECTOR</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl66 style='height:15.75pt'></td>
  <td colspan=4 class=xl76>(signature)</td>
  <td colspan=11 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl76>(signature)</td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
