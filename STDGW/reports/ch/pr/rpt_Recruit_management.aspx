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
    string p_org=Request["p_org"].ToString();
    string p_position = Request["p_position"].ToString();
    string p_serach = Request["p_serach"].ToString();
    string p_temp = Request["p_temp"].ToString();
    string p_resultby = Request["p_resultby"].ToString();
    string p_status = Request["p_status"].ToString();
    string p_request = Request["p_request"].ToString();
    string p_detail = Request["p_detail"].ToString();
    string p_PeriodFrom = Request["p_PeriodFrom"].ToString();
    string p_PeriodTo = Request["p_PeriodTo"].ToString();
    string p_receive_from = Request["p_receive_from"].ToString();
    string p_receive_to = Request["p_receive_to"].ToString();
    string p_Expiry_from = Request["p_Expiry_from"].ToString();
    string p_Expiry_to = Request["p_Expiry_to"].ToString();
    string p_Interview1_from = Request["p_Interview1_from"].ToString();
    string p_Interview1_to = Request["p_Interview1_to"].ToString();
    string p_Interview2_from = Request["p_Interview2_from"].ToString();
    string p_Interview2_to = Request["p_Interview2_to"].ToString();
    string p_Interview3_from = Request["p_Interview3_from"].ToString();
    string p_Interview3_to = Request["p_Interview3_to"].ToString();
    string p_working_from = Request["p_working_from"].ToString();
    string p_working_to = Request["p_working_to"].ToString();
   
              
                    
                    
  string SQL
	= "select  " + 
        "   e.rec_id " +
        "   ,e.REC_NM " +
        "   ,decode (SEX,'M','Male','F','Female','') " +
        "   ,case when length( BIRTH_DT)>4 then to_char( to_date(BIRTH_DT,'yyyymmdd'),'dd/mm/yyyy') else BIRTH_DT  end  " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0021' and v.code=nvl( BIRTH_PLACE,' ')) " +
        "   ,PER_ID " +
        "   ,to_char( to_date(ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0014' and v.code=nvl( PLACE_PER_ID,' ')) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0015' and v.code=nvl(ETHNIC_TYPE,' ')) " +
        "   ,PERMANENT_ADDR " +
        "   ,PRESENT_ADDR " +
        "   ,HAND_PHONE " +
        "   ,HOME_PHONE " +
        "   ,OTHER_CONTACT " +
        "   ,EMAIL " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0011' and v.code=nvl(EDU_TYPE,' ')) " +
        "   ,GRA_SCHOOL " +
        "   ,MAJOR " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0147' and v.code=nvl(GRA_RESULT,' ')) " +
        "   ,OTHER_DEGREE " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0143' and v.code=nvl(LANG_TYPE,' ')) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0144' and v.code=nvl(LANG_RESULT,' ')) " +
        "   ,OTHER_LANGUAGE " +
        "   ,COMPUTER_SKILL " +
        "   ,EXPERIENCE_YEAR " +
        "   ,REMARK " +
        "   ,(select g.ORG_NM from   comm.tco_org g where g.del_if=0 and g.pk=nvl( REC_ORG_PK,0)) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0008' and v.code=nvl(REC_POS_TYPE,' ')) " +
        "   ,(select v.code_nm from vhr_hr_code v where v.id='HR0010' and v.code=nvl(REC_JOB_TYPE,' ')) " +
        "   ,REC_SALARY " +
        "   ,OTHER_REQUEST " +
        "   ,to_char( to_date(CV_RECIEVE_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,INT_ID||'-'||INT_NM " +
        "   ,to_char( to_date(EXPIRY_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,decode(INF_FULL_YN,'Y','Yes','N','No','') " +
        "   ,INF_NOTE " +
        "   ,to_char( to_date(INTERVIEW_DT1,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,RESULT_T1 " +
        "   ,REMARK_1 " +
        "   ,to_char( to_date(INTERVIEW_DT2,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,RESULT_T2 " +
        "   ,REMARK_2 " +
        "   ,to_char( to_date(INTERVIEW_DT3,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,RESULT_T3 " +
       "   ,REMARK_3 " +
         ",(case when   nvl((select '1' from thr_employee u where u.del_if=0 and nvl(u.THR_REC_EMP_PK,0)=e.pk  ),'0')='1' then 'Applied' " + 
        "          else decode (e.pass_yn,'N','Failed','Y','Passed','Waiting') " +
        "      end) " +
        "   ,to_char( to_date(WORKING_DT,'yyyymmdd'),'dd/mm/yyyy') " +
        "   ,(select a.app_no ||' - ' ||(select v.code_nm from vhr_hr_code v where v.id='HR0008' and nvl(v.code,' ') = b.POS_TYPE ) from THR_REC_REQUEST a,THR_REC_REQUEST_DETAIL b  where a.del_if=0 and b.del_if=0 and a.pk=b.THR_REC_REQUEST_PK and b.pk= e.THR_REC_REQUEST_DT_PK   ) " +
        "    from thr_rec_emp e " +
        "     where e.DEL_IF=0 " +
        "     and decode ('"+p_position+"','ALL','"+p_position+"',e.REC_POS_TYPE)='"+p_position+"' " +
        "      and ( ('" + p_resultby + "'='1' and  decode ('" + p_status + "','ALL','" + p_status + "',e.result_t1 )='" + p_status + "' ) " +
        "          or('" + p_resultby + "'='2' and  decode ('" + p_status + "','ALL','" + p_status + "',e.result_t2 )='" + p_status + "' ) " +
        "          or('" + p_resultby + "'='3' and  decode ('" + p_status + "','ALL','" + p_status + "',e.result_t3 )='" + p_status + "' ) " +
        "          or('" + p_resultby + "'='4' and  decode ('" + p_status + "','ALL','" + p_status + "',e.pass_yn )='" + p_status + "' ) " +
        "          or ('" + p_resultby + "' ='ALL' and (  decode ('" + p_status + "','ALL','" + p_status + "',e.result_t1 )='" + p_status + "'  " +
        "                                     or decode ('" + p_status + "','ALL','" + p_status + "',e.result_t2 )='" + p_status + "'  " +
        "                                     or decode ('" + p_status + "','ALL','" + p_status + "',e.result_t3 )='" + p_status + "'  " +
        "                                     or decode ('" + p_status + "','ALL','" + p_status + "',e.pass_yn )='" + p_status + "'  " +
        "                                      )) " +
        "          ) " +
        "      and decode ('"+p_detail+"','ALL','"+p_detail+"',THR_REC_REQUEST_DT_PK)='"+p_detail+"' " +
        "      and (case when '"+p_request+"'='NON' and e.THR_REC_REQUEST_DT_PK is null  then 'NON' else  '1' end) = decode('"+p_request+"','NON','NON','1' ) " +
        "      and (e.THR_REC_REQUEST_DT_PK  " +
        "                in (select b.PK " +
        "                            from  THR_REC_REQUEST a,THR_REC_REQUEST_DETAIL b where b.del_if=0 and a.del_if=0 and a.pk=b.THR_REC_REQUEST_PK  " +
        "                            and e.THR_REC_REQUEST_DT_PK=b.pk " +
        "                            and(  " +
        "                                 (('"+p_PeriodFrom+"'  between  a.FROM_DT and a.TO_DT " +
        "                              or  '"+p_PeriodTo+"'  between  a.FROM_DT and a.TO_DT " +
        "                              or  a.FROM_DT  between  '"+p_PeriodFrom+"'  and '"+p_PeriodTo+"' " +
        "                              or  a.TO_DT  between  '"+p_PeriodFrom+"'  and '"+p_PeriodTo+"') " +
        "                              and '"+p_PeriodTo+"' is not null and '"+p_PeriodFrom+"'  is not null  " +
        "                              ) " +
        "                              or  " +
        "                              ( '"+p_PeriodTo+"' is null and '"+p_PeriodFrom+"'  is  null) " +
        "                               " +
        "                              ) " +
        "                              and decode ('"+p_request+"','ALL','"+p_request+"',a.pk)='"+p_request+"' " +
        "                              " +
        "                   ) " +
        "                   or '"+p_request+"'='ALL'  " +
        "                   and '"+p_request+"'<>'NON' " +
        "                   ) " +
        "       " +
        "       AND (e.REC_ORG_PK IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM COMM.TCO_ORG g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('"+p_org+"', " +
        "                                                    'ALL', 0, " +
        "                                                    '"+p_org+"' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '"+p_org+"' = 'ALL') " +
        "      AND (   (    '"+p_serach+"' = 1 " +
        "                  AND UPPER (e.rec_nm) LIKE '%' || UPPER ('"+p_temp+"') || '%' " +
        "                 ) " +
        "              OR ('"+p_serach+"' = 2 AND e.rec_id LIKE '%' || '"+p_temp+"' || '%') " +
        "                          OR (    '"+p_serach+"' = 4 " +
        "                  AND UPPER (e.per_id) LIKE '%' || UPPER ('"+p_temp+"') || '%' " +
        "                 ) " +
        "              OR '"+p_temp+"' IS NULL " +
        "             ) " +
        "              " +
        "      and ( ('"+p_receive_from+"' is null and '"+p_receive_to+"' is null ) or (CV_RECIEVE_DT between  '"+p_receive_from+"' and '"+p_receive_to+"')  ) " +
        "      and ( ('"+p_Expiry_from+"' is null and '"+p_Expiry_to+"' is null ) or (EXPIRY_DT between  '"+p_Expiry_from+"'  and '"+p_Expiry_to+"')  )  " +
        "      and ( ('"+p_Interview1_from+"' is null and '"+p_Interview1_to+"' is null ) or (INTERVIEW_DT1 between  '"+p_Interview1_from+"'  and '"+p_Interview1_to+"')  ) " +
        "      and ( ('"+p_Interview2_from+"' is null and '"+p_Interview2_to+"' is null ) or (INTERVIEW_DT2 between  '"+p_Interview2_from+"'  and '"+p_Interview2_to+"')  )  " +
        "      and ( ('"+p_Interview3_from+"' is null and '"+p_Interview3_to+"' is null ) or (INTERVIEW_DT3 between  '"+p_Interview3_from+"'  and '"+p_Interview3_to+"')  )   " +
        "      and ( ('" + p_working_from + "' is null and '" + p_working_to + "' is null ) or (e.working_dt between  '" + p_working_from + "'  and '" + p_working_to + "')  )   " +
        "         order by rec_id    " ;


 // Response.Write(SQL);
 // Response.End();
  DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
   if (dt_Emp.Rows.Count == 0)
  {
      Response.Write("There is no data of salary");
      Response.End();
  }

 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="New%20Microsoft%20Excel%20Worksheet%20(3)_files/filelist.xml">
