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
    string P_TCO_ORG_PK,P_TEAM_PK,P_NATION,P_SEARCH_BY,P_SEARCH_TEMP,P_FROM_JOINDATE;
    string P_TO_JOINDATE,P_POSITION,P_SEX,P_STATUS,P_FROM_LEFTDATE,P_TO_LEFTDATE;
    string P_FROM_BIRTHDATE,P_TO_BIRTHDATE;
    
    
    P_TCO_ORG_PK = Request["P_TCO_ORG_PK"].ToString();
    P_TEAM_PK = Request["P_TEAM_PK"].ToString();
    P_NATION = Request["P_NATION"].ToString();
    P_SEARCH_BY = Request["P_SEARCH_BY"].ToString();
    P_SEARCH_TEMP = Request["P_SEARCH_TEMP"].ToString();
    P_FROM_JOINDATE = Request["P_FROM_JOINDATE"].ToString();
    P_TO_JOINDATE = Request["P_TO_JOINDATE"].ToString();
    P_POSITION = Request["P_POSITION"].ToString();
    P_SEX = Request["P_SEX"].ToString();
    P_STATUS = Request["P_STATUS"].ToString();
    P_FROM_LEFTDATE = Request["P_FROM_LEFTDATE"].ToString();
    P_TO_LEFTDATE = Request["P_TO_LEFTDATE"].ToString();
    P_FROM_BIRTHDATE = Request["P_FROM_BIRTHDATE"].ToString();
    P_TO_BIRTHDATE= Request["P_TO_BIRTHDATE"].ToString();
  
    string SQL
	= "SELECT " + 
        "        A.EMP_ID compare,  " +
        "        F_GET_ORG_LEVEL(a.tco_org_pk,'01','NAME') AS ORG_NM1,  " +
        "        F_GET_ORG_LEVEL(a.tco_org_pk,'02','NAME') AS ORG_NM2,  " +
        "        F_GET_ORG_LEVEL(a.tco_org_pk,'03','NAME') AS team,  " +
        "        A.EMP_ID,  " +
        "        null relation , " + 
        "        A.FULL_NAME,   " +
        "        TO_CHAR(TO_DATE(A.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY'),  " +
        "        DECODE(LENGTH(BIRTH_DT),4,BIRTH_DT,TO_CHAR(TO_DATE(BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')),   " +
        "        TEL,  " +
        "        EMAIL,  " +
        "        (select code_nm from vhr_hr_code where id='HR0010' and code=a.JOB_TYPE),  " + //
        "        PRESENT_ADDR, " +
        "        SEX.CODE_NM,   " +
        "        NATION.CODE_NM,  " +
        "        POS_TYPE.CODE_NM,  " +
        "        STATUS.CODE_NM,   " +
        "        TO_CHAR(TO_DATE(LEFT_DT,'YYYYMMDD'),'DD/MM/YYYY'),  " +
        "        RESIGN_TYPE.CODE_NM,   " +
        "        A.PIT_TAX_NO,  " +
        "        D.PASSPORT_NO,   " +
        "        TO_CHAR(TO_DATE(D.FROM_DT,'YYYYMMDD'),'DD/MM/YYYY'),  " +
        "        TO_CHAR(TO_DATE(D.TO_DT,'YYYYMMDD'),'DD/MM/YYYY'),   " +
        "        E.VISA_NO, " +
        "        TO_CHAR(TO_DATE(E.FROM_DT,'YYYYMMDD'),'DD/MM/YYYY'),  " +
        "        TO_CHAR(TO_DATE(E.TO_DT,'YYYYMMDD'),'DD/MM/YYYY'), " +
        "        F.LABOUR_NO,  " +
        "        TO_CHAR(TO_DATE(F.FROM_DT,'YYYYMMDD'),'DD/MM/YYYY'),  " +
        "        TO_CHAR(TO_DATE(F.TO_DT,'YYYYMMDD'),'DD/MM/YYYY'),  " +
        "        G.RENTAL_AMT,  " +
        "        G.DEPOSIT_AMT, " +
        "        TO_CHAR(TO_DATE(G.FROM_DT,'YYYYMMDD'),'DD/MM/YYYY'),  " +
        "        TO_CHAR(TO_DATE(G.TO_DT,'YYYYMMDD'),'DD/MM/YYYY')  " +
        "     FROM THR_EMPLOYEE A,TCO_ORG B,THR_WORK_GROUP C " +
        "     ,(SELECT A.CODE,A.CODE_NM FROM THR_CODE_DETAIL A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.THR_CODE_MASTER_PK=B.PK AND B.ID ='HR0022') STATUS " +
        "     ,(SELECT A.CODE,A.CODE_NM FROM THR_CODE_DETAIL A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.THR_CODE_MASTER_PK=B.PK AND B.ID ='HR0004') RESIGN_TYPE " +
        "     ,(SELECT A.CODE,A.CODE_NM FROM THR_CODE_DETAIL A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.THR_CODE_MASTER_PK=B.PK AND B.ID ='HR0009') NATION " +
        "     ,(SELECT A.CODE,A.CODE_NM FROM THR_CODE_DETAIL A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.THR_CODE_MASTER_PK=B.PK AND B.ID ='HR0008') POS_TYPE " +
        "     ,(SELECT A.CODE,A.CODE_NM FROM THR_CODE_DETAIL A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.THR_CODE_MASTER_PK=B.PK AND B.ID ='HR0007') SEX " +
        "     ,THR_F_PASSPORT D,THR_F_VISA E,THR_F_LABOUR_LICENCE F,THR_F_RENTAL_HOUSE G " +
        "     WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND A.TCO_ORG_PK=B.PK AND A.THR_WG_PK=C.PK " +
        "     AND A.STATUS=STATUS.CODE(+) AND D.DEL_IF(+)=0 AND E.DEL_IF(+)=0 AND F.DEL_IF(+)=0 AND G.DEL_IF(+)=0 AND NVL(A.NATION,'00')<>'01'" +
        "     AND A.RESIGN_TYPE=RESIGN_TYPE.CODE(+) AND A.NATION=NATION.CODE(+) AND A.POS_TYPE=POS_TYPE.CODE(+) AND SEX.CODE(+)=A.SEX " +
        "     AND A.THR_F_PASSPORT_PK=D.PK(+)  " +
        "     AND A.THR_F_VISA_PK=E.PK(+) " +
        "     AND A.THR_F_LABOUR_LICENCE_PK=F.PK(+) " +
        "     AND A.THR_F_RENTAL_HOUSE_PK=G.PK(+) " +
        "     AND DECODE('" + P_TEAM_PK + "','ALL','ALL',c.PK)='" + P_TEAM_PK + "' " +
        "     AND DECODE('" + P_NATION + "','ALL','ALL',A.NATION )='" + P_NATION + "' " +
        "     AND (('" + P_SEARCH_BY + "'='1' AND UPPER(A.FULL_NAME) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%') " +
        "         OR ('" + P_SEARCH_BY + "'='2' AND UPPER(A.EMP_ID) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%') " +
        "         OR ('" + P_SEARCH_BY + "'='3' AND UPPER(D.PASSPORT_NO) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%' ) " +
        "         OR ('" + P_SEARCH_BY + "'='4' AND UPPER(E.VISA_NO ) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%') " +
        "         OR ('" + P_SEARCH_BY + "'='5' AND UPPER(F.LABOUR_NO ) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%')) " +
        "     AND (('" + P_FROM_JOINDATE + "' IS NULL AND '" + P_TO_JOINDATE + "' IS NULL) " +
        "         OR (A.JOIN_DT BETWEEN '" + P_FROM_JOINDATE + "' AND '" + P_TO_JOINDATE + "') ) " +
        "     AND DECODE('" + P_POSITION + "','ALL','ALL',A.POS_TYPE )='" + P_POSITION + "' " +
        "     AND DECODE('" + P_SEX + "','ALL','ALL',A.SEX )='" + P_SEX + "' " +
        "     AND DECODE('" + P_STATUS + "','ALL','ALL',A.STATUS)='" + P_STATUS + "' " +
        "     AND (('" + P_FROM_LEFTDATE + "' IS NULL AND '" + P_TO_LEFTDATE + "' IS NULL) " +
        "         OR (A.LEFT_DT BETWEEN '" + P_FROM_LEFTDATE + "' AND '" + P_TO_LEFTDATE + "') ) " +
        "      AND (('" + P_FROM_BIRTHDATE + "' IS NULL AND '" + P_TO_BIRTHDATE + "' IS NULL) " +
        "         OR (DECODE(LENGTH(A.BIRTH_DT),4,A.BIRTH_DT || '0101',A.BIRTH_DT) BETWEEN '" + P_FROM_BIRTHDATE + "' AND '" + P_TO_BIRTHDATE + "') ) " +
        "      AND (   A.TCO_ORG_PK IN ( " +
        "                              SELECT     G.PK " +
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('" + P_TCO_ORG_PK + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + P_TCO_ORG_PK + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '" + P_TCO_ORG_PK + "' = 'ALL') " +
        " union all"  + 
        " SELECT " + 
        "        a.emp_id compare ," +
        "        null AS ORG_NM1,  " +
        "        null AS ORG_NM2,  " +
        "        null AS TEAM,  " +
        "        null emp_id,  " +
        "        rel.code_nm," +
        "        y.FULL_NAME,   " +
        "        null,  " +
        "        y.BIRTH_DT,   " +
        "        null,  " +
        "        null,  " +
        "        null, " +
        "        null, " +
        "        SEX.CODE_NM,   " +
        "        NATION.CODE_NM,  " +
        "        null,  " +
        "        null,   " +
        "        null,  " +
        "        null,   " +
        "        null,  " +
        "        D.PASSPORT_NO,   " +
        "        TO_CHAR(TO_DATE(D.FROM_DT,'YYYYMMDD'),'DD/MM/YYYY'),  " +
        "        TO_CHAR(TO_DATE(D.TO_DT,'YYYYMMDD'),'DD/MM/YYYY'),   " +
        "        E.VISA_NO, " +
        "        TO_CHAR(TO_DATE(E.FROM_DT,'YYYYMMDD'),'DD/MM/YYYY'),  " +
        "        TO_CHAR(TO_DATE(E.TO_DT,'YYYYMMDD'),'DD/MM/YYYY'), " +
        "        null,  " +
        "        null,  " +
        "        null,  " +
        "        null,  " +
        "        null, " +
        "        null,  " +
        "        null  " +
        "     FROM THR_EMPLOYEE A,TCO_ORG B,THR_WORK_GROUP C " +
        "     ,(SELECT A.CODE,A.CODE_NM FROM THR_CODE_DETAIL A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.THR_CODE_MASTER_PK=B.PK AND B.ID ='HR0024') REL " +
        "     ,(SELECT A.CODE,A.CODE_NM FROM THR_CODE_DETAIL A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.THR_CODE_MASTER_PK=B.PK AND B.ID ='HR0009') NATION " +
        "     ,(SELECT A.CODE,A.CODE_NM FROM THR_CODE_DETAIL A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND A.THR_CODE_MASTER_PK=B.PK AND B.ID ='HR0007') SEX " +
        "     ,THR_F_PASSPORT D,THR_F_VISA E,THR_FAMILY Y " +
        "     WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND A.TCO_ORG_PK=B.PK AND A.THR_WG_PK=C.PK AND y.DEL_IF=0 " +
        "     and Y.THR_EMPLOYEE_PK=A.PK AND D.DEL_IF(+)=0 AND E.DEL_IF(+)=0 AND NVL(A.NATION,'00')<>'01' " +
        "     AND Y.NATION=NATION.CODE(+) AND Y.RELATION=REL.CODE(+) AND SEX.CODE(+)=Y.SEX " +
        "     AND Y.THR_F_PASSPORT_PK=D.PK(+)  " +
        "     AND y.THR_F_VISA_PK=E.PK(+) " +
        "     AND DECODE('" + P_TEAM_PK + "','ALL','ALL',c.PK)='" + P_TEAM_PK + "' " +
        "     AND DECODE('" + P_NATION + "','ALL','ALL',A.NATION )='" + P_NATION + "' " +
        "     AND (('" + P_SEARCH_BY + "'='1' AND UPPER(A.FULL_NAME) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%') " +
        "         OR ('" + P_SEARCH_BY + "'='2' AND UPPER(A.EMP_ID) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%') " +
        "         OR ('" + P_SEARCH_BY + "'='3' AND UPPER(D.PASSPORT_NO) LIKE  '%' || UPPER('" + P_SEARCH_TEMP + "')|| '%' )) " +
        "     AND (('" + P_FROM_JOINDATE + "' IS NULL AND '" + P_TO_JOINDATE + "' IS NULL) " +
        "         OR (A.JOIN_DT BETWEEN '" + P_FROM_JOINDATE + "' AND '" + P_TO_JOINDATE + "') ) " +
        "     AND DECODE('" + P_POSITION + "','ALL','ALL',A.POS_TYPE )='" + P_POSITION + "' " +
        "     AND DECODE('" + P_SEX + "','ALL','ALL',A.SEX )='" + P_SEX + "' " +
        "     AND DECODE('" + P_STATUS + "','ALL','ALL',A.STATUS)='" + P_STATUS + "' " +
        "     AND (('" + P_FROM_LEFTDATE + "' IS NULL AND '" + P_TO_LEFTDATE + "' IS NULL) " +
        "         OR (A.LEFT_DT BETWEEN '" + P_FROM_LEFTDATE + "' AND '" + P_TO_LEFTDATE + "') ) " +
        "      AND (('" + P_FROM_BIRTHDATE + "' IS NULL AND '" + P_TO_BIRTHDATE + "' IS NULL) " +
        "         OR (DECODE(LENGTH(A.BIRTH_DT),4,A.BIRTH_DT || '0101',A.BIRTH_DT) BETWEEN '" + P_FROM_BIRTHDATE + "' AND '" + P_TO_BIRTHDATE + "') ) " +
        "      AND (   A.TCO_ORG_PK IN ( " +
        "                              SELECT     G.PK " +
        "                                    FROM TCO_ORG G " +
        "                                   WHERE G.DEL_IF = 0 " +
        "                              START WITH G.PK = " +
        "                                            DECODE ('" + P_TCO_ORG_PK + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + P_TCO_ORG_PK + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR G.PK = G.P_PK) " +
        "                        OR '" + P_TCO_ORG_PK + "' = 'ALL') " +
        "      ORDER BY COMPARE,relation desc " ;

	
	//Response.Write(SQL);
