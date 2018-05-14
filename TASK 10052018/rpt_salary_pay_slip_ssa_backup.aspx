<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">S
<%
    
    string p_dept, p_group, p_status, p_type, p_pay_type, p_emp_id, p_work_mon, p_times, p_emp_type, p_from_leftdate, p_to_leftdate;
       
    p_dept       = Request["l_dept"].ToString();
    p_group      = Request["l_group"].ToString();
    p_status      = Request["l_status"].ToString();
    p_type       = Request["l_type"].ToString();
    p_pay_type   = Request["l_pay_type"].ToString();
    p_emp_id     = Request["l_emp_id"].ToString();
    p_work_mon   = Request["l_work_mon"].ToString();
    p_times = Request["l_Times_r"].ToString();
    p_emp_type = Request["l_Emp_Type"].ToString();
    p_from_leftdate = Request["l_from_leftdate"].ToString();
    p_to_leftdate = Request["l_to_leftdate"].ToString();
    string p_m_type = Request.QueryString["l_m_type"].ToString();
    string not185 = "185";
	string not195="215", nst270="280", nht235="410";
	if(int.Parse(p_work_mon)>=201509)
	{
		not185="185";
		not195="200";
		nst270="270";
		nht235="390";		
	}
    string SQL
     = "select to_char(to_date(A.WORK_MON,'yyyymm'),'MM-YYYY') c0 " +
         "    , A.FULL_NAME c1, A.EMP_ID c2 " +
         "    ,A.DEPT_NM c3 " +
         "    ,to_char(to_date(A.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') c4 " +
         "    ,case when nvl(a.CONFIRM_DT,a.FROM_DT) between a.FROM_DT and a.TO_DT then  round(a.SAL_WITH_WT_L2,5) " +
   "                when nvl(a.CONFIRM_DT,a.FROM_DT) > a.TO_DT then  round(a.SAL_WITH_WT_L1,5) " +
   "                else round(a.SAL_WITH_WT_L2,5) " +
   "         end c5 " +
         "    ,S.ALLOW_AMT2 c6 " +
         "    ,S.ALLOW_AMT1 c7 " +
         "    ,400000 c8 " +
         "    ,100000 c9 " +
         "    ,round(nvl(A.WT_L1,0)/8+nvl(A.WT_L2,0)/8+nvl(A.HOL_DAY_L1,0)+nvl(A.HOL_DAY_L2,0),5) c10 " +
         "    ,round(nvl(A.TOTAL_ABS_PAY_L1,0)/8+nvl(A.TOTAL_ABS_PAY_L2,0)/8,5) c11 " +
         "    ,round(nvl(A.WT_L1,0)/8+nvl(A.WT_L2,0)/8+nvl(A.HOL_DAY_L1,0)+nvl(A.HOL_DAY_L2,0) " +
         "        + nvl(A.TOTAL_ABS_PAY_L1,0)/8+nvl(A.TOTAL_ABS_PAY_L2,0)/8,5) c12 " +
         "    ,round(nvl(A.TOTAL_ABS_NPAY_L1,0)/8+nvl(A.TOTAL_ABS_NPAY_L2,0)/8,5) c13 " +
         "    ,round(nvl(A.OT_L1,0)+nvl( A.OT_L2,0),5) c14 " +
         "    ,round(nvl(A.NOT_185_L1,0)+nvl( A.NOT_185_L2,0),5) c15 " +
         "    ,round(nvl(A.NOT_195_L1,0)+nvl( A.NOT_195_L2,0),5) c16 " +
         "    ,round(nvl(A.ST_L1,0)+nvl( A.ST_L2,0)+nvl(A.OST_L1,0)+nvl( A.OST_L2,0)+nvl(A.NOST_L1,0)+nvl( A.NOST_L2,0),5) c17 " +
         "    ,round(nvl(A.NST_L1,0)+nvl( A.NST_L2,0),5) c18 " +
         "    ,round(nvl(A.HT_L1,0)+nvl( A.HT_L2,0),5) c19 " +
         "    ,round(nvl(A.NHT_L1,0)+nvl( A.NHT_L2,0),5) c20 " +
         "    ,round(nvl(A.OHT_L1,0)+nvl( A.OHT_L2,0) + nvl(A.NOHT_L1,0)+nvl( A.NOHT_L2,0) +nvl(A.ST_300_L1,0)+nvl( A.ST_300_L2,0)+nvl(A.OST_300_L1,0)+nvl( A.OST_300_L2,0),5) c21 " +
         "    ,round(nvl(A.OT_L1,0)+nvl( A.OT_L2,0) " +
         "    +nvl(A.NOT_185_L1,0)+nvl( A.NOT_185_L2,0) " +
         "    +nvl(A.NOT_195_L1,0)+nvl( A.NOT_195_L2,0) " +
         "    +nvl(A.NOT_195_2_L1,0)+nvl( A.NOT_195_2_L2,0) " +
         "    +nvl(A.ST_L1,0)+nvl( A.ST_L2,0)+nvl(A.OST_L1,0)+nvl( A.OST_L2,0) " +
         "    +nvl(A.NST_L1,0)+nvl( A.NST_L2,0)+nvl(A.NOST_L1,0)+nvl( A.NOST_L2,0) " +
         "    +nvl(A.HT_L1,0)+nvl( A.HT_L2,0) " +
         "    +nvl(A.NHT_L1,0)+nvl( A.NHT_L2,0) " +
		 "	  +nvl(A.ST_300_L1,0)+nvl( A.ST_300_L2,0)+nvl(A.OST_300_L1,0)+nvl( A.OST_300_L2,0)	"+
         "    +nvl(A.OHT_L1,0)+nvl( A.OHT_L2,0) + nvl(A.NOHT_L1,0)+nvl( A.NOHT_L2,0),5) c22 " +
         "    ,round(nvl(A.Total_wt_hol_abs_l1_amt,0)+nvl(A.Total_wt_hol_abs_l2_amt,0) " +
         "            ,5) c23 " +
         "    ,round(nvl(A.TOTAL_OT_L1_AMT,0)+nvl(A.TOTAL_OT_L2_AMT,0) " +
         "            -nvl(A.NT_30_L1_AMT,0)-nvl(A.NT_30_L2_AMT,0),5) c24 " +
         "    ,round(nvl(A.NT_30_L1_AMT,0)+nvl(A.NT_30_L2_AMT,0),5) c25 " +
         "    ,round(nvl(A.ALLOW_K4_AMT,0),5) c26 " +
         "    ,round(nvl(A.ALLOW_AMT2,0),5) c27 " +
         "    ,round(nvl(A.ALLOW_AMT1,0),5) c28 " +
         "    ,round(nvl(A.ALLOW_K1_AMT,0),5) c29 " +
         "    ,round(nvl(A.ALLOW_K2_AMT,0),5) c30                                     " +
         "    ,round(nvl(A.ALLOW_K5_AMT,0),5) c31 " +
         "    ,round(nvl(A.ALLOW_K3_AMT,0),5) c32 " +
         "    ,round(nvl(A.RETURN_AMT,0)+nvl(A.RETURN_NO_PIT,0)-nvl(a.refund_business_trip_amt,0) ,5) c33 " +
         "    ,round(nvl(a.refund_business_trip_amt,0),0) c34 " +
         "    ,round(nvl(A.GROSS_AMT,0),5) c35 " +
         "    ,round(nvl(A.OT_TAX_L1_AMT,0)+nvl(A.OT_TAX_L2_AMT,0),5) c36 " +
         "    ,round(nvl(A.DEDUCT_PIT,0),5) c37 " +
         "    ,round(nvl(A.INCOME_BEFORE_TAX,0),5) c38 " +
         "    ,round(nvl(A.SOCIAL_AMT,0),5) c39 " +
         "    ,round(nvl(A.HEALTH_AMT,0),5) c40 " +
         "    ,round(nvl(A.UNEMP_INS,0),5) c41 " +
         "    ,round(nvl(A.HEALTH_CARD_AMT ,0),5) c42 " +
         "    ,round(nvl(A.UNION_AMT,0),5) c43 " +
         "    ,round(nvl(A.INCOME_TAX,0),5) c44 " +
         "    ,0 c45 " +
         "    ,round(nvl(A.ADVANCE_AMT,0)+nvl( A.ADVANCE_NO_PIT,0) ,5) c46  " +
         "    ,round(nvl(A.SOCIAL_AMT,0) " +
         "    +nvl(A.HEALTH_AMT,0) " +
         "    +nvl(A.UNEMP_INS,0) " +
         "    +nvl(A.HEALTH_CARD_AMT ,0) " +
         "    +nvl(A.UNION_AMT,0) " +
         "    +nvl(A.INCOME_TAX,0)     " +
         "    +nvl(A.ADVANCE_AMT,0)+nvl( A.ADVANCE_NO_PIT,0) - nvl(a.deduct_health_card,0) ,5) c47 " +
         "    ,round(nvl(A.NET_AMT,0) ,5) c48 " +
         "    ,to_char(add_months(to_date(A.WORK_MON||'20','yyyymmdd'),1),'dd/mm/yyyy') c49 " +
         "    ,round(nvl(a.sickness_amt,0),5) c50  " +
         "    ,round(nvl(late.in_late,0) + nvl(late.out_early,0) ,5) c51  "+
         "    ,nvl(a.seq,0) c52  "+
         "        ,round(nvl(a.ALE_STOP_AMT,0)  ,5) ANNUAL_STOP_AMT " +
        "        ,round( nvl(a.WT_L1,0)/8+nvl(a.WT_L2,0)/8+nvl(a.HOL_DAY_L1,0)+nvl(a.HOL_DAY_L2,0) - (NVL(a.wd_nt_l1,0)+NVL(a.wd_nt_l2,0))/8,5) work_day  " +
        "        ,round((NVL(a.wd_nt_l1,0)+NVL(a.wd_nt_l2,0))/8,5) work_day_nt  " +
		"        ,round( nvl(s.ALLOW_AMT3,0) ,5) ALLOW_AMT3_FULL  " +
		
	   "        ,round( nvl(s.ALLOW_AMT4,0) ,5) ALLOW_AMT4_FULL  " +
	   "        ,round( nvl(a.ALLOW_AMT3,0) ,5) ALLOW_AMT3  " +
	   
	   "        ,round( nvl(a.ALLOW_AMT4,0) ,5) ALLOW_AMT4  " +
	   "        ,round( nvl(a.children_allow_amt ,0) ,5) children_allow_amt  " +
	   "    , round(nvl(NOT_195_2_L1,0) + nvl(NOT_195_2_L2,0),0) NOT_195_2 "+
	   "    , round(nvl(NOT_195_2_L1_AMT,0) + nvl(NOT_195_2_L2_AMT,0),0) NOT_195_2_AMT  "+
	   "	,round( nvl(a.senior_amt,0),0) senior_amt	" +
	   "        ,round( nvl(s.ALLOW_AMT5,0) ,5) ALLOW_AMT5_FULL  " +
	   "        ,round( nvl(a.ALLOW_AMT5,0) ,5) ALLOW_AMT5 , a.DEPT_NM " +
	   "        ,round( nvl(a.ALLOW_AMT6,0) ,5) ALLOW_AMT6  " +
	   "        ,round( nvl(s.ALLOW_AMT6,0) ,5) ALLOW_AMT6_FULL  " +
        "from thr_month_salary a,comm.tco_org b,comm.tco_company c,thr_salary_manage s, thr_month_summary late " +    
        " where a.del_if=0 and a.work_mon='" + p_work_mon + "' " +
        " and b.del_if=0 and a.tco_dept_pk=b.pk  " +
        " and a.thr_emp_pk=late.thr_emp_pk(+) " +
		" and a.work_mon = late.work_mon(+) "+
		" and late.del_if = 0 " +
        " and S.DEL_IF(+)=0 and S.THR_EMP_PK(+)=A.THR_EMP_PK and S.WORK_MON(+)=A.WORK_MON " +
        " and c.del_if(+)=0 and b.tco_company_pk(+)=c.pk " +
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
        " and ('" + p_from_leftdate + "' is null or '" + p_to_leftdate + "' is null or a.left_dt between '" + p_from_leftdate + "' and '" + p_to_leftdate + "')" + 
        " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
        " and decode('" + p_emp_type + "','ALL','ALL',a.Employee_Type)='" + p_emp_type + "'" +
        " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
        " and decode('" + p_times + "','ALL','ALL',a.times)='" + p_times + "'" +
        " and nvl(a.net_amt,0) " + p_type  + 
        " order by nvl(b.seq,0),a .DEPT_NM , a.EMP_ID" ;

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
    double ins_rate=7;
	if(double.Parse(p_work_mon)>=201401)
		ins_rate=8;
    
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="ssa%20payslip%201_files/filelist.xml">
<link rel=Edit-Time-Data href="ssa%20payslip%201_files/editdata.mso">
<link rel=OLE-Object-Data href="ssa%20payslip%201_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>convert</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-09-30T04:17:42Z</o:LastPrinted>
  <o:Created>2011-09-30T03:47:56Z</o:Created>
  <o:LastSaved>2011-09-30T04:20:01Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .2in .25in .2in;
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
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl69
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl70
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dotted windowtext;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;}
.xl86
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt dotted windowtext;}
.xl87
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;}
.xl93
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:2.0pt double windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl94
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.5pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl95
	{mso-style-parent:style0;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
       <x:RangeSelection>$G$18:$H$18</x:RangeSelection>
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
        for (int k=0;k< dt_Emp.Rows.Count ;k++)
        {
            irow+=68;
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
  <x:WindowHeight>11895</x:WindowHeight>
  <x:WindowWidth>19020</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=631 style='border-collapse:
 collapse;table-layout:fixed;width:473pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=64 style='width:48pt'>
 <col width=115 style='mso-width-source:userset;mso-width-alt:4205;width:86pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=31 style='mso-width-source:userset;mso-width-alt:1133;width:23pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:1755;width:36pt'>
 <col width=64 style='width:48pt'>
 <col width=115 style='mso-width-source:userset;mso-width-alt:4205;width:86pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <% for (int i = 0; i < dt_Emp.Rows.Count; i += 2)
    { %>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl92 width=227 style='height:15.75pt;
  width:170pt'>CÔNG TY TNHH SUNG SHIN A VIỆT NAM</td>
  <td class=xl65 width=73 style='border-left:none;width:55pt'>No: <%=dt_Emp.Rows[i][52].ToString()%> </td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td width=31 style='width:23pt'></td>
  <td colspan=3 class=xl92 width=227 style='width:170pt'>CÔNG TY TNHH SUNG SHIN
  A VIỆT NAM</td>
  <td class=xl65 width=73 style='border-left:none;width:55pt'>No: <%=dt_Emp.Rows[i+1][52].ToString()%></td>
  <%    } %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=4 height=17 class=xl74 style='border-right:2.0pt double black;
  mso-height-source:userset;height:12.0pt'>PHIẾU LƯƠNG THÁNG <%=dt_Emp.Rows[i][0].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=4 class=xl74 style='border-right:2.0pt double black'>PHIẾU LƯƠNG
  THÁNG <%=dt_Emp.Rows[i+1][0].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td rowspan=4 height=80 class=xl87 width=48 style='height:60.0pt;border-top:
  none;width:36pt' x:str="THÔNG &#10;TIN &#10;CÁ&#10; NHÂN ">THÔNG <br>
    TIN <br>
    CÁ<br>
    <span style='mso-spacerun:yes'> </span>NHÂN<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl66 align=left style='border-top:none;border-left:none'>Họ và
  tên</td>
  <td colspan=2 class=xl88 style='border-right:2.0pt double black;border-left:
  none'><%=dt_Emp.Rows[i][1].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td rowspan=4 class=xl87 width=48 style='border-top:none;width:36pt'
  x:str="THÔNG &#10;TIN &#10;CÁ&#10; NHÂN ">THÔNG <br>
    TIN <br>
    CÁ<br>
    <span style='mso-spacerun:yes'> </span>NHÂN<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl66 align=left style='border-top:none;border-left:none'>Họ và
  tên</td>
  <td colspan=2 class=xl88 style='border-right:2.0pt double black;border-left:
  none'><%=dt_Emp.Rows[i+1][1].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Mã
  số</td>
  <td class=xl73 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][2].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Mã số</td>
  <td class=xl73 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i+1][2].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td height=17 class=xl66 align=left style='mso-height-source:userset;height:12.0pt;border-top:none;
  border-left:none'>Bộ phận</td>
  <td colspan=2 class=xl90 style='border-right:2.0pt double black;border-left:
  none'><%=dt_Emp.Rows[i][3].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td class=xl66 align=left style='border-top:none;border-left:none'>Bộ phận</td>
  <td colspan=2 class=xl90 style='border-right:2.0pt double black;border-left:
  none'><%=dt_Emp.Rows[i+1][3].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Ngày
  vào làm</td>
  <td class=xl68 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][4].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Ngày vào làm</td>
  <td class=xl68 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i+1][4].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td rowspan=10 height=100 class=xl87 width=48 style='height:75.0pt;border-top:
  none;width:36pt'>LƯƠNG<br>
    <span style='mso-spacerun:yes'> </span>ĐỦ <br>
    THÁNG</td>
  <td colspan=2 class=xl83 style='border-left:none'>Lương cơ bản</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][5].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td rowspan=10 class=xl87 width=48 style='border-top:none;width:36pt'>LƯƠNG<br>
    <span style='mso-spacerun:yes'> </span>ĐỦ <br>
    THÁNG</td>
  <td colspan=2 class=xl83 style='border-left:none'>Lương cơ bản</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][5].ToString() %></td>
  <%} %>
 </tr>
 
 
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Phụ cấp chức vụ</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["ALLOW_AMT5_FULL"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Phụ cấp chức vụ</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["ALLOW_AMT5_FULL"].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Phụ
  cấp trách nhiệm</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][7].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Phụ cấp trách nhiệm</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][7].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Phụ cấp thâm niên</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["senior_amt"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Phụ cấp thâm niên</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["senior_amt"].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trợ
  cấp công việc</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][6].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trợ cấp công việc</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][6].ToString() %></td>
  <%} %>
 </tr>
 <!-- ----------------------------------------------------------------------------------------->
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trợ cấp ưu đãi</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["ALLOW_AMT3_FULL"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trợ cấp ưu đãi</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["ALLOW_AMT3_FULL"].ToString() %></td>
  <%} %>
 </tr>
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trợ
  cấp sinh hoạt</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][8].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trợ cấp sinh hoạt</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][8].ToString() %></td>
  <%} %>
 </tr>
 
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Thưởng thành tích</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["ALLOW_AMT6_FULL"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Thưởng thành tích</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["ALLOW_AMT6_FULL"].ToString() %></td>
  <%} %>
 </tr>
 
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Thưởng sáng kiến</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["ALLOW_AMT4_FULL"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Thưởng sáng kiến</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["ALLOW_AMT4_FULL"].ToString() %></td>
  <%} %>
 </tr>
 <!-- ----------------------------------------------------------------------------------------->
 
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Thưởng
  chuyên cần</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][9].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Thưởng chuyên cần</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][9].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td rowspan=4 height=60 class=xl87 width=48 style='height:45.0pt;border-top:
  none;width:36pt'>CÔNG <br>
    và NGHỈ <br>
    HƯỞNG<br>
    <span style='mso-spacerun:yes'> </span>LƯƠNG</td>
  <td colspan=2 class=xl83 style='border-left:none'>Tổng công ngày</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["work_day"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td rowspan=4 class=xl87 width=48 style='border-top:none;width:36pt'>CÔNG
  <br>
    và NGHỈ <br>
    HƯỞNG<br>
    <span style='mso-spacerun:yes'> </span>LƯƠNG</td>
  <td colspan=2 class=xl83 style='border-left:none'>Tổng công ngày</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["work_day"].ToString() %></td>
  <%} %>
 </tr>
<tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'
  x:str>Tổng công đêm<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["work_day_nt"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'
  x:str>Tổng công đêm<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["work_day_nt"].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'
  x:str="Số ngày nghỉ hưởng lương ">Số ngày nghỉ hưởng lương<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][11].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'
  x:str="Số ngày nghỉ hưởng lương ">Số ngày nghỉ hưởng lương<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][11].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl84 style='mso-height-source:userset;height:12.0pt;border-left:none'>TỔNG
  NGÀY HƯỞNG LƯƠNG</td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][12].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl84 style='border-left:none'>TỔNG NGÀY HƯỞNG LƯƠNG</td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][12].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=3 height=17 class=xl85 style='mso-height-source:userset;height:12.0pt'>SỐ NGÀY NGHỈ KHÔNG
  HƯỞNG LƯƠNG</td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][13].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=3 class=xl85>SỐ NGÀY NGHỈ KHÔNG HƯỞNG LƯƠNG</td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][13].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td rowspan=9 height=160 class=xl82 width=48 style='height:120.0pt;
  border-top:none;width:36pt'>TỔNG<br>
    <span style='mso-spacerun:yes'> </span>SỐ GIỜ <br>
    TĂNG<br>
    <span style='mso-spacerun:yes'> </span>CA</td>
  <td colspan=2 class=xl83 style='border-left:none'
  x:str="Tổng tăng ca của ca ngày (x150%) ">Tổng tăng ca của ca ngày
  (x150%)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][14].ToString() %></td
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td rowspan=9 class=xl82 width=48 style='border-top:none;width:36pt'>TỔNG<br>
    <span style='mso-spacerun:yes'> </span>SỐ GIỜ <br>
    TĂNG<br>
    <span style='mso-spacerun:yes'> </span>CA</td>
  <td colspan=2 class=xl83 style='border-left:none'
  x:str="Tổng tăng ca của ca ngày (x150%) ">Tổng tăng ca của ca ngày
  (x150%)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][14].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Tổng
  tăng ca của ca đêm (<%=not185%>%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][15].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Tổng tăng ca của ca đêm
  (x<%=not185%>%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][15].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Tăng
  ca ngày sau 22 giờ (x<%=not195%>%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][16].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Tăng ca ngày sau 22 giờ
  (x<%=not195%>%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][16].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Tăng
  ca ngày sau 22 giờ (x210%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["NOT_195_2"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Tăng ca ngày sau 22 giờ
  (x210%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["NOT_195_2"].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Tăng
  ca chủ nhật (6h-22h)x200%</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][17].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Tăng ca chủ nhật
  (6h-22h)x200%</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][17].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Tăng
  ca chủ nhật (22h-6h)x<%=nst270%>%</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][18].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Tăng ca chủ nhật
  (22h-6h)x<%=nst270%>%</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][18].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Tăng
  ca ngày Lễ-Tết (x300%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][19].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Tăng ca ngày Lễ-Tết (x300%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][19].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Tăng
  ca ngày Lễ-Tết (x<%=nht235%>%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][20].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Tăng ca ngày Lễ-Tết (x<%=nht235%>%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][20].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Tăng
  ca ngày Lễ-Tết (x300%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][21].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Tăng ca ngày Lễ-Tết (x300%)</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][21].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=3 height=17 class=xl85 style='mso-height-source:userset;height:12.0pt'>TỔNG SỐ GIỜ TĂNG
  CA</td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][22].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=3 class=xl85>TỔNG SỐ GIỜ TĂNG CA</td>
  <td class=xl70 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][22].ToString() %></td>
  <%} %>
 </tr>
 <tr height=18 style='mso-height-source:userset;mso-height-source:userset;height:12.0pt'>
  <td rowspan=19 height=260 class=xl82 width=48 style='height:195.0pt;
  border-top:none;width:36pt'>THÀNH <br>
    TIỀN<br>
    <span style='mso-spacerun:yes'> </span>CÁC<br>
    <span style='mso-spacerun:yes'> </span>KHOẢN</td>
  <td colspan=2 class=xl83 style='border-left:none'>Lương ngày công,nghỉ có
  lương</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][23].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td rowspan=19 class=xl82 width=48 style='border-top:none;width:36pt'>THÀNH
  <br>
    TIỀN<br>
    <span style='mso-spacerun:yes'> </span>CÁC<br>
    <span style='mso-spacerun:yes'> </span>KHOẢN</td>
  <td colspan=2 class=xl83 style='border-left:none'>Lương ngày công,nghỉ có
  lương</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][23].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Lương
  tăng ca</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][24].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Lương tăng ca</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][24].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trợ
  cấp ca đêm (x35%)</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][25].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trợ cấp ca đêm (x35%)</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][25].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Phụ
  cấp tăng ca</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][26].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Phụ cấp tăng ca</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][26].ToString() %></td>
  <%} %>
 </tr>
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Phụ
  cấp chức vụ</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["ALLOW_AMT5"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Phụ
  cấp chức vụ</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["ALLOW_AMT5"].ToString() %></td>
  <%} %>
 </tr>

  <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Phụ
  cấp trách nhiệm</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][28].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Phụ cấp trách nhiệm</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][28].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Phụ cấp
  thâm niên</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][32].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Phụ cấp thâm niên</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][32].ToString() %></td>
  <%} %>
 </tr>
 
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trợ
  cấp công việc</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][27].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trợ cấp công việc</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][27].ToString() %></td>
  <%} %>
 </tr>

 
 <!-- ----------------------------------------------------------------------------------------->
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trợ cấp ưu đãi</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["ALLOW_AMT3"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trợ cấp ưu đãi</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["ALLOW_AMT3"].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trợ
  cấp sinh hoạt</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][29].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trợ cấp sinh hoạt</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][29].ToString() %></td>
  <%} %>
 </tr>
 
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Thưởng thành tích</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["ALLOW_AMT6"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Thưởng thành tích</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["ALLOW_AMT6"].ToString() %></td>
  <%} %>
 </tr>
 
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Thưởng sáng kiến</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["ALLOW_AMT4"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Thưởng sáng kiến</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["ALLOW_AMT4"].ToString() %></td>
  <%} %>
 </tr>
 <!-- ----------------------------------------------------------------------------------------->
 
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Thưởng
  chuyên cần</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][30].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Thưởng chuyên cần</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][30].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trả
  22% BH trong T.G thử việc</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][31].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trả 22% BH trong T.G thử
  việc</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][31].ToString() %></td>
  <%} %>
 </tr>
 
 <!------------------------------------ ------------------------------------------------------>
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trợ cấp con nhỏ</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["children_allow_amt"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trợ cấp con nhỏ</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["children_allow_amt"].ToString() %></td>
  <%} %>
 </tr>
 
 <!------------------------------------ ------------------------------------------------------>
 
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Hoàn trả	
</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=double.Parse(dt_Emp.Rows[i][33].ToString()) + double.Parse(dt_Emp.Rows[i]["ANNUAL_STOP_AMT"].ToString()) %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Hoàn trả	
</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=double.Parse(dt_Emp.Rows[i+1][33].ToString()) + double.Parse(dt_Emp.Rows[i + 1]["ANNUAL_STOP_AMT"].ToString()) %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt;'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Hoàn trả phép năm</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i]["ANNUAL_STOP_AMT"].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Hoàn trả phép năm</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1]["ANNUAL_STOP_AMT"].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Phí
  công tác-Tiền nhận tháng trước</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][34].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Phí công tác-Tiền nhận
  tháng trước</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][34].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl84 style='mso-height-source:userset;height:12.0pt;border-left:none'>TỔNG
  LƯƠNG</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][35].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl84 style='border-left:none'>TỔNG LƯƠNG</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][35].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=3 height=17 class=xl85 style='mso-height-source:userset;height:12.0pt'>Lương tăng ca tính
  thuế</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][36].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=3 class=xl85>Lương tăng ca tính thuế</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][36].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=3 height=17 class=xl85 style='mso-height-source:userset;height:12.0pt'>Giảm trừ gia cảnh</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][37].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=3 class=xl85>Giảm trừ gia cảnh</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][37].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=3 height=17 class=xl85 style='mso-height-source:userset;height:12.0pt'>THU NHẬP TÍNH
  THUẾ</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][38].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=3 class=xl85>THU NHẬP TÍNH THUẾ</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][38].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td rowspan=8 height=180 class=xl82 width=48 style='height:135.0pt;
  border-top:none;width:36pt'>TỔNG <br>
    KHẤU<br>
    <span style='mso-spacerun:yes'> </span>TRỪ</td>
  <td colspan=2 class=xl83 style='border-left:none'>Bảo hiểm xã hội<span
  style='mso-spacerun:yes'>           </span><%=ins_rate%>,0%</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][39].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td rowspan=8 class=xl82 width=48 style='border-top:none;width:36pt'>TỔNG
  <br>
    KHẤU<br>
    <span style='mso-spacerun:yes'> </span>TRỪ</td>
  <td colspan=2 class=xl83 style='border-left:none'>Bảo hiểm xã hội<span
  style='mso-spacerun:yes'>           </span><%=ins_rate%>,0%</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][39].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Bảo
  hiểm y tế<span style='mso-spacerun:yes'>               </span>1,5%</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][40].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Bảo hiểm y tế<span
  style='mso-spacerun:yes'>               </span>1,5%</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][40].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Bảo
  hiểm thất nghiệp<span style='mso-spacerun:yes'>   </span>1,0%</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][41].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Bảo hiểm thất
  nghiệp<span style='mso-spacerun:yes'>   </span>1,0%</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][41].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trừ
  BHYT với người nghỉ việc</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][42].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trừ BHYT với người nghỉ
  việc</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][42].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Công
  đòan</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][43].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Công đòan</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][43].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Thuế
  thu nhập</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][44].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Thuế thu nhập</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][44].ToString() %></td>
  <%} %>
 </tr>
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl83 style='mso-height-source:userset;height:12.0pt;border-left:none'>Trừ
  khác</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][46].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl83 style='border-left:none'>Trừ khác</td>
  <td class=xl71 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][46].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=2 height=17 class=xl84 style='mso-height-source:userset;height:12.0pt;border-left:none'>TỔNG
  KHẤU TRỪ</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][47].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=2 class=xl84 style='border-left:none'>TỔNG KHẤU TRỪ</td>
  <td class=xl72 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][47].ToString() %></td>
  <%} %>
 </tr>
 
 
 
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=3 height=17 class=xl74 style='mso-height-source:userset;height:12.0pt'>Tiền ốm đau</td>
  <td class=xl67 align=right style='border-top:none;border-left:none;' x:num><%=dt_Emp.Rows[i][50].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=3 class=xl74>Tiền ốm đau</td>
  <td class=xl67 align=right  style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][50].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=3 height=17 class=xl74 style='mso-height-source:userset;height:12.0pt'>TỔNG LƯƠNG THỰC
  LÃNH</td>
  <td class=xl67 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i][48].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=3 class=xl74>TỔNG LƯƠNG THỰC LÃNH</td>
  <td class=xl67 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[i+1][48].ToString() %></td>
  <%} %>
 </tr>

 

 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=4 height=17 class=xl76 style='border-right:2.0pt double black;
  mso-height-source:userset;height:12.0pt'>Ghi chú: Trong thời gian thử việc không có phụ cấp sinh hoạt (400000đ)</td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=4 class=xl76 style='border-right:2.0pt double black'>Ghi chú: Trong thời gian thử việc không có phụ cấp sinh hoạt (400000đ)</td>
  <%} %>
 </tr>

 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=4 height=17 class=xl76 style='border-right:2.0pt double black;
  mso-height-source:userset;height:12.0pt'>Ghi chú:số phút vào trễ hoặc ra sớm: <%=dt_Emp.Rows[i][51].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=4 class=xl76 style='border-right:2.0pt double black'>Ghi chú:số
  phút vào trễ hoặc ra sớm: <%=dt_Emp.Rows[i+1][51].ToString() %></td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=4 height=17 class=xl76 style='border-right:2.0pt double black;
  mso-height-source:userset;height:12.0pt'>Cảm ơn anh/chị đã làm việc tích cực</td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=4 class=xl76 style='border-right:2.0pt double black'>Cảm ơn
  anh/chị đã làm việc tích cực</td>
  <%} %>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.0pt'>
  <td colspan=4 height=17 class=xl76 style='border-right:2.0pt double black;
  mso-height-source:userset;height:12.0pt'>Mọi thắc mắc vui lòng liên hệ tổ trưởng, phòng nhân
  sự ghi nhận và giải quyết</td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=4 class=xl76 style='border-right:2.0pt double black'>Mọi thắc
  mắc vui lòng liên hệ tổ trưởng, phòng nhân sự ghi nhận và giải
  quyết</td>
  <%} %>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl79 style='border-right:2.0pt double black;
  height:15.75pt'>Hạn cuối cùng nhận thắc mắc là ngày <%=dt_Emp.Rows[i][49].ToString() %></td>
  <% if (i + 1 < dt_Emp.Rows.Count)
     { %>
  <td></td>
  <td colspan=4 class=xl79 style='border-right:2.0pt double black'>Hạn cuối
  cùng nhận thắc mắc là ngày <%=dt_Emp.Rows[i+1][49].ToString() %></td>
  <%} %>
 </tr>
 
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=48 style='width:36pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=73 style='width:55pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
