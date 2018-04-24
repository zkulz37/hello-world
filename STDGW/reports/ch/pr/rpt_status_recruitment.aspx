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
    
    string p_dept, p_master, p_detail, p_dtFrom, p_dtTo; 
     
  
    p_dept       = Request["l_dept"].ToString();
    p_master      = Request["l_master"].ToString();
    p_detail      = Request["l_detail"].ToString();
    p_dtFrom       = Request["l_dtFrom"].ToString();
    p_dtTo         = Request["l_dtTo"].ToString();



    string SQL
    = "select 0 " +
        "        ,(select k.org_nm from comm.tco_org k where k.del_if=0 and k.pk = (select o.p_pk from comm.tco_org o where o.del_if=0 and o.PK = c.p_pk)) as factory " +
        "        ,(select o.org_nm from comm.tco_org o where o.del_if=0 and o.PK = c.p_pk) as Dept " +
        "        ,c.org_nm as group_nm " +
        "        ,'' col_4 " +
        "        ,(select v.code_nm from vhr_hr_code v where v.id='HR0160' and v.code = a.edu_type) education_5 " +
        "        ,a.major major_6 " +
        "        ,a.experience_year exp_7 " +
        "        ,'' as c_8, '' as c_9 " +
        "        ,(select v.code_nm from vhr_hr_code v where v.id='HR0021' and v.code = a.province_type) area_10 " +
        "        ,a.height height_11 " +
        "        ,a.weight weight_12 " +
        "        ,(select v.code_nm from vhr_hr_code v where v.id='HR0161' and v.code = a.shift_type) shift_13 " +
        "        ,a.other other_14 " +
        "        ,nvl(a.req_num,0) req_num_15 " +
        "        ,nvl(a.req_num_male,0) male_16 " +
        "        ,nvl(a.req_num_female,0) femal_17 " +
        "        ,nvl(app1.app_num,0) app_num_18 " +
        "        ,nvl(app2.itv_num,0) itv_num_19 " +
        "        ,nvl(app3.pass_num,0) pass_num_20 " +
        "        ,nvl(emp.emp_num,0) emp_num_21 " +
        "        ,abs(nvl(emp.emp_num,0) - nvl(a.req_num,0)) thieu_22 " +
        "        ,nvl(emp.emp_num,0)*100/nvl(a.req_num,0) rate_23 " +
        "        ,to_char(to_date(b.from_dt,'yyyymmdd'),'dd/mm/yyyy') from_dt_24 " +
        "        ,to_char(to_date(b.to_dt,'yyyymmdd'),'dd/mm/yyyy') from_dt_25  " +
        "     from thr_rec_request_detail a, thr_rec_request b, comm.tco_org c " +
        "            ,(select e.THR_REC_REQUEST_DT_PK " +
        "              ,count(e.THR_REC_REQUEST_DT_PK) app_num             " +
        "                from thr_rec_emp e " +
        "                where e.del_if=0 " +
        "                    and e.cv_recieve_dt between '" + p_dtFrom + "' and '" + p_dtTo + "' " +
        "                group by e.THR_REC_REQUEST_DT_PK " +
        "            ) app1 " +
        "           ,(select e.THR_REC_REQUEST_DT_PK " +
        "              ,sum(case when e.result_t1 is not null or e.result_t2 is not null or e.result_t3 is not null " +
        "                then 1 else 0 end) itv_num             " +
        "                from thr_rec_emp e " +
        "                where e.del_if=0 " +
        "                    and ((e.interview_dt1 between '" + p_dtFrom + "' and '" + p_dtTo + "' ) " +
        "                        or(e.interview_dt2 between '" + p_dtFrom + "' and '" + p_dtTo + "' ) " +
        "                        or(e.interview_dt3 between '" + p_dtFrom + "' and '" + p_dtTo + "' )) " +
        "                group by e.THR_REC_REQUEST_DT_PK " +
        "            ) app2 " +
        "           ,(select e.THR_REC_REQUEST_DT_PK " +
        "              ,sum(decode(nvl(e.PASS_YN,'N'),'Y',1,0)) pass_num            " +
        "                from thr_rec_emp e " +
        "                where e.del_if=0 " +
        "                    and e.pass_dt between '" + p_dtFrom + "' and '" + p_dtTo + "' " +
        "                group by e.THR_REC_REQUEST_DT_PK " +
        "            ) app3 " +
        "          ,(select r.pk , count(r.pk) emp_num  " +
        "                from thr_employee e, thr_rec_emp a,thr_rec_request_detail r " +
        "                where e.del_if=0 and r.del_if=0 and a.del_if=0 " +
        "                and a.pk = e.THR_REC_EMP_PK " +
        "                and a.THR_REC_REQUEST_DT_PK = r.pk " +
        "                and r.app_status ='03' " +
        "                and e.join_dt between '" + p_dtFrom + "' and '" + p_dtTo + "' " +
        "                group by r.pk) emp " +
        "        where a.del_if=0 and c.del_if=0 and b.del_if=0 " +
        "            and a.thr_rec_request_pk = b.pk " +
        "            and b.tco_org_pk = c.pk " +
        "            and a.pk = app1.thr_rec_request_dt_pk(+) " +
        "            and a.pk = app2.thr_rec_request_dt_pk(+) " +
        "            and a.pk = app3.thr_rec_request_dt_pk(+) " +
        "            and a.pk = emp.pk(+) " +
        "            and a.app_status ='03'  " +
        "            and (('" + p_dtFrom + "' between b.from_dt  and b.to_dt) or ('" + p_dtTo + "' between b.from_dt and b.to_dt)) " +
        "           and (b.tco_org_pk in ( " +
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
        " and decode('" + p_master + "','ALL','ALL',a.thr_rec_request_pk)='" + p_master + "'" +
        " and decode('" + p_detail + "','ALL','ALL',a.pk)='" + p_detail + "'" +
        " order by 2 ";





   //Response.Write(SQL);
   //Response.End();

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
   
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
<link rel=File-List href="rpt_status_recruitment_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_status_recruitment_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_status_recruitment_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>nga</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-07-23T07:35:44Z</o:LastPrinted>
  <o:Created>2011-06-20T02:00:45Z</o:Created>
  <o:LastSaved>2011-07-23T08:02:57Z</o:LastSaved>
  <o:Company>vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.38in .16in .39in .17in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
	mso-page-orientation:landscape;}