//	Response.End();
	
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }    
    
   
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_foreigner_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_foreigner_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_foreigner_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>truong</o:LastAuthor>
  <o:LastPrinted>2011-09-07T03:58:45Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2011-09-07T03:59:12Z</o:LastSaved>
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:30.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
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
      <x:Scale>46</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveCol>14</x:ActiveCol>
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
  <x:WindowHeight>8835</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2657 style='border-collapse:
 collapse;table-layout:fixed;width:2001pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
  <col class=xl24 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=172 style='mso-width-source:userset;mso-width-alt:6290;
 width:129pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col class=xl24 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
  <col class=xl24 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl24 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl24 width=136 style='mso-width-source:userset;mso-width-alt:4973;
 width:102pt'>
 <col class=xl24 width=63 span=3 style='mso-width-source:userset;mso-width-alt:
 2304;width:47pt'>
 <col class=xl24 width=109 span=4 style='mso-width-source:userset;mso-width-alt:
 3986;width:82pt'>
 <col class=xl24 width=82 span=13 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=29 height=38 class=xl47 width=2657 style='height:28.5pt;
  width:2001pt'>FOREIGER LIST</td>
 </tr>
 
 <tr class=xl33 height=43 style='mso-height-source:userset;height:30.25pt'>
  <td height=43 class=xl31 style='height:30.25pt'>No</td>
  <td class=xl32>Plant</td>
  <td class=xl32>Department</td>
  <td class=xl32>Team/Section</td>
  <td class=xl32>Emp ID</td>
  <td class=xl32>Relation</td>
  <td class=xl32>Full Name</td>
  <td class=xl32>Join Date</td>
  <td class=xl32>Birth Date</td>
  <td class=xl32>Telephone</td>
  <td class=xl32>Email</td>
  <td class=xl32>Job Title</td>
  <td class=xl32>Current Addr</td>
  <td class=xl32>Sex</td>
  <td class=xl32>Nation</td>
  <td class=xl32>Position</td>
  <td class=xl32>Status</td>
  <td class=xl32>Left Date</td>
  <td class=xl32>Resignation Type</td>
  <td class=xl32>Pit Tax No</td>
  <td colspan=3 class=xl45 style='border-left:none'>Passport</td>
  <td colspan=3 class=xl45 style='border-left:none'>Visa/Residence</td>
  <td colspan=3 class=xl45 style='border-left:none'>Working Permit</td>
  <td colspan=4 class=xl45 style='border-left:none'>Rental House</td>
 </tr>
 <tr class=xl33 height=43 style='mso-height-source:userset;height:30.25pt'>
  <td height=43 class=xl34 style='height:30.25pt'>STT</td>
  <td class=xl35></td>
  <td class=xl35>Bộ phận</td>
  <td class=xl35>Nhóm</td>
  <td class=xl35>Mã NV</td>
  <td class=xl35>Quan hệ</td>
  <td class=xl35>Họ và tên</td>
  <td class=xl35>Ngày vào</td>
  <td class=xl35>Ngày sinh</td>
  <td class=xl35>Điện thoại</td>
  <td class=xl35>Mail</td>
  <td class=xl35>Công việc</td>
  <td class=xl35>Địa chỉ</td>
  <td class=xl35>Giới tính</td>
  <td class=xl35>Quốc gia</td>
  <td class=xl35>Chức vụ</td>
  <td class=xl35>Trạng thái</td>
  <td class=xl35>Ngày nghỉ</td>
  <td class=xl35>Lý do</td>
  <td class=xl35>Mã số thuế</td>
  <td class=xl35>Number</td>
  <td class=xl35>Issue Date</td>
  <td class=xl35>Expiry Date</td>
  <td class=xl35>Number</td>
  <td class=xl35>Issue Date</td>
  <td class=xl35>Expiry Date</td>
  <td class=xl35>Number</td>
  <td class=xl35>Issue Date</td>
  <td class=xl35>Expiry Date</td>
  <td class=xl35>Rental Amt.</td>
  <td class=xl35>Deposit Amt.</td>
  <td class=xl35>Issue Date</td>
  <td class=xl35>Expiry Date</td>
 </tr>
 <%
    int i;
	for (i=0;i<irow_emp;i++)
    {	
		
  %>
 <tr class=xl40 height=68 style='mso-height-source:userset;height:30.0pt'>
  <td height=68 class=xl36 style='height:30.0pt' x:num><%=i+1 %></td>
  <% 
    for (int k=1;k<icol_emp;k++)
    {
        
   %>
  <td class=xl37><%=dt_Emp.Rows[i][k].ToString() %></td>
  <%} %>
 </tr>
 <%} %>
 <tr class=xl40 height=68 style='mso-height-source:userset;height:12.75pt'>
  <td height=68 class=xl41 style='height:12.75pt' x:num>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl44 x:num>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=172 style='width:129pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=136 style='width:102pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
