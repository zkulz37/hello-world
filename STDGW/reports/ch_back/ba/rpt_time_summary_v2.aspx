<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
     string p_user,p_tco_org_pk,p_wg,p_from,p_to;
    string p_thr_ws_pk,p_search,p_input,p_opt,p_opt_text,p_m1,p_m2,p_nation;
     
  
    p_tco_org_pk       = Request["p_tco_org_pk"].ToString();
    p_wg                = Request["p_wg"].ToString();
    p_from              = Request["p_from"].ToString();
    p_to                = Request["p_to"].ToString();
    p_thr_ws_pk        = Request["p_thr_ws_pk"].ToString();
    p_search            = Request["p_search"].ToString();
    p_input             = Request["p_input"].ToString();
    p_user              = Request["p_user"].ToString();
    p_opt               = Request["p_opt"].ToString();
    p_opt_text          = Request["p_opt_text"].ToString();
    p_m1               = Request["p_m1"].ToString();
    p_m2          = Request["p_m2"].ToString();
	p_nation          = Request["p_nation"].ToString();
    string SQL;
    if (p_opt=="5")
    {
	    SQL= "SELECT     TO_CHAR(SYSDATE,'DD/MM/YYYY') " + 
        "            ,F.org_NM " +
        "            ,B.workgroup_NM " +
        "            ,A.EMP_ID " +
        "            ,A.FULL_NAME " +
        "            ,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "            ,C.REMARK " +
        "            ,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ,MAX(DECODE(E.OT_TYPE,'OT',NVL(E.OT_TIME,0),0)) AS OT " +
        "            ,MAX(DECODE(E.OT_TYPE,'HT',NVL(E.OT_TIME,0),0)) AS HT " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT',NVL(E.OT_TIME,0),0)) AS NT " +
        "           ,(case when MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) >=0 then NULL " + 
        "       else " +
        "           ABS(MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK))) " +
        "     END ) " +
        "        AS LATE_IN " +
        ",(case when MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) >=0 then null " +
        "    else " +
        "        abs(MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK))) " +
        "  end)   AS EARLY_OUT "  +
        "         ,MAX(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y'))) mod_yn " +
        "         ,MAX(DECODE(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y')),'Y',nvl(NVL(D.MOD_BY,E.CRT_BY),d.crt_by),NULL)) mod_by " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT2',NVL(E.OT_TIME,0),0)) AS NT2 " +
        "            FROM THR_EMPLOYEE A,THR_work_group B, THR_WORK_SHIFT C,THR_TIME_MACHINE D,THR_EXTRA_TIME E,tco_org F " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND E.DEL_IF(+)=0 AND F.DEL_IF=0 " +
        "            AND A.THR_wg_PK=B.PK AND A.PK=D.THR_EMP_PK AND C.PK=D.THR_WS_PK AND A.TCO_org_PK=F.PK " +
        "            AND D.THR_EMP_PK=E.THR_EMP_PK(+) AND D.WORK_DT=E.WORK_DT(+) " +
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND  '" + p_to + "' " +
        "            AND DECODE('" + p_wg + "' ,'ALL', '" + p_wg + "',B.PK) =  '" + p_wg  + "'" +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation  + "'" +
        "            AND DECODE('" + p_thr_ws_pk + "','ALL', '" + p_thr_ws_pk + "',C.PK)= '" + p_thr_ws_pk + "' " ;
        SQL = SQL + "                   AND (    A.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";                           
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('"+p_tco_org_pk+"', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '"+p_tco_org_pk+"' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '"+p_tco_org_pk+"' = 'ALL') "+     
        "            AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL) " +
        "            GROUP BY F.org_NM,B.workGROUP_NM,D.WORK_DT,A.EMP_ID,A.FULL_NAME,C.REMARK,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ORDER BY F.org_NM,B.workGROUP_NM,D.WORK_DT,A.EMP_ID ";        
	}
    else if (p_opt=="1")
	{
        SQL= "SELECT     TO_CHAR(SYSDATE,'DD/MM/YYYY') " + 
        "            ,F.org_NM " +
        "            ,B.workGROUP_NM " +
        "            ,A.EMP_ID " +
        "            ,A.FULL_NAME " +
        "            ,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "            ,C.REMARK " +
        "            ,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ,MAX(DECODE(E.OT_TYPE,'OT',NVL(E.OT_TIME,0),0)) AS OT " +
        "            ,MAX(DECODE(E.OT_TYPE,'HT',NVL(E.OT_TIME,0),0)) AS HT " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT',NVL(E.OT_TIME,0),0)) AS NT " +
        "           ,(case when MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) >=0 then NULL " + 
        "       else " +
        "           ABS(MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK))) " +
        "     END ) " +
        "        AS LATE_IN " +
        ",(case when MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) >=0 then null " +
        "    else " +
        "        abs(MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK))) " +
        "  end)   AS EARLY_OUT "  +
        "         ,MAX(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y'))) mod_yn " +
        "         ,MAX(DECODE(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y')),'Y',nvl(NVL(D.MOD_BY,E.CRT_BY),d.crt_by),NULL)) mod_by " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT2',NVL(E.OT_TIME,0),0)) AS NT2 " +
        "            FROM THR_EMPLOYEE A,THR_work_GROUP B, THR_WORK_SHIFT C,THR_TIME_MACHINE D,THR_EXTRA_TIME E,tco_org F " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND E.DEL_IF(+)=0 AND F.DEL_IF=0 " +
        "            AND A.THR_wg_PK=B.PK AND A.PK=D.THR_EMP_PK AND C.PK=D.THR_WS_PK AND A.TCO_org_PK=F.PK " +
        "            AND D.THR_EMP_PK=E.THR_EMP_PK(+) AND D.WORK_DT=E.WORK_DT(+) " +
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND  '" + p_to + "' " +
        "            AND DECODE('" + p_wg + "' ,'ALL', '" + p_wg + "',B.PK) =  '" + p_wg  + "'" +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation  + "'" +
        "            AND DECODE('" + p_thr_ws_pk + "','ALL', '" + p_thr_ws_pk + "',C.PK)= '" + p_thr_ws_pk + "' " ;
        SQL = SQL + "                   AND (    A.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";                           
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('"+p_tco_org_pk+"', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '"+p_tco_org_pk+"' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '"+p_tco_org_pk+"' = 'ALL') "+ 
        "            AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL) " +
        "            AND (D.TIME_IN IS NULL OR D.TIME_OUT IS NULL)          " +
        "            GROUP BY F.org_NM,B.workGROUP_NM,D.WORK_DT,A.EMP_ID,A.FULL_NAME,C.REMARK,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ORDER BY F.org_NM,B.workGROUP_NM,D.WORK_DT,A.EMP_ID " ;
	}
   else if (p_opt=="2")
   {
        SQL= "SELECT     TO_CHAR(SYSDATE,'DD/MM/YYYY') " + 
        "            ,F.ORG_NM " +
        "            ,B.WORKGROUP_NM " +
        "            ,A.EMP_ID " +
        "            ,A.FULL_NAME " +
        "            ,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "            ,C.REMARK " +
        "            ,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ,MAX(DECODE(E.OT_TYPE,'OT',NVL(E.OT_TIME,0),0)) AS OT " +
        "            ,MAX(DECODE(E.OT_TYPE,'HT',NVL(E.OT_TIME,0),0)) AS HT " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT',NVL(E.OT_TIME,0),0)) AS NT " +
        "           ,(case when MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) >=0 then NULL " + 
        "       else " +
        "           ABS(MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK))) " +
        "     END ) " +
        "        AS LATE_IN " +
        ",(case when MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) >=0 then null " +
        "    else " +
        "        abs(MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK))) " +
        "  end)   AS EARLY_OUT "  +
        "         ,MAX(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y'))) mod_yn " +
        "         ,MAX(DECODE(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y')),'Y',nvl(NVL(D.MOD_BY,E.CRT_BY),d.crt_by),NULL)) mod_by " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT2',NVL(E.OT_TIME,0),0)) AS NT2 " +
        "            FROM THR_EMPLOYEE A,THR_WORK_GROUP B, THR_WORK_SHIFT C,THR_TIME_MACHINE D,THR_EXTRA_TIME E,tco_org F " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND E.DEL_IF(+)=0 AND F.DEL_IF=0 " +
        "            AND A.THR_WG_PK=B.PK AND A.PK=D.THR_EMP_PK AND C.PK=D.THR_WS_PK AND A.TCO_ORG_PK=F.PK " +
        "            AND D.THR_EMP_PK=E.THR_EMP_PK(+) AND D.WORK_DT=E.WORK_DT(+) " +
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND  '" + p_to + "' " +
        "            AND DECODE('" + p_wg + "' ,'ALL', '" + p_wg + "',B.PK) =  '" + p_wg  + "'" +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation  + "'" +
        "            AND DECODE('" + p_thr_ws_pk + "','ALL', '" + p_thr_ws_pk + "',C.PK)= '" + p_thr_ws_pk + "' " ;
        SQL = SQL + "                   AND (    A.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";                           
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('"+p_tco_org_pk+"', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '"+p_tco_org_pk+"' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '"+p_tco_org_pk+"' = 'ALL') "+ 
        "            AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL) " +
        "           AND (HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK) < 0  )  " +
        "       AND (Abs(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) >= '" + p_m1 + "' OR '" + p_m1 + "' is null) " + 
        "       AND (Abs(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) <= '" + p_m2 + "' OR '" + p_m2 + "' is null) " +
        "            GROUP BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID,A.FULL_NAME,C.REMARK,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ORDER BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID " ;
		
       
	}
   else if (p_opt=="3")
   {
        SQL= "SELECT     TO_CHAR(SYSDATE,'DD/MM/YYYY') " + 
        "            ,F.ORG_NM " +
        "            ,B.WORKGROUP_NM " +
        "            ,A.EMP_ID " +
        "            ,A.FULL_NAME " +
        "            ,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "            ,C.REMARK " +
        "            ,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ,MAX(DECODE(E.OT_TYPE,'OT',NVL(E.OT_TIME,0),0)) AS OT " +
        "            ,MAX(DECODE(E.OT_TYPE,'HT',NVL(E.OT_TIME,0),0)) AS HT " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT',NVL(E.OT_TIME,0),0)) AS NT " +
        "           ,(case when MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) >=0 then NULL " + 
        "       else " +
        "           ABS(MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK))) " +
        "     END ) " +
        "        AS LATE_IN " +
        ",(case when MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) >=0 then null " +
        "    else " +
        "        abs(MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK))) " +
        "  end)   AS EARLY_OUT "  +
        "         ,MAX(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y'))) mod_yn " +
        "         ,MAX(DECODE(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y')),'Y',nvl(NVL(D.MOD_BY,E.CRT_BY),d.crt_by),NULL)) mod_by " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT2',NVL(E.OT_TIME,0),0)) AS NT2 " +
        "            FROM THR_EMPLOYEE A,THR_WORK_GROUP B, THR_WORK_SHIFT C,THR_TIME_MACHINE D,THR_EXTRA_TIME E,tco_org F " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND E.DEL_IF(+)=0 AND F.DEL_IF=0 " +
        "            AND A.THR_WG_PK=B.PK AND A.PK=D.THR_EMP_PK AND C.PK=D.THR_WS_PK AND A.TCO_ORG_PK=F.PK " +
        "            AND D.THR_EMP_PK=E.THR_EMP_PK(+) AND D.WORK_DT=E.WORK_DT(+) " +
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND  '" + p_to + "' " +
        "            AND DECODE('" + p_wg + "' ,'ALL', '" + p_wg + "',B.PK) =  '" + p_wg  + "'" +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation  + "'" +
        "            AND DECODE('" + p_thr_ws_pk + "','ALL', '" + p_thr_ws_pk + "',C.PK)= '" + p_thr_ws_pk + "' " ;
       SQL = SQL + "                   AND (    A.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";                           
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('"+p_tco_org_pk+"', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '"+p_tco_org_pk+"' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '"+p_tco_org_pk+"' = 'ALL') "+ 
        "            AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL) " +
	    "              AND (HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK) < 0 )             " + 
        "       AND (Abs(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) >= '" + p_m1 + "' OR '" + p_m1 + "' is null) " + 
        "       AND (Abs(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) <= '" + p_m2 + "' OR '" + p_m2 + "' is null) " +
        "            GROUP BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID,A.FULL_NAME,C.REMARK,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ORDER BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID " ;
	}
   else if (p_opt=="4")
   {
        SQL= "SELECT     TO_CHAR(SYSDATE,'DD/MM/YYYY') " + 
        "            ,F.ORG_NM " +
        "            ,B.WORKGROUP_NM " +
        "            ,A.EMP_ID " +
        "            ,A.FULL_NAME " +
        "            ,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "            ,C.REMARK " +
        "            ,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ,MAX(DECODE(E.OT_TYPE,'OT',NVL(E.OT_TIME,0),0)) AS OT " +
        "            ,MAX(DECODE(E.OT_TYPE,'HT',NVL(E.OT_TIME,0),0)) AS HT " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT',NVL(E.OT_TIME,0),0)) AS NT " +
        "           ,(case when MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) >=0 then NULL " + 
        "       else " +
        "           ABS(MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK))) " +
        "     END ) " +
        "        AS LATE_IN " +
        ",(case when MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) >=0 then null " +
        "    else " +
        "        abs(MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK))) " +
        "  end)   AS EARLY_OUT "  +
        "         ,MAX(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y'))) mod_yn " +
        "         ,MAX(DECODE(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y')),'Y',nvl(NVL(D.MOD_BY,E.CRT_BY),d.crt_by),NULL)) mod_by " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT2',NVL(E.OT_TIME,0),0)) AS NT2 " +
        "            FROM THR_EMPLOYEE A,THR_WORK_GROUP B, THR_WORK_SHIFT C,THR_TIME_MACHINE D,THR_EXTRA_TIME E,tco_org F " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND E.DEL_IF(+)=0 AND F.DEL_IF=0 " +
        "            AND A.THR_WG_PK=B.PK AND A.PK=D.THR_EMP_PK AND C.PK=D.THR_WS_PK AND A.TCO_ORG_PK=F.PK " +
        "            AND D.THR_EMP_PK=E.THR_EMP_PK(+) AND D.WORK_DT=E.WORK_DT(+) " +
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND  '" + p_to + "' " +
        "            AND DECODE('" + p_wg + "' ,'ALL', '" + p_wg + "',B.PK) =  '" + p_wg  + "'" +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation  + "'" +
        "            AND DECODE('" + p_thr_ws_pk + "','ALL', '" + p_thr_ws_pk + "',C.PK)= '" + p_thr_ws_pk + "' " ;
       SQL = SQL + "                   AND (    A.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";                           
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('"+p_tco_org_pk+"', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '"+p_tco_org_pk+"' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '"+p_tco_org_pk+"' = 'ALL') "+ 
        "            AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL) " +	    
		"		AND (NVL(D.MOD_BYHAND_YN,'N')='Y' OR NVL(E.MOD_BYHAND_YN,'N')='Y' " +
        "        OR NVL(D.MOD_AUTO_YN,'N')='Y' OR NVL(E.MOD_AUTO_YN,'N')='Y') " +
        "            GROUP BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID,A.FULL_NAME,C.REMARK,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +        
        "            ORDER BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID " ;
	}
    else if (p_opt=="6")
	{
        SQL= "SELECT     TO_CHAR(SYSDATE,'DD/MM/YYYY') " + 
        "            ,F.ORG_NM " +
        "            ,B.WORKGROUP_NM " +
        "            ,A.EMP_ID " +
        "            ,A.FULL_NAME " +
        "            ,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "            ,C.REMARK " +
        "            ,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ,MAX(DECODE(E.OT_TYPE,'OT',NVL(E.OT_TIME,0),0)) AS OT " +
        "            ,MAX(DECODE(E.OT_TYPE,'HT',NVL(E.OT_TIME,0),0)) AS HT " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT',NVL(E.OT_TIME,0),0)) AS NT " +
        "           ,(case when MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) >=0 then NULL " + 
        "       else " +
        "           ABS(MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK))) " +
        "     END ) " +
        "        AS LATE_IN " +
        ",(case when MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) >=0 then null " +
        "    else " +
        "        abs(MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK))) " +
        "  end)   AS EARLY_OUT "  +
        "         ,MAX(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y'))) mod_yn " +
        "         ,MAX(DECODE(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y')),'Y',nvl(NVL(D.MOD_BY,E.CRT_BY),d.crt_by),NULL)) mod_by " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT2',NVL(E.OT_TIME,0),0)) AS NT2 " +
        "            FROM THR_EMPLOYEE A,THR_WORK_GROUP B, THR_WORK_SHIFT C,THR_TIME_MACHINE D,THR_EXTRA_TIME E,tco_org F " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND E.DEL_IF(+)=0 AND F.DEL_IF=0 " +
        "            AND A.THR_WG_PK=B.PK AND A.PK=D.THR_EMP_PK AND C.PK=D.THR_WS_PK AND A.TCO_ORG_PK=F.PK " +
        "            AND D.THR_EMP_PK=E.THR_EMP_PK(+) AND D.WORK_DT=E.WORK_DT(+) " +
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND  '" + p_to + "' " +
        "            AND DECODE('" + p_wg + "' ,'ALL', '" + p_wg + "',B.PK) =  '" + p_wg  + "'" +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation  + "'" +
        "            AND DECODE('" + p_thr_ws_pk + "','ALL', '" + p_thr_ws_pk + "',C.PK)= '" + p_thr_ws_pk + "' " ;
       SQL = SQL + "                   AND (    A.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";                           
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('"+p_tco_org_pk+"', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '"+p_tco_org_pk+"' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '"+p_tco_org_pk+"' = 'ALL') "+ 
        "            AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL) " +
	    " AND (HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK) < 0  " + 
        "or HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK) < 0 ) " +
        "AND ( ( " +
        "(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK) < 0  and (abs(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) >= '" + p_m1 + "' OR  '" + p_m1 + "'  is null) " +
        "AND (abs(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) <= '" + p_m2 + "' OR '" + p_m2 + "'  is null)) " +
        ") or (  " +
        "HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)  < 0  and  (abs(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) >=  '" + p_m1 + "'  OR  '" + p_m1 + "'  is null) " +
        "AND (abs(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) <=  '" + p_m2 + "'  OR  '" + p_m2 + "'  is null) " +
        ")) " +
        "            GROUP BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID,A.FULL_NAME,C.REMARK,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ORDER BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID ";
	}
     else if (p_opt=="7")   
	 {
       SQL= "SELECT     TO_CHAR(SYSDATE,'DD/MM/YYYY') " + 
        "            ,F.ORG_NM " +
        "            ,B.WORKGROUP_NM " +
        "            ,A.EMP_ID " +
        "            ,A.FULL_NAME " +
        "            ,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "            ,C.REMARK " +
        "            ,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ,MAX(DECODE(E.OT_TYPE,'OT',NVL(E.OT_TIME,0),0)) AS OT " +
        "            ,MAX(DECODE(E.OT_TYPE,'HT',NVL(E.OT_TIME,0),0)) AS HT " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT',NVL(E.OT_TIME,0),0)) AS NT " +
        "           ,(case when MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) >=0 then NULL " + 
        "       else " +
        "           ABS(MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK))) " +
        "     END ) " +
        "        AS LATE_IN " +
        ",(case when MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) >=0 then null " +
        "    else " +
        "        abs(MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK))) " +
        "  end)   AS EARLY_OUT "  +
        "         ,MAX(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y'))) mod_yn " +
        "         ,MAX(DECODE(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y')),'Y',nvl(NVL(D.MOD_BY,E.CRT_BY),d.crt_by),NULL)) mod_by " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT2',NVL(E.OT_TIME,0),0)) AS NT2 " +
        "            FROM THR_EMPLOYEE A,THR_WORK_GROUP B, THR_WORK_SHIFT C,THR_TIME_MACHINE D,THR_EXTRA_TIME E,tco_org F " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND E.DEL_IF(+)=0 AND F.DEL_IF=0 " +
        "            AND A.THR_WG_PK=B.PK AND A.PK=D.THR_EMP_PK AND C.PK=D.THR_WS_PK AND A.TCO_ORG_PK=F.PK " +
        "            AND D.THR_EMP_PK=E.THR_EMP_PK(+) AND D.WORK_DT=E.WORK_DT(+) " +
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND  '" + p_to + "' " +
        "            AND DECODE('" + p_wg + "' ,'ALL', '" + p_wg + "',B.PK) =  '" + p_wg  + "'" +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation  + "'" +
        "            AND DECODE('" + p_thr_ws_pk + "','ALL', '" + p_thr_ws_pk + "',C.PK)= '" + p_thr_ws_pk + "' " ;
        SQL = SQL + "                   AND (    A.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";                           
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('"+p_tco_org_pk+"', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '"+p_tco_org_pk+"' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '"+p_tco_org_pk+"' = 'ALL') "+ 
        "            AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL) " +
        "           AND D.TIME_IN IS NOT NULL  " +
        "    AND D.TIME_IN BETWEEN NVL('" + p_m1 + "',D.TIME_IN) AND NVL('" + p_m2 + "',D.TIME_IN)" +
        "            GROUP BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID,A.FULL_NAME,C.REMARK,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ORDER BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID "; 
	}
    else //if (p_opt=="8")   
	{
       SQL= "SELECT     TO_CHAR(SYSDATE,'DD/MM/YYYY') " + 
        "            ,F.ORG_NM " +
        "            ,B.WORKGROUP_NM " +
        "            ,A.EMP_ID " +
        "            ,A.FULL_NAME " +
        "            ,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD'),'DD/MM/YYYY') " +
        "            ,C.REMARK " +
        "            ,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ,MAX(DECODE(E.OT_TYPE,'OT',NVL(E.OT_TIME,0),0)) AS OT " +
        "            ,MAX(DECODE(E.OT_TYPE,'HT',NVL(E.OT_TIME,0),0)) AS HT " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT',NVL(E.OT_TIME,0),0)) AS NT " +
        "           ,(case when MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK)) >=0 then NULL " + 
        "       else " +
        "           ABS(MAX(HR_LATELY_EARLY(D.WORK_DT,C.START_TIME,D.DATE_IN,D.TIME_IN,'IN',A.PK))) " +
        "     END ) " +
        "        AS LATE_IN " +
        ",(case when MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK)) >=0 then null " +
        "    else " +
        "        abs(MAX(HR_LATELY_EARLY(D.DATE_OUT,D.TIME_OUT,DECODE(C.DURING_DAY,1,D.WORK_DT,TO_CHAR(TO_DATE(D.WORK_DT,'YYYYMMDD')+1,'YYYYMMDD')),C.END_TIME,'OUT',A.PK))) " +
        "  end)   AS EARLY_OUT "  +
        "         ,MAX(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y'))) mod_yn " +
        "         ,MAX(DECODE(decode(nvl(D.MOD_BYHAND_YN,'N'),'Y','Y',decode(nvl(D.MOD_AUTO_YN,'N'),'N',nvl(E.MOD_BYHAND_YN,'N'),'Y')),'Y',nvl(NVL(D.MOD_BY,E.CRT_BY),d.crt_by),NULL)) mod_by " +
        "            ,MAX(DECODE(E.OT_TYPE,'NT2',NVL(E.OT_TIME,0),0)) AS NT2 " +
        "            FROM THR_EMPLOYEE A,THR_WORK_GROUP B, THR_WORK_SHIFT C,THR_TIME_MACHINE D,THR_EXTRA_TIME E,tco_org F " +
        "            WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND C.DEL_IF=0 AND D.DEL_IF=0 AND E.DEL_IF(+)=0 AND F.DEL_IF=0 " +
        "            AND A.THR_WG_PK=B.PK AND A.PK=D.THR_EMP_PK AND C.PK=D.THR_WS_PK AND A.TCO_ORG_PK=F.PK " +
        "            AND D.THR_EMP_PK=E.THR_EMP_PK(+) AND D.WORK_DT=E.WORK_DT(+) " +
        "            AND D.WORK_DT BETWEEN '" + p_from + "' AND  '" + p_to + "' " +
        "            AND DECODE('" + p_wg + "' ,'ALL', '" + p_wg + "',B.PK) =  '" + p_wg  + "'" +
        "            AND DECODE('" + p_nation + "' ,'ALL', '" + p_nation + "',a.nation) =  '" + p_nation  + "'" +
        "            AND DECODE('" + p_thr_ws_pk + "','ALL', '" + p_thr_ws_pk + "',C.PK)= '" + p_thr_ws_pk + "' " ;
        SQL = SQL + "                   AND (    A.TCO_ORG_PK IN ( ";
        SQL = SQL + "                       SELECT     G.PK ";
        SQL = SQL + "                             FROM TCO_ORG G ";
        SQL = SQL + "                            WHERE G.DEL_IF = 0           ";                           
        SQL = SQL + "                       START WITH G.PK = ";
        SQL = SQL + "                                     DECODE ('"+p_tco_org_pk+"', ";
        SQL = SQL + "                                             'ALL', 0, ";
        SQL = SQL + "                                             '"+p_tco_org_pk+"' ";
        SQL = SQL + "                                            ) ";
        SQL = SQL + "                       CONNECT BY PRIOR G.PK = G.P_PK) ";
        SQL = SQL + "                 OR '"+p_tco_org_pk+"' = 'ALL') "+ 
        "            AND (DECODE('" + p_search + "','1',UPPER(A.EMP_ID),'2',A.ID_NUM,'3',UPPER(A.FULL_NAME)) LIKE '%'||UPPER('" + p_input + "') " +
        "                        OR '" + p_input + "' IS NULL) " +
        "           AND D.TIME_OUT IS NOT NULL  " +
        "    AND D.TIME_OUT BETWEEN NVL('" + p_m1 + "',D.TIME_OUT) AND NVL('" + p_m2 + "',D.TIME_OUT)" +
        "            GROUP BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID,A.FULL_NAME,C.REMARK,D.TIME_IN,D.TIME_OUT,D.WORK_TIME " +
        "            ORDER BY F.ORG_NM,B.WORKGROUP_NM,D.WORK_DT,A.EMP_ID ";    
        
      } 
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
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_time_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_time_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_time_summary_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-07-21T09:05:51Z</o:LastPrinted>
  <o:Created>2008-05-23T07:19:16Z</o:Created>
  <o:LastSaved>2008-07-24T03:06:05Z</o:LastSaved>
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
	margin:.32in .16in .26in .33in;
	mso-header-margin:.32in;
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
	text-align:right;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
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
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
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
.xl33
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
.xl34
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
.xl35
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
.xl36
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
.xl37
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
.xl38
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
.xl39
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
	border-left:.5pt solid windowtext;}
