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

    string p_year;


    p_year = Request["p_year"].ToString();

   string SQL
    = "select (select char_4 from vhr_hr_code where id='HR0043') as Min_ins " + 
        ",b.EMP_ID " +
        ",b.FULL_NAME " +
        ",(select max(code_nm) from vhr_hr_code where id='HR0008' and code= b.POS_TYPE) as position_3   " +
        ",c.ORG_NM as org_4  " +
        ",to_char(to_date(b.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') join_dt " +
        ",to_char(to_date(a.START_DT ,'yyyymmdd'),'dd/mm/yyyy') start_dt " +
        ",to_char(add_months(to_date(a.start_dt,'yyyymmdd')-1,4),'dd/mm/yyyy') end_dt " +
        ",to_char(add_months(to_date(a.start_dt,'yyyymmdd'),4),'dd/mm/yyyy') working_again " +
        ",to_char(to_date(d.tu_thang,'yyyymm'),'mm/yyyy') from_mon " +
        ",to_char(to_date(d.den_thang,'yyyymm'),'mm/yyyy') to_mon " +
        ",to_char(add_months(to_date(d.den_thang,'yyyymm'),1),'mm/yyyy') paid_again " +
        ",(select i.LUONG_CB from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon = d.tu_thang) as sal1 " +
        ",(select i.LUONG_CB from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon = to_char(add_months(to_date(d.tu_thang,'yyyymm'),-1),'yyyymm')) as sal2 " +
        ",(select i.LUONG_CB from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon = to_char(add_months(to_date(d.tu_thang,'yyyymm'),-2),'yyyymm')) as sal3 " +
        ",(select i.LUONG_CB from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon = to_char(add_months(to_date(d.tu_thang,'yyyymm'),-3),'yyyymm')) as sal4 " +
        ",(select i.LUONG_CB from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon = to_char(add_months(to_date(d.tu_thang,'yyyymm'),-4),'yyyymm')) as sal5 " +
        ",(select i.LUONG_CB from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon = to_char(add_months(to_date(d.tu_thang,'yyyymm'),-5),'yyyymm')) as sal6 " +
        ",(select i.LUONG_CB from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon = to_char(add_months(to_date(d.tu_thang,'yyyymm'),-6),'yyyymm')) as sal7 " +
        ",(select sum(nvl(i.LUONG_CB,0)) from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon between  " +
        "to_char(add_months(to_date(d.tu_thang,'yyyymm'),-6),'yyyymm') and to_char(add_months(to_date(d.tu_thang,'yyyymm'),-1),'yyyymm') ) as saltotal " +
        ",(select sum(nvl(i.LUONG_CB,0))/count(*) from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon between  " +
        "to_char(add_months(to_date(d.tu_thang,'yyyymm'),-6),'yyyymm') and to_char(add_months(to_date(d.tu_thang,'yyyymm'),-1),'yyyymm')) as sal_average " +
        ",(select sum(nvl(i.LUONG_CB,0))/count(*) from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon between  " +
        "to_char(add_months(to_date(d.tu_thang,'yyyymm'),-6),'yyyymm') and to_char(add_months(to_date(d.tu_thang,'yyyymm'),-1),'yyyymm'))*4 as sal4mon " +
        ",(select char_4 from vhr_hr_code where id='HR0043')*2 as sal2mon " +
        ",(select sum(nvl(i.LUONG_CB,0))/count(*) from thr_insurance_month i where i.del_if=0 and i.thr_emp_pk= b.pk and i.work_mon between  " +
        "to_char(add_months(to_date(d.tu_thang,'yyyymm'),-6),'yyyymm') and to_char(add_months(to_date(d.tu_thang,'yyyymm'),-1),'yyyymm'))*4 " +
        "+ (select char_4 from vhr_hr_code where id='HR0043')*2 as total " +
        "from thr_absence_reg a, thr_employee b, comm.tco_org c,thr_insurance_manage d " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 and d.del_if(+)=0 " +
        "and a.THR_EMP_PK = b.PK " +
        "and b.TCO_ORG_PK = c.PK " +
        "and d.thr_emp_pk(+) = b.pk " +
        "and '"+ p_year +"' between substr(d.tu_thang(+),1,4) and substr(d.den_thang(+),1,4) " +
        "and '"+ p_year +"' between substr(a.START_DT,1,4) and substr(a.END_DT,1,4) " +
        "and a.absence_type ='04' " ;



    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp, icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp = dt_Emp.Columns.Count;
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
<link rel=File-List href="rpt_maternity_statistic_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_maternity_statistic_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_maternity_statistic_vhpc_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>user</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-06-14T02:19:26Z</o:LastPrinted>
  <o:Created>2011-04-29T07:53:22Z</o:Created>
  <o:LastSaved>2011-06-14T02:20:58Z</o:LastSaved>
  <o:Company>Hewlett-Packard Company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .5in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
