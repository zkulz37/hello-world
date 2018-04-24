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
    string p_mon,p_from,p_to;

    p_mon = Request["p_mon"].ToString();
    p_from = Request["p_from"].ToString();
    p_to = Request["p_to"].ToString();

    string SQL
    = "select max(round(s.SALARY_LEVEL2,0))  " +
        ", s.emp_id " +
        ", s.full_name " +
		", to_char(to_date(max(a.work_dt),'yyyymmdd'),'dd/mm/yyyy') " +
        ", max(t.TIME_IN) " +
        ", max(t.TIME_OUT)  " +
        ", sum(decode(a.pay_rate,150, a.ot_time, 0)) as rate150 " +
        ", sum(decode(a.pay_rate,200, a.ot_time, 0)) as rate200 " +
        ", sum(decode(a.pay_rate,300, a.ot_time, 0)) as rate300 " +
        ", sum(decode(a.pay_rate,30, a.ot_time, 0)) as rate30 " +
        ", sum(decode(a.pay_rate,45, a.ot_time, 0)) as rate45 " +
        ", sum(decode(a.pay_rate,60, a.ot_time, 0)) as rate60 " +
        ", sum(decode(a.pay_rate,90, a.ot_time, 0)) as rate90 " +
        ", sum(a.ot_time) total " +
        ", round(sum( (case when a.pay_rate = 150 then a.ot_time*1.5 " +
        "             when a.pay_rate = 200 then a.ot_time*2 " +
        "             when a.pay_rate = 300 then a.ot_time*3 " +
        "             when a.pay_rate = 30 then a.ot_time*0.3 " +
        "             when a.pay_rate = 45 then a.ot_time*0.45 " +
        "             when a.pay_rate = 60 then a.ot_time*0.6 " +
        "             when a.pay_rate = 90 then a.ot_time*0.9 " +
        "        end)* (case when a.work_dt < s.confirm_dt then nvl(s.SAL_WITH_OT_L1,0)/26/8 " +
        "                    when a.work_dt >= s.confirm_dt or s.confirm_dt is null then nvl(s.SAL_WITH_OT_L2,0)/26/8 " +
        "                end) " +
        "      ),0) total_money " +
        " , round(sum( (case when a.pay_rate = 150 then a.ot_time " +
        "             when a.pay_rate = 200 then a.ot_time " +
        "             when a.pay_rate = 300 then a.ot_time " +
        "        end)* (case when a.work_dt < s.confirm_dt then nvl(s.SAL_WITH_OT_L1,0)/26/8 " +
        "                    when a.work_dt >= s.confirm_dt or s.confirm_dt is null then nvl(s.SAL_WITH_OT_L2,0)/26/8 " +
        "                end) " +
        "      ),0) total_money_100 " +
        "from thr_extra_time a, thr_month_salary s, thr_time_machine t " +
        "where a.del_if=0 and s.del_if=0 and t.del_if=0 " +
        "and a.thr_emp_pk = t.thr_emp_pk and a.work_dt = t.work_dt " +
        "and a.thr_emp_pk = s.THR_EMP_PK " +
        "and s.WORK_MON ='" + p_mon + "' " +
        "and a.work_dt between '" + p_from + "' and '" + p_to + "' " +
        "and a.THR_WG_PK = 21 " +
        "and nvl(a.ot_time,0) >0 " +
        "group by a.thr_emp_pk, a.work_dt, s.full_name, s.emp_id " +
        "order by a.thr_emp_pk, a.work_dt ";


    //Response.Write(SQL);
    //Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
	string cur_grp, next_grp;
    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_driver_overtime_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_driver_overtime_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_driver_overtime_vhpc_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Posco</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-06-12T15:08:20Z</o:LastPrinted>
  <o:Created>2007-11-19T02:01:31Z</o:Created>
  <o:LastSaved>2011-06-12T16:09:02Z</o:LastSaved>
  <o:Company>Posco</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.23in .25in .25in .42in;
	mso-header-margin:.51in;
	mso-footer-margin:.3in;
	mso-page-orientation:landscape;}
