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
    
    string p_tco_org,p_pos_type,p_search,p_input,p_from,p_to;


    p_tco_org = Request["l_tco_org_pk"].ToString();
    p_pos_type = Request["l_pos_type"].ToString();
    p_search = Request["l_search"].ToString();
    p_input = Request["l_input"].ToString();
    p_from = Request["l_from"].ToString();
    p_to = Request["l_to"].ToString();
    
    string SQL
      = "SELECT A.PK  " +   //0
          "            , A.THR_EMP_PK " +   //1
          "            , A.EMP_ID  " +      //2
          "            , A.FULL_NAME " +    //3
          "            , (SELECT B.ORG_NM FROM TCO_ORG B WHERE B.DEL_IF=0 AND A.TCO_ORG_PK= B.PK) AS ORG_NM " +  //4
          "            , (SELECT CODE_NM FROM VHR_HR_CODE  WHERE ID= 'HR0008' AND CODE= A.POS_TYPE ) " +     //5
          "            , TO_CHAR(TO_DATE(A.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY') " +      //6
          "            , TRUNC((TO_DATE(A.ISSUE_DT,'YYYYMMDD') -TO_DATE(A.JOIN_DT,'YYYYMMDD'))/365) AS YEAR  " +    //7
          "            , ROUND(((TO_DATE(A.ISSUE_DT,'YYYYMMDD') -TO_DATE(A.JOIN_DT,'YYYYMMDD'))/365 - trunc((TO_DATE(A.ISSUE_DT,'YYYYMMDD') -TO_DATE(A.JOIN_DT,'YYYYMMDD'))/365))*12,2) AS MONTH " +    //8
          "            ,A.GRADE " +    //9
          "            ,TO_CHAR(TO_DATE(A.ISSUE_DT,'YYYYMMDD'),'DD/MM/YYYY') " +      //10
          "            ,A.SALARY_OLD " +        //11
          "            ,A.INCREASE_SAL_1 " +    //12
          "            ,A.INCREASE_SAL_2 " +    //13
          "            ,A.INC_TOTAL_AMT " +     //14
          "            ,A.INC_TOTAL_PER " +     //15
          "            ,A.SALARY_NEW " +        //16
          "            ,A.REMARK " +            //17
          "            ,(SELECT C.ORG_NM FROM TCO_ORG C WHERE C.DEL_IF=0 AND NVL(B.P_PK,B.PK) = C.PK) AS ORG_NM_PK  " +  //18
          "   FROM THR_ADJUST_VHPC A, TCO_ORG B, TCO_ORG C " +
          "    WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 " +
          "        AND A.TCO_ORG_PK = B.PK AND A.TCO_ORG_PK = C.PK " +
          "        AND A.ISSUE_DT BETWEEN '"+ p_from +"' AND '"+ p_to +"' " +
          "        AND DECODE('" + p_pos_type + "', 'ALL', '" + p_pos_type + "', A.POS_TYPE) = '" + p_pos_type + "' " +
          "        AND (a.TCO_ORG_pk IN ( " +
          "                              SELECT     g.pk " +
          "                                    FROM TCO_ORG g " +
          "                                   WHERE g.del_if = 0 " +
          "                              START WITH g.pk = " +
          "                                            DECODE ('" + p_tco_org + "', " +
          "                                                    'ALL', 0, " +
          "                                                    '" + p_tco_org + "' " +
          "                                                   ) " +
          "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
          "                        OR '" + p_tco_org + "' = 'ALL') " +
          "        AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
          "                OR '" + p_input + "' IS NULL) " +
          "        ORDER BY B.P_PK, ORG_NM, A.EMP_ID ";

