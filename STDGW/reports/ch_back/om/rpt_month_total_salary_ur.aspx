<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
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
     = "select a.thr_group_nm as section0 " +
         ",count(a.thr_emp_pk) as qty1 " +
         ",round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0) sal_vnd2 " +
         ",round(round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0)/max(nvl(a.EXCHANGE_RATE,1)),2) sal_usd3 " +
         ",round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
         "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
         "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0) ins_vnd4 " +
         ",round(round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
         "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
         "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0)/max(nvl(a.EXCHANGE_RATE,1)),2) ins_usd5 " +
         ",round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0) " +
         "    + round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
         "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
         "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0) as total_vnd6 " +
         ",round((round(sum(round(decode(a.MONEY_KIND,'01',nvl(a.NET_amt,0),nvl(a.net_amt,0)* nvl(a.exchange_rate,1)),0)),0) " +
         "    + round(sum(nvl(a.SOCIAL_AMT,0) + nvl(a.SOCIAL_COM_NET,0) + nvl(a.SOCIAL_COMPANY,0) " +
         "    +  nvl(a.health_AMT,0) + nvl(a.health_COM_NET,0) + nvl(a.health_COMPANY,0) " +
         "    + nvl(a.UNEMP_INS,0) + nvl(a.UNEMP_INS_NET,0) + nvl(a.UNEMP_COM_INS,0)),0))/max(nvl(a.EXCHANGE_RATE,1)),2) as total_usd7 "+
        ",max(nvl(a.EXCHANGE_RATE,1)) ex8 " +
        "from thr_month_salary_ur a, thr_group b " +
        "where a.del_if=0 and b.del_if(+)=0  " +
        "and a.WORK_MON='" + p_work_mon + "' and a.thr_group_pk=b.pk(+) " +
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
        " and nvl(a.net_amt,0) " + p_type  +
        " group by a.THR_GROUP_PK,a.THR_GROUP_NM,b.SEQ " +
        " order by nvl(b.seq,0),a.thr_group_nm " ;




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
<link rel=File-List href="rpt_total_salary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_total_salary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_total_salary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tyml</o:Author>
  <o:LastAuthor>tyml</o:LastAuthor>
  <o:LastPrinted>2009-05-27T03:41:49Z</o:LastPrinted>
  <o:Created>2009-05-27T03:35:37Z</o:Created>
  <o:LastSaved>2009-05-27T03:43:45Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.37in .24in .35in .27in;
	mso-header-margin:.36in;
	mso-footer-margin:.16in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style45
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
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style45;
	font-size:8.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:left;}
.xl54
	{mso-style-parent:style45;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl55
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";}
.xl56
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";}
.xl62
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl63
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0";
	text-align:left;}
.xl64
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl65
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl66
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style45;
	font-family:VNi-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:left;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;}
