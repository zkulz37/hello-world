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
    
    string p_dept,p_group,p_status,p_type,p_pay_type,p_emp_id,p_work_mon, p_m_type;
     
  
    p_dept       = Request["l_dept"].ToString();
    p_group      = Request["l_group"].ToString();
    p_status      = Request["l_status"].ToString();
    p_type       = Request["l_type"].ToString();
    p_pay_type   = Request["l_pay_type"].ToString();
    p_emp_id     = Request["l_emp_id"].ToString();
    p_work_mon   = Request["l_work_mon"].ToString();
    p_m_type = Request.QueryString["l_m_type"].ToString();
         
    string SQL
    = "select nvl(b.seq,0) c0 " +
    "        , nvl(c.seq,0) c1 " +
    "        , a.THR_GROUP_NM c2 " +
    "        , A.EMP_ID c00 " +
    "        , A.FULL_NAME c01 " +
    "        , A.POS_NM c02 " +
    "        , to_char(to_date( A.JOIN_DT  ,'yyyymmdd')    ,'dd/mm/yyyy') c03  " +
    "        , to_char(to_date( A.LEFT_DT  ,'yyyymmdd')    ,'dd/mm/yyyy') c04 " +
    "        , to_char(to_date( A.CONFIRM_DT  ,'yyyymmdd')    ,'dd/mm/yyyy') c05 " +
    "        , case when two_level_status in ('01','02') then round(nvl(A.SALARY_LEVEL1,0),0) else 0 end c06 " +
    "        , case when two_level_status in ('03','02') then round(nvl(A.SALARY_LEVEL2,0),0) else 0 end c07 " +
    "        , round(nvl(A.ALLOW_AMT1 ,0),0) c08 " +
    "        , A.DAYS_IN_MONTH*8 c09 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_L1,0),3) - round(nvl(A.ABS_ALE_L1,0)/8 ,3) c10 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_L2,0),3) - round(nvl(A.ABS_ALE_L2,0)/8 ,3) c11 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS,0),3) - round(nvl(A.ABS_ALE_L1,0)/8,3)- round(nvl(A.ABS_ALE_L2,0)/8,3) c12 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_AMT,0) - nvl(A.ABS_ALE_L1_AMT,0)- nvl(A.ABS_ALE_L2_AMT,0), 3) c13 " +
    "        , round(nvl(A.ABS_ALE_L1,0)/8 ,3) c14 " +
    "        , round(nvl(A.ABS_ALE_L2,0)/8,3 ) c15 " +
    "        , round(nvl(A.ABS_ALE_L1,0)/8,3) + round(nvl(A.ABS_ALE_L2,0)/8 ,3) c16 " +
    "        , round(nvl(A.ABS_ALE_L1_AMT,0) + nvl(A.ABS_ALE_L2_AMT,0), 3) c17 " +
    "        , round(nvl(A.OT_L1,0) , 3) c18 " +
    "        , round(nvl(A.OT_L2,0) , 3) c19 " +
    "        , round(nvl(A.OT_L1,0) + nvl(A.OT_L2,0) , 3) c20 " +
    "        , 0 c21 " +
    "        , round(nvl(A.OT_L1_AMT,0) + nvl(A.OT_L2_AMT,0) , 3) c22 " +
    "        , round(nvl(A.ST_L1,0) + nvl(A.OST_L1,0) , 3) c23 " +
    "        , round(nvl(A.ST_L2,0) + nvl(A.OST_L2,0) , 3) c24 " +
    "        , round(nvl(A.ST_L1,0) + nvl(A.ST_L2,0) + nvl(A.OST_L1,0) + nvl(A.OST_L2,0)  , 3) c25 " +
    "        , 0 c26 " +
    "        , round(nvl(A.ST_L1_AMT,0) + nvl(A.ST_L2_AMT,0) + nvl(A.OST_L1_AMT,0) + nvl(A.OST_L2_AMT,0) , 3) c27 " +
    "        , round(nvl(A.NT_45_L1,0) , 3) c28 " +
    "        , round(nvl(A.NT_45_L2,0) , 3) c29 " +
    "        , round(nvl(A.NT_45_L1,0)  + nvl(A.NT_45_L2,0)   , 3) c30 " +
    "        , 0 c31 " +
    "        , round(nvl(A.NT_45_L1_AMT,0)  + nvl(A.NT_45_L2_AMT,0)  , 3) c32 " +
    "        , round(nvl(A.HT_L1,0) + nvl(A.OHT_L1,0) , 3) c33 " +
    "        , round(nvl(A.HT_L2,0) + nvl(A.OHT_L2,0) , 3) c34 " +
    "        , round(nvl(A.HT_L1,0) + nvl(A.HT_L2,0) + nvl(A.OHT_L1,0) + nvl(A.OHT_L2,0)  , 3) c35 " +
    "        , 0 c36 " +
    "        , round(nvl(A.HT_L1_AMT,0) + nvl(A.HT_L2_AMT,0) + nvl(A.OHT_L1_AMT,0) + nvl(A.OHT_L2_AMT,0) , 3) c37 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_AMT,0)+nvl(A.TOTAL_OT_L1_AMT,0)+nvl(A.TOTAL_OT_L2_AMT,0),3) c38 " +
    "        , round(nvl(A.ALLOW_AMT2,0),3) c39 " +
    "        , round(nvl(A.ALLOW_AMT3,0),3) c40 " +
    "        , round(nvl(A.ALLOW_AMT4,0),3) c41 " +
    "        , round(nvl(A.ALLOW_AMT5,0),3) c42 " +
    "        , round(nvl(A.RETURN_AMT,0),3) c43 " +
    "        , round(nvl(A.ADVANCE_AMT,0),3) c44 " +
    "        , 0 c45 " +
    "        , 0 c46 " +
    "        , 0 c47 " +
    "        , 0 c48 " +
    "        , round(nvl(A.GROSS_AMT,0),3) c49 " +
    "        , round(nvl(A.INCOME_TAX,0),3) c50 " +
    "        , case when nvl(A.RECIEVE_NET_YN,'N')='N' then round(nvl(A.SOCIAL_AMT,0)+nvl(A.HEALTH_AMT,0) ,3)  " +
    "                 else round(nvl(A.SOCIAL_COM_NET,0)+nvl(A.HEALTH_COM_NET,0),3)  " +
    "          end  c51 " +
    "        , case when nvl(A.RECIEVE_NET_YN,'N')='N' then round(nvl(A.UNEMP_INS,0),3) " +
    "                else round(nvl(A.UNEMP_INS_NET,0),3) " +
    "          end c52 " +
    "        , round(nvl(A.INS_PRO_AMT,0),3) c53 " +
    "        , round(nvl(A.UNION_AMT,0),3) c54 " +
    "        , round(nvl(A.RETURN_NO_PIT,0),3) c55 " +
    "        , round(nvl(A.ADVANCE_NO_PIT,0),3) c56 " +
    "        , round(nvl(A.NET_AMT,0),3) c57       " +
    "        , (select code_nm from vhr_hr_code v where V.CODE=A.EMPLOYEE_TYPE and id='HR0017') c58 " +
    "        , round(nvl(A.DEDUCT_PIT,0),3) c59 " +
    "        , to_char(to_date( E.BEGIN_CONTRACT  ,'yyyymmdd')    ,'dd/mm/yyyy') c60  " +
    "        , round(nvl(A.OT_TAX_L1_AMT,0)+nvl( A.OT_TAX_L2_AMT,0) ,3) c61   " +
    "        , round(nvl(a.abs_progressive_type_03,0),3) c62          " +
    "from thr_month_salary a, tco_dept b, thr_group c, thr_employee e  " +
    "where a.del_if=0 and a.work_mon='" + p_work_mon + "' " +
    "and E.DEL_IF=0 " +
    "and A.THR_EMP_PK=e.pk " +
    " and b.del_if=0 and c.del_if=0 and a.tco_dept_pk=b.pk and a.thr_group_pk=c.pk" +
    " and (a.tco_dept_pk in ( " +
    "                              SELECT     g.pk " +
    "                                    FROM comm.tco_dept g " +
    "                                   WHERE g.del_if = 0 " +
    "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
    "                              START WITH g.pk = " +
    "                                            DECODE ('" + p_dept + "', " +
    "                                                    'ALL', 0, " +
    "                                                    '" + p_dept + "' " +
    "                                                   ) " +
    "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
    "                        OR '" + p_dept + "' = 'ALL') " +
    " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
    " and a.emp_id like '%" + p_emp_id + "%' " +
    " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
    " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
    " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
    " and nvl(a.net_amt,0) " + p_type +       
    " order by c0, c1, c2, c00 ";

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

    string SQL_SUM
    = " select c0, c1, c2 "+
    ",     sum(nvl(c06,0)) c06 ,     sum(nvl(c07,0)) c07 ,     sum(nvl(c08,0)) c08 ,     sum(nvl(c09,0)) c09 ,     sum(nvl(c10,0)) c10  " +
    ",     sum(nvl(c11,0)) c11 ,     sum(nvl(c12,0)) c12 ,     sum(nvl(c13,0)) c13 ,     sum(nvl(c14,0)) c14 ,     sum(nvl(c15,0)) c15  " +
    ",     sum(nvl(c16,0)) c16 ,     sum(nvl(c17,0)) c17 ,     sum(nvl(c18,0)) c18 ,     sum(nvl(c19,0)) c19 ,     sum(nvl(c20,0)) c20  " +
    ",     sum(nvl(c21,0)) c21 ,     sum(nvl(c22,0)) c22 ,     sum(nvl(c23,0)) c23 ,     sum(nvl(c24,0)) c24 ,     sum(nvl(c25,0)) c25  " +
    ",     sum(nvl(c26,0)) c26 ,     sum(nvl(c27,0)) c27 ,     sum(nvl(c28,0)) c28 ,     sum(nvl(c29,0)) c29 ,     sum(nvl(c30,0)) c30  " +
    ",     sum(nvl(c31,0)) c31 ,     sum(nvl(c32,0)) c32 ,     sum(nvl(c33,0)) c33 ,     sum(nvl(c34,0)) c34 ,     sum(nvl(c35,0)) c35  " +
    ",     sum(nvl(c36,0)) c36 ,     sum(nvl(c37,0)) c37 ,     sum(nvl(c38,0)) c38 ,     sum(nvl(c39,0)) c39 ,     sum(nvl(c40,0)) c40  " +
    ",     sum(nvl(c41,0)) c41 ,     sum(nvl(c42,0)) c42 ,     sum(nvl(c43,0)) c43 ,     sum(nvl(c44,0)) c44 ,     sum(nvl(c45,0)) c45  " +
    ",     sum(nvl(c46,0)) c46 ,     sum(nvl(c47,0)) c47 ,     sum(nvl(c48,0)) c48 ,     sum(nvl(c49,0)) c49 ,     sum(nvl(c50,0)) c50  " +
    ",     sum(nvl(c51,0)) c51 ,     sum(nvl(c52,0)) c52 ,     sum(nvl(c53,0)) c53 ,     sum(nvl(c54,0)) c54 ,     sum(nvl(c55,0)) c55  " +
    ",     sum(nvl(c56,0)) c56 ,     sum(nvl(c57,0)) c57 ,     sum(nvl(c59,0)) c59  " +
    ",     sum(nvl(c61,0)) c61 ,     sum(nvl(c62,0)) c62 " +
    "   from(select nvl(b.seq,0) c0 " +
    "        , nvl(c.seq,0) c1 " +
    "        , a.THR_GROUP_NM c2 " +
    "        , A.EMP_ID c00 " +
    "        , A.FULL_NAME c01 " +
    "        , A.POS_NM c02 " +
    "        , to_char(to_date( A.JOIN_DT  ,'yyyymmdd')    ,'dd/mm/yyyy') c03  " +
    "        , to_char(to_date( A.LEFT_DT  ,'yyyymmdd')    ,'dd/mm/yyyy') c04 " +
    "        , to_char(to_date( A.CONFIRM_DT  ,'yyyymmdd')    ,'dd/mm/yyyy') c05 " +
    "        , case when two_level_status in ('01','02') then round(nvl(A.SALARY_LEVEL1,0),0) else 0 end c06 " +
    "        , case when two_level_status in ('03','02') then round(nvl(A.SALARY_LEVEL2,0),0) else 0 end c07 " +
    "        , round(nvl(A.ALLOW_AMT1 ,0),0) c08 " +
    "        , A.DAYS_IN_MONTH*8 c09 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_L1,0),3) - round(nvl(A.ABS_ALE_L1,0)/8 ,3) c10 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_L2,0),3) - round(nvl(A.ABS_ALE_L2,0)/8 ,3) c11 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS,0),3) - round(nvl(A.ABS_ALE_L1,0)/8,3)- round(nvl(A.ABS_ALE_L2,0)/8,3) c12 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_AMT,0) - nvl(A.ABS_ALE_L1_AMT,0)- nvl(A.ABS_ALE_L2_AMT,0), 3) c13 " +
    "        , round(nvl(A.ABS_ALE_L1,0)/8 ,3) c14 " +
    "        , round(nvl(A.ABS_ALE_L2,0)/8,3 ) c15 " +
    "        , round(nvl(A.ABS_ALE_L1,0)/8,3) + round(nvl(A.ABS_ALE_L2,0)/8 ,3) c16 " +
    "        , round(nvl(A.ABS_ALE_L1_AMT,0) + nvl(A.ABS_ALE_L2_AMT,0), 3) c17 " +
    "        , round(nvl(A.OT_L1,0) , 3) c18 " +
    "        , round(nvl(A.OT_L2,0) , 3) c19 " +
    "        , round(nvl(A.OT_L1,0) + nvl(A.OT_L2,0) , 3) c20 " +
    "        , 0 c21 " +
    "        , round(nvl(A.OT_L1_AMT,0) + nvl(A.OT_L2_AMT,0) , 3) c22 " +
    "        , round(nvl(A.ST_L1,0) + nvl(A.OST_L1,0) , 3) c23 " +
    "        , round(nvl(A.ST_L2,0) + nvl(A.OST_L2,0) , 3) c24 " +
    "        , round(nvl(A.ST_L1,0) + nvl(A.ST_L2,0) + nvl(A.OST_L1,0) + nvl(A.OST_L2,0)  , 3) c25 " +
    "        , 0 c26 " +
    "        , round(nvl(A.ST_L1_AMT,0) + nvl(A.ST_L2_AMT,0) + nvl(A.OST_L1_AMT,0) + nvl(A.OST_L2_AMT,0) , 3) c27 " +
    "        , round(nvl(A.NT_45_L1,0) , 3) c28 " +
    "        , round(nvl(A.NT_45_L2,0) , 3) c29 " +
    "        , round(nvl(A.NT_45_L1,0)  + nvl(A.NT_45_L2,0)   , 3) c30 " +
    "        , 0 c31 " +
    "        , round(nvl(A.NT_45_L1_AMT,0)  + nvl(A.NT_45_L2_AMT,0)  , 3) c32 " +
    "        , round(nvl(A.HT_L1,0) + nvl(A.OHT_L1,0) , 3) c33 " +
    "        , round(nvl(A.HT_L2,0) + nvl(A.OHT_L2,0) , 3) c34 " +
    "        , round(nvl(A.HT_L1,0) + nvl(A.HT_L2,0) + nvl(A.OHT_L1,0) + nvl(A.OHT_L2,0)  , 3) c35 " +
    "        , 0 c36 " +
    "        , round(nvl(A.HT_L1_AMT,0) + nvl(A.HT_L2_AMT,0) + nvl(A.OHT_L1_AMT,0) + nvl(A.OHT_L2_AMT,0) , 3) c37 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_AMT,0)+nvl(A.TOTAL_OT_L1_AMT,0)+nvl(A.TOTAL_OT_L2_AMT,0),3) c38 " +
    "        , round(nvl(A.ALLOW_AMT2,0),3) c39 " +
    "        , round(nvl(A.ALLOW_AMT3,0),3) c40 " +
    "        , round(nvl(A.ALLOW_AMT4,0),3) c41 " +
    "        , round(nvl(A.ALLOW_AMT5,0),3) c42 " +
    "        , round(nvl(A.RETURN_AMT,0),3) c43 " +
    "        , round(nvl(A.ADVANCE_AMT,0),3) c44 " +
    "        , 0 c45 " +
    "        , 0 c46 " +
    "        , 0 c47 " +
    "        , 0 c48 " +
    "        , round(nvl(A.GROSS_AMT,0),3) c49 " +
    "        , round(nvl(A.INCOME_TAX,0),3) c50 " +
    "        , case when nvl(A.RECIEVE_NET_YN,'N')='N' then round(nvl(A.SOCIAL_AMT,0)+nvl(A.HEALTH_AMT,0) ,3)  " +
    "                 else round(nvl(A.SOCIAL_COM_NET,0)+nvl(A.HEALTH_COM_NET,0),3)  " +
    "          end  c51 " +
    "        , case when nvl(A.RECIEVE_NET_YN,'N')='N' then round(nvl(A.UNEMP_INS,0),3) " +
    "                else round(nvl(A.UNEMP_INS_NET,0),3) " +
    "          end c52 " +
    "        , round(nvl(A.INS_PRO_AMT,0),3) c53 " +
    "        , round(nvl(A.UNION_AMT,0),3) c54 " +
    "        , round(nvl(A.RETURN_NO_PIT,0),3) c55 " +
    "        , round(nvl(A.ADVANCE_NO_PIT,0),3) c56 " +
    "        , round(nvl(A.NET_AMT,0),3) c57       " +
    "        , (select code_nm from vhr_hr_code v where V.CODE=A.EMPLOYEE_TYPE and id='HR0017') c58 " +
    "        , round(nvl(A.DEDUCT_PIT,0),3) c59 " +
    "        , to_char(to_date( E.BEGIN_CONTRACT  ,'yyyymmdd')    ,'dd/mm/yyyy') c60  " +
    "        , round(nvl(A.OT_TAX_L1_AMT,0)+nvl( A.OT_TAX_L2_AMT,0) ,3) c61   " +
    "        , round(nvl(a.abs_progressive_type_03,0),3) c62          " +
    "from thr_month_salary a, tco_dept b, thr_group c, thr_employee e  " +
    "where a.del_if=0 and a.work_mon='" + p_work_mon + "' " +
    "and E.DEL_IF=0 " +
    "and A.THR_EMP_PK=e.pk " +
    " and b.del_if=0 and c.del_if=0 and a.tco_dept_pk=b.pk and a.thr_group_pk=c.pk" +
    " and (a.tco_dept_pk in ( " +
    "                              SELECT     g.pk " +
    "                                    FROM comm.tco_dept g " +
    "                                   WHERE g.del_if = 0 " +
    "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
    "                              START WITH g.pk = " +
    "                                            DECODE ('" + p_dept + "', " +
    "                                                    'ALL', 0, " +
    "                                                    '" + p_dept + "' " +
    "                                                   ) " +
    "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
    "                        OR '" + p_dept + "' = 'ALL') " +
    " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
    " and a.emp_id like '%" + p_emp_id + "%' " +
    " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
    " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
    " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
    " and nvl(a.net_amt,0) " + p_type +
    "   ) sub "+
    " group by c0, c1, c2 " +
    " order by c0, c1, c2 ";

    //Response.Write(SQL);
    //Response.End();

    DataTable dt_Sum = ESysLib.TableReadOpen(SQL_SUM);

    string SQL_SUM2
    = " select " +
    "      sum(nvl(c06,0)) c06 ,     sum(nvl(c07,0)) c07 ,     sum(nvl(c08,0)) c08 ,     sum(nvl(c09,0)) c09 ,     sum(nvl(c10,0)) c10  " +
    ",     sum(nvl(c11,0)) c11 ,     sum(nvl(c12,0)) c12 ,     sum(nvl(c13,0)) c13 ,     sum(nvl(c14,0)) c14 ,     sum(nvl(c15,0)) c15  " +
    ",     sum(nvl(c16,0)) c16 ,     sum(nvl(c17,0)) c17 ,     sum(nvl(c18,0)) c18 ,     sum(nvl(c19,0)) c19 ,     sum(nvl(c20,0)) c20  " +
    ",     sum(nvl(c21,0)) c21 ,     sum(nvl(c22,0)) c22 ,     sum(nvl(c23,0)) c23 ,     sum(nvl(c24,0)) c24 ,     sum(nvl(c25,0)) c25  " +
    ",     sum(nvl(c26,0)) c26 ,     sum(nvl(c27,0)) c27 ,     sum(nvl(c28,0)) c28 ,     sum(nvl(c29,0)) c29 ,     sum(nvl(c30,0)) c30  " +
    ",     sum(nvl(c31,0)) c31 ,     sum(nvl(c32,0)) c32 ,     sum(nvl(c33,0)) c33 ,     sum(nvl(c34,0)) c34 ,     sum(nvl(c35,0)) c35  " +
    ",     sum(nvl(c36,0)) c36 ,     sum(nvl(c37,0)) c37 ,     sum(nvl(c38,0)) c38 ,     sum(nvl(c39,0)) c39 ,     sum(nvl(c40,0)) c40  " +
    ",     sum(nvl(c41,0)) c41 ,     sum(nvl(c42,0)) c42 ,     sum(nvl(c43,0)) c43 ,     sum(nvl(c44,0)) c44 ,     sum(nvl(c45,0)) c45  " +
    ",     sum(nvl(c46,0)) c46 ,     sum(nvl(c47,0)) c47 ,     sum(nvl(c48,0)) c48 ,     sum(nvl(c49,0)) c49 ,     sum(nvl(c50,0)) c50  " +
    ",     sum(nvl(c51,0)) c51 ,     sum(nvl(c52,0)) c52 ,     sum(nvl(c53,0)) c53 ,     sum(nvl(c54,0)) c54 ,     sum(nvl(c55,0)) c55  " +
    ",     sum(nvl(c56,0)) c56 ,     sum(nvl(c57,0)) c57 ,     sum(nvl(c59,0)) c59  " +
    ",     sum(nvl(c61,0)) c61 ,     sum(nvl(c62,0)) c62 " +
    "   from(select nvl(b.seq,0) c0 " +
    "        , nvl(c.seq,0) c1 " +
    "        , a.THR_GROUP_NM c2 " +
    "        , A.EMP_ID c00 " +
    "        , A.FULL_NAME c01 " +
    "        , A.POS_NM c02 " +
    "        , to_char(to_date( A.JOIN_DT  ,'yyyymmdd')    ,'dd/mm/yyyy') c03  " +
    "        , to_char(to_date( A.LEFT_DT  ,'yyyymmdd')    ,'dd/mm/yyyy') c04 " +
    "        , to_char(to_date( A.CONFIRM_DT  ,'yyyymmdd')    ,'dd/mm/yyyy') c05 " +
    "        , case when two_level_status in ('01','02') then round(nvl(A.SALARY_LEVEL1,0),0) else 0 end c06 " +
    "        , case when two_level_status in ('03','02') then round(nvl(A.SALARY_LEVEL2,0),0) else 0 end c07 " +
    "        , round(nvl(A.ALLOW_AMT1 ,0),0) c08 " +
    "        , A.DAYS_IN_MONTH*8 c09 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_L1,0),3) - round(nvl(A.ABS_ALE_L1,0)/8 ,3) c10 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_L2,0),3) - round(nvl(A.ABS_ALE_L2,0)/8 ,3) c11 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS,0),3) - round(nvl(A.ABS_ALE_L1,0)/8,3)- round(nvl(A.ABS_ALE_L2,0)/8,3) c12 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_AMT,0) - nvl(A.ABS_ALE_L1_AMT,0)- nvl(A.ABS_ALE_L2_AMT,0), 3) c13 " +
    "        , round(nvl(A.ABS_ALE_L1,0)/8 ,3) c14 " +
    "        , round(nvl(A.ABS_ALE_L2,0)/8,3 ) c15 " +
    "        , round(nvl(A.ABS_ALE_L1,0)/8,3) + round(nvl(A.ABS_ALE_L2,0)/8 ,3) c16 " +
    "        , round(nvl(A.ABS_ALE_L1_AMT,0) + nvl(A.ABS_ALE_L2_AMT,0), 3) c17 " +
    "        , round(nvl(A.OT_L1,0) , 3) c18 " +
    "        , round(nvl(A.OT_L2,0) , 3) c19 " +
    "        , round(nvl(A.OT_L1,0) + nvl(A.OT_L2,0) , 3) c20 " +
    "        , 0 c21 " +
    "        , round(nvl(A.OT_L1_AMT,0) + nvl(A.OT_L2_AMT,0) , 3) c22 " +
    "        , round(nvl(A.ST_L1,0) + nvl(A.OST_L1,0) , 3) c23 " +
    "        , round(nvl(A.ST_L2,0) + nvl(A.OST_L2,0) , 3) c24 " +
    "        , round(nvl(A.ST_L1,0) + nvl(A.ST_L2,0) + nvl(A.OST_L1,0) + nvl(A.OST_L2,0)  , 3) c25 " +
    "        , 0 c26 " +
    "        , round(nvl(A.ST_L1_AMT,0) + nvl(A.ST_L2_AMT,0) + nvl(A.OST_L1_AMT,0) + nvl(A.OST_L2_AMT,0) , 3) c27 " +
    "        , round(nvl(A.NT_45_L1,0) , 3) c28 " +
    "        , round(nvl(A.NT_45_L2,0) , 3) c29 " +
    "        , round(nvl(A.NT_45_L1,0)  + nvl(A.NT_45_L2,0)   , 3) c30 " +
    "        , 0 c31 " +
    "        , round(nvl(A.NT_45_L1_AMT,0)  + nvl(A.NT_45_L2_AMT,0)  , 3) c32 " +
    "        , round(nvl(A.HT_L1,0) + nvl(A.OHT_L1,0) , 3) c33 " +
    "        , round(nvl(A.HT_L2,0) + nvl(A.OHT_L2,0) , 3) c34 " +
    "        , round(nvl(A.HT_L1,0) + nvl(A.HT_L2,0) + nvl(A.OHT_L1,0) + nvl(A.OHT_L2,0)  , 3) c35 " +
    "        , 0 c36 " +
    "        , round(nvl(A.HT_L1_AMT,0) + nvl(A.HT_L2_AMT,0) + nvl(A.OHT_L1_AMT,0) + nvl(A.OHT_L2_AMT,0) , 3) c37 " +
    "        , round(nvl(A.TOTAL_WT_HT_ABS_AMT,0)+nvl(A.TOTAL_OT_L1_AMT,0)+nvl(A.TOTAL_OT_L2_AMT,0),3) c38 " +
    "        , round(nvl(A.ALLOW_AMT2,0),3) c39 " +
    "        , round(nvl(A.ALLOW_AMT3,0),3) c40 " +
    "        , round(nvl(A.ALLOW_AMT4,0),3) c41 " +
    "        , round(nvl(A.ALLOW_AMT5,0),3) c42 " +
    "        , round(nvl(A.RETURN_AMT,0),3) c43 " +
    "        , round(nvl(A.ADVANCE_AMT,0),3) c44 " +
    "        , 0 c45 " +
    "        , 0 c46 " +
    "        , 0 c47 " +
    "        , 0 c48 " +
    "        , round(nvl(A.GROSS_AMT,0),3) c49 " +
    "        , round(nvl(A.INCOME_TAX,0),3) c50 " +
    "        , case when nvl(A.RECIEVE_NET_YN,'N')='N' then round(nvl(A.SOCIAL_AMT,0)+nvl(A.HEALTH_AMT,0) ,3)  " +
    "                 else round(nvl(A.SOCIAL_COM_NET,0)+nvl(A.HEALTH_COM_NET,0),3)  " +
    "          end  c51 " +
    "        , case when nvl(A.RECIEVE_NET_YN,'N')='N' then round(nvl(A.UNEMP_INS,0),3) " +
    "                else round(nvl(A.UNEMP_INS_NET,0),3) " +
    "          end c52 " +
    "        , round(nvl(A.INS_PRO_AMT,0),3) c53 " +
    "        , round(nvl(A.UNION_AMT,0),3) c54 " +
    "        , round(nvl(A.RETURN_NO_PIT,0),3) c55 " +
    "        , round(nvl(A.ADVANCE_NO_PIT,0),3) c56 " +
    "        , round(nvl(A.NET_AMT,0),3) c57       " +
    "        , (select code_nm from vhr_hr_code v where V.CODE=A.EMPLOYEE_TYPE and id='HR0017') c58 " +
    "        , round(nvl(A.DEDUCT_PIT,0),3) c59 " +
    "        , to_char(to_date( E.BEGIN_CONTRACT  ,'yyyymmdd')    ,'dd/mm/yyyy') c60  " +
    "        , round(nvl(A.OT_TAX_L1_AMT,0)+nvl( A.OT_TAX_L2_AMT,0) ,3) c61   " +
    "        , round(nvl(a.abs_progressive_type_03,0),3) c62          " +
    "from thr_month_salary a, tco_dept b, thr_group c, thr_employee e  " +
    "where a.del_if=0 and a.work_mon='" + p_work_mon + "' " +
    "and E.DEL_IF=0 " +
    "and A.THR_EMP_PK=e.pk " +
    " and b.del_if=0 and c.del_if=0 and a.tco_dept_pk=b.pk and a.thr_group_pk=c.pk" +
    " and (a.tco_dept_pk in ( " +
    "                              SELECT     g.pk " +
    "                                    FROM comm.tco_dept g " +
    "                                   WHERE g.del_if = 0 " +
    "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
    "                              START WITH g.pk = " +
    "                                            DECODE ('" + p_dept + "', " +
    "                                                    'ALL', 0, " +
    "                                                    '" + p_dept + "' " +
    "                                                   ) " +
    "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
    "                        OR '" + p_dept + "' = 'ALL') " +
    " and decode('" + p_group + "','ALL','ALL',a.thr_group_pk)='" + p_group + "'" +
    " and a.emp_id like '%" + p_emp_id + "%' " +
    " and decode('" + p_status + "','ALL','ALL',a.status)='" + p_status + "'" +
    " and decode('" + p_pay_type + "','ALL','ALL',a.pay_type)='" + p_pay_type + "'" +
    " and decode('" + p_m_type + "','ALL','ALL',a.MONEY_KIND)='" + p_m_type + "'" +
    " and nvl(a.net_amt,0) " + p_type +
    "   ) sub ";

    //Response.Write(SQL);
    //Response.End();

    DataTable dt_SumGrand = ESysLib.TableReadOpen(SQL_SUM2);
    
    //--------------------company information-----------------------
    string SQL_Com
    = "select  a.PARTNER_LNAME c0,a.ADDR1 c1,a.PHONE_NO c2,a.TCO_BPPHOTO_PK c3,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY') c4 " +
        "   ,to_char(to_date('" + p_work_mon + "','yyyymm'),'MM-YYYY') c5 " +
        "   ,'10'||to_char(add_months(to_date('" + p_work_mon + "','yyyymm'),1),'mm/yyyy') c6    " +
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               comm.tco_dept  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_dept g " +
        "                                   WHERE g.del_if = 0 " +
        "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_dept + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_dept + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_dept + "' = 'ALL') " +
        "and rownum=1 ";

    
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_employee_payroll_st2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_payroll_st2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_payroll_st2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Huong</o:Author>
  <o:LastAuthor>SV108</o:LastAuthor>
  <o:LastPrinted>2013-07-13T06:56:35Z</o:LastPrinted>
  <o:Created>2013-07-12T03:29:21Z</o:Created>
  <o:LastSaved>2013-07-13T07:06:33Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.55in .28in .47in .38in;
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
.style21
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
	mso-style-name:"Normal 12";}
