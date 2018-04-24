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

    string  p_org, p_status, p_nation, p_month, p_from, p_to;


    p_org = Request["p_org"].ToString();
    p_status = Request["p_status"].ToString();
    p_nation = Request["p_nation"].ToString();
    p_month = Request["p_1"].ToString();
    p_from = Request["p_from"].ToString();
    p_to = Request["p_to"].ToString();

    string SQL
    = "select " + 
        "decode(b.EMPLOYEE_TYPE,'01','OFFICE','FACTORY') " +
        ",b.EMP_ID as emp_1 " +
        ",b.FULL_NAME as fullname_2 " +
        ",(select max(code_nm) from vhr_hr_code where id='HR0008' and code= b.POS_TYPE) as position_3 " +
        ",c.ORG_NM as org_4 " +
        ",max(nvl(s.SALARY_LEVEL2,0)) as salary_5 " +
        ",sum(decode(a.PAY_RATE,150,nvl(a.OT_TIME,0),0)) as ot150_6 " +
        ",sum(decode(a.PAY_RATE,200,nvl(a.OT_TIME,0),0)) as ot200_7 " +
        ",sum(decode(a.PAY_RATE,300,nvl(a.OT_TIME,0),0)) as ot300_8 " +
        ",sum(decode(a.PAY_RATE,30,nvl(a.OT_TIME,0),0)) as nt30_9 " +
        ",sum(decode(a.PAY_RATE,45,nvl(a.OT_TIME,0),0)) as nt45_10 " +
        ",sum(decode(a.PAY_RATE,60,nvl(a.OT_TIME,0),0)) as nt60_11 " +
        ",sum(decode(a.PAY_RATE,90,nvl(a.OT_TIME,0),0)) as nt90_12 " +
        ",sum(case when a.PAY_RATE in (30,45,60,90,150,200,300) then a.OT_TIME else 0 end) as total_13 " +
        ",round(max(nvl(s.TOTAL_OT_L1_AMT,0) + nvl(s.TOTAL_OT_L2_AMT,0)),0) as total_amt_14 " +
        "from thr_extra_time a, thr_employee b, tco_org c, thr_month_salary s " +
        "where a.del_if=0 and b.del_if=0 and c.del_if=0 and s.del_if(+)=0 " +
        "and a.THR_EMP_PK = b.PK " +
        "and b.TCO_ORG_PK = c.PK " +
        "and a.THR_EMP_PK = s.THR_EMP_PK(+) " +
		"and nvl(a.ot_time,0)>0 " +
        "and s.WORK_MON(+) = '" + p_month + "' " +
        "and a.WORK_DT between '"+ p_from +"' and '" + p_to + "'  " +
            "and Decode('" + p_status + "','ALL','ALL', b.STATUS )= '" + p_status + "' " +
            "and Decode('" + p_nation + "','ALL','ALL', b.NATION )= '" + p_nation + "' " +
            " and (b.tco_org_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_org + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_org + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_org + "' = 'ALL') " +
            "group by b.EMP_ID, b.FULL_NAME, b.POS_TYPE, b.EMPLOYEE_TYPE, c.ORG_NM " +
        "order by 1 desc " ;


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
    = "select to_char(to_date('" + p_month + "','YYYYMM'),'MM-YYYY'), to_char(to_date('" + p_month + "','YYYYMM'),'MON YYYY') from dual " ;

    DataTable dt_Day = ESysLib.TableReadOpen(SQL_Day);

 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_overtime_detail_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_overtime_detail_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_overtime_detail_vhpc_files/oledata.mso">
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
  <o:LastPrinted>2011-03-22T08:50:10Z</o:LastPrinted>
  <o:Created>2011-03-14T01:07:13Z</o:Created>
  <o:LastSaved>2011-03-23T02:58:21Z</o:LastSaved>
  <o:Company>Hewlett-Packard Company</o:Company>
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
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	color:yellow;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl78
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl79
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl82
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
.xl83
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl84
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
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style43;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl91
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022?_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl93
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
.xl94
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl100
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
.xl101
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
.xl102
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
.xl103
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
.xl104
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
.xl107
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
.xl108
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
.xl109
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
.xl110
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
.xl111
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	color:windowtext;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl114
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
.xl115
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
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
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
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl118
	{mso-style-parent:style0;
	color:red;
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
	background:white;
	mso-pattern:auto none;}
