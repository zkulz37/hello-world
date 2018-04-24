﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

    string p_work_mon;
     
    p_work_mon   = Request["l_work_mon"].ToString();
    
 //--------------------company information-----------------------
    string SQL_Com
	= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY'),to_char(to_date('" + p_work_mon + "','yyyymm'),'MM-YYYY') " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
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

    string SQL
    = "select a.EXCHANGE_RATE as rate, " + //0
        "round(sum(nvl(A.WT_L1_AMT,0) + nvl(A.WT_L2_AMT,0)+ nvl(A.TOTAL_ABS_PAY_L1_AMT,0) + nvl(A.TOTAL_ABS_PAY_L2_AMT,0)  " +
        "+ NVL(a.HOL_DAY_L1_AMT,0)+ NVL(a.HOL_DAY_L2_AMT,0)),3) as basic_sal,   " + //1
        "round(sum(nvl(A.TOTAL_OT_L1_AMT,0) + nvl(A.TOTAL_OT_L2_AMT,0)),3) as ot,  " + //2
        "ROUND(sum(NVL(A.ALLOW_K1_AMT,0)),3) as house,   " + //3
        "ROUND(sum(NVL(A.ALLOW_K2_AMT,0)),3) as attendacne,   " + //4
        "ROUND(sum(NVL(A.ALLOW_K3_AMT,0)),3) as child,   " + //5
        "round(sum(nvl(A.RETURN_AMT,0)),3) as other,  " + //6
        "round(sum(nvl(a.inc_amt,0) + nvl(a.incentive_02,0)),3) as incentive, " + //7
        "round(sum(nvl(A.WT_L1_AMT,0) + nvl(A.WT_L2_AMT,0)+ nvl(A.TOTAL_ABS_PAY_L1_AMT,0) + nvl(A.TOTAL_ABS_PAY_L2_AMT,0)  " +
        "+ NVL(a.HOL_DAY_L1_AMT,0)+ NVL(a.HOL_DAY_L2_AMT,0)),3)    " +
        "+ round(sum(nvl(A.TOTAL_OT_L1_AMT,0) + nvl(A.TOTAL_OT_L2_AMT,0)),3)  " +
        "+ ROUND(sum(NVL(A.ALLOW_K1_AMT,0)),3)   " +
        "+ ROUND(sum(NVL(A.ALLOW_K2_AMT,0)),3)   " +
        "+ ROUND(sum(NVL(A.ALLOW_K3_AMT,0)),3)   " +
        "+ round(sum(nvl(A.RETURN_AMT,0)),3) + round(sum(nvl(A.RETURN_no_pit,0)),3)+ROUND (SUM (NVL (a.allow_amt1_l1, 0) + nvl(a.allow_amt1_l2,0)), 3) + ROUND (SUM (NVL (a.allow_amt4_l1, 0) + nvl(a.allow_amt4_l2,0)), 3)  " +
        "+ round(sum(nvl(a.inc_amt,0)+ nvl(a.incentive_02,0)),3)+ round(sum(nvl(a.ins_pro_amt,0)),3)+ round(sum(nvl(a.ale_stop_amt,0)),3) as total_wt, " + //8
        "round(sum(NVL(A.INCOME_TAX,0)),3) as income_tax,   " + //9
        "round(sum(NVL(A.UNION_AMT,0)),3) as union_amt,   " + //10
        "round(sum(nvl(A.SOCIAL_AMT,0)),3) as social, " + //11
        "round(sum(nvl(A.HEALTH_AMT,0)),3) as health, " + //12
       // "round(sum(NVL(A.INCOME_TAX,0)),3) " + 
        " round(sum(NVL(A.UNION_AMT,0)),3) + round(sum(nvl(a.unemp_ins,0)),3)  " +
        "+ round(sum(nvl(A.SOCIAL_AMT,0)),3) + ROUND(sum(NVL(A.ADVANCE_NO_PIT,0)),3) " + 
        "+ round(sum(nvl(A.HEALTH_AMT,0)),3) +  round(sum(nvl(a.ADVANCE_AMT,0)),3) + round(sum(nvl(health_card_amt,0)),3) as total_dt, " + //13
        "round(sum(nvl(A.SOCIAL_AMT,0))*3,3) as social_15, " + //14
        "round(sum(nvl(A.HEALTH_AMT,0))*2,3) as health_2,   " + //15
        "ROUND (sum(NVL (a.wt_l1, 0) + (NVL (a.hol_day_l1, 0) * 8) " + 
        "        + nVL (a.wt_l2, 0) + (NVL (a.hol_day_l2, 0) * 8)), 3) as wt_1, " + //16
        "ROUND (sum(NVL (a.ot_l1, 0)+NVL (a.ot_l2, 0)),3) as ot_1   , " + //17
        "ROUND (sum(NVL (a.st_l1, 0) + NVL (a.ht_l1, 0) " +
        "        +NVL (a.st_l2, 0) + NVL (a.ht_l2, 0)), 3) as ht, " + //18
        "ROUND (sum(NVL (a.nt_30_l1, 0)+NVL (a.nt_30_l2, 0)), 3) as st, " + //19
        "ROUND (sum(NVL (a.nt_45_l1, 0)+NVL (a.nt_45_l2, 0)), 3) as ot_45,   " + //20
        "ROUND (sum(NVL (a.st_l1_amt, 0) + NVL (a.ht_l1_amt, 0) " + 
        "        +NVL (a.st_l2_amt, 0) + NVL (a.ht_l2_amt, 0)), 3) as ht_amt, " + //21
        "ROUND (sum(NVL (a.nt_30_l1_amt, 0)+NVL (a.nt_30_l2_amt, 0)), 3) as st_amt, " + //22
        "ROUND (sum(NVL (a.nt_45_l1_amt, 0)+NVL (a.nt_45_l2_amt, 0)), 3) as ot_45_amt,    " + //23
        " round(sum(nvl(a.ADVANCE_AMT,0)),3) as advance,  " + //24
        " round(sum(nvl(a.unemp_ins,0)),3) as unemp_ins, " + //25
        "ROUND(sum(NVL(A.RETURN_NO_PIT,0)),3)," + //26
        "ROUND(sum(NVL(A.ADVANCE_NO_PIT,0)),3)," + //27
        "ROUND(sum(NVL(A.ins_pro_amt,0)),3)," + //28
        "ROUND(sum(NVL(A.ale_stop_amt,0)),3)," + //29
        "ROUND(sum(NVL(A.health_card_amt,0)),3)," + //30
        "round(sum(NVL(A.ALLOW_AMT1_L1 ,0) + NVL(A.ALLOW_AMT1_L2 ,0)),3)," + //31
        "round(sum(NVL(A.ALLOW_AMT4_L1 ,0) + NVL(A.ALLOW_AMT4_L2 ,0)),3)" + //32
                " from thr_month_salary a  " +
        "where a.del_if=0 and a.net_amt>0 and a.work_mon='" + p_work_mon + "' " +
        "group by a.EXCHANGE_RATE ";

  //  Response.Write(SQL);
  //  Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp, icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp = dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary this month");
        Response.End();
    }

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_total_salary_files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="Copy of bo sung luong phan mem_26793_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
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
.xl1526793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6526793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl6626793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl6726793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl6826793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl6926793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl7026793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl7126793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl7226793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl7326793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:normal;}
.xl7426793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl7526793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl7626793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl7726793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:normal;}
.xl7826793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl7926793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl8026793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl8126793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl8226793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl8326793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl8426793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl8526793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl8626793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl8726793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl8826793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:normal;}
.xl8926793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl9026793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl9126793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)\\&\0022 Hours\0022";
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl9226793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl9326793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl9426793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl9526793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl9626793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl9726793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)\\&\0022 Hours\0022";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl9826793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl9926793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl10026793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl10126793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl10226793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl10326793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)\\&\0022 Hours\0022";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl10426793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl10526793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl10626793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl10726793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl10826793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl10926793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl11026793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl11126793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl11226793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:normal;}
.xl11326793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl11426793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl11526793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:general;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl11626793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl11726793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl11826793
	{padding:0px;
	mso-ignore:padding;
	color:red;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl11926793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl12026793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl12126793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl12226793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl12326793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl12426793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl12526793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl12626793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl12726793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl12826793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl12926793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl13026793
	{padding:0px;
	mso-ignore:padding;
	color:red;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl13126793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl13226793
	{padding:0px;
	mso-ignore:padding;
	color:red;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl13326793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl13426793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl13526793
	{padding:0px;
	mso-ignore:padding;
	color:red;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl13626793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl13726793
	{padding:0px;
	mso-ignore:padding;
	color:red;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl13826793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl13926793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:normal;}
.xl14026793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:normal;}
.xl14126793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl14226793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl14326793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl14426793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl14526793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl14626793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl14726793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl14826793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl14926793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl15026793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl15126793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl15226793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl15326793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl15426793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl15526793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl15626793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl15726793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl15826793
	{padding:0px;
	mso-ignore:padding;
	color:red;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl15926793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl16026793
	{padding:0px;
	mso-ignore:padding;
	color:red;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0\0022 Usd\0022";
	text-align:right;
	vertical-align:bottom;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl16126793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl16226793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl16326793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl16426793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl16526793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl16626793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl16726793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl16826793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl16926793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl17026793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl17126793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl17226793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl17326793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl17426793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl17526793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl17626793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl17726793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl17826793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl17926793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl18026793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl18126793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl18226793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl18326793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl18426793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl18526793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl18626793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl18726793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl18826793
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl18926793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl19026793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl19126793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl19226793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl19326793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
.xl19426793
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
	mso-font-charset:163;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked hidden;
	white-space:nowrap;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>rpt_total_salary</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>59</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8805</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="5121"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1,4"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="Copy of bo sung luong phan mem_26793" align=center
x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1803 style='border-collapse:
 collapse;table-layout:fixed;width:1354pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=253 style='mso-width-source:userset;mso-width-alt:9252;width:190pt'>
 <col width=112 style='mso-width-source:userset;mso-width-alt:4096;width:84pt'>
 <col width=149 style='mso-width-source:userset;mso-width-alt:5449;width:112pt'>
 <col width=141 style='mso-width-source:userset;mso-width-alt:5156;width:106pt'>
 <col width=75 style='mso-width-source:userset;mso-width-alt:2742;width:56pt'>
 <col width=22 style='mso-width-source:userset;mso-width-alt:804;width:17pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=160 span=4 style='mso-width-source:userset;mso-width-alt:5851;
 width:120pt'>
 <col width=64 span=3 style='width:48pt'>
 <tr class=xl6526793 height=48 style='mso-height-source:userset;height:36.0pt'>
  <td colspan=13 height=48 width=1611 style='height:36.0pt;width:1210pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="Picture_x0020_3" o:spid="_x0000_s4114" type="#_x0000_t75"
   alt="logoSarahOK.png" style='position:absolute;margin-left:0;margin-top:0;
   width:81pt;height:45.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_total_salary_files/Copy%20of%20bo%20sung%20luong%20phan%20mem_26793_image001.png"
    o:title="logoSarahOK"/>
   <v:path arrowok="t"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:108px;
  height:61px'><img width=108 height=61
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" 
  alt=logoSarahOK.png v:shapes="Picture_x0020_3"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  
  <%
        double t_total_sal, t_insuracne_18, t_insuracne_25, t_total;
        double t_total_sal_usd, t_insuracne_18_usd, t_insuracne_25_usd, t_total_usd;
        double t_hours, t_salary, t_usd;
        double[] Rate_Total = new double[60];
        double[] Scale_Total = new double[60];
        double[] Scale_Total_1 = new double[60]; 
      
        for (int j = 1; j < icol_emp; j++)
        {
            Rate_Total[j - 1] = Double.Parse(dt_Emp.Rows[0][j].ToString()) / Double.Parse(dt_Emp.Rows[0][0].ToString());
        }

        for (int i = 1; i < 33; i++)
        {
            Scale_Total[i - 1] = Double.Parse(dt_Emp.Rows[0][i].ToString()) / Double.Parse(dt_Emp.Rows[0][8].ToString());
        }
      
      t_total_sal = Double.Parse(dt_Emp.Rows[0][8].ToString())- Double.Parse(dt_Emp.Rows[0][13].ToString());
      t_insuracne_18 =Double.Parse(dt_Emp.Rows[0][25].ToString())+ Double.Parse(dt_Emp.Rows[0][14].ToString())+ Double.Parse(dt_Emp.Rows[0][15].ToString());
      t_insuracne_25 = Double.Parse(dt_Emp.Rows[0][14].ToString()) + Double.Parse(dt_Emp.Rows[0][15].ToString())
                       + Double.Parse(dt_Emp.Rows[0][11].ToString()) + Double.Parse(dt_Emp.Rows[0][12].ToString())
                        +Double.Parse(dt_Emp.Rows[0][25].ToString()) + Double.Parse(dt_Emp.Rows[0][25].ToString());
      t_total = Double.Parse(dt_Emp.Rows[0][8].ToString()) + t_insuracne_18;

      t_total_sal_usd = t_total_sal / Double.Parse(dt_Emp.Rows[0][0].ToString());
      t_insuracne_18_usd = t_insuracne_18 / Double.Parse(dt_Emp.Rows[0][0].ToString());
      t_insuracne_25_usd = t_insuracne_25 / Double.Parse(dt_Emp.Rows[0][0].ToString());
      t_total_usd = t_total / Double.Parse(dt_Emp.Rows[0][0].ToString());
      
      t_hours = Double.Parse(dt_Emp.Rows[0][17].ToString())+ Double.Parse(dt_Emp.Rows[0][18].ToString())
                + Double.Parse(dt_Emp.Rows[0][19].ToString())+ Double.Parse(dt_Emp.Rows[0][20].ToString())
                + Double.Parse(dt_Emp.Rows[0][16].ToString());
      t_salary = Double.Parse(dt_Emp.Rows[0][21].ToString())+ Double.Parse(dt_Emp.Rows[0][22].ToString())
                + Double.Parse(dt_Emp.Rows[0][23].ToString())+ Double.Parse(dt_Emp.Rows[0][1].ToString())
                + Double.Parse(dt_Emp.Rows[0][2].ToString());
      t_usd = Rate_Total[0] + Rate_Total[1] + Rate_Total[20] + Rate_Total[21] + Rate_Total[22];

      for (int j = 1; j < icol_emp; j++)
      {
          Scale_Total_1[j - 1] = Double.Parse(dt_Emp.Rows[0][j].ToString()) / t_salary;
      }
  %>
  
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=13 height=48 class=xl16926793 width=1611 style='height:36.0pt;
    width:1210pt' x:str>TOÅNG HÔÏP LÖÔNG <%=dt_Com.Rows[0][5].ToString()%><span style='mso-spacerun:yes'> </span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl6626793 width=64 style='width:48pt'></td>
  <td class=xl6726793 width=64 style='width:48pt'></td>
  <td class=xl6826793 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl6526793 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=13 height=29 class=xl17026793 style='height:21.75pt'
  x:str><span
  style='mso-spacerun:yes'> </span>TOTAL SALARY REPORT IN <%=dt_Com.Rows[0][4].ToString()%><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl7026793></td>
  <td class=xl6626793></td>
  <td class=xl6826793></td>
 </tr>
 <tr class=xl6526793 height=32 style='height:24.0pt'>
  <td height=32 class=xl13826793 style='height:24.0pt'></td>
  <td class=xl6526793>Rate: <%=dt_Emp.Rows[0][0].ToString()%></td>
  <td class=xl6926793></td>
  <td class=xl7126793></td>
  <td class=xl6526793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6826793></td>
 </tr>
 <tr class=xl6526793 height=27 style='height:20.25pt'>
  <td height=27 class=xl13926793 width=58 style='height:20.25pt;width:44pt'>No.</td>
  <td colspan=3 class=xl17126793 style='border-right:.5pt solid black;
  border-left:none'>Actual salary</td>
  <td rowspan=2 class=xl17426793 x:str="USD"><span
  style='mso-spacerun:yes'> </span>USD<span style='mso-spacerun:yes'> </span></td>
  <td class=xl7326793 width=75 style='border-left:none;width:56pt'>Scale</td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6826793></td>
 </tr>
 <tr class=xl6526793 height=29 style='height:21.75pt'>
  <td height=29 class=xl14026793 width=58 style='height:21.75pt;border-top:
  none;width:44pt'>STT</td>
  <td colspan=3 class=xl18126793 style='border-right:.5pt solid black;
  border-left:none'>L&#432;&#417;ng Th&#7921;c T&#7871;</td>
  <td class=xl7726793 width=75 style='border-top:none;border-left:none;
  width:56pt'>T&#7881; l&#7879;</td>
  <td class=xl6626793></td>
  <td colspan=6 class=xl16426793>Total Hourly Salary (T&#7893;ng
  L&#432;&#417;ng Gi&#7901; Laøm)</td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6826793></td>
 </tr>
 <tr class=xl7526793 height=32 style='height:24.0pt'>
  <td height=32 class=xl14126793 style='height:24.0pt' x:num>1</td>
  <td class=xl7826793 style='border-top:none;border-left:none'>Basic salary</td>
  <td class=xl7926793 style='border-top:none;border-left:none'>Lg cơ bản</td>
  <td class=xl8026793 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'><%=dt_Emp.Rows[0][1].ToString()%>  </span></td>
  <td class=xl8126793 style='border-left:none' x:num><%=Rate_Total[0] %></td>
  <td class=xl8226793 x:num><%= Scale_Total[0] %></td>
  <td class=xl7426793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=32 style='height:24.0pt'>
  <td height=32 class=xl14126793 style='height:24.0pt' x:num>2</td>
  <td class=xl7826793 style='border-top:none;border-left:none'>Responsibility</td>
  <td class=xl7926793 style='border-top:none;border-left:none'>Lg trách nhiệm</td>
  <td class=xl8026793 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'><%=dt_Emp.Rows[0][31].ToString()%>  </span></td>
  <td class=xl8126793 style='border-left:none' x:num><%=Rate_Total[30] %></td>
  <td class=xl8226793 x:num><%= Scale_Total[30] %></td>
 <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl8726793 x:str="Hours"><span
  style='mso-spacerun:yes'> </span>Hours<span style='mso-spacerun:yes'> </span></td>
  <td class=xl8726793 x:str="Salary"><span
  style='mso-spacerun:yes'> </span>Salary<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl8726793 x:str="USD"><span
  style='mso-spacerun:yes'> </span>USD<span style='mso-spacerun:yes'> </span></td>
  <td class=xl8826793 width=160 style='border-left:none;width:120pt'>Scale</td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=32 style='height:24.0pt'>
  <td height=32 class=xl14126793 style='height:24.0pt' x:num>3</td>
  <td class=xl7826793 style='border-top:none;border-left:none'>Professional Skill</td>
  <td class=xl7926793 style='border-top:none;border-left:none'>Lg trợ cấp tay nghề</td>
  <td class=xl8026793 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'><%=dt_Emp.Rows[0][32].ToString()%>  </span></td>
  <td class=xl8126793 style='border-left:none' x:num><%=Rate_Total[31] %></td>
  <td class=xl8226793 x:num><%= Scale_Total[31] %></td>
   <td class=xl7426793></td>
  <td class=xl8926793>Daily</td>
  <td class=xl9026793 style='border-left:none' x:num="1">100%</td>
  <td class=xl9126793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][16].ToString()%></span></td>
  <td class=xl9226793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][1].ToString()%></span></td>
  <td class=xl9326793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=Rate_Total[0] %></span></td>
  <td class=xl9426793 style='border-left:none' x:num><%=Scale_Total_1[0]%></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=32 style='height:24.0pt'>
  <td height=32 class=xl14226793 style='height:24.0pt;border-top:none' x:num>4</td>
  <td class=xl8326793 style='border-top:none;border-left:none'>Attendence</td>
  <td class=xl8426793 style='border-top:none;border-left:none'>Chuyên c&#7847;n</td>
  <td class=xl8526793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][4].ToString()%> </span></td>
  <td class=xl8626793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[3] %></td>
  <td class=xl8226793 x:num><%= Scale_Total[3] %></td>
  <td class=xl7426793></td>
  <td class=xl9526793 style='border-top:none'>Overtime</td>
  <td class=xl9626793 style='border-top:none;border-left:none' x:num="1.5">150%</td>
  <td class=xl9726793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][17].ToString()%></span> </td>
  <td class=xl9826793 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'><%=dt_Emp.Rows[0][2].ToString()%></span> </td>
  <td class=xl9926793 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'><%=Rate_Total[1] %></span> </td>
  <td class=xl10026793 style='border-top:none' x:num><%=Scale_Total_1[1]%></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>5</td>
  <td class=xl8326793 style='border-top:none;border-left:none'>Housing&amp; Oil</td>
  <td class=xl8426793 style='border-top:none;border-left:none'>Sinh ho&#7841;t
  phí</td>
  <td class=xl8526793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][3].ToString()%></span></td>
  <td class=xl8626793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[2] %></td>
  <td class=xl8226793 x:num><%= Scale_Total[2] %></td>
  <td class=xl7426793></td>
  <td class=xl9526793 style='border-top:none'>Over Night</td>
  <td class=xl9626793 style='border-top:none;border-left:none' x:num="1.95">195%</td>
  <td class=xl9726793 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[0][20].ToString()%></td>
  <td class=xl9826793 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[0][23].ToString()%></td>
  <td class=xl9826793 style='border-top:none;border-left:none' x:num><%=Rate_Total[22] %><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl10026793 style='border-top:none' x:num><%=Scale_Total_1[22]%></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>6</td>
  <td class=xl8326793 style='border-top:none;border-left:none'>Overtime</td>
  <td class=xl8426793 style='border-top:none;border-left:none'>T&#259;ng Ca</td>
  <td class=xl8526793 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>      
  </span><%=dt_Emp.Rows[0][2].ToString()%></td>
  <td class=xl8626793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[1] %></td>
  <td class=xl8226793 x:num><%= Scale_Total[1] %></td>
  <td class=xl7426793></td>
  <td class=xl9526793 style='border-top:none'>Sunday</td>
  <td class=xl9626793 style='border-top:none;border-left:none' x:num="2">200%</td>
  <td class=xl9726793 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[0][19].ToString()%></td>
  <td class=xl9826793 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[0][22].ToString()%></td>
  <td class=xl9826793 style='border-top:none;border-left:none' x:num><%=Rate_Total[21] %><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl10026793 style='border-top:none' x:num><%=Scale_Total_1[21]%></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>7</td>
  <td class=xl8326793 style='border-top:none;border-left:none'>Other</td>
  <td class=xl8426793 style='border-top:none;border-left:none'>Hoàn Tr&#7843;
  Khác</td>
  <td class=xl8526793 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>          
  </span><%=dt_Emp.Rows[0][6].ToString()%> </td>
  <td class=xl8626793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[5] %></td>
  <td class=xl8226793 x:num><%= Scale_Total[5] %></td>
  <td class=xl7426793></td>
  <td class=xl9526793 style='border-top:none'>Shift work</td>
  <td class=xl9626793 style='border-top:none;border-left:none'  x:num="1.3">130%</td>
  <td class=xl9726793 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[0][18].ToString()%></td>
  <td class=xl9826793 style='border-top:none;border-left:none' x:num><%=dt_Emp.Rows[0][21].ToString()%></td>
  <td class=xl9826793 style='border-top:none;border-left:none' x:num><%=Rate_Total[20] %><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl10026793 style='border-top:none' x:num><%=Scale_Total_1[20]%></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>8</td>
  <td class=xl8326793 style='border-top:none;border-left:none'>Child</td>
  <td class=xl8426793 style='border-top:none;border-left:none'>Con Nh&#7887;</td>
  <td class=xl8526793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][5].ToString()%>           </span></td>
  <td class=xl8626793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[4] %></td>
  <td class=xl8226793 x:num><%= Scale_Total[4] %></td>
  <td class=xl7426793></td>
  <td class=xl11126793>Total</td>
  <td class=xl11226793 width=65 style='border-left:none;width:49pt'>T&#7893;ng
  s&#7889;</td>
  <td class=xl11326793 style='border-left:none' x:num><%=t_hours %></td>
  <td class=xl11426793 style='border-left:none' x:num><%=t_salary %></td>
  <td class=xl11526793 align=right style='border-left:none'
  x:num><%=t_usd %></td>
  <td class=xl11626793>100%</td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>9</td>
  <td class=xl8326793 style='border-top:none;border-left:none'>Insurance 17%</td>
  <td class=xl8426793 style='border-top:none;border-left:none'>BH 17%</td>
  <td class=xl8526793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][28].ToString()%>           </span></td>
  <td class=xl8626793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[27] %></td>
  <td class=xl8226793 x:num><%=Scale_Total[27]%></td>
  <td class=xl7426793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>10</td>
  <td class=xl8326793 style='border-top:none;border-left:none'>Remaining ALE</td>
  <td class=xl8426793 style='border-top:none;border-left:none'>Phép năm còn</td>
  <td class=xl8526793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][29].ToString()%>           </span></td>
  <td class=xl8626793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[28] %></td>
  <td class=xl8226793 x:num><%=Scale_Total[28]%></td>
  <td class=xl7426793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 
 
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>11</td>
  <td class=xl8326793 style='border-top:none;border-left:none'>Other Compensation (No PIT)</td>
  <td class=xl8426793 style='border-top:none;border-left:none'>Hoàn Tr&#7843;
  Khác</td>
  <td class=xl8526793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][26].ToString()%>           </span></td>
  <td class=xl8626793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[25] %></td>
  <td class=xl8226793 x:num><%= Scale_Total[25] %></td>
  <td class=xl7426793></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
  
 </tr>
 <tr class=xl7526793 height=32 style='height:24.0pt'>
  <td height=32 class=xl14326793 style='height:24.0pt;border-top:none' x:num>12</td>
  <td class=xl10726793 style='border-top:none;border-left:none'>Total Incentive</td>
  <td class=xl10826793 style='border-top:none;border-left:none'>T&#7893;ng
  Th&#432;&#7903;ng</td>
  <td class=xl8526793 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>      
  <%=dt_Emp.Rows[0][7].ToString()%></span></td>
  <td class=xl11026793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[6] %></td>
  <td class=xl8226793 x:num><%= Scale_Total[6] %></td>
  <td class=xl7426793></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
  
 </tr>
 <tr class=xl7526793 height=49 style='height:36.75pt'>
  <td colspan=2 height=49 class=xl17626793 style='height:36.75pt'>Actual Total</td>
  <td class=xl14926793 style='border-top:none'>&nbsp;</td>
  <td class=xl11726793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][8].ToString()%> </span> </td>
  <td class=xl11826793 style='border-left:none' x:num><%=Rate_Total[7] %></td>
  <td class=xl11926793 style='border-top:none;border-left:none' x:num="1">100.0%</td>
  <td class=xl7426793></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14126793 style='height:23.25pt;border-top:none' x:num>13</td>
  <td class=xl7226793 style='border-top:none;border-left:none'>Social Insurance
  (5%)</td>
  <td class=xl12026793 style='border-top:none;border-left:none' x:str="BHXH"><span
  style='mso-spacerun:yes'> </span>BHXH<span style='mso-spacerun:yes'> </span></td>
  <td class=xl8026793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][11].ToString()%></span></td>
  <td class=xl8126793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[10] %></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>14</td>
  <td class=xl12126793 style='border-top:none;border-left:none'>Health
  Insurance (1%)</td>
  <td class=xl12226793 style='border-top:none;border-left:none' x:str="BHYT"><span
  style='mso-spacerun:yes'> </span>BHYT<span style='mso-spacerun:yes'> </span></td>
  <td class=xl12326793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][12].ToString()%></span></td>
  <td class=xl8626793 style='border-left:none' x:num><%=Rate_Total[11] %></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>15</td>
  <td class=xl12126793 style='border-left:none'>Deduct Health Card</td>
  <td class=xl12226793 style='border-left:none' x:str><span
  style='mso-spacerun:yes'> </span>Khấu trừ thẻ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl12326793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][30].ToString()%></span></td>
  <td class=xl8626793 style='border-left:none' x:num><%=Rate_Total[29] %></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>16</td>
  <td class=xl12126793 style='border-left:none'>Unemployment Insurance (1%)</td>
  <td class=xl12226793 style='border-left:none' x:str="BHTN"><span
  style='mso-spacerun:yes'> </span>BHTN<span style='mso-spacerun:yes'> </span></td>
  <td class=xl12326793 style='border-left:none' x:num><%=dt_Emp.Rows[0][25].ToString()%><span
  style='mso-spacerun:yes'>         </span></td>
  <td class=xl8626793 style='border-left:none' x:num><%=Rate_Total[24] %></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt;border-top:none' x:num>17</td>
  <td class=xl12526793 style='border-left:none'>Income tax</td>
  <td class=xl12626793>Thu&#7871; Thu Nh&#7853;p</td>
  <td class=xl8526793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][9].ToString()%></span></td>
  <td class=xl8626793 style='border-left:none' x:num><%=Rate_Total[8] %></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=32 style='height:24.0pt'>
  <td height=32 class=xl14426793 style='height:24.0pt' x:num>18</td>
  <td class=xl14526793 style='border-left:none'>Union Fee</td>
  <td class=xl14726793>Công &#272;oàn</td>
  <td class=xl8526793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][10].ToString()%></span></td>
  <td class=xl8626793 style='border-left:none' x:num><%=Rate_Total[9] %></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt' x:num>19</td>
  <td class=xl12526793 style='border-left:none'>Other Deduction</td>
  <td class=xl12626793>Khấu trừ khác</td>
  <td class=xl12826793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][24].ToString()%></span></td>
  <td class=xl8626793 style='border-left:none' x:num><%=Rate_Total[23] %></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=31 style='height:23.25pt'>
  <td height=31 class=xl14226793 style='height:23.25pt' x:num>20</td>
  <td class=xl12526793 style='border-left:none'>Other Deduction (No PIT)</td>
  <td class=xl12626793>Tr&#7915; khác</td>
  <td class=xl12826793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][27].ToString()%></span></td>
  <td class=xl8626793 style='border-left:none' x:num><%=Rate_Total[26] %></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl15026793></td>
  <td class=xl15126793></td>
  <td class=xl15226793></td>
  <td class=xl15326793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=27 style='height:20.25pt'>
  <td colspan=2 height=27 class=xl19126793 style='height:20.25pt'>Total
  Deductions</td>
  <td class=xl14826793>T&#7893;ng Tr&#7915;</td>
  <td class=xl14626793 style='border-top:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][13].ToString()%></span></td>
  <td class=xl13026793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[12] %></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl15426793>Supervisor</td>
  <td class=xl15526793>Manager</td>
  <td class=xl15626793 x:str="V. President ">V. President<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl15526793 x:str="President ">President<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=29 style='height:21.75pt'>
  <td colspan=2 height=29 class=xl19326793 style='height:21.75pt'>Total Salary</td>
  <td class=xl12726793>T&#7893;ng L&#432;&#417;ng</td>
  <td class=xl13126793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=t_total_sal%></span></td>
  <td class=xl13226793 x:num><%=t_total_sal_usd%></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td rowspan=8 class=xl16726793 style='border-bottom:1.0pt solid black'>&nbsp;</td>
  <td rowspan=8 class=xl16526793 style='border-bottom:1.0pt solid black'>&nbsp;</td>
  <td rowspan=8 class=xl18726793 style='border-bottom:1.0pt solid black'></td>
  <td rowspan=8 class=xl16526793 style='border-bottom:1.0pt solid black'>&nbsp;</td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl13826793 style='height:30.0pt'></td>
  <td class=xl13326793></td>
  <td class=xl13326793></td>
  <td class=xl13426793></td>
  <td class=xl13326793></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl6526793 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl14126793 style='height:30.0pt' x:num>21</td>
  <td class=xl7226793 style='border-left:none'>Social Insurance (15%)</td>
  <td class=xl12026793 style='border-left:none' x:str="BHXH"><span
  style='mso-spacerun:yes'> </span>BHXH<span style='mso-spacerun:yes'> </span></td>
  <td class=xl8026793 style='border-left:none' x:num><span
  style='mso-spacerun:yes'><%=dt_Emp.Rows[0][14].ToString()%></span></td>
  <td class=xl8126793 style='border-left:none' x:num><%=Rate_Total[13] %></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl6526793></td>
  <td class=xl6826793></td>
  <td class=xl6526793></td>
 </tr>
 <tr class=xl6526793 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl14226793 style='height:18.0pt;border-top:none' x:num>22</td>
  <td class=xl12526793 style='border-top:none;border-left:none'>Health
  Insurance (2%)</td>
  <td class=xl16126793 style='border-top:none;border-left:none' x:str="BHYT"><span
  style='mso-spacerun:yes'> </span>BHYT<span style='mso-spacerun:yes'> </span></td>
  <td class=xl8526793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%= dt_Emp.Rows[0][15].ToString()%></span></td>
  <td class=xl8626793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[14] %></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl6526793></td>
  <td class=xl6826793></td>
  <td class=xl6526793></td>
 </tr>
 <tr class=xl7526793 height=32 style='height:24.0pt'>
  <td height=32 class=xl14326793 style='height:24.0pt;border-top:none' x:num>23</td>
  <td class=xl16226793 style='border-top:none;border-left:none'>Unemployment
  Insurance (1%)</td>
  <td class=xl16326793 style='border-top:none;border-left:none' x:str="BHTN"><span
  style='mso-spacerun:yes'> </span>BHTN<span style='mso-spacerun:yes'> </span></td>
  <td class=xl10926793 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'><%= dt_Emp.Rows[0][25].ToString()%></span></td>
  <td class=xl11026793 style='border-top:none;border-left:none'
  x:num><%=Rate_Total[24] %></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7426793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=27 style='height:20.25pt'>
  <td colspan=3 height=27 class=xl18426793 style='border-right:.5pt solid black;
  height:20.25pt'>Total Social, Health &amp; Unemployment Insurance<span
  style='mso-spacerun:yes'>  </span>(18%)</td>
  <td class=xl15926793 style='border-left:none' x:num><span style='mso-spacerun:yes'>        
  </span>
  <%=t_insuracne_18%>
  </td>
  <td class=xl16026793 style='border-left:none' x:num><%=t_insuracne_18_usd%></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=29 style='height:21.75pt'>
  <td colspan=3 height=29 class=xl17826793 style='border-right:.5pt solid black;
  height:21.75pt'>Total Social, Health &amp; Unemployment Insurance<span
  style='mso-spacerun:yes'>  </span>(25%)</td>
  <td class=xl15726793 style='border-left:none' x:num><span style='mso-spacerun:yes'>        
  <%=t_insuracne_25%>
  </span></td>
  <td class=xl15826793 style='border-left:none' x:num><%=t_insuracne_25_usd%></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl7526793 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl13826793 style='height:30.0pt'></td>
  <td class=xl6926793></td>
  <td class=xl7126793></td>
  <td class=xl6526793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl7426793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl7526793></td>
  <td class=xl7626793></td>
  <td class=xl7526793></td>
 </tr>
 <tr class=xl6526793 height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=2 height=45 class=xl18926793 style='height:33.75pt'>Total Salary</td>
  <td class=xl13626793 style='border-left:none'>T&#7893;ng L&#432;&#417;ng</td>
  <td class=xl13726793 style='border-left:none' x:num
  ><span style='mso-spacerun:yes'><%=t_total %></span></td>
  <td class=xl13526793 style='border-left:none' x:num><%=t_total_usd %></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6526793></td>
  <td class=xl6826793></td>
  <td class=xl6526793></td>
 </tr>
 <tr class=xl6526793 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl1526793 style='height:15.0pt'></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl6626793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6526793></td>
  <td class=xl6826793></td>
  <td class=xl6526793></td>
 </tr>
 <tr class=xl6526793 height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl1526793 style='height:33.75pt'></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl6626793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6526793></td>
  <td class=xl6826793></td>
  <td class=xl6526793></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl1526793 style='height:25.5pt'></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl1526793 style='height:16.5pt'></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl1526793 style='height:16.5pt'></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl6626793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
  <td class=xl1526793></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=58 style='width:44pt'></td>
  <td width=253 style='width:190pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=149 style='width:112pt'></td>
  <td width=141 style='width:106pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=160 style='width:120pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>