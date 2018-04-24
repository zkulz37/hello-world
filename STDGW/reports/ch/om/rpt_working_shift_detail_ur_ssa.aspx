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
    string p_tco_org_pk,p_thr_wg_pk,p_status,p_emp_id,p_work_mon,p_from_dt,p_to_dt,p_dept_nm,p_times,p_nation;
    
    p_tco_org_pk = Request["l_tco_dept_pk"].ToString();
    p_thr_wg_pk = Request["l_thr_group_pk"].ToString();
    p_status = Request["l_status"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();
    p_to_dt = Request["l_to_dt"].ToString();
    p_from_dt = Request["l_from_dt"].ToString();
    p_dept_nm = Request["l_dept_nm"].ToString();
    p_times = Request["l_resign_times"].ToString();
    p_nation = Request["l_nation"].ToString();
    //-----------------information of company-----------------
    string SQL_Com
	= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY') " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               comm.tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_org_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_org_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_org_pk + "' = 'ALL') " +
        "and rownum=1 " ;

    //Response.Write(SQL_Com);
    //Response.End();
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    //-----------------working time-----------------

string SQL
= "select d.dept_nm, E.EMP_ID, E.FULL_NAME " +
"        , to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') join_dt " +
 "        , max(decode(substr(A.WORK_DT,-2),'01',decode(HR.F_CHECK_NUMBER(nvl(D.D1,'0')),0,D.D1, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),''))  dd1 " +
