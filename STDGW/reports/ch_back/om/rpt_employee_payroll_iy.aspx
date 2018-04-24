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
	string p_dept,p_group,p_status,p_type,p_pay_type,p_emp_id,p_work_mon, p_m_type,p_times;
     
  
    p_dept       = Request["l_dept"].ToString();
    p_group      = Request["l_group"].ToString();
    p_status      = Request["l_status"].ToString();
    p_type       = Request["l_type"].ToString();
    p_pay_type   = Request["l_pay_type"].ToString();
    p_emp_id     = Request["l_emp_id"].ToString();
    p_work_mon   = Request["l_work_mon"].ToString();
    p_times = Request["l_Times_r"].ToString();
    p_m_type = Request.QueryString["l_m_type"].ToString();
	
	string SQL
	= "select null, A.EMP_ID,B.ORG_NM, A.FULL_NAME " + 
        "    , to_char(to_date(A.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        "    ,null,A.SALARY_LEVEL2,A.SALARY_LEVEL1 " +
        "    ,round( nvl(A.HOL_DAY_L1,0)+nvl(A.WT_L1,0)/8,3) " +
        "    ,round( nvl(A.HOL_DAY_L2,0)+nvl(A.WT_L2,0)/8,3) " +
        "    ,round( nvl(A.ABS_POWER_LOST_L1,0)/8+nvl( A.ABS_POWER_LOST_L2,0)/8,3) " +
        "    ,round( nvl(A.ABS_TEMP_REST_L1,0)/8+nvl( A.ABS_TEMP_REST_L2,0)/8,3) " +
        "    ,0 " +
        "    ,round(nvl(A.ABS_ALE_L1,0)/8+nvl( A.ABS_ALE_L2,0)/8,3) " +
        "    ,round(nvl(A.ABS_FUNERAL_L1,0)/8+nvl( A.ABS_FUNERAL_L2,0)/8 " +
        "        +nvl( A.ABS_LAC_L1,0)/8+nvl( A.ABS_LAC_L2,0)/8 " +
        "        +nvl( A.ABS_WED_L1,0)/8+nvl( A.ABS_WED_L2,0)/8,3) " +
        "    ,round(nvl(A.WT_L1_AMT,0)+nvl(A.WT_L2_AMT,0) " +
        "            +nvl(A.HOL_DAY_L1_AMT,0)+nvl(A.HOL_DAY_L2_AMT,0) " +
        "            +nvl(A.TOTAL_ABS_PAY_L1_AMT,0) " +
        "            +nvl(A.TOTAL_ABS_PAY_L2_AMT,0),3) " +
        "    ,round(nvl(A.ABS_PERMISSION_L1,0)/8+nvl(A.ABS_PERMISSION_L2,0)/8,3 )                    " +
        "    ,round(nvl(A.ABS_NON_PERMISSION_L1,0)/8+nvl(A.ABS_NON_PERMISSION_L2,0)/8,3 ) " +
        "    ,nvl(A.OT_L1,0) " +
        "    ,nvl(A.ST_L1,0) " +
        "    ,nvl(A.HT_L1,0) " +
        "    ,nvl(a.OT_L2,0) " +
        "    ,nvl(A.ST_L2,0) " +
        "    ,nvl(a.HT_L2,0) " +
        "    ,round(nvl(a.OT_L1_AMT,0)+nvl( a.OT_L2_AMT,0) " +
        "            +nvl(a.ST_L1_AMT,0)+nvl( a.ST_L2_AMT,0) " +
        "            +nvl(a.HT_L1_AMT,0)+nvl( a.HT_L2_AMT,0) ,3)     " +
        "    ,nvl(a.NT_30_L1,0) " +
        "    ,nvl(a.NT_45_L1,0) " +
        "    ,nvl(a.NT_60_L1,0) " +
        "    ,nvl(a.NT_30_L2,0) " +
        "    ,nvl(a.NT_45_L2,0) " +
        "    ,nvl(a.NT_60_L2,0) " +
        "    ,round(nvl(a.NT_30_L1_AMT,0)+nvl( a.NT_30_L2_AMT,0) " +
        "            +nvl( a.NT_45_L1_AMT,0)+nvl( a.NT_45_L2_AMT,0) " +
        "            +nvl( a.NT_60_L1_AMT,0)+nvl( a.NT_60_L2_AMT,0) ,3) " +
        "    ,round(nvl(a.ALLOW_K1_AMT,0),3) " +
        "    ,round(nvl(a.ALLOW_K3_AMT,0),3) " +
        "    ,round(nvl(a.ALLOW_K2_AMT,0),3)   " +
        "    ,round(nvl(a.INC_AMT,0),3) " +
        "    ,round(nvl(a.ALLOW_AMT1,0),3) " +
        "    ,round(nvl(a.ALLOW_AMT2,0),3) " +
        "    ,round(nvl(a.ALLOW_AMT3,0),3) " +
        "    ,round(nvl(a.ALLOW_AMT4,0),3) " +
        "    ,round(nvl(a.ALLOW_K4_AMT,0),3) " +
        "    ,round(nvl(a.ALLOW_K5_AMT,0),3) " +
        "    ,round(nvl(a.ALLOW_AMT5,0),3)   " +
        "    ,round(nvl(a.RETURN_AMT,0),3) " +
        "    ,round(nvl(a.SEVERANCE_AMT,0),3) " +
        "    ,round(nvl(a.ALE_STOP,0),3) " +
        "    ,round(nvl(a.ALE_STOP_AMT,0),3)  " +
        "    ,0,0 " +
        "    ,round(nvl(a.ALLOW_K1_AMT,0),3) " +
        "        +round(nvl(a.ALLOW_K3_AMT,0),3) " +
        "        +round(nvl(a.ALLOW_K2_AMT,0),3)   " +
        "        +round(nvl(a.INC_AMT,0),3) " +
        "        +round(nvl(a.ALLOW_AMT1,0),3) " +
        "        +round(nvl(a.ALLOW_AMT2,0),3) " +
        "        +round(nvl(a.ALLOW_AMT3,0),3) " +
        "        +round(nvl(a.ALLOW_AMT4,0),3) " +
        "        +round(nvl(a.ALLOW_K4_AMT,0),3) " +
        "        +round(nvl(a.ALLOW_K5_AMT,0),3) " +
        "        +round(nvl(a.ALLOW_AMT5,0),3)   " +
        "    ,round(nvl(a.GROSS_AMT,0),3) " +
        "    ,round(nvl(a.OT_TAX_L1_AMT,0)+nvl( a.OT_TAX_L2_AMT,0),3)     " +
        "    ,round(nvl(a.DEDUCT_PIT,0),3) " +
        "    ,round(nvl(a.HEALTH_AMT,0),3) " +
        "    ,round(nvl(a.SOCIAL_AMT,0),3) " +
        "    ,round(nvl(a.UNEMP_INS,0),3) " +
        "    ,round(nvl(a.UNION_AMT,0),3) " +
        "    ,round(nvl(a.INCOME_TAX,0),3) " +
        "    ,round(nvl(a.ADVANCE_AMT,0),3) " +
        "    ,0 " +
        "    ,round(nvl(a.HEALTH_AMT,0),3) " +
        "        +round(nvl(a.SOCIAL_AMT,0),3) " +
        "        +round(nvl(a.UNEMP_INS,0),3) " +
        "        +round(nvl(a.UNION_AMT,0),3) " +
        "        +round(nvl(a.INCOME_TAX,0),3) " +
        "        +round(nvl(a.ADVANCE_AMT,0),3)   " +
        "    ,round(nvl(a.NET_AMT,0),3)                   " +
        "from thr_month_salary_ur a, comm.tco_org b, thr_work_group c " +         
        "where a.del_if=0 and a.work_mon='" + p_work_mon + "' " +
        " and b.del_if=0 and c.del_if=0 and a.tco_dept_pk=b.pk and a.thr_group_pk=c.pk" +
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
        " order by A.DEPT_NM,a.emp_id";
		
	//Response.Write(SQL);
	//Response.End();

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count-2;
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
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="payroll_files/filelist.xml">
<link rel=Edit-Time-Data href="payroll_files/editdata.mso">
<link rel=OLE-Object-Data href="payroll_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>server</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2007-08-29T15:32:40Z</o:LastPrinted>
  <o:Created>2005-07-26T20:50:04Z</o:Created>
  <o:LastSaved>2011-05-14T04:20:36Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.46in 0in .5in .25in;
	mso-header-margin:0in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Vni-times;
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
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Vni-times;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl78
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl81
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl86
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl87
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl88
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl90
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl93
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl100
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl101
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl102
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl107
	{mso-style-parent:style43;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style43;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl109
	{mso-style-parent:style43;
	font-size:10.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	text-align:center;}
.xl111
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>21</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:ShowPageBreakZoom/>
     <x:PageBreakZoom>85</x:PageBreakZoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
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
       <x:ActiveRow>11</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
       <x:RangeSelection>$C$7:$C$9</x:RangeSelection>
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
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
  <x:WindowHeight>8010</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2325</x:WindowTopY>
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

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=5100 style='border-collapse:
 collapse;table-layout:fixed;width:3835pt'>
 <col class=xl65 width=69 style='mso-width-source:userset;mso-width-alt:1962;
 width:52pt'>
 <col class=xl65 width=94 style='mso-width-source:userset;mso-width-alt:2673;
 width:71pt'>
 <col class=xl65 width=181 style='mso-width-source:userset;mso-width-alt:5148;
 width:136pt'>
 <col class=xl65 width=75 style='mso-width-source:userset;mso-width-alt:2133;
 width:56pt'>
 <col class=xl65 width=72 style='mso-width-source:userset;mso-width-alt:2048;
 width:54pt'>
 <col class=xl65 width=118 style='mso-width-source:userset;mso-width-alt:3356;
 width:89pt'>
 <col class=xl65 width=97 style='mso-width-source:userset;mso-width-alt:2759;
 width:73pt'>
 <col class=xl65 width=70 span=7 style='mso-width-source:userset;mso-width-alt:
 1991;width:53pt'>
 <col class=xl65 width=109 style='mso-width-source:userset;mso-width-alt:3100;
 width:82pt'>
 <col class=xl65 width=57 span=2 style='mso-width-source:userset;mso-width-alt:
 1621;width:43pt'>
 <col class=xl65 width=71 span=6 style='mso-width-source:userset;mso-width-alt:
 2019;width:53pt'>
 <col class=xl65 width=99 style='mso-width-source:userset;mso-width-alt:2816;
 width:74pt'>
 <col class=xl65 width=51 span=6 style='mso-width-source:userset;mso-width-alt:
 1450;width:38pt'>
 <col class=xl65 width=83 style='mso-width-source:userset;mso-width-alt:2360;
 width:62pt'>
 <col class=xl65 width=84 style='mso-width-source:userset;mso-width-alt:2389;
 width:63pt'>
 <col class=xl65 width=78 span=10 style='mso-width-source:userset;mso-width-alt:
 2218;width:59pt'>
 <col class=xl65 width=90 span=7 style='mso-width-source:userset;mso-width-alt:
 2560;width:68pt'>
 <col class=xl65 width=117 span=3 style='mso-width-source:userset;mso-width-alt:
 3328;width:88pt'>
 <col class=xl65 width=99 span=6 style='mso-width-source:userset;mso-width-alt:
 2816;width:74pt'>
 <col class=xl65 width=100 span=2 style='mso-width-source:userset;mso-width-alt:
 2844;width:75pt'>
 <col class=xl65 width=128 style='mso-width-source:userset;mso-width-alt:3640;
 width:96pt'>
 <col class=xl65 width=81 span=195 style='mso-width-source:userset;mso-width-alt:
 2304;width:61pt'>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=42 rowspan=5 height=170 width=3197 style='height:127.5pt;
  width:2405pt' align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="Picture_x0020_2" o:spid="_x0000_s1036" type="#_x0000_t75"
   alt="HEAD" style='position:absolute;margin-left:552pt;margin-top:.75pt;
   width:831.75pt;height:103.5pt;z-index:1;visibility:visible'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" o:title="vinagenuwin"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:736px;margin-top:1px;width:1109px;
  height:138px'><img width=1109 height=138 src="payroll_files/image002.jpg"
  alt=HEAD v:shapes="Picture_x0020_2"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=42 rowspan=5 height=170 class=xl110 width=3197
    style='height:127.5pt;width:2405pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl65 width=90 style='width:68pt'></td>
  <td class=xl65 width=90 style='width:68pt'></td>
  <td class=xl65 width=90 style='width:68pt'></td>
  <td class=xl65 width=90 style='width:68pt'></td>
  <td class=xl65 width=90 style='width:68pt'></td>
  <td class=xl65 width=90 style='width:68pt'></td>
  <td class=xl65 width=90 style='width:68pt'></td>
  <td class=xl65 width=117 style='width:88pt'></td>
  <td class=xl65 width=117 style='width:88pt'></td>
  <td class=xl65 width=117 style='width:88pt'></td>
  <td class=xl65 width=99 style='width:74pt'></td>
  <td class=xl65 width=99 style='width:74pt'></td>
  <td class=xl65 width=99 style='width:74pt'></td>
  <td class=xl65 width=99 style='width:74pt'></td>
  <td class=xl65 width=99 style='width:74pt'></td>
  <td class=xl65 width=99 style='width:74pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=128 style='width:96pt'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 colspan=19 class=xl65 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 colspan=19 class=xl65 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 colspan=19 class=xl65 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 colspan=19 class=xl65 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=46 height=34 class=xl111 style='height:25.5pt'>PAYROLL SUMMARY
  FOR THE MONTH OF <%=dt_Com.Rows[0][4].ToString()%></td>
  <td colspan=15 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td rowspan=3 height=131 class=xl104 width=69 style='height:98.25pt;
  width:52pt'>Emp ID<br>
    <br>
    Mã NV</td>
  <td rowspan=3 class=xl104 width=94 style='width:71pt'>Group<br>
    <br>
    Nhóm</td>
  <td rowspan=3 class=xl104 width=181 style='width:136pt'>Full Name<br>
    <br>
    Họ Tên</td>
  <td rowspan=3 class=xl104 width=75 style='width:56pt'>Join date<br>
    <br>
    Ngày Vào<br>
    </td>
  <td rowspan=3 class=xl104 width=72 style='width:54pt'>Sign<br>
    <br>
    Ký nhận <br>
    </td>
  <td rowspan=3 class=xl104 width=118 style='width:89pt'>Basic Salary<br>
    ( VND)<br>
    Lương cơ bản<br>
    (VND)</td>
  <td rowspan=3 class=xl108 width=97 style='width:73pt'
  x:str="Probation Salary&#10;Lương T.V&#10;(VND)"><span
  style='mso-spacerun:yes'> </span>Probation Salary<br>
    Lương T.V<br>
    (VND)<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl108 width=140 style='border-left:none;width:106pt'
  x:str="Working days&#10;Ngày Công"><span
  style='mso-spacerun:yes'> </span>Working days<br>
    Ngày Công<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl108 width=70 style='width:53pt'
  x:str="Working days Lost Power"><span
  style='mso-spacerun:yes'> </span>Working days Lost Power<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl108 width=70 style='width:53pt'
  x:str="Temp rest in plan (Nghỉ chờ hàng)"><span
  style='mso-spacerun:yes'> </span>Temp rest in plan (Nghỉ chờ hàng)<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl108 width=70 style='width:53pt'
  x:str="Annual leave Last Year"><span style='mso-spacerun:yes'> </span>Annual
  leave Last Year<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl90 width=70 style='width:53pt'
  x:str="Ann leave&#10;Phép&#10;Năm"><span style='mso-spacerun:yes'> </span>Ann
  leave<br>
    Phép<br>
    Năm<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl90 width=70 style='width:53pt'
  x:str="Rem Due&#10;Nghỉ chế độ"><span style='mso-spacerun:yes'> </span>Rem
  Due<br>
    Nghỉ chế độ<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl90 width=109 style='width:82pt'
  x:str="WT Salary (VND)&#10;Lương ngày công (VND)"><span
  style='mso-spacerun:yes'> </span>WT Salary (VND)<br>
    Lương ngày công (VND)<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl108 width=114 style='border-left:none;width:86pt'
  x:str="Total Absent&#10;Tổng ngày vắng"><span
  style='mso-spacerun:yes'> </span>Total Absent<br>
    Tổng ngày vắng<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl109 width=426 style='border-left:none;width:318pt'
  x:str="Overtime Hours&#10;Giờ tăng Ca"><span
  style='mso-spacerun:yes'> </span>Overtime Hours<br>
    Giờ tăng Ca<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl90 width=99 style='width:74pt'
  x:str="Total &#10;Overtime&#10;&#10;Tổng tiền&#10;tăng Ca"><span
  style='mso-spacerun:yes'> </span>Total <br>
    Overtime<br>
    <br>
    Tổng tiền<br>
    tăng Ca<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl90 width=306 style='border-left:none;width:228pt'
  x:str="Night Shift&#10;Ca Đêm"><span style='mso-spacerun:yes'> </span>Night
  Shift<br>
    Ca Đêm<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl90 width=83 style='width:62pt'
  x:str="Total Night Shift&#10;&#10;Tổng tiền ca đêm"><span
  style='mso-spacerun:yes'> </span>Total Night Shift<br>
    <br>
    Tổng tiền ca đêm<span style='mso-spacerun:yes'> </span></td>
  <td colspan=11 class=xl105 width=864 style='border-left:none;width:653pt'>Allowance<br>
    Các loại trợ cấp</td>
  <td rowspan=3 class=xl90 width=90 style='width:68pt'
  x:str="Return &#10;&#10;Hoàn trả&#10;"><span
  style='mso-spacerun:yes'> </span>Return <br>
    <br>
    Hoàn trả<br>
    <span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl104 width=90 style='width:68pt'>Severance amount<br>
    <br>
    Trợ cấp T.V</td>
  <td rowspan=3 class=xl104 width=90 style='width:68pt'>Annual Leave Stop<br>
    <br>
    Phép năm còn lại</td>
  <td rowspan=3 class=xl104 width=90 style='width:68pt'>AL Stop AMT<br>
    <br>
    Tiền phép năm còn lại</td>
  <td rowspan=3 class=xl104 width=90 style='width:68pt'>AL remain last
  year<br>
    <br>
    Phép năm còn lại năm trước</td>
  <td rowspan=3 class=xl104 width=90 style='width:68pt'>AL remain last year
  AMT<br>
    <br>
    Tiền phép năm còn lại năm trước</td>
  <td rowspan=3 class=xl104 width=90 style='width:68pt'>Total Allowance<br>
    <br>
    Tổng trợ cấp</td>
  <td rowspan=3 class=xl105 width=117 style='width:88pt'>Gross Salary<br>
    <br>
    Tổng tiền</td>
  <td rowspan=3 class=xl105 width=117 style='width:88pt'>OT No Tax<br>
    <br>
    Tăng ca không thuế</td>
  <td rowspan=3 class=xl105 width=117 style='width:88pt'>Family Deduction<br>
    <br>
    Giảm trừ gia cảnh</td>
  <td colspan=6 class=xl105 width=594 style='border-left:none;width:444pt'>Deduction<br>
    Các loại khấu trừ</td>
  <td rowspan=3 class=xl105 width=100 style='width:75pt'>Advance<br>
    <br>
    Khấu trừ Tết</td>
  <td rowspan=3 class=xl105 width=100 style='width:75pt'>Total Deduction<br>
    <br>
    Tổng khấu trừ</td>
  <td rowspan=3 class=xl106 width=128 style='width:96pt'>Net salary<br>
    ( VND )<br>
    <br>
    Thực lãnh<br>
    VND</td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td rowspan=2 height=97 class=xl90 width=70 style='height:72.75pt;border-top:
  none;width:53pt' x:str="Prob&#10;T.V"><span
  style='mso-spacerun:yes'> </span>Prob<br>
    T.V<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl107 width=70 style='border-top:none;width:53pt'>Off<br>
    C.T</td>
  <td rowspan=2 class=xl108 width=57 style='border-top:none;width:43pt'
  x:str="Per.&#10;Có phép"><span style='mso-spacerun:yes'> </span>Per.<br>
    Có phép<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl108 width=57 style='border-top:none;width:43pt'
  x:str="Non Per.&#10;Không phép"><span style='mso-spacerun:yes'> </span>Non
  Per.<br>
    Không phép<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl109 width=213 style='border-left:none;width:159pt'
  x:str="Probation&#10;T.V"><span
  style='mso-spacerun:yes'> </span>Probation<br>
    T.V<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl109 width=213 style='border-left:none;width:159pt'
  x:str="Official&#10;C.T"><span
  style='mso-spacerun:yes'> </span>Official<br>
    C.T<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl90 width=153 style='border-left:none;width:114pt'
  x:str="Probation&#10;T.V"><span
  style='mso-spacerun:yes'> </span>Probation<br>
    T.V<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl90 width=153 style='border-left:none;width:114pt'
  x:str="Offical&#10;C.T"><span style='mso-spacerun:yes'> </span>Offical<br>
    C.T<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=84 style='border-top:none;width:63pt'
  x:str="Industrial AMT&#10;Chuyên cần"><span
  style='mso-spacerun:yes'> </span>Industrial AMT<br>
    Chuyên cần<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl103 width=78 style='border-top:none;width:59pt'>Gas
  AMT<br>
    Giao thông</td>
  <td rowspan=2 class=xl103 width=78 style='border-top:none;width:59pt'>Hire
  room<br>
    Trợ cấp nhà trọ</td>
  <td rowspan=2 class=xl102 width=78 style='border-top:none;width:59pt'
  x:str="Incentive&#10;Tiền thưởng"><span
  style='mso-spacerun:yes'> </span>Incentive<br>
    Tiền thưởng<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=78 style='border-top:none;width:59pt'
  x:str="Treat Allow&#10;Trợ cấp độc hại"><span
  style='mso-spacerun:yes'> </span>Treat Allow<br>
    Trợ cấp độc hại<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=78 style='border-top:none;width:59pt'
  x:str="Ability Allow&#10;Trợ cấp kỹ năng"><span
  style='mso-spacerun:yes'> </span>Ability Allow<br>
    Trợ cấp kỹ năng<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=78 style='border-top:none;width:59pt'
  x:str="Respon Allow&#10;Trợ cấp trách nhiệm"><span
  style='mso-spacerun:yes'> </span>Respon Allow<br>
    Trợ cấp trách nhiệm<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=78 style='border-top:none;width:59pt'
  x:str="Manager Allow&#10;Trợ cấp quản lý"><span
  style='mso-spacerun:yes'> </span>Manager Allow<br>
    Trợ cấp quản lý<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=78 style='border-top:none;width:59pt'
  x:str="Senior Allow&#10;Trợ cấp thâm niên"><span
  style='mso-spacerun:yes'> </span>Senior Allow<br>
    Trợ cấp thâm niên<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=78 style='border-top:none;width:59pt'
  x:str=" Children Allow&#10;Trợ cấp con nhỏ "><span style='mso-spacerun:yes'> 
  </span>Children Allow<br>
    Trợ cấp con nhỏ<span style='mso-spacerun:yes'>  </span></td>
  <td rowspan=2 class=xl102 width=78 style='border-top:none;width:59pt'
  x:str="Other&#10;Trợ cấp khác"><span
  style='mso-spacerun:yes'> </span>Other<br>
    Trợ cấp khác<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl103 width=99 style='border-top:none;width:74pt'>Health
  Insurance<br>
    <br>
    BHYT (1.5%)</td>
  <td rowspan=2 class=xl103 width=99 style='border-top:none;width:74pt'>Social
  Insurance<br>
    <br>
    BHXH (6%)</td>
  <td rowspan=2 class=xl103 width=99 style='border-top:none;width:74pt'>Unemployment
  Insurance <br>
    BHTN (1%)</td>
  <td rowspan=2 class=xl102 width=99 style='border-top:none;width:74pt'
  x:str="Union&#10;Phí công đoàn"><span
  style='mso-spacerun:yes'> </span>Union<br>
    Phí công đoàn<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=99 style='border-top:none;width:74pt'
  x:str="Income tax&#10;&#10;Thuế T.N"><span
  style='mso-spacerun:yes'> </span>Income tax<br>
    <br>
    Thuế T.N<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=99 style='border-top:none;width:74pt'
  x:str="Other&#10;&#10;K.T khác"><span
  style='mso-spacerun:yes'> </span>Other<br>
    <br>
    K.T khác<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td height=63 class=xl89 width=71 style='height:47.25pt;border-top:none;
  border-left:none;width:53pt' x:num>1.5</td>
  <td class=xl89 width=71 style='border-top:none;border-left:none;width:53pt'>2.0</td>
  <td class=xl89 width=71 style='border-top:none;border-left:none;width:53pt'>3.0</td>
  <td class=xl89 width=71 style='border-top:none;border-left:none;width:53pt'>1.5</td>
  <td class=xl89 width=71 style='border-top:none;border-left:none;width:53pt'>2.3</td>
  <td class=xl89 width=71 style='border-top:none;border-left:none;width:53pt'>3.0</td>
  <td class=xl90 width=51 style='border-top:none;border-left:none;width:38pt'
  x:str="'30%"><span style='mso-spacerun:yes'> </span>30%<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl90 width=51 style='border-top:none;border-left:none;width:38pt'
  x:str="'45%"><span style='mso-spacerun:yes'> </span>45%<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl90 width=51 style='border-top:none;border-left:none;width:38pt'
  x:str="'60%"><span style='mso-spacerun:yes'> </span>60%<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl90 width=51 style='border-top:none;border-left:none;width:38pt'
  x:str="'30%"><span style='mso-spacerun:yes'> </span>30%<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl90 width=51 style='border-top:none;border-left:none;width:38pt'
  x:str="'45%"><span style='mso-spacerun:yes'> </span>45%<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl90 width=51 style='border-top:none;border-left:none;width:38pt'
  x:str="'60%"><span style='mso-spacerun:yes'> </span>60%<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 
 <%
	int i=0,j=0,num=0;
	
	double[] Group_Total=new double[69];
    double[] Group_GTotal=new double[69];
	for(i=0;i<69;i++)
	{
		Group_Total[i]=0;
		Group_GTotal[i]=0;
	}
	for (i=0;i<irow_emp;i++)
    {
		num++;
		for(j=6;j<=61;j++)
		{
			Group_Total[j]+=double.Parse(dt_Emp.Rows[i][j].ToString());
			Group_GTotal[j]+=double.Parse(dt_Emp.Rows[i][j].ToString());
		}
 %>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl68 width=69 style='height:25.5pt;width:52pt'><%=dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl69><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl91 width=181 style='width:136pt'><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl70 width=75 style='width:56pt'><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl71 width=72 style='width:54pt'><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl72 width=118 style='width:89pt' x:num><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl72 width=97 style='width:73pt' x:num><%=dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl73 x:num><%=dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl73 x:num><%=dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl73 x:num><%=dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl74 x:num><%=dt_Emp.Rows[i][11].ToString()%></td>
  <td class=xl73 x:num><%=dt_Emp.Rows[i][12].ToString()%></td>
  <td class=xl73 x:num><%=dt_Emp.Rows[i][13].ToString()%></td>
  <td class=xl75 width=70 style='width:53pt' x:num><%=dt_Emp.Rows[i][14].ToString()%></td>
  <td class=xl75 width=109 style='width:82pt' x:num><%=dt_Emp.Rows[i][15].ToString()%></td>
  <td class=xl75 width=57 style='width:43pt' x:num><%=dt_Emp.Rows[i][16].ToString()%></td>
  <td class=xl75 width=57 style='width:43pt' x:num><%=dt_Emp.Rows[i][17].ToString()%></td>
  <td class=xl76 width=71 style='width:53pt' x:num><%=dt_Emp.Rows[i][18].ToString()%></td>
  <td class=xl76 width=71 style='width:53pt' x:num><%=dt_Emp.Rows[i][19].ToString()%></td>
  <td class=xl76 width=71 style='width:53pt' x:num><%=dt_Emp.Rows[i][20].ToString()%></td>
  <td class=xl76 width=71 style='width:53pt' x:num><%=dt_Emp.Rows[i][21].ToString()%></td>
  <td class=xl76 width=71 style='width:53pt' x:num><%=dt_Emp.Rows[i][22].ToString()%></td>
  <td class=xl76 width=71 style='width:53pt' x:num><%=dt_Emp.Rows[i][23].ToString()%></td>
  <td class=xl75 width=99 style='width:74pt' x:num><%=dt_Emp.Rows[i][24].ToString()%></td>
  <td class=xl76 width=51 style='width:38pt' x:num><%=dt_Emp.Rows[i][25].ToString()%></td>
  <td class=xl76 width=51 style='width:38pt' x:num><%=dt_Emp.Rows[i][26].ToString()%></td>
  <td class=xl76 width=51 style='width:38pt' x:num><%=dt_Emp.Rows[i][27].ToString()%></td>
  <td class=xl76 width=51 style='width:38pt' x:num><%=dt_Emp.Rows[i][28].ToString()%></td>
  <td class=xl76 width=51 style='width:38pt' x:num><%=dt_Emp.Rows[i][29].ToString()%></td>
  <td class=xl76 width=51 style='width:38pt' x:num><%=dt_Emp.Rows[i][30].ToString()%></td>
  <td class=xl75 width=83 style='width:62pt' x:num><%=dt_Emp.Rows[i][31].ToString()%></td>
  <td class=xl72 width=84 style='width:63pt' x:num><%=dt_Emp.Rows[i][32].ToString()%></td>
  <td class=xl72 width=78 style='width:59pt' x:num><%=dt_Emp.Rows[i][33].ToString()%></td>
  <td class=xl72 width=78 style='width:59pt' x:num><%=dt_Emp.Rows[i][34].ToString()%></td>
  <td class=xl72 width=78 style='width:59pt' x:num><%=dt_Emp.Rows[i][35].ToString()%></td>
  <td class=xl72 width=78 style='width:59pt' x:num><%=dt_Emp.Rows[i][36].ToString()%></td>
  <td class=xl72 width=78 style='width:59pt' x:num><%=dt_Emp.Rows[i][37].ToString()%></td>
  <td class=xl72 width=78 style='width:59pt' x:num><%=dt_Emp.Rows[i][38].ToString()%></td>
  <td class=xl72 width=78 style='width:59pt' x:num><%=dt_Emp.Rows[i][39].ToString()%></td>
  <td class=xl72 width=78 style='width:59pt' x:num><%=dt_Emp.Rows[i][40].ToString()%></td>
  <td class=xl72 width=78 style='width:59pt' x:num><%=dt_Emp.Rows[i][41].ToString()%></td>
  <td class=xl72 width=78 style='width:59pt' x:num><%=dt_Emp.Rows[i][42].ToString()%></td>
  <td class=xl72 width=90 style='width:68pt' x:num><%=dt_Emp.Rows[i][43].ToString()%></td>
  <td class=xl72 width=90 style='width:68pt' x:num><%=dt_Emp.Rows[i][44].ToString()%></td>
  <td class=xl73 x:num><%=dt_Emp.Rows[i][45].ToString()%></td>
  <td class=xl73 x:num><%=dt_Emp.Rows[i][46].ToString()%></td>
  <td class=xl73 x:num><%=dt_Emp.Rows[i][47].ToString()%></td>
  <td class=xl73 x:num><%=dt_Emp.Rows[i][48].ToString()%></td>
  <td class=xl72 width=90 style='width:68pt' x:num><%=dt_Emp.Rows[i][49].ToString()%></td>
  <td class=xl72 width=117 style='width:88pt' x:num><%=dt_Emp.Rows[i][50].ToString()%></td>
  <td class=xl72 width=117 style='width:88pt' x:num><%=dt_Emp.Rows[i][51].ToString()%></td>
  <td class=xl72 width=117 style='width:88pt' x:num><%=dt_Emp.Rows[i][52].ToString()%></td>
  <td class=xl72 width=99 style='width:74pt' x:num><%=dt_Emp.Rows[i][53].ToString()%></td>
  <td class=xl72 width=99 style='width:74pt' x:num><%=dt_Emp.Rows[i][54].ToString()%></td>
  <td class=xl72 width=99 style='width:74pt' x:num><%=dt_Emp.Rows[i][55].ToString()%></td>
  <td class=xl72 width=99 style='width:74pt' x:num><%=dt_Emp.Rows[i][56].ToString()%></td>
  <td class=xl72 width=99 style='width:74pt' x:num><%=dt_Emp.Rows[i][57].ToString()%></td>
  <td class=xl72 width=99 style='width:74pt' x:num><%=dt_Emp.Rows[i][58].ToString()%></td>
  <td class=xl72 width=100 style='width:75pt' x:num><%=dt_Emp.Rows[i][59].ToString()%></td>
  <td class=xl72 width=100 style='width:75pt' x:num><%=dt_Emp.Rows[i][60].ToString()%></td>
  <td class=xl72 width=128 style='width:96pt' x:num><%=dt_Emp.Rows[i][61].ToString()%></td>
 </tr>
 
 <%
		
		if(i<irow_emp-1)
		{
			if( dt_Emp.Rows[i][2].ToString() !=dt_Emp.Rows[i+1][2].ToString())
			{
 %>
 
 <tr class=xl67 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=5 height=34 class=xl93 style='border-right:.5pt solid black;
  height:25.5pt'>Total of <%=dt_Emp.Rows[i][2].ToString()%> (<%=num%> persons)</td>
  <td class=xl77 x:num><%=Group_Total[6].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[7].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[8].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[9].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[10].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[11].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[12].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[13].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[14].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[15].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[16].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[17].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[18].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[19].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[20].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[21].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[22].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[23].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[24].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[25].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[26].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[27].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[28].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[29].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[30].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[31].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[32].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[33].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[34].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[35].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[36].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[37].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[38].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[39].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[40].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[41].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[42].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[43].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[44].ToString()%></td>
  <td class=xl78 x:num><%=Group_Total[45].ToString()%></td>
  <td class=xl78 x:num><%=Group_Total[46].ToString()%></td>
  <td class=xl78 x:num><%=Group_Total[47].ToString()%></td>
  <td class=xl78 x:num><%=Group_Total[48].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[49].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[50].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[51].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[52].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[53].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[54].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[55].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[56].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[57].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[58].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[59].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[60].ToString()%></td>
  <td class=xl79 align=right width=128 style='width:96pt' x:num><%=Group_Total[61].ToString()%></td>
 </tr>
<%
				for(int k=0;k<69;k++)
					Group_Total[k]=0;
				num=0;
			}
		}
			%>			 
 <%
	}
 %>
 <tr class=xl67 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=5 height=34 class=xl93 style='border-right:.5pt solid black;
  height:25.5pt'>Total of <%=dt_Emp.Rows[i-1][2].ToString()%> (<%=num%> persons)</td>
  <td class=xl77 x:num><%=Group_Total[6].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[7].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[8].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[9].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[10].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[11].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[12].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[13].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[14].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[15].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[16].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[17].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[18].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[19].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[20].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[21].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[22].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[23].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[24].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[25].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[26].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[27].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[28].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[29].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[30].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[31].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[32].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[33].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[34].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[35].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[36].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[37].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[38].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[39].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[40].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[41].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[42].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[43].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[44].ToString()%></td>
  <td class=xl78 x:num><%=Group_Total[45].ToString()%></td>
  <td class=xl78 x:num><%=Group_Total[46].ToString()%></td>
  <td class=xl78 x:num><%=Group_Total[47].ToString()%></td>
  <td class=xl78 x:num><%=Group_Total[48].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[49].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[50].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[51].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[52].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[53].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[54].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[55].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[56].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[57].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[58].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[59].ToString()%></td>
  <td class=xl77 x:num><%=Group_Total[60].ToString()%></td>
  <td class=xl79 align=right width=128 style='width:96pt' x:num><%=Group_Total[61].ToString()%></td>
 </tr> 

 
  <tr class=xl80 height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=5 height=34 class=xl96 style='border-right:.5pt solid black;
  height:25.5pt'>Grant Total (<%=i+1%> persons)</td>
  <td class=xl82 x:num><%=Group_GTotal[6].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[7].ToString()%></td>
  <td class=xl82 x:str><%=Group_GTotal[8].ToString()%></td>
  <td class=xl82 x:str><%=Group_GTotal[9].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[10].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[11].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[12].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[13].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[14].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[15].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[16].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[17].ToString()%></td>
  <td class=xl82 x:str><%=Group_GTotal[18].ToString()%></td>
  <td class=xl82 x:str><%=Group_GTotal[19].ToString()%></td>
  <td class=xl82 x:str><%=Group_GTotal[20].ToString()%></td>
  <td class=xl82 x:str><%=Group_GTotal[21].ToString()%></td>
  <td class=xl82 x:str><%=Group_GTotal[22].ToString()%></td>
  <td class=xl82 x:str><%=Group_GTotal[23].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[24].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[25].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[26].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[27].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[28].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[29].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[30].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[31].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[32].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[33].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[34].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[35].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[36].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[37].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[38].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[39].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[40].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[41].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[42].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[43].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[44].ToString()%></td>
  <td class=xl83 x:num><%=Group_GTotal[45].ToString()%></td>
  <td class=xl83 x:num><%=Group_GTotal[46].ToString()%></td>
  <td class=xl83 x:num><%=Group_GTotal[47].ToString()%></td>
  <td class=xl83 x:num><%=Group_GTotal[48].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[49].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[50].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[51].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[52].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[53].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[54].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[55].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[56].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[57].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[58].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[59].ToString()%></td>
  <td class=xl82 x:num><%=Group_GTotal[60].ToString()%></td>
  <td class=xl84 align=right x:num><%=Group_GTotal[61].ToString()%></td>
 </tr>
 

 
  
   
 
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=61 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=61 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'></td>
  <td colspan=4 class=xl99 x:str>Tổng
  số tiền lương trích nộp BHXH-YT-TN:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl88 align=right x:num >61,344,000</td>
  <td colspan=55 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=61 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=61 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl86 height=24 style='height:18.0pt'>
  <td height=24 colspan=2 class=xl86 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl87>GENERAL DIRECTOR</td>
  <td colspan=6 class=xl86 style='mso-ignore:colspan'></td>
  <td class=xl66 colspan=4 style='mso-ignore:colspan'>PRODUCTION MANAGER</td>
  <td colspan=13 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl66 colspan=6 style='mso-ignore:colspan'>HUMAN RESOURSE DEPARTMENT</td>
  <td class=xl66></td>
  <td class=xl87></td>
  <td colspan=3 class=xl86 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl87>CREATE BY</td>
  <td colspan=21 class=xl86 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=2 class=xl65 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl100>(Signature)</td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl85 colspan=2 style='mso-ignore:colspan'>(Signature)</td>
  <td colspan=6 class=xl85 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl85></td>
  <td colspan=2 class=xl100>(Signature)</td>
  <td class=xl85></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl101>(Signature)</td>
  <td class=xl85></td>
  <td colspan=20 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=61 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=61 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=61 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=61 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=61 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=2 class=xl65 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl92>LEE JAE GUN</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl92>AHN LEE LOCK</td>
  <td colspan=13 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl92>QUÁCH THỊ DUNG</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl81 colspan=2 style='mso-ignore:colspan'>PHẠM THỊ TRANG</td>
  <td class=xl81></td>
  <td colspan=20 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
