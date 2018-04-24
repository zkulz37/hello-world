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
    string p_tco_dept_pk, p_thr_group_pk, p_status, p_emp_id, p_work_mon, p_from_dt, p_to_dt, p_dept_nm, p_salary_period, p_nation;
    
    p_tco_dept_pk = Request["l_tco_dept_pk"].ToString();
    p_thr_group_pk = Request["l_thr_group_pk"].ToString();
    p_status = Request["l_status"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();
    p_to_dt = Request["l_to_dt"].ToString();
    p_from_dt = Request["l_from_dt"].ToString();
    p_dept_nm = Request["l_dept_nm"].ToString();
    p_salary_period = Request["l_SalaryPeriod"].ToString();
    p_nation = Request["l_nation"].ToString();
    DateTime p_from_dt_1=new DateTime(int.Parse(p_from_dt.Substring(0,4).ToString()),int.Parse(p_from_dt.Substring(4,2).ToString()),int.Parse(p_from_dt.Substring(6,2).ToString())) ;
    DateTime p_to_dt_1=new DateTime(int.Parse(p_to_dt.Substring(0,4).ToString()),int.Parse(p_to_dt.Substring(4,2).ToString()),int.Parse(p_to_dt.Substring(6,2).ToString())) ;
    TimeSpan ts=p_to_dt_1-p_from_dt_1;
    int iDays=ts.Days+1;
  
    //-----------------working time-----------------
    string SQL
	= "select b.emp_id a0 " + 
        ",b.full_name a1 " +
        ",b.dept a2 " +
        ",b.sec a3 " +
        ",b.pos_type a4 " +
        ",to_char(to_date(b.CAR_DATE,'yyyymmdd'),'dd/mm/yyyy') a5 " +
        ",decode(b.day_type,1,'CN',b.day_type) a6 " +
        ",c.time_in a7 " +
        ",c.time_out a8 " +
        ",c.shift a9 " +
        ",nvl(c.work_time,0) a10 " +
        ",0 NC300a11 " +
        ",nvl(d.ot,0) a12 " +
        ",nvl(d.ht,0) a13 " +
        ",nvl(d.oht,0) a14 " +
        ",nvl(d.nt30,0) a15 " +
        ",nvl(d.nt45,0) a16 " +
        ",nvl(d.nt60,0) a17 " +
        ",nvl(c.lately,0) a18 " +
        ",nvl(c.early ,0) a19 " +
        ",nvl(c.minus_hours,0)  a20 " +
        ",(select v.char_1 from vhr_hr_code v where  v.id='HR0003' and v.code=e.absence_type) a21 " +
        ",nvl(W.TOTAL_HOL,0)/8 A22 " +
        ",nvl(M.ABS_TOTAL_PAY,0)/8 A23 " +
        ",nvl(M.ABS_TOTAL_UNPAY,0)/8 A24 " +
        "from (select a.car_date,a.day_type,f.pk,f.emp_id,f.tco_org_pk,f.full_name " +
        "    ,(select v.code_nm from vhr_hr_code v where v.id='HR0008' and v.code=f.pos_type) pos_type " +
        "    ,g.org_nm dept " +
        "    ,r.org_nm sec " +
        "    ,f.tco_company_pk,f.nation,f.thr_wg_pk,f.status,f.sal_period from  tco_abcalendar a, thr_employee  f,tco_org g ,tco_org r  " +
        "            where a.del_if=0 and f.del_if=0 and g.del_if=0 and r.del_if=0 and f.MATERNITY_LEAVE_DT is null and (f.status='A' or f.left_dt>'" + p_to_dt +"')    " +
        "            and a.CAR_DATE between '" + p_from_dt + "' and '" + p_to_dt + "'  " +
        "            and f.tco_org_pk=g.pk " +
        "            and g.p_pk=r.pk " +
        " and (f.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        "and decode('" + p_thr_group_pk + "','ALL','ALL',f.thr_wg_pk)='" + p_thr_group_pk + "' " +
        "and f.emp_id like '%" + p_emp_id + "%' " + 
        "and decode('" + p_status + "','ALL','ALL',f.status)='" + p_status + "' " +
        " and decode('" + p_salary_period + "','ALL','ALL',nvl(f.sal_period,' '))='" + p_salary_period + "' " +
        " and decode('" + p_nation + "','ALL','ALL',nvl(f.nation,'01'))='" + p_nation + "' " +
        "            ) b " +
        ",(select thr_emp_pk,ti.work_dt,ti.TIME_IN,ti.time_out,ti.work_time -nvl(ti.MINUS_WT,0) work_time,ws.shift " +
        "    ,(case when (HR_F_LATELY_EARLY(ti.WORK_DT,ws.START_TIME,ti.DATE_IN,ti.TIME_IN,'IN',ti.thr_emp_pk)) >=0 then NULL " +
        "                else " +
        "                    ABS((HR_F_LATELY_EARLY(ti.WORK_DT,ws.START_TIME,ti.DATE_IN,ti.TIME_IN,'IN',ti.thr_emp_pk))) " +
        "              END ) lately " +
        "    ,(case when (HR_F_LATELY_EARLY(ti.DATE_OUT,ti.TIME_OUT,DECODE(ws.DURING_DAY,1,ti.WORK_DT,TO_CHAR(TO_DATE(ti.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),ws.END_TIME,'OUT',ti.thr_emp_pk)) >=0 then null " +
        "                else " +
        "                    abs((HR_F_LATELY_EARLY(ti.DATE_OUT,ti.TIME_OUT,DECODE(ws.DURING_DAY,1,ti.WORK_DT,TO_CHAR(TO_DATE(ti.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),ws.END_TIME,'OUT',ti.thr_emp_pk))) " +
        "              end) early " +
        "    ,nvl(ti.minus_wt,0) + nvl(ti.minus_ot,0)  minus_hours " +
        "     from thr_time_machine ti,thr_work_shift ws,thr_employee m  " +
        "        where ti.del_if=0 and ws.del_if=0 and ti.thr_ws_pk=ws.pk and m.del_if=0 and ti.thr_emp_pk=m.pk " +
        " and (m.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        "and decode('" + p_thr_group_pk + "','ALL','ALL',m.thr_wg_pk)='" + p_thr_group_pk + "' " +
        "and m.emp_id like '%" + p_emp_id + "%' " + 
        "and decode('" + p_status + "','ALL','ALL',m.status)='" + p_status + "' " +
        " and decode('" + p_salary_period + "','ALL','ALL',nvl(m.sal_period,' '))='" + p_salary_period + "' " +
        " and decode('" + p_nation + "','ALL','ALL',nvl(m.nation,'01'))='" + p_nation + "' " +
        "        and  ti.work_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
        "        ) c " +
        ",(select EX.thr_emp_pk,t.work_dt,SUM(decode(nvl(ex.hol_type,' '),' ',decode(ex.ot_type,'OT',ex.ot_time,0) ) -nvl(t.MINUS_OT,0) + nvl(t.ot_plus,0))  ot " +
        "                        ,sum(case when ((nvl(ex.hol_type,' ')='SUN' and ex.ot_type in('OT','HT')) or(nvl(ex.hol_type,' ')='HOL' and ex.ot_type ='HT')) then nvl(ex.ot_time,0) + nvl(t.ot_plus,0) -nvl(t.MINUS_OT,0) else 0 end)  ht " +
        "                        ,sum((case when nvl(ex.hol_type,' ')='HOL' and ex.ot_type in('OT') then nvl(ex.ot_time,0) + nvl(t.ot_plus,0)-nvl(t.MINUS_OT,0) else 0 end) ) oht " +
        "                        ,SUM(decode(nvl(ex.hol_type,' '),' ',decode(ex.ot_type,'NT',ex.ot_time,0),0)) nt30 " +
        "                        ,SUM(decode(nvl(ex.hol_type,' '),' ',decode(ex.ot_type,'NT2',ex.ot_time,0),0)) nt45 " +
        "                        ,SUM(decode(nvl(ex.hol_type,' '),' ',0,decode(ex.ot_type,'NT',ex.ot_time,0))) nt60 " +
        "            from thr_extra_time ex,thr_employee m,thr_time_machine t " +
        "    where ex.del_if(+)=0 and m.del_if=0  and t.del_if=0 and t.thr_emp_pk=m.pk and t.thr_emp_pk=ex.thr_emp_pk(+) and t.work_dt=ex.work_dt(+) " + 
        " and (m.tco_org_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        "and decode('" + p_thr_group_pk + "','ALL','ALL',m.thr_wg_pk)='" + p_thr_group_pk + "' " +
        "and m.emp_id like '%" + p_emp_id + "%' " + 
        "and decode('" + p_status + "','ALL','ALL',m.status)='" + p_status + "' " +
        " and decode('" + p_salary_period + "','ALL','ALL',nvl(m.sal_period,' '))='" + p_salary_period + "' " +
        " and decode('" + p_nation + "','ALL','ALL',nvl(m.nation,'01'))='" + p_nation + "' " +
        " and t.work_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
        "    group by ex.thr_emp_pk,t.WORK_DT) d,(select ab.thr_emp_pk,ab.absence_type,ab.absence_dt from thr_absence ab where ab.del_if=0 and ab.absence_dt between '" + p_from_dt + "' and '" + p_to_dt + "') e " +
        ",thr_work_mon w,THR_ABSENCE_MONTH M " +
        "where  w.del_if=0 AND M.DEL_IF=0  " +
        "and w.THR_EMP_PK=b.pk  " +
        "AND M.THR_EMP_PK=b.pk " +
        "and b.pk=c.thr_emp_pk(+) " +
        "and b.pk=d.thr_emp_pk(+) " +
        "and b.pk=e.thr_emp_pk(+) " +
        "and w.work_mon=m.work_mon " +
        "and w.work_mon='" + p_work_mon + "' " +
        "and M.work_mon='" + p_work_mon + "' " +
        "and b.car_date = c.work_dt(+) " +
        "and b.car_date = d.work_dt(+) " +
        "and b.car_date = e.absence_dt(+) " +
          "order by b.dept,b.sec,b.emp_id,b.car_date " ;

   // Response.Write(SQL);
   // Response.End();   
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp;
    irow_emp = dt_Emp.Rows.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of working time");
        Response.End();
    }
    int iDate_Num;
    
    //-----------------calendar-----------------
    string SQL_Cal
    = "select sum(decode(nvl(t.hol_type,' '),'SUN',1,0)) SD, sum(decode(nvl(t.hol_type,' '),'SUN',0,1)) WD " +
        "from thr_calendar T,thr_close m " +
        "where t.del_if=0 and m.del_if=0 and m.id='" + p_salary_period + "' and m.month_close='" + p_work_mon + "' and m.tco_company_pk=t.tco_company_pk " +
        "   and m.tco_company_pk=(select tco_company_pk from tco_org g where g.del_if=0 and g.pk='" + p_tco_dept_pk + "' ) " +
        "    and t.car_date between m.from_dt and '" + p_to_dt + "'";
      //  Response.Write(SQL_Cal);
    //Response.End(); 
    DataTable dt_Cal = ESysLib.TableReadOpen(SQL_Cal);
    iDate_Num = dt_Cal.Rows.Count;
    if (iDate_Num == 0)
    {
        Response.Write("There is no data of calendar");
        Response.End();
    }
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_detaildatalist_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_detaildatalist_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_detaildatalist_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Nguyen Cong Thanh</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2012-07-19T07:44:20Z</o:LastPrinted>
  <o:Created>2005-04-22T06:24:06Z</o:Created>
  <o:LastSaved>2012-07-19T07:44:58Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.17in 0in 0in .3in;
	mso-header-margin:.17in;
	mso-footer-margin:0in;}
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:.5pt solid silver;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid silver;
	border-right:none;
	border-bottom:.5pt solid silver;
	border-left:.5pt solid silver;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid silver;
	border-right:none;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid silver;
	border-right:.5pt solid silver;
	border-bottom:.5pt solid silver;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int ipage=48;
        int irow=0;
        for (int k=0;k<irow_emp/iDays;k++)
        {
            irow+=ipage;
                %>
                    <x:RowBreak>
                        <x:Row><%=irow %></x:Row>
                    </x:RowBreak>
                <%
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
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
  <x:WindowHeight>9225</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=833 style='border-collapse:
 collapse;table-layout:fixed;width:626pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=31 style='mso-width-source:userset;mso-width-alt:1133;width:23pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=52 span=2 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=47 style='mso-width-source:userset;mso-width-alt:1718;width:35pt'>
 <col width=45 span=3 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1865;width:38pt'>
 <col width=49 style='mso-width-source:userset;mso-width-alt:1792;width:37pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=69 style='mso-width-source:userset;mso-width-alt:2523;width:52pt'>
 <% 
    int i=0;
    while (i<irow_emp)
    {
        
    %> 
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 width=27 style='height:9.0pt;width:20pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=69 style='width:52pt'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=2 style='height:22.5pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl46>DANH SÁCH CHI TIẾT NHÂN VIÊN ĐI LÀM</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl25>TỪ <%=p_from_dt.Substring(6,2).ToString() + "/" + p_from_dt.Substring(4,2).ToString() + "/" + p_from_dt.Substring(0,4).ToString() %> TỚI <%=p_to_dt.Substring(6,2).ToString() + "/" + p_to_dt.Substring(4,2).ToString() + "/" + p_to_dt.Substring(0,4).ToString() %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=15 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 colspan=7 style='height:12.75pt;mso-ignore:colspan'>MSNV
  VÀ TÊN<span style='mso-spacerun:yes'>  </span>: <%= dt_Emp.Rows[i]["a0"].ToString() %>-<%= dt_Emp.Rows[i]["a1"].ToString() %></td>
  <td class=xl24></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 colspan=5 style='height:14.25pt;mso-ignore:colspan'>PHÒNG
  BAN<span style='mso-spacerun:yes'>     </span>: <%= dt_Emp.Rows[i]["a2"].ToString() %></td>
  <td class=xl24></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 colspan=5 style='height:14.25pt;mso-ignore:colspan'>BỘ
  PHẬN<span style='mso-spacerun:yes'>          </span>: <%= dt_Emp.Rows[i]["a3"].ToString() %></td>
  <td class=xl24></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl24 colspan=5 style='height:13.5pt;mso-ignore:colspan'>VỊ
  TRÍ<span style='mso-spacerun:yes'>               </span>: <%= dt_Emp.Rows[i]["a4"].ToString() %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=2 height=39 class=xl47 style='border-bottom:.5pt solid black;
  height:29.25pt'>STT</td>
  <td rowspan=2 class=xl47 style='border-bottom:.5pt solid black'>NGÀY</td>
  <td rowspan=2 class=xl49 width=31 style='border-bottom:.5pt solid black;
  width:23pt'>THỨ</td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>GiỜ</td>
  <td rowspan=2 class=xl53 width=27 style='border-bottom:.5pt solid black;
  width:20pt'>CA LV</td>
  <td rowspan=2 class=xl53 width=52 style='border-bottom:.5pt solid black;
  width:39pt'>GiỜ CÔNG</td>
  <td rowspan=2 class=xl53 width=52 style='border-bottom:.5pt solid black;
  width:39pt'>NC 300%</td>
  <td colspan=3 class=xl55 width=138 style='border-right:.5pt solid black;
  border-left:none;width:104pt'>TĂNG CA (GiỜ)</td>
  <td colspan=3 class=xl43 width=136 style='border-right:.5pt solid black;
  border-left:none;width:103pt'>PHỤ CẤP (GIỜ)</td>
  <td rowspan=2 class=xl38 width=51 style='border-bottom:.5pt solid black;
  width:38pt'>ĐI TRỄ ( PHÚT )</td>
  <td rowspan=2 class=xl38 width=49 style='border-bottom:.5pt solid black;
  width:37pt'>VỀ SỚM ( PHÚT )</td>
  <td rowspan=2 class=xl38 width=50 style='border-bottom:.5pt solid black;
  width:38pt'><span style='mso-spacerun:yes'> </span>GiỜ RA NGOÀI</td>
  <td rowspan=2 class=xl38 width=69 style='border-bottom:.5pt solid black;
  width:52pt' x:str="LÝ DO NGHỈ ">LÝ DO NGHỈ<span
  style='mso-spacerun:yes'> </span></td>
 </tr>

 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'>VÀO</td>
  <td class=xl27>RA</td>
  <td class=xl28 width=46 style='width:35pt'>TC.150</td>
  <td class=xl29 width=47 style='width:35pt'>CN/NL.200</td>
  <td class=xl29 width=45 style='width:34pt'>NL.300</td>
  <td class=xl29 width=45 style='width:34pt'>PC.30</td>
  <td class=xl29 width=45 style='width:34pt'>PC.45</td>
  <td class=xl29 width=46 style='width:35pt'>PC.60</td>
 </tr>
  <%    int j=0; 
        double[] Group_GTotal=new double[11] {0,0,0,0,0,0,0,0,0,0,0};
        int icur=i;
       while ( i<icur+iDays) // while ( (   i!=0  && i<irow_emp && dt_Emp.Rows[i]["a0"].ToString() == dt_Emp.Rows[i-1]["a0"].ToString()) || i==0 )
        { 
            j++; 
            %>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt' x:num><%=j %></td>
  <td class=xl32 x:str><%=dt_Emp.Rows[i]["a5"].ToString() %></td>
  <td class=xl32 x:str><%=dt_Emp.Rows[i]["a6"].ToString() %></td>
  <td class=xl32 x:str><%=dt_Emp.Rows[i]["a7"].ToString() %></td>
  <td class=xl32 x:str><%=dt_Emp.Rows[i]["a8"].ToString() %></td>
  <td class=xl31 style='border-left:none' x:num><%=dt_Emp.Rows[i]["a9"].ToString() %></td>
                <% 
                    
                    for (int k=0;k<11;k++)
                    {
                        Group_GTotal[k]+=Double.Parse(dt_Emp.Rows[i][k+10].ToString());
                     %>
                    <td class=xl33 x:num style="white-space:nowrap;mso-text-control:shrinktofit;"><%=dt_Emp.Rows[i][k+10].ToString() %></td>
                 <%} %>
  <td class=xl31 style='border-left:none'><%=dt_Emp.Rows[i]["a21"].ToString() %></td>
 </tr>
 <%         i++;

    }
             i--;%>
    
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=3 height=24 class=xl40 style='border-right:.5pt solid silver;
  height:18.0pt'>Tổng số giờ làm việc :</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
                 <% 
                    for (int k=0;k<11;k++)
                    {
                        
                     %>
  <td class=xl36 x:num style="white-space:nowrap;mso-text-control:shrinktofit;"><span style='mso-spacerun:yes'> </span><%=Group_GTotal[k] %> </td>
                    <%} %>
  <td class=xl36>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 style='height:18.0pt;mso-ignore:colspan'>Tổng số ngày
  công :</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl37 x:num><%=Group_GTotal[0]/8 %></td>
  <td colspan=5 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=18 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=5 style='height:13.5pt;mso-ignore:colspan'
  x:str="Số ngày nghỉ lễ:                           ">Số ngày nghỉ lễ:<span
  style='mso-spacerun:yes'>                           </span></td>
  <td></td>
  <td align=right x:num><%=dt_Emp.Rows[i]["a22"].ToString() %></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=6 style='height:14.25pt;mso-ignore:colspan'
  x:str="Số ngày nghỉ được hưởng luơng:         ">Số ngày nghỉ được hưởng
  luơng:<span style='mso-spacerun:yes'>         </span></td>
  <td align=right x:num><%=dt_Emp.Rows[i]["a23"].ToString() %></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=6 style='height:14.25pt;mso-ignore:colspan'
  x:str="Số nghỉ không được hưởng luơng:         ">Số nghỉ không được hưởng
  luơng:<span style='mso-spacerun:yes'>        </span><span style='display:
  none'><span style='mso-spacerun:yes'> </span></span></td>
  <td align=right x:num><%=dt_Emp.Rows[i]["a24"].ToString() %></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <%
    i++;
    
    }//end while %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=27 style='width:20pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=69 style='width:52pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
