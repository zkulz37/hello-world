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
    string p_thr_group_pk,p_nation,p_search_by,p_search_temp,p_from_joindate,p_to_joindate;
    string p_salary_yn,p_position,p_pay_type,p_contract_kind,p_from_contract,p_to_contract;
    string p_sex,p_insurance_yn,p_status,p_from_leftdate,p_to_leftdate,p_from_birthdate;
    string p_ot_yn,p_to_birthdate,p_tco_dept_pk,p_sal_security,p_wplace,p_picture ;
    string p_user;
    string p_job,p_education,p_lstEmpKind,p_lstProject,p_wg;
    
    p_user = Request["p_user"].ToString();
    p_thr_group_pk ="ALL";
    p_nation = Request["p_nation"].ToString();
    p_search_by = Request["p_search_by"].ToString();
    p_search_temp = Request["p_search_temp"].ToString();
    p_from_joindate = Request["p_from_joindate"].ToString();
    p_to_joindate = Request["p_to_joindate"].ToString();
    p_salary_yn = Request["p_salary_yn"].ToString();
    p_position = Request["p_position"].ToString();
    p_pay_type = Request["p_pay_type"].ToString();
    p_contract_kind = Request["p_contract_kind"].ToString();
    p_from_contract = Request["p_from_contract"].ToString();
    p_to_contract = Request["p_to_contract"].ToString();
    p_sex= Request["p_sex"].ToString();
    p_insurance_yn = Request["p_insurance_yn"].ToString();
    p_status = Request["p_status"].ToString();
  //  p_from_leftdate = Request["p_from_leftdate"].ToString();
   // p_to_leftdate = Request["p_to_leftdate"].ToString();
   // p_from_birthdate = Request["p_from_birthdate"].ToString();
    p_ot_yn = "ALL";
   // p_to_birthdate = Request["p_to_birthdate"].ToString();
    p_tco_dept_pk = Request["p_tco_dept_pk"].ToString();
    p_sal_security = Request["p_sal_security"].ToString();
    
    p_job = Request["p_job"].ToString();
    p_education = "ALL";
    p_lstEmpKind = Request["p_emp_kind"].ToString();
    p_lstProject = Request["p_project"].ToString();
    p_wg = "ALL";
    p_wplace =Request["p_wplace"].ToString();
    p_picture=Request["p_picture"].ToString();
    
    
    string SQL;
    SQL = " select to_char(sysdate,'dd/mm/yyyy') ";
    SQL = SQL + ",(SELECT   MAX(T.org_NM) ";
    SQL = SQL + " FROM comm.tco_org t      ";
    SQL = SQL + "   WHERE t.del_if = 0      ";
    SQL = SQL + "   AND T.org_TYPE IN('06') ";
    SQL = SQL + "  START WITH t.pk=a.tco_org_pk ";
    SQL = SQL + "  CONNECT BY PRIOR t.p_pk=t.pk) AS org_NM ";
    SQL = SQL + "  ,c.org_nm as team ";
    SQL = SQL + ",a.emp_id,a.full_name,a.ID_NUM  ";
    SQL = SQL + ", decode(length(birth_dt),4,birth_dt,to_char(to_date(BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy')) ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0021' and code=a.PLACE_BIRTH) ";
    SQL = SQL + ",to_char(to_date(join_dt,'yyyymmdd'),'dd/mm/yyyy')";
    SQL = SQL + ",nvl(a.BASIC_SAL,0)+nvl(a.ALLOW_AMT1,0)+nvl(a.ALLOW_AMT2,0)+nvl(a.ALLOW_AMT3,0)+nvl(a.ALLOW_AMT4,0)+nvl(a.ALLOW_AMT5,0)+nvl(a.ALLOW_AMT6,0)  ";
    SQL = SQL + ",a.salary_l2_k1  ";
    SQL = SQL + ",a.ALLOW_AMT1,a.ALLOW_AMT2,a.ALLOW_AMT3,a.ALLOW_AMT4,a.ALLOW_AMT5,a.ALLOW_AMT6,a.ALLOW_AMT7,a.ALLOW_AMT8  ";
    SQL = SQL + ",a.TEL,a.PERMANENT_ADDR,a.PRESENT_ADDR ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0007' and code=a.SEX) ";
    SQL = SQL + ",a.PERSON_ID ";
    SQL = SQL + ",to_char(to_date(a.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0014' and code=a.PLACE_PER_ID) ";
    SQL = SQL + ",decode(MARRIED_YN,'Y','Married','Single') ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0009' and code=a.Nation)  ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0015' and code=a.ETHNIC_TYPE ) ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0016' and code=a.RELIG_TYPE ) ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0011' and code=a.EDU_TYPE ) ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0010' and code=a.JOB_TYPE)  ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0008' and code=a.POS_TYPE)  ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0002' and code=a.PROB_TYPE ) ";
    SQL = SQL + ",to_char(to_date(a.BEGIN_PROBATION ,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + ",to_char(to_date(a.END_PROBATION ,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0002' and code=a.CONTRACT_TYPE  ) ";
    SQL = SQL + ",to_char(to_date(a.BEGIN_Contract ,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + ",to_char(to_date(a.END_contract ,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + ",decode(a.SOCIAL_YN,'Y','Yes','No') ";
    SQL = SQL + ",to_char(to_date(a.SOCIAL_DT,'yyyymm'),'mm/yyyy') ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0013' and code=a.SOCIAL_PLACE ) ";
    SQL = SQL + ",decode(a.Health_YN,'Y','Yes','No') ";
    SQL = SQL + ",to_char(to_date(a.health_DT,'yyyymm'),'mm/yyyy') ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0012' and code=a.health_PLACE ) ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0017' and code=a.EMPLOYEE_TYPE ) ";
    SQL = SQL + ",(select code_nm from vhr_hr_code where id='HR0022' and code=a.status ) ";
    SQL = SQL + ",to_char(to_date(a.left_dt ,'yyyymmdd'),'dd/mm/yyyy'),a.account,a.pit_tax_no ";
    SQL = SQL + ",(SELECT K.KIND_NAME FROM THR_EMPLOYEE_KIND   K WHERE  K.PK=nvl(A.EMPLOYEE_KIND_pk,0) and K.del_if=0 ) ";
    SQL = SQL + ",(select H.PL_CD from acnt.tac_abpl H  where H.del_if=0 and H.pk=nvl(a.Project_pk,0) ) ";
    SQL = SQL + ",a.salary_l2_k2,a.salary_l2_k3 ";
    SQL = SQL + ",a.email,a.office_number,d.workgroup_nm ";
    SQL = SQL + "from thr_employee a, comm.tco_org c,thr_work_group d ";
    SQL = SQL + "where a.del_if=0   and c.del_if=0 and d.del_if=0";
    SQL = SQL + "and a.tco_org_pk=c.pk and a.thr_wg_pk=d.pk ";
    SQL = SQL + "and decode('" + p_nation + "','ALL','ALL',a.NATION )='" + p_nation  + "'";
    SQL = SQL + "and (('" + p_search_by + "'='1' and upper(a.FULL_NAME) like  '%' || upper('" + p_search_temp + "') || '%') ";
    SQL = SQL + "         or ('" + p_search_by + "'='2' and upper(a.emp_id) like  '%' || upper('" + p_search_temp + "') || '%') ";
    SQL = SQL + "         or ('" + p_search_by + "'='3' and upper(a.id_num) like  '%' || upper('" + p_search_temp + "') || '%') ";
    SQL = SQL + "         or ('" + p_search_by + "'='4' and upper(a.PERSON_ID ) like  '%' || upper('" + p_search_temp + "') || '%') ";
    SQL = SQL + "         or ('" + p_search_by + "'='5' and upper(a.OLD_ID ) like  '%' || upper('" + p_search_temp + "') || '%')) ";
    SQL = SQL + "and decode('" + p_salary_yn + "','ALL','ALL',a.SALARY_YN )='" + p_salary_yn  + "'";
    SQL = SQL + "and decode('" + p_position + "','ALL','ALL',a.POS_TYPE )='" + p_position        + "'";
    SQL = SQL + "and decode('" + p_pay_type + "','ALL','ALL',a.PAY_TYPE )='" + p_pay_type  + "'";
    SQL = SQL + "and decode('" + p_contract_kind + "','ALL','ALL',a.CONTRACT_TYPE )='" + p_contract_kind  + "'";
    SQL = SQL + "and (('" + p_from_contract  + "' is null and '" + p_to_contract + "' is null)  ";
    SQL = SQL + "    or (a.BEGIN_CONTRACT between '" + p_from_contract + "' and '" + p_to_contract + "') ) ";
    SQL = SQL + "and decode('" + p_sex + "','ALL','ALL',a.SEX )='" + p_sex + "' ";
    SQL = SQL + "and decode('" + p_insurance_yn + "','ALL','ALL',a.SOCIAL_YN )='" + p_insurance_yn  + "'";
    SQL = SQL + "and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status  + "'";
    SQL = SQL + "and decode('" + p_ot_yn + "','ALL','ALL',a.ot_yn)='" + p_ot_yn  + "'";
    SQL = SQL + "and decode('" + p_wg + "','ALL','ALL',d.pk)='" + p_wg  + "'";
    SQL = SQL + "and decode('" + p_wplace + "','ALL','ALL',a.working_place)='" + p_wplace  + "'";
    SQL = SQL + "and decode('" + p_picture + "','ALL','ALL',case when a.photo_pk is null then 2 else 1 end )='" + p_picture  + "'";
    SQL = SQL + "AND (   a.tco_org_pk IN ( ";
    SQL = SQL + "                         SELECT     g.pk ";
    SQL = SQL + "                               FROM comm.tco_org g ";
    SQL = SQL + "                              WHERE g.del_if = 0 ";
//    SQL = SQL + "                                AND NVL (g.child_yn, 'Y') = 'N' ";
    SQL = SQL + "                         START WITH g.pk = ";
    SQL = SQL + "                                       DECODE ('" + p_tco_dept_pk + "', ";
    SQL = SQL + "                                               'ALL', 0, ";
    SQL = SQL + "                                               '" + p_tco_dept_pk  + "'";
    SQL = SQL + "                                              ) ";
    SQL = SQL + "                         CONNECT BY PRIOR g.pk = g.p_pk) ";
    SQL = SQL + "                   OR '" + p_tco_dept_pk + "' = 'ALL') ";
    SQL = SQL + "and decode('" + p_job + "','ALL','ALL',A.JOB_TYPE)='" + p_job + "'";
    SQL = SQL + "and decode('" + p_education + "','ALL','ALL',A.EDU_TYPE)='" + p_education + "'";
   SQL = SQL + "and decode('" + p_lstProject + "','ALL','ALL',A.Project_pk)='" + p_lstProject + "'";
   SQL=SQL+ " AND   (  A.EMPLOYEE_KIND_PK IN (SELECT G.PK FROM THR_EMPLOYEE_KIND G WHERE G.DEL_IF = 0";
   SQL = SQL + "  START WITH G.PK = DECODE ('" + p_lstEmpKind + "','ALL', 0,'" + p_lstEmpKind + "') CONNECT BY PRIOR G.PK = G.P_PK) OR '" + p_lstEmpKind + "'= 'ALL')";
   SQL = SQL + " order by nvl(c.seq,0), org_nm,team,emp_id ";
	
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
    
    string SQL_Allow
	= "   SELECT MAX (code1), MAX (code2), MAX (code3), MAX (code4), MAX (code5), " + 
        "             MAX (code6), MAX (code7), MAX (code8), MAX (c1), MAX (c2), " +
        "             MAX (c3), MAX (c4), MAX (c5), MAX (c6), MAX (c7), MAX (c8), " +
        "           MAX (codef1), MAX (codef2), MAX (codef3), MAX (codef4), MAX (codef5), " + 
        "             MAX (codef6), MAX (codef7), MAX (codef8) " +
        "        FROM (SELECT DECODE (code, 'A1', a.code_nm, '') AS code1, " +
        "                     DECODE (code, 'A2', a.code_nm, '') AS code2, " +
        "                     DECODE (code, 'A3', a.code_nm, '') AS code3, " +
        "                     DECODE (code, 'A4', a.code_nm, '') AS code4, " +
        "                     DECODE (code, 'A5', a.code_nm, '') AS code5, " +
        "                     DECODE (code, 'A6', a.code_nm, '') AS code6, " +
        "                     DECODE (code, 'A7', a.code_nm, '') AS code7, " +
        "                     DECODE (code, 'A8', a.code_nm, '') AS code8, " +
        "                     DECODE (code, 'A1', a.num_2, '') AS c1, " +
        "                     DECODE (code, 'A2', a.num_2, '') AS c2, " +
        "                     DECODE (code, 'A3', a.num_2, '') AS c3, " +
        "                     DECODE (code, 'A4', a.num_2, '') AS c4, " +
        "                     DECODE (code, 'A5', a.num_2, '') AS c5, " +
        "                     DECODE (code, 'A6', a.num_2, '') AS c6, " +
        "                     DECODE (code, 'A7', a.num_2, '') AS c7, " +
        "                     DECODE (code, 'A8', a.num_2, '') AS c8, " +
        "                     DECODE (code, 'A1', a.code_fnm, '') AS codef1, " +
        "                     DECODE (code, 'A2', a.code_fnm, '') AS codef2, " +
        "                     DECODE (code, 'A3', a.code_fnm, '') AS codef3, " +
        "                     DECODE (code, 'A4', a.code_fnm, '') AS codef4, " +
        "                     DECODE (code, 'A5', a.code_fnm, '') AS codef5, " +
        "                     DECODE (code, 'A6', a.code_fnm, '') AS codef6, " +
        "                     DECODE (code, 'A7', a.code_fnm, '') AS codef7, " +
        "                     DECODE (code, 'A8', a.code_fnm, '') AS codef8 " +
        "                FROM vhr_hr_code a " +
        "               WHERE a.ID = 'HR0019'  ) allow_amt " ;
       
     
    DataTable dt_Allow = ESysLib.TableReadOpen(SQL_Allow);
    int irow_Allow;
    irow_Allow = dt_Allow.Rows.Count;
    if (irow_Allow == 0)
    {
        Response.Write("There is no data of allowance");
        Response.End();
    }
   
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_employee_detail_list_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_detail_list_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_detail_list_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-05-23T08:14:08Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2008-07-09T03:50:59Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.41in .11in .26in .15in;
	mso-header-margin:.24in;
	mso-footer-margin:.14in;
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
.xl24
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
      <x:PaperSizeIndex>5</x:PaperSizeIndex>
      <x:Scale>24</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
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
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=5218 style='border-collapse:
 collapse;table-layout:fixed;width:3916pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=191 style='mso-width-source:userset;mso-width-alt:3985;
 width:143pt'>
 <col class=xl24 width=90 span=3 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <col class=xl24 width=106 span=4 style='mso-width-source:userset;mso-width-alt:
 3876;width:80pt'>
 <col class=xl24 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>
 <col class=xl24 width=106 span=3 style='mso-width-source:userset;mso-width-alt:
 3876;width:80pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=156 span=2 style='mso-width-source:userset;mso-width-alt:
 5705;width:117pt'>
 <col class=xl24 width=95 span=4 style='mso-width-source:userset;mso-width-alt:
 3474;width:71pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl24 width=75 span=3 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl24 width=95 span=3 style='mso-width-source:userset;mso-width-alt:
 3474;width:71pt'>
 <col class=xl24 width=116 span=7 style='mso-width-source:userset;mso-width-alt:
 4242;width:87pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <col class=xl24 width=116 style='mso-width-source:userset;mso-width-alt:4242;
 width:87pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=119 span=2 style='mso-width-source:userset;mso-width-alt:
 4352;width:89pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:10205;
 width:86pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl24 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=49 height=38 class=xl48 width=5218 style='height:28.5pt;
  width:3916pt'>LIST OF EMPLOYEES</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl39>Reporter</td>
  <td class=xl26 style='border-left:none'><%=p_user %></td>
  <td colspan=45 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl40 style='border-top:none'>Report Date</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num><%=dt_total.Rows[0][0].ToString()%></td>
  <td colspan=45 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl40>&nbsp;</td>
  <td class=xl27 style='border-left:none'>&nbsp;</td>
  <td colspan=45 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl36 style='height:19.5pt'>No</td>
  <td class=xl36 style='border-left:none'>Department</td>
  <td class=xl36 style='border-left:none'>Team/Section</td>
  <td class=xl36 style='border-left:none'>Job </td>
  <td class=xl36 style='border-left:none'>Position </td>
  <td class=xl36 style='border-left:none'>Emp ID</td>
  <td class=xl36 style='border-left:none'>Full Name</td>
  <td class=xl36 style='border-left:none'>ID Num</td>
  <td class=xl36 style='border-left:none'>Birth Date</td>
  <td class=xl36 style='border-left:none'>Birth Place</td>
  <td class=xl36 style='border-left:none'>Join Date</td>
  <td class=xl36 style='border-left:none'>Employee Kind</td>
  <td class=xl36 style='border-left:none'>Project</td>
  
  <%if (p_sal_security=="Y")
 { %>
  <td class=xl36 style='border-left:none'>Gross Salary</td>
  <td class=xl36 style='border-left:none'>Basic Salary</td>
  <td class=xl36 style='border-left:none'>Addition Salary</td>
  <td class=xl36 style='border-left:none'>Basic Salary(Crane Operator)</td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][8].ToString()=="1" && p_sal_security=="Y" ) //xet xem allowance type co hay khong?
    {
%>
  <td class=xl36 style='border-left:none'><% =dt_Allow.Rows[0][0].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][9].ToString()=="1" && p_sal_security=="Y" ) //xet xem allowance type co hay khong?
    {
%>
  <td class=xl36 style='border-left:none'><% =dt_Allow.Rows[0][1].ToString()%></td>
  <%} %>  
  <%
    if (dt_Allow.Rows[0][10].ToString()=="1" && p_sal_security=="Y" ) //xet xem allowance type co hay khong?
    {
%>
  <td class=xl36 style='border-left:none'><% =dt_Allow.Rows[0][2].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][11].ToString()=="1" && p_sal_security=="Y" ) //xet xem allowance type co hay khong?
    {
%>
  <td class=xl36 style='border-left:none'><% =dt_Allow.Rows[0][3].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][12].ToString()=="1" && p_sal_security=="Y" ) //xet xem allowance type co hay khong?
    {
%>
  <td class=xl36 style='border-left:none'><% =dt_Allow.Rows[0][4].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][13].ToString()=="1" && p_sal_security=="Y" ) //xet xem allowance type co hay khong?
    {
%>
  <td class=xl36 style='border-left:none'><% =dt_Allow.Rows[0][5].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][14].ToString()=="1" && p_sal_security=="Y" ) //xet xem allowance type co hay khong?
    {
%>
  <td class=xl36 style='border-left:none'><% =dt_Allow.Rows[0][6].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][15].ToString()=="1" && p_sal_security=="Y" ) //xet xem allowance type co hay khong?
    {
%>
  <td class=xl36 style='border-left:none'><% =dt_Allow.Rows[0][7].ToString()%></td>
  <%} %>
  <td class=xl36 style='border-left:none'>Telephone</td>
  <td class=xl36 style='border-left:none'>Permanent Address</td>
  <td class=xl36 style='border-left:none'>Present Address</td>
  <td class=xl36 style='border-left:none'>Sex</td>
  <td class=xl36 style='border-left:none'>Person ID</td>
  <td class=xl36 style='border-left:none'>Issued Date</td>
  <td class=xl36 style='border-left:none'>Person Place</td>
  <td class=xl36 style='border-left:none'>Married Status</td>
  <td class=xl36 style='border-left:none'>Nation</td>
  <td class=xl36 style='border-left:none'>Ethenic</td>
  <td class=xl36 style='border-left:none'>Religion</td>
  <td class=xl36 style='border-left:none'>Education</td>
  <td class=xl36 style='border-left:none'>Probation Type</td>
  <td class=xl36 style='border-left:none'>Begin Probation</td>
  <td class=xl36 style='border-left:none'>End Probation</td>
  <td class=xl36 style='border-left:none'>Contract Type</td>
  <td class=xl36 style='border-left:none'>Contract No</td>
  <td class=xl36 style='border-left:none'>End Contract</td>
  <td class=xl36 style='border-left:none'>Social Flag</td>
  <td class=xl36 style='border-left:none'>Social Place</td>
  <td class=xl36 style='border-left:none'>Social Date</td>
  <td class=xl36 style='border-left:none'>Health Flag</td>
  <td class=xl36 style='border-left:none'>Health Place</td>
  <td class=xl36 style='border-left:none'>Health Date</td>
  <td class=xl36 style='border-left:none'>Employee Type</td>
  <td class=xl36 style='border-left:none'>Status</td>
  <td class=xl36 style='border-left:none'>Left Date</td>
  <td class=xl36 style='border-left:none'>Account</td>
  <td class=xl36 style='border-left:none'>PIT No</td>
  <td class=xl36 style='border-left:none'>Email</td>
  <td class=xl36 style='border-left:none'>Office Phone</td>
  <td class=xl36 style='border-left:none'>W-Group</td>
 </tr>
 
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl37 style='height:19.5pt;border-top:none'>STT</td>
  <td class=xl37 style='border-top:none;border-left:none'>B&#7897; ph&#7853;n</td>
  <td class=xl37 style='border-top:none;border-left:none'>Nhóm</td>
  <td class=xl37 style='border-top:none;border-left:none'>Công việc</td>
  <td class=xl37 style='border-top:none;border-left:none'>Chức vụ</td>
  <td class=xl37 style='border-top:none;border-left:none'>Mã NV</td>
  <td class=xl37 style='border-top:none;border-left:none'>H&#7885; và tên</td>
  <td class=xl37 style='border-top:none;border-left:none'>S&#7889; th&#7867;</td>
  <td class=xl37 style='border-top:none;border-left:none'>Ngày sinh</td>
  <td class=xl37 style='border-top:none;border-left:none'>N&#417;i sinh</td>
  <td class=xl37 style='border-top:none;border-left:none'>Ngày vào</td>
  <td class=xl37 style='border-top:none;border-left:none'>Loại nhân viên</td>
  <td class=xl37 style='border-top:none;border-left:none'>Dự án</td>
   <%if (p_sal_security=="Y")
 { %>
  <td class=xl37 style='border-top:none;border-left:none'>Tổng Lương</td>
  <td class=xl37 style='border-top:none;border-left:none'>Lương Cơ bản</td>
  <td class=xl37 style='border-top:none;border-left:none'>Lương CB trả thêm</td>
  <td class=xl37 style='border-top:none;border-left:none'>Lương CB(NV vận hành cẩu)</td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][8].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl37 style='border-top:none;border-left:none'><% =dt_Allow.Rows[0][16].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][9].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl37 style='border-top:none;border-left:none'><% =dt_Allow.Rows[0][17].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][10].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl37 style='border-top:none;border-left:none'><% =dt_Allow.Rows[0][18].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][11].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl37 style='border-top:none;border-left:none'><% =dt_Allow.Rows[0][19].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][12].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl37 style='border-top:none;border-left:none'><% =dt_Allow.Rows[0][20].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][13].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl37 style='border-top:none;border-left:none'><% =dt_Allow.Rows[0][21].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][14].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl37 style='border-top:none;border-left:none'><% =dt_Allow.Rows[0][22].ToString()%></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][15].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl37 style='border-top:none;border-left:none'><% =dt_Allow.Rows[0][23].ToString()%></td>
  <%} %>
  <td class=xl37 style='border-top:none;border-left:none'>&#272;i&#7879;n
  tho&#7841;i</td>
  <td class=xl37 style='border-top:none;border-left:none'>&#272;&#7883;a
  ch&#7881; th&#432;&#7901;ng trú</td>
  <td class=xl37 style='border-top:none;border-left:none'>&#272;&#7883;a
  ch&#7881; t&#7841;m trú</td>
  <td class=xl37 style='border-top:none;border-left:none'>Gi&#7899;i tính</td>
  <td class=xl37 style='border-top:none;border-left:none'>CMND</td>
  <td class=xl37 style='border-top:none;border-left:none'>Ngày c&#7845;p</td>
  <td class=xl37 style='border-top:none;border-left:none'>N&#417;i c&#7845;p</td>
  <td class=xl38 style='border-top:none;border-left:none'>Trình tr&#7841;ng hôn
  nhân</td>
  <td class=xl38 style='border-top:none;border-left:none'>Qu&#7889;c t&#7883;ch</td>
  <td class=xl38 style='border-top:none;border-left:none'>Tôn giáo</td>
  <td class=xl38 style='border-top:none;border-left:none'>Dân t&#7897;c</td>
  <td class=xl38 style='border-top:none;border-left:none'>H&#7885;c v&#7845;n</td>
  <td class=xl38 style='border-top:none;border-left:none'>Lo&#7841;i th&#7917;
  vi&#7879;c</td>
  <td class=xl38 style='border-top:none;border-left:none'>Ngày b&#7855;t
  &#273;&#7847;u TV</td>
  <td class=xl38 style='border-top:none;border-left:none'>Ngày k&#7871;t thúc
  TV</td>
  <td class=xl38 style='border-top:none;border-left:none'>Lo&#7841;i h&#7907;p
  &#273;&#7891;ng</td>
  <td class=xl38 style='border-top:none;border-left:none'>S&#7889; h&#7907;p
  &#273;&#7891;ng</td>
  <td class=xl38 style='border-top:none;border-left:none'>Ngày k&#7871;t thúc
  TV</td>
  <td class=xl38 style='border-top:none;border-left:none'>Tham gia BHXH</td>
  <td class=xl38 style='border-top:none;border-left:none'>N&#417;i tham gia
  BHXH</td>
  <td class=xl38 style='border-top:none;border-left:none'>Ngày tham gia BHXH</td>
  <td class=xl38 style='border-top:none;border-left:none'>Tham gia BHYT</td>
  <td class=xl38 style='border-top:none;border-left:none'>N&#417;i tham gia
  BHYT</td>
  <td class=xl38 style='border-top:none;border-left:none'>Ngày tham gia BHYT</td>
  <td class=xl38 style='border-top:none;border-left:none'>Lo&#7841;i nhân viên</td>
  <td class=xl38 style='border-top:none;border-left:none'>Trình tr&#7841;ng</td>
  <td class=xl38 style='border-top:none;border-left:none'>Ngày ngh&#7881;
  vi&#7879;c</td>
  <td class=xl38 style='border-top:none;border-left:none'>Số TK</td>
  <td class=xl38 style='border-top:none;border-left:none'>Mã số Thuế</td>
  <td class=xl38 style='border-top:none;border-left:none'>Email</td>
  <td class=xl38 style='border-top:none;border-left:none'>Điện thoại</td>
  <td class=xl38 style='border-top:none;border-left:none'>Nhóm</td>
 </tr>
 <% 
    string s_format;
    for (int i = 0; i < irow; i++) 
    {
        if (i==irow-1) 
            s_format=";border-bottom:.5pt solid windowtext";
        else
            s_format=";";
    %> 
 <tr class=xl28 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl29 style='height:19.5pt;border-top:none<%=s_format%>' x:num><%=i+1 %></td>
  <td class=xl30 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][1].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][2].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][31].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][32].ToString() %></td>
  <td class=xl29 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][3].ToString() %></td>
  <td class=xl30 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][4].ToString() %></td>
  <td class=xl29 style='border-top:none;border-left:none<%=s_format%>' x:num><%= dt_total.Rows[i][5].ToString() %></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' ><%= dt_total.Rows[i][6].ToString() %></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:str><%= dt_total.Rows[i][7].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][8].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][50].ToString() %></td>
  <td class=xl41 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][51].ToString() %></td>
  <%if (p_sal_security=="Y")
 { %>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][9].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][10].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][52].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][53].ToString() %></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][8].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span 
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][11].ToString() %></td>
   <%} %>
  <%
    if (dt_Allow.Rows[0][9].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][12].ToString() %></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][10].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][13].ToString() %></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][11].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][14].ToString() %></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][12].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][15].ToString() %> </td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][13].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][16].ToString() %> </td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][14].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>  
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][17].ToString() %></td>
  <%} %>
  <%
    if (dt_Allow.Rows[0][15].ToString()=="1" && p_sal_security=="Y") //xet xem allowance type co hay khong?
    {
%>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][18].ToString() %></td>
  <%} %>
  <td class=xl42 style='border-top:none;border-left:none<%=s_format%>' x:num><%= dt_total.Rows[i][19].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][20].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][21].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][22].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][23].ToString() %></td>
  <td class=xl29 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][24].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][25].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][26].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][27].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][28].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][29].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][30].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][33].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][34].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][35].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][36].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][37].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][38].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][39].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][40].ToString() %> </td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][41].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>'><%= dt_total.Rows[i][42].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][43].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][44].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][45].ToString() %> </td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][46].ToString() %> </td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][47].ToString() %> </td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][48].ToString() %> </td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][49].ToString() %> </td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][54].ToString() %> </td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][55].ToString() %></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_total.Rows[i][56].ToString() %></td>
 </tr>
 <%
    }
  %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=191 style='width:143pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=106 style='width:80pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=156 style='width:117pt'></td>
  <td width=156 style='width:117pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=116 style='width:87pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=119 style='width:89pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=115 style='width:86pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