<link rel=Edit-Time-Data
href="New%20Microsoft%20Excel%20Worksheet%20(3)_files/editdata.mso">
<link rel=OLE-Object-Data
href="New%20Microsoft%20Excel%20Worksheet%20(3)_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:LastPrinted>2011-06-21T03:18:42Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-06-21T03:18:57Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.1in .2in .1in .2in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl25
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:204;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
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
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>20</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>42</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>49</x:ActiveCol>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$3:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=4791 style='border-collapse:
 collapse;table-layout:fixed;width:3593pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl24 width=191 style='mso-width-source:userset;mso-width-alt:6985;
 width:143pt'>
 <col class=xl24 width=96 span=253 style='mso-width-source:userset;mso-width-alt:
 3510;width:72pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=49 rowspan=2 height=42 class=xl24 width=4791 style='border-bottom:
  .5pt solid black;height:31.5pt;width:3593pt'>Application Document</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
 </tr>
 <tr class=xl25 height=27 style='height:20.25pt'>
  <td colspan=16 height=27 class=xl43 style='height:20.25pt'>PERSONAL
  INFORMATION - TH&Ocirc;NG TIN C&Aacute; NH&Acirc;N</td>
  <td colspan=11 class=xl48 style='border-right:.5pt hairline black;border-left:
  none'>EDUCATION - TR&Igrave;NH &#272;&#7896; CHUY&Ecirc;N M&Ocirc;N</td>
  
  <td colspan=10 class=xl47 style='border-right:.5pt hairline black'>APPLICATION
  - &#7912;NG TUY&#7874;N</td>
  <td colspan=11 class=xl42 style='border-left:none'>INTERVIEW INFORMATION -
  TH&Ocirc;NG TIN PH&#7886;NG V&#7844;N</td>
  <td rowspan=2 class=xl45 >Request No</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl26 style='height:23.25pt;border-top:none'>No</td>
  <td class=xl37 style='border-top:none'>Document ID</td>
  <td class=xl27 style='border-top:none;border-left:none'>Full Name</td>
  <td class=xl27 style='border-top:none;border-left:none'>Sex</td>
  <td class=xl27 style='border-top:none;border-left:none'>Birthday</td>
  <td class=xl27 style='border-top:none;border-left:none'>Birth Place</td>
  <td class=xl27 style='border-top:none;border-left:none'>Personal ID</td>
  <td class=xl27 style='border-top:none;border-left:none'>Isuued Date</td>
  <td class=xl27 style='border-top:none;border-left:none'>Place ID</td>
  <td class=xl27 style='border-top:none;border-left:none'>Ethnic</td>
  <td class=xl27 style='border-top:none;border-left:none'>Current Address</td>
  <td class=xl27 style='border-top:none;border-left:none'>Permanent Address</td>
  <td class=xl27 style='border-top:none;border-left:none'>Hand Phone</td>
  <td class=xl27 style='border-top:none;border-left:none'>Home Phone</td>
  <td class=xl27 style='border-top:none;border-left:none'>Other Contact</td>
  <td class=xl27 style='border-top:none;border-left:none'>Email</td>
  <td class=xl27 style='border-top:none;border-left:none'>Education</td>
  <td class=xl27 style='border-top:none;border-left:none'>School</td>
  <td class=xl27 style='border-top:none;border-left:none'>Major</td>
  <td class=xl27 style='border-top:none;border-left:none'>Granduation Kind</td>
  <td class=xl27 style='border-top:none;border-left:none'>Other Certificate</td>
  <td class=xl27 style='border-top:none;border-left:none'>Foreign Language</td>
  <td class=xl27 style='border-top:none;border-left:none'>Language Certificate</td>
  <td class=xl27 style='border-top:none;border-left:none'>Other Language</td>
  <td class=xl27 style='border-top:none;border-left:none'>Computer skill</td>
  <td class=xl27 style='border-top:none;border-left:none'>Experience</td>
  <td class=xl27 style='border-top:none;border-left:none'>Other Description</td>
  <td class=xl27 style='border-top:none;border-left:none' x:str="Organization ">Organization<span
  style='mso-spacerun:yes'>&nbsp;</span></td>
  <td class=xl27 style='border-top:none;border-left:none'>Position</td>
  <td class=xl27 style='border-top:none;border-left:none'>Job</td>
  <td class=xl27 style='border-top:none;border-left:none' x:str="Salary ">Salary<span
  style='mso-spacerun:yes'>&nbsp;</span></td>
  <td class=xl27 style='border-top:none;border-left:none'>Other Request</td>
  <td class=xl27 style='border-top:none;border-left:none'>Received DT</td>
  <td class=xl27 style='border-top:none;border-left:none'>Introduction</td>
  <td class=xl27 style='border-top:none;border-left:none'>Expiry DT</td>
  <td class=xl27 style='border-top:none;border-left:none'>Full Profile</td>
  <td class=xl27 style='border-top:none;border-left:none'>Profile Note</td>
  <td class=xl27 style='border-top:none;border-left:none'>Interview DT</td>
  <td class=xl27 style='border-top:none;border-left:none'>Result 1</td>
  <td class=xl27 style='border-top:none;border-left:none'>Remark 1</td>
  <td class=xl27 style='border-top:none;border-left:none'>Interview DT 2</td>
  <td class=xl27 style='border-top:none;border-left:none'>Result 2</td>
  <td class=xl27 style='border-top:none;border-left:none'>Remark 2</td>
  <td class=xl27 style='border-top:none;border-left:none'>Interview DT 3</td>
  <td class=xl27 style='border-top:none;border-left:none'>Result 3</td>
  <td class=xl27 style='border-top:none;border-left:none'>Remark 3</td>
  <td class=xl27 style='border-top:none;border-left:none'>Status</td>
  <td class=xl27 style='border-top:none;border-left:none'>Join DT</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl28 style='height:21.0pt;border-top:none'>S&#7889;</td>
  <td class=xl38 style='border-top:none'>M&atilde; h&#7891; s&#417;</td>
  <td class=xl29 style='border-top:none;border-left:none'>H&#7885; t&ecirc;n</td>
  <td class=xl29 style='border-top:none;border-left:none'>Gi&#7899;i
  t&iacute;nh</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ng&agrave;y sinh</td>
  <td class=xl29 style='border-top:none;border-left:none'>N&#417;i sinh</td>
  <td class=xl29 style='border-top:none;border-left:none'>CMND</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ng&agrave;y c&#7845;p</td>
  <td class=xl29 style='border-top:none;border-left:none'>N&#417;i c&#7845;p</td>
  <td class=xl29 style='border-top:none;border-left:none'>Dân tộc</td>
  <td class=xl29 style='border-top:none;border-left:none'>&#272;/C
  th&#432;&#7901;ng tr&uacute;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&#272;/C t&#7841;m
  tr&uacute;</td>
  <td class=xl29 style='border-top:none;border-left:none'>&#272;T Di
  &#273;&#7897;ng</td>
  <td class=xl29 style='border-top:none;border-left:none'>&#272;T b&agrave;n</td>
  <td class=xl29 style='border-top:none;border-left:none'>H&igrave;nh
  th&#7913;c Li&ecirc;n l&#7841;c kh&aacute;c</td>
  <td class=xl29 style='border-top:none;border-left:none'>Email</td>
  <td class=xl29 style='border-top:none;border-left:none'>Tr&igrave;nh
  &#273;&#7897;</td>
  <td class=xl29 style='border-top:none;border-left:none'>Tr&#432;&#7901;ng</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ng&agrave;nh</td>
  <td class=xl29 style='border-top:none;border-left:none'>H&igrave;nh
  th&#7913;c t&#7889;t nghi&#7879;p</td>
  <td class=xl29 style='border-top:none;border-left:none'>B&#7857;ng c&#7845;p
  kh&aacute;c</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ngo&#7841;i ng&#7919;</td>
  <td class=xl29 style='border-top:none;border-left:none'>B&#7857;ng c&#7845;p</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ngo&#7841;i ng&#7919;
  kh&aacute;c</td>
  <td class=xl29 style='border-top:none;border-left:none'>Kh&#7843; n&#259;ng
  s&#7917; d&#7909;ng vi t&iacute;nh</td>
  <td class=xl29 style='border-top:none;border-left:none'>Kinh nghi&#7879;m</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ghi ch&uacute;
  kh&aacute;c</td>
  <td class=xl29 style='border-top:none;border-left:none'>B&#7897; ph&#7853;n</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ch&#7913;c v&#7909;</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ngh&#7873;
  nghi&#7879;p</td>
  <td class=xl29 style='border-top:none;border-left:none'>L&#432;&#417;ng</td>
  <td class=xl29 style='border-top:none;border-left:none'>Y&ecirc;u c&#7847;u
  kh&aacute;c</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ng&agrave;y n&#7897;p
  h&#7891; s&#417;</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ng&#432;&#7901;i
  gi&#7899;i thi&#7879;u</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ng&agrave;y h&#7871;t
  hi&#7879;u l&#7921;c</td>
  <td class=xl29 style='border-top:none;border-left:none'>N&#7897;p
  &#273;&#7911; h&#7891; s&#417;</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ghi ch&uacute;</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ng&agrave;y
  ph&#7887;ng v&#7845;n L1</td>
  <td class=xl29 style='border-top:none;border-left:none'>K&#7871;t qu&#7843;
  L1</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ghi ch&uacute; L1</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ng&agrave;y
  ph&#7887;ng v&#7845;n L1</td>
  <td class=xl29 style='border-top:none;border-left:none'>K&#7871;t qu&#7843;
  L1</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ghi ch&uacute; L1</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ng&agrave;y
  ph&#7887;ng v&#7845;n L1</td>
  <td class=xl29 style='border-top:none;border-left:none'>K&#7871;t qu&#7843;
  L1</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ghi ch&uacute; L1</td>
  <td class=xl29 style='border-top:none;border-left:none'>Tr&#7841;ng
  th&aacute;i</td>
  <td class=xl29 style='border-top:none;border-left:none'>Ng&agrave;y
  nh&#7853;n vi&#7879;c</td>
  <td class=xl30 style='border-top:none;border-left:none'>Phi&#7871;u
  tuy&#7875;n d&#7909;ng</td>
 </tr>
 
 <% for (int i = 0; i < dt_Emp.Rows.Count; i++)
    {%>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt;border-top:none'><%=i + 1%></td>
  <td class=xl39 style='border-top:none'><%=dt_Emp.Rows[i][0].ToString()%></td>
  <%for (int j = 1; j < 48; j++)
    {%>
  <td class=xl32 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][j].ToString()%></td>
 <%} %>
 </tr>
 <%
} %>
 <tr height=21 style='height:15.75pt'>
  <td class=xl34 style="height:16pt;border-top:none">&nbsp;</td>
  <td class=xl40 style="border-top:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl35 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
  <td class=xl36 style="border-top:none;border-left:none; height: 16pt;">&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=96 style='width:72pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=191 style='width:143pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=96 style='width:72pt'></td>
 </tr>
 <![endif]></table>

</body>

</html>