.font8
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:12.0pt;
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
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl73
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl75
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl76
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl77
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl78
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
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
.xl80
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl81
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl82
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style59;
	color:windowtext;
	font-size:24.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl88
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style59;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl96
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl97
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl100
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl101
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl102
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl103
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl104
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.00\;\[Red\]0\.00";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl105
	{mso-style-parent:style59;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.00\;\[Red\]0\.00";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Theo doi tinh hinh tuyen dung</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>41</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7110</x:WindowHeight>
  <x:WindowWidth>10395</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="5121"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl71>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2417 style='border-collapse:
 collapse;table-layout:fixed;width:1814pt'>
 <col class=xl71 width=126 span=3 style='mso-width-source:userset;mso-width-alt:
 4608;width:95pt'>
 <col class=xl71 width=96 span=2 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <col class=xl71 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl71 width=96 span=7 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <col class=xl71 width=131 span=3 style='mso-width-source:userset;mso-width-alt:
 4790;width:98pt'>
 <col class=xl71 width=96 span=7 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <tr height=61 style='mso-height-source:userset;height:45.75pt'>
  <td colspan=23 height=61 class=xl83 width=2417 style='height:45.75pt;
  width:1814pt'>B&#7842;NG THEO DÕI TÌNH HÌNH TUY&#7874;N D&#7908;NG</td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=23 height=34 class=xl84 style='border-right:.5pt solid black;
  height:25.5pt'>T&#7915; ngày <%= p_dtFrom.Substring(6,2).ToString() %>/<%= p_dtFrom.Substring(4,2).ToString() %>/<%= p_dtFrom.Substring(0,4).ToString() %> &#273;&#7871;n ngày <%= p_dtTo.Substring(6,2).ToString() %>/<%= p_dtTo.Substring(4,2).ToString() %>/<%= p_dtTo.Substring(0,4).ToString() %></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td rowspan=2 height=105 class=xl87 width=126 style='border-bottom:.5pt solid black;
  height:78.75pt;border-top:none;width:95pt'>Factory<br>
    <font class="font9">X&#432;&#7903;ng</font></td>
  <td rowspan=2 class=xl81 width=126 style='border-top:none;width:95pt'><font
  class="font8">Department</font><font class="font9"><br>
    B&#7897; ph&#7853;n</font></td>
  <td rowspan=2 class=xl72 width=126 style='border-top:none;width:95pt'>Part<font
  class="font9"><br>
    Nhóm</font></td>
  <td rowspan=2 class=xl72 width=96 style='border-top:none;width:72pt'>Plan<br>
    <font class="font9">Ch&#7881; tiêu <br>
    &#273;&#7873; xu&#7845;t</font></td>
  <td colspan=10 class=xl74 width=1009 style='border-right:.5pt solid black;
  border-left:none;width:757pt'>DETAIL REQUEST/ <font class="font9">YÊU
  C&#7846;U CHI TI&#7870;T</font></td>
  <td rowspan=2 class=xl72 width=131 style='border-top:none;width:98pt'>Apply<br>
    H&#7891; S&#417; d&#7921; tuy&#7875;n</td>
  <td rowspan=2 class=xl72 width=131 style='border-top:none;width:98pt'>Interview
  <br>
    <font class="font9">H&#7891; S&#417; ch&#7885;n <br>
    Ph&#7887;ng v&#7845;n</font></td>
  <td rowspan=2 class=xl72 width=96 style='border-top:none;width:72pt'>Pass
  <br>
    <font class="font9">Nhân viên &#273;&#7841;t</font></td>
  <td rowspan=2 class=xl72 width=96 style='border-top:none;width:72pt'>Working<br>
    <font class="font9">Nhân viên nh&#7853;n vi&#7879;c</font></td>
  <td rowspan=2 class=xl72 width=96 style='border-top:none;width:72pt'>Shortage<br>
    <font class="font9">Thi&#7871;u</font></td>
  <td rowspan=2 class=xl79 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>Rate<br>
    <font class="font9">T&#7927; l&#7879;</font><font class="font8"><br>
    <span style='mso-spacerun:yes'> </span>(%)</font></td>
  <td rowspan=2 class=xl79 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>Start Date<br>
    <font class="font9">Ngày nh&#7853;n yêu c&#7847;u</font></td>
  <td rowspan=2 class=xl79 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>End Date<br>
    <font class="font9">Ngày hoàn thành tuy&#7875;n d&#7909;ng</font></td>
  <td rowspan=2 class=xl77 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>Remark<br>
    <font class="font9">Ghi chú</font></td>
 </tr>
 <tr height=63 style='height:47.25pt'>
  <td height=63 class=xl72 width=96 style='height:47.25pt;border-top:none;
  border-left:none;width:72pt'>Education <font class="font9">Trình
  &#273;&#7897;</font></td>
  <td class=xl72 width=110 style='border-top:none;border-left:none;width:83pt'>Major<br>
    <span style='mso-spacerun:yes'> </span><font class="font9">Chuyên ngành</font></td>
  <td class=xl72 width=96 style='border-top:none;border-left:none;width:72pt'>Experience<br>
    <font class="font9">Kinh nghi&#7879;m</font></td>
  <td class=xl72 width=96 style='border-top:none;border-left:none;width:72pt'>Male<br>
    <font class="font9">Nam</font></td>
  <td class=xl72 width=96 style='border-top:none;border-left:none;width:72pt'>Female<br>
    <font class="font9">N&#7919;</font></td>
  <td class=xl72 width=96 style='border-top:none;border-left:none;width:72pt'>Vùng/mi&#7873;n</td>
  <td class=xl72 width=96 style='border-top:none;border-left:none;width:72pt'>Height<br>
    <font class="font9">Chi&#7873;u cao</font></td>
  <td class=xl72 width=96 style='border-top:none;border-left:none;width:72pt'>Weight<br>
    <font class="font9">Cân n&#7863;ng<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl72 width=96 style='border-top:none;border-left:none;width:72pt'>Work
  Type<br>
    <font class="font9">Th&#7901;i gian làm vi&#7879;c</font></td>
  <td class=xl72 width=131 style='border-top:none;border-left:none;width:98pt'>Other<br>
    <font class="font9">Khác</font></td>
 </tr>
 <%
     string dept_old,  dept_new;
     bool flag_total = false;
     int count = 1;
     double[] total = new double[8];
     double[] gtotal = new double[8];
     for (int i = 0; i < 8; i++)
     {
         total[i] = 0;
         gtotal[i] = 0;
     }
     for (int i = 0; i < irow_emp; i++)
     {
         dept_old = dt_Emp.Rows[i][1].ToString();

         for (int k = 15; k < 23; k++)
         {
             total[k - 15] += double.Parse(dt_Emp.Rows[i][k].ToString());
             gtotal[k - 15] += double.Parse(dt_Emp.Rows[i][k].ToString());
         }
      %>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl89 style='height:26.25pt;border-top:none'><%= dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl89 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl89 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][15].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][16].ToString() %></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][17].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][10].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][11].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][12].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][13].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][14].ToString() %></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][18].ToString() %></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][19].ToString() %></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][20].ToString() %></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][21].ToString() %></td>
  <td class=xl90 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][22].ToString() %></td>
  <td class=xl92 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][23].ToString() %></td>
  <td class=xl93 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][24].ToString() %></td>
  <td class=xl93 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][25].ToString() %></td>
  <td class=xl91 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
     
    if (i < irow_emp - 1)
    {
        count = count + 1;
        dept_new = dt_Emp.Rows[i + 1][1].ToString();
        if (dept_new != dept_old)
        {
            flag_total = true;
        }
    }
    else
    {
        flag_total = true;
    }
    if (flag_total)
    {
  %>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=3 height=35 class=xl94 style='border-right:.5pt solid black;
  height:26.25pt'>Total</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num><%= total[0] %></td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num><%= total[1] %></td>
  <td class=xl97 style='border-top:none;border-left:none' x:num><%= total[2] %></td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl97 style='border-top:none;border-left:none' x:num><%= total[3] %></td>
  <td class=xl97 style='border-top:none;border-left:none' x:num><%= total[4] %></td>
  <td class=xl97 style='border-top:none;border-left:none' x:num><%= total[5] %></td>
  <td class=xl97 style='border-top:none;border-left:none' x:num><%= total[6] %></td>
  <td class=xl97 style='border-top:none;border-left:none' x:num><%= total[7] %></td>
  <td class=xl104 style='border-top:none;border-left:none' x:num><%= total[6]*100/total[0] %></td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl98 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
     flag_total = false;
     for (int k = 0; k < 8; k++)
         total[k] = 0;
    }
   } %>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=3 height=35 class=xl99 style='border-right:.5pt solid black;
  height:26.25pt'>T&#7893;ng</td>
  <td class=xl102 style='border-left:none' x:num><%= gtotal[0] %></td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-left:none' x:num><%= gtotal[1] %></td>
  <td class=xl102 style='border-left:none' x:num><%= gtotal[2] %></td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-left:none'>&nbsp;</td>
  <td class=xl102 style='border-left:none' x:num><%= gtotal[3] %></td>
  <td class=xl102 style='border-left:none' x:num><%= gtotal[4] %></td>
  <td class=xl102 style='border-left:none' x:num><%= gtotal[5] %></td>
  <td class=xl102 style='border-left:none' x:num><%= gtotal[6] %></td>
  <td class=xl102 style='border-left:none' x:num><%= gtotal[7] %></td>
  <td class=xl105 style='border-top:none;border-left:none' x:num><%= gtotal[6]*100/gtotal[0] %></td>
  <td class=xl103 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=126 style='width:95pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
