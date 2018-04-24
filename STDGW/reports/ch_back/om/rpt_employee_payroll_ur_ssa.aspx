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
    
    string p_dept, p_group, p_status, p_type, p_pay_type, p_emp_id, p_work_mon, p_m_type, p_times, p_emp_type, p_from_leftdate, p_to_leftdate; 
     
  
    p_dept       = Request["l_dept"].ToString();
    p_group      = Request["l_group"].ToString();
    p_status      = Request["l_status"].ToString();
    p_type       = Request["l_type"].ToString();
    p_pay_type   = Request["l_pay_type"].ToString();
    p_emp_id     = Request["l_emp_id"].ToString();
    p_work_mon   = Request["l_work_mon"].ToString();
    p_times = Request["l_Times_r"].ToString();
    //p_emp_type = Request["l_Emp_Type"].ToString();
    p_m_type = Request.QueryString["l_m_type"].ToString();
    //p_from_leftdate = Request["l_from_leftdate"].ToString();
    //p_to_leftdate = Request["l_to_leftdate"].ToString();
    
    
  string SQL
= "select to_char(to_date(s.work_mon,'yyyymm'),'MON-YYYY') || ' - THÁNG ' || to_char(to_date(s.work_mon,'yyyymm'),'MM-YYYY') ,S.EMP_ID, S.FULL_NAME,S.DEPT_NM " +
   "        , to_char(to_date(S.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') join_dt " +
   "        , to_char(to_date(S.LEFT_DT,'yyyymmdd'),'dd/mm/yyyy') left_dt " +
   "        ,case when nvl(S.CONFIRM_DT,S.FROM_DT) between S.FROM_DT and S.TO_DT then  round(S.SAL_WITH_WT_L2,5) " +
   "                when nvl(S.CONFIRM_DT,S.FROM_DT) > S.TO_DT then  round(S.SAL_WITH_WT_L1,5) " +
   "                else round(S.SAL_WITH_WT_L2,5) " +
   "         end " +
   "        , 100000  " +
   "        ,round(nvl(M.ALLOW_AMT1,0),5) res_full  " +
   "        ,round(nvl(M.ALLOW_AMT2,0),5) job_full " +
   "        ,200000 " +
   "        ,round( case when nvl(S.CONFIRM_DT,S.FROM_DT) between S.FROM_DT and S.TO_DT then  round(S.SAL_WITH_WT_L2,5) " +
   "                when nvl(S.CONFIRM_DT,S.FROM_DT) > S.TO_DT then  round(S.SAL_WITH_WT_L1,5) " +
   "                else round(S.SAL_WITH_WT_L2,5) " +
   "         end " +
   "        + 100000 + nvl(M.ALLOW_AMT1,0)+ nvl(M.ALLOW_AMT2,0) +200000,5) total_sal   " +
   "        ,round( nvl(S.WT_L1,0)/8+nvl(S.WT_L2,0)/8+nvl(S.HOL_DAY_L1,0)+nvl(S.HOL_DAY_L2,0)+nvl(S.TOTAL_ABS_PAY_L1,0)/8+nvl(S.TOTAL_ABS_PAY_L2,0)/8,5) WD  " +
   "        ,round( nvl(S.WT_L1,0)+nvl(S.WT_L2,0)+nvl(S.HOL_DAY_L1,0)*8+nvl(S.HOL_DAY_L2,0)*8+nvl(S.TOTAL_ABS_PAY_L1,0)+nvl(S.TOTAL_ABS_PAY_L2,0),5) WT " +
   "        ,round( 0 ,5) late_early " +
   "        ,round(nvl(S.TOTAL_ABS_NPAY_L1,0)/8+nvl(S.TOTAL_ABS_NPAY_L2,0)/8,5) abs_npay " +
   "        ,round( nvl(S.OT_L1,0)+nvl(S.OT_L2,0),5) ot_150 " +
   "        ,round( nvl(S.NOT_185_L1,0)+nvl(S.NOT_185_L2,0),5) not_185 " +
   "        ,round( nvl(S.NOT_195_L1,0)+nvl(S.NOT_195_L2,0),5) not_195 " +
   "        ,round( nvl(S.ST_L1,0)+nvl(S.ST_L2,0)+nvl(S.OST_L1,0)+nvl(S.OST_L2,0)+nvl(S.NOST_L1,0)+nvl(S.NOST_L2,0),5) st_ost_nost_200 " +
   "        ,round( nvl(S.NST_L1 ,0)+nvl(S.NST_L2,0),5) nst_270 " +
   "        ,round( nvl(S.HT_L1,0)+nvl(S.HT_L2,0),5) ht_200 " +
   "        ,round( nvl(S.NHT_L1,0)+nvl(S.NHT_L2,0),5) nht_235 " +
   "        ,round( nvl(S.OHT_L1,0)+nvl(S.OHT_L2,0)+nvl(S.NOHT_L1,0)+nvl(S.NOHT_L2,0),5) oht_noht_300 " +
   "        ,round( nvl(S.OT_L1,0)+nvl(S.OT_L2,0)+ nvl(S.NOT_185_L1,0)+nvl(S.NOT_185_L2,0) " +
   "        + nvl(S.NOT_195_L1,0)+nvl(S.NOT_195_L2,0)+ nvl(S.ST_L1,0)+nvl(S.ST_L2,0) " +
   "            +nvl(S.OST_L1,0)+nvl(S.OST_L2,0)+ nvl(S.NST_L1 ,0)+nvl(S.NST_L2,0)+nvl(S.NOST_L1,0)+nvl(S.NOST_L2,0) " +
   "            + nvl(S.HT_L1,0)+nvl(S.HT_L2,0)+ nvl(S.NHT_L1,0)+nvl(S.NHT_L2,0) " +
   "            + nvl(S.OHT_L1,0)+nvl(S.OHT_L2,0)+nvl(S.NOHT_L1,0)+nvl(S.NOHT_L2,0),5) total_ot " +
   "        ,round(nvl(s.wt_l1_amt,0)+nvl(s.wt_l2_amt,0)+nvl(S.TOTAL_ABS_PAY_L1_AMT,0)+nvl(S.TOTAL_ABS_PAY_L2_AMT,0) " +
   "            +nvl(S.HOL_DAY_L1_AMT ,0)+nvl(S.HOL_DAY_L2_AMT ,0),5) wt_ot_amt " +
   "        ,round(nvl(S.NT_30_L1_AMT ,0)+nvl(S.NT_30_L2_AMT ,0),5) nt_35_amt " +
   "        ,round( nvl(S.ALLOW_K4_AMT,0),5) ot_allow_amt  " +
   "        ,round( nvl(S.OT_L1_AMT ,0)+nvl(S.OT_L2_AMT ,0) ,5)ot_150_amt " +
   "        ,round(nvl(S.NOT_185_L1_AMT ,0)+nvl(S.NOT_185_L2_AMT ,0),5) not_185_amt " +
   "        ,round(nvl(S.NOT_195_L1_AMT ,0)+nvl(S.NOT_195_L2_AMT ,0),5) not_195_amt " +
   "        ,round(nvl(S.ST_L1_AMT ,0)+nvl(S.ST_L2_AMT ,0)+nvl(S.OST_L1_AMT ,0)+nvl(S.OST_L2_AMT ,0)+nvl(S.NOST_L1_AMT ,0)+nvl(S.NOST_L2_AMT ,0),5) st_ost_nost_200_amt " +
   "        ,round(nvl(S.NST_L1_AMT ,0)+nvl(S.NST_L2_AMT ,0),5) nst_270_amt " +
   "        ,round(nvl(S.HT_L1_AMT ,0)+nvl(S.HT_L2_AMT ,0),5) ht_200_amt " +
   "        ,round(nvl(S.NHT_L1_AMT ,0)+nvl(S.NHT_L2_AMT ,0),5) nht_235_amt " +
   "        ,round(nvl(S.OHT_L1_AMT ,0)+nvl(S.OHT_L2_AMT ,0)+nvl(S.NOHT_L1_AMT ,0)+nvl(S.NOHT_L2_AMT ,0),5) noht_300_amt " +
   "        ,round(nvl(s.wt_l1_amt,0)+nvl(s.wt_l2_amt,0)+nvl(S.TOTAL_ABS_PAY_L1_AMT,0)+nvl(S.TOTAL_ABS_PAY_L2_AMT,0) " +
   "            +nvl(S.TOTAL_OT_L1_AMT ,0)+nvl(S.TOTAL_OT_L2_AMT ,0) +nvl(S.HOL_DAY_L1_AMT ,0)+nvl(S.HOL_DAY_L2_AMT ,0)+nvl(S.ALLOW_K4_AMT,0),5) wt_ot_amt " +
   "        ,round(nvl(S.ALLOW_K2_AMT,0),5) deligent_amt " +
   "        ,round(nvl(S.ALLOW_AMT1,0),5) res_amt            " +
   "        ,round(nvl(S.ALLOW_K5_AMT,0),5) ins_prob " +
   "        ,round(nvl(S.ALLOW_AMT2,0),5) job_amt " +
   "        ,round(nvl(S.ALLOW_K1_AMT,0),5) live_amt " +
   "        ,round(nvl(S.RETURN_AMT,0) + nvl(S.RETURN_NO_PIT,0)-nvl(business_amt,0)+nvl(adj_unreal,0) ,5) return_amt " +
   "        ,round(nvl(S.ALLOW_K3_AMT,0),5) senior_amt " +
   "        ,round(nvl(S.GROSS_AMT,0),5) gross_amt " +
   "        ,round(nvl(S.OT_TAX_L1_AMT,0) + nvl(S.OT_TAX_L2_AMT,0),5) ot_tax_amt " +
   "        ,round(nvl(S.DEDUCT_PIT,0),5) deduct_pit " +
   "        ,round(nvl(S.INCOME_BEFORE_TAX,0),5)          " +
   "        ,round(nvl(S.SOCIAL_AMT,0),5) " +
   "        ,round(nvl(S.HEALTH_AMT,0),5) " +
   "        ,round(nvl(S.UNEMP_INS,0),5) " +
   "        ,round(nvl(S.UNION_AMT,0),5) " +
   "        ,round(nvl(S.INCOME_TAX,0),5) " +
   "        ,round(nvl(s.HEALTH_CARD_AMT,0)+nvl(deduct_health_card,0),5) " +
   "        ,round(nvl(S.ADVANCE_AMT,0)+nvl(S.ADVANCE_NO_PIT,0) -nvl(deduct_health_card,0) ,5) adv_amt " +
   "        ,round(nvl(S.NET_AMT,0),5)         " +
   "        ,round(nvl(adj.sickness_amt,0) ,5) sickness_amt         " +
   "        ,round(nvl(adj.business_amt,0) ,5) business_amt         " +
   "        ,round(nvl(S.NET_AMT,0)+nvl(adj.sickness_amt,0)-nvl(adj.business_amt,0)  ,5) ,s.seq        " +
   "from thr_month_salary_ur s, comm.tco_org b, thr_work_group c, thr_salary_manage m " +
   ",(select thr_emp_pk,  sum(decode(TS.ADJ_TYPE,'04',nvl(TS.ADJ_AMT,0),0)) sickness_amt,sum(decode(TS.ADJ_TYPE,'05',nvl(TS.ADJ_AMT,0),0)) business_amt " +
   ",    sum(decode(TS.ADJ_TYPE,'06',nvl(TS.ADJ_AMT,0),0)) deduct_health_card    " +
   ",    sum(decode(TS.ADJ_TYPE,'07',nvl(TS.ADJ_AMT,0),0)) adj_unreal    " +
        "from thr_salary_adjustment ts " +
        "where TS.DEL_IF=0 " +
        "and TS.ADJ_DT between '" + p_work_mon + "01' and to_char(last_day(to_date('" + p_work_mon + "','yyyymm')),'yyyymmdd') " +
        "and TS.ADJ_TYPE in ('04','05','06','07') " +
        "group by TS.THR_EMP_PK) adj " + 
        "where s.del_if=0 and s.work_mon='" + p_work_mon + "' " +
        " and b.del_if=0 and c.del_if=0 and s.tco_dept_pk=b.pk and s.thr_group_pk=c.pk" +
        " and s.thr_emp_pk=adj.thr_emp_pk(+) " +
        " and (s.tco_dept_pk in ( " +
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
        " and decode('" + p_group + "','ALL','ALL',s.thr_group_pk)='" + p_group + "'" +
        " and s.emp_id like '%" + p_emp_id + "%' " +
        //" and ('" + p_from_leftdate + "' is null or '" + p_to_leftdate + "' is null or s.left_dt between '" + p_from_leftdate + "' and '" + p_to_leftdate + "')" +
        " and decode('" + p_status + "','ALL','ALL',s.status)='" + p_status + "'" +
        " and decode('" + p_pay_type + "','ALL','ALL',s.pay_type)='" + p_pay_type + "'" +
        //" and decode('" + p_emp_type + "','ALL','ALL',s.Employee_Type)='" + p_emp_type + "'" +
        " and decode('" + p_m_type + "','ALL','ALL',s.MONEY_KIND)='" + p_m_type + "'" +
        " and decode('" + p_times + "','ALL','ALL',s.times)='" + p_times + "'" +
        " and nvl(s.net_amt,0) " + p_type +
       " and M.DEL_IF=0 " +
       " and S.THR_EMP_PK=M.THR_EMP_PK " +
       " and M.WORK_MON=S.WORK_MON " +
       " and S.WORK_MON='"+p_work_mon+"' order by nvl(b.seq,0),S.DEPT_NM , S.EMP_ID ";


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

    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_employee_payroll_ssa_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_payroll_ssa_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_payroll_ssa_files/oledata.mso">
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
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2011-09-17T04:15:48Z</o:LastPrinted>
  <o:Created>2011-09-07T07:13:36Z</o:Created>
  <o:LastSaved>2011-09-17T09:31:35Z</o:LastSaved>
  <o:Company>HOME</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.44in .22in .28in .19in;
	mso-header-margin:.31in;
	mso-footer-margin:.18in;
	mso-page-orientation:landscape;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font10
	{color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font11
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font15
	{color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font16
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font17
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font18
	{color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font19
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font20
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font21
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font22
	{color:black;
	font-size:8.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font23
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.font26
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style22
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:32B12;}
.style44
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
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
.style57
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-protection:locked visible;
	mso-style-name:Normal_PAYROLL;}
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
.xl67
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl70
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl71
	{mso-style-parent:style22;
	font-size:70.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	background:white;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style22;
	font-size:26.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl75
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt solid blue;}
.xl76
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;}
.xl77
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border:.5pt dashed blue;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl79
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl80
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl81
	{mso-style-parent:style22;
	font-size:24.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style22;
	font-size:16.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt dashed blue;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl87
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl88
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl89
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl90
	{mso-style-parent:style44;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl91
	{mso-style-parent:style57;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl92
	{mso-style-parent:style57;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:none;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl93
	{mso-style-parent:style57;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl94
	{mso-style-parent:style57;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl95
	{mso-style-parent:style57;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl96
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt solid blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl97
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl98
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl99
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl100
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl101
	{mso-style-parent:style57;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl102
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl103
	{mso-style-parent:style44;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl104
	{mso-style-parent:style57;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl105
	{mso-style-parent:style57;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl106
	{mso-style-parent:style44;
	color:black;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl107
	{mso-style-parent:style22;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl108
	{mso-style-parent:style57;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl109
	{mso-style-parent:style57;
	color:black;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl110
	{mso-style-parent:style22;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl111
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl112
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl113
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl114
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt dashed blue;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl115
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt dashed blue;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl116
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt dashed blue;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl117
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl118
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl119
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt solid blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt solid blue;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl121
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt solid blue;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dashed blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt solid blue;
	border-left:.5pt dashed blue;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid blue;
	border-right:.5pt dashed blue;
	border-bottom:.5pt dashed blue;
	border-left:.5pt solid blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;}
.xl125
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl126
	{mso-style-parent:style57;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt dashed blue;
	background:aqua;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>SSA Payroll</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>21</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
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
       <x:ActiveRow>5</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
       <x:RangeSelection>$A$6:$F$6</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8505</x:WindowHeight>
  <x:WindowWidth>20115</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='SSA Payroll'!$A$4:$BF$4</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='SSA Payroll'!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1085"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl69>

<table x:str border=0 cellpadding=0 cellspacing=0 width=4808 style='border-collapse:
 collapse;table-layout:fixed;width:3619pt'>
 <col class=xl69 width=45 span=3 style='mso-width-source:userset;mso-width-alt:
 1645;width:34pt'>
 <col class=xl69 width=187 style='mso-width-source:userset;mso-width-alt:6838;
 width:140pt'>
 <col class=xl69 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <col class=xl70 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl74 width=89 span=6 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl74 width=61 span=2 style='mso-width-source:userset;mso-width-alt:
 2230;width:46pt'>
 <col class=xl74 width=61 span=1 style='mso-width-source:userset;mso-width-alt:
 2230;width:46pt; display:none;'>
 <col class=xl74 width=61 span=10 style='mso-width-source:userset;mso-width-alt:
 2230;width:46pt'>
 <col class=xl74 width=89 span=33 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl74 width=89 span=1 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt; display:none'>
 <col class=xl74 width=89 span=2 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>

 <tr class=xl67 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl67 width=45 style='height:27.75pt;width:34pt'>&nbsp;</td>
  <td colspan=53 class=xl81 width=4407 style='width:3317pt'>SALARY REPORT -
  BẢNG LƯƠNG CHI TIẾT</td>
  <td class=xl71 width=89 style='width:67pt'>&nbsp;</td>
  <td class=xl72 width=89 style='width:67pt'>&nbsp;</td>
  <td class=xl72 width=89 style='width:67pt'>&nbsp;</td>
  <td class=xl68 width=89 style='width:67pt'></td>
 </tr>
 <tr class=xl67 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl67 style='height:18.0pt'>&nbsp;</td>
  <td colspan=53 class=xl82><%=dt_Emp.Rows[0][0].ToString() %></td>
  <td class=xl73>&nbsp;</td>
  <td colspan=2 class=xl72 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl68></td>
 </tr>
 <tr class=xl78 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td rowspan=2 height=107 class=xl124 style='height:80.25pt'>Seq.</td>
  <td rowspan=2 height=107 class=xl124 style='height:80.25pt'>No.</td>
  <td rowspan=2 class=xl86 width=45 style='width:34pt;border-right:.5pt dashed blue;'><font class="font16">Code</font><font
  class="font9"><br>
    </font><font class="font14">Mã số</font></td>
  <td rowspan=2 class=xl86 width=187 style='width:140pt'><font class="font16">Name</font><font
  class="font9"><br>
    </font><font class="font14">Họ và tên</font></td>
  <td rowspan=2 class=xl86 width=145 style='width:109pt'><font class="font16">Section</font><font
  class="font9"><br>
    </font><font class="font14">Bộ phận</font></td>
  <td rowspan=2 class=xl87 width=75 style='width:56pt'><font class="font16">Join
  date</font><font class="font9"><br>
    </font><font class="font14">Ngày vào làm</font></td>
  <td rowspan=2 class=xl87 width=75 style='width:56pt'><font class="font16">Left
  date</font><font class="font9"><br>
    </font><font class="font14">Ngày nghỉ việc</font></td>
  <td colspan=5 class=xl88 width=445 style='border-left:none;width:335pt'><font
  class="font16">Basic Salary and Allowances' Details</font><font class="font7"><br>
    </font><font class="font26">Chi tiết các khoản tiền lương và phụ cấp</font></td>
  <td rowspan=2 class=xl89 width=89 style='width:67pt'><font class="font17">Total
  salary</font><font class="font9"><br>
    </font><font class="font14">Tổng lương</font></td>
  <td colspan=4 class=xl90 width=244 style='border-left:none;width:184pt'><font
  class="font16">Attended Days</font><font class="font7"> - </font><font
  class="font26">Ngày công</font></td>
  <td colspan=8 class=xl91 width=549 style='border-left:none;width:414pt'><font
  class="font16">Overtime Status</font><font class="font7"> - </font><font
  class="font26">Thời gian làm tăng ca</font></td>
  <td rowspan=2 class=xl92 width=61 style='border-bottom:.5pt dashed blue;
  width:46pt'><font class="font17">Total of OT</font><font class="font9"><br>
    </font><font class="font14">Tổng cộng tăng ca</font><font class="font9"><br>
    </font></td>
  <td colspan=11 class=xl93 style='border-left:none'><font class="font16">Working
  Salary</font><font class="font7"> -</font><font class="font26"> Tổng lương
  làm việc thực tế</font></td>
  <td rowspan=2 class=xl89 width=89 style='width:67pt'><font class="font17">Total
  <br>
    Salary</font><font class="font9"><br>
    </font><font class="font14">TỔNG CỘNG</font></td>
  <td colspan=8 class=xl91 width=623 style='border-left:none;width:469pt'><font
  class="font16">Allowance</font><font class="font7"> - </font><font
  class="font26">Phụ cấp</font></td>
  <td rowspan=2 class=xl94 width=89 style='width:67pt'><font class="font17">Total
  Income</font><font class="font9"><br>
    </font><font class="font14">Tổng thu nhập</font></td>
  <td rowspan=2 class=xl95 width=89 style='width:67pt'><font class="font10">OverTime
  Tax</font><font class="font11"><br>
    </font><font class="font15">Tăng ca tính thuế</font></td>
  <td rowspan=2 class=xl95 width=89 style='width:67pt'><font class="font10">Relation
  Deduction</font><font class="font11"><br>
    </font><font class="font15">Giảm trừ gia cảnh<br>
    và bản thân</font></td>
  <td rowspan=2 class=xl95 width=89 style='width:67pt'><font class="font10">Income
  Pay Tax</font><font class="font11"><br>
    </font><font class="font15">Thu nhập tính thuế</font></td>
  <td colspan=7 class=xl91 width=623 style='border-left:none;width:469pt'><font
  class="font16">Deduct - </font><font class="font26">Khấu trừ</font></td>
  <td rowspan=2 class=xl117 width=89 style='width:67pt'>Net Amt 1<font
  class="font7"><br>
    </font><font class="font26">Thực lãnh</font></td>
  <td rowspan=2 class=xl117 width=89 style='width:67pt'>Sickness Amt<font
  class="font7"><br>
    </font><font class="font26">Tiền ốm đau</font></td>
  <td rowspan=2 class=xl117 width=89 style='width:67pt'>Business Amt<font
  class="font7"><br>
    </font><font class="font26">Công tác phí</font></td>
  <td rowspan=2 class=xl117 width=89 style='width:67pt'>Net Amt 2<font
  class="font7"><br>
    </font><font class="font26">Thực lãnh</font></td> 
  <td rowspan=2 class=xl119 width=89 style='width:67pt'>Sign<font class="font17"><br>
    </font><font class="font14">Kí tên</font></td>
 </tr>
 <tr class=xl78 height=71 style='mso-height-source:userset;height:53.25pt'>
  <td height=71 class=xl100 id="_x0000_s1031" x:autofilter="all" width=89
  style='height:53.25pt;border-top:none;border-left:none;width:67pt'><font
  class="font18">Basic salary</font><font class="font19"><br>
    </font><font class="font20">Lương cơ bản</font></td>
  <td class=xl101 id="_x0000_s1032" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Diligence</font><font
  class="font19"><br>
    </font><font class="font20">Chuyên cần</font></td>
  <td class=xl101 id="_x0000_s1033" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Responsibility</font><font
  class="font19"><br>
    </font><font class="font20">Trách nhiệm</font></td>
  <td class=xl101 id="_x0000_s1034" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Job
  Amt</font><font class="font19"><br>
    </font><font class="font20">Phụ cấp công việ</font><font class="font19">c</font></td>
  <td class=xl101 id="_x0000_s1035" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Living
  Amt</font><font class="font19"><br>
    <span style='mso-spacerun:yes'> </span></font><font class="font20">Phụ cấp
  sinh hoạt</font></td>
  <td class=xl103 id="_x0000_s1037" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font18">Working
  days</font><font class="font19"><br>
    </font><font class="font20">Ngày công</font></td>
  <td class=xl103 id="_x0000_s1038" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font18">Working
  Hours</font><font class="font19"><br>
    </font><font class="font20">Giờ công</font></td>
  <td class=xl103 id="_x0000_s1039" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font18">Full-
  Paid leave</font><font class="font19"><br>
    </font><font class="font20">Nghỉ có lương</font></td>
  <td class=xl103 id="_x0000_s1040" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font18">Absence<br>
    no pay</font><font class="font19"><br>
    </font><font class="font20">Nghỉ không lương</font></td>
  
  <td class=xl104 id="_x0000_s1042" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font22">OT
  150</font><font class="font21"><br>
    </font><font class="font23">Tca, ca ngày<br>
    (14h -18h)<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl104 id="_x0000_s1043" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font22">NOT
  185</font><font class="font21"><br>
    </font><font class="font23">Tca, ca đêm<br>
    (18h -22h)<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl104 id="_x0000_s1044" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font22">NOT
  195</font><font class="font21"><br>
    </font><font class="font23">Tăng ca sau 22h</font><font class="font21"><br>
    </font></td>
  <td class=xl104 id="_x0000_s1045" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font22">ST
  200</font><font class="font21"><br>
    </font><font class="font23">Tca CN<br>
    (6h -22h)<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl101 id="_x0000_s1046" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font18">NST
  270</font><font class="font19"><br>
    </font><font class="font20">Đêm CN<br>
    (22h-6h)<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl101 id="_x0000_s1047" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font18">HT
  200 </font><font class="font19"><br>
    </font><font class="font20">Tăng ca ngày lễ</font></td>
  <td class=xl101 id="_x0000_s1048" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font18">NHT
  235</font><font class="font19"><br>
    </font><font class="font20">Tăng ca ngày lễ</font></td>
  <td class=xl101 id="_x0000_s1049" x:autofilter="all" width=61
  style='border-top:none;border-left:none;width:46pt'><font class="font18">OHT-NOHT
  300</font></td>
  <td class=xl101 id="_x0000_s1051" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Daily,Leave/
  Wage</font><font class="font19"><br>
    </font><font class="font20">Tiền công &amp;<br>
    nghỉ có lương</font></td>
  <td class=xl101 id="_x0000_s1052" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">NT
  35</font><font class="font19"><br>
    </font><font class="font20">Trợ cấp làm đêm</font></td>
  <td class=xl101 id="_x0000_s1053" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">OT
  Allowance</font><font class="font19"><br>
    </font><font class="font20">Trợ cấp tăng ca</font></td>
  <td class=xl104 id="_x0000_s1054" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font22">OT
  150</font><font class="font21"><br>
    </font><font class="font23">Tiền tăng ca, ca ngày</font><font class="font21"><br>
    </font></td>
  <td class=xl106 id="_x0000_s1055" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font22">NOT
  185</font><font class="font21"><br>
    <span style='mso-spacerun:yes'> </span></font><font class="font23">Tiền
  tăng ca ,ca đêm</font><font class="font21"><br>
    </font></td>
  <td class=xl104 id="_x0000_s1056" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font22">NOT
  195</font><font class="font21"><br>
    </font><font class="font23">Tăng ca sau 22h</font><font class="font21"><br>
    </font></td>
  <td class=xl104 id="_x0000_s1057" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font22">ST
  200</font><font class="font21"><br>
    </font><font class="font23">Tiền ngày chủ nhật</font></td>
  <td class=xl101 id="_x0000_s1058" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">NST
  270</font><font class="font19"><br>
    </font><font class="font20">Tăng ca đêm ngày chủ nhật</font><font
  class="font19"><br>
    </font></td>
  <td class=xl101 id="_x0000_s1059" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><span
  style='mso-spacerun:yes'> </span><font class="font18">HT 200</font><font
  class="font19"><br>
    </font><font class="font20">Làm việc ngày lễ</font></td>
  <td class=xl101 id="_x0000_s1060" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><span
  style='mso-spacerun:yes'> </span><font class="font18">NHT 235</font><font
  class="font19"><br>
    </font><font class="font20">Làm việc ngày lễ</font></td>
  <td class=xl126 id="_x0000_s1061" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'>OHT-NOHT 300<font
  class="font19"><br>
    </font><font class="font20">Làm việc ngày lễ</font></td>
  <td class=xl101 id="_x0000_s1063" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Diligence</font><font
  class="font19"><br>
    </font><font class="font20">Chuyên cần</font></td>
  <td class=xl101 id="_x0000_s1064" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Responsibility</font><font
  class="font19"><br>
    </font><font class="font20">Trách nhiệm</font></td>
  <td class=xl101 id="_x0000_s1065" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Pay
  20% insurance</font><font class="font19"><br>
    </font><font class="font20">Trả 20% BH trong thgian t.việc</font></td>
  <td class=xl101 id="_x0000_s1066" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Job
  Allowance</font><font class="font19"><br>
    </font><font class="font20">Phụ cấp công việc</font></td>
  <td class=xl101 id="_x0000_s1067" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Living
  Allowance</font><font class="font19"><br>
    </font><font class="font20">Phụ cấp sinh hoạt</font></td>
  <td class=xl101 id="_x0000_s1068" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Return</font><font
  class="font19"><br>
    </font><font class="font20">Hoàn trả</font></td>

  

  <td class=xl101 id="_x0000_s1069" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Long
  time working bonus</font><font class="font19"><br>
    </font><font class="font20">Thưởng thâm niên</font></td>
  
  
  <td class=xl101 id="Td1" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Bussiness fee</font><font class="font19"><br>
    </font><font class="font20">Phí công tác</font></td>


  <td class=xl100 id="_x0000_s1074" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">SOCIAL
  INS</font><font class="font19"><br>
    </font><font class="font20">BHXH</font></td>
  <td class=xl100 id="_x0000_s1075" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">MEDICAL.
  INS</font><font class="font19"><br>
    </font><font class="font20">BHYT</font></td>
  <td class=xl100 id="_x0000_s1076" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Unemployment
  INS</font><font class="font19"><br>
    </font><font class="font20">BH Thất Nghiệp</font></td>
  <td class=xl100 id="_x0000_s1077" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">UNION</font><font
  class="font19"><br>
    </font><font class="font20">Công đoàn</font></td>
  <td class=xl100 id="_x0000_s1078" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">INCOME
  TAX</font><font class="font19"><br>
    </font><font class="font20">Thuế thu nhập</font></td>
  <td class=xl100 id="_x0000_s1079" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">Trừ
  BHYT</font><font class="font19"><br>
    </font><font class="font20">(với người nghỉ việc)</font></td>
  <td class=xl100 id="_x0000_s1080" x:autofilter="all" width=89
  style='border-top:none;border-left:none;width:67pt'><font class="font18">ADVANCE</font><font
  class="font19"><br>
    </font><font class="font20">Trừ khác</font></td>
  
 </tr>
 <%
     double[] _grp = new double[59];
     double[] _grd = new double[59];
     for (int _j = 0; _j < 57; _j++)
     {
         _grp[_j] = _grd[_j] = 0;
     }
     for (int i = 0; i < dt_Emp.Rows.Count; i++)
     {
         for (int _j = 6; _j < 59; _j++)
         {
             _grd[_j] += double.Parse(dt_Emp.Rows[i][_j].ToString());
             _grp[_j] += double.Parse(dt_Emp.Rows[i][_j].ToString());
         }
      %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl75 style='height:15.0pt;border-top:none' x:num><%=i + 1%></td>
  <td height=20 class=xl75 style='height:15.0pt;border-top:none' x:num><%=dt_Emp.Rows[i][59].ToString() %></td>
  <td class=xl76 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl77 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl77 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl76 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl76 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][11].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][13].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][14].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][15].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][16].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][17].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][18].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][19].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][20].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][21].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][22].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][23].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][24].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][25].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][26].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][27].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][28].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][29].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][30].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][31].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][32].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][33].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][34].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][35].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][36].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][37].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][38].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][39].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][40].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][41].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][42].ToString()%></td>
  
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][43].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][57].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][44].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][45].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][46].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][47].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][48].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][49].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][50].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][51].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][52].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][53].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][54].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=double.Parse(dt_Emp.Rows[i][55].ToString())%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][56].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][57].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><%=double.Parse(dt_Emp.Rows[i][58].ToString()) %></td>
  
  <td class=xl85 style='border-top:none;border-left:none'></td>
 </tr>
 <%     if (i < dt_Emp.Rows.Count - 1)
        {
            if (dt_Emp.Rows[i][3].ToString() != dt_Emp.Rows[i + 1][3].ToString())
            {%>
 <tr class=xl80 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=7 height=25 class=xl120 style='height:18.75pt' x:str>Total
  of:<span style='mso-spacerun:yes'> <%=dt_Emp.Rows[i][3].ToString()%> </span></td>
  <%    
      string _class = "";
        for (int _t = 6; _t < 59; _t++)
        {
                if(_t>=12 && _t<=24)
                    _class = "xl112";
                else
                    _class = "xl111";
                
                 %>
  <td class="<%=_class %>" style='border-top:none;border-left:none' x:num><%=_grp[_t]%></td>
  <%    if (_t == 43)
        {
             %>
    <td class="<%=_class %>" style='border-top:none;border-left:none' x:num><%=_grp[57]%></td>
     <%
         _grp[57] = 0;
        } %>
  
  <%
        _grp[_t]=0;
        }
      
                %>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% }
        }
     }%>


 <tr class=xl80 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=7 height=25 class=xl120 style='height:18.75pt' x:str>Total
  of:<span style='mso-spacerun:yes'> <%=dt_Emp.Rows[dt_Emp.Rows.Count-1 ][3].ToString()%> </span></td>
  <%    
      string _class1 = "";
        for (int _t = 6; _t < 59; _t++)
        {
                if(_t>=12 && _t<=24)
                    _class1 = "xl112";
                else
                    _class1 = "xl111";
                
                 %>
  <td class="<%=_class1 %>" style='border-top:none;border-left:none' x:num><%=_grp[_t]%></td> 
  <%    if (_t == 43)
        {
             %>
    <td class="<%=_class1 %>" style='border-top:none;border-left:none' x:num><%=_grp[57]%></td>
     <%
            _grp[57]=0;
        } %>                           
  <%
        _grp[_t]=0;
        } %>
  <td class=xl113 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>


 <tr class=xl79 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=7 height=30 class=xl122 style='height:22.5pt'>Grand total</td>
  <%    
      string _class2 = "";
      for (int _t = 6; _t < 59; _t++)
      {
          if (_t >= 12 && _t <= 24)
              _class2 = "xl115";
          else
              _class2 = "xl114";         
                 %>
  <td class="<%=_class2 %>" style='border-top:none;border-left:none' x:num><%=_grd[_t]%></td>    
  <%    if (_t == 43)
        { %>     
        <td class="<%=_class2 %>" style='border-top:none;border-left:none' x:num><%=_grd[57]%></td>
        <%} %>  
  <%} %>
  
 
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
