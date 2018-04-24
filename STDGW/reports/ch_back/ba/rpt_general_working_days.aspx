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

    //-----------------working time-----------------
    string SQL
	= "select c.PARTNER_FNAME a0,c.ADDR2 a1,a.dept_NM a2,a.EMP_ID a3,a.full_name a4" + 
        ",round(nvl(a.TOTAL_WD,0)/8-NVL(A.ABS_ALE,0)-NVL(A.ABS_OTHER,0)-NVL(A.TOTAL_HOL,0)/8,2) a5" +
        ",NVL(A.TOTAL_HOL,0)/8 a6" +
        ",NVL(A.ABS_ALE,0) a7" +
        ",NVL(b.TOTAL_OT,0) a8" +
        ",0 WT300_9" +
        ",NVL(b.NT_30,0) a10" +
        ",NVL(b.NT_45,0) a11" +
        ",NVL(b.TOTAL_HT,0) + NVL(b.TOTAL_ST,0)  + NVL(b.TOTAL_OST,0) a12 " +
        ",NVL(b.NT_60,0) + NVL(b.NT_90,0) a13 " +
        ",NVL(b.TOTAL_OHT,0) a14 " +
        "from thr_work_mon a,thr_extra_month b, tco_company c,thr_employee e " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 and e.del_if=0 and c.pk=e.tco_company_pk " +
        "and a.thr_emp_pk=b.thr_emp_pk  and e.pk=a.thr_emp_pk and e.MATERNITY_LEAVE_DT is null  " +
        "and a.work_mon = b.work_mon " +
        "and a.work_mon='" + p_work_mon + "' " +
        "and b.work_mon='" + p_work_mon + "' " +
        "and (a.tco_dept_pk in ( " +
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
        "and decode('" + p_thr_group_pk + "','ALL','ALL',a.thr_group_pk)='" + p_thr_group_pk + "' " +
        "and a.emp_id like '%" + p_emp_id + "%' " + 
        "and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "' " +
        " and decode('" + p_salary_period + "','ALL','ALL',nvl(a.sal_period,' '))='" + p_salary_period + "' " +
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
<link rel=File-List href="rpt_general_working_days_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_general_working_days_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_general_working_days_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PM-013</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2006-05-25T05:02:15Z</o:LastPrinted>
  <o:Created>2005-11-29T04:09:31Z</o:Created>
  <o:LastSaved>2012-07-19T02:03:25Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-header-data:"&L&\0022VNI-Fato\,Bold\0022&11<%= dt_Emp.Rows[0][0].ToString() %>&12\000A&\0022Arial\,Italic\0022&8 <%= dt_Emp.Rows[0][1].ToString() %> \000A";
	margin:1.0in 0in 0in .25in;
	mso-header-margin:0in;
	mso-footer-margin:0in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
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
.style22
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
	mso-style-name:Normal_Sheet1;}
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
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	color:white;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	padding-left:12px;
	mso-char-indent-count:1;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0000;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style22;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	padding-left:12px;
	mso-char-indent-count:1;}
