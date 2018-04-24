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

    string p_to, p_org, p_status, p_nation, p_mon_from, p_mon_to , p_rate;


    p_org = Request["p_org"].ToString();
    p_status = Request["p_status"].ToString();
    p_nation = Request["p_nation"].ToString();
    p_mon_from = Request["p_month_from"].ToString();
    p_mon_to = Request["p_month_to"].ToString();
    p_rate = Request["p_rate"].ToString();

    string SQL
    = "select  " + 
        "decode(b.EMPLOYEE_TYPE,'01','OFFICE','FACTORY')  " +
        ",b.EMP_ID as emp_1  " +
        ",b.FULL_NAME as fullname_2  " +
        ",(select max(code_nm) from vhr_hr_code where id='HR0008' and code= b.POS_TYPE) as position_3  " +
        ",c.ORG_NM as org_4  " +
        ",sum(decode(a.PAY_RATE,150,nvl(a.OT_TIME,0),0)) as ot150_5  " +
        ",sum(decode(a.PAY_RATE,200,nvl(a.OT_TIME,0),0)) as ot200_6  " +
        ",sum(decode(a.PAY_RATE,300,nvl(a.OT_TIME,0),0)) as ot300_7  " +
        ",sum(decode(a.PAY_RATE,30,nvl(a.OT_TIME,0),0)) as nt30_8  " +
        ",sum(decode(a.PAY_RATE,45,nvl(a.OT_TIME,0),0)) as nt45_9  " +
        ",sum(decode(a.PAY_RATE,60,nvl(a.OT_TIME,0),0)) as nt60_10  " +
        ",sum(decode(a.PAY_RATE,90,nvl(a.OT_TIME,0),0)) as nt90_11  " +
        ",sum(nvl(a.OT_TIME,0)) as total_12  " +
        ",round(amt.ot_amt,0) as total_amt_13 " +
        "from thr_extra_time a, thr_employee b, comm.tco_org c, " +
        "(select s.thr_emp_pk emp_pk, sum(s.TOTAL_OT_L1_AMT + s.TOTAL_OT_L2_AMT) ot_amt  " +
        "    from thr_month_salary s where s.del_if=0 " +
        "    and s.WORK_MON between '"+ p_mon_from +"' and '"+ p_mon_to +"' " +
        "    group by s.THR_EMP_PK " +
        ") amt " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0  " +
        "and a.THR_EMP_PK = b.PK  " +
        "and b.TCO_ORG_PK = c.PK " +
        "and b.pk = amt.emp_pk    " +
        "and a.WORK_DT between b.JOIN_DT and to_char(to_date(nvl(b.LEFT_DT,'30000101'),'yyyymmdd')-1,'yyyymmdd') " +
        "and a.WORK_DT between to_char(add_months(to_date('"+ p_mon_from +"','yyyymm'),-1),'yyyymm')||'16' and '"+ p_mon_to +"'||'15'   " +
            "and Decode('" + p_status + "','ALL','ALL', b.STATUS )= '" + p_status + "' " +
            "and Decode('" + p_nation + "','ALL','ALL', b.NATION )= '" + p_nation + "' " +
            " and (b.tco_org_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM comm.tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_org + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_org + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_org + "' = 'ALL') " +
            "group by b.EMP_ID, b.FULL_NAME, b.POS_TYPE, b.EMPLOYEE_TYPE, c.ORG_NM, amt.ot_amt " +
            "order by b.EMPLOYEE_TYPE, c.ORG_NM " ;


    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp, icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp = dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }

    //--------------------company information-----------------------
    string SQL_Day
    = "select " +
	" to_char(to_date('" + p_mon_from + "','YYYYMM'),'MM-YYYY'), to_char(to_date('" + p_mon_from + "','YYYYMM'),'MON YYYY'), " +
	" to_char(to_date('" + p_mon_to + "','YYYYMM'),'MM-YYYY'), to_char(to_date('" + p_mon_to + "','YYYYMM'),'MON YYYY') from dual " ;

    DataTable dt_Day = ESysLib.TableReadOpen(SQL_Day);

 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_overtime_summary_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_overtime_summary_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_overtime_summary_vhpc_files/oledata.mso">
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
  <o:LastPrinted>2011-06-01T06:21:25Z</o:LastPrinted>
  <o:Created>2011-04-29T07:53:22Z</o:Created>
  <o:LastSaved>2011-06-01T06:30:12Z</o:LastSaved>
  <o:Company>Hewlett-Packard Company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in 0in .25in 0in;
	mso-header-margin:0in;
	mso-footer-margin:0in;
	mso-page-orientation:landscape;}
