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
    
    string l_year;
    
    l_year   = Request["p_1"].ToString();
   string SQL
	= "select  " + 
        "decode(hr.c1,'WW','Total',hr.c1) " +
		",hr.org_level1_id " +
        ",level3.sub " +
        ",decode(hr.c2,'WW','Sub Total',hr.c2)  " +
		",hr.org_level2_id " +
        ",level2.sub " +
        ",hr.c3 " +
		",hr.dept_id " +
        ",level1.sub " +
        ",decode(hr.c4,'99','S.T',(select code_nm from vhr_hr_code where id='HR0017' and code=c4)) as emp_type " +
        ",c5 " +
        ",c6 " +
        ",c7 " +
        ",c8 " +
        ",c9 " +
        ",c10 " +
        ",c11 " +
        ",c12 " +
        ",c13 " +
        ",c14 " +
        ",c15 " +
        ",c16 " +
        ",c17 " +
        "from  " +
        "(select case when  grouping_id(A.ORG_LEVEL1_PK)=1 then 'WW' else  max(A.ORG_LEVEL1_nm) end as c1 " +
        ",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 or grouping_id(A.ORG_LEVEL1_PK)=1  then 'WW' else  max(A.ORG_LEVEL2_nm) end as c2 " +
        ",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 or grouping_id(A.ORG_LEVEL1_PK)=1  then 'WW' else max(A.DEPT_nm) end  as c3 " +
        ",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 then '99' else A.EMPLOYEE_TYPE end as c4 " +
		",max(a.org_level1_id) as org_level1_id" +
		",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 or grouping_id(A.ORG_LEVEL1_PK)=1  then 'WW' else max(a.org_level2_id) end as org_level2_id" +
		",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 or grouping_id(A.ORG_LEVEL1_PK)=1  then 'WW' else max(a.dept_id) end as dept_id " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'01',round(a.gross_amt,10),0)) c5 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'02',round(a.gross_amt,10),0)) c6 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'03',round(a.gross_amt,10),0)) c7 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'04',round(a.gross_amt,10),0)) c8 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'05',round(a.gross_amt,10),0)) c9 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'06',round(a.gross_amt,10),0)) c10 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'07',round(a.gross_amt,10),0)) c11 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'08',round(a.gross_amt,10),0)) c12 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'09',round(a.gross_amt,10),0)) c13 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'10',round(a.gross_amt,10),0)) c14 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'11',round(a.gross_amt,10),0)) c15 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'12',round(a.gross_amt,10),0)) c16 " +
        ",sum(decode(substr(a.work_mon,1,4),'" + l_year + "',round(a.gross_amt,10),0)) c17 " +
        " from thr_month_salary a " +
        "where del_if=0 and work_mon like '" + l_year + "%'  and nvl(a.net_amt,0)>=0 and A.ORG_LEVEL1_PK is not null " +
        "group by rollup (A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK,A.EMPLOYEE_TYPE) " +
        "having grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK)<>1 and grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK,A.EMPLOYEE_TYPE)<>1 " +
        "union all " +
        "select  max(A.ORG_LEVEL1_nm) as c1 " +
        ",'WW' as c2 " +
        ",'WW' as c3 " +
        ",A.EMPLOYEE_TYPE as c4 " +
		",max(a.org_level1_id) as org_level1_id" +
		",'WW' as org_level2_id" +
		",'WW' as dept_id " +",sum(decode(a.work_mon,'" + l_year + "' ||'01',round(a.gross_amt,10),0)) c5 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'02',round(a.gross_amt,10),0)) c6 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'03',round(a.gross_amt,10),0)) c7 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'04',round(a.gross_amt,10),0)) c8 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'05',round(a.gross_amt,10),0)) c9 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'06',round(a.gross_amt,10),0)) c10 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'07',round(a.gross_amt,10),0)) c11 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'08',round(a.gross_amt,10),0)) c12 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'09',round(a.gross_amt,10),0)) c13 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'10',round(a.gross_amt,10),0)) c14 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'11',round(a.gross_amt,10),0)) c15 " +
        ",sum(decode(a.work_mon,'" + l_year + "' ||'12',round(a.gross_amt,10),0)) c16 " +
		",sum(decode(substr(a.work_mon,1,4),'" + l_year + "',round(a.gross_amt,10),0)) c17 " +
        " from thr_month_salary a " +
        "where del_if=0 and work_mon like '" + l_year + "%'  and nvl(a.net_amt,0)>=0 and a.org_level1_pk is not null " +
        "group by (A.ORG_LEVEL1_PK,A.EMPLOYEE_TYPE))HR " +
        ",(select c1,c2,c3,count(*) as sub " +
        "from ( " +
        "select   case when  grouping_id(A.ORG_LEVEL1_PK)=1 then 'WW' else  max(A.ORG_LEVEL1_nm) end as c1 " +
        ",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 or grouping_id(A.ORG_LEVEL1_PK)=1  then 'WW' else  max(A.ORG_LEVEL2_nm) end as c2 " +
        ",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 or grouping_id(A.ORG_LEVEL1_PK)=1  then 'WW' else max(A.DEPT_nm) end  as c3 " +
        ",1 " +
        " from thr_month_salary a " +
        "where del_if=0 and work_mon like '" + l_year + "%'  and nvl(a.net_amt,0)>=0 and A.ORG_LEVEL1_PK is not null " +
        "group by rollup (A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK,A.EMPLOYEE_TYPE) " +
        "having grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK)<>1 and grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK,A.EMPLOYEE_TYPE)<>1 " +
        "union all " +
        "select  max(A.ORG_LEVEL1_nm) as c1 " +
        ",'WW' as c2 " +
        ",'WW' as c3 " +
        ",1 " +
        " from thr_month_salary a " +
        "where del_if=0 and work_mon like '" + l_year + "%'  and nvl(a.net_amt,0)>=0 and a.org_level1_pk is not null " +
        "group by (A.ORG_LEVEL1_PK,A.EMPLOYEE_TYPE)) L1 " +
        "group by l1.c1,l1.c2,l1.c3 " +
        "order by l1.c1,l1.c2,l1.c3 " +
        ") level1 " +
        ",(select c1,c2,count(*) as sub " +
        "from ( " +
        "select  case when  grouping_id(A.ORG_LEVEL1_PK)=1 then 'WW' else  max(A.ORG_LEVEL1_nm) end as c1 " +
        ",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 or grouping_id(A.ORG_LEVEL1_PK)=1  then 'WW' else  max(A.ORG_LEVEL2_nm) end as c2 " +
        ",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 or grouping_id(A.ORG_LEVEL1_PK)=1  then 'WW' else max(A.DEPT_nm) end  as c3 " +
        ",1 " +
        " from thr_month_salary a " +
        "where del_if=0 and work_mon like '" + l_year + "%'  and nvl(a.net_amt,0)>=0 and A.ORG_LEVEL1_PK is not null " +
        "group by rollup (A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK,A.EMPLOYEE_TYPE) " +
        "having grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK)<>1 and grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK,A.EMPLOYEE_TYPE)<>1 " +
        "union all " +
        "select  max(A.ORG_LEVEL1_nm) as c1 " +
        ",'WW' as c2 " +
        ",'WW' as c3 " +
        ",1 " +
        " from thr_month_salary a " +
        "where del_if=0 and work_mon like '" + l_year + "%'   and nvl(a.net_amt,0)>=0 and a.org_level1_pk is not null " +
        "group by (A.ORG_LEVEL1_PK,A.EMPLOYEE_TYPE)) L1 " +
        "group by l1.c1,l1.c2 " +
        "order by l1.c1,l1.c2) level2 " +
        ",(select c1,count(*) as sub " +
        "from ( " +
        "select case when  grouping_id(A.ORG_LEVEL1_PK)=1 then 'WW' else  max(A.ORG_LEVEL1_nm) end as c1 " +
        ",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 or grouping_id(A.ORG_LEVEL1_PK)=1  then 'WW' else  max(A.ORG_LEVEL2_nm) end as c2 " +
        ",case when  grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK)=1 or grouping_id(A.ORG_LEVEL1_PK)=1  then 'WW' else max(A.DEPT_nm) end  as c3 " +
        ",1 " +
        " from thr_month_salary a " +
        "where del_if=0 and work_mon like '" + l_year + "%'  and nvl(a.net_amt,0)>=0 and A.ORG_LEVEL1_PK is not null " +
        "group by rollup (A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK,A.EMPLOYEE_TYPE) " +
        "having grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK)<>1 and grouping_id(A.ORG_LEVEL1_PK,A.ORG_LEVEL2_PK,A.TCO_DEPT_PK,A.EMPLOYEE_TYPE)<>1 " +
        "union all " +
        "select  max(A.ORG_LEVEL1_nm) as c1 " +
        ",'WW' as c2 " +
        ",'WW' as c3 " +
        ",1 " +
        " from thr_month_salary a " +
        "where del_if=0 and work_mon like '" + l_year + "%'  and nvl(a.net_amt,0)>=0 and a.org_level1_pk is not null " +
        "group by (A.ORG_LEVEL1_PK,A.EMPLOYEE_TYPE)) L1 " +
        "group by l1.c1 " +
        "order by l1.c1) level3 " +
        "where hr.c1=level3.c1 " +
        "and hr.c1=level2.c1 " +
        "and hr.c2=level2.c2 " +
        "and hr.c1=level1.c1 " +
        "and hr.c2=level1.c2 " +
        "and hr.c3=level1.c3 " +
        "order by hr.org_level1_id,hr.org_level2_id,hr.dept_id,hr.c4 " ;
  //       Response.Write(SQL);
