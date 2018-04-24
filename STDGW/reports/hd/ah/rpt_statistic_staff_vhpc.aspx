
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
    string p_work_mon,p_from,p_to;    
    p_work_mon = Request["p_1"].ToString();
    p_from = Request["p_from"].ToString();
    p_to = Request["p_to"].ToString();
    string SQL
    = "select to_char(to_date(c.CAR_DATE,'yyyymmdd'),'dd/mm/yyyy') " +
        ",nvl(wd.num1,0)+ nvl(abs1.num2,0)- nvl(abs2.num3,0) " +
        ",nvl(jo.num4,0) new_staff " +
        ",nvl(le.num5,0) left_staff " +
        ",nvl(abs.num6,0) absence " +
        ",(nvl(wd.num1,0)+ nvl(abs1.num2,0)- nvl(abs2.num3,0)- nvl(abs.num6,0)) as working " +
        ",case when (nvl(wd.num1,0)+ nvl(abs1.num2,0)- nvl(abs2.num3,0))=0 then 0 " +
        "      else round((nvl(wd.num1,0)+ nvl(abs1.num2,0)- nvl(abs2.num3,0)- nvl(abs.num6,0))*100/(nvl(wd.num1,0)+ nvl(abs1.num2,0)- nvl(abs2.num3,0)),2) end ratio " +
        ",nvl(late.num7,0) lately " +
        "from comm.tco_abcalendar c, " +
        "    (select a.WORK_DT work_dt, count(*) num1 " +
        "    from thr_time_machine a, thr_employee b " +
        "    where a.del_if=0 and b.del_if=0 " +
        "    and a.THR_EMP_PK = b.pk " +
        "    and a.HOL_TYPE is null " +
        "    and a.WORK_DT between '" + p_from + "' and '" + p_to + "' " +
        "    and b.NATION='01' " +
        "    and a.THR_EMP_PK not in (select t.THR_EMP_PK from thr_absence t  " +
        "                                    where t.del_if=0 and t.ABSENCE_DT = a.WORK_DT " +
        "                                       and t.THR_EMP_PK = a.THR_EMP_PK) " +
        "    group by a.WORK_DT) wd, " +
        "    (select t.ABSENCE_DT absence_dt, count(*) num2 " +
        "    from thr_absence t, thr_employee b  " +
        "    where t.del_if=0 and b.del_if=0 " +
        "    and t.THR_EMP_PK = b.pk " +
        "    and t.ABSENCE_DT between '" + p_from + "' and '" + p_to + "' " +
        "    and b.NATION ='01' " +
        "    group by t.ABSENCE_DT) abs1, " +
        "    (select t.ABSENCE_DT absence_dt, count(*) num3 " +
        "    from thr_absence t, thr_wg_sch_detail s " +
        "    where t.del_if=0 and s.DEL_IF=0 " +
        "    and s.THR_EMP_PK = t.THR_EMP_PK " +
        "    and s.WORK_DT = t.ABSENCE_DT " +
        "    and t.THR_ABSENCE_REG_PK is not null " +
        "    and t.ABSENCE_DT between '" + p_from + "' and '" + p_to + "' " +
        "    and s.HOL_TYPE is not null " +
        "    group by t.ABSENCE_DT " +
        "    ) abs2, " +
        "    (select a.JOIN_DT join_dt ,count(*) num4 from thr_employee a " +
        "    where a.del_if=0 " +
        "    and a.JOIN_DT between '" + p_from + "' and '" + p_to + "' " +
        "    and a.NATION='01' and nvl(a.SALARY_YN,'Y')='Y' " +
        "    group by a.JOIN_DT " +
        "    ) jo, " +
        "    (select a.LEFT_DT left_dt ,count(*) num5 from thr_employee a " +
        "    where a.del_if=0 " +
        "    and a.LEFT_DT between '" + p_from + "' and '" + p_to + "' " +
        "    and a.NATION='01' and nvl(a.SALARY_YN,'Y')='Y' " +
        "    group by a.LEFT_DT " +
        "    ) le, " +
        "    (select t.ABSENCE_DT absence_dt, count(*) num6  " +
        "    from thr_absence t, thr_employee b " +
        "    where t.del_if=0 and b.del_if=0 " +
        "    and t.THR_EMP_PK = b.pk " +
        "    and b.NATION = '01' " +
        "    and t.ABSENCE_DT between '" + p_from + "' and '" + p_to + "' " +
        "    and t.ABSENCE_TYPE in ('05','13','19') " +
		"    and t.ABSENCE_DT between '" + p_from + "' and nvl(b.LEFT_DT,'" + p_to + "') " +
        "    group by t.ABSENCE_DT " +
        "    ) abs, " +
        "    (select b.work_dt work_dt " +
        "    ,sum(case when round(to_number(to_date(b.date_in||b.time_in,'yyyymmddhh24:mi')-to_date(b.work_dt||s.start_time,'yyyymmddhh24:mi'))*24*60  " +
        "                        -  decode(re.reg_type,'03',0,f_lately_regulation(b.work_dt,re.start_dt,re.end_dt,re.mi)),0)  " +
        "                           >4                      " +
        "        then 1 " +
        "        else 0 end " +
        "        ) as num7 " +
        "        from thr_employee a, thr_time_machine b,thr_work_shift s " +
        "        ,(select r.thr_emp_pk thr_emp_pk,max(r.start_dt) start_dt,max(r.end_dt) end_dt,max(nvl(r.reg_hours,0))*60 as mi, r.reg_type reg_type " +
        "            from thr_regulation r where r.del_if=0 " +
        "                group by r.thr_emp_pk, r.reg_type " +
        "            having max(r.start_dt)<='" + p_to + "' and max(r.end_dt)>='" + p_from + "') re " +
        "        where a.del_if=0 and b.del_if=0 and s.del_if=0 and b.thr_ws_pk=s.pk " +
        "        and a.pk=b.thr_emp_pk " +
        "        and b.hol_type is null " +
        "        and b.work_dt between '" + p_from + "' and '" + p_to + "' " +
        "        and b.work_dt between '" + p_from + "' and to_char(to_date(nvl(a.left_dt,'30000101'),'yyyymmdd')-1,'yyyymmdd') " +
        "        and nvl(a.left_dt,'" + p_to + "') >= '" + p_from + "' " +
        "        and a.thr_wg_pk <> 21  " +
		"    	 and a.NATION = '01' " +	
		"		 AND B.WORK_DT NOT IN (SELECT C.ABSENCE_DT FROM THR_ABSENCE C WHERE C.DEL_IF=0 " +
        "                			            AND C.ABSENCE_DT = B.WORK_DT AND C.THR_EMP_PK =B.THR_EMP_PK AND C.ABSENCE_TYPE NOT IN  ('05','13','19')) " +
        "        and a.pk=re.thr_emp_pk(+) " +
        "        group by b.work_dt " +
        "    )late " +
        "where c.DEL_IF=0 and c.CAR_DATE = wd.work_dt(+) " +
        "and c.CAR_DATE between '" + p_from + "' and '" + p_to + "' " +
        "and c.CAR_DATE = abs1.absence_dt(+) " +
        "and c.CAR_DATE = abs2.absence_dt(+) " +
        "and c.CAR_DATE = jo.join_dt(+) " +
        "and c.CAR_DATE = le.left_dt(+) " +
        "and c.CAR_DATE = abs.absence_dt(+) " +
        "and c.CAR_DATE = late.work_dt(+) " +
        "order by c.CAR_DATE ";

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    if (dt_Emp.Rows.Count == 0)
    {
        Response.Write("There is no data ");
        Response.End();
    }
    
	string SQL_Late
    = "    select nvl(count(distinct b.thr_emp_pk),0) " + 
        "        from thr_employee a, thr_time_machine b,thr_work_shift s  " +
        "        ,(select r.thr_emp_pk thr_emp_pk,max(r.start_dt) start_dt,max(r.end_dt) end_dt,max(nvl(r.reg_hours,0))*60 as mi, r.reg_type reg_type  " +
        "            from thr_regulation r where r.del_if=0  " +
        "                group by r.thr_emp_pk, r.reg_type  " +
        "            having max(r.start_dt)<='"+ p_to +"' and max(r.end_dt)>='"+ p_from +"') re  " +
        "        where a.del_if=0 and b.del_if=0 and s.del_if=0 and b.thr_ws_pk=s.pk  " +
        "        and a.pk=b.thr_emp_pk  " +
        "        and b.hol_type is null  " +
        "        and b.work_dt between '"+ p_from +"' and '"+ p_to +"'  " +
        "        and b.work_dt between '"+ p_from +"' and to_char(to_date(nvl(a.left_dt,'30000101'),'yyyymmdd')-1,'yyyymmdd')  " +
        "        and nvl(a.left_dt,'"+ p_to +"') >= '"+ p_from +"'  " +
        "        and a.thr_wg_pk <> 21   " +
        "         AND B.WORK_DT NOT IN (SELECT C.ABSENCE_DT FROM THR_ABSENCE C WHERE C.DEL_IF=0  " +
        "                                        AND C.ABSENCE_DT = B.WORK_DT AND C.THR_EMP_PK =B.THR_EMP_PK AND C.ABSENCE_TYPE NOT IN  ('05','13','19'))  " +
        "        and round(to_number(to_date(b.date_in||b.time_in,'yyyymmddhh24:mi')-to_date(b.work_dt||s.start_time,'yyyymmddhh24:mi'))*24*60   " +
        "                        -  decode(re.reg_type,'03',0,f_lately_regulation(b.work_dt,re.start_dt,re.end_dt,re.mi)),0)   " +
        "                           >4 " +
        "        and a.pk=re.thr_emp_pk(+) " ;
    
	DataTable dt_Late = ESysLib.TableReadOpen(SQL_Late);
    
	
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_statistic_staff_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_statistic_staff_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_statistic_staff_vhpc_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>welcome</o:Author>
  <o:LastAuthor>HRSV1</o:LastAuthor>
  <o:LastPrinted>2011-02-09T01:40:12Z</o:LastPrinted>
  <o:Created>2011-02-08T03:51:24Z</o:Created>
  <o:LastSaved>2011-02-09T01:40:53Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .75in 0in .75in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;
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
.style56
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
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
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
.xl66
	{mso-style-parent:style56;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:129;}
