<%@ Page Language="C#"%>
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
    
    string p_dept,p_group,p_status,p_type,p_pay_type,p_emp_id,p_work_mon, p_m_type,month_eng,month_vie;
     
  
    p_dept       = Request["l_dept"].ToString();
    p_group      = Request["l_group"].ToString();
    p_status      = Request["l_status"].ToString();
    p_type       = Request["l_type"].ToString();
    p_pay_type   = Request["l_pay_type"].ToString();
    p_emp_id     = Request["l_emp_id"].ToString();
    p_work_mon   = Request["l_work_mon"].ToString();
    p_m_type = Request.QueryString["l_m_type"].ToString();
   DateTime t= new DateTime(int.Parse(p_work_mon.Substring(0,4).ToString()),int.Parse(p_work_mon.Substring(4,2).ToString()),1);
    month_eng=t.ToString("MMMM - yyyy").ToUpper();
    month_vie=t.ToString("MM - yyyy");


    string SQL
	= "select hr.thr_group_nm " + 
        ",sum(old1) " +
        ",sum(old2) " +
        ",sum(old3) " +
        ",sum(old4) " +
        ",sum(old5) " +
        ",sum(old6) " +
        ",sum(old7) " +
        ",sum(new1) " +
        ",sum(new2) " +
        ",sum(new3) " +
        ",sum(new4) " +
        ",sum(new5) " +
        ",sum(new6) " +
        ",sum(new7) " +
        ",sum(new6) - sum(old6)  " +
        ",max(old8) ex_old" +
        ",max(new8) ex_new" +
        ",to_char(add_months(to_date('" + p_work_mon + "','yyyymm'),-1),'MONTH - YYYY')  " +
        ",to_char(add_months(to_date('" + p_work_mon + "','yyyymm'),-1),'mm - YYYY') " +
        "from  " +
        "(select a.thr_group_pk,a.thr_group_nm " +
        ",count(a.thr_emp_pk) as old1 " +
        ",round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0) old2 " +
        ",round(round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0)/max(nvl(a.EXCHANGE_RATE,1)),2) old3 " +
        ",round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
        "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
        "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0) old4 " +
        ",round(round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
        "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
        "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0)/max(nvl(a.EXCHANGE_RATE,1)),2) old5 " +
        ",round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0) " +
        "    + round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
        "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
        "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0) as old6 " +
        ",round((round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0) " +
        "    + round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
        "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
        "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0))/max(nvl(a.EXCHANGE_RATE,1)),2) as old7 " +
        ",max(nvl(a.exchange_rate,1)) old8 " +
        ",0 new1 " +
        ",0 new2 " +
        ",0 new3 " +
        ",0 new4 " +
        ",0 new5 " +
        ",0 new6 " +
        ",0 new7 " +
        ",0 new8 " +
        "from thr_month_salary a " +
        "where a.del_if=0 " +
        "and a.WORK_MON=to_char(add_months(to_date('" + p_work_mon + "','yyyymm'),-1),'yyyymm')  " +
        " and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
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
        " and nvl(a.net_amt,0) " + p_type +
        "group by a.THR_GROUP_PK,a.THR_GROUP_NM " +
        "union all " +
        "select a.thr_group_pk,a.thr_group_nm " +
        ",0 old1 " +
        ",0 old2 " +
        ",0 old3 " +
        ",0 old4 " +
        ",0 old5 " +
        ",0 old6 " +
        ",0 old7 " +
        ",0 old8 " +
        ",count(a.thr_emp_pk) as new1 " +
        ",round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0) new2 " +
        ",round(round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0)/max(nvl(a.EXCHANGE_RATE,1)),2) new3 " +
        ",round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
        "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
        "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0) new4 " +
        ",round(round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
        "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
        "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0)/max(nvl(a.EXCHANGE_RATE,1)),2) new5 " +
        ",round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0) " +
        "    + round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
        "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
        "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0) as new6 " +
        ",round((round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0) " +
        "    + round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
        "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
        "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0))/max(nvl(a.EXCHANGE_RATE,1)),2) as new7 " +
        ",max(nvl(a.exchange_rate,1)) new8 " +
        "from thr_month_salary a " +
        "where a.del_if=0 " +
        "and a.WORK_MON='" + p_work_mon + "'  " +
        " and (a.tco_dept_pk in ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
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
        " and nvl(a.net_amt,0) " + p_type +
        "group by a.THR_GROUP_PK,a.THR_GROUP_NM) hr " +
        ",thr_group b " +
        "where b.del_if(+)=0 " +
        "and hr.thr_group_pk=b.pk(+) " +
        "group by hr.thr_group_pk,hr.thr_group_nm,nvl(b.seq,0) " +
        "order by nvl(b.seq,0),hr.thr_group_nm " ;





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
   
    //--------------------company information-----------------------
    string SQL_Com
	= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY'),to_char(to_date('" + p_work_mon + "','yyyymm'),'MM-YYYY') " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
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
<link rel=File-List href="rpt_comparison_salary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_comparison_salary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_comparison_salary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tyml</o:Author>
  <o:LastAuthor>tyml</o:LastAuthor>
  <o:LastPrinted>2009-05-27T08:59:46Z</o:LastPrinted>
  <o:Created>2009-05-27T08:37:47Z</o:Created>
  <o:LastSaved>2009-05-27T09:00:54Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in 0in 0in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-horizontal-page-align:center;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style714
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:"Comma_LUONG 04\.09NV LUYEN02";}
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
.xl1014
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl1015
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl1016
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl1017
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl1018
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1019
	{mso-style-parent:style714;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl1020
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl1021
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl1022
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1023
	{mso-style-parent:style714;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl1024
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;}
.xl1025
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl1026
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl1027
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl1028
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl1029
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl1030
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl1031
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl1032
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl1033
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl1034
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl1035
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl1036
	{mso-style-parent:style0;
	font-size:24.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl1037
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0;}
.xl1038
	{mso-style-parent:style714;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl1039
	{mso-style-parent:style714;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl1040
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";}
.xl1041
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl1042
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl1043
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:left;}
.xl1044
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl1045
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1046
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1047
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";}
.xl1048
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl1049
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";}
.xl1050
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";}
.xl1051
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl1052
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl1053
	{mso-style-parent:style0;
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
.xl1054
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1055
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1056
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1057
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1058
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1059
	{mso-style-parent:style714;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1060
	{mso-style-parent:style714;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1061
	{mso-style-parent:style714;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1062
	{mso-style-parent:style714;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1063
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1064
	{mso-style-parent:style714;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1065
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1066
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1067
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1068
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1069
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1070
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl1071
	{mso-style-parent:style714;
	font-size:8.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>ss tong luong</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>270</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>60</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:CodeName>Sheet23</x:CodeName>
     <x:TabColorIndex>53</x:TabColorIndex>
     <x:Selected/>
     <x:TopRowVisible>1</x:TopRowVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:SplitVertical>2</x:SplitVertical>
     <x:LeftColumnRightPane>2</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:Sorting>
     <x:Sort>Column B</x:Sort>
    </x:Sorting>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1052"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl1018>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1484 style='border-collapse:
 collapse;table-layout:fixed;width:1115pt'>
 <col class=xl1018 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl1018 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl1018 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl1018 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl1021 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl1018 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl1018 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl1022 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl1018 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl1018 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl1018 width=69 span=2 style='mso-width-source:userset;mso-width-alt:
 2523;width:52pt'>
 <col class=xl1018 width=71 span=2 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <col class=xl1018 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl1018 width=64 style='width:48pt'>
 <col class=xl1023 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl1018 width=64 span=5 style='width:48pt'>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=3 height=32 class=xl1020 width=160 style='height:24.0pt;
  width:121pt'>SUN KYOUNG, Ltd…</td>
  <td class=xl1018 width=80 style='width:60pt'></td>
  <td class=xl1021 width=80 style='width:60pt'></td>
  <td class=xl1018 width=76 style='width:57pt'></td>
  <td class=xl1018 width=78 style='width:59pt'></td>
  <td class=xl1022 width=79 style='width:59pt'></td>
  <td class=xl1018 width=66 style='width:50pt'></td>
  <td class=xl1018 width=43 style='width:32pt'></td>
  <td class=xl1018 width=69 style='width:52pt'></td>
  <td class=xl1018 width=69 style='width:52pt'></td>
  <td class=xl1018 width=71 style='width:53pt'></td>
  <td class=xl1018 width=71 style='width:53pt'></td>
  <td class=xl1018 width=77 style='width:58pt'></td>
  <td class=xl1018 width=64 style='width:48pt'></td>
  <td class=xl1023 width=81 style='width:61pt'></td>
  <td class=xl1018 width=64 style='width:48pt'></td>
  <td class=xl1018 width=64 style='width:48pt'></td>
  <td class=xl1018 width=64 style='width:48pt'></td>
  <td class=xl1018 width=64 style='width:48pt'></td>
  <td class=xl1018 width=64 style='width:48pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=6 height=24 class=xl1024 style='height:18.0pt'
  ><%=dt_Com.Rows[0][1] %><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=16 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=6 height=27 class=xl1024 style='height:20.25pt'><%=dt_Com.Rows[0][0] %></td>
  <td colspan=16 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=17 height=32 class=xl1016 width=1164 style='height:24.0pt;
  width:875pt'>MONTHLY SALARY COMPARISON</td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 colspan=2 class=xl1014 style='height:27.75pt;mso-ignore:colspan'></td>
  <td colspan=7 rowspan=2 class=xl1015 width=509 style='width:383pt'><span
  style='mso-spacerun:yes'> </span>TOTAL SALARY OF <%=dt_Emp.Rows[0][18].ToString() %><br>
    <span style='mso-spacerun:yes'> </span>( B&#7842;NG L&#431;&#416;NG
  T&#7892;NG THÁNG <%=dt_Emp.Rows[0][19].ToString() %>)</td>
  <td colspan=8 rowspan=2 class=xl1015 width=545 style='width:409pt'><span
  style='mso-spacerun:yes'> </span>TOTAL SALARY OF <%=month_eng %><br>
    <span style='mso-spacerun:yes'> </span>( B&#7842;NG L&#431;&#416;NG
  T&#7892;NG THÁNG <%=month_vie%>)</td>
  <td colspan=5 class=xl1014 style='mso-ignore:colspan'></td>
 </tr>

 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl1014 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl1014 style='mso-ignore:colspan'></td>
 </tr>
  <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=6></td>
  <td>Exchange Rate</td>
  <td></td>
  <td><%=dt_Emp.Rows[0][16].ToString() %></td>
  <td colspan=5></td>
  <td>Exchange Rate</td>
  <td></td>
  <td><%=dt_Emp.Rows[0][17].ToString() %></td>
  
 </tr>
 <tr class=xl1030 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td rowspan=2 height=76 class=xl1026 width=21 style='height:57.0pt;
  width:16pt'>No.</td>
  <td rowspan=2 class=xl1027 width=89 style='width:67pt'>SECTION</td>
  <td rowspan=2 class=xl1027 width=50 style='width:38pt'>Q'TY</td>
  <td rowspan=2 class=xl1027 width=80 style='width:60pt'>SALARY<br>
    (VND)<br>
    </td>
  <td rowspan=2 class=xl1028 width=80 style='width:60pt'>SALARY<br>
    (USD)<br>
    </td>
  <td rowspan=2 class=xl1027 width=76 style='width:57pt'>BH 25%<br>
    (VND)</td>
  <td rowspan=2 class=xl1027 width=78 style='width:59pt'>BH<br>
    (USD)</td>
  <td rowspan=2 class=xl1029 width=79 style='width:59pt'>TOTAL<br>
    (VND)</td>
  <td rowspan=2 class=xl1027 width=66 style='width:50pt'>TOTAL<br>
    (USD)</td>
  <td rowspan=2 class=xl1027 width=43 style='width:32pt'>Q'TY</td>
  <td rowspan=2 class=xl1027 width=69 style='width:52pt'>SALARY<br>
    (VND)</td>
  <td rowspan=2 class=xl1027 width=69 style='width:52pt'>SALARY<br>
    (USD)<br>
    </td>
  <td rowspan=2 class=xl1027 width=71 style='width:53pt'>BH 25%<br>
    (VND)</td>
  <td rowspan=2 class=xl1027 width=71 style='width:53pt'>BH<br>
    (USD)</td>
  <td rowspan=2 class=xl1027 width=77 style='width:58pt'>TOTAL<br>
    (VND)</td>
  <td rowspan=2 class=xl1027 width=64 style='width:48pt'>TOTAL<br>
    (USD)</td>
  <td rowspan=2 class=xl1019 width=81 style='width:61pt' x:str="CHÊNH L&#7878;CH"><span
  style='mso-spacerun:yes'> </span>CHÊNH L&#7878;CH<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl1030 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl1030 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 colspan=5 class=xl1030 style='height:32.25pt;mso-ignore:colspan'></td>
 </tr>
 <%
    int i;
    double[] Group_Total=new double[icol_emp];
    for (int j=0;j<icol_emp;j++)
    {
        Group_Total[j]=0;
    }
    
    for (i=0;i<irow_emp;i++)
    {
        for (int j=1;j<icol_emp-4;j++)
        {
            Group_Total[j-1]+=Double.Parse(dt_Emp.Rows[i][j].ToString());
        }
  %>
 <tr class=xl1032 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl1031 style='height:16.5pt' x:num><%=i+1 %></td>
  <td class=xl1053 style='border-left:none' x:num><%=dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl1053 style='border-left:none' x:num><%=dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl1054 style='border-left:none' x:num><%=dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl1055 style='border-left:none' x:num><%=dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl1056 style='border-left:none' x:num><%=dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl1055 style='border-left:none' x:num><%=dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl1057 style='border-left:none' x:num><%=dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl1055 style='border-left:none' x:num><%=dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl1054 style='border-left:none' x:num><%=dt_Emp.Rows[i][8].ToString() %></td>
  <td class=xl1054 style='border-left:none' x:num><%=dt_Emp.Rows[i][9].ToString() %></td>
  <td class=xl1055 style='border-left:none' x:num><%=dt_Emp.Rows[i][10].ToString() %></td>
  <td class=xl1056 style='border-left:none' x:num><%=dt_Emp.Rows[i][11].ToString() %></td>
  <td class=xl1055 style='border-left:none' x:num><%=dt_Emp.Rows[i][12].ToString() %></td>
  <td class=xl1058 style='border-left:none' x:num><%=dt_Emp.Rows[i][13].ToString() %></td>
  <td class=xl1055 style='border-left:none' x:num><%=dt_Emp.Rows[i][14].ToString() %></td>
  <td class=xl1059 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][15].ToString() %> </td>
  <td colspan=5 class=xl1032 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr class=xl1032 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=2 height=23 class=xl1033 style='border-right:.5pt solid black;
  height:17.25pt'>Total</td>
  <td class=xl1060 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=Group_Total[0] %></td>
  <td class=xl1061 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=Group_Total[1] %></td>
  <td class=xl1062 style='border-top:none;border-left:none' x:num><%=Group_Total[2] %></td>
  <td class=xl1061 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=Group_Total[3] %></td>
  <td class=xl1062 style='border-top:none;border-left:none' x:num><%=Group_Total[4] %></td>
  <td class=xl1063 style='border-top:none;border-left:none' x:num><%=Group_Total[5] %></td>
  <td class=xl1062 style='border-top:none;border-left:none' x:num><%=Group_Total[6] %></td>
  <td class=xl1064 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=Group_Total[7] %></td>
  <td class=xl1064 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=Group_Total[8] %></td>
  <td class=xl1062 style='border-top:none;border-left:none' x:num><%=Group_Total[9] %></td>
  <td class=xl1064 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=Group_Total[10] %></td>
  <td class=xl1062 style='border-top:none;border-left:none' x:num><%=Group_Total[11] %></td>
  <td class=xl1065 style='border-top:none;border-left:none' x:num><%=Group_Total[12] %></td>
  <td class=xl1062 style='border-top:none;border-left:none' x:num><%=Group_Total[13] %></td>
  <td class=xl1064 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=Group_Total[14] %></td>
  <td colspan=5 class=xl1032 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl1036 height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=2 height=45 class=xl1035 style='height:33.75pt'>TOTAL</td>
  <td class=xl1066 style='border-top:none;border-left:none' x:num><%=Group_Total[0] %></td>
  <td class=xl1067 style='border-top:none;border-left:none' x:num><%=Group_Total[1] %></td>
  <td class=xl1068 style='border-top:none;border-left:none' x:num><%=Group_Total[2] %></td>
  <td class=xl1067 style='border-top:none;border-left:none' x:num><%=Group_Total[3] %></td>
  <td class=xl1068 style='border-top:none;border-left:none' x:num><%=Group_Total[4] %></td>
  <td class=xl1069 style='border-top:none;border-left:none' x:num><%=Group_Total[5] %></td>
  <td class=xl1068 style='border-top:none;border-left:none' x:num><%=Group_Total[6] %></td>
  <td class=xl1066 style='border-top:none;border-left:none' x:num><%=Group_Total[7] %></td>
  <td class=xl1070 style='border-top:none;border-left:none' x:num><%=Group_Total[8] %></td>
  <td class=xl1068 style='border-top:none;border-left:none' x:num><%=Group_Total[9] %></td>
  <td class=xl1070 style='border-top:none;border-left:none' x:num><%=Group_Total[10] %></td>
  <td class=xl1068 style='border-top:none;border-left:none' x:num><%=Group_Total[11] %></td>
  <td class=xl1070 style='border-top:none;border-left:none' x:num><%=Group_Total[12] %></td>
  <td class=xl1068 style='border-top:none;border-left:none' x:num><%=Group_Total[13] %></td>
  <td class=xl1071 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=Group_Total[14] %></td>
  <td colspan=5 class=xl1036 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl1018 style='height:13.5pt'></td>
  <td class=xl1037></td>
  <td class=xl1018></td>
  <td class=xl1023></td>
  <td class=xl1038></td>
  <td colspan=2 class=xl1023 style='mso-ignore:colspan'></td>
  <td class=xl1039></td>
  <td class=xl1040></td>
  <td class=xl1018></td>
  <td colspan=4 class=xl1041 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl1018 style='height:18.75pt'></td>
  <td class=xl1037></td>
  <td class=xl1018></td>
  <td class=xl1040></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1040 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl1041 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1040 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl1042 colspan=9 style='height:15.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>             </span>NG&#431;&#7900;I L&#7852;P
  B&#7842;NG<span style='mso-spacerun:yes'>                    </span>K&#7870;
  TOÁN TR&#431;&#7902;NG<span
  style='mso-spacerun:yes'>                           </span>GIÁM &#272;&#7888;C</td>
  <td class=xl1018></td>
  <td colspan=4 class=xl1045 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=56 style='mso-height-source:userset;height:42.0pt'>
  <td height=56 colspan=3 class=xl1046 style='height:42.0pt;mso-ignore:colspan'></td>
  <td class=xl1047></td>
  <td class=xl1048></td>
  <td colspan=2 class=xl1047 style='mso-ignore:colspan'></td>
  <td class=xl1049></td>
  <td class=xl1046></td>
  <td class=xl1018></td>
  <td colspan=4 class=xl1020 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl1042 colspan=10 style='height:20.25pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>          </span>NGUY&#7876;N TH&#7882;
  LUY&#7870;N<span style='mso-spacerun:yes'>                 </span>NGÔ
  TH&#7882; KIM CHÂU<span style='mso-spacerun:yes'>                  
  </span>LEE KYOUNG SUN</td>
  <td colspan=4 class=xl1045 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=3 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1040></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1040 style='mso-ignore:colspan'></td>
  <td class=xl1050></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl1040 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 colspan=4 class=xl1018 style='height:29.25pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td class=xl1040></td>
  <td colspan=7 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl1018 style='height:13.5pt'></td>
  <td class=xl1040></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=4 class=xl1018 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl1018 style='height:13.5pt'></td>
  <td class=xl1051></td>
  <td class=xl1052></td>
  <td class=xl1018></td>
  <td class=xl1021></td>
  <td colspan=2 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1022></td>
  <td colspan=8 class=xl1018 style='mso-ignore:colspan'></td>
  <td class=xl1023></td>
  <td colspan=5 class=xl1018 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=21 style='width:16pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