.font8
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
.style45
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:"Comma 2";}
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
.style59
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 2";}
.style60
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Jan;}
.style61
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
	mso-style-name:Normal_Sheet1;}
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
.xl69
	{mso-style-parent:style59;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl70
	{mso-style-parent:style45;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"h\:mm\;\@";}
.xl71
	{mso-style-parent:style45;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"h\:mm\;\@";}
.xl72
	{mso-style-parent:style59;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl73
	{mso-style-parent:style59;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style45;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl75
	{mso-style-parent:style45;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl76
	{mso-style-parent:style59;
	color:windowtext;
	font-weight:700;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl77
	{mso-style-parent:style45;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;}
.xl78
	{mso-style-parent:style43;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl79
	{mso-style-parent:style45;
	color:windowtext;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl80
	{mso-style-parent:style45;
	color:red;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl81
	{mso-style-parent:style45;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl82
	{mso-style-parent:style45;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl83
	{mso-style-parent:style43;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl84
	{mso-style-parent:style60;
	color:windowtext;
	font-size:10.0pt;
	font-family:VNI-Times, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl85
	{mso-style-parent:style59;
	color:windowtext;
	font-size:13.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl86
	{mso-style-parent:style61;
	color:windowtext;
	font-size:10.5pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl87
	{mso-style-parent:style59;
	color:windowtext;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl88
	{mso-style-parent:style45;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl89
	{mso-style-parent:style45;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style59;
	color:windowtext;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl92
	{mso-style-parent:style45;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl93
	{mso-style-parent:style59;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl94
	{mso-style-parent:style59;
	color:windowtext;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl95
	{mso-style-parent:style59;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"h\:mm\;\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl96
	{mso-style-parent:style45;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style45;
	color:windowtext;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style45;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl100
	{mso-style-parent:style45;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl101
	{mso-style-parent:style59;
	color:windowtext;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style45;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl103
	{mso-style-parent:style59;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl104
	{mso-style-parent:style45;
	color:red;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl105
	{mso-style-parent:style59;
	color:windowtext;
	font-size:25.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl106
	{mso-style-parent:style59;
	color:windowtext;
	font-size:16.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"mm\\-yyyy";
	text-align:center;}
.xl107
	{mso-style-parent:style59;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl108
	{mso-style-parent:style59;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl109
	{mso-style-parent:style59;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"h\:mm\;\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl110
	{mso-style-parent:style59;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl111
	{mso-style-parent:style59;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"h\:mm\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl112
	{mso-style-parent:style45;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"h\:mm\;\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style45;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"h\:mm\;\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl114
	{mso-style-parent:style45;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"h\:mm\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl115
	{mso-style-parent:style45;
	color:windowtext;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"h\:mm\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Overtime Driver</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int ibreak=10;
        
        for (int k=0;k<irow;k++)
        {
           ibreak +=1;
            cur_grp=dt_total.Rows[k][1].ToString() ;
            if (k<irow -1)
            {
                
                next_grp=dt_total.Rows[k+1][1].ToString();
                if (cur_grp!=next_grp)
                {   ibreak += 8;
                
                %>
                    <x:RowBreak>
                        <x:Row><%=ibreak %></x:Row>
                    </x:RowBreak>
                <%
                }
                
            }    
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9120</x:WindowHeight>
  <x:WindowWidth>12120</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl69>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1604 style='border-collapse:
 collapse;table-layout:fixed;width:1207pt'>
 <col class=xl69 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl70 width=85 span=2 style='mso-width-source:userset;mso-width-alt:
 3108;width:64pt'>
 <col class=xl71 width=78 span=7 style='mso-width-source:userset;mso-width-alt:
 2852;width:59pt'>
 <col class=xl71 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt;display:none'>
 <col class=xl71 width=115 span=2 style='mso-width-source:userset;mso-width-alt:
 4205;width:86pt'>
 <col class=xl69 width=247 style='mso-width-source:userset;mso-width-alt:9033;
 width:185pt'>
 <col class=xl69 width=113 span=2 style='mso-width-source:userset;mso-width-alt:
 4132;width:85pt'>
  <% 
          
      int count = 0;
      Boolean flag_h = true;
      Boolean flag_f = false;
      string old_r, new_r;
      int i, j;
      double[] total = new double[10];
      for (int k = 0; k < 10; k++)
          total[k] = 0;
      for (i = 0; i < irow; i++)
      {
          
          count++;
          old_r = dt_total.Rows[i][1].ToString();

          for ( j = 6; j < dt_total.Columns.Count; j++)
          {
              total[j - 6] += Double.Parse(dt_total.Rows[i][j].ToString());
          }
          if (flag_h)
          {
              
    %>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl69 colspan=2 width=193 style='height:14.25pt;
  mso-ignore:colspan;width:145pt' x:str="POSCO-VHPC ">POSCO-VHPC<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl70 width=85 style='width:64pt'></td>
  <td class=xl71 width=78 style='width:59pt'></td>
  <td class=xl71 width=78 style='width:59pt'></td>
  <td class=xl71 width=78 style='width:59pt'></td>
  <td class=xl71 width=78 style='width:59pt'></td>
  <td class=xl71 width=78 style='width:59pt'></td>
  <td class=xl71 width=78 style='width:59pt'></td>
  <td class=xl71 width=78 style='width:59pt'></td>
  <td class=xl71 width=77 style='width:58pt'></td>
  <td class=xl71 width=115 style='width:86pt'></td>
  <td class=xl71 width=115 style='width:86pt'></td>
  <td class=xl69 width=247 style='width:185pt'></td>
  <td class=xl69 width=113 style='width:85pt'></td>
  <td class=xl69 width=113 style='width:85pt'></td>
 </tr>
     
 <tr height=41 style='height:30.75pt'>
  <td colspan=14 height=41 class=xl105 style='height:30.75pt'>OVERTIME
  CALCULATION</td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=14 height=27 class=xl106 style='height:20.25pt' x:num><%= p_mon.Substring(4,2).ToString() %>-<%= p_mon.Substring(0,4).ToString() %></td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl91 style='height:15.0pt'>Emp ID:</td>
  <td class=xl92 x:str><%= dt_total.Rows[i][1].ToString() %></td>
  <td class=xl70></td>
  <td colspan=10 class=xl71 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl91 style='height:15.0pt'>Driver's Name:<font
  class="font8"><span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl93 colspan=2 style='mso-ignore:colspan'><%= dt_total.Rows[i][2].ToString() %></td>
  <td class=xl71></td>
  <td class=xl74></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl74></td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl94 style='height:15.0pt'>Basic Salary:</td>
  <td class=xl89 x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][0].ToString() %> </td>
  <td class=xl88></td>
  <td class=xl78></td>
  <td class=xl74></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl74></td>
  <td class=xl71></td>
  <td colspan=4 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl69 style='height:14.25pt'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl78></td>
  <td class=xl74></td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
  <td class=xl74></td>
  <td class=xl71></td>
  <td colspan=4 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl76 style='height:14.25pt'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl77 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl75 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl108 width=108 style='height:21.0pt;width:81pt'>&nbsp;</td>
  <td class=xl109 width=85 style='border-left:none;width:64pt'>&nbsp;</td>
  <td class=xl109 width=85 style='border-left:none;width:64pt'>&nbsp;</td>
  <td class=xl96 style='border-left:none' x:num="1.5">150%</td>
  <td class=xl96 style='border-left:none' x:num="2">200%</td>
  <td class=xl96 style='border-left:none' x:num="3">300%</td>
  <td class=xl96 style='border-left:none' x:num="0.3">30%</td>
  <td class=xl96 style='border-left:none' x:num="0.45">45%</td>
  <td class=xl96 style='border-left:none' x:num="0.6">60%</td>
  <td class=xl96 style='border-left:none' x:num="0.9">90%</td>
  <td class=xl109 width=77 style='border-left:none;width:58pt'>&nbsp;</td>
  <td class=xl112 style='border-left:none'>&nbsp;</td>
  <td class=xl113 width=115 style='border-left:none;width:86pt'>&nbsp;</td>
  <td class=xl108 width=247 style='border-left:none;width:185pt'>&nbsp;</td>
  <td colspan=2 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl72 height=52 style='mso-height-source:userset;height:39.0pt'>
  <td height=52 class=xl110 width=108 style='height:39.0pt;width:81pt'>Date</td>
  <td class=xl111 width=85 style='border-left:none;width:64pt'>Starting Time</td>
  <td class=xl111 width=85 style='border-left:none;width:64pt'>Ending Time</td>
  <td class=xl95 width=78 style='border-top:none;border-left:none;width:59pt'>Normal
  day</td>
  <td class=xl95 width=78 style='border-top:none;border-left:none;width:59pt'>Day
  off</td>
  <td class=xl95 width=78 style='border-top:none;border-left:none;width:59pt'>Holiday</td>
  <td class=xl95 width=78 style='border-top:none;border-left:none;width:59pt'
  x:str="Night ">Night<span style='mso-spacerun:yes'> </span></td>
  <td class=xl95 width=78 style='border-top:none;border-left:none;width:59pt'
  x:str="Night ">Night<span style='mso-spacerun:yes'> </span></td>
  <td class=xl95 width=78 style='border-top:none;border-left:none;width:59pt'>Night
  off</td>
  <td class=xl95 width=78 style='border-top:none;border-left:none;width:59pt'
  x:str="Night Holiday ">Night Holiday<span style='mso-spacerun:yes'> </span></td>
  <td class=xl111 width=77 style='border-left:none;width:58pt'>Total Overtime</td>
  <td class=xl115 style='border-left:none'>Total Amount</td>
  <td class=xl114 width=115 style='border-left:none;width:86pt'>Total <br>
    PIT</td>
  <td class=xl110 width=247 style='border-left:none;width:185pt'>Remarks</td>
  <td colspan=2 class=xl72 style='mso-ignore:colspan'></td>
 </tr>
    <%         
     flag_h = false;
           } // end if 
               %>
 <tr class=xl73 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl97 style='height:24.0pt' x:num><%= dt_total.Rows[i][3].ToString() %></td>
  <td class=xl90 style='border-left:none'><%= dt_total.Rows[i][4].ToString() %></td>
  <td class=xl90 style='border-left:none'><%= dt_total.Rows[i][5].ToString() %></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][6].ToString() %> </td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][7].ToString() %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][8].ToString() %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][9].ToString() %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][10].ToString() %> </td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][11].ToString() %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl98 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][12].ToString() %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl99 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][13].ToString() %> </td>
  <td class=xl100 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][14].ToString() %></td>
  <td class=xl100 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][15].ToString() %> </td>
  <td class=xl101 style='border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl73 style='mso-ignore:colspan'></td>
 </tr>
  <%
      if (i < irow - 1)
      {
          new_r = dt_total.Rows[i + 1][1].ToString();
          if (old_r != new_r)
          {
              flag_h = true;
              flag_f = true;
          }
          else
          {
              flag_h = false;
              flag_f = false;
          }
      }
      else
      {
          flag_h = true;
          flag_f = true;
      }
          

  %>
 <%  
     if (flag_f == true)
     { 
  %>
 <tr class=xl85 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=3 height=36 class=xl107 style='height:27.0pt'>Total</td>
  <td class=xl102 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'> </span><%= total[0] %> </td>
  <td class=xl102 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'> </span><%= total[1] %> </td>
  <td class=xl102 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= total[2] %> </td>
  <td class=xl102 style='border-top:none;border-left:none' x:num><%= total[3] %></td>
  <td class=xl102 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= total[4] %> </td>
  <td class=xl102 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= total[5] %> </td>
  <td class=xl102 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= total[6] %><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl102 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'> </span><%= total[7] %> </td>
  <td class=xl103 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= total[8] %> </td>
  <td class=xl103 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= total[9] %> </td>
  <td class=xl104 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl85 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl69 style='height:14.25pt'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=5 class=xl79 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl69 style='height:14.25pt'></td>
  <td class=xl87 colspan=2 style='mso-ignore:colspan'>Prepared by:</td>
  <td colspan=4 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl75></td>
  <td class=xl86></td>
  <td class=xl83></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl69 style='height:14.25pt'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl80 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl69 style='height:14.25pt'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl80 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl69 style='height:14.25pt'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl80 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl69 style='height:15.0pt'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl81></td>
  <td class=xl84></td>
  <td colspan=2 class=xl81 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl82 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl69 style='height:14.25pt'></td>
  <td class=xl69 colspan=2 style='mso-ignore:colspan'>Ms. Le Thi Kieu Hanh</td>
  <td colspan=10 class=xl80 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 style='mso-ignore:colspan'></td>
 </tr>
    <%
        for (int k = 0; k < 10; k++)
            total[k] = 0;
     flag_f = false;
     } //end if       
   } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=108 style='width:81pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=247 style='width:185pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=113 style='width:85pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
