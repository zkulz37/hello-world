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
    = "select C.PARTNER_NAME,C.TCO_BPPHOTO_PK,substr(a.FROM_DT,-2),substr(a.TO_DT,-2),to_char(to_date(a.WORK_MON,'yyyymm'),'MON-YYYY' )  " + 
        "    ,a.EMP_ID,to_char(to_date(a.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy'),b.ORG_NM " +
        "    ,a.FULL_NAME,a.SALARY_LEVEL1, a.SALARY_LEVEL2 " +
        "    ,a.WT_L1/8, a.WT_L2/8, round( nvl(a.WT_L1_AMT,0)+ nvl( a.WT_L2_AMT,0)) " +
        "    ,a.OT_L1, a.OT_L2,round(nvl(a.OT_L1_AMT,0) + nvl( a.OT_L2_AMT,0)) " +
        "    ,nvl(a.ST_L1,0)+nvl(a.HT_L1,0),nvl(a.ST_L2,0)+nvl(a.HT_L2,0),round(nvl(a.ST_L1_AMT,0)+nvl( a.ST_L2_AMT,0) + nvl(a.HT_L1_AMT,0)+nvl( a.HT_L2_AMT,0))  " +
        "    ,a.ABS_POWER_LOST_L1/8,a.ABS_POWER_LOST_L2/8,round(nvl(a.ABS_POWER_LOST_L1_AMT,0)+ nvl( a.ABS_POWER_LOST_L2_AMT,0)) " +
        "    ,a.ABS_TEMP_REST_L1/8, a.ABS_TEMP_REST_L2/8,round(nvl(a.ABS_TEMP_REST_L1_AMT,0)+nvl( a.ABS_TEMP_REST_L2_AMT,0)) " +
        "    ,a.ABS_ALE_L1, a.ABS_ALE_L2,round(nvl(a.ABS_ALE_L1_AMT,0)+nvl( a.ABS_ALE_L2_AMT,0)) " +
        "    ,nvl(a.ABS_FLE_L1,0)+nvl(a.ABS_WED_L1,0)+nvl(a.ABS_LAC_L1,0),nvl(a.ABS_FLE_L2,0)+nvl(a.ABS_WED_L2,0)+nvl(a.ABS_LAC_L2,0) " +
        "    ,round(nvl(a.ABS_WED_L1_AMT,0)+nvl( a.ABS_WED_L2_AMT,0)+nvl(a.ABS_FLE_L1_AMT,0)+nvl( a.ABS_FLE_L2_AMT,0)+nvl(a.ABS_LAC_L1_AMT,0)+nvl( a.ABS_LAC_L2_AMT,0)) " +
        "    ,a.HOL_DAY_L1, a.HOL_DAY_L2,round(nvl(a.HOL_DAY_L1_AMT,0)+nvl( a.HOL_DAY_L2_AMT,0)) " +
        "    ,a.ABS_COMPENSATION_L1, a.ABS_COMPENSATION_L2,round(nvl(a.ABS_COMPENSATION_L1_AMT,0)+nvl( a.ABS_COMPENSATION_L2_AMT,0)) " +
        "    ,a.ABS_PERMISSION_L1, a.ABS_PERMISSION_L2 " +
        "    ,a.ABS_NON_PERMISSION_L1, a.ABS_NON_PERMISSION_L2 " +
        "    ,a.NT_30_L1, a.NT_30_L2,round(nvl(a.NT_30_L1_AMT,0)+nvl( a.NT_30_L2_AMT,0)) " +
        "    ,a.NT_45_L1, a.NT_45_L2,round(nvl(a.NT_45_L1_AMT,0)+nvl( a.NT_45_L2_AMT,0)) " +
        "    ,a.NT_60_L1, a.NT_60_L2,round(nvl(a.NT_60_L1_AMT,0)+nvl( a.NT_60_L2_AMT,0)) " +
        "         ,ROUND (a.ALLOW_K3_AMT,0), " +
        "         ROUND (a.ALLOW_K2_AMT,0), " +
        "         ROUND (a.ALLOW_K1_AMT,0), " +
        "         ROUND (a.ALLOW_AMT1,0), " +
        "         ROUND (a.ALLOW_AMT2,0), " +
        "         ROUND (a.ALLOW_AMT3,0), " +
        "         ROUND (a.ALLOW_AMT4,0), " +
        "         ROUND (a.ALLOW_K4_AMT,0), " +
        "         ROUND (a.ALLOW_K5_AMT,0), " +
        "         ROUND (a.ALLOW_AMT5,0), " +
        "         ROUND (a.INC_AMT,0), " +
        "         ROUND (a.ALE_STOP,0), " +
        "         ROUND (a.ALE_STOP_AMT,0), " +
        "         ROUND (a.SEVERANCE_MONTH,0), " +
        "         ROUND (a.SEVERANCE_AMT,0), " +
		"         ROUND (a.allow_k3_amt, 0)+ ROUND (a.allow_k2_amt, 0)+ " +
        "         ROUND (a.allow_k1_amt, 0)+ ROUND (a.allow_amt1, 0)+ " +
        "         ROUND (a.allow_amt2, 0)+ ROUND (a.allow_amt3, 0)+ " +
        "         ROUND (a.allow_amt4, 0)+ ROUND (a.allow_k4_amt, 0)+ " +
        "         ROUND (a.allow_k5_amt, 0)+ ROUND (a.allow_amt5, 0), " +
        "         ROUND (a.RETURN_AMT,0), " +
        "         ROUND (a.GROSS_AMT,0) " +
        "    ,round(nvl(a.OT_TAX_L1_AMT,0)+nvl( a.OT_TAX_L2_AMT,0)) " +
        "    ,round(a.DEDUCT_PIT) " +
        "    ,round(nvl(a.HEALTH_AMT,0)+nvl(a.SOCIAL_AMT,0)+nvl(a.UNEMP_INS,0)) " +
        "    ,round(a.HEALTH_AMT,0), round(a.UNEMP_INS,0),round(a.UNION_AMT) " +
        "    ,round(nvl(a.ADVANCE_AMT,0),0),round(nvl(a.INCOME_TAX,0)) " +
        "    ,    ROUND (a.health_amt, 0)+ round(NVL (a.social_amt, 0),0) " +
        "         + ROUND (a.unemp_ins, 0) " +
        "         + ROUND (a.union_amt,0) " +
        "         + round(nvl(a.ADVANCE_AMT,0),0) " +
        "         + ROUND (NVL (a.income_tax, 0)) " +		
        "    ,round(a.NET_AMT) " +
        "         ,(select sum(v.mon_cnt) from vhr_annual_leave v  " +
        "             where v.thr_emp_pk=a.THR_EMP_PK  " +
        "             and substr(v.yearmon,1,4) = substr(a.WORK_MON,1,4)  ) " +
        "         ,a.ALE_DAY_IN_YEAR-nvl((select sum(v.mon_cnt)  " +
        "                 from vhr_annual_leave v  " +
        "                 where v.thr_emp_pk=a.THR_EMP_PK  " +
        "                 and substr(v.yearmon,1,4) = substr(a.WORK_MON,1,4)),0) " +		
		"		,to_char(add_months(to_date(a.WORK_MON,'yyyymm'),1),'mm/yyyy') "+
        "from thr_month_salary_ur a,comm.tco_org b,comm.tco_company c " +         
        "where a.del_if=0 and a.work_mon='" + p_work_mon + "' " +
        "and b.del_if=0 and a.tco_dept_pk=b.pk " +
        "and c.del_if(+)=0 and b.tco_company_pk(+)=c.pk " +
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
        " and decode('" + p_times + "','ALL','ALL',a.times)='" + p_times + "'" +
        " and nvl(a.net_amt,0) " + p_type  + 
        "order by a.dept_nm,a.thr_group_nm,a.emp_id" ;
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
<link rel=File-List href="rpt_pay_slip_iy_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_pay_slip_iy_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_pay_slip_iy_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>kimsach</o:Author>
  <o:LastAuthor>Genuwin</o:LastAuthor>
  <o:LastPrinted>2011-04-01T06:15:10Z</o:LastPrinted>
  <o:Created>2007-08-01T07:15:04Z</o:Created>
  <o:LastSaved>2011-04-01T06:15:58Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.3in .3in .3in .3in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
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
	font-size:9.0pt;
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
	font-size:9.0pt;
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
	text-align:left;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl37
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	vertical-align:middle;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:Standard;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:7.0pt;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	color:red;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	color:red;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	color:red;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl94
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl95
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-weight:700;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;}
.xl107
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl108
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>240</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>115</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>59</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
	<x:PageBreaks>
     <x:RowBreaks>
      <% 
        int irow=0;
        for (int k=0;k<irow_emp/4;k++)
        {
            irow+=108;
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
   
  </x:ExcelWorksheets>
  <x:WindowHeight>8580</x:WindowHeight>
  <x:WindowWidth>11340</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=684 style='border-collapse:
 collapse;table-layout:fixed;width:514pt'>
 <col width=64 style='width:48pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col class=xl24 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col width=44 span=2 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl25 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col width=64 style='width:48pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=64 style='width:48pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col class=xl24 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col width=44 span=2 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl25 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col width=64 style='width:48pt'>
 <%
	int i=0;
    for (i=0;i<irow_emp;i++)
    {
  %>
 <tr height=16 style='height:12.0pt'>
  <td height=16 width=64 style='height:12.0pt;width:48pt' align=left
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
   margin-left:3pt;margin-top:2.25pt;width:237.75pt;height:21pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Emp.Rows[i][1].ToString()%>&table_name=tco_bpphoto" o:title="vinagenuwin"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:4px;margin-top:3px;width:317px;
  height:28px'><img width=317 height=28 src="rpt_pay_slip_iy_files/image002.jpg"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=16 class=xl26 width=64 style='height:12.0pt;width:48pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 width=46 style='width:35pt'>&nbsp;</td>
  <td class=xl28 width=13 style='width:10pt'>&nbsp;</td>
  <td class=xl27 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl27 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl29 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl30 width=64 style='width:48pt'>&nbsp;</td>
  <td width=40 style='width:30pt'></td>
  <td width=64 style='width:48pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;margin-left:3pt;
   margin-top:2.25pt;width:237.75pt;height:21pt;z-index:2'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Emp.Rows[i][1].ToString()%>&table_name=tco_bpphoto" o:title="vinagenuwin"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:4px;margin-top:3px;width:317px;
  height:28px'><img width=317 height=28 src="rpt_pay_slip_iy_files/image003.jpg"
  v:shapes="_x0000_s1026"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=16 class=xl26 width=64 style='height:12.0pt;width:48pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl27 width=46 style='width:35pt'>&nbsp;</td>
  <td class=xl28 width=13 style='width:10pt'>&nbsp;</td>
  <td class=xl27 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl27 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl29 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl30 width=64 style='width:48pt'>&nbsp;</td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl31 style='height:12.0pt'>&nbsp;</td>
  <td colspan=5></td>
  <td class=xl32>&nbsp;</td>
  <td></td>
  <td class=xl31>&nbsp;</td>
  <td colspan=5></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=7 height=11 class=xl106 style='border-right:.5pt solid black;
  height:8.25pt'>PAYROLL SLIP FROM 01 TO <%=dt_Emp.Rows[i][3].ToString()%> <%=dt_Emp.Rows[i][4].ToString()%></td>
  <td></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=7 class=xl106 style='border-right:.5pt solid black'>PAYROLL SLIP FROM 01 TO <%=dt_Emp.Rows[i][3].ToString()%> <%=dt_Emp.Rows[i][4].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=7 height=26 class=xl100 width=322 style='border-right:.5pt solid black;
  height:20.1pt;width:242pt'><%=dt_Emp.Rows[i][5].ToString()%>&nbsp;&nbsp;&nbsp;&nbsp;<%=dt_Emp.Rows[i][6].ToString()%>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dt_Emp.Rows[i][7].ToString()%> <br>
    <%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl33></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=7 class=xl100 width=322 style='border-right:.5pt solid black;
  width:242pt'><%=dt_Emp.Rows[i+1][5].ToString()%>&nbsp;&nbsp;&nbsp;&nbsp;<%=dt_Emp.Rows[i+1][6].ToString()%>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dt_Emp.Rows[i+1][7].ToString()%> <br>
    <%=dt_Emp.Rows[i+1][8].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl103 style='height:8.25pt'>Lương T.Việc - CBản</td>
  <td class=xl34 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl105 x:num><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl35 x:num><%=dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl36></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl103>Lương T.Việc - CBản</td>
  <td class=xl34 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl105 x:num><%=dt_Emp.Rows[i+1][9].ToString()%></td>
  <td class=xl35 x:num><%=dt_Emp.Rows[i+1][10].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl98 style='height:8.25pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>T.V</td>
  <td class=xl40>C.T</td>
  <td class=xl42>Đ.V.T</td>
  <td class=xl43 x:str="Số Tiền"><span style='mso-spacerun:yes'> </span>Số
  Tiền<span style='mso-spacerun:yes'> </span></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl98>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>T.V</td>
  <td class=xl40>C.T</td>
  <td class=xl42>Đ.V.T</td>
  <td class=xl43 x:str="Số Tiền"><span style='mso-spacerun:yes'> </span>Số
  Tiền<span style='mso-spacerun:yes'> </span></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl26 style='height:8.25pt'>Ngày công LV thực tế</td>
  <td class=xl46 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl47 x:num><%=dt_Emp.Rows[i][11].ToString()%></td>
  <td class=xl47 x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl48 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl49 x:num><%=dt_Emp.Rows[i][13].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl26>Ngày công LV thực tế</td>
  <td class=xl46 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl47 x:num><%=dt_Emp.Rows[i+1][11].ToString()%></td>
  <td class=xl47 x:num><%=dt_Emp.Rows[i+1][12].ToString()%></td>
  <td class=xl48 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl49 x:num><%=dt_Emp.Rows[i+1][13].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Tăng ca thường</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][14].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][15].ToString()%></td>
  <td class=xl51 x:str="Hour(s)"><span
  style='mso-spacerun:yes'> </span>Hour(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][16].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Tăng ca thường</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][14].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][15].ToString()%></td>
  <td class=xl51 x:str="Hour(s)"><span
  style='mso-spacerun:yes'> </span>Hour(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][16].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl85 style='height:8.25pt'>Tăng ca CN/Ngày Lễ</td>
  <td class=xl53 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i][17].ToString()%></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i][18].ToString()%></td>
  <td class=xl55 x:str="Hour(s)"><span
  style='mso-spacerun:yes'> </span>Hour(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl56 x:num><%=dt_Emp.Rows[i][19].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl85>Tăng ca CN/Ngày Lễ</td>
  <td class=xl53 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i+1][17].ToString()%></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i+1][18].ToString()%></td>
  <td class=xl55 x:str="Hour(s)"><span
  style='mso-spacerun:yes'> </span>Hour(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl56 x:num><%=dt_Emp.Rows[i+1][19].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  165'>
  <td colspan=2 class=xl78 x:str="Nghỉ mất điện ">Nghỉ mất điện<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][20].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][21].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][22].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl78 x:str="Nghỉ mất điện ">Nghỉ mất điện<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][20].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][21].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][22].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  165'>
  <td colspan=2 class=xl31 x:str="Nghỉ hết hàng ">Nghỉ hết hàng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][23].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][24].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][25].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31 x:str="Nghỉ hết hàng ">Nghỉ hết hàng<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][23].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][24].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][25].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Phép năm</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][26].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][27].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][28].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Phép năm</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][26].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][27].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][28].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='display:none;mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Phép năm năm trước</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num="3"><span style='mso-spacerun:yes'>          </span>3.00
  </td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num="194653.84599999999"><span
  style='mso-spacerun:yes'>             </span>194,654 </td>
  <td class=xl44></td>
  <td colspan=2 class=xl31>Phép năm năm trước</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num="0"><span
  style='mso-spacerun:yes'>                         </span>-<span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl97 style='height:8.25pt'>Nghỉ chế độ</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][29].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][30].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][31].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl97>Nghỉ chế độ</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][29].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][30].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][31].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl97 style='height:8.25pt'>Nghỉ lễ</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><%=dt_Emp.Rows[i][32].ToString()%></td>
  <td class=xl50 x:num="4"><%=dt_Emp.Rows[i][33].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][34].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl97>Nghỉ lễ</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><%=dt_Emp.Rows[i+1][32].ToString()%></td>
  <td class=xl50 x:num="4"><%=dt_Emp.Rows[i+1][33].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][34].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl97 style='height:8.25pt'>Nghỉ hưởng lương
  khác</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][35].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][36].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][37].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl97>Nghỉ hưởng lương khác</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][35].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][36].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][37].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl97 style='height:8.25pt'>Nghỉ có phép</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][38].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][39].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num="0">-</td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl97>Nghỉ có phép</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][38].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][39].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num="0"><span
  style='mso-spacerun:yes'>                         </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl85 style='height:8.25pt'>Nghỉ không phép</td>
  <td class=xl53 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i][40].ToString()%></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i][41].ToString()%></td>
  <td class=xl55 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl56 x:num="0">-</td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl85>Nghỉ không phép</td>
  <td class=xl53 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i+1][40].ToString()%></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i+1][41].ToString()%></td>
  <td class=xl55 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl56 x:num="0"><span
  style='mso-spacerun:yes'>                         </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl26 style='height:8.25pt'>Trợ cấp ca đêm 30%</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][42].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][43].ToString()%></td>
  <td class=xl51 x:str="Hour(s)"><span
  style='mso-spacerun:yes'> </span>Hour(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][44].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl26>Trợ cấp ca đêm 30%</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][42].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][43].ToString()%></td>
  <td class=xl51 x:str="Hour(s)"><span
  style='mso-spacerun:yes'> </span>Hour(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][44].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Trợ cấp ca đêm 45%</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][45].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][46].ToString()%></td>
  <td class=xl51 x:str="Hour(s)"><span
  style='mso-spacerun:yes'> </span>Hour(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][47].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Trợ cấp ca đêm 45%</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][45].ToString()%></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][46].ToString()%></td>
  <td class=xl51 x:str="Hour(s)"><span
  style='mso-spacerun:yes'> </span>Hour(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][47].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl85 style='height:8.25pt'>Trợ cấp ca đêm 60%</td>
  <td class=xl53 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i][48].ToString()%></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i][49].ToString()%></td>
  <td class=xl55 x:str="Hour(s)"><span
  style='mso-spacerun:yes'> </span>Hour(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl56 x:num><%=dt_Emp.Rows[i][50].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl85>Trợ cấp ca đêm 60%</td>
  <td class=xl53 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i+1][48].ToString()%></td>
  <td class=xl54 x:num><%=dt_Emp.Rows[i+1][49].ToString()%></td>
  <td class=xl55 x:str="Hour(s)"><span
  style='mso-spacerun:yes'> </span>Hour(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl56 x:num><%=dt_Emp.Rows[i+1][50].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl26 style='height:8.25pt'>Trợ cấp đi lại</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][51].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl26>Trợ cấp đi lại</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][51].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Trợ cấp nhà trọ</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][52].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Trợ cấp nhà trọ</td>
  <td class=xl44 x:str=":"></td>
  <td class=xl50 x:str="        -  "></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][52].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Trợ cấp chuyên cần</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][53].ToString()%></td>
  <td class=xl57></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Trợ cấp chuyên cần</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][53].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Trợ cấp độc hại</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][54].ToString()%></td>
  <td class=xl57></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Trợ cấp độc hại</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][54].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Trợ cấp kỹ năng</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][55].ToString()%></td>
  <td class=xl57></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Trợ cấp kỹ năng</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][55].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Trợ cấp trách nhiệm</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][56].ToString()%></td>
  <td class=xl57></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Trợ cấp trách nhiệm</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][56].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Trợ cấp quản lý</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][57].ToString()%></td>
  <td class=xl57></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Trợ cấp quản lý</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:num><%=dt_Emp.Rows[i+1][12].ToString()%></td>
  <td class=xl51 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][57].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Trợ cấp thâm niên</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50></td>
  <td class=xl51 x:str=" &nbsp; "><span style='mso-spacerun:yes'> 
  </span>&nbsp;<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][58].ToString()%></td>
  <td class=xl57></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Trợ cấp thâm niên</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50></td>
  <td class=xl51 x:str=" &nbsp; "><span style='mso-spacerun:yes'> 
  </span>&nbsp;<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][58].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Trợ cấp con nhỏ</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50></td>
  <td class=xl51 x:str=" &nbsp; "><span style='mso-spacerun:yes'> 
  </span>&nbsp;<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][59].ToString()%></td>
  <td class=xl57></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Trợ cấp con nhỏ</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl50 x:num="0"><span style='mso-spacerun:yes'>              
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50></td>
  <td class=xl51 x:str=" &nbsp; "><span style='mso-spacerun:yes'> 
  </span>&nbsp;<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][59].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Trợ cấp Khác</td>
  <td class=xl44 x:str=" : "><span style='mso-spacerun:yes'>  </span>:<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl50 x:str="        -  "><span style='mso-spacerun:yes'>        
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50></td>
  <td class=xl51 x:str=""><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][60].ToString()%></td>
  <td class=xl57></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Trợ cấp Khác</td>
  <td class=xl44 x:str=" : "><span style='mso-spacerun:yes'>  </span>:<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl50 x:str="        -  "><span style='mso-spacerun:yes'>        
  </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl50></td>
  <td class=xl51 x:str=""><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][60].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Tiền Thưởng</td>
  <td class=xl44 x:str=" : "><span style='mso-spacerun:yes'>  </span>:<span
  style='mso-spacerun:yes'>  </span></td>
  <td colspan=2 class=xl50></td>
  <td class=xl50></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][61].ToString()%></td>
  <td class=xl57></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Tiền Thưởng</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl50></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][61].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'
  x:str="Phép năm còn lại ">Phép năm còn lại<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl50 x:num><%=dt_Emp.Rows[i][62].ToString()%></td>
  <td class=xl50 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][63].ToString()%></td>
  <td class=xl52>&nbsp;</td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31 style='border-left:none' x:str="Phép năm còn lại ">Phép
  năm còn lại<span style='mso-spacerun:yes'> </span></td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl50 x:num><%=dt_Emp.Rows[i+1][62].ToString()%></td>
  <td class=xl50 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][63].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='display:none;mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'
  x:str="Phép năm còn lại năm trước ">Phép năm còn lại năm trước<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl50 x:num><span
  style='mso-spacerun:yes'>                                     </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num="0"><span
  style='mso-spacerun:yes'>                         </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl52>&nbsp;</td>
  <td colspan=2 class=xl31 style='border-left:none'>Phép năm còn lại năm trước</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl50 x:num="0"><span
  style='mso-spacerun:yes'>                                     </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl50 x:str="Day(s)"><span
  style='mso-spacerun:yes'> </span>Day(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:num="0"><span
  style='mso-spacerun:yes'>                         </span>-<span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl85 style='height:8.25pt'>Trợ cấp thôi việc</td>
  <td class=xl53 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl54 x:num><%=dt_Emp.Rows[i][64].ToString()%></td>
  <td class=xl55 x:str="Year(s)"><span
  style='mso-spacerun:yes'> </span>Year(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl56 x:num><%=dt_Emp.Rows[i][65].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl85>Trợ cấp thôi việc</td>
  <td class=xl53 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl54 x:num><%=dt_Emp.Rows[i+1][64].ToString()%></td>
  <td class=xl55 x:str="Year(s)"><span
  style='mso-spacerun:yes'> </span>Year(s)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl56 x:num><%=dt_Emp.Rows[i+1][65].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl95 style='height:8.25pt'>Tổng Trợ Cấp</td>
  <td class=xl58 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl59>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td colspan=2 class=xl60 style='border-right:.5pt solid black'
  x:num><%=dt_Emp.Rows[i][66].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl95>Tổng Trợ Cấp</td>
  <td class=xl58 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl59>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td colspan=2 class=xl60 style='border-right:.5pt solid black'
  x:num><%=dt_Emp.Rows[i+1][66].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl92 style='height:8.25pt'>Hoàn trả Tháng Trước</td>
  <td class=xl53 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl56 x:num><%=dt_Emp.Rows[i][67].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl92>Hoàn trả Tháng Trước</td>
  <td class=xl53 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl94>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl56 x:num><%=dt_Emp.Rows[i+1][67].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl88 style='height:8.25pt'
  x:str="Tổng thu nhập ">Tổng thu nhập<span style='mso-spacerun:yes'> </span></td>
  <td class=xl61 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td colspan=2 class=xl90 style='border-right:.5pt solid black'
  x:num><%=dt_Emp.Rows[i][68].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl88 x:str="Tổng thu nhập ">Tổng thu nhập<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl61 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl62>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td colspan=2 class=xl90 style='border-right:.5pt solid black'
  x:num><%=dt_Emp.Rows[i+1][68].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  165'>
  <td colspan=2 class=xl26>Tăng ca không thuế</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][69].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl26>Tăng ca không thuế</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][69].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  165'>
  <td colspan=2 class=xl31>Giảm trừ gia cảnh</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][70].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Giảm trừ gia cảnh</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][70].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Phí làm thẻ ATM</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  
  <td class=xl52 x:num="0"><span
  style='mso-spacerun:yes'>                         </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Phí làm thẻ ATM</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num="0"><span
  style='mso-spacerun:yes'>                         </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>BH YT-XH-TN(8.5%)</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][71].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>BH YT-XH-TN(8.5%)</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][71].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  165'>
  <td colspan=2 class=xl31>Bảo hiểm YT</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][72].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Bảo hiểm YT</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][72].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=0 style='display:none;mso-height-source:userset;mso-height-alt:
  165'>
  <td colspan=2 class=xl31>Bảo hiểm TN</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][73].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Bảo hiểm TN</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][73].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Phí công đoàn</td>
  <td class=xl37>:</td>
  <td class=xl45></td>
  <td class=xl44></td>
  <td class=xl41></td>
  <td class=xl63 x:num><%=dt_Emp.Rows[i][74].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Phí công đoàn</td>
  <td class=xl37>:</td>
  <td class=xl45></td>
  <td class=xl44></td>
  <td class=xl41></td>
  <td class=xl63 x:num><%=dt_Emp.Rows[i+1][74].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Khấu Trừ Khác</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][75].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Khấu Trừ Khác</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][75].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl31 style='height:8.25pt'>Khấu Trừ Tết</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num="0"><span
  style='mso-spacerun:yes'>                         </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl31>Khấu Trừ Tết</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl51></td>
  <td class=xl52 x:num="0"><span
  style='mso-spacerun:yes'>                         </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl85 style='height:8.25pt'>Thuế thu nhập</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44></td>
  <td class=xl36></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i][76].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl85>Thuế thu nhập</td>
  <td class=xl44 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44></td>
  <td class=xl36></td>
  <td class=xl51></td>
  <td class=xl52 x:num><%=dt_Emp.Rows[i+1][76].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl70 style='height:8.25pt'>Tổng Khấu Trừ</td>
  <td class=xl60 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td colspan=2 class=xl60 style='border-right:.5pt solid black' x:num><%=dt_Emp.Rows[i][77].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl70>Tổng Khấu Trừ</td>
  <td class=xl60 x:str=":"><span style='mso-spacerun:yes'> </span>:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td colspan=2 class=xl60 style='border-right:.5pt solid black' x:num><%=dt_Emp.Rows[i+1][77].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=2 height=11 class=xl82 style='height:8.25pt'>Thực lãnh</td>
  <td class=xl64>:</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td colspan=2 class=xl84 style='border-right:.5pt solid black'
  x:num><%=dt_Emp.Rows[i][78].ToString()%></td>
  <td></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=2 class=xl82>Thực lãnh</td>
  <td class=xl64>:</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td colspan=2 class=xl84 style='border-right:.5pt solid black'
  x:num><%=dt_Emp.Rows[i+1][78].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=5 height=11 class=xl78 style='height:8.25pt'>Phép năm đã sử dụng
  trong năm :</td>
  <td class=xl51></td>
  <td class=xl66 align=right x:num><%=dt_Emp.Rows[i][79].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=5 class=xl78>Phép năm đã sử dụng trong năm :</td>
  <td class=xl51></td>
  <td class=xl66 align=right x:num><%=dt_Emp.Rows[i+1][79].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td colspan=5 height=11 class=xl80 style='height:8.25pt'>Phép năm còn lại
  trong năm :</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68 align=right x:num><%=dt_Emp.Rows[i][80].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=5 class=xl80>Phép năm còn lại trong năm :</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68 align=right x:num><%=dt_Emp.Rows[i+1][80].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=7 height=24 class=xl73 width=322 style='border-right:.5pt solid black;
  height:18.0pt;width:242pt'>Cám ơn anh(chị) đã làm việc nhiệt tình và tích
  cực. Mọi thắc mắc về lương xin vui lòng liên hệ Phòng Nhân sự hạn cuối là
  20/<%=dt_Emp.Rows[i][81].ToString()%></td>
  <td class=xl44></td>
  <%
	if(i+1<irow_emp)
	{
  %>
  <td colspan=7 class=xl73 width=322 style='border-right:.5pt solid black;
  width:242pt'>Cám ơn anh(chị) đã làm việc nhiệt tình và tích cực. Mọi thắc mắc
  về lương xin vui lòng liên hệ Phòng Nhân sự hạn cuối là 20/<%=dt_Emp.Rows[i][81].ToString()%></td>
  <%
	}
  %>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td colspan=5 height=8 class=xl76 style='height:6.0pt'>&nbsp;</td>
  <td class=xl51></td>
  <td></td>
  <td class=xl44></td>
  <td colspan=5 class=xl77>&nbsp;</td>
  <td class=xl51></td>
  <td></td>
 </tr>
 <%
	i++;
	}
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
 
 </tr>
 <![endif]>
</table>

</body>

</html>