//Response.Write(SQL);
//Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
    icol_emp=dt_Emp.Columns.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of salary");
        Response.End();
    }

    string SQL_TOTAL_ORG
    = "SELECT    (SELECT B.ORG_NM FROM TCO_ORG B WHERE B.DEL_IF=0 AND A.TCO_ORG_PK= B.PK) AS ORG_NM  " +
        "            ,SUM(NVL(A.SALARY_OLD,0))  " +
        "            ,SUM(NVL(A.INCREASE_SAL_1,0))  " +
        "            ,SUM(NVL(A.INCREASE_SAL_2,0))  " +
        "            ,SUM(NVL(A.INC_TOTAL_AMT,0))  " +
        "            ,SUM(NVL(A.INC_TOTAL_PER,0))  " +
        "            ,SUM(NVL(A.SALARY_NEW,0))    " +
        "   FROM THR_ADJUST_VHPC A, TCO_ORG B, TCO_ORG C  " +
        "    WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
        "        AND A.TCO_ORG_PK = B.PK AND A.TCO_ORG_PK = C.PK  " +
        "        AND A.ISSUE_DT BETWEEN '"+ p_from +"' AND '"+ p_to +"'  " +
        "        AND (a.TCO_ORG_pk IN ( " +
          "                              SELECT     g.pk " +
          "                                    FROM TCO_ORG g " +
          "                                   WHERE g.del_if = 0 " +
          "                              START WITH g.pk = " +
          "                                            DECODE ('" + p_tco_org + "', " +
          "                                                    'ALL', 0, " +
          "                                                    '" + p_tco_org + "' " +
          "                                                   ) " +
          "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
          "                        OR '" + p_tco_org + "' = 'ALL') " +
        "        AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                OR '" + p_input + "' IS NULL) " +
        "        GROUP BY A.TCO_ORG_PK, B.P_PK " +
        "        ORDER BY B.P_PK, ORG_NM ";

    DataTable dt_Total_org = ESysLib.TableReadOpen(SQL_TOTAL_ORG);
    int irow_org, icol_org;
    irow_org = dt_Total_org.Rows.Count;
    icol_org = dt_Total_org.Columns.Count;
    
    //---------------------

    string SQL_TOTAL_DEPT
    = "SELECT      NVL(B.P_PK,B.PK) " +
        "            ,SUM(NVL(A.SALARY_OLD,0))  " +
        "            ,SUM(NVL(A.INCREASE_SAL_1,0))  " +
        "            ,SUM(NVL(A.INCREASE_SAL_2,0))  " +
        "            ,SUM(NVL(A.INC_TOTAL_AMT,0))  " +
        "            ,SUM(NVL(A.INC_TOTAL_PER,0))  " +
        "            ,SUM(NVL(A.SALARY_NEW,0))    " +
        "   FROM THR_ADJUST_VHPC A, TCO_ORG B, TCO_ORG C  " +
        "    WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
        "        AND A.TCO_ORG_PK = B.PK AND A.TCO_ORG_PK = C.PK  " +
        "        AND A.ISSUE_DT BETWEEN '"+ p_from +"' AND '"+ p_to +"'  " +
         "        AND (a.TCO_ORG_pk IN ( " +
          "                              SELECT     g.pk " +
          "                                    FROM TCO_ORG g " +
          "                                   WHERE g.del_if = 0 " +
          "                              START WITH g.pk = " +
          "                                            DECODE ('" + p_tco_org + "', " +
          "                                                    'ALL', 0, " +
          "                                                    '" + p_tco_org + "' " +
          "                                                   ) " +
          "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
          "                        OR '" + p_tco_org + "' = 'ALL') " +
        "        AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                OR '" + p_input + "' IS NULL) " +
        "        GROUP BY NVL(B.P_PK,B.PK) " +
        "        ORDER BY NVL(B.P_PK,B.PK) ";

    DataTable dt_Total_dept = ESysLib.TableReadOpen(SQL_TOTAL_DEPT);
    int irow_dept, icol_dept;
    irow_dept = dt_Total_dept.Rows.Count;
    icol_dept = dt_Total_dept.Columns.Count;

    //---------------------

    string SQL_TOTAL
    = "SELECT      'Total' " +
        "            ,SUM(NVL(A.SALARY_OLD,0))  " +
        "            ,SUM(NVL(A.INCREASE_SAL_1,0))  " +
        "            ,SUM(NVL(A.INCREASE_SAL_2,0))  " +
        "            ,SUM(NVL(A.INC_TOTAL_AMT,0))  " +
        "            ,SUM(NVL(A.INC_TOTAL_PER,0))  " +
        "            ,SUM(NVL(A.SALARY_NEW,0))    " +
        "            ,MAX(TO_CHAR(TO_DATE(a.ISSUE_DT,'YYYYMMDD'),'DD MONTH YYYY'))     " +
        "   FROM THR_ADJUST_VHPC A, TCO_ORG B, TCO_ORG C  " +
        "    WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0  " +
        "        AND A.TCO_ORG_PK = B.PK AND A.TCO_ORG_PK = C.PK  " +
        "        AND A.ISSUE_DT BETWEEN '" + p_from + "' AND '" + p_to + "'  " +
         "        AND (a.TCO_ORG_pk IN ( " +
          "                              SELECT     g.pk " +
          "                                    FROM TCO_ORG g " +
          "                                   WHERE g.del_if = 0 " +
          "                              START WITH g.pk = " +
          "                                            DECODE ('" + p_tco_org + "', " +
          "                                                    'ALL', 0, " +
          "                                                    '" + p_tco_org + "' " +
          "                                                   ) " +
          "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
          "                        OR '" + p_tco_org + "' = 'ALL') " +
        "        AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                OR '" + p_input + "' IS NULL) " ;
      
    DataTable dt_Total = ESysLib.TableReadOpen(SQL_TOTAL);
    
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_salary_adjust_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_salary_adjust_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_salary_adjust_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HR_PHU</o:Author>
  <o:LastAuthor>Convert</o:LastAuthor>
  <o:LastPrinted>2011-01-14T03:48:46Z</o:LastPrinted>
  <o:Created>2011-01-10T07:22:54Z</o:Created>
  <o:LastSaved>2011-01-14T03:52:47Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:RelyOnVML/>
  <o:AllowPNG/>
 </o:OfficeDocumentSettings>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .5in .75in .5in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
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
.style58
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
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal 2";}
.style59
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal_Production line";}
.style60
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet1;}
.style61
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal_Sheet3;}
.style62
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
	mso-style-name:"Normal_Shrimp & Acc\.";}
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
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl73
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl74
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style58;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl78
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl79
	{mso-style-parent:style58;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl80
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl81
	{mso-style-parent:style61;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl82
	{mso-style-parent:style61;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style61;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl84
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl88
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0000_\)\;_\(* \\\(\#\,\#\#0\.0000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl89
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl92
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl93
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl94
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl95
	{mso-style-parent:style58;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl96
	{mso-style-parent:style58;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl97
	{mso-style-parent:style58;
	color:windowtext;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl98
	{mso-style-parent:style58;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl99
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl100
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl101
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl102
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl103
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl104
	{mso-style-parent:style61;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl105
	{mso-style-parent:style60;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:normal;}
.xl106
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl107
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl109
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
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
	white-space:normal;}
.xl110
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
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
	white-space:normal;}
.xl111
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl112
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl113
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl114
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl115
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl116
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl117
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl118
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl119
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl120
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl121
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl122
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl123
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl124
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl125
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl126
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl127
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl128
	{mso-style-parent:style59;
	color:windowtext;
	font-size:8.0pt;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl129
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl130
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl131
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl132
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl133
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl134
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl135
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl136
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl137
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl138
	{mso-style-parent:style61;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl139
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl141
	{mso-style-parent:style58;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl142
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl143
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl144
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl145
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl146
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl147
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl148
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl149
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl150
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl151
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl152
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl153
	{mso-style-parent:style58;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl154
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl155
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl156
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl157
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl158
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl159
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
.xl160
	{mso-style-parent:style58;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
.xl161
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;}
.xl162
	{mso-style-parent:style62;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl163
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl164
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl165
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl166
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;}
.xl167
	{mso-style-parent:style58;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;}
.xl168
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;}
.xl169
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl170
	{mso-style-parent:style60;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:black none;
	white-space:normal;}
.xl171
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl172
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl173
	{mso-style-parent:style58;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl174
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl175
	{mso-style-parent:style60;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:black none;
	white-space:normal;}
.xl176
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0000_\)\;_\(* \\\(\#\,\#\#0\.0000\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl177
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl178
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl179
	{mso-style-parent:style60;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:black none;
	white-space:normal;}
.xl180
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl181
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl182
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl183
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl184
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl185
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl186
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl187
	{mso-style-parent:style58;
	color:windowtext;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl188
	{mso-style-parent:style58;
	color:windowtext;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl189
	{mso-style-parent:style58;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;}
.xl190
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>form </x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>86</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
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
  <x:WindowHeight>11640</x:WindowHeight>
  <x:WindowWidth>18975</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl72>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1108 style='border-collapse:
 collapse;table-layout:fixed;width:833pt'>
 <col class=xl72 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl72 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl72 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl72 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl72 width=64 span=2 style='width:48pt'>
 <col class=xl72 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:0'>
 <col class=xl72 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2194'>
 <col class=xl143 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl155 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl143 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl72 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl72 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2633'>
 <col class=xl143 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl143 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl143 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl155 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl143 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl72 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl72 width=29 style='height:15.0pt;width:22pt'></td>
  <td class=xl72 width=53 style='width:40pt'></td>
  <td class=xl72 width=120 style='width:90pt'></td>
  <td class=xl72 width=78 style='width:59pt'></td>
  <td class=xl72 width=64 style='width:48pt'></td>
  <td class=xl72 width=64 style='width:48pt'></td>
  <td class=xl72 width=0></td>
  <td class=xl72 width=0></td>
  <td width=60 style='width:45pt' align=left valign=top><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1026" type="#_x0000_t75"
   style='position:absolute;margin-left:0;margin-top:3.75pt;width:152.25pt;
   height:38.25pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_salary_adjust_files/image001.png" o:title=""/>
   <!--[if mso]><x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:Anchor>
     6, 12, 0, 5, 11, 7, 2, 16</x:Anchor>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
   <![endif]--></v:shape><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl143 width=60 style='height:15.0pt;width:45pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl155 width=60 style='width:45pt'></td>
  <td class=xl143 width=76 style='width:57pt'></td>
  <td class=xl72 width=51 style='width:38pt'></td>
  <td class=xl72 width=0></td>
  <td class=xl143 width=77 style='width:58pt'></td>
  <td class=xl143 width=79 style='width:59pt'></td>
  <td class=xl143 width=77 style='width:58pt'></td>
  <td class=xl155 width=56 style='width:42pt'></td>
  <td class=xl143 width=102 style='width:77pt'></td>
  <td class=xl72 width=62 style='width:47pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=8 class=xl72 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl143></td>
  <td class=xl155></td>
  <td class=xl143></td>
  <td colspan=2 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl143 style='mso-ignore:colspan'></td>
  <td class=xl155></td>
  <td class=xl143></td>
  <td class=xl72></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=8 class=xl72 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl143></td>
  <td class=xl155></td>
  <td class=xl143></td>
  <td colspan=2 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl143 style='mso-ignore:colspan'></td>
  <td class=xl155></td>
  <td class=xl143></td>
  <td class=xl72></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=19 height=32 class=xl190 style='height:24.0pt'
  x:str="POSCO VIETNAM PROCESSING CENTER CO., LTD ">POSCO VIETNAM PROCESSING
  CENTER CO., LTD<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=8 class=xl72 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl143></td>
  <td class=xl155></td>
  <td class=xl143></td>
  <td colspan=2 class=xl72 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl143 style='mso-ignore:colspan'></td>
  <td class=xl155></td>
  <td class=xl143></td>
  <td class=xl72></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=19 height=34 class=xl188 style='height:25.5pt'>ADJUST<span
  style='mso-spacerun:yes'>  </span>SALARY<span style='mso-spacerun:yes'> 
  </span>FOR<span style='mso-spacerun:yes'>  </span>EMPLOYEE<span
  style='mso-spacerun:yes'>  </span></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td colspan=19 height=31 class=xl189 style='height:23.25pt'>Effective Date <%=dt_Total.Rows[0][7].ToString()%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl73 style='height:15.0pt'></td>
  <td class=xl74></td>
  <td class=xl75></td>
  <td class=xl76></td>
  <td class=xl75></td>
  <td class=xl74></td>
  <td colspan=2 class=xl77 style='mso-ignore:colspan'></td>
  <td class=xl144></td>
  <td class=xl147></td>
  <td class=xl134></td>
  <td class=xl74></td>
  <td class=xl78></td>
  <td class=xl134></td>
  <td class=xl144></td>
  <td class=xl141></td>
  <td class=xl153></td>
  <td class=xl141></td>
  <td class=xl79></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td rowspan=3 height=79 class=xl106 width=29 style='border-bottom:.5pt solid black;
  height:59.25pt;width:22pt'>No.</td>
  <td rowspan=3 class=xl106 width=53 style='border-bottom:.5pt solid black;
  width:40pt'>Emp ID</td>
  <td rowspan=3 class=xl122 width=120 style='border-bottom:.5pt solid black;
  width:90pt'>Full Name</td>
  <td rowspan=3 class=xl125 width=78 style='border-bottom:.5pt solid black;
  width:59pt'>Department</td>
  <td rowspan=3 class=xl106 width=64 style='border-bottom:.5pt solid black;
  width:48pt'>Position</td>
  <td rowspan=3 class=xl119 width=64 style='border-bottom:.5pt solid black;
  width:48pt'>Hire Date</td>
  <td colspan=2 class=xl117 width=0 style='border-right:.5pt solid black;
  border-left:none'>Increased Last Year 01/01/2009</td>
  <td class=xl145 width=60 style='border-left:none;width:45pt'>&nbsp;</td>
  <td class=xl148 width=60 style='width:45pt'>&nbsp;</td>
  <td rowspan=3 class=xl135 width=76 style='border-bottom:.5pt solid black;
  width:57pt' x:str="Current Basic Salary"><span
  style='mso-spacerun:yes'> </span>Current Basic Salary<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl106 width=51 style='border-bottom:.5pt solid black;
  width:38pt' x:str="Grade ">Grade<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl106 width=0 style='border-bottom:.5pt solid black'>Ranking</td>
  <td colspan=4 rowspan=2 class=xl111 width=289 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:217pt'>Basic Salary Increased</td>
  <td rowspan=3 class=xl135 width=102 style='border-bottom:.5pt solid black;
  width:77pt' x:str="Salary After Increased (New basic salary)"><span
  style='mso-spacerun:yes'> </span>Salary After Increased (New basic
  salary)<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl106 width=62 style='border-bottom:.5pt solid black;
  width:47pt' x:str="Note ">Note<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td rowspan=2 height=56 class=xl109 width=0 style='border-bottom:.5pt solid black;
  height:42.0pt' x:str="Salary Increased ">Salary Increased<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl109 width=0 style='border-bottom:.5pt solid black'
  x:str="Special ">Special<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl114 width=120 style='border-right:.5pt solid black;
  border-left:none;width:90pt'>Year of<span style='mso-spacerun:yes'> 
  </span>Working</td>
 </tr>
 <tr height=44 style='mso-height-source:userset;height:33.0pt'>
  <td height=44 class=xl137 width=60 style='height:33.0pt;border-left:none;
  width:45pt' x:str="Year"><span style='mso-spacerun:yes'> </span>Year<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl149 width=60 style='border-left:none;width:45pt' x:str="Month"><span
  style='mso-spacerun:yes'> </span>Month<span style='mso-spacerun:yes'> </span></td>
  <td class=xl156 width=77 style='width:58pt' x:str="Increased (%) "><span
  style='mso-spacerun:yes'> </span>Increased (%)<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl156 width=79 style='width:59pt' x:str="Increased (Amt)"><span
  style='mso-spacerun:yes'> </span>Increased (Amt)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl162 width=77 style='border-left:none;width:58pt'
  x:str="Total (Amt)"><span style='mso-spacerun:yes'> </span>Total (Amt)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl149 width=56 style='width:42pt' x:str="Total (%)"><span
  style='mso-spacerun:yes'> </span>Total (%)<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
  <%
     int i = 0;
     int m = 0, n = 0;
	 int count =1;
	 Boolean flag_pk = true;
     Boolean flag_pk2 = false;
     Boolean flag_org = false;
	 
              
	 string pk_old, pk_new ;
     string org_old, org_new;
     for (i = 0; i < irow_emp; i++)
     {
        
         pk_old = dt_Emp.Rows[i][18].ToString();  // luu dữ liêu dept_pk
         org_old = dt_Emp.Rows[i][4].ToString();  // luu dữ liệu org
         if (flag_pk)
         {
  %>
             <tr height=32 style='mso-height-source:userset;height:24.0pt'>
              <td colspan=19 height=32 class=xl169 style='border-right:.5pt solid black;
              height:24.0pt'>Department :<span style='mso-spacerun:yes'>  </span><%=dt_Emp.Rows[i][18].ToString()%></td>
             </tr>
  <%
            flag_pk = false;
         }
   %>           
             
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl80 style='height:21.75pt;border-top:none'><%= count %></td>
  <td class=xl81 width=53 style='border-top:none;border-left:none;width:40pt'><%=dt_Emp.Rows[i][2].ToString()%></td>
  <td class=xl128 width=120 style='border-top:none;border-left:none;width:90pt'><%=dt_Emp.Rows[i][3].ToString()%></td>
  <td class=xl128 width=78 style='border-top:none;border-left:none;width:59pt'><%=dt_Emp.Rows[i][4].ToString()%></td>
  <td class=xl82 width=64 style='border-top:none;border-left:none;width:48pt'><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][5].ToString()%></td>
  <td class=xl83 width=64 style='border-top:none;border-left:none;width:48pt'><%=dt_Emp.Rows[i][6].ToString()%></td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl146 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%=dt_Emp.Rows[i][7].ToString()%> </td>
  <td class=xl150 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%=dt_Emp.Rows[i][8].ToString()%> </td>
  <td class=xl138 width=76 style='border-top:none;border-left:none;width:57pt'
  x:num><span style='mso-spacerun:yes'>    </span><%=dt_Emp.Rows[i][11].ToString()%> </td>
  <td class=xl104 width=51 style='border-top:none;border-left:none;width:38pt'
  x:str><span style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span><%=dt_Emp.Rows[i][9].ToString()%></td> 
  <td class=xl85 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl157 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][12].ToString()%> </td>
  <td class=xl146 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%=dt_Emp.Rows[i][13].ToString()%></td>
  <td class=xl146 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'>       </span><%=dt_Emp.Rows[i][14].ToString()%> </td>
  <td class=xl164 style='border-top:none;border-left:none'
  x:num><span
  style='mso-spacerun:yes'>         </span><%=dt_Emp.Rows[i][15].ToString()%> </td>
  <td class=xl146 style='border-top:none;border-left:none' x:num><span style='mso-spacerun:yes'>            
  </span><%=dt_Emp.Rows[i][16].ToString()%> </td>
  <td class=xl86 style='border-top:none;border-left:none'><%=dt_Emp.Rows[i][17].ToString()%></td>
 </tr>
 <%
     count++;
     if (i < irow_emp - 1)
     {
         pk_new = dt_Emp.Rows[i + 1][18].ToString();
         if (pk_old != pk_new)  // Nếu khác Department cha 
         {
             flag_pk = true;
             flag_pk2 = true;
         }
         // kiem tra Org
         org_new = dt_Emp.Rows[i + 1][4].ToString();
         if (org_new != org_old)  // Nếu khác Org 
         {
             flag_org = true;
         }
     }
     else
     {
         flag_pk = true;
         flag_pk2 = true;
         flag_org = true;
     }
      if (flag_org == true)
      {
        
  %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl129 style='height:21.75pt;border-top:none'>&nbsp;</td>
  <td class=xl130 style='border-top:none'>TOTAL</td>
  <td class=xl133 style='border-top:none'><%=dt_Total_org.Rows[m][0].ToString()%></td>
  <td class=xl87 style='border-top:none'>&nbsp;</td>
  <td class=xl87 style='border-top:none'>&nbsp;</td>
  <td class=xl170 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl88 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'>               </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl88 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'>               </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl139 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl151 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl139 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%=dt_Total_org.Rows[m][1].ToString()%> </td>  <%--luong basic --%>
  <td class=xl105 width=51 style='border-top:none;border-left:none;width:38pt'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl158 style='border-top:none;border-left:none' x:num><%=dt_Total_org.Rows[m][2].ToString()%></td>
  <td class=xl139 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%=dt_Total_org.Rows[m][3].ToString()%> </td>
  <td class=xl139 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%=dt_Total_org.Rows[m][4].ToString()%> </td>
  <td class=xl165 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>        
  </span><%=dt_Total_org.Rows[m][5].ToString()%> </td>
  <td class=xl139 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>               </span><%=dt_Total_org.Rows[m][6].ToString()%> </td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
         m++;
         flag_org = false;
      }
      if (flag_pk2)
      {
        
  %>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl171 colspan=2 style='height:21.75pt;mso-ignore:colspan'>TOTAL</td>
  <td class=xl173 style='border-top:none'><%=dt_Emp.Rows[i][18].ToString()%></td>
  <td class=xl174 style='border-top:none'>&nbsp;</td>
  <td class=xl174 style='border-top:none'>&nbsp;</td>
  <td class=xl175 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl176 style='border-top:none' x:num="0"><span
  style='mso-spacerun:yes'>               </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl176 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'>               </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl177 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl178 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                     </span><%=dt_Total_dept.Rows[n][1].ToString()%> </td>
  <td class=xl179 width=51 style='border-top:none;border-left:none;width:38pt'>&nbsp;</td>
  <td class=xl180 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl181 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_Total_dept.Rows[n][2].ToString()%> </td>
  <td class=xl177 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%=dt_Total_dept.Rows[n][3].ToString()%></td>
  <td class=xl177 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%=dt_Total_dept.Rows[n][4].ToString()%> </td>
  <td class=xl182 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>        
  </span><%=dt_Total_dept.Rows[n][5].ToString()%> </td>
  <td class=xl177 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>               </span><%=dt_Total_dept.Rows[n][6].ToString()%> </td>
  <td class=xl183 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%     
            n++;
            flag_pk2 = false;
        }  
     }// dong for(i
  %>
 <tr class=xl72 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl184 colspan=3 style='height:21.75pt;mso-ignore:colspan'>GRAND
  TOTAL</td>
  <td class=xl174 style='border-top:none'>&nbsp;</td>
  <td class=xl174 style='border-top:none'>&nbsp;</td>
  <td class=xl186 style='border-top:none'>&nbsp;</td>
  <td class=xl187 align=right style='border-top:none' x:num></td>
  <td class=xl176 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'>               </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl177 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl178 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl177 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%=dt_Total.Rows[0][1].ToString()%> </td>
  <td class=xl180 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl180 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl181 style='border-top:none;border-left:none' x:num><%=dt_Total.Rows[0][2].ToString()%></td>
  <td class=xl177 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%=dt_Total.Rows[0][3].ToString()%> </td>
  <td class=xl177 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><%=dt_Total.Rows[0][4].ToString()%> </td>
  <td class=xl182 style='border-top:none;border-left:none'
  x:num><span style='mso-spacerun:yes'>        
  </span><%=dt_Total.Rows[0][5].ToString()%> </td>
  <td class=xl177 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>               </span><%=dt_Total.Rows[0][6].ToString()%> </td>
  <td class=xl183 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl91 style='height:15.0pt'></td>
  <td class=xl92></td>
  <td colspan=4 class=xl93 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl94 style='mso-ignore:colspan'></td>
  <td class=xl140></td>
  <td class=xl152></td>
  <td class=xl140></td>
  <td class=xl93></td>
  <td class=xl92></td>
  <td class=xl159></td>
  <td colspan=2 class=xl140 style='mso-ignore:colspan'></td>
  <td class=xl166></td>
  <td class=xl140></td>
  <td class=xl93></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl91 style='height:15.0pt'></td>
  <td class=xl92></td>
  <td colspan=4 class=xl93 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl94 style='mso-ignore:colspan'></td>
  <td class=xl140></td>
  <td class=xl152></td>
  <td class=xl140></td>
  <td class=xl93></td>
  <td class=xl92></td>
  <td class=xl159></td>
  <td colspan=2 class=xl140 style='mso-ignore:colspan'></td>
  <td class=xl166></td>
  <td class=xl140></td>
  <td class=xl93></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl95 style='height:15.0pt'></td>
  <td class=xl96></td>
  <td class=xl79></td>
  <td colspan=2 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=2 class=xl98 style='mso-ignore:colspan'></td>
  <td class=xl141></td>
  <td class=xl153></td>
  <td class=xl141></td>
  <td class=xl79></td>
  <td class=xl96></td>
  <td class=xl160></td>
  <td colspan=2 class=xl141 style='mso-ignore:colspan'></td>
  <td class=xl167></td>
  <td class=xl141></td>
  <td class=xl79></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl95 style='height:15.0pt'></td>
  <td class=xl96></td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl97></td>
  <td class=xl79></td>
  <td colspan=2 class=xl98 style='mso-ignore:colspan'></td>
  <td class=xl141></td>
  <td class=xl153></td>
  <td class=xl141></td>
  <td class=xl79></td>
  <td class=xl96></td>
  <td class=xl160></td>
  <td colspan=2 class=xl141 style='mso-ignore:colspan'></td>
  <td class=xl167></td>
  <td class=xl141></td>
  <td class=xl79></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl95 style='height:15.0pt'></td>
  <td class=xl96></td>
  <td class=xl79></td>
  <td colspan=2 class=xl97 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td colspan=2 class=xl98 style='mso-ignore:colspan'></td>
  <td class=xl141></td>
  <td class=xl153></td>
  <td class=xl141></td>
  <td class=xl79></td>
  <td class=xl96></td>
  <td class=xl160></td>
  <td colspan=2 class=xl141 style='mso-ignore:colspan'></td>
  <td class=xl167></td>
  <td class=xl141></td>
  <td class=xl79></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl99 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Issued
  by <span style='display:none'>………………………………………………</span></td>
  <td class=xl72></td>
  <td class=xl101></td>
  <td colspan=2 class=xl100 style='mso-ignore:colspan'></td>
  <td class=xl100>Reviewed by :…………………………………………………….</td>
  <td class=xl102></td>
  <td class=xl142 colspan=6 style='mso-ignore:colspan'
  x:str="Checked by……………………………."><span style='mso-spacerun:yes'> </span>Checked
  by…………………………….<span style='mso-spacerun:yes'> </span></td>
  <td class=xl142 colspan=5 style='mso-ignore:colspan'
  x:str="Approval by ………………………………………….."><span
  style='mso-spacerun:yes'> </span>Approval by …………………………………………..<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl79 style='height:15.75pt'></td>
  <td class=xl102><span style='mso-spacerun:yes'>  </span>……<span
  style='display:none'>……./………………./ 20………..</span></td>
  <td class=xl72></td>
  <td class=xl93></td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl98></td>
  <td class=xl102><span style='mso-spacerun:yes'>  </span>…………./………………./
  20………..</td>
  <td class=xl142></td>
  <td class=xl154></td>
  <td class=xl142 colspan=5 style='mso-ignore:colspan'
  x:str="  …………./………………./ 20……….."><span style='mso-spacerun:yes'>  
  </span>…………./………………./ 20………..<span style='mso-spacerun:yes'> </span></td>
  <td class=xl142 colspan=4 style='mso-ignore:colspan'
  x:str="  …………./………………./ 20……….."><span style='mso-spacerun:yes'>  
  </span>…………./………………./ 20………..<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=120 style='width:90pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=60 style='width:45pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=0></td>
  <td width=77 style='width:58pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=62 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