.xl67
	{mso-style-parent:style56;
	color:black;
	font-size:18.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl68
	{mso-style-parent:style56;
	color:#99CCFF;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:129;}
.xl69
	{mso-style-parent:style56;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:129;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style56;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;}
.xl71
	{mso-style-parent:style56;
	color:black;
	font-size:20.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl72
	{mso-style-parent:style56;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:129;
	border:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style56;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style56;
	color:black;
	font-size:11.0pt;
	font-family:Calibri, sans-serif;
	mso-font-charset:129;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style56;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:Calibri, sans-serif;
	mso-font-charset:129;
	border:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
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
      <x:Scale>88</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:WindowHeight>9015</x:WindowHeight>
  <x:WindowWidth>16275</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1054 style='border-collapse:
 collapse;table-layout:fixed;width:792pt'>
 <col width=187 style='mso-width-source:userset;mso-width-alt:6838;width:140pt'>
 <col width=141 style='mso-width-source:userset;mso-width-alt:5156;width:106pt'>
 <col width=118 style='mso-width-source:userset;mso-width-alt:4315;width:89pt'>
 <col width=136 style='mso-width-source:userset;mso-width-alt:4973;width:102pt'>
 <col width=118 span=2 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=119 style='mso-width-source:userset;mso-width-alt:4352;width:89pt'>
 <tr height=19 style='height:14.25pt'>
  <td height=19 width=187 style='height:14.25pt;width:140pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1029" type="#_x0000_t75"
   style='position:absolute;margin-left:0;margin-top:13.5pt;width:134.25pt;
   height:45.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_statistic_staff_vhpc_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:18px;width:179px;
  height:61px'><img width=179 height=61
  src="rpt_statistic_staff_vhpc_files/image002.gif" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl66 width=187 style='height:14.25pt;width:140pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl66 width=141 style='width:106pt'></td>
  <td class=xl66 width=118 style='width:89pt'></td>
  <td class=xl66 width=136 style='width:102pt'></td>
  <td class=xl66 width=118 style='width:89pt'></td>
  <td class=xl66 width=118 style='width:89pt'></td>
  <td class=xl66 width=117 style='width:88pt'></td>
  <td class=xl66 width=119 style='width:89pt'></td>
 </tr>
 <tr height=61 style='mso-height-source:userset;height:45.75pt'>
  <td height=61 style='height:45.75pt'></td>
  <td class=xl70 colspan=5 style='mso-ignore:colspan'>REPORT STATISTIC STAFF
  MONTH <%= p_work_mon.Substring(4,2).ToString() %>/<%= p_work_mon.Substring(0,4).ToString() %></td>
  <td class=xl70></td>
  <td class=xl71></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 colspan=8 class=xl67 style='height:23.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl66 style='height:14.25pt'></td>
  <td colspan=7 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl69 style='height:27.0pt'>Day in Month</td>
  <td class=xl69 style='border-left:none'>New staff</td>
  <td class=xl69 style='border-left:none'>Leave<span style='mso-spacerun:yes'> 
  </span>staff</td>
  <td class=xl69 style='border-left:none'>Late (staff)</td>
  <td class=xl69 style='border-left:none'>Absence</td>
  <td class=xl69 style='border-left:none'>Working</td>
  <td class=xl69 style='border-left:none'>Total (staff)</td>
  <td class=xl69 style='border-left:none'>Ratio working</td>
 </tr>
  <% 
   double[] total = new double[7];
   for (int i = 0; i < 7; i++)
       total[i] = 0;
         
     for (int i = 0; i < dt_Emp.Rows.Count; i++)
     {
         for(int j=1 ;j<dt_Emp.Columns.Count; j++)
            total[j-1] += Double.Parse(dt_Emp.Rows[i][j].ToString()) ;
         %>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl72 style='height:27.0pt;border-top:none'><%=dt_Emp.Rows[i][0].ToString()%></td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                               </span><%=dt_Emp.Rows[i][2].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%=dt_Emp.Rows[i][3].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                             </span><%=dt_Emp.Rows[i][7].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=dt_Emp.Rows[i][4].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%=dt_Emp.Rows[i][5].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                       </span><%=dt_Emp.Rows[i][1].ToString()%> </td>
  <td class=xl74 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%=dt_Emp.Rows[i][6].ToString()%> </td>
 </tr>
 <%
      } 
  %>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl75 style='height:27.0pt;border-top:none'>TOTAL</td>
  <td class=xl76 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                               </span><%= total[1] %> </td>
  <td class=xl76 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                          </span><%= total[2] %> </td>
  <td class=xl76 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                              </span><%= dt_Late.Rows[0][0].ToString() %> </td>
  <td class=xl76 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%= total[3] %> </td>
  <td class=xl76 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                         </span><%= total[4] %> </td>
  <td class=xl76 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                       </span><%= total[0] %> </td>
  <td class=xl77 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                     </span><%= total[4]*100/total[0] %> </td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl66 style='height:14.25pt'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=187 style='width:140pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=136 style='width:102pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=119 style='width:89pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>