.font18
	{color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
.xl65
	{mso-style-parent:style0;
	text-align:center;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	color:windowtext;
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	color:windowtext;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl69
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style43;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl91
	{mso-style-parent:style43;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style0;
	color:purple;
	font-size:16.0pt;
	font-style:italic;
	text-align:center;}
.xl105
	{mso-style-parent:style0;
	color:windowtext;
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
.xl106
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl107
	{mso-style-parent:style0;
	font-size:13.0pt;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style0;
	color:windowtext;
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
	mso-protection:unlocked visible;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	color:windowtext;
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
	mso-protection:unlocked visible;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	color:windowtext;
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
	mso-protection:unlocked visible;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	color:windowtext;
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
.xl112
	{mso-style-parent:style0;
	color:windowtext;
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
.xl113
	{mso-style-parent:style0;
	color:windowtext;
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
.xl114
	{mso-style-parent:style0;
	color:windowtext;
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
.xl115
	{mso-style-parent:style0;
	color:windowtext;
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
.xl116
	{mso-style-parent:style0;
	color:windowtext;
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
	mso-pattern:auto none;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	color:windowtext;
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
.xl118
	{mso-style-parent:style0;
	color:windowtext;
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
.xl119
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl120
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl121
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl123
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl124
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl125
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl126
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Summarize OT Year</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>72</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="7169"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="6"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1453 style='border-collapse:
 collapse;table-layout:fixed;width:1089pt'>
 <col class=xl65 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=161 style='mso-width-source:userset;mso-width-alt:5888;width:121pt'>
 <col width=116 span=2 style='mso-width-source:userset;mso-width-alt:4242;
 width:87pt'>
 <col width=75 span=7 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 width=36 style='height:15.0pt;width:27pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=161 style='width:121pt'></td>
  <td width=116 style='width:87pt'></td>
  <td class=xl66 width=116 style='width:87pt'></td>
  <td width=75 style='width:56pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s6145" type="#_x0000_t75"
   style='position:absolute;margin-left:6.75pt;margin-top:3.75pt;width:137.25pt;
   height:39pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_overtime_summary_vhpc_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:9px;margin-top:5px;width:183px;
  height:52px'><img width=183 height=52
  src="rpt_overtime_summary_vhpc_files/image002.jpg" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 width=75 style='height:15.0pt;width:56pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td colspan=16 height=63 class=xl128 width=1389 style='height:47.25pt;
  width:1041pt'>TH&#7888;NG KÊ CHI TI&#7870;T NGOÀI GI&#7900; C&#7910;A THÁNG
  T&#7914; <%= dt_Day.Rows[0][0].ToString() %> &#272;&#7870;N THÁNG <%= dt_Day.Rows[0][2].ToString() %><br>
    <font class="font18">OVERTIME CALCULATION FROM <%= dt_Day.Rows[0][1].ToString() %> TO <%= dt_Day.Rows[0][3].ToString() %></font></td>
  <td></td>
 </tr>
 <tr height=28 style='height:21.0pt'>
  <td colspan=14 height=28 class=xl104 style='height:21.0pt'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl67 height=55 style='mso-height-source:userset;height:41.25pt'>
  <td rowspan=3 height=102 class=xl105 width=36 style='border-bottom:.5pt solid black;
  height:76.5pt;width:27pt'>No<br>
    STT</td>
  <td rowspan=3 class=xl108 width=78 style='border-bottom:.5pt solid black;
  width:59pt'>Emp ID<br>
    Mã NV</td>
  <td rowspan=3 class=xl105 width=161 style='border-bottom:.5pt solid black;
  width:121pt'>Full Name<br>
    H&#7885; và Tên</td>
  <td rowspan=3 class=xl113 width=116 style='border-bottom:.5pt solid black;
  width:87pt'>Position<br>
    Ch&#7913;c v&#7909;</td>
  <td rowspan=3 class=xl105 width=116 style='border-bottom:.5pt solid black;
  width:87pt'>Dept.<br>
    B&#7897; ph&#7853;n</td>
  <td colspan=7 class=xl116 width=525 style='border-right:.5pt solid black;
  width:392pt'><span style='mso-spacerun:yes'>     </span>Overtimes<br>
    <span style='mso-spacerun:yes'>      </span>T&#259;ng ca</td>
  <td rowspan=3 class=xl105 width=103 style='border-bottom:.5pt solid black;
  width:77pt' x:str="Total Hours&#10;T&#7893;ng s&#7889; gi&#7901;                  ">Total
  Hours<br>
    T&#7893;ng s&#7889; gi&#7901;<span
  style='mso-spacerun:yes'>                  </span></td>
  <td rowspan=3 class=xl99 width=109 style='border-bottom:.5pt solid black;
  width:82pt' x:str="Total Amount&#10;T&#7893;ng s&#7889; ti&#7873;n               ">Total
  Amount<br>
    T&#7893;ng s&#7889; ti&#7873;n<span
  style='mso-spacerun:yes'>               </span></td>
  <td rowspan=3 class=xl105 width=81 style='border-bottom:.5pt solid black;
  width:61pt'>Remark<br>
    Ghi chú</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl67 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td rowspan=2 height=47 class=xl126 style='border-bottom:.5pt solid black;
  height:35.25pt;border-top:none' x:num="1.5">150%</td>
  <td rowspan=2 class=xl102 style='border-bottom:.5pt solid black;border-top:
  none' x:num="2">200%</td>
  <td rowspan=2 class=xl102 style='border-bottom:.5pt solid black;border-top:
  none' x:num="3">300%</td>
  <td rowspan=2 class=xl102 style='border-bottom:.5pt solid black;border-top:
  none' x:num="0.3">30%</td>
  <td rowspan=2 class=xl102 style='border-bottom:.5pt solid black;border-top:
  none' x:num="0.45">45%</td>
  <td rowspan=2 class=xl102 style='border-bottom:.5pt solid black;border-top:
  none' x:num="0.6">60%</td>
  <td rowspan=2 class=xl102 style='border-bottom:.5pt solid black;border-top:
  none' x:num="0.9">90%</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=2 style='height:8.25pt;mso-ignore:colspan'></td>
 </tr>
 <%
    int i = 0;
    int count = 1;
    Boolean flag = true;
    Boolean flag_total = false;
    string emp_type_old, emp_type_new; 
    double[] total = new double[10];
    double[] gtotal = new double[10];
    for (int k = 0; k < 10; k++)
    {
        total[k] = 0;
        gtotal[k] = 0;
    }  
    for (i = 0; i < irow_emp; i++)
    {
        emp_type_old = dt_Emp.Rows[i][0].ToString();

        for (int j = 5; j < icol_emp; j++)
        { 
            total[j-5] += Double.Parse(dt_Emp.Rows[i][j].ToString());
            gtotal[j-5] += Double.Parse(dt_Emp.Rows[i][j].ToString());
        }
        if (flag)
        {
  %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=15 height=28 class=xl119 style='border-right:.5pt solid black;
  height:21.0pt'><span style='mso-spacerun:yes'>        </span><%= dt_Emp.Rows[i][0].ToString()%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
     <%	
        flag = false;
        }
 %>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl70 style='height:22.5pt;border-top:none' x:num><%= count %></td>
  <td class=xl71 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl97 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl97 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl98 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl72 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_Emp.Rows[i][5].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= dt_Emp.Rows[i][6].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_Emp.Rows[i][7].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_Emp.Rows[i][8].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_Emp.Rows[i][9].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_Emp.Rows[i][10].ToString()%> </td>
  <td class=xl73 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= dt_Emp.Rows[i][11].ToString()%> </td>
  <td class=xl74 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= dt_Emp.Rows[i][12].ToString()%> </td>
  <td class=xl75 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][13].ToString()%> </td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
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
  <td colspan=5 height=28 class=xl122 style='height:21.0pt'>TOTAL <%= dt_Emp.Rows[i][0].ToString()%></td>
  <td class=xl76 x:num="2"><span style='mso-spacerun:yes'>           
  </span><%= total[0] %> </td>
  <td class=xl76 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= total[1] %> </td>
  <td class=xl76 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= total[2] %> </td>
  <td class=xl76 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= total[3] %> </td>
  <td class=xl76 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= total[4] %> </td>
  <td class=xl76 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= total[5] %> </td>
  <td class=xl76 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= total[6] %> </td>
  <td class=xl77 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= total[7] %> </td>
  <td class=xl75 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[8] %> </td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
  <%
     
     for (int k = 0; k < 10; k++)
         total[k] = 0;     
    flag_total = false;
   }
}
      
	%>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=5 height=28 class=xl122 style='border-right:.5pt solid black;
  height:21.0pt'>GRAND<span style='mso-spacerun:yes'>  </span>TOTAL</td>
  <td class=xl78 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= gtotal[0] %> </td>
  <td class=xl79 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[1] %> </td>
  <td class=xl79 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= gtotal[2] %> </td>
  <td class=xl79 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= gtotal[3] %> </td>
  <td class=xl79 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= gtotal[4] %> </td>
  <td class=xl79 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= gtotal[5] %> </td>
  <td class=xl79 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%= gtotal[6] %> </td>
  <td class=xl80 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= gtotal[7] %> </td>
  <td class=xl81 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[8] %> </td>
  <td class=xl94 style='border-top:none'>vnd</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl83 style='height:16.5pt;border-top:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none;border-left:none'>Average/person</td>
  <td class=xl85 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl86 style='border-top:none'>&nbsp;</td>
  <td class=xl87 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl87 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>               </span><%= gtotal[7]/count %> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[8]/count %> </td>
  <td class=xl82>vnd</td>
  <td class=xl96 style='border-left:none'>ex rate</td>
  <td></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl88 style='height:16.5pt'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl90>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-left:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl91 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= gtotal[8]/count/Double.Parse(p_rate.ToString()) %> </td>
  <td class=xl82 style='border-top:none'>usd</td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%= p_rate %> </td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=161 style='width:121pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