"        , max(decode(substr(A.WORK_DT,-2),'02',decode(HR.F_CHECK_NUMBER(nvl(D.D2,'0')),0,D.D2, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd2  " +
"        , max(decode(substr(A.WORK_DT,-2),'03',decode(HR.F_CHECK_NUMBER(nvl(D.D3,'0')),0,D.D3, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd3  " +
"        , max(decode(substr(A.WORK_DT,-2),'04',decode(HR.F_CHECK_NUMBER(nvl(D.D4,'0')),0,D.D4, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd4  " +
"        , max(decode(substr(A.WORK_DT,-2),'05',decode(HR.F_CHECK_NUMBER(nvl(D.D5,'0')),0,D.D5, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd5  " +
"        , max(decode(substr(A.WORK_DT,-2),'06',decode(HR.F_CHECK_NUMBER(nvl(D.D6,'0')),0,D.D6, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd6  " +
"        , max(decode(substr(A.WORK_DT,-2),'07',decode(HR.F_CHECK_NUMBER(nvl(D.D7,'0')),0,D.D7, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd7  " +
"        , max(decode(substr(A.WORK_DT,-2),'08',decode(HR.F_CHECK_NUMBER(nvl(D.D8,'0')),0,D.D8, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd8  " +
"        , max(decode(substr(A.WORK_DT,-2),'09',decode(HR.F_CHECK_NUMBER(nvl(D.D9,'0')),0,D.D9, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd9  " +
"        , max(decode(substr(A.WORK_DT,-2),'10',decode(HR.F_CHECK_NUMBER(nvl(D.D10,'0')),0,D.D10, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd10  " +
"        , max(decode(substr(A.WORK_DT,-2),'11',decode(HR.F_CHECK_NUMBER(nvl(D.D11,'0')),0,D.D11, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd11  " +
"        , max(decode(substr(A.WORK_DT,-2),'12',decode(HR.F_CHECK_NUMBER(nvl(D.D12,'0')),0,D.D12, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd12  " +
"        , max(decode(substr(A.WORK_DT,-2),'13',decode(HR.F_CHECK_NUMBER(nvl(D.D13,'0')),0,D.D13, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd13  " +
"        , max(decode(substr(A.WORK_DT,-2),'14',decode(HR.F_CHECK_NUMBER(nvl(D.D14,'0')),0,D.D14, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd14  " +
"        , max(decode(substr(A.WORK_DT,-2),'15',decode(HR.F_CHECK_NUMBER(nvl(D.D15,'0')),0,D.D15, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd15  " +
"        , max(decode(substr(A.WORK_DT,-2),'16',decode(HR.F_CHECK_NUMBER(nvl(D.D16,'0')),0,D.D16, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd16  " +
"        , max(decode(substr(A.WORK_DT,-2),'17',decode(HR.F_CHECK_NUMBER(nvl(D.D17,'0')),0,D.D17, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd17  " +
"        , max(decode(substr(A.WORK_DT,-2),'18',decode(HR.F_CHECK_NUMBER(nvl(D.D18,'0')),0,D.D18, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd18  " +
"        , max(decode(substr(A.WORK_DT,-2),'19',decode(HR.F_CHECK_NUMBER(nvl(D.D19,'0')),0,D.D19, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd19  " +
"        , max(decode(substr(A.WORK_DT,-2),'20',decode(HR.F_CHECK_NUMBER(nvl(D.D20,'0')),0,D.D20, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd20  " +
"        , max(decode(substr(A.WORK_DT,-2),'21',decode(HR.F_CHECK_NUMBER(nvl(D.D21,'0')),0,D.D21, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd21  " +
"        , max(decode(substr(A.WORK_DT,-2),'22',decode(HR.F_CHECK_NUMBER(nvl(D.D22,'0')),0,D.D22, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd22  " +
"        , max(decode(substr(A.WORK_DT,-2),'23',decode(HR.F_CHECK_NUMBER(nvl(D.D23,'0')),0,D.D23, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd23  " +
"        , max(decode(substr(A.WORK_DT,-2),'24',decode(HR.F_CHECK_NUMBER(nvl(D.D24,'0')),0,D.D24, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd24  " +
"        , max(decode(substr(A.WORK_DT,-2),'25',decode(HR.F_CHECK_NUMBER(nvl(D.D25,'0')),0,D.D25, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd25  " +
"        , max(decode(substr(A.WORK_DT,-2),'26',decode(HR.F_CHECK_NUMBER(nvl(D.D26,'0')),0,D.D26, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd26  " +
"        , max(decode(substr(A.WORK_DT,-2),'27',decode(HR.F_CHECK_NUMBER(nvl(D.D27,'0')),0,D.D27, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd27  " +
"        , max(decode(substr(A.WORK_DT,-2),'28',decode(HR.F_CHECK_NUMBER(nvl(D.D28,'0')),0,D.D28, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd28  " +
"        , max(decode(substr(A.WORK_DT,-2),'29',decode(HR.F_CHECK_NUMBER(nvl(D.D29,'0')),0,D.D29, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd29  " +
"        , max(decode(substr(A.WORK_DT,-2),'30',decode(HR.F_CHECK_NUMBER(nvl(D.D30,'0')),0,D.D30, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd30  " +
"        , max(decode(substr(A.WORK_DT,-2),'31',decode(HR.F_CHECK_NUMBER(nvl(D.D31,'0')),0,D.D31, decode(b.shift,5,'B',6,'C',7,'A',1,'HC',b.shift||' ')),'')) dd31  " +
"from thr_wg_sch_detail_ur a, thr_work_shift b, thr_work_group c,thr_work_mon_ur d, thr_employee e      " +
"where A.DEL_IF=0 " +
"and B.DEL_IF=0 " +
"and A.THR_WS_PK=b.pk " +
"and A.THR_EMP_PK=e.pk " +
"and D.THR_EMP_PK=e.pk " +
"and C.PK=D.THR_GROUP_PK " +
"and D.WORK_MON='" + p_work_mon + "' " +
"and a.work_dt between '" + p_from_dt + "' and '" + p_to_dt + "'" +
"and a.work_dt between '" + p_from_dt + "' and nvl( to_char(to_date( e.left_dt,'yyyymmdd')-1,'yyyymmdd'),'" + p_to_dt + "') " +
"and (d.tco_dept_pk in ( " +
"                              SELECT     g.pk " +
"                                    FROM comm.tco_org g " +
"                                   WHERE g.del_if = 0 " +
"                              START WITH g.pk = " +
"                                            DECODE ('" + p_tco_org_pk + "', " +
"                                                    'ALL', 0, " +
"                                                    '" + p_tco_org_pk + "' " +
"                                                   ) " +
"                              CONNECT BY PRIOR g.pk = g.p_pk) " +
"                        OR '" + p_tco_org_pk + "' = 'ALL') " +
"and decode('" + p_thr_wg_pk + "','ALL','ALL',d.thr_group_pk)='" + p_thr_wg_pk + "' " +
"and d.emp_id like '%" + p_emp_id + "%' " +
"and decode('" + p_status + "','ALL','ALL',d.status)='" + p_status + "' " +
" and decode('" + p_nation + "','ALL','ALL',decode(e.nation,'01','01','02'))='" + p_nation + "' " +
"and decode('" + p_times + "','ALL','ALL',nvl(d.times,' '))='" + p_times + "' " +
"group by d.dept_nm, E.EMP_ID, E.FULL_NAME " +
"    , to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy') " +
"order by d.dept_nm, E.EMP_ID, E.FULL_NAME " +
"    , to_char(to_date(E.JOIN_DT,'yyyymmdd'),'dd/mm/yyyy')   ";

    
    //Response.Write(SQL);
 //   Response.End();   
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
	= "select substr(car_date,-2),hol_type " + 
        "from tco_abcalendar  " +
        "where del_if=0 and car_date between '" + p_from_dt + "' and '" + p_to_dt + "' order by car_date ";
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
<link rel=File-List href="rpt_working_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_working_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_working_summary_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-08-12T04:30:21Z</o:LastPrinted>
  <o:Created>2008-08-12T02:55:49Z</o:Created>
  <o:LastSaved>2008-08-19T08:49:03Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.22in .2in .38in .2in;
	mso-header-margin:.24in;
	mso-footer-margin:.18in;
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
	padding:0px;
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
.xl24
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
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
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	color:navy;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	color:navy;
	font-size:30.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	color:navy;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FF99CC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	color:navy;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yyyy";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
     <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>43</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int icur_row;
        icur_row=5;
        string next_group,cur_group;
        for (int i=0;i<irow_emp-1;i++)
        {
            icur_row+=2;
            cur_group=dt_Emp.Rows[i][0].ToString();
            next_group=dt_Emp.Rows[i+1][0].ToString();
            if (next_group != cur_group)
            {
      %>
      <x:RowBreak>
       <x:Row><%=icur_row %></x:Row>
      </x:RowBreak>
      <%
            }
        }
       %>
     </x:RowBreaks>
    </x:PageBreaks>
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
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2320 style='border-collapse:
 collapse;table-layout:fixed;width:1757pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=64 style='width:48pt'>
 <col width=159 style='mso-width-source:userset;mso-width-alt:5814;width:119pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt; display:none'>
 <col width=50 span="<%=iDate_Num%>" style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col width=56 span=4 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 width=42 style='height:24.75pt;width:32pt' align=left
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:0;margin-top:6.75pt;width:93pt;height:62.25pt;z-index:1'>
   <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" o:title="vinagenuwin"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:9px;width:124px;
  height:83px'><img width=124 height=83
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_Com.Rows[0][3].ToString()%>&table_name=tco_bpphoto" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=33 width=42 style='height:24.75pt;width:32pt'></td>
   </tr>
  </table>
  </span></td>
  <td width=102 style='width:77pt'></td>
  <td class=xl31 colspan=2 width=223 style='mso-ignore:colspan;width:167pt'><% = dt_Com.Rows[0][0].ToString()%></td>
  <td width=66 style='width:50pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td class=xl30 width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=74 style='width:56pt'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 colspan=2 style='height:31.5pt;mso-ignore:colspan'></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'><% = dt_Com.Rows[0][1].ToString()%></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl33>WORKING SUMMARY <% if (p_tco_org_pk!="ALL") 
                                     Response.Write(" - " + p_dept_nm); %></td>
  <td colspan=22 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 colspan=2 style='height:24.75pt;mso-ignore:colspan'></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span></td>
  <td colspan=14 style='mso-ignore:colspan'></td>
  <td class=xl34>Month:</td>
  <td colspan=2 class=xl47 width=100 style='width:76pt' x:num><%=dt_Com.Rows[0][4].ToString()%></td>
  <td colspan=21 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl25 style='height:27.0pt;font-style:italic;'>No.</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Group</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Emp ID</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Full Name</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Join Date</td>
  <td class=xl32 style='border-left:none;font-style:italic;'>Note</td>
   <%
    for (int j = 0; j < iDate_Num; j++) 
    {
   %>
  <td rowspan=2 class=xl45 style='border-bottom:.5pt solid black;font-style:italic;' x:num><%= dt_Cal.Rows[j][0].ToString() %></td>
  <%
    }
   %>
  
  <td class=xl29 style='font-style:italic;'>Sign</td>
 </tr>
 <tr class=xl24 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl25 style='height:27.0pt;font-style:italic;'>STT</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Nhóm</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Mã s&#7889;</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>H&#7885; và tên</td>
  <td class=xl25 style='border-left:none;font-style:italic;'>Ngày vào</td>
  <td class=xl32 style='border-left:none;font-style:italic;'>Ghi chú</td>  
  <td class=xl29 style='border-top:none;font-style:italic;'>Ch&#7919; ký</td>
 </tr>
  <% 
   
    for (int i = 0; i < irow_emp; i++) 
    {
    %> 
 <tr class=xl27 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td rowspan=1 height=84 class=xl43 style='border-bottom:.5pt solid black;
  height:63.0pt' x:num><%=i+1 %></td>
  <td rowspan=1 class=xl48 width=102 style='border-bottom:.5pt solid black; 
  width:77pt'><%= dt_Emp.Rows[i][0].ToString() %></td>
  <td rowspan=1 class=xl43 style='border-bottom:.5pt solid black'><%= dt_Emp.Rows[i][1].ToString() %></td>
  <td rowspan=1 class=xl48 width=159 style='border-bottom:.5pt solid black;
  width:119pt'><%= dt_Emp.Rows[i][2].ToString() %></td>
  <td rowspan=1 class=xl51 style='border-bottom:.5pt solid black' x:num><%= dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl35 style='border-left:none;font-style:italic;'>WT(H)</td>
  <%
    for (int j = 0; j < iDate_Num; j++) 
    {
        string sformat;
        if (dt_Cal.Rows[j][1].ToString()=="HOL")
            sformat=";background:#FF99CC;mso-pattern:auto none;";
        else if (dt_Cal.Rows[j][1].ToString()=="SUN")
            sformat=";background:#CCFFFF;mso-pattern:auto none;";
        else
        
            sformat="";
   %>
  <td class=xl37 style='border-top:none<%=sformat %>' x:num ><%= dt_Emp.Rows[i][j+4].ToString() %></td>
  <%
    }//end of "for" of WT 
   %>
  
  <td rowspan=1 class=xl43 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
 </tr>
 
 <%
    } //end of "for" of employee 
  %>
 
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
