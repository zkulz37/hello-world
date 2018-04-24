<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:st1="urn:schemas-microsoft-com:office:smarttags"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_thr_group_pk,p_nation,p_search_by,p_search_temp,p_from_joindate,p_to_joindate;
    string p_salary_yn,p_position,p_pay_type,p_contract_kind,p_from_contract,p_to_contract;
    string p_sex,p_insurance_yn,p_status,p_from_leftdate,p_to_leftdate,p_from_birthdate;
    string p_ot_yn,p_to_birthdate,p_tco_dept_pk,p_sal_security, p_union;
    string p_user;
    string p_job, p_education, p_lstEmpKind, p_lstProject, p_wg, p_birth_month;
    
    p_user = Request["p_user"].ToString();
    p_thr_group_pk = Request["p_thr_group_pk"].ToString();
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
    p_from_leftdate = Request["p_from_leftdate"].ToString();
    p_to_leftdate = Request["p_to_leftdate"].ToString();
    p_from_birthdate = Request["p_from_birthdate"].ToString();
    p_ot_yn = Request["p_ot_yn"].ToString();
    p_to_birthdate = Request["p_to_birthdate"].ToString();
    p_tco_dept_pk = Request["p_tco_dept_pk"].ToString();
    p_sal_security = Request["p_sal_security"].ToString();
    
    p_job = Request["p_23"].ToString();
    p_education = Request["p_24"].ToString();
    p_union = Request["p_25"].ToString();
    p_birth_month = Request["p_birth_month"].ToString();

    string SQL
    = "select a.FULL_NAME,case when length(a.BIRTH_DT)=8  " +
        "then  to_char(to_date(a.BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        "else a.BIRTH_DT end " +
        ",c.org_nm " +
        ",(select v.code_nm from vhr_hr_code v where v.id='HR0008' and v.code=a.POS_TYPE ),to_char (to_date(a.join_dt,'yyyymmdd'),'dd/mm/yyyy' ) ";
    SQL = SQL + "from thr_employee a, comm.tco_org c,thr_work_group d,";
    SQL = SQL + "(SELECT e.pk as pk,D.PL_NM||' - '||B.PLC_NM as pl_nm ";
    SQL = SQL + "                       FROM ACNT.TAC_ABPL D, ACNT.TAC_ABPLCENTER E, ACNT.TAC_ABCENTER B ";
    SQL = SQL + "                        WHERE D.DEL_IF    = 0 ";
    SQL = SQL + "                          AND E.DEL_IF    = 0 ";
    SQL = SQL + "                          AND E.TAC_ABPL_PK = D.PK ";
    SQL = SQL + "                          AND E.TAC_ABCENTER_PK = B.PK) pl ";
    SQL = SQL + "where a.del_if=0   and c.del_if=0 and d.del_if=0";
    SQL = SQL + "and a.tco_org_pk=c.pk and a.thr_wg_pk=d.pk and pl.pk(+)=a.TAC_ABPL_PK ";
    SQL = SQL + "and decode('" + p_nation + "','ALL','ALL',a.NATION )='" + p_nation  + "'";
    SQL = SQL + "and (('" + p_search_by + "'='1' and upper(a.FULL_NAME) like  '%' || upper('" + p_search_temp + "') || '%') ";
    SQL = SQL + "         or ('" + p_search_by + "'='2' and upper(a.emp_id) like  '%' || upper('" + p_search_temp + "') || '%') ";
    SQL = SQL + "         or ('" + p_search_by + "'='3' and upper(a.id_num) like  '%' || upper('" + p_search_temp + "') || '%') ";
    SQL = SQL + "         or ('" + p_search_by + "'='4' and upper(a.PERSON_ID ) like  '%' || upper('" + p_search_temp + "') || '%') ";
    SQL = SQL + "         or ('" + p_search_by + "'='5' and upper(a.OLD_ID ) like  '%' || upper('" + p_search_temp + "') || '%')) ";
    SQL = SQL + "and (('" + p_from_joindate + "' is null and '" + p_to_joindate + "' is null)  ";
    SQL = SQL + "         or (a.JOIN_DT between '" + p_from_joindate + "' and '" + p_to_joindate + "') ) ";
    SQL = SQL + "and decode('" + p_salary_yn + "','ALL','ALL',a.SALARY_YN )='" + p_salary_yn  + "'";
    SQL = SQL + "and decode('" + p_position + "','ALL','ALL',a.POS_TYPE )='" + p_position        + "'";
    SQL = SQL + "and decode('" + p_pay_type + "','ALL','ALL',a.PAY_TYPE )='" + p_pay_type  + "'";
    SQL = SQL + "and decode('" + p_contract_kind + "','ALL','ALL',a.CONTRACT_TYPE )='" + p_contract_kind  + "'";
    SQL = SQL + "and (('" + p_from_contract  + "' is null and '" + p_to_contract + "' is null)  ";
    SQL = SQL + "    or (a.BEGIN_CONTRACT between '" + p_from_contract + "' and '" + p_to_contract + "') ) ";
    SQL = SQL + "and decode('" + p_sex + "','ALL','ALL',a.SEX )='" + p_sex + "' ";
    SQL = SQL + "and decode('" + p_insurance_yn + "','ALL','ALL',a.SOCIAL_YN )='" + p_insurance_yn  + "'";
    SQL = SQL + "and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status  + "'";
    SQL = SQL + "and (('" + p_from_leftdate  + "' is null and '" + p_to_leftdate + "' is null)  ";
    SQL = SQL + "    or (a.LEFT_DT between '" + p_from_leftdate + "' and '" + p_to_leftdate + "') ) ";
    SQL = SQL + " and (('" + p_from_birthdate + "' is null and '" + p_to_birthdate + "' is null)  ";
    SQL = SQL + "    or (decode(length(a.BIRTH_DT),4,a.birth_dt || '0101',a.birth_dt) between '" + p_from_birthdate  + "' and '" + p_to_birthdate + "') ) ";
    SQL = SQL + "and decode('" + p_ot_yn + "','ALL','ALL',a.ot_yn)='" + p_ot_yn  + "'";
   // SQL = SQL + "and decode('" + p_wg + "','ALL','ALL',d.pk)='" + p_wg  + "'";
    SQL = SQL + "and decode('" + p_thr_group_pk + "','ALL','ALL',d.pk)='" + p_thr_group_pk + "'";
    SQL = SQL + "and decode('" + p_union + "','ALL','ALL',a.union_yn)='" + p_union + "'";
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
    SQL = SQL + "and ('" + p_birth_month + "'= 'ALL' or (LENGTH(A.BIRTH_DT)=8 and substr(A.BIRTH_DT,5,2)= '" + p_birth_month + "')) ";
   SQL = SQL + "  order by nvl(c.seq,99999), org_nm,emp_id ";
	
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
    
  
   
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Word.Document>
<meta name=Generator content="Microsoft Word 11">
<meta name=Originator content="Microsoft Word 11">
<link rel=File-List
href="PERFORMANCE%20APPRAISAL%20-%20%20NON%20MANAGEMENT_files/filelist.xml">
<title>POSCO VST CO</title>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="City"/>
<o:SmartTagType namespaceuri="urn:schemas-microsoft-com:office:smarttags"
 name="place"/>