.xl37
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style16;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0000;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl43
	{mso-style-parent:style16;
	font-size:6.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl44
	{mso-style-parent:style16;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:left;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:right;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:center;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0000;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style22;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	padding-left:12px;
	mso-char-indent-count:1;}
.xl56
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl58
	{mso-style-parent:style16;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:17.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
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
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>86</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
       <x:ActiveCol>15</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:ConditionalFormatting>
     <x:Range>$C$3,$F$7:$I$7,$K$7:$L$7,$A$7:$C$7</x:Range>
     <x:Condition>
      <x:Value1>$M3=1</x:Value1>
      <x:Format Style='background:silver'/>
     </x:Condition>
     <x:Condition>
      <x:Value1>#REF!=&quot;Resign&quot;</x:Value1>
      <x:Format Style='background:#FF99CC'/>
     </x:Condition>
    </x:ConditionalFormatting>
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
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$4:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=822 style='border-collapse:
 collapse;table-layout:fixed;width:618pt'>
 <col width=28 style='mso-width-source:userset;mso-width-alt:1024;width:21pt'>
 <col width=64 style='width:48pt'>
 <col width=146 style='mso-width-source:userset;mso-width-alt:5339;width:110pt'>
 <col width=64 style='width:48pt'>
 <col width=52 span=4 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col width=44 style='mso-width-source:userset;mso-width-alt:1609;width:33pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1682;width:35pt'>
 <col width=52 span=2 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=12 height=21 class=xl59 width=686 style='height:15.75pt;
  width:516pt'>GENERAL WORKING DAYS SHEET</td>
  <td width=71 style='width:53pt'></td>
  <td width=65 style='width:49pt'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt'></td>
  <td class=xl26></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl27>CN</td>
  <td class=xl27></td>
  <td class=xl27 x:num><%=dt_Cal.Rows[0][0].ToString() %></td>
  <td class=xl27>NC</td>
  <td class=xl27 x:num><%=dt_Cal.Rows[0][1].ToString() %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl28 colspan=2 style='height:15.75pt;mso-ignore:colspan'>SECTION<span
  style='display:none'> :</span></td>
  <td class=xl29><%= dt_Emp.Rows[0][2].ToString() %></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl60>CYCLE SALARY :<%=p_from_dt.Substring(6,2).ToString() + "/" + p_from_dt.Substring(4,2).ToString() + "/" + p_from_dt.Substring(0,4).ToString() %>-<%=p_to_dt.Substring(6,2).ToString() + "/" + p_to_dt.Substring(4,2).ToString() + "/" + p_to_dt.Substring(0,4).ToString() %></td>
  <td></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=2 height=42 class=xl61 style='border-bottom:.5pt solid black;
  height:31.5pt'>NO.</td>
  <td rowspan=2 class=xl61 style='border-bottom:.5pt solid black'>CODE</td>
  <td rowspan=2 class=xl61 style='border-bottom:.5pt solid black;border-top:
  none'>FULLNAME</td>
  <td rowspan=2 class=xl63 width=64 style='border-bottom:.5pt solid black;
  width:48pt'>WORKING<br>
    DAYS</td>
  <td rowspan=2 class=xl63 width=52 style='border-bottom:.5pt solid black;
  width:39pt'>HOLIDAY</td>
  <td rowspan=2 class=xl63 width=52 style='border-bottom:.5pt solid black;
  border-top:none;width:39pt'>ANNUAL LEAVE</td>
  <td rowspan=2 class=xl63 width=52 style='border-bottom:.5pt solid black;
  border-top:none;width:39pt'>OVERTIME</td>
  <td rowspan=2 class=xl63 width=52 style='border-bottom:.5pt solid black;
  border-top:none;width:39pt'>WORKING 300%</td>
  <td colspan=2 rowspan=2 class=xl65 width=90 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:68pt'>NIGHT<br>
    SHIFT</td>
  <td colspan=3 rowspan=2 class=xl69 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>SUNDAY/HOLIDAY</td>
  <td rowspan=2 class=xl61 style='border-bottom:.5pt solid black'>SIGNATURE</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'>STT</td>
  <td class=xl32>MSNV</td>
  <td class=xl32>HỌ VÀ TÊN</td>
  <td class=xl32>NGÀY CÔNG</td>
  <td class=xl32>NGHỈ LỄ</td>
  <td class=xl33 width=52 style='width:39pt'>PHÉP NĂM</td>
  <td class=xl32>TĂNG CA</td>
  <td class=xl32>NC 300%</td>
  <td class=xl32>T.CA 30%</td>
  <td class=xl32>T.CA 45%</td>
  <td class=xl32>CN/NL (200%)</td>
  <td class=xl32>Đêm (60%)</td>
  <td class=xl32>TĂNG CA NL (300%)</td>
  <td class=xl32>KÝ TÊN</td>
 </tr>
 <% 
    string sformat;
    for (int i = 0; i < irow_emp; i++) 
    {
        if (i==irow_emp-1)
            sformat="border-bottom:.5pt solid windowtext;";
        else
            sformat="";
    %> 
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl34 style='<%=sformat %>height:21.0pt'><%=i+1 %></td>
  <td class=xl35 style='<%=sformat %>'><%= dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl36 style='<%=sformat %>'><%= dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl37 style='<%=sformat %>' x:num><%= dt_Emp.Rows[i][5].ToString() %> </td>
  <td class=xl37 style='<%=sformat %>' x:num><%= dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl38 width=52 style='<%=sformat %>width:39pt' x:num><%= dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl38 width=52 style='<%=sformat %>width:39pt' x:num><%= dt_Emp.Rows[i][8].ToString() %></td>
  <td class=xl38 width=52 style='<%=sformat %>width:39pt' x:num><%= dt_Emp.Rows[i][9].ToString() %></td>
  <td class=xl38 width=44 style='<%=sformat %>width:33pt' x:num><%= dt_Emp.Rows[i][10].ToString() %></td>
  <td class=xl38 width=46 style='<%=sformat %>width:35pt' x:num><%= dt_Emp.Rows[i][11].ToString() %></td>
  <td class=xl38 width=52 style='<%=sformat %>width:39pt' x:num><%= dt_Emp.Rows[i][12].ToString() %></td>
  <td class=xl38 width=52 style='<%=sformat %>width:39pt' x:num><%= dt_Emp.Rows[i][13].ToString() %></td>
  <td class=xl38 width=71 style='<%=sformat %>width:53pt' x:num><%= dt_Emp.Rows[i][14].ToString() %></td>
  <td class=xl39 width=65 style='<%=sformat %>width:49pt'>&nbsp;</td>
 </tr>
 <%} %>
 
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt'></td>
  <td class=xl41></td>
  <td class=xl30></td>
  <td colspan=7 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td class=xl44></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl45 style='height:15.75pt'></td>
  <td colspan=2 class=xl46>CHECKED BY</td>
  <td class=xl46 colspan=2 style='mso-ignore:colspan'>TEAM LEADER</td>
  <td class=xl47></td>
  <td class=xl48>HEAD DEPARTMENT</td>
  <td></td>
  <td class=xl48></td>
  <td class=xl47></td>
  <td class=xl48>PRODUCTION MANAGER</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl49 colspan=3 style='height:15.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'>       </span>(NGƯỜI CHẤM CÔNG)</td>
  <td class=xl50><span style='mso-spacerun:yes'> </span>(TỔ TRƯỞNG)</td>
  <td class=xl51></td>
  <td></td>
  <td class=xl50>(TRƯỞNG BỘ PHẬN)</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'></td>
  <td></td>
  <td class=xl50>(QUẢN LÝ XƯỞNG)</td>
  <td class=xl52></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=28 style='width:21pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=146 style='width:110pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=65 style='width:49pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
