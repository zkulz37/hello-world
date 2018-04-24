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
    string p_tco_dept_pk, p_thr_group_pk, p_status, p_emp_id, p_work_mon, p_from_dt, p_to_dt, p_dept_nm, p_times,p_nation;
    
    p_tco_dept_pk = Request["l_tco_dept_pk"].ToString();
    p_thr_group_pk = Request["l_thr_group_pk"].ToString();
    p_status = Request["l_status"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();
    p_to_dt = Request["l_to_dt"].ToString();
    p_from_dt = Request["l_from_dt"].ToString();
    p_dept_nm = Request["l_dept_nm"].ToString();
    p_times = Request["l_resign_times"].ToString();
    p_nation = Request["l_nation"].ToString();
    
    //-----------------information of company-----------------
    string SQL_Com
	= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY') " + 
        "from comm.tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               comm.tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        "and rownum=1 " ;

    //Response.Write(SQL_Com);
    //Response.End();
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    //-----------------working time-----------------
    string SQL
	= "select a.dept_NM,a.EMP_ID,a.full_name,to_char(to_date(a.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        ",decode(nvl(b.N1,0),0,a.D1,'-' || b.N1)	"+ //,a.D2	,a.D3	,a.D4	,a.D5	,a.D6	,a.D7	,a.D8	,a.D9	,a.D10	 " +
        //",a.D11	,a.D12	,a.D13	,a.D14	,a.D15	,a.D16	,a.D17	,a.D18	,a.D19	,a.D20	 " +
        //",a.D21	,a.D22	,a.D23	,a.D24	,a.D25	,a.D26	,a.D27	,a.D28	,a.D29	,a.D30	,a.D31 " +
        ",decode(nvl(b.N2,0),0,a.D2,'-' || b.N2)	" +
        ",decode(nvl(b.N3,0),0,a.D3,'-' || b.N3)	" +
        ",decode(nvl(b.N4,0),0,a.D4,'-' || b.N4)	" +
        ",decode(nvl(b.N5,0),0,a.D5,'-' || b.N5)	" +
        ",decode(nvl(b.N6,0),0,a.D6,'-' || b.N6)	" +
        ",decode(nvl(b.N7,0),0,a.D7,'-' || b.N7)	" +
        ",decode(nvl(b.N8,0),0,a.D8,'-' || b.N8)	" +
        ",decode(nvl(b.N9,0),0,a.D9,'-' || b.N9)	" +
        ",decode(nvl(b.N10,0),0,a.D10,'-' || b.N10)	" +
        ",decode(nvl(b.N11,0),0,a.D11,'-' || b.N11)	" +
        ",decode(nvl(b.N12,0),0,a.D12,'-' || b.N12)	" +
        ",decode(nvl(b.N13,0),0,a.D13,'-' || b.N13)	" +
        ",decode(nvl(b.N14,0),0,a.D14,'-' || b.N14)	" +
        ",decode(nvl(b.N15,0),0,a.D15,'-' || b.N15)	" +
        ",decode(nvl(b.N16,0),0,a.D16,'-' || b.N16)	" +
        ",decode(nvl(b.N17,0),0,a.D17,'-' || b.N17)	" +
        ",decode(nvl(b.N18,0),0,a.D18,'-' || b.N18)	" +
        ",decode(nvl(b.N19,0),0,a.D19,'-' || b.N19)	" +
        ",decode(nvl(b.N20,0),0,a.D20,'-' || b.N20)	" +
        ",decode(nvl(b.N21,0),0,a.D21,'-' || b.N21)	" +
        ",decode(nvl(b.N22,0),0,a.D22,'-' || b.N22)	" +
        ",decode(nvl(b.N23,0),0,a.D23,'-' || b.N23)	" +
        ",decode(nvl(b.N24,0),0,a.D24,'-' || b.N24)	" +
        ",decode(nvl(b.N25,0),0,a.D25,'-' || b.N25)	" +
        ",decode(nvl(b.N26,0),0,a.D26,'-' || b.N26)	" +
        ",decode(nvl(b.N27,0),0,a.D27,'-' || b.N27)	" +
        ",decode(nvl(b.N28,0),0,a.D28,'-' || b.N28)	" +
        ",decode(nvl(b.N29,0),0,a.D29,'-' || b.N29)	" +
        ",decode(nvl(b.N30,0),0,a.D30,'-' || b.N30)	" +
        ",decode(nvl(b.N31,0),0,a.D31,'-' || b.N31)	" +
        ",decode(b.D1,0,'',b.D1) 	 " +
        ",decode(b.D2,0,'',b.D2) 	 " +
        ",decode(b.D3,0,'',b.D3) 	 " +
        ",decode(b.D4,0,'',b.D4) 	 " +
        ",decode(b.D5,0,'',b.D5) 	 " +
        ",decode(b.D6,0,'',b.D6) 	 " +
        ",decode(b.D7,0,'',b.D7) 	 " +
        ",decode(b.D8,0,'',b.D8) 	 " +
        ",decode(b.D9,0,'',b.D9) 	 " +
        ",decode(b.D10,0,'',b.D10) 	 " +
        ",decode(b.D11,0,'',b.D11) 	 " +
        ",decode(b.D12,0,'',b.D12)  " +
        ",decode(b.D13,0,'',b.D13) 	 " +
        ",decode(b.D14,0,'',b.D14)  " +
        ",decode(b.D15,0,'',b.D15) 	 " +
        ",decode(b.D16,0,'',b.D16) 	 " +
        ",decode(b.D17,0,'',b.D17)	 " +
        ",decode(b.D18,0,'',b.D18) 	 " +
        ",decode(b.D19,0,'',b.D19) 	 " +
        ",decode(b.D20,0,'',b.D20) 	 " +
        ",decode(b.D21,0,'',b.D21) 	 " +
        ",decode(b.D22,0,'',b.D22) 	 " +
        ",decode(b.D23,0,'',b.D23) 	 " +
        ",decode(b.D24,0,'',b.D24) 	 " +
        ",decode(b.D25,0,'',b.D25) 	 " +
        ",decode(b.D26,0,'',b.D26) 	 " +
        ",decode(b.D27,0,'',b.D27) 	 " +
        ",decode(b.D28,0,'',b.D28) 	 " +
        ",decode(b.D29,0,'',b.D29) 	 " +
        ",decode(b.D30,0,'',b.D30) 	 " +
        ",decode(b.D31,0,'',b.D31) 	 " +
        ",round(nvl(total_wd,0)/8-(nvl(abs.c1,0)+nvl(abs.c2,0)+nvl(abs.c3,0)+nvl(abs.c4,0)+nvl(abs.c5,0))-nvl(b.TOTAL_NT,0)/8,2) " +
        ",b.TOTAL_OT " +
        ",nvl(b.TOTAL_NT,0)/8 " +
        ",decode(nvl(abs.c1,0),0,'',c1),decode(nvl(abs.c2,0),0,'',c2),decode(nvl(abs.c3,0),0,'',c3),decode(nvl(abs.c4,0),0,'',c4),decode(nvl(abs.c5,0),0,'',c5),a.total_wd/8  " +
        ",decode(nvl(abs.c6,0),0,'',c6),decode(nvl(abs.c7,0),0,'',c7),decode(nvl(abs.c10,0),0,'',c10),decode(nvl(abs.c9,0),0,'',c9) " +
        //",decode(nvl(abs.c6,0)+nvl(abs.c7,0)+nvl(abs.c8,0)+nvl(abs.c9,0),0,'', nvl(abs.c6,0)+nvl(abs.c7,0)+nvl(abs.c8,0)+nvl(abs.c9,0)) " +
        ",decode(nvl(abs.c11,0),0,'',c11) " +
        ",decode(nvl(ot_150,0),0,'',nvl(ot_150,0)) " +
        ",decode(nvl(not_185,0),0,'',nvl(not_185,0)) " +
        ",decode(nvl(not_195,0),0,'',nvl(not_195,0)) " +
        ",decode(nvl(st_200,0),0,'',nvl(st_200,0)) " +
        ",decode(nvl(nst_270,0),0,'',nvl(nst_270,0)) " +
        ",decode(nvl(ht_200,0),0,'',nvl(ht_200,0)) " +
        ",decode(nvl(ht_300,0),0,'',nvl(ht_300,0)) " +
        ",decode(nvl(nht_235,0),0,'',nvl(nht_235,0)) " +
        ",decode(nvl(nht_300,0) ,0,'',nvl(nht_300,0)) " +
        ",decode(nvl(late.in_late,0) + nvl(late.out_early,0),0,'', nvl(late.in_late,0) + nvl(late.out_early,0)) " +
        "from thr_work_mon_ur a,thr_extra_month_ur b, thr_work_group c,thr_employee e " +
        ",(select M.THR_EMP_PK, sum(decode(M.THR_WS_PK,24,nvl(M.WORK_TIME,0),0))/8 wt_day " +
        "from thr_time_machine_ur m, thr_employee e " +
        "where M.DEL_IF=0 and e.del_if=0 and e.pk=m.thr_emp_pk " +
        "and e.emp_id like '%" + p_emp_id + "%' " +
        " and m.WORK_DT between '" + p_from_dt + "' and  nvl( to_char(to_date( e.left_dt,'yyyymmdd')-1,'yyyymmdd'), '" + p_to_dt + "')" +
        "and M.WORK_DT between '" + p_from_dt + "' and '" + p_to_dt + "'  " +
        "group by M.THR_EMP_PK) wt " +
        ",(select TA.THR_EMP_PK   " +
        ", nvl(TA.ABS_20_L1,0)/8+nvl(TA.ABS_20_L2,0)/8 c1  " +
        ", nvl(TA.ABS_01_L1,0)/8+nvl(TA.ABS_01_L2,0)/8 c2  " +
        ", nvl(TA.ABS_08_L1,0)/8+nvl(TA.ABS_08_L2,0)/8 c3  " +
        ", nvl(TA.ABS_02_L1,0)/8+nvl(TA.ABS_02_L2,0)/8 c4  " +
       " , nvl(TA.ABS_09_L1,0)/8+nvl(TA.ABS_09_L2,0)/8 c5  " +
        ", nvl(TA.ABS_11_L1,0)/8+nvl(TA.ABS_11_L2,0)/8 c6  " +
        ", nvl(TA.ABS_05_L1,0)/8+nvl(TA.ABS_05_L2,0)/8 c7  " +
        ", nvl(TA.ABS_19_L1,0)/8+nvl(TA.ABS_19_L2,0)/8 c8  " +
        ", nvl(TA.ABS_07_L1,0)/8+nvl(TA.ABS_07_L2,0)/8 c9  " +
        ",    nvl(TA.ABS_TOTAL_L1,0)/8+nvl( TA.ABS_TOTAL_L2,0)/8-nvl( TA.ABS_TOTAL_PAY,0)/8 " +
        "    -nvl(TA.ABS_11_L1,0)/8-nvl(TA.ABS_11_L2,0)/8-nvl(TA.ABS_05_L1,0)/8-nvl(TA.ABS_05_L2,0)/8 " +
        "    -nvl(TA.ABS_07_L1,0)/8-nvl(TA.ABS_07_L2,0)/8  c10 " +
        ",    nvl(TA.ABS_TOTAL_L1,0)/8+nvl( TA.ABS_TOTAL_L2,0)/8-nvl( TA.ABS_TOTAL_PAY,0)/8 c11 " +
        "from thr_absence_month_ur ta  " +
        "where TA.DEL_IF=0   " +
        "and ta.emp_id like '%" + p_emp_id + "%' " +
        "and TA.WORK_MON='" + p_work_mon + "' )  abs " +
        ",(select T.THR_EMP_PK " +
        "    , sum(case when T.HOL_TYPE is null and T.OT_TYPE='OT' then nvl(T.OT_TIME,0) else 0 end) ot_150 " +
        "    , sum(case when T.HOL_TYPE is null and T.OT_TYPE='NOT' and T.PAY_RATE=185 then nvl(T.OT_TIME,0) else 0 end) not_185 " +
        "    , sum(case when T.HOL_TYPE is null and T.OT_TYPE='NOT' and T.PAY_RATE=195 then nvl(T.OT_TIME,0) else 0 end) not_195 " +
        "    , sum(case when T.HOL_TYPE='SUN' and (T.OT_TYPE='HT' or T.OT_TYPE='OT' or T.OT_TYPE='NOT') then nvl(T.OT_TIME,0) else 0 end) st_200 " +
        "    , sum(case when T.HOL_TYPE='SUN' and (T.OT_TYPE='NHT') then nvl(T.OT_TIME,0) else 0 end) nst_270 " +
        "    , sum(case when T.HOL_TYPE='HOL' and T.OT_TYPE='HT' then nvl(T.OT_TIME,0) else 0 end) ht_200 " +
        "    , sum(case when T.HOL_TYPE='HOL' and T.OT_TYPE='OT' then nvl(T.OT_TIME,0) else 0 end) ht_300 " +
        "    , sum(case when T.HOL_TYPE='HOL' and T.OT_TYPE='NHT' then nvl(T.OT_TIME,0) else 0 end) nht_235 " +
        "    , sum(case when T.HOL_TYPE='HOL' and T.OT_TYPE='NOT' then nvl(T.OT_TIME,0) else 0 end) nht_300 " +
        "from thr_extra_time_ur t , thr_employee e " +
        "where T.DEL_IF=0 and E.DEL_IF=0 and e.pk=T.THR_EMP_PK " +
        "and e.emp_id like '%" + p_emp_id + "%' " +
        "and T.WORK_DT between '" + p_from_dt + "' and '" + p_to_dt + "'  " +
        " and T.WORK_DT between '" + p_from_dt + "' and  nvl( to_char(to_date( e.left_dt,'yyyymmdd')-1,'yyyymmdd'), '" + p_to_dt + "')" +
        "group by T.THR_EMP_PK) extra  " +
        ",(select D.THR_EMP_PK " +
        "        ,sum(case when nvl(F_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',D.THR_EMP_PK ),0)<0 then " +
        "        abs(F_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',D.THR_EMP_PK ))       " +
        "        else 0 " +
        "        end ) IN_LATE " +
        "        ,sum( case when nvl(F_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT, " +
        "        TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',D.THR_EMP_PK),0)<0 then " +
        "        abs(F_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT, " +
        "        TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',D.THR_EMP_PK)) " +
        "        else 0 " +
        "        end " +
        "        ) OUT_EARLY " +
        "from  THR_WORK_SHIFT C,THR_TIME_MACHINE_UR D, thr_employee e  " +
        "where C.DEL_IF=0 and e.del_if=0 and e.pk=d.thr_emp_pk " +
        "and D.DEL_IF=0 " +
        "and C.PK=D.THR_WS_PK                                                         " +
        "and D.HOL_TYPE is null " +
        "and e.emp_id like '%" + p_emp_id + "%' " +
        "and D.WORK_DT between '" + p_from_dt + "' and '" + p_to_dt + "'  " +
        " and d.WORK_DT between '" + p_from_dt + "' and  nvl( to_char(to_date( e.left_dt,'yyyymmdd')-1,'yyyymmdd'), '" + p_to_dt + "')" +
        "group by THR_EMP_PK ) late " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 and e.del_if=0 and c.pk=a.thr_group_pk " +
        "and a.thr_emp_pk=b.thr_emp_pk  and e.pk=a.thr_emp_pk " +
        "and a.work_mon = b.work_mon " +
        " and a.thr_emp_pk=late.thr_emp_pk(+)" +
        "and a.thr_emp_pk=extra.thr_emp_pk(+) "+
        "and a.thr_emp_pk=abs.thr_emp_pk(+) " +
        "and a.thr_emp_pk=wt.thr_emp_pk(+) " +
        "and a.work_mon='" + p_work_mon + "' " +
        "and b.work_mon='" + p_work_mon + "' " +
        "and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        "and decode('" + p_thr_group_pk + "','ALL','ALL',a.thr_group_pk)='" + p_thr_group_pk + "' " +
        "and a.emp_id like '%" + p_emp_id + "%' " + 
        "and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "' " +
        " and decode('" + p_times + "','ALL','ALL',nvl(a.times,' '))='" + p_times + "' " +
        " and decode('" + p_nation + "','ALL','ALL',nvl(e.nation,'01'))='" + p_nation + "' " +
        "order by a.dept_nm,a.emp_id " ;
    //Response.Write(SQL);
    //Response.End();   
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
	= "select substr(car_date,-2),hol_type " + 
        "from comm.tco_abcalendar  " +
        "where del_if=0 and car_date between '" + p_from_dt + "' and '" + p_to_dt + "' order by car_date ";
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
<link rel=File-List href="rpt_working_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_working_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_working_summary_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-08-12T04:30:21Z</o:LastPrinted>
  <o:Created>2008-08-12T02:55:49Z</o:Created>
  <o:LastSaved>2008-08-19T08:49:03Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.22in .2in .38in .2in;
	mso-header-margin:.24in;
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
.xl24
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;}
.xl25
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
	background:#99CCFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	color:navy;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl32
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
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	color:navy;
	font-size:30.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	color:navy;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;	
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	color:navy;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yyyy";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
      <x:Scale>43</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int icur_row;
        icur_row=5;
        string next_group,cur_group;
        for (int i=0;i<irow_emp-1;i++)
        {
            icur_row+=2;
            cur_group=dt_Emp.Rows[i][0].ToString();
            next_group=dt_Emp.Rows[i+1][0].ToString();
            if (next_group != cur_group)
            {
      %>
      <x:RowBreak>
       <x:Row><%=icur_row %></x:Row>
      </x:RowBreak>
      <%
            }
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
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2320 style='border-collapse:
 collapse;table-layout:fixed;width:1757pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=64 style='width:48pt'>
 <col width=159 style='mso-width-source:userset;mso-width-alt:5814;width:119pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt; display:none'>
 <col width=50 span="<%=iDate_Num%>" style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt; display:none'>
 <col width=56 span=24 style='mso-width-source:userset;mso-width-alt:2048;
 width:55pt'>

 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 width=42 style='height:24.75pt;width:32pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:6.75pt;width:93pt;height:62.25pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" o:title="vinagenuwin"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:9px;width:124px;
  height:83px'><img width=124 height=83
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=33 width=42 style='height:24.75pt;width:32pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=102 style='width:77pt'></td>
  <td class=xl31 colspan=2 width=223 style='mso-ignore:colspan;width:167pt'><% = dt_Com.Rows[0][0].ToString()%></td>
  <td width=66 style='width:50pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=74 style='width:56pt'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 colspan=2 style='height:31.5pt;mso-ignore:colspan'></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'><% = dt_Com.Rows[0][1].ToString()%></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl33>BẢNG KÝ NHẬN CÔNG(WORKING SUMMARY)<% if (p_tco_dept_pk!="ALL") 
                                     Response.Write(" - " + p_dept_nm); %></td>
  <td colspan=22 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 colspan=2 style='height:24.75pt;mso-ignore:colspan'></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span></td>
  <td colspan=14 style='mso-ignore:colspan'></td>
  <td class=xl34>Month:</td>
  <td colspan=2 class=xl47 width=100 style='width:76pt' x:num><%=dt_Com.Rows[0][4].ToString()%></td>
  <td colspan=21 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl25 style='height:27.0pt;font-style:italic;'>No.</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Group</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Emp ID</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Full Name</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Join Date</td>
  <td class=xl32 style='border-left:none;font-style:italic;'>Note</td>
   <%
    for (int j = 0; j < iDate_Num; j++) 
    {
   %>
  <td rowspan=2 class=xl45 style='border-bottom:.5pt solid black;font-style:italic;' x:num><%= dt_Cal.Rows[j][0].ToString() %></td>
  <%
    }
   %>
  <td class=xl26 rowspan=2 style='border-left:none;font-style:italic;mso-pattern:auto none;white-space:normal;'>Công ngày</td>  
  <td class=xl26 rowspan=2 style='font-style:italic;mso-pattern:auto none;white-space:normal;'>Công đêm</td>
  <td class=xl26 rowspan=2 style='font-style:italic;mso-pattern:auto none;white-space:normal;'>Tổng công làm</td>
  <td class=xl26 colspan="5" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>Nghỉ có lương</td>
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>Tổng hưởng lương</td>
  <td class=xl26 colspan="4" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>Nghỉ không lương</td>
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>Tổng không lương</td>
  <!--<td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>OT 150%</td>
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>NOT 185%</td>
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>NOT 195%</td>
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>ST 200%</td>
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>NST 270%</td>
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>HT 200%</td>
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>OHT 300%</td>
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>NHT 235%</td>
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>NOHT 300%</td> -->
  <td class=xl26 rowspan="2" style='font-style:italic;mso-pattern:auto none;white-space:normal;'>Đi trễ-Về sớm</td>
  <td class=xl29 style='font-style:italic;'>Sign</td>
 </tr>
 <tr class=xl24 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl25 style='height:27.0pt;font-style:italic;'>STT</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Nhóm</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Mã s&#7889;</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>H&#7885; và tên</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Ngày vào</td>
  <td class=xl32 style='border-left:none;font-style:italic;'>Ghi chú</td>
  <!--<td class=xl26 style='border-top:none;border-left:none;font-style:italic;'>(100%)</td>  
  <td class=xl26 style='border-top:none;font-style:italic;mso-pattern:auto none;white-space:normal;'>Đêm (35%)</td>-->
  <td class=xl26 style='border-top:none;font-style:italic;mso-pattern:auto none;white-space:normal;'>Hội thao cty</td>
  <td class=xl26 style='border-top:none;font-style:italic;mso-pattern:auto none;white-space:normal;'>Phép năm</td>
  <td class=xl26 style='border-top:none;font-style:italic;'>Cưới</td>
  <td class=xl26 style='border-top:none;font-style:italic;'>Tang</td>
  <td class=xl26 style='border-top:none;font-style:italic;'>TNLĐ</td>
  <td class=xl26 style='border-top:none;font-style:italic;'>Phép</td>
  <td class=xl26 style='border-top:none;font-style:italic;mso-pattern:auto none;white-space:normal;'>Không phép</td>
  <td class=xl26 style='border-top:none;font-style:italic;'>Khác</td>
  <td class=xl26 style='border-top:none;font-style:italic;'>Bệnh</td>
  <td class=xl29 style='border-top:none;font-style:italic;'>Ch&#7919; ký</td>
 </tr>
  <% 
   
    for (int i = 0; i < irow_emp; i++) 
    {
    %> 
 <tr class=xl27 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black'><%= i+1 %></td>
  <td rowspan=2 class=xl48 width=102 style='border-bottom:.5pt solid black; 
  width:77pt'><%= dt_Emp.Rows[i][0].ToString() %></td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black'><%= dt_Emp.Rows[i][1].ToString() %></td>
  <td rowspan=2 class=xl48 width=159 style='border-bottom:.5pt solid black;
  width:119pt'><%= dt_Emp.Rows[i][2].ToString() %></td>
  <td rowspan=2 class=xl51 style='border-bottom:.5pt solid black' x:num><%= dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl35 style='border-left:none;font-style:italic;'>WT(H)</td>
  <%
    for (int j = 0; j < iDate_Num; j++) 
    {
        string sformat;
        if (dt_Cal.Rows[j][1].ToString()=="HOL")
            sformat=";background:#FF99CC;mso-pattern:auto none;";
        else if (dt_Cal.Rows[j][1].ToString()=="SUN")
            sformat=";background:#CCFFFF;mso-pattern:auto none;";
        else
        
            sformat="";
   %>
  <td class=xl37 style='border-top:none<%=sformat %>' x:num ><%= dt_Emp.Rows[i][j+4].ToString() %></td>
  <%
    }//end of "for" of WT 
   %>
  <td rowspan=2 class=xl43 align=center style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][66].ToString() %></td>  
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][68].ToString() %></td>
  
  
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num>
  <%= double.Parse(dt_Emp.Rows[i][68].ToString()) + double.Parse(dt_Emp.Rows[i][66].ToString())%></td>


  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][69].ToString() %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][70].ToString() %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][71].ToString() %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][72].ToString() %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][73].ToString() %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][74].ToString() %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][75].ToString() %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][76].ToString() %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][77].ToString() %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][78].ToString() %></td>
  
 
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][79].ToString() %></td>

  <!--<td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][80].ToString() %><%//OT  %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num>fff<%= dt_Emp.Rows[i][81].ToString() %><%//OT  %></td>  
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][82].ToString() %><%//OT  %></td>  
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][83].ToString() %><%//OT  %></td>  
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][84].ToString() %><%//OT  %></td>  
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][85].ToString() %><%//OT  %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][86].ToString() %><%//OT  %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][87].ToString() %><%//OT  %></td>
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][88].ToString() %><%//OT  %></td>
  -->
  
  <td rowspan=2 class=xl43 align=center  style='border-bottom:.5pt solid black;border-top:
  none;mso-number-format:"_\(* \#\,\#\#0\_\)\;_\(* \\\(\#\,\#\#0\\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";' x:num><%= dt_Emp.Rows[i][89].ToString() %><%//OT  %></td>
  <td rowspan=2 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
 </tr>
 <tr class=xl27 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl39 style='height:31.5pt;border-top:none;border-left:
  none;font-style:italic;'>OT(H)</td>
  <%
    for (int j = 0; j < iDate_Num; j++) 
    {
         string sformat;
        if (dt_Cal.Rows[j][1].ToString()=="HOL")
            sformat=";background:#FF99CC;mso-pattern:auto none;";
        else if (dt_Cal.Rows[j][1].ToString()=="SUN")
            sformat=";background:#CCFFFF;mso-pattern:auto none;";
        else
        
            sformat="";
    
   %>
  <td class=xl41 style='border-top:none<%=sformat %>' x:num><%= dt_Emp.Rows[i][j+35].ToString() %></td>
  <%
    } //end of "for" of OT 
   %>
 </tr>
 <%
    } //end of "for" of employee 
  %>
 
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