<!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:View>Print</w:View>
  <w:GrammarState>Clean</w:GrammarState>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
 </w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState="false" LatentStyleCount="156">
 </w:LatentStyles>
</xml><![endif]--><!--[if !mso]><object
 classid="clsid:38481807-CA0E-42D2-BF39-B33AF135CC4D" id=ieooui></object>
<style>
st1\:*{behavior:url(#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:12.0pt;
	font-family:"Times New Roman";
	mso-fareast-font-family:"Times New Roman";}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
@page Section1
	{size:595.45pt 841.7pt;
	margin:.6in .5in .3in .8in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<![endif]-->
</head>

<body lang=EN-US style='tab-interval:.5in'>

<div class=Section1>
<% 
     
     for (int i = 0; i < irow; i++) 
     {
        
        
    
    %> 

<p class=MsoNormal><b><span style='font-family:Arial'>POSCO VST CO.,
LTD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span class=GramE><i><u><span style='color:red'>Confidential !</span></u></i></span></span></b></p>

<p class=MsoNormal><span style='font-family:Arial'>&nbsp;</span></p>

<p class=MsoNormal><span style='font-family:Arial'>&nbsp;</span></p>

<p class=MsoNormal align=center style='text-align:center'><b><span
style='font-size:14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
PERFORMANCE APPRAISAL</span></b></p>

<p class=MsoNormal align=center style='text-align:center'><b><span
style='font-size:14.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Non-
Management)</span></b></p>

<p class=MsoNormal><span style='font-family:Arial'>&nbsp;&nbsp; </span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;
<span class=GramE>I&nbsp; .</span>&nbsp;&nbsp;&nbsp; <b>PERIOD UNDER <span
class=GramE>REVIEW :</span> </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;From
__/__/____To&nbsp;__/__/____<o:p></o:p></span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;
<span class=GramE>II .</span>&nbsp;&nbsp;&nbsp; <b>PERSONAL PARTICULARS OF
EMPLOYEE</b> </span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;<span class=GramE>Name :</span>&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=dt_total.Rows[i][0].ToString() %></span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;<span class=GramE>D.O.B :</span>&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=dt_total.Rows[i][1].ToString() %></span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;Department:&nbsp; <%=dt_total.Rows[i][2].ToString() %></span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Title:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <%=dt_total.Rows[i][3].ToString() %></span></p>

<p class=MsoNormal style='margin-left:.25in'><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date jointed:&nbsp;<%=dt_total.Rows[i][4].ToString() %></span></p>

<p class=MsoNormal style='margin-left:9.75pt'><span style='font-size:10.0pt;
font-family:Arial'>III&nbsp;&nbsp;&nbsp; <b>APPRAISER’S <st1:City w:st="on"><st1:place
 w:st="on"><span class=GramE>SUPERIOR</span></st1:place></st1:City></b><span
class=GramE> :</span></span><span style='font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;
</span></p>

<p class=MsoNormal style='margin-left:30.0pt;text-indent:-.25in'><b><span
style='font-size:10.0pt;font-family:Arial'>1.</span></b><b><span
style='font-size:7.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></b><b><span
style='font-size:10.0pt;font-family:Arial'>SECTION 1:&nbsp; EVALUATION</span></b></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Section <span class=GramE>1.1 :</span>&nbsp; Quality &amp; quantity of work</b></span></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 align=left
 width=656 style='width:492.25pt;border-collapse:collapse;mso-table-lspace:
 9.0pt;margin-left:6.75pt;mso-table-rspace:9.0pt;margin-right:6.75pt;
 mso-table-anchor-vertical:paragraph;mso-table-anchor-horizontal:column;
 mso-table-left:left;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;height:22.35pt'>
  <td width=43 style='width:32.45pt;border:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:22.35pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>No</span></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=252 style='width:189.3pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0in 5.4pt 0in 5.4pt;height:22.35pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>Factors</span></p>
  </td>
  <td width=361 colspan=5 style='width:270.5pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt;height:22.35pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>Rating</span></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>Poor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  Excellent</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:21.25pt'>
  <td width=43 style='width:32.45pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt;height:21.25pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=252 style='width:189.3pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:21.25pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>Quality of work have been done</span></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:21.25pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:21.25pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>6</span></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:21.25pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>9</span></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:21.25pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>12</span></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:21.25pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>15</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:17.65pt'>
  <td width=43 style='width:32.45pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt;height:17.65pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=252 style='width:189.3pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.65pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>Quantity of work have been done</span></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.65pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.65pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>6</span></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.65pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>9</span></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.65pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>12</span></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.65pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><span
  style='font-size:10.0pt;font-family:Arial'>15</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;mso-yfti-lastrow:yes;height:30.25pt'>
  <td width=512 colspan=5 style='width:384.0pt;padding:0in 0in 0in 0in;
  height:30.25pt'>
  <p class=MsoNormal style='mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:
  column;mso-height-rule:exactly'>&nbsp;</p>
  </td>
  <td width=72 style='width:54.1pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt;height:30.25pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><b><span
  style='font-size:10.0pt;font-family:Arial'>TOTAL</span></b></p>
  </td>
  <td width=72 style='width:54.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:30.25pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly'><b><span
  style='font-size:10.0pt;font-family:Arial'>/ 30</span></b></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;
&nbsp;&nbsp;&nbsp;<span style='mso-spacerun:yes'>  </span>Section <span
class=GramE>1.2 :</span></span></b><span style='font-size:10.0pt;font-family:
Arial'> &nbsp;<b>Specialist knowledge</b> <b>&nbsp;</b></span></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 width=648
 style='width:6.75in;margin-left:5.4pt;border-collapse:collapse;mso-padding-alt:
 0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=36 style='width:27.0pt;border:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>No</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=252 style='width:189.0pt;border:solid windowtext 1.0pt;border-left:
  none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Factors</span></p>
  </td>
  <td width=360 colspan=5 style='width:3.75in;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Rating</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Poor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  Excellent</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=36 style='width:27.0pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=252 style='width:189.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Apply specialist knowledge on job</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>5</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2'>
  <td width=36 style='width:27.0pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=252 style='width:189.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Forecast &amp; solving problem</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>5</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3'>
  <td width=36 style='width:27.0pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=252 style='width:189.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Responsibility on process</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>5</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4'>
  <td width=36 style='width:27.0pt;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
  <td width=252 style='width:189.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Improve specialist knowledge</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>5</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5;mso-yfti-lastrow:yes;height:25.6pt'>
  <td width=504 colspan=5 style='width:5.25in;padding:0in 0in 0in 0in;
  height:25.6pt'>
  <p class=MsoNormal>&nbsp;</p>
  </td>
  <td width=72 style='width:.75in;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt;height:25.6pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>TOTAL</span></b></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:25.6pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>/ 20</span></b></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;
Section <span class=GramE>1.3 :</span></span></b><span style='font-size:10.0pt;
font-family:Arial'> <b>Personal abilities&nbsp;</b></span></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='margin-left:5.4pt;border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>No</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Factors</span></p>
  </td>
  <td width=360 colspan=5 valign=top style='width:3.75in;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  Rating</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Poor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  Excellent</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;height:17.05pt'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:17.05pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.05pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Teamwork
  &amp; Cooperation</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2;height:17.95pt'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:17.95pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.95pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Improvement</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.95pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3;height:17.05pt'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:17.05pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:17.05pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Responsibility</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:17.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4;height:16.6pt'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:16.6pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:16.6pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Enthusiasm</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:16.6pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:16.6pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:16.6pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:16.6pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:16.6pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>5</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Confidential</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>6</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Creativity</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:7'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>7</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Flexible</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:8'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>8</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Guide
  &amp; remind colleagues carry out the job well</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:9'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>9</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>English</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:10'>
  <td width=35 valign=top style='width:26.6pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>10</span></p>
  </td>
  <td width=253 valign=top style='width:189.4pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Computer</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2.5</span></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:11;mso-yfti-lastrow:yes;height:26.05pt'>
  <td width=504 colspan=5 style='width:5.25in;padding:0in 0in 0in 0in;
  height:26.05pt'>
  <p class=MsoNormal>&nbsp;</p>
  </td>
  <td width=72 style='width:.75in;border:solid windowtext 1.0pt;border-top:
  none;padding:0in 5.4pt 0in 5.4pt;height:26.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>TOTAL</span></b></p>
  </td>
  <td width=72 style='width:.75in;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;
  height:26.05pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>/ 30</span></b></p>
  </td>
 </tr>
</table>

<p class=MsoNormal style='margin-left:12.0pt'><b><span style='font-size:10.0pt;
font-family:Arial'>Section 1.4 :&nbsp; Company regulation implement </span></b></p>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='margin-left:5.4pt;border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=36 valign=top style='width:27.0pt;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>No</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=252 valign=top style='width:189.0pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Factors</span></p>
  </td>
  <td width=360 colspan=5 valign=top style='width:3.75in;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  Rating</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Poor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Excellent</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1'>
  <td width=36 valign=top style='width:27.0pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=252 valign=top style='width:189.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Attendance/Punctuality</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>0</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:2'>
  <td width=36 valign=top style='width:27.0pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=252 valign=top style='width:189.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Work
  Attitude </span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>0</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:3'>
  <td width=36 valign=top style='width:27.0pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=252 valign=top style='width:189.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Safety
  Consciousness</span></p>
  <p class=MsoNormal align=right style='text-align:right'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>0</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:4'>
  <td width=36 valign=top style='width:27.0pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
  <td width=252 valign=top style='width:189.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Care of
  Company’s assets</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>0</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:5'>
  <td width=36 valign=top style='width:27.0pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>5</span></p>
  </td>
  <td width=252 valign=top style='width:189.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Others</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>0</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>1</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>2</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>3</span></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>4</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:6;mso-yfti-lastrow:yes;height:18.85pt'>
  <td width=504 colspan=5 style='width:5.25in;padding:0in 0in 0in 0in;
  height:18.85pt'>
  <p class=MsoNormal>&nbsp;</p>
  </td>
  <td width=72 valign=top style='width:.75in;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;TOTAL</span></b></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  </td>
  <td width=72 valign=top style='width:.75in;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:18.85pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;
  </span></b></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  / 20</span></b></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='margin-left:5.4pt;border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes;
  height:103.45pt'>
  <td width=648 valign=top style='width:6.75in;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:103.45pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial;
  color:black'>&nbsp;</span></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial;
  color:black'>TOTAL SCORE : To be completed by Appraiser</span></b></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial;
  color:black'>&nbsp;</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial;
  color:black'>Section 1.1&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
  style='font-size:10.0pt;font-family:Arial'>Quality &amp; quantity of
  work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style='color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  /30%&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial;
  color:black'>Section 1.2&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp; </span><span
  style='font-size:10.0pt;font-family:Arial'>Specialist
  knowledge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;/20%</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial;
  color:black'>Section 1.3&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
  style='font-size:10.0pt;font-family:Arial'>Personal
  abilities&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  /30%</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial;
  color:black'>Section 1.4&nbsp; :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span
  style='font-size:10.0pt;font-family:Arial'>Company regulation
  implement&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;=&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;/20%</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial;
  color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;----------------</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial;
  color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  / 100%</span></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;</span></b></p>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;
2.&nbsp; </span></b><b><span style='font-family:Arial'>SECTION 2 :&nbsp;
DEVELOPMENT</span></b><b><u><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;
</span></u></b></p>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;Section 2.1 :&nbsp;&nbsp; Ranking </span></b></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='margin-left:5.4pt;border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes'>
  <td width=135 valign=top style='width:101.45pt;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>D </span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Poor</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Under 50%</span></p>
  </td>
  <td width=129 valign=top style='width:96.55pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>C </span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Basic</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>50% - 59%</span></p>
  </td>
  <td width=163 valign=top style='width:122.5pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>B </span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Meet requirements</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>60% - 79%</span></p>
  </td>
  <td width=132 valign=top style='width:99.0pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>A </span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Good</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>80% - 90%</span></p>
  </td>
  <td width=133 valign=top style='width:99.8pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:10.0pt;font-family:Arial'>A+ </span></b></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>Excellent</span></p>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>90% - 100%</span></p>
  </td>
 </tr>
 <tr style='mso-yfti-irow:1;mso-yfti-lastrow:yes'>
  <td width=135 valign=top style='width:101.45pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=129 valign=top style='width:96.55pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal align=center style='text-align:center'><span
  style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=163 valign=top style='width:122.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=132 valign=top style='width:99.0pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
  <td width=133 valign=top style='width:99.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></b></p>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Section 2.2&nbsp; Appraiser’s comments&nbsp; </span></b></p>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;
</span></b></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 align=left
 style='border-collapse:collapse;mso-table-lspace:9.0pt;margin-left:6.75pt;
 mso-table-rspace:9.0pt;margin-right:6.75pt;mso-table-anchor-vertical:paragraph;
 mso-table-anchor-horizontal:column;mso-table-left:left;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=16 valign=top style='width:11.8pt;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:
  column;mso-height-rule:exactly'><b><span style='font-size:10.0pt;font-family:
  Arial'>&nbsp;</span></b></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Promotable
to :&nbsp; ……………………………………………………………………………………………………………<br clear=all>
&nbsp;&nbsp; </span></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 align=left
 style='border-collapse:collapse;mso-table-lspace:9.0pt;margin-left:6.75pt;
 mso-table-rspace:9.0pt;margin-right:6.75pt;mso-table-anchor-vertical:paragraph;
 mso-table-anchor-horizontal:column;mso-table-left:left;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=16 valign=top style='width:11.8pt;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:
  column;mso-height-rule:exactly'><span style='font-size:10.0pt;font-family:
  Arial'>&nbsp;</span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Considerable
for salary increasing :&nbsp; ……………………………………………………………………………………</span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 align=left
 style='border-collapse:collapse;mso-table-lspace:9.0pt;margin-left:6.75pt;
 mso-table-rspace:9.0pt;margin-right:6.75pt;mso-table-anchor-vertical:paragraph;
 mso-table-anchor-horizontal:column;mso-table-left:left;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=16 valign=top style='width:11.8pt;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:
  column;mso-height-rule:exactly'><span style='font-size:10.0pt;font-family:
  Arial'>&nbsp;</span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Trainning
needs : …………………………………………………………………………………………………………</span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;
</span></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 align=left
 style='border-collapse:collapse;mso-table-lspace:9.0pt;margin-left:6.75pt;
 mso-table-rspace:9.0pt;margin-right:6.75pt;mso-table-anchor-vertical:paragraph;
 mso-table-anchor-horizontal:column;mso-table-left:left;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=16 valign=top style='width:11.8pt;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:
  column;mso-height-rule:exactly'><span style='font-size:10.0pt;font-family:
  Arial'>&nbsp;</span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Unable to assess
: ………………………………………………………………………………………………………</span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 align=left
 style='border-collapse:collapse;mso-table-lspace:9.0pt;margin-left:6.75pt;
 mso-table-rspace:9.0pt;margin-right:6.75pt;mso-table-anchor-vertical:paragraph;
 mso-table-anchor-horizontal:column;mso-table-left:left;mso-padding-alt:0in 0in 0in 0in'>
 <tr style='mso-yfti-irow:0;mso-yfti-firstrow:yes;mso-yfti-lastrow:yes'>
  <td width=16 valign=top style='width:11.8pt;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:
  column;mso-height-rule:exactly'><span style='font-size:10.0pt;font-family:
  Arial'>&nbsp;</span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>Others :
…………………………………………………………………………………………………………………</span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>

<p class=MsoNormal style='text-indent:6.0pt'><b><span style='font-size:10.0pt;
font-family:Arial'>Appraiser 1 :</span></b><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name&nbsp;
________________________ , Signature _______________&nbsp; , Date _________</span></p>

<p class=MsoNormal style='text-indent:6.0pt'><span style='font-size:10.0pt;
font-family:Arial'>&nbsp;</span></p>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;
Appraiser 2 :</span></b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Name&nbsp;
________________________ , Signature _______________&nbsp; , Date _________</span></p>

<p class=MsoNormal><span style='font-size:10.0pt;font-family:Arial'>&nbsp;</span></p>

<p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Arial'>&nbsp;
Approved by :
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></b><span
style='font-size:10.0pt;font-family:Arial'>Name&nbsp; ________________________
, Signature _______________&nbsp; , Date _________</span></p>
<%  if (i==dt_total.Rows.Count-1) 
    {%>
<p class=MsoNormal style='margin-right:5.6pt;text-align:justify'><span
lang=PT-BR style='mso-ansi-language:PT-BR;mso-special-character:line-break;
page-break-before:always'><o:p>&nbsp;</o:p></span></p>
<%  } 
    else
    {    %>
<b><span lang=PT-BR style='font-size:12.0pt;font-family:"Times New Roman";
mso-fareast-font-family:"Times New Roman";mso-ansi-language:PT-BR;mso-fareast-language:
VI;mso-bidi-language:AR-SA'><br clear=all style='page-break-before:always'>
</span></b>
<%  } %>
<%} %>

</div>

</body>

</html>