.style22
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
.style23
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
	mso-style-name:"Normal 5";}
.style24
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
	mso-style-name:"Normal 6";}
.style25
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
	mso-style-name:"Normal 7";}
.style26
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
	mso-style-name:"Normal 8";}
.style27
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
	mso-style-name:"Normal 9";}
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
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";}
.xl36
	{mso-style-parent:style22;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl40
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl41
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl42
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";}
.xl43
	{mso-style-parent:style23;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl44
	{mso-style-parent:style24;
	color:windowtext;
	font-size:18.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl45
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl46
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
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
.xl54
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
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
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style25;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	background:white;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style26;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	background:white;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	background:white;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl86
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl120
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl121
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl122
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl123
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl124
	{mso-style-parent:style25;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl125
	{mso-style-parent:style26;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl126
	{mso-style-parent:style27;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl129
	{mso-style-parent:style0;
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>8</x:PaperSizeIndex>
      <x:Scale>45</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>10</x:SplitVertical>
     <x:LeftColumnRightPane>10</x:LeftColumnRightPane>
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
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
       <x:RangeSelection>$C$4:$C$6</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int irow=6;
        
        for (int k=0;k<dt_Emp.Rows.Count;k++)
        {
            irow++;            
            if (k < dt_Emp.Rows.Count - 1)
            {
                if ( dt_Emp.Rows[k]["c2"].ToString() != dt_Emp.Rows[k+1]["c2"].ToString() )
                {   
                    irow+=11;                
                %>
                    <x:RowBreak>
                        <x:Row><%=irow %></x:Row>
                    </x:RowBreak>
                <%
                }                
            }                    
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9915</x:WindowHeight>
  <x:WindowWidth>19320</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl31>

<table x:str border=0 cellpadding=0 cellspacing=0 width=3127 style='border-collapse:
 collapse;table-layout:fixed;width:2353pt'>
 <col class=xl31 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl31 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl31 width=154 style='mso-width-source:userset;mso-width-alt:5632;
 width:116pt'>
 <col class=xl31 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl32 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl32 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2779'><!-- confirm date -->
 <col class=xl33 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl33 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl33 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl34 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2377'><!-- WT -->
 <col class=xl35 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl33 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2523'><!-- ALE -->
 <col class=xl35 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl33 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2486'>
 <col class=xl35 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl33 width=68 style='display:none;mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl33 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2413'>
 <col class=xl35 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl33 width=67 style='display:none;mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
<col class=xl35 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2560'>
 <col class=xl35 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl33 width=62 span=1 style='display:none;mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <col class=xl33 width=62 span=1 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2560'>
 <col class=xl35 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl33 width=62 span=1 style='display:none;mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <col class=xl33 width=62 span=1 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <col class=xl33 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl33 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl33 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl33 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl33 width=80 span=3 style='mso-width-source:userset;mso-width-alt:
 2925;width:60pt'>
 <col class=xl33 width=0 span=4 style='display:none;mso-width-source:userset;
 mso-width-alt:2925'>
 <col class=xl33 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl33 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl33 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl33 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl33 width=68 span=2 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl33 width=69 span=2 style='mso-width-source:userset;mso-width-alt:
 2523;width:52pt'>
 <col class=xl33 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl34 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl34 width=0 span=6 style='display:none;mso-width-source:userset;
 mso-width-alt:3145'>
 <tr height=28 style='height:21.0pt'>
  <td height=28 class=xl36 colspan=8 width=483 style='height:21.0pt;mso-ignore:
  colspan;width:363pt'>SUN GARMENT TEXTILE VIET NAM CO.,LTD</td>
  <td class=xl33 width=82 style='width:62pt'></td>
  <td class=xl33 width=80 style='width:60pt'></td>
  <td class=xl34 width=63 style='width:47pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=65 style='width:49pt'></td>
  <td class=xl33 width=76 style='width:57pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=69 style='width:52pt'></td>
  <td class=xl33 width=71 style='width:53pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=68 style='width:51pt'></td>
  <td class=xl33 width=68 style='width:51pt'></td>
  <td class=xl33 width=77 style='width:58pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=66 style='width:50pt'></td>
  <td class=xl33 width=67 style='width:50pt'></td>
  <td class=xl33 width=48 style='width:36pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=70 style='width:53pt'></td>
  <td class=xl33 width=62 style='width:47pt'></td>
  <td class=xl33 width=62 style='width:47pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=70 style='width:53pt'></td>
  <td class=xl33 width=62 style='width:47pt'></td>
  <td class=xl33 width=62 style='width:47pt'></td>
  <td class=xl33 width=86 style='width:65pt'></td>
  <td class=xl33 width=88 style='width:66pt'></td>
  <td class=xl33 width=87 style='width:65pt'></td>
  <td class=xl33 width=85 style='width:64pt'></td>
  <td class=xl33 width=80 style='width:60pt'></td>
  <td class=xl33 width=80 style='width:60pt'></td>
  <td class=xl33 width=80 style='width:60pt'></td>
  <td class=xl33 width=0></td>
  <td class=xl33 width=0></td>
  <td class=xl33 width=0></td>
  <td class=xl33 width=0></td>
  <td class=xl33 width=97 style='width:73pt'></td>
  <td class=xl33 width=69 style='width:52pt'></td>
  <td class=xl33 width=76 style='width:57pt'></td>
  <td class=xl33 width=74 style='width:56pt'></td>
  <td class=xl33 width=68 style='width:51pt'></td>
  <td class=xl33 width=68 style='width:51pt'></td>
  <td class=xl33 width=69 style='width:52pt'></td>
  <td class=xl33 width=69 style='width:52pt'></td>
  <td class=xl33 width=94 style='width:71pt'></td>
  <td class=xl34 width=86 style='width:65pt'></td>
  <td class=xl34 width=0></td>
  <td class=xl34 width=0></td>
  <td class=xl34 width=0></td>
  <td class=xl34 width=0></td>
  <td class=xl34 width=0></td>
  <td class=xl34 width=0></td>
 </tr>
 <tr class=xl37 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=66 height=30 class=xl85 style='height:22.5pt'>SALARY PAYMENT
  TABLE FOR DAILY WORKERS</td>
 </tr>
 <tr height=36 style='height:27.0pt'>
  <td height=36 colspan=4 class=xl38 style='height:27.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td class=xl40></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td class=xl40></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td class=xl42></td>
  <td colspan=9 class=xl86>PAYROLL OF <%=dt_Com.Rows[0]["c4"].ToString() %></td>
  <td colspan=17 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl45>Actual pay date <%=dt_Com.Rows[0]["c6"].ToString %></td>
  <td colspan=7 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td rowspan=3 height=148 class=xl87 width=46 style='border-bottom:.5pt solid black;
  height:111.0pt;width:35pt'>NO<br>
    STT</td>
  <td rowspan=3 class=xl90 width=41 style='border-bottom:.5pt solid black;
  width:31pt'>ID No<br>
    MNV</td>
  <td rowspan=3 class=xl90 width=154 style='border-bottom:.5pt solid black;
  width:116pt'>Full Name<br>
    Họ và Tên</td>
  <td rowspan=3 class=xl93 width=83 style='border-bottom:.5pt solid black;
  width:62pt'>Position<br>
    Công việc</td>
  <td rowspan=3 class=xl96 width=76 style='border-bottom:.5pt solid black;
  width:57pt'><span style='mso-spacerun:yes'> </span>D.O.H<br>
    Ngày vào</td>
  <td rowspan=3 class=xl96 width=0 style='border-bottom:.5pt solid black'>Left
  date<br>
    Ngày nghỉ việc</td>
  <td rowspan=3 class=xl96 width=0 style='border-bottom:.5pt solid black'>Confirm
  Date<br>
    Ngày thay đổi lương</td>
  <td rowspan=3 class=xl99 width=83 style='border-bottom:.5pt solid black;
  width:62pt'>SALARY LEVEL 1</td>
  <td rowspan=3 class=xl99 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>SALARY LEVEL 2</td>
  <td rowspan=3 class=xl102 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>SKILLED<br>
    Chuyên môn, Trách nhiệm</td>
  <td rowspan=3 class=xl105 width=63 style='border-bottom:.5pt solid black;
  width:47pt'>R.Hours<br>
    TG LV</td>
  <td colspan=4 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>NGÀY CÔNG</td>
  <td colspan=4 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>PHÉP NĂM</td>
  <td colspan=5 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>EXTRA/ TĂNG CA 150%</td>
  <td colspan=5 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>EXTRA/ TĂNG CA 200%</td>
  <td colspan=5 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>EXTRA/ TĂNG CA 215%</td>
  <td colspan=5 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>EXTRA/ TĂNG CA 300%</td>
  <td rowspan=3 class=xl102 width=86 style='border-bottom:.5pt solid black;
  width:65pt'>Total<span style='mso-spacerun:yes'>  </span>Salary<br>
    Lương&amp; T/C</td>
  <td rowspan=3 class=xl102 width=88 style='border-bottom:.5pt solid black;
  width:66pt'>Full Attandance Allowance<br>
    ( Chuyên cần)</td>
  <td rowspan=3 class=xl102 width=87 style='border-bottom:.5pt solid black;
  width:65pt'>Housing<br>
    <span style='mso-spacerun:yes'> </span>Allowance<br>
    (Tiền<span style='mso-spacerun:yes'>  </span>nhà)</td>
  <td rowspan=3 class=xl102 width=85 style='border-bottom:.5pt solid black;
  width:64pt'>Petrol<br>
    Allowance<br>
    ( P/cấp xăng )</td>
  <td rowspan=3 class=xl102 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>Child<br>
    Care<br>
    Allowance<span style='mso-spacerun:yes'>  </span>(P/C Con nhỏ)</td>
  <td rowspan=3 class=xl102 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>Return with PIT<br>
    Hoàn trả/Bù lương</td>
  <td rowspan=3 class=xl102 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>Advanced<br>
    Trừ khác</td>
  <td colspan=4 class=xl112 width=0 style='border-right:.5pt solid black;
  border-left:none'>STOP WORKING(DEDUCTION)</td>
  <td rowspan=3 class=xl102 width=97 style='border-bottom:.5pt solid black;
  width:73pt'>Gross<br>
    Salary<br>
    TNTT</td>
  <td colspan=4 class=xl112 width=355 style='border-right:.5pt solid black;
  border-left:none;width:267pt'>DEDUCTION</td>
  <td rowspan=3 class=xl102 width=97 style='border-bottom:.5pt solid black;
  width:73pt'>Probation Insurance<br>
    (21%) BHTV<br>
    </td>
  
  <td rowspan=3 class=xl102 width=69 style='border-bottom:.5pt solid black;
  width:52pt'>BALANCE<br>
    Bù Lương<br>
    (No PIT)</td>
  <td rowspan=3 class=xl102 width=69 style='border-bottom:.5pt solid black;
  width:52pt'>Advanced<br>
    (No PIT)</td>
  <td rowspan=3 class=xl102 width=94 style='border-bottom:.5pt solid black;
  width:71pt'>Net Salary<br>
    Lương Thực Nhận</td>
  <td rowspan=3 class=xl105 width=86 style='border-bottom:.5pt solid black;
  width:65pt'>SIGNATURE<br>
    KÝ NHẬN</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>RECEIVED
  DATE</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>Employee
  Type<br>
    Kiểu tính OT cho nhân viên</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>DEDUCT
  PIT<br>
    Giảm trừ thuế</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>BEGIN
  CONTRACT<br>
    Ngày ký HĐLĐ</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>OT
  TAX 100%<br>
    Tăng ca tính thuế</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>OT
  TAX 100%<br>
    Tăng ca tính thuế</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=2 height=120 class=xl117 width=0 style='border-bottom:.5pt solid black;
  height:90.0pt;border-top:none'>W.DAYS<br>
    Level 1</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>W.DAYS<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=65 style='border-bottom:.5pt solid black;
  border-top:none;width:49pt'>W.DAYS<br>
    Ngày làm</td>
  <td rowspan=2 class=xl102 width=76 style='border-bottom:.5pt solid black;
  border-top:none;width:57pt'>R.Salary<br>
    L/Tháng</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Annual Leave<br>
    Level 1</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Annual Leave<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=69 style='border-bottom:.5pt solid black;
  border-top:none;width:52pt'>Annual Leave<br>
    Ngày phép năm</td>
  <td rowspan=2 class=xl102 width=71 style='border-bottom:.5pt solid black;
  border-top:none;width:53pt'>Annual Leave AMT<br>
    Tiền Ngày<span style='mso-spacerun:yes'>  </span>PN</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>OT<br>
    Level 1</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>OT<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=68 style='border-bottom:.5pt solid black;
  border-top:none;width:51pt'>OT<br>
    Giờ T/Ca</td>
  <td rowspan=2 class=xl102 width=68 style='border-bottom:.5pt solid black;
  border-top:none;width:51pt'>Hours Salary<br>
    OT<br>
    (150%)</td>
  <td rowspan=2 class=xl102 width=77 style='border-bottom:.5pt solid black;
  border-top:none;width:58pt'>Total<span style='mso-spacerun:yes'> 
  </span>OT<br>
    Tiền T/Ca</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none' x:str="ST&#10;Level 1 ">ST<br>
    Level 1<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>ST<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=66 style='border-bottom:.5pt solid black;
  border-top:none;width:50pt' x:str="ST&#10;Giờ T/Ca ">ST<br>
    Giờ T/Ca<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=67 style='border-bottom:.5pt solid black;
  border-top:none;width:50pt'>Hours<br>
    Salary OT<br>
    (200%)</td>
  <td rowspan=2 class=xl102 width=48 style='border-bottom:.5pt solid black;
  border-top:none;width:36pt'>Total Sunday<br>
    Tiền T/Ca</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>NT<br>
    Level 1</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>NT<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=70 style='border-bottom:.5pt solid black;
  border-top:none;width:53pt'>NT<br>
    Giờ T/Ca</td>
  <td rowspan=2 class=xl102 width=62 style='border-bottom:.5pt solid black;
  border-top:none;width:47pt'><br>
    Night Shift<br>
    (215%)</td>
  <td rowspan=2 class=xl102 width=62 style='border-bottom:.5pt solid black;
  border-top:none;width:47pt'>Total Night<br>
    Tiền T/Ca</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>HT<br>
    Level 1</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>HT<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=70 style='border-bottom:.5pt solid black;
  border-top:none;width:53pt'>HT<br>
    Giờ T/Ca</td>
  <td rowspan=2 class=xl102 width=62 style='border-bottom:.5pt solid black;
  border-top:none;width:47pt'><br>
    Night Shift<br>
    (300%)</td>
  <td rowspan=2 class=xl102 width=62 style='border-bottom:.5pt solid black;
  border-top:none;width:47pt'>Total Night<br>
    Tiền T/Ca</td>
  <td rowspan=2 class=xl102 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Card ID</td>
  <td rowspan=2 class=xl102 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Check Healthy</td>
  <td rowspan=2 class=xl102 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Uniform</td>
  <td rowspan=2 class=xl102 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Break Contract</td>
  <td rowspan=2 class=xl102 width=69 style='border-bottom:.5pt solid black;
  border-top:none;width:52pt'>PIT<br>
    TTN</td>
  <td rowspan=2 class=xl102 width=76 style='border-bottom:.5pt solid black;
  border-top:none;width:57pt'>SOCIAL-HEALTH<br>
    INSURANCE ( BHXH , YT 8.5%)</td>
  <td rowspan=2 class=xl102 width=74 style='border-bottom:.5pt solid black;
  border-top:none;width:56pt'>Jobless<br>
    (BHTN<br>
    1%)</td>
  <td rowspan=2 class=xl102 width=68 style='border-bottom:.5pt solid black;
  border-top:none;width:51pt'>UNION DUES<br>
    Quỹ Công Đoàn<br>
    </td>
  
 </tr>
 <tr class=xl46 height=101 style='mso-height-source:userset;height:75.75pt'>
 </tr>
 <%
     int i = 0, j = 1;
     int flag1 = 0, flag2 = 0;
     int j2 = 0;
     for (i = 0; i < dt_Emp.Rows.Count; i++)
     {
         if (i == 0)
             flag1 = 1;
         else if (dt_Emp.Rows[i]["c2"].ToString() != dt_Emp.Rows[i - 1]["c2"].ToString())
         {
             flag1 = 1;
             j = 1;
         }
         else
         {
             flag1 = 0;
             j++;
         }

         if (i == dt_Emp.Rows.Count-1)
             flag2 = 1;
         else if ( i < dt_Emp.Rows.Count-1 && dt_Emp.Rows[i]["c2"].ToString() != dt_Emp.Rows[i + 1]["c2"].ToString())
             flag2 = 1;
         else flag2 = 0;
      %>
 <%
        if (flag1 == 1)
        { %>
 <tr class=xl47 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl48 colspan=4 style='height:30.0pt;mso-ignore:colspan'
  x:str>SALARY DETAILS OF: <%=dt_Emp.Rows[i]["c2"].ToString() %></td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
 </tr>
 <%     } %>
 <tr class=xl47 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl54 style='height:24.0pt' x:num><%=j %></td>
  <td class=xl55 x:str><%=dt_Emp.Rows[i]["c00"].ToString() %></td>
  <td class=xl56><%=dt_Emp.Rows[i]["c01"].ToString() %></td>
  <td class=xl57><%=dt_Emp.Rows[i]["c02"].ToString() %></td>
  <td class=xl55 x:str><%=dt_Emp.Rows[i]["c03"].ToString() %></td>
  <td class=xl55 x:str><%=dt_Emp.Rows[i]["c04"].ToString() %></td>
  <td class=xl55 x:str><%=dt_Emp.Rows[i]["c05"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c06"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c07"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c08"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c09"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c10"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c11"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c12"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c13"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c14"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c15"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c16"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c17"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c18"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c19"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c20"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c21"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c22"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c23"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c24"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c25"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c26"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c27"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c28"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c29"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c30"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c31"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c32"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c33"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c34"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c35"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c36"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c37"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c38"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c39"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c40"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c41"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c42"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c43"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c44"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c45"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c46"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c47"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c48"].ToString() %></td>
  <td class=xl60 x:num><%=dt_Emp.Rows[i]["c49"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c50"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c51"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c52"].ToString() %></td>  
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c54"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c53"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c55"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c56"].ToString() %></td>
  <td class=xl60 x:num><%=dt_Emp.Rows[i]["c57"].ToString() %></td>
  <td class=xl61 x:num>&nbsp;</td>
  <td class=xl61 x:num>&nbsp;</td>
  <td class=xl61 x:num><%=dt_Emp.Rows[i]["c58"].ToString() %></td>
  <td class=xl61 x:num><%=dt_Emp.Rows[i]["c59"].ToString() %></td>
  <td class=xl61 x:str><%=dt_Emp.Rows[i]["c60"].ToString() %></td>
  <td class=xl61 x:num><%=dt_Emp.Rows[i]["c61"].ToString() %></td>
  <td class=xl61 x:num><%=dt_Emp.Rows[i]["c62"].ToString() %></td>
  
 </tr> <!-- -->
<!-- <tr class=xl47 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl62 style='height:24.0pt' x:num>1</td>
  <td class=xl63 x:num>12574</td>
  <td class=xl64>Trần Thị Ngân</td>
  <td class=xl65>Leader</td>
  <td class=xl63>99/99/9999</td>
  <td class=xl63>99/99/9999</td>
  <td class=xl63>99/99/9999</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
 </tr>  <!-- -->
 <%
        if (flag2 == 1)
        { %> 
 <tr class=xl47 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=7 height=40 class=xl119 style='height:30.0pt'>SUB TOTAL OF:<%=dt_Emp.Rows[i]["c2"].ToString() %></td>
  <td class=xl128 x:num><%=dt_Sum.Rows[j2]["c06"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c07"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c08"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c09"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c10"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c11"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c12"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c13"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c14"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c15"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c16"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c17"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c18"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c19"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c20"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c21"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c22"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c23"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c24"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c25"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c26"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c27"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c28"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c29"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c30"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c31"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c32"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c33"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c34"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c35"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c36"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c37"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c38"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c39"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c40"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c41"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c42"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c43"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c44"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c45"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c46"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c47"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c48"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c49"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c50"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c51"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c52"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c54"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c53"].ToString() %></td>
  
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c55"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c56"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c57"].ToString() %></td>
  <td class=xl72 x:num>&nbsp;</td>
  <td class=xl73 x:num>&nbsp;</td>
  <td class=xl73 x:num><%=dt_Sum.Rows[j2]["c59"].ToString() %></td>
  <td class=xl73 x:num>&nbsp;</td>
  <td class=xl73 x:num><%=dt_Sum.Rows[j2]["c61"].ToString() %></td>
  <td class=xl73 x:num><%=dt_Sum.Rows[j2++]["c62"].ToString() %></td>
  <td class=xl73 x:num>&nbsp;</td>

 </tr>
 <%     } %> 
 <%
     if (flag2 == 1)
     { %>
 <tr height=21 style='height:15.75pt; display:none;'>
  <td height=21 colspan=2 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl76></td>
  <td class=xl31></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td class=xl77></td>
  <td class=xl78></td>
  <td class=xl79></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl78></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl78></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt; display:none;'>
  <td height=21 colspan=2 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl81>PREPARED BY</td>
  <td class=xl31></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl123 x:str="  PERSONNAL MANAGER "><span
  style='mso-spacerun:yes'>  </span>PERSONNAL MANAGER<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl33></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl124>CHIEF ACCOUNT</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=5 class=xl82 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl81>F. MANAGER</td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl125>G.MANAGER</td>
  <td class=xl83>&nbsp;</td>
  <td colspan=6 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl126>MANAGING DIRECTOR</td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81>G.DIRECTOR</td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt; display:none;'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt; display:none;'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt; display:none;'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt; display:none;'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt; display:none;'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt; display:none;'>
  <td height=21 colspan=4 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=28 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt; display:none;'>
  <td height=21 colspan=2 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl81>TRAN CAM THE</td>
  <td class=xl31></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl123>DO TRUNG HIEU</td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td class=xl78></td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td class=xl78></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl127>DUONG THI THANH TAM</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=5 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl81>KANG KYUNG HEE</td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81>BAEK CHOL SOO</td>
  <td colspan=7 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl81>SHIN CHANG UK</td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81>SEO PETER HAE WON</td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
        <%} %>
 <%     } //end for %>
 <tr class=xl47 height=47 style='mso-height-source:userset;height:35.25pt'>
  <td colspan=7 height=47 class=xl121 style='height:35.25pt'>GRAND TOTAL</td>
  <td class=xl129 style='border-top:none' x:num><%=dt_SumGrand.Rows[0]["c06"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c07"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c08"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c09"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c10"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c11"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c12"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c13"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c14"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c15"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c16"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c17"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c18"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c19"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c20"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c21"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c22"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c23"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c24"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c25"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c26"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c27"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c28"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c29"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c30"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c31"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c32"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c33"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c34"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c35"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c36"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c37"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c38"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c39"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c40"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c41"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c42"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c43"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c44"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c45"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c46"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c47"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c48"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c49"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c50"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c51"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c52"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c54"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c53"].ToString() %></td>
  
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c55"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c56"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c57"].ToString() %></td>
  <td class=xl53 x:num>&nbsp;</td>
  <td class=xl53 x:num><%=dt_SumGrand.Rows[0]["c59"].ToString() %></td>
  <td class=xl53 x:num>&nbsp;</td>
  <td class=xl53 x:num><%=dt_SumGrand.Rows[0]["c61"].ToString() %></td>
  <td class=xl53 x:num><%=dt_SumGrand.Rows[0]["c62"].ToString() %></td>
  <td class=xl53 x:num>&nbsp;</td>
  <td class=xl53 x:num>&nbsp;</td>
 </tr> <!-- -->
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_employee_payroll_st2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_payroll_st2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_payroll_st2_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Huong</o:Author>
  <o:LastAuthor>SV108</o:LastAuthor>
  <o:LastPrinted>2013-07-13T06:56:35Z</o:LastPrinted>
  <o:Created>2013-07-12T03:29:21Z</o:Created>
  <o:LastSaved>2013-07-13T07:06:33Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.55in .28in .47in .38in;
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
.style21
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
	mso-style-name:"Normal 12";}
.style22
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
.style23
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
	mso-style-name:"Normal 5";}
.style24
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
	mso-style-name:"Normal 6";}
.style25
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
	mso-style-name:"Normal 7";}
.style26
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
	mso-style-name:"Normal 8";}
.style27
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
	mso-style-name:"Normal 9";}
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
.xl31
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";}
.xl36
	{mso-style-parent:style22;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl40
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl41
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl42
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";}
.xl43
	{mso-style-parent:style23;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl44
	{mso-style-parent:style24;
	color:windowtext;
	font-size:18.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl45
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl46
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
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
.xl54
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
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
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl82
	{mso-style-parent:style25;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	background:white;
	mso-pattern:auto none;}
.xl83
	{mso-style-parent:style26;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	background:white;
	mso-pattern:auto none;}
.xl84
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	background:white;
	mso-pattern:auto none;}
.xl85
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl86
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-size:10.0pt;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.000";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl120
	{mso-style-parent:style0;
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
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl121
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl122
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCCCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl123
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
.xl124
	{mso-style-parent:style25;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl125
	{mso-style-parent:style26;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl126
	{mso-style-parent:style27;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style21;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl129
	{mso-style-parent:style0;
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>8</x:PaperSizeIndex>
      <x:Scale>45</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:SplitVertical>10</x:SplitVertical>
     <x:LeftColumnRightPane>10</x:LeftColumnRightPane>
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
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
       <x:RangeSelection>$C$4:$C$6</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     <%
        int irow=6;
        
        for (int k=0;k<dt_Emp.Rows.Count;k++)
        {
            irow++;            
            if (k < dt_Emp.Rows.Count - 1)
            {
                if ( dt_Emp.Rows[k]["c2"].ToString() != dt_Emp.Rows[k+1]["c2"].ToString() )
                {   
                    irow+=11;                
                %>
                    <x:RowBreak>
                        <x:Row><%=irow %></x:Row>
                    </x:RowBreak>
                <%
                }                
            }                    
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9915</x:WindowHeight>
  <x:WindowWidth>19320</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl31>

<table x:str border=0 cellpadding=0 cellspacing=0 width=3127 style='border-collapse:
 collapse;table-layout:fixed;width:2353pt'>
 <col class=xl31 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl31 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl31 width=154 style='mso-width-source:userset;mso-width-alt:5632;
 width:116pt'>
 <col class=xl31 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl32 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl32 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2779'><!-- confirm date -->
 <col class=xl33 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl33 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl33 width=80 style='mso-width-source:userset;mso-width-alt:2925;
 width:60pt'>
 <col class=xl34 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2377'><!-- WT -->
 <col class=xl35 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl33 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2523'><!-- ALE -->
 <col class=xl35 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl33 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2486'>
 <col class=xl35 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl33 width=68 style='display:none;mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl33 width=77 style='mso-width-source:userset;mso-width-alt:2816;
 width:58pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2413'>
 <col class=xl35 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl33 width=67 style='display:none;mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
<col class=xl35 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2560'>
 <col class=xl35 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl33 width=62 span=1 style='display:none;mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <col class=xl33 width=62 span=1 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <col class=xl35 width=0 span=2 style='display:none;mso-width-source:userset;
 mso-width-alt:2560'>
 <col class=xl35 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl33 width=62 span=1 style='display:none;mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <col class=xl33 width=62 span=1 style='mso-width-source:userset;mso-width-alt:
 2267;width:47pt'>
 <col class=xl33 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl33 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl33 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl33 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl33 width=80 span=3 style='mso-width-source:userset;mso-width-alt:
 2925;width:60pt'>
 <col class=xl33 width=0 span=4 style='display:none;mso-width-source:userset;
 mso-width-alt:2925'>
 <col class=xl33 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl33 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl33 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl33 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl33 width=68 span=2 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl33 width=69 span=2 style='mso-width-source:userset;mso-width-alt:
 2523;width:52pt'>
 <col class=xl33 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl34 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl34 width=0 span=6 style='display:none;mso-width-source:userset;
 mso-width-alt:3145'>
 <tr height=28 style='height:21.0pt'>
  <td height=28 class=xl36 colspan=8 width=483 style='height:21.0pt;mso-ignore:
  colspan;width:363pt'>SUN GARMENT TEXTILE VIET NAM CO.,LTD</td>
  <td class=xl33 width=82 style='width:62pt'></td>
  <td class=xl33 width=80 style='width:60pt'></td>
  <td class=xl34 width=63 style='width:47pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=65 style='width:49pt'></td>
  <td class=xl33 width=76 style='width:57pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=69 style='width:52pt'></td>
  <td class=xl33 width=71 style='width:53pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=68 style='width:51pt'></td>
  <td class=xl33 width=68 style='width:51pt'></td>
  <td class=xl33 width=77 style='width:58pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=66 style='width:50pt'></td>
  <td class=xl33 width=67 style='width:50pt'></td>
  <td class=xl33 width=48 style='width:36pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=70 style='width:53pt'></td>
  <td class=xl33 width=62 style='width:47pt'></td>
  <td class=xl33 width=62 style='width:47pt'></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=0></td>
  <td class=xl35 width=70 style='width:53pt'></td>
  <td class=xl33 width=62 style='width:47pt'></td>
  <td class=xl33 width=62 style='width:47pt'></td>
  <td class=xl33 width=86 style='width:65pt'></td>
  <td class=xl33 width=88 style='width:66pt'></td>
  <td class=xl33 width=87 style='width:65pt'></td>
  <td class=xl33 width=85 style='width:64pt'></td>
  <td class=xl33 width=80 style='width:60pt'></td>
  <td class=xl33 width=80 style='width:60pt'></td>
  <td class=xl33 width=80 style='width:60pt'></td>
  <td class=xl33 width=0></td>
  <td class=xl33 width=0></td>
  <td class=xl33 width=0></td>
  <td class=xl33 width=0></td>
  <td class=xl33 width=97 style='width:73pt'></td>
  <td class=xl33 width=69 style='width:52pt'></td>
  <td class=xl33 width=76 style='width:57pt'></td>
  <td class=xl33 width=74 style='width:56pt'></td>
  <td class=xl33 width=68 style='width:51pt'></td>
  <td class=xl33 width=68 style='width:51pt'></td>
  <td class=xl33 width=69 style='width:52pt'></td>
  <td class=xl33 width=69 style='width:52pt'></td>
  <td class=xl33 width=94 style='width:71pt'></td>
  <td class=xl34 width=86 style='width:65pt'></td>
  <td class=xl34 width=0></td>
  <td class=xl34 width=0></td>
  <td class=xl34 width=0></td>
  <td class=xl34 width=0></td>
  <td class=xl34 width=0></td>
  <td class=xl34 width=0></td>
 </tr>
 <tr class=xl37 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=66 height=30 class=xl85 style='height:22.5pt'>SALARY PAYMENT
  TABLE FOR DAILY WORKERS</td>
 </tr>
 <tr height=36 style='height:27.0pt'>
  <td height=36 colspan=4 class=xl38 style='height:27.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl40 style='mso-ignore:colspan'></td>
  <td class=xl41></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td class=xl40></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td class=xl40></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td class=xl42></td>
  <td colspan=9 class=xl86>PAYROLL OF JUN-2013</td>
  <td colspan=17 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl44 style='mso-ignore:colspan'></td>
  <td class=xl45>Actual pay date 10/07/2013</td>
  <td colspan=7 class=xl41 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td rowspan=3 height=148 class=xl87 width=46 style='border-bottom:.5pt solid black;
  height:111.0pt;width:35pt'>NO<br>
    STT</td>
  <td rowspan=3 class=xl90 width=41 style='border-bottom:.5pt solid black;
  width:31pt'>ID No<br>
    MNV</td>
  <td rowspan=3 class=xl90 width=154 style='border-bottom:.5pt solid black;
  width:116pt'>Full Name<br>
    Họ và Tên</td>
  <td rowspan=3 class=xl93 width=83 style='border-bottom:.5pt solid black;
  width:62pt'>Position<br>
    Công việc</td>
  <td rowspan=3 class=xl96 width=76 style='border-bottom:.5pt solid black;
  width:57pt'><span style='mso-spacerun:yes'> </span>D.O.H<br>
    Ngày vào</td>
  <td rowspan=3 class=xl96 width=0 style='border-bottom:.5pt solid black'>Left
  date<br>
    Ngày nghỉ việc</td>
  <td rowspan=3 class=xl96 width=0 style='border-bottom:.5pt solid black'>Confirm
  Date<br>
    Ngày thay đổi lương</td>
  <td rowspan=3 class=xl99 width=83 style='border-bottom:.5pt solid black;
  width:62pt'>SALARY LEVEL 1</td>
  <td rowspan=3 class=xl99 width=82 style='border-bottom:.5pt solid black;
  width:62pt'>SALARY LEVEL 2</td>
  <td rowspan=3 class=xl102 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>SKILLED<br>
    Chuyên môn, Trách nhiệm</td>
  <td rowspan=3 class=xl105 width=63 style='border-bottom:.5pt solid black;
  width:47pt'>R.Hours<br>
    TG LV</td>
  <td colspan=4 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>NGÀY CÔNG</td>
  <td colspan=4 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>PHÉP NĂM</td>
  <td colspan=5 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>EXTRA/ TĂNG CA 150%</td>
  <td colspan=5 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>EXTRA/ TĂNG CA 200%</td>
  <td colspan=5 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>EXTRA/ TĂNG CA 215%</td>
  <td colspan=5 class=xl109 style='border-right:.5pt solid black;border-left:
  none'>EXTRA/ TĂNG CA 300%</td>
  <td rowspan=3 class=xl102 width=86 style='border-bottom:.5pt solid black;
  width:65pt'>Total<span style='mso-spacerun:yes'>  </span>Salary<br>
    Lương&amp; T/C</td>
  <td rowspan=3 class=xl102 width=88 style='border-bottom:.5pt solid black;
  width:66pt'>Full Attandance Allowance<br>
    ( Chuyên cần)</td>
  <td rowspan=3 class=xl102 width=87 style='border-bottom:.5pt solid black;
  width:65pt'>Housing<br>
    <span style='mso-spacerun:yes'> </span>Allowance<br>
    (Tiền<span style='mso-spacerun:yes'>  </span>nhà)</td>
  <td rowspan=3 class=xl102 width=85 style='border-bottom:.5pt solid black;
  width:64pt'>Petrol<br>
    Allowance<br>
    ( P/cấp xăng )</td>
  <td rowspan=3 class=xl102 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>Child<br>
    Care<br>
    Allowance<span style='mso-spacerun:yes'>  </span>(P/C Con nhỏ)</td>
  <td rowspan=3 class=xl102 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>Return with PIT<br>
    Hoàn trả/Bù lương</td>
  <td rowspan=3 class=xl102 width=80 style='border-bottom:.5pt solid black;
  width:60pt'>Advanced<br>
    Trừ khác</td>
  <td colspan=4 class=xl112 width=0 style='border-right:.5pt solid black;
  border-left:none'>STOP WORKING(DEDUCTION)</td>
  <td rowspan=3 class=xl102 width=97 style='border-bottom:.5pt solid black;
  width:73pt'>Gross<br>
    Salary<br>
    TNTT</td>
  <td colspan=4 class=xl112 width=355 style='border-right:.5pt solid black;
  border-left:none;width:267pt'>DEDUCTION</td>
  <td rowspan=3 class=xl102 width=97 style='border-bottom:.5pt solid black;
  width:73pt'>Probation Insurance<br>
    (21%) BHTV<br>
    </td>
  
  <td rowspan=3 class=xl102 width=69 style='border-bottom:.5pt solid black;
  width:52pt'>BALANCE<br>
    Bù Lương<br>
    (No PIT)</td>
  <td rowspan=3 class=xl102 width=69 style='border-bottom:.5pt solid black;
  width:52pt'>Advanced<br>
    (No PIT)</td>
  <td rowspan=3 class=xl102 width=94 style='border-bottom:.5pt solid black;
  width:71pt'>Net Salary<br>
    Lương Thực Nhận</td>
  <td rowspan=3 class=xl105 width=86 style='border-bottom:.5pt solid black;
  width:65pt'>SIGNATURE<br>
    KÝ NHẬN</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>RECEIVED
  DATE</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>Employee
  Type<br>
    Kiểu tính OT cho nhân viên</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>DEDUCT
  PIT<br>
    Giảm trừ thuế</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>BEGIN
  CONTRACT<br>
    Ngày ký HĐLĐ</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>OT
  TAX 100%<br>
    Tăng ca tính thuế</td>
  <td rowspan=3 class=xl114 width=0 style='border-bottom:.5pt solid black'>OT
  TAX 100%<br>
    Tăng ca tính thuế</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td rowspan=2 height=120 class=xl117 width=0 style='border-bottom:.5pt solid black;
  height:90.0pt;border-top:none'>W.DAYS<br>
    Level 1</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>W.DAYS<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=65 style='border-bottom:.5pt solid black;
  border-top:none;width:49pt'>W.DAYS<br>
    Ngày làm</td>
  <td rowspan=2 class=xl102 width=76 style='border-bottom:.5pt solid black;
  border-top:none;width:57pt'>R.Salary<br>
    L/Tháng</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Annual Leave<br>
    Level 1</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Annual Leave<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=69 style='border-bottom:.5pt solid black;
  border-top:none;width:52pt'>Annual Leave<br>
    Ngày phép năm</td>
  <td rowspan=2 class=xl102 width=71 style='border-bottom:.5pt solid black;
  border-top:none;width:53pt'>Annual Leave AMT<br>
    Tiền Ngày<span style='mso-spacerun:yes'>  </span>PN</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>OT<br>
    Level 1</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>OT<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=68 style='border-bottom:.5pt solid black;
  border-top:none;width:51pt'>OT<br>
    Giờ T/Ca</td>
  <td rowspan=2 class=xl102 width=68 style='border-bottom:.5pt solid black;
  border-top:none;width:51pt'>Hours Salary<br>
    OT<br>
    (150%)</td>
  <td rowspan=2 class=xl102 width=77 style='border-bottom:.5pt solid black;
  border-top:none;width:58pt'>Total<span style='mso-spacerun:yes'> 
  </span>OT<br>
    Tiền T/Ca</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none' x:str="ST&#10;Level 1 ">ST<br>
    Level 1<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>ST<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=66 style='border-bottom:.5pt solid black;
  border-top:none;width:50pt' x:str="ST&#10;Giờ T/Ca ">ST<br>
    Giờ T/Ca<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl102 width=67 style='border-bottom:.5pt solid black;
  border-top:none;width:50pt'>Hours<br>
    Salary OT<br>
    (200%)</td>
  <td rowspan=2 class=xl102 width=48 style='border-bottom:.5pt solid black;
  border-top:none;width:36pt'>Total Sunday<br>
    Tiền T/Ca</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>NT<br>
    Level 1</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>NT<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=70 style='border-bottom:.5pt solid black;
  border-top:none;width:53pt'>NT<br>
    Giờ T/Ca</td>
  <td rowspan=2 class=xl102 width=62 style='border-bottom:.5pt solid black;
  border-top:none;width:47pt'><br>
    Night Shift<br>
    (215%)</td>
  <td rowspan=2 class=xl102 width=62 style='border-bottom:.5pt solid black;
  border-top:none;width:47pt'>Total Night<br>
    Tiền T/Ca</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>HT<br>
    Level 1</td>
  <td rowspan=2 class=xl117 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>HT<br>
    Level 2</td>
  <td rowspan=2 class=xl117 width=70 style='border-bottom:.5pt solid black;
  border-top:none;width:53pt'>HT<br>
    Giờ T/Ca</td>
  <td rowspan=2 class=xl102 width=62 style='border-bottom:.5pt solid black;
  border-top:none;width:47pt'><br>
    Night Shift<br>
    (300%)</td>
  <td rowspan=2 class=xl102 width=62 style='border-bottom:.5pt solid black;
  border-top:none;width:47pt'>Total Night<br>
    Tiền T/Ca</td>
  <td rowspan=2 class=xl102 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Card ID</td>
  <td rowspan=2 class=xl102 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Check Healthy</td>
  <td rowspan=2 class=xl102 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Uniform</td>
  <td rowspan=2 class=xl102 width=0 style='border-bottom:.5pt solid black;
  border-top:none'>Break Contract</td>
  <td rowspan=2 class=xl102 width=69 style='border-bottom:.5pt solid black;
  border-top:none;width:52pt'>PIT<br>
    TTN</td>
  <td rowspan=2 class=xl102 width=76 style='border-bottom:.5pt solid black;
  border-top:none;width:57pt'>SOCIAL-HEALTH<br>
    INSURANCE ( BHXH , YT 8.5%)</td>
  <td rowspan=2 class=xl102 width=74 style='border-bottom:.5pt solid black;
  border-top:none;width:56pt'>Jobless<br>
    (BHTN<br>
    1%)</td>
  <td rowspan=2 class=xl102 width=68 style='border-bottom:.5pt solid black;
  border-top:none;width:51pt'>UNION DUES<br>
    Quỹ Công Đoàn<br>
    </td>
  
 </tr>
 <tr class=xl46 height=101 style='mso-height-source:userset;height:75.75pt'>
 </tr>
 <%
     int i = 0, j = 1;
     int flag1 = 0, flag2 = 0;
     int j2 = 0;
     for (i = 0; i < dt_Emp.Rows.Count; i++)
     {
         if (i == 0)
             flag1 = 1;
         else if (dt_Emp.Rows[i]["c2"].ToString() != dt_Emp.Rows[i - 1]["c2"].ToString())
         {
             flag1 = 1;
             j = 1;
         }
         else
         {
             flag1 = 0;
             j++;
         }

         if (i == dt_Emp.Rows.Count-1)
             flag2 = 1;
         else if ( i < dt_Emp.Rows.Count-1 && dt_Emp.Rows[i]["c2"].ToString() != dt_Emp.Rows[i + 1]["c2"].ToString())
             flag2 = 1;
         else flag2 = 0;
      %>
 <%
        if (flag1 == 1)
        { %>
 <tr class=xl47 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl48 colspan=4 style='height:30.0pt;mso-ignore:colspan'
  x:str>SALARY DETAILS OF: <%=dt_Emp.Rows[i]["c2"].ToString() %></td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
 </tr>
 <%     } %>
 <tr class=xl47 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl54 style='height:24.0pt' x:num><%=j %></td>
  <td class=xl55 x:str><%=dt_Emp.Rows[i]["c00"].ToString() %></td>
  <td class=xl56><%=dt_Emp.Rows[i]["c01"].ToString() %></td>
  <td class=xl57><%=dt_Emp.Rows[i]["c02"].ToString() %></td>
  <td class=xl55 x:str><%=dt_Emp.Rows[i]["c03"].ToString() %></td>
  <td class=xl55 x:str><%=dt_Emp.Rows[i]["c04"].ToString() %></td>
  <td class=xl55 x:str><%=dt_Emp.Rows[i]["c05"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c06"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c07"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c08"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c09"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c10"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c11"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c12"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c13"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c14"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c15"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c16"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c17"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c18"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c19"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c20"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c21"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c22"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c23"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c24"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c25"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c26"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c27"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c28"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c29"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c30"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c31"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c32"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c33"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c34"].ToString() %></td>
  <td class=xl59 x:num><%=dt_Emp.Rows[i]["c35"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c36"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c37"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c38"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c39"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c40"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c41"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c42"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c43"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c44"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c45"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c46"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c47"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c48"].ToString() %></td>
  <td class=xl60 x:num><%=dt_Emp.Rows[i]["c49"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c50"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c51"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c52"].ToString() %></td>  
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c54"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c53"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c55"].ToString() %></td>
  <td class=xl58 x:num><%=dt_Emp.Rows[i]["c56"].ToString() %></td>
  <td class=xl60 x:num><%=dt_Emp.Rows[i]["c57"].ToString() %></td>
  <td class=xl61 x:num>&nbsp;</td>
  <td class=xl61 x:num>&nbsp;</td>
  <td class=xl61 x:num><%=dt_Emp.Rows[i]["c58"].ToString() %></td>
  <td class=xl61 x:num><%=dt_Emp.Rows[i]["c59"].ToString() %></td>
  <td class=xl61 x:str><%=dt_Emp.Rows[i]["c60"].ToString() %></td>
  <td class=xl61 x:num><%=dt_Emp.Rows[i]["c61"].ToString() %></td>
  <td class=xl61 x:num><%=dt_Emp.Rows[i]["c62"].ToString() %></td>
  
 </tr> <!-- -->
<!-- <tr class=xl47 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl62 style='height:24.0pt' x:num>1</td>
  <td class=xl63 x:num>12574</td>
  <td class=xl64>Trần Thị Ngân</td>
  <td class=xl65>Leader</td>
  <td class=xl63>99/99/9999</td>
  <td class=xl63>99/99/9999</td>
  <td class=xl63>99/99/9999</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
 </tr>  <!-- -->
 <%
        if (flag2 == 1)
        { %> 
 <tr class=xl47 height=40 style='mso-height-source:userset;height:30.0pt'>
  <td colspan=7 height=40 class=xl119 style='height:30.0pt'>SUB TOTAL OF:<%=dt_Emp.Rows[i]["c2"].ToString() %></td>
  <td class=xl128 x:num><%=dt_Sum.Rows[j2]["c06"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c07"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c08"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c09"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c10"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c11"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c12"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c13"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c14"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c15"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c16"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c17"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c18"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c19"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c20"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c21"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c22"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c23"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c24"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c25"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c26"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c27"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c28"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c29"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c30"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c31"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c32"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c33"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c34"].ToString() %></td>
  <td class=xl71 x:num><%=dt_Sum.Rows[j2]["c35"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c36"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c37"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c38"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c39"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c40"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c41"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c42"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c43"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c44"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c45"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c46"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c47"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c48"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c49"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c50"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c51"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c52"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c54"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c53"].ToString() %></td>
  
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c55"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c56"].ToString() %></td>
  <td class=xl70 x:num><%=dt_Sum.Rows[j2]["c57"].ToString() %></td>
  <td class=xl72 x:num>&nbsp;</td>
  <td class=xl73 x:num>&nbsp;</td>
  <td class=xl73 x:num><%=dt_Sum.Rows[j2]["c59"].ToString() %></td>
  <td class=xl73 x:num>&nbsp;</td>
  <td class=xl73 x:num><%=dt_Sum.Rows[j2]["c61"].ToString() %></td>
  <td class=xl73 x:num><%=dt_Sum.Rows[j2++]["c62"].ToString() %></td>
  <td class=xl73 x:num>&nbsp;</td>

 </tr>
 <%     } %> 
 <%
     if (flag2 == 1)
     { %>
 <tr height=21 style='height:15.75pt; display:none;'>
  <td height=21 colspan=2 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl76></td>
  <td class=xl31></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td class=xl77></td>
  <td class=xl78></td>
  <td class=xl79></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl78></td>
  <td colspan=2 class=xl80 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl78></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt; display:none;'>
  <td height=21 colspan=2 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl81>PREPARED BY</td>
  <td class=xl31></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl123 x:str="  PERSONNAL MANAGER "><span
  style='mso-spacerun:yes'>  </span>PERSONNAL MANAGER<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl33></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl124>CHIEF ACCOUNT</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=5 class=xl82 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl81>F. MANAGER</td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl125>G.MANAGER</td>
  <td class=xl83>&nbsp;</td>
  <td colspan=6 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl126>MANAGING DIRECTOR</td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81>G.DIRECTOR</td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt; display:none;'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt; display:none;'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt; display:none;'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt; display:none;'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt; display:none;'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=22 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt; display:none;'>
  <td height=21 colspan=4 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td class=xl33></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=28 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt; display:none;'>
  <td height=21 colspan=2 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl81>TRAN CAM THE</td>
  <td class=xl31></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td colspan=3 class=xl123>DO TRUNG HIEU</td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td class=xl78></td>
  <td colspan=2 class=xl79 style='mso-ignore:colspan'></td>
  <td class=xl79></td>
  <td class=xl78></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl127>DUONG THI THANH TAM</td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=5 class=xl84 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=5 class=xl81>KANG KYUNG HEE</td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81>BAEK CHOL SOO</td>
  <td colspan=7 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl81>SHIN CHANG UK</td>
  <td colspan=3 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl81>SEO PETER HAE WON</td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
        <%} %>
 <%     } //end for %>
 <tr class=xl47 height=47 style='mso-height-source:userset;height:35.25pt'>
  <td colspan=7 height=47 class=xl121 style='height:35.25pt'>GRAND TOTAL</td>
  <td class=xl129 style='border-top:none' x:num><%=dt_SumGrand.Rows[0]["c06"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c07"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c08"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c09"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c10"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c11"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c12"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c13"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c14"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c15"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c16"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c17"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c18"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c19"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c20"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c21"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c22"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c23"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c24"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c25"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c26"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c27"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c28"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c29"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c30"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c31"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c32"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c33"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c34"].ToString() %></td>
  <td class=xl75 x:num><%=dt_SumGrand.Rows[0]["c35"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c36"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c37"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c38"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c39"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c40"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c41"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c42"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c43"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c44"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c45"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c46"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c47"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c48"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c49"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c50"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c51"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c52"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c54"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c53"].ToString() %></td>
  
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c55"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c56"].ToString() %></td>
  <td class=xl74 x:num><%=dt_SumGrand.Rows[0]["c57"].ToString() %></td>
  <td class=xl53 x:num>&nbsp;</td>
  <td class=xl53 x:num><%=dt_SumGrand.Rows[0]["c59"].ToString() %></td>
  <td class=xl53 x:num>&nbsp;</td>
  <td class=xl53 x:num><%=dt_SumGrand.Rows[0]["c61"].ToString() %></td>
  <td class=xl53 x:num><%=dt_SumGrand.Rows[0]["c62"].ToString() %></td>
  <td class=xl53 x:num>&nbsp;</td>
  <td class=xl53 x:num>&nbsp;</td>
 </tr> <!-- -->
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