.xl74
	{mso-style-parent:style0;
	font-style:italic;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:vni-times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>87</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
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
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>375</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=940 style='border-collapse:
 collapse;table-layout:fixed;width:705pt'>
 <col class=xl26 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl62 width=116 style='mso-width-source:userset;mso-width-alt:4242;
 width:87pt'>
 <col class=xl26 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl26 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl66 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl26 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl66 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl26 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl66 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl26 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl26 width=57 style='mso-width-source:userset;mso-width-alt:2084;
 width:43pt'>
 <col class=xl26 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl25 width=201 style='height:24.0pt;width:151pt'><%=dt_Com.Rows[0][0] %></td>
  <td class=xl26 width=104 style='width:78pt'></td>
  <td class=xl66 width=80 style='width:60pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl66 width=73 style='width:55pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl66 width=75 style='width:56pt'></td>
  <td class=xl26 width=87 style='width:65pt'></td>
  <td class=xl26 width=57 style='width:43pt'></td>
  <td class=xl26 width=71 style='width:53pt'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=10 rowspan=2 height=62 class=xl27 width=812 style='height:46.5pt;width:609pt'><span
  style='mso-spacerun:yes'> </span>TOTAL SALARY OF <%=month_eng %><br>
    <span style='mso-spacerun:yes'> </span>(BẢNG TỔNG LƯƠNG THÁNG <%=month_vie %>)</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl29 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=3 height=32 class=xl25 width=201 style='height:24.0pt;width:151pt'></td>
  <td class=xl26 width=104 style='width:78pt'></td>
  <td class=xl66 width=80 style='width:60pt'></td>
  <td class=xl26 width=96 style='width:72pt'></td>
  <td class=xl66 width=73 style='width:55pt'><b>Exchange Rate:</b></td>
  <td class=xl26 width=87 style='width:65pt'></td>
  <td class=xl26 width=71 style='width:53pt;mso-number-format:"\#\,\#\#0\;\[Red\]\#\,\#\#0"' x:num><%=dt_Emp.Rows[0][8].ToString() %></td>
 </tr>
 <tr class=xl33 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td rowspan=2 height=62 class=xl30 width=39 style='border-bottom:.5pt solid black;
  height:46.5pt;width:29pt'>No.</td>
  <td rowspan=2 class=xl31 width=116 style='border-bottom:.5pt solid black;
 width:87pt'>SECTION</td>
  <td rowspan=2 class=xl32 width=46 style='border-bottom:.5pt solid black;
  width:35pt'>Q'TY</td>
  <td rowspan=2 class=xl32 width=104 style='border-bottom:.5pt solid black;
 width:78pt'>SALARY<br>
    (VND)</td>
  <td rowspan=2 class=xl67 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>SALARY<br>
    (USD)</td>
  <td rowspan=2 class=xl32 width=96 style='border-bottom:.5pt solid black;
  width:72pt'>BH 25%<br>
    (VND)</td>
  <td rowspan=2 class=xl67 width=73 style='border-bottom:.5pt solid black;
  width:55pt'>BH<br>
    (USD)</td>
  <td rowspan=2 class=xl32 width=96 style='border-bottom:.5pt solid black;
  width:72pt'>TOTAL<br>
    (VND)</td>
  <td rowspan=2 class=xl67 width=75 style='border-bottom:.5pt solid black;
  width:56pt'>TOTAL<br>
    (USD)</td>
  <td rowspan=2 class=xl32 width=87 style='border-bottom:.5pt solid black;
  width:65pt'>KÝ NHẬN</td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl33 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 colspan=2 class=xl33 style='height:21.75pt;mso-ignore:colspan'></td>
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
        for (int j=1;j<icol_emp;j++)
        {
            Group_Total[j-1]+=Double.Parse(dt_Emp.Rows[i][j].ToString());
        }
  %>
 <tr class=xl43 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl37 style='height:27.0pt;mso-text-control:shrinktofit;' x:num><%=i+1 %></td>
  <td class=xl38 style='mso-text-control:shrinktofit;' x:num><%=dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl39 style='mso-text-control:shrinktofit;' x:num><%=dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl39 style='mso-text-control:shrinktofit;' x:num><%=dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl69 style='mso-text-control:shrinktofit;' x:num><%=dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl40 style='mso-text-control:shrinktofit;' x:num><%=dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl74 style='mso-text-control:shrinktofit;' x:num><%=dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl41 style='mso-text-control:shrinktofit;' x:num><%=dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl77 style='mso-text-control:shrinktofit;' x:num><%=dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl42 style='mso-text-control:shrinktofit;'>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr class=xl43 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=2 height=36 class=xl44 style='border-right:.5pt solid black;
  height:27.0pt'>Total</td>
  <td class=xl46 style='border-top:none;border-left:none;mso-text-control:shrinktofit;' x:num><span
  style='mso-spacerun:yes'>           </span><%=Group_Total[0] %> </td>
  <td class=xl46 style='border-top:none;border-left:none;mso-text-control:shrinktofit;' x:num><span
  style='mso-spacerun:yes'>                              </span><%=Group_Total[1] %>  </td>
  <td class=xl69 style='border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[2] %> </td>
  <td class=xl46 style='border-top:none;border-left:none;mso-text-control:shrinktofit;' x:num><span
  style='mso-spacerun:yes'>                           </span><%=Group_Total[3] %> </td>
  <td class=xl75 style='border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[4] %> </td>
  <td class=xl47 style='border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[5] %> </td>
  <td class=xl76 style='border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[6] %> </td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl52 height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=2 height=45 class=xl48 style='border-right:.5pt solid black;
  height:33.75pt'>TOTAL</td>
  <td class=xl50 style='border-top:none;border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[0] %></td>
  <td class=xl50 style='border-top:none;border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[1] %></td>
  <td class=xl70 style='border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[2] %></td>
  <td class=xl50 style='border-top:none;border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[3] %></td>
  <td class=xl70 style='border-top:none;border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[4] %></td>
  <td class=xl50 style='border-top:none;border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[5] %></td>
  <td class=xl70 style='border-top:none;border-left:none;mso-text-control:shrinktofit;' x:num><%=Group_Total[6] %></td>
  <td class=xl51 style='border-top:none'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl53></td>
  <td class=xl26></td>
  <td class=xl54></td>
  <td class=xl71></td>
  <td class=xl54></td>
  <td class=xl71></td>
  <td class=xl54></td>
  <td class=xl66></td>
  <td colspan=3 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl26 style='height:18.75pt'></td>
  <td class=xl53></td>
  <td class=xl26></td>
  <td class=xl55></td>
  <td class=xl66></td>
  <td class=xl55></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl57 colspan=8 style='height:18.0pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>             </span>NGƯỜI LẬP BẢNG<span
  style='mso-spacerun:yes'>                     </span>KẾ TOÁN TRƯỞNG<span
  style='mso-spacerun:yes'>                           </span> GIÁM ĐỐC</td>
  <td class=xl72></td>
  <td class=xl57></td>
  <td colspan=2 class=xl58 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=56 style='mso-height-source:userset;height:42.0pt'>
  <td height=56 class=xl59 style='height:42.0pt'></td>
  <td class=xl60></td>
  <td class=xl59></td>
  <td class=xl61></td>
  <td class=xl73></td>
  <td class=xl61></td>
  <td class=xl73></td>
  <td class=xl61></td>
  <td class=xl73></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl57 colspan=9 style='height:20.25pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>          </span> NGUYỄN THỊ LUYẾN <span
  style='mso-spacerun:yes'>                 </span>NGÔ THỊ KIM CHÂU<span
  style='mso-spacerun:yes'>                   </span>LEE KYOUNG SUN</td>
  <td class=xl57></td>
  <td colspan=2 class=xl58 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td class=xl26></td>
  <td class=xl55></td>
  <td class=xl66></td>
  <td class=xl55></td>
  <td class=xl66></td>
  <td class=xl55></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl26 style='height:29.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl63></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl62></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl26 style='height:14.25pt'></td>
  <td class=xl64></td>
  <td class=xl65></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td class=xl26></td>
  <td class=xl66></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=39 style='width:29pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=57 style='width:43pt'></td>
  <td width=71 style='width:53pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
