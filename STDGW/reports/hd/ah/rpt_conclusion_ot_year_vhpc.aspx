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

     string p_year;


    p_year = Request["p_year"].ToString();


    string SQL
    = "select decode(e.EMPLOYEE_TYPE, '01', 'OFFICE', 'FACTORY'),case when a.pay_rate in (300,200,150) then 'OT '||a.pay_rate else 'NT '||a.pay_rate end " + 
        ",sum(case when a.WORK_DT between to_number('"+ p_year +"')-1||'1216' and '"+ p_year +"'||'0115' then nvl(a.OT_TIME,0) else 0 end) mon01 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'0116' and '"+ p_year +"'||'0215' then nvl(a.OT_TIME,0) else 0 end) mon02 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'0216' and '"+ p_year +"'||'0315' then nvl(a.OT_TIME,0) else 0 end) mon03 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'0316' and '"+ p_year +"'||'0415' then nvl(a.OT_TIME,0) else 0 end) mon04 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'0416' and '"+ p_year +"'||'0515' then nvl(a.OT_TIME,0) else 0 end) mon05 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'0516' and '"+ p_year +"'||'0615' then nvl(a.OT_TIME,0) else 0 end) mon06 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'0616' and '"+ p_year +"'||'0715' then nvl(a.OT_TIME,0) else 0 end) mon07 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'0716' and '"+ p_year +"'||'0815' then nvl(a.OT_TIME,0) else 0 end) mon08 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'0816' and '"+ p_year +"'||'0915' then nvl(a.OT_TIME,0) else 0 end) mon09 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'0916' and '"+ p_year +"'||'1015' then nvl(a.OT_TIME,0) else 0 end) mon10 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'1016' and '"+ p_year +"'||'1115' then nvl(a.OT_TIME,0) else 0 end) mon11 " +
        ",sum(case when a.WORK_DT between '"+ p_year +"'||'1116' and '"+ p_year +"'||'1215' then nvl(a.OT_TIME,0) else 0 end) mon12 " +
        ",sum(case when a.WORK_DT between to_number('" + p_year + "')-1||'1216' and '" + p_year + "'||'1215' then nvl(a.OT_TIME,0) else 0 end) total " +
        "from thr_extra_time a, thr_employee e " +
        "where a.del_if=0 and e.del_if=0 " +
        "and a.THR_EMP_PK = e.PK " +
        "and e.EMPLOYEE_TYPE in ('01','02') " +
        "and  a.PAY_RATE in (30,45,60,90,150,200,300) " +
        "group by a.PAY_RATE, e.EMPLOYEE_TYPE " +
        "order by e.EMPLOYEE_TYPE, a.pay_rate desc " ;


    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp, icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp = dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }
//-----------------total --------------------

    string SQL_Total
    = "select count(mon1.thr_emp_pk),count(mon2.thr_emp_pk),count(mon3.thr_emp_pk),count(mon4.thr_emp_pk),count(mon5.thr_emp_pk), " + 
        "count(mon6.thr_emp_pk),count(mon7.thr_emp_pk),count(mon8.thr_emp_pk),count(mon9.thr_emp_pk),count(mon10.thr_emp_pk),count(mon11.thr_emp_pk), " +
        "count(mon12.thr_emp_pk), " +
        "count(mon1.thr_emp_pk)+count(mon2.thr_emp_pk)+count(mon3.thr_emp_pk)+count(mon4.thr_emp_pk)+count(mon5.thr_emp_pk)+count(mon6.thr_emp_pk) " +
        "+ count(mon7.thr_emp_pk)+count(mon8.thr_emp_pk)+count(mon9.thr_emp_pk)+count(mon10.thr_emp_pk)+count(mon11.thr_emp_pk)+count(mon12.thr_emp_pk) total " +
        "from thr_employee e, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between to_number('" + p_year + "')-1||'1216' and '" + p_year + "'||'0115' group by a.THR_EMP_PK) mon1, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0116' and '" + p_year + "'||'0215' group by a.THR_EMP_PK) mon2, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0216' and '" + p_year + "'||'0315' group by a.THR_EMP_PK) mon3, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0316' and '" + p_year + "'||'0415' group by a.THR_EMP_PK) mon4, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0416' and '" + p_year + "'||'0515' group by a.THR_EMP_PK) mon5, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0516' and '" + p_year + "'||'0615' group by a.THR_EMP_PK) mon6, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0616' and '" + p_year + "'||'0715' group by a.THR_EMP_PK) mon7, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0716' and '" + p_year + "'||'0815' group by a.THR_EMP_PK) mon8, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0816' and '" + p_year + "'||'0915' group by a.THR_EMP_PK) mon9, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0916' and '" + p_year + "'||'1015' group by a.THR_EMP_PK) mon10, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'1016' and '" + p_year + "'||'1115' group by a.THR_EMP_PK) mon11, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'1116' and '" + p_year + "'||'1215' group by a.THR_EMP_PK) mon12 " +
        "where e.del_if=0  " +
        "and e.pk = mon1.thr_emp_pk(+) " +
        "and e.pk = mon2.thr_emp_pk(+) " +
        "and e.pk = mon3.thr_emp_pk(+) " +
        "and e.pk = mon4.thr_emp_pk(+) " +
        "and e.pk = mon5.thr_emp_pk(+) " +
        "and e.pk = mon6.thr_emp_pk(+) " +
        "and e.pk = mon7.thr_emp_pk(+) " +
        "and e.pk = mon8.thr_emp_pk(+) " +
        "and e.pk = mon9.thr_emp_pk(+) " +
        "and e.pk = mon10.thr_emp_pk(+) " +
        "and e.pk = mon11.thr_emp_pk(+) " +
        "and e.pk = mon12.thr_emp_pk(+) " +
        "group by e.employee_type " +
        "having e.employee_type in ('01','02') ";


    DataTable dt_total = ESysLib.TableReadOpen(SQL_Total);
    //-------------------------gtotal ----------
    string SQL_gTotal
    = "select count(mon1.thr_emp_pk),count(mon2.thr_emp_pk),count(mon3.thr_emp_pk),count(mon4.thr_emp_pk),count(mon5.thr_emp_pk), " +
        "count(mon6.thr_emp_pk),count(mon7.thr_emp_pk),count(mon8.thr_emp_pk),count(mon9.thr_emp_pk),count(mon10.thr_emp_pk),count(mon11.thr_emp_pk), " +
        "count(mon12.thr_emp_pk), " +
        "count(mon1.thr_emp_pk)+count(mon2.thr_emp_pk)+count(mon3.thr_emp_pk)+count(mon4.thr_emp_pk)+count(mon5.thr_emp_pk)+count(mon6.thr_emp_pk) " +
        "+ count(mon7.thr_emp_pk)+count(mon8.thr_emp_pk)+count(mon9.thr_emp_pk)+count(mon10.thr_emp_pk)+count(mon11.thr_emp_pk)+count(mon12.thr_emp_pk) total " +
        "from thr_employee e, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between to_number('" + p_year + "')-1||'1216' and '" + p_year + "'||'0115' group by a.THR_EMP_PK) mon1, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0116' and '" + p_year + "'||'0215' group by a.THR_EMP_PK) mon2, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0216' and '" + p_year + "'||'0315' group by a.THR_EMP_PK) mon3, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0316' and '" + p_year + "'||'0415' group by a.THR_EMP_PK) mon4, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0416' and '" + p_year + "'||'0515' group by a.THR_EMP_PK) mon5, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0516' and '" + p_year + "'||'0615' group by a.THR_EMP_PK) mon6, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0616' and '" + p_year + "'||'0715' group by a.THR_EMP_PK) mon7, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0716' and '" + p_year + "'||'0815' group by a.THR_EMP_PK) mon8, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0816' and '" + p_year + "'||'0915' group by a.THR_EMP_PK) mon9, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'0916' and '" + p_year + "'||'1015' group by a.THR_EMP_PK) mon10, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'1016' and '" + p_year + "'||'1115' group by a.THR_EMP_PK) mon11, " +
        "(select a.thr_emp_pk from thr_extra_time a where a.del_if=0 and a.work_dt between '" + p_year + "'||'1116' and '" + p_year + "'||'1215' group by a.THR_EMP_PK) mon12 " +
        "where e.del_if=0  " +
        "and e.pk = mon1.thr_emp_pk(+) " +
        "and e.pk = mon2.thr_emp_pk(+) " +
        "and e.pk = mon3.thr_emp_pk(+) " +
        "and e.pk = mon4.thr_emp_pk(+) " +
        "and e.pk = mon5.thr_emp_pk(+) " +
        "and e.pk = mon6.thr_emp_pk(+) " +
        "and e.pk = mon7.thr_emp_pk(+) " +
        "and e.pk = mon8.thr_emp_pk(+) " +
        "and e.pk = mon9.thr_emp_pk(+) " +
        "and e.pk = mon10.thr_emp_pk(+) " +
        "and e.pk = mon11.thr_emp_pk(+) " +
        "and e.pk = mon12.thr_emp_pk(+) " +
        "and e.employee_type in ('01','02') ";


    DataTable dt_gtotal = ESysLib.TableReadOpen(SQL_gTotal);



 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_conclusion_ot_year_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_conclusion_ot_year_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_conclusion_ot_year_vhpc_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>user</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-09-20T03:41:07Z</o:LastPrinted>
  <o:Created>2011-04-29T05:58:59Z</o:Created>
  <o:LastSaved>2011-09-20T03:42:39Z</o:LastSaved>
  <o:Company>Hewlett-Packard Company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .5in .25in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
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
.style57
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
	mso-style-name:"Normal 2";}