.xl119
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
.xl120
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
.xl121
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
.xl122
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
.xl123
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
.xl124
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
.xl125
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
.xl126
	{mso-style-parent:style0;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl127
	{mso-style-parent:style0;
	color:purple;
	font-size:16.0pt;
	font-style:italic;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>OT by monthly</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10995</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>150</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='OT by monthly'!$6:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1447 style='border-collapse:
 collapse;table-layout:fixed;width:1083pt'>
 <col class=xl65 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=149 style='mso-width-source:userset;mso-width-alt:5449;width:112pt'>
 <col width=91 span=2 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=63 span=7 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col width=99 span=2 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 width=36 style='height:15.0pt;width:27pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=149 style='width:112pt'></td>
  <td class=xl66 width=91 style='width:68pt'></td>
  <td class=xl66 width=91 style='width:68pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=63 style='width:47pt' align=left valign=top></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=14 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td colspan=14 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=63 style='mso-height-source:userset;height:47.25pt'>
  <td colspan=15 height=63 class=xl99 width=1178 style='height:47.25pt;
  width:881pt'>TH&#7888;NG KÊ CHI TI&#7870;T NGOÀI GI&#7900; C&#7910;A THÁNG
  <%= dt_Day.Rows[0][0].ToString() %><br>
    OVERTIME CALCULATION IN <%= dt_Day.Rows[0][1].ToString() %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='height:21.0pt'>
  <td colspan=15 height=28 class=xl127 style='height:21.0pt'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl67 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td rowspan=3 height=85 class=xl105 width=36 style='border-bottom:.5pt solid black;
  height:63.75pt;width:27pt'>No<br>
    STT</td>
  <td rowspan=3 class=xl123 width=73 style='border-bottom:.5pt solid black;
  width:55pt'>Emp ID<br>
    Mã NV</td>
  <td rowspan=3 class=xl105 width=149 style='border-bottom:.5pt solid black;
  width:112pt'>Full Name<br>
    H&#7885; và Tên</td>
  <td rowspan=3 class=xl105 width=91 style='border-bottom:.5pt solid black;
  width:68pt'>Position<br>
    Ch&#7913;c v&#7909;</td>
  <td rowspan=3 class=xl105 width=91 style='border-bottom:.5pt solid black;
  width:68pt'>Dept.<br>
    B&#7897; ph&#7853;n</td>
  <td rowspan=3 class=xl111 width=99 style='border-bottom:.5pt solid black;
  width:74pt'>Basic salary<br>
    L&#432;&#417;ng c&#417; b&#7843;n</td>
  <td colspan=7 class=xl114 width=441 style='border-right:.5pt solid black;
  width:329pt'><span style='mso-spacerun:yes'>     </span>Overtimes<br>
    T&#259;ng ca</td>
  <td rowspan=3 class=xl105 width=99 style='border-bottom:.5pt solid black;
  width:74pt'>Total Hours<br>
    T&#7893;ng s&#7889; gi&#7901;</td>
  <td rowspan=3 class=xl102 width=99 style='border-bottom:.5pt solid black;
  width:74pt'>Total Amount<br>
    T&#7893;ng s&#7889; ti&#7873;n</td>
  <td rowspan=3 class=xl105 width=67 style='border-bottom:.5pt solid black;
  width:50pt'>Remark<br>
    Ghi chú</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl67 height=20 style='height:15.0pt'>
  <td rowspan=2 height=44 class=xl121 style='border-bottom:.5pt solid black;
  height:33.0pt;border-top:none' x:num="1.5">150%</td>
  <td rowspan=2 class=xl100 style='border-bottom:.5pt solid black;border-top:
  none' x:num="2">200%</td>
  <td rowspan=2 class=xl100 style='border-bottom:.5pt solid black;border-top:
  none' x:num="3">300%</td>
  <td rowspan=2 class=xl100 style='border-bottom:.5pt solid black;border-top:
  none' x:num="0.3">30%</td>
  <td rowspan=2 class=xl100 style='border-bottom:.5pt solid black;border-top:
  none' x:num="0.45">45%</td>
  <td rowspan=2 class=xl100 style='border-bottom:.5pt solid black;border-top:
  none' x:num="0.6">60%</td>
  <td rowspan=2 class=xl100 style='border-bottom:.5pt solid black;border-top:
  none' x:num="0.9">90%</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=3 style='height:18.0pt;mso-ignore:colspan'></td>
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
  <td colspan=2 height=28 class=xl117 style='height:21.0pt'><%= dt_Emp.Rows[i][0].ToString()%></td>
  <td class=xl81 style='border-top:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none'>&nbsp;</td>
  <td class=xl70 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl72 style='border-top:none'>&nbsp;</td>
  <td class=xl80 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none'>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
    <%	
        flag = false;
        }
 %>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl73 style='height:24.0pt;border-top:none' x:num><%= count %></td>
  <td class=xl98 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl96 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl97 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl97 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= dt_Emp.Rows[i][5].ToString()%> </td>
  <td class=xl93 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][6].ToString()%> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= dt_Emp.Rows[i][7].ToString()%> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][8].ToString()%> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][9].ToString()%> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][10].ToString()%> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][11].ToString()%> </td>
  <td class=xl93 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][12].ToString()%> </td>
  <td class=xl82 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= dt_Emp.Rows[i][13].ToString()%> </td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= dt_Emp.Rows[i][14].ToString()%> </td>
  <td class=xl76 style='border-top:none'>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
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
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=5 height=32 class=xl108 style='height:24.0pt'>TOTAL <%= dt_Emp.Rows[i][0].ToString()%></td>
  <td class=xl84 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= total[0] %> </td>
  <td class=xl91 x:num><span style='mso-spacerun:yes'>         </span><%= total[1] %> </td>
  <td class=xl91 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= total[2] %> </td>
  <td class=xl91 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[3] %> </td>
  <td class=xl91 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[4] %> </td>
  <td class=xl91 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[5] %> </td>
  <td class=xl91 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[6] %> </td>
  <td class=xl91 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[7] %> </td>
  <td class=xl83 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= total[8] %> </td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= total[9] %> </td>
  <td class=xl76 style='border-top:none'>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <%
     
     for (int k = 0; k < 10; k++)
         total[k] = 0;     
    flag_total = false;
   }
}
      
	%>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=5 height=32 class=xl108 style='border-right:.5pt solid black;
  height:24.0pt'>GRAND<span style='mso-spacerun:yes'>  </span>TOTAL <%= count %> EMPLOYEE</td>
  <td class=xl84 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>    </span><%= gtotal[0] %> </td>
  <td class=xl92 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[1] %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= gtotal[2] %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[3] %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[4] %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[5] %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[6] %> </td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[7] %> </td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>             </span><%= gtotal[8] %> </td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= gtotal[9] %> </td>
  <td class=xl87 style='border-top:none'></td>
  <td class=xl90></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl74 style='height:16.5pt;border-top:none' x:num></td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl94 style='border-top:none;border-left:none'>Average/person</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl75 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl85 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                 </span><%= gtotal[8]/count %> </td>
  <td class=xl86 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[9]/count %> </td>
  <td class=xl87 style='border-top:none'></td>
  <td class=xl88 style='border-left:none'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl77 style='height:16.5pt'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl78 style='border-left:none'>&nbsp;</td>
  <td class=xl87 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl95 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span> </td>
  <td class=xl87 style='border-top:none'></td>
  <td class=xl89 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>   </span> </td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=149 style='width:112pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