.xl41
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
.xl42
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl44
	{mso-style-parent:style0;
	font-size:19.0pt;
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
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>12</x:LeftColumnRightPane>
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
       <x:ActiveCol>16</x:ActiveCol>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1539 style='border-collapse:
 collapse;table-layout:fixed;width:1155pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl24 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=173 style='mso-width-source:userset;mso-width-alt:6326;
 width:130pt'>
 <col class=xl24 width=73 style='mso-width-source:userset;mso-width-alt:2669;
 width:55pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
  <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=13 height=38 class=xl42 width=1207 style='height:28.5pt;
  width:907pt'>TIME SUMMARY</td>
  <td class=xl42 width=59 style='width:44pt'></td>
  <td class=xl42 width=67 style='width:50pt'></td>
  <td class=xl42 width=103 style='width:77pt'></td>
  <td class=xl42 width=103 style='width:77pt'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl25 x:str="Work date:   ">Work date:<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl26 x:num><%=p_from.Substring(6,2) + "/" + p_from.Substring(4,2) + "/" + p_from.Substring(0,4) %></td>
  <td class=xl44>~</td>
  <td class=xl26 x:num><%=p_to.Substring(6,2) + "/" + p_to.Substring(4,2) + "/" + p_to.Substring(0,4) %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>Reporter</td>
  <td class=xl24></td>
  <td colspan=2 class=xl43><%=p_user %></td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl25 x:str><%if (p_opt!="5") 
                        Response.Write("Option:   ");
                    %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl31><%if (p_opt!="5") 
                        Response.Write(p_opt_text);
                    %></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>Report Date</td>
  <td colspan=2 class=xl26 x:num><%= dt_total.Rows[0][0].ToString() %></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl30></td>
  <td class=xl26></td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl28 style='height:19.5pt'>No</td>
  <td class=xl28 style='border-left:none'>Organization</td>
  <td class=xl28 style='border-left:none'>Work Group</td>
  <td class=xl28 style='border-left:none'>Emp ID</td>
  <td class=xl28 style='border-left:none'>Full Name</td>
  <td class=xl28 style='border-left:none'>Date</td>
  <td class=xl28 style='border-left:none'>Work Shift</td>
  <td class=xl28 style='border-left:none'>IN Time</td>
  <td class=xl28 style='border-left:none'>OUT Time</td>
  <td class=xl28 style='border-left:none'>WT</td>
  <td class=xl28 style='border-left:none'>OT</td>
  <td class=xl28 style='border-left:none'>HT</td>
  <td class=xl28 style='border-left:none'>NT</td>
  <td class=xl28 style='border-left:none'>NT2</td>
  <td class=xl28 style='border-left:none'>Lately</td>
  <td class=xl28 style='border-left:none'>Early</td>
  <td class=xl28 style='border-left:none'>Mod by Hand</td>
  <td class=xl28 style='border-left:none'>Mod by</td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl32 style='height:19.5pt;border-top:none'>STT</td>
  <td class=xl32 style='border-top:none;border-left:none'>B&#7897; ph&#7853;n</td>
  <td class=xl32 style='border-top:none;border-left:none'>Nhóm</td>
  <td class=xl32 style='border-top:none;border-left:none'>Mã NV</td>
  <td class=xl32 style='border-top:none;border-left:none'>H&#7885; và tên</td>
  <td class=xl32 style='border-top:none;border-left:none'>Ngày</td>
  <td class=xl32 style='border-top:none;border-left:none'>Ca làm vi&#7879;c</td>
  <td class=xl32 style='border-top:none;border-left:none'>Gi&#7901; vào</td>
  <td class=xl32 style='border-top:none;border-left:none'>Gi&#7901; ra</td>
  <td class=xl32 style='border-top:none;border-left:none'>Công</td>
  <td class=xl32 style='border-top:none;border-left:none'>T&#259;ng ca</td>
  <td class=xl32 style='border-top:none;border-left:none'>Ngày l&#7877;</td>
  <td class=xl32 style='border-top:none;border-left:none'>Gi&#7901; &#273;êm</td>
  <td class=xl32 style='border-top:none;border-left:none'>Gi&#7901; &#273;êm TC</td>
  <td class=xl32 style='border-top:none;border-left:none'>Phút vào</td>
  <td class=xl32 style='border-top:none;border-left:none'>Phút ra</td>
  <td class=xl32 style='border-top:none;border-left:none'>S&#7917;a b&#7857;ng
  tay</td>
  <td class=xl32 style='border-top:none;border-left:none'>Ng&#432;&#7901;i
  s&#7917;a</td>
 </tr>
 <% 
     string s_format;
     for (int i = 0; i < irow; i++) 
    {
        if (i == irow - 1)
            s_format = ";border-bottom:.5pt solid windowtext";
        else
            s_format = ";";
    %> 
 <tr class=xl29 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl33 style='height:19.5pt;border-top:none<%=s_format%>' x:num><%=i+1 %></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][1].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][2].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][3].ToString()%></td>
  <td class=xl34 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][4].ToString()%></td>
  <td class=xl35 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][5].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][6].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][7].ToString()%></td>
  <td class=xl36 style='border-top:none;border-left:none<%=s_format%>'><% = dt_total.Rows[i][8].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][9].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][10].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][11].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][12].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][17].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][13].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][14].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][15].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none<%=s_format%>' x:num><% = dt_total.Rows[i][16].ToString()%></td>
 </tr>
 <%
    }
  %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=47 style='width:35pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=77 style='width:58pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=173 style='width:130pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