.style58
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
	mso-style-name:"Normal 3";}
td
	{mso-style-parent:style0;
	padding:0px;
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
.xl68
	{mso-style-parent:style57;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style57;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style57;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style57;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style57;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style57;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style57;
	font-size:20.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl85
	{mso-style-parent:style57;
	font-size:16.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl86
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style58;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>1. conclusion</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>330</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>86</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>112</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>37</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11760</x:WindowHeight>
  <x:WindowWidth>19095</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
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

<body link=blue vlink=purple class=xl71>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1156 style='border-collapse:
 collapse;table-layout:fixed;width:867pt'>
 <col class=xl71 width=171 style='mso-width-source:userset;mso-width-alt:6253;
 width:128pt'>
 <col class=xl70 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl70 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl70 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl70 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl70 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl70 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl70 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl70 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl70 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl70 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl70 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl70 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl77 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl71 width=96 span=2 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <tr height=22 style='height:16.5pt'>
  <td height=22 width=171 style='height:16.5pt;width:128pt' align=left
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1025" type="#_x0000_t75"
   style='position:absolute;margin-left:0;margin-top:0;width:96.75pt;height:37.5pt;
   z-index:1;visibility:visible'>
   <v:imagedata src="rpt_conclusion_ot_year_vhpc_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:129px;
  height:50px'><img width=129 height=50
  src="rpt_conclusion_ot_year_vhpc_files/image002.jpg" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=22 class=xl68 width=171 style='height:16.5pt;width:128pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl69 width=78 style='width:59pt'></td>
  <td class=xl69 width=87 style='width:65pt'></td>
  <td class=xl69 width=81 style='width:61pt'></td>
  <td class=xl69 width=83 style='width:62pt'></td>
  <td class=xl69 width=83 style='width:62pt'></td>
  <td class=xl69 width=78 style='width:59pt'></td>
  <td class=xl69 width=87 style='width:65pt'></td>
  <td class=xl69 width=81 style='width:61pt'></td>
  <td class=xl69 width=83 style='width:62pt'></td>
  <td class=xl69 width=87 style='width:65pt'></td>
  <td class=xl69 width=81 style='width:61pt'></td>
  <td class=xl69 width=83 style='width:62pt'></td>
  <td class=xl77 width=76 style='width:57pt'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl68 style='height:16.5pt'></td>
  <td colspan=2 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl72></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl77></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=14 height=40 class=xl84 style='height:30.0pt'>TH&#7888;NG
  K&#7870; S&#7888; GI&#7900; T&#258;NG CA TRONG N&#258;M <%= p_year %></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=14 height=35 class=xl85 style='height:26.25pt'>OVERTIME &amp;
  NIGHT SHIFT ALLOWANCE CONCLUSION REPORT<span style='mso-spacerun:yes'> 
  </span>IN <%= p_year %></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl74 style='height:18.75pt'>unit : hour</td>
  <td colspan=12 class=xl73 style='mso-ignore:colspan'></td>
  <td class=xl77></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl79 width=171 style='height:25.5pt;width:128pt'>&nbsp;</td>
  <td class=xl80>Jan-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>Feb-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>Mar-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>Apr-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>May-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>Jun-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>Jul-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>Aug-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>Sep-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>Oct-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>Nov-<%= p_year %></td>
  <td class=xl80 style='border-left:none'>Dec-<%= p_year %></td>
  <td class=xl81 style='border-left:none'>TOTAL</td>
 </tr>
 <%
 
    int i;
    int count=1;
    int g = 0;
    Boolean flag = true;
    Boolean flag_total = false;
    string emp_type_old, emp_type_new;
    double [] total = new double[13];
    double[] gtotal = new double[13];
     for (int j=0; j<13; j++)
     {
         total[j] = 0;
         gtotal[j] = 0;
     }
    for (i = 0; i < irow_emp; i++)
    {

        emp_type_old = dt_Emp.Rows[i][0].ToString();
        for (int j = 2; j < icol_emp; j++)
        {
            total[j - 2] += Double.Parse(dt_Emp.Rows[i][j].ToString());
            gtotal[j - 2] += Double.Parse(dt_Emp.Rows[i][j].ToString());
        }
        if (flag)
        {
  %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=14 height=28 class=xl82 style='height:21.0pt' x:str><%= dt_Emp.Rows[i][0].ToString()%><span style='mso-spacerun:yes'> </span></td>
 </tr>
  <%	
     flag = false;
 }
 %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl76 style='height:21.0pt;border-top:none'><%= dt_Emp.Rows[i][1].ToString()%>%</td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= dt_Emp.Rows[i][2].ToString()%><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= dt_Emp.Rows[i][3].ToString()%> </td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][4].ToString()%> </td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= dt_Emp.Rows[i][5].ToString()%> </td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= dt_Emp.Rows[i][6].ToString()%> </td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][7].ToString()%> </td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= dt_Emp.Rows[i][8].ToString()%> </td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][9].ToString()%> </td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= dt_Emp.Rows[i][10].ToString()%> </td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= dt_Emp.Rows[i][11].ToString()%> </td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][12].ToString()%> </td>
  <td class=xl87 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= dt_Emp.Rows[i][13].ToString()%> </td>
  <td class=xl88 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= dt_Emp.Rows[i][14].ToString()%> </td>
 </tr>
 <%
     
     if (i < irow_emp - 1)
     {
         count = count + 1;
         emp_type_new = dt_Emp.Rows[i + 1][0].ToString();
         if (emp_type_new != emp_type_old)
         {
             flag = true;
             flag_total = true;
         }
     }
     else
     {
         flag = true;
         flag_total = true;
     }
     if (flag_total)
     {
  %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl78 style='height:21.0pt'>Total <%= dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[0] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= total[1] %></td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[2] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= total[3] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= total[4] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[5] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= total[6] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[7] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= total[8] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= total[9] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[10] %> </td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= total[11] %> </td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= total[12] %> </td>
 </tr>

 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl78 style='height:21.0pt;border-top:none'>Employee OT
  <%= dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_total.Rows[g][0].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= dt_total.Rows[g][1].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_total.Rows[g][2].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_total.Rows[g][3].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_total.Rows[g][4].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_total.Rows[g][5].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= dt_total.Rows[g][6].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_total.Rows[g][7].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_total.Rows[g][8].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= dt_total.Rows[g][9].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_total.Rows[g][10].ToString() %> </td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_total.Rows[g][11].ToString() %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_total.Rows[g][12].ToString() %> </td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl78 style='height:21.0pt;border-top:none'>Average <%= dt_Emp.Rows[i][0].ToString() %></td>
  <% for (int k = 0; k < 12; k++)
     {
         if (Double.Parse(dt_total.Rows[g][k].ToString()) == 0)
         {       
   %>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span>0 </td>
  <%    }
         else
         {
  %>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[k] / Double.Parse(dt_total.Rows[g][k].ToString())%> </td>          
  <%     }  
    } %>
  
  <td class=xl90 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= total[12] / Double.Parse(dt_total.Rows[g][12].ToString()) %> </td>
 </tr>
   <%
     flag_total = false;
     g++;
     for (int j = 0; j < 13; j++)
     {
         total[j] = 0;
     }
     }
} 
  %>
 <tr class=xl75 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl86 style='height:20.25pt;border-top:none'>GRAND TOTAL</td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[0] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= gtotal[1] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[2] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[3] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[4] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[5] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= gtotal[6] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[7] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[8] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= gtotal[9] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[10] %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[11] %> </td>
  <td class=xl94 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= gtotal[12] %> </td>
 </tr>
 <tr class=xl75 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl86 style='height:20.25pt;border-top:none'>Grand
  Employee OT</td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_gtotal.Rows[0][0].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= dt_gtotal.Rows[0][1].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_gtotal.Rows[0][2].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_gtotal.Rows[0][3].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_gtotal.Rows[0][4].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_gtotal.Rows[0][5].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= dt_gtotal.Rows[0][6].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_gtotal.Rows[0][7].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_gtotal.Rows[0][8].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= dt_gtotal.Rows[0][9].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_gtotal.Rows[0][10].ToString() %> </td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_gtotal.Rows[0][11].ToString() %> </td>
  <td class=xl96 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_gtotal.Rows[0][12].ToString() %> </td>
 </tr>
 <tr class=xl75 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl86 style='height:20.25pt;border-top:none'>Grand Average
  OT</td>
   <% for (int k = 0; k < 12; k++)
     {
         if (Double.Parse(dt_gtotal.Rows[0][k].ToString()) == 0)
         {       
   %>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span>0 </td>
  <%    }
         else
         {
  %>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[k] / Double.Parse(dt_gtotal.Rows[0][k].ToString())%> </td>          
  <%     }  
    } %>
  
 
  <td class=xl94 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= gtotal[12] / Double.Parse(dt_gtotal.Rows[0][12].ToString())%> </td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=171 style='width:128pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=76 style='width:57pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