//  Response.End();

    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary 1");
        Response.End();
    }
   
  
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_1_1_emp_total_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_1_1_emp_total_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_1_1_emp_total_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>truong</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:Created>" + l_year + "-08-16T06:59:35Z</o:Created>
  <o:LastSaved>" + l_year + "-08-16T08:01:12Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.24in .17in .24in .25in;
	mso-header-margin:.17in;
	mso-footer-margin:.16in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
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
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl66
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:bottom;
	background:white;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style43;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";}
.xl69
	{mso-style-parent:style43;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;}
.xl70
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl71
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style43;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl82
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style43;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style0;
	font-size:18.0pt;
	text-align:center;}
.xl85
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl86
	{mso-style-parent:style43;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl87
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style43;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl93
	{mso-style-parent:style43;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl94
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl95
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl96
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl97
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style43;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style43;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style43;
	font-size:18.0pt;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;}
.xl103
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl106
	{mso-style-parent:style0;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl107
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl108
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl109
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl110
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl111
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl113
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl116
	{mso-style-parent:style0;
	font-size:18.0pt;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl118
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>1-1 Salary Employee ( Total )</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>450</x:DefaultRowHeight>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>59</x:Zoom>
     <x:Selected/>
	 <x:DoNotDisplayZeros/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
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
       <x:ActiveRow>5</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='1-1 Salary Employee ( Total )'!$A$1:$S$13</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='1-1 Salary Employee ( Total )'!$3:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl84>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2127 style='border-collapse:
 collapse;table-layout:fixed;width:1598pt'>
 <col class=xl84 width=151 style='mso-width-source:userset;mso-width-alt:4832;
 width:113pt'>
 <col class=xl84 width=147 style='mso-width-source:userset;mso-width-alt:4704;
 width:110pt'>
 <col class=xl84 width=159 style='mso-width-source:userset;mso-width-alt:5088;
 width:119pt'>
 <col class=xl84 width=85 span=1 style='mso-width-source:userset;mso-width-alt:
 2720;width:64pt'>
 <col class=xl102 width=85 span=12 style='mso-width-source:userset;mso-width-alt:
 4420;width:64pt'>
 <col class=xl84 width=93 style='mso-width-source:userset;mso-width-alt:2976;
 width:70pt'>
 <col class=xl84 width=101 style='mso-width-source:userset;mso-width-alt:3232;
 width:76pt'>
 <col class=xl84 width=83 style='mso-width-source:userset;mso-width-alt:2656;
 width:62pt'>
 <col class=xl84 width=72 span=4 style='width:54pt'>
 <tr class=xl70 height=31 style='height:23.25pt'>
  <td height=31 class=xl66 width=151 style='height:23.25pt;width:113pt'><a
  name="Print_Area">&nbsp;</a></td>
  <td class=xl67 width=147 style='width:110pt'></td>
  <td class=xl67 width=159 style='width:119pt'></td>
  <td class=xl67 width=85 style='width:64pt'></td>
  <td class=xl67 width=85 style='width:64pt'></td>
  <td class=xl67 width=85 style='width:64pt'></td>
  <td class=xl68 width=85 style='width:64pt'></td>
  <td class=xl68 width=85 style='width:64pt'></td>
  <td class=xl68 width=85 style='width:64pt'></td>
  <td class=xl68 width=85 style='width:64pt'></td>
  <td class=xl68 width=85 style='width:64pt'></td>
  <td class=xl69 width=85 style='width:64pt'></td>
  <td class=xl69 width=85 style='width:64pt'></td>
  <td class=xl69 width=85 style='width:64pt'></td>
  <td class=xl69 width=85 style='width:64pt'></td>
  <td class=xl69 width=85 style='width:64pt'></td>
  <td class=xl70 width=93 style='width:70pt'></td>
  <td class=xl70 width=101 style='width:76pt'></td>
  <td class=xl70 width=83 style='width:62pt'></td>
  <td class=xl70 width=72 style='width:54pt'></td>
  <td class=xl70 width=72 style='width:54pt'></td>
  <td class=xl70 width=72 style='width:54pt'></td>
  <td class=xl70 width=72 style='width:54pt'></td>
 </tr>
 <tr class=xl70 height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 colspan=6 class=xl70 style='height:9.75pt;mso-ignore:colspan'></td>
  <td colspan=10 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl78 height=49 style='mso-height-source:userset;height:36.75pt'>
  <td rowspan=2 height=92 class=xl71 style='height:69.0pt'>Plant</td>
  <td rowspan=2 class=xl72>Team</td>
  <td rowspan=2 class=xl73 style='border-right:.5pt solid black'>Section</td>
  <td class=xl74>Duty</td>
  <td class=xl75 x:str><%=l_year %></td>
  <td class=xl76>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl103 align=center>Compare with last month</td>
  <td class=xl105>&nbsp;</td>
  <td class=xl104>&nbsp;</td>
  <td colspan=4 class=xl78 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl78 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl81 style='height:32.25pt;border-left:none'>&nbsp;</td>
  <td class=xl82 style='border-top:none;border-left:none'>Jan</td>
  <td class=xl82 style='border-top:none;border-left:none'>Feb</td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Mar"><span
  style='mso-spacerun:yes'> </span>Mar<span style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Apr"><span
  style='mso-spacerun:yes'> </span>Apr<span style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="May"><span
  style='mso-spacerun:yes'> </span>May<span style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Jun"><span
  style='mso-spacerun:yes'> </span>Jun<span style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Jul"><span
  style='mso-spacerun:yes'> </span>Jul<span style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Aug"><span
  style='mso-spacerun:yes'> </span>Aug<span style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Sep"><span
  style='mso-spacerun:yes'> </span>Sep<span style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Oct"><span
  style='mso-spacerun:yes'> </span>Oct<span style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Nov"><span
  style='mso-spacerun:yes'> </span>Nov<span style='mso-spacerun:yes'> </span></td>
  <td class=xl83 style='border-top:none;border-left:none' x:str="Dec"><span
  style='mso-spacerun:yes'> </span>Dec<span style='mso-spacerun:yes'> </span></td>
  <td class=xl82 style='border-top:none;border-left:none'>Total</td>
  <td class=xl106 style='border-top:none;border-left:none'>Incre - Decre</td>
  <td class=xl82 style='border-left:none'>Percent</td>
  <td colspan=4 class=xl78 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
  <%
    Boolean bplan=false,bdept=false,bsection=false;
	int i;
	string scolor,sformat;
	int scolspan;
    for (i=0;i<irow_emp;i++)
    {
		sformat="";
		//sformat="border-bottom:.5pt solid windowtext;";
        if (i==0)
        {
            bplan=bdept=bsection=true;
			
            
        }
		else if (i==irow_emp-1)
		    bplan=bdept=bsection=true;
        else
        {
            if (dt_Emp.Rows[i][1].ToString()!=dt_Emp.Rows[i-1][1].ToString()) //khac plan
                bplan=true;
            if (dt_Emp.Rows[i][4].ToString()!=dt_Emp.Rows[i-1][4].ToString()) //khac dept
                bdept=true;
            if (dt_Emp.Rows[i][7].ToString()!=dt_Emp.Rows[i-1][7].ToString() ) //khac section
			{
                bsection=true;
			}
			

        }
		//------------To net dong
		if (i!=irow_emp-1)
		{
            if (dt_Emp.Rows[i][7].ToString()!=dt_Emp.Rows[i+1][7].ToString() ) //khac section
			{
                sformat="border-bottom:.5pt solid windowtext;";
			}
		}
		else
		        sformat="border-bottom:.5pt solid windowtext;border-top:.5pt solid windowtext;";
		//colspan cac dong total va sub 
		if (dt_Emp.Rows[i][0].ToString()=="Total")
		{
			scolspan=4;
			scolor="background:#FFCC99;mso-pattern:auto none;";
		}
		else if (dt_Emp.Rows[i][3].ToString()=="Sub Total")
		{
			scolspan=2;
			scolor="background:#99CCFF;mso-pattern:auto none;";
		}
		else
		{
			scolspan=1;
			scolor="";
		}
		
 %>
 <tr height=49 style='mso-height-source:userset;height:51.75pt'>
 <%if (bplan==true)
 {%>
  <td height=49 rowspan="<%=dt_Emp.Rows[i][2].ToString() %>" colspan="<%=scolspan%>" class=xl112 width=151 style='height:51.75pt;width:113pt;<%=scolor%>'><%=dt_Emp.Rows[i][0].ToString()%></td>
  <%
        bplan=false;
    } %>
<%if (scolspan!=4) //khong xuat hien neu gap dong Total
{%>
    <%if(bdept==true)
	{
		
	%>
  <td class=xl113 rowspan="<%=dt_Emp.Rows[i][5].ToString() %>" colspan="<%=scolspan%>" width=147 style='border-top:none;border-left:none;width:110pt;<%=scolor%>'
  ><%=dt_Emp.Rows[i][3].ToString() %><span style='mso-spacerun:yes'> </span></td>
  <%
        bdept=false;
    } %>
<%if (scolspan==1)  //khong xuat hien neu gap dong SubTotal va Total
{%>
    <%if(bsection==true)
    { 
		
	%>
  <td class=xl114 width=159 rowspan="<%=dt_Emp.Rows[i][8].ToString() %>" style='border-top:none;border-left:none;width:119pt;<%=scolor%>'><%=dt_Emp.Rows[i][6].ToString() %></td>
  <%
        bsection=false;
    } %>
<%}%>   

  <td class=xl109 style='<%=sformat%>border-top:none;<%=scolor%>'><%=dt_Emp.Rows[i][9].ToString() %></td>
 <%}%>
 <%    for(int j=0;j<=12;j++)
  { %>
 
  <td class=xl109 style='border-top:none;<%=sformat%>border-left:none;<%=scolor%>' x:num><%=dt_Emp.Rows[i][j+10].ToString()%></td>
  <%} %>
  
  <td class=xl107 style='<%=sformat%>border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl107 style='<%=sformat%>border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=4 class=xl84 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl84 style='height:21.0pt'>&nbsp;</td>
  <td colspan=4 class=xl84 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl70 style='height:32.25pt'></td>
  <td colspan=3 class=xl99 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl100 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=10 class=xl101 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl100 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 class=xl84 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 colspan=6 class=xl70 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=10 class=xl69 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl84 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=151 style='width:113pt'></td>
  <td width=147 style='width:110pt'></td>
  <td width=159 style='width:119pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