.font11
	{color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl66
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dotted windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dotted windowtext;}
.xl70
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dotted windowtext;}
.xl71
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt dashed windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt dashed windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt dotted windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl112
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl113
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Maternity</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>375</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>42</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>10</x:SplitHorizontal>
     <x:TopRowBottomPane>10</x:TopRowBottomPane>
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
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2362 style='border-collapse:
 collapse;table-layout:fixed;width:1772pt'>
 <col class=xl65 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl65 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl65 width=188 style='mso-width-source:userset;mso-width-alt:6875;
 width:141pt'>
 <col class=xl65 width=108 span=2 style='mso-width-source:userset;mso-width-alt:
 3949;width:81pt'>
 <col class=xl65 width=89 span=4 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl65 width=75 span=3 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl65 width=100 span=12 style='mso-width-source:userset;mso-width-alt:
 3657;width:75pt'>
 <col class=xl65 width=64 style='width:48pt'>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl65 width=33 style='height:18.75pt;width:25pt'></td>
  <td class=xl65 width=80 style='width:60pt'></td>
  <td class=xl65 width=188 style='width:141pt'></td>
  <td class=xl65 width=108 style='width:81pt'></td>
  <td class=xl65 width=108 style='width:81pt'></td>
  <td class=xl65 width=89 style='width:67pt'></td>
  <td class=xl65 width=89 style='width:67pt'></td>
  <td class=xl65 width=89 style='width:67pt'></td>
  <td class=xl65 width=89 style='width:67pt'></td>
  <td class=xl65 width=75 style='width:56pt'></td>
  <td class=xl65 width=75 style='width:56pt'></td>
  <td class=xl65 width=75 style='width:56pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=100 style='width:75pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=25 height=30 class=xl111 style='height:22.5pt'>THEO DÕI
  GI&#7842;M LAO &#272;&#7896;NG THAI S&#7842;N N&#258;M 2011</td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=25 height=30 class=xl111 style='height:22.5pt'>MATERNITY IN 2011</td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=25 class=xl65 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=25 class=xl65 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td colspan=6 height=37 class=xl99 style='border-right:.5pt solid black;
  height:27.75pt'>Personal Maternity</td>
  <td colspan=3 rowspan=2 class=xl105 width=267 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:201pt'><span
  style='mso-spacerun:yes'> </span>Company<span
  style='mso-spacerun:yes'>                              </span>(Working day)</td>
  <td colspan=3 rowspan=2 class=xl105 width=225 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:168pt'>Social insuanrance<br>
    (Month)</td>
  <td colspan=12 class=xl99 style='border-right:.5pt solid black;border-left:
  none'>Welfare to Maternity</td>
  <td rowspan=5 class=xl87 style='border-bottom:.5pt solid black'>Remark</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td rowspan=4 height=121 class=xl96 style='border-bottom:.5pt solid black;
  height:90.75pt;border-top:none'>No</td>
  <td rowspan=4 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>Code</td>
  <td rowspan=4 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>Full Name</td>
  <td rowspan=4 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>Position</td>
  <td rowspan=4 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>Depatment</td>
  <td rowspan=4 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>Joint Date</td>
  <td class=xl76 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=11 class=xl99 style='border-right:.5pt solid black;border-left:
  none'>Paid salary for maternity (VND)</td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td colspan=2 height=39 class=xl99 style='height:29.25pt;border-left:none'
  x:str="Leave ">Leave<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl101 width=89 style='border-bottom:.5pt solid black;
  border-top:none;width:67pt'>Working again</td>
  <td colspan=2 class=xl99 style='border-left:none' x:str="Leave ">Leave<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>Paid again</td>
  <td rowspan=3 class=xl89 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Basic salary<br>
    leave</td>
  <td colspan=8 class=xl94 style='border-left:none' x:str="Average salary ">Average
  salary<span style='mso-spacerun:yes'> </span></td>
  <td class=xl77 style='border-top:none'>Months</td>
  <td class=xl78 width=100 style='border-top:none;width:75pt'><span
  style='mso-spacerun:yes'> </span>Allowance <font class="font11">(830.000/month)</font></td>
  <td class=xl79>Income</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td rowspan=2 height=51 class=xl87 style='border-bottom:.5pt solid black;
  height:38.25pt;border-top:none'>From</td>
  <td rowspan=2 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>To</td>
  <td rowspan=2 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>From</td>
  <td rowspan=2 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>To</td>
  <td colspan=6 class=xl91 style='border-right:.5pt solid black;border-left:
  none' x:str="Salary for 6 month nearly ">Salary for 6 month nearly<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>Total</td>
  <td rowspan=2 class=xl87 style='border-bottom:.5pt solid black;border-top:
  none'>Average</td>
  <td rowspan=2 class=xl87 style='border-bottom:.5pt solid black' x:num>4</td>
  <td rowspan=2 class=xl87 style='border-bottom:.5pt solid black' x:num>2</td>
  <td rowspan=2 class=xl87 style='border-bottom:.5pt solid black'>(VND)</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl80 style='height:18.75pt;border-top:none;border-left:
  none'>(1)</td>
  <td class=xl81 style='border-top:none;border-left:none'>(2)</td>
  <td class=xl81 style='border-top:none;border-left:none'>(3)</td>
  <td class=xl81 style='border-top:none;border-left:none'>(4)</td>
  <td class=xl81 style='border-top:none;border-left:none'>(5)</td>
  <td class=xl82 style='border-top:none;border-left:none'>(6)</td>
 </tr>
 <%
    for (i = 0; i < irow_emp; i++)
    {
  %>
 
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl113 align=right style='height:28.5pt;border-top:none'
  x:num>1</td>
  <td class=xl112 align=right style='border-top:none' x:num><%= dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl113 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl113 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl113 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl114 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl84 style='border-top:none'><%= dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl84 style='border-top:none'><%= dt_Emp.Rows[i][7].ToString()%></td>
  <td class=xl84 style='border-top:none'><%= dt_Emp.Rows[i][8].ToString()%></td>
  <td class=xl84 style='border-top:none'><%= dt_Emp.Rows[i][9].ToString()%></td>
  <td class=xl84 style='border-top:none'><%= dt_Emp.Rows[i][10].ToString()%></td>
  <td class=xl84 style='border-top:none'><%= dt_Emp.Rows[i][11].ToString()%></td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][12].ToString()%> </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%= dt_Emp.Rows[i][13].ToString()%> </td>
  <td class=xl85 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][14].ToString()%> </td>
  <td class=xl85 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][15].ToString()%> </td>
  <td class=xl85 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][16].ToString()%> </td>
  <td class=xl85 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][17].ToString()%> </td>
  <td class=xl85 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][18].ToString()%> </td>
  <td class=xl83 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>  </span><%= dt_Emp.Rows[i][19].ToString()%> </td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%= dt_Emp.Rows[i][20].ToString()%> </td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%= dt_Emp.Rows[i][21].ToString()%> </td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%= dt_Emp.Rows[i][22].ToString()%> </td>
  <td class=xl83 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>  </span><%= dt_Emp.Rows[i][23].ToString()%> </td>
  <td class=xl86 style='border-left:none'>&nbsp;</td>
 </tr>
 <%} %>
 <tr height=1 style='mso-height-source:userset;height:.75pt'>
  <td height=1 class=xl67 style='height:.75pt;border-top:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl74 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl73 style='border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=188 style='width:141pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
