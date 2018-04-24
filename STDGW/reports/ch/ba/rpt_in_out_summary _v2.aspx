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
   
    string p_tco_dept_pk, p_thr_group_pk, p_status, p_emp_id, p_work_mon, p_from_dt, p_to_dt, p_dept_nm, p_salary_period, p_nation, p_lstEmpID;
    string l_work_from;
    
    p_tco_dept_pk = Request["l_tco_dept_pk"].ToString();
    p_thr_group_pk = Request["l_thr_group_pk"].ToString();
    p_status = Request["l_status"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();
    p_to_dt = Request["l_to_dt"].ToString();
    p_from_dt = Request["l_from_dt"].ToString();
    p_dept_nm = Request["l_dept_nm"].ToString();
    p_nation = Request["l_nation"].ToString();
    p_salary_period = Request["l_SalaryPeriod"].ToString();
    p_lstEmpID = Request["l_lstEmpID"].ToString();
   
    
    //-----------------information of company-----------------
    string SQL_Com
	= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY') " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        "and rownum=1 " ;

    //Response.Write(SQL_Com);
    //Response.End();
    DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_Com.Rows.Count;
    //if (irow_com == 0)
    //{
    //    Response.Write("There is no data of company");
    //    Response.End();
    //}

    if (p_lstEmpID != "")
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    //-----------------working time-----------------
    string SQL="";
    string SQL1 = "";
    string SQL_work_from="";
    
    if (p_lstEmpID != "")
    {
        SQL= "select c.org_NM,b.emp_id,b.full_name " +
            ",to_char(to_date(b.join_dt,'yyyymmdd'),'dd/mm/yyyy') " +
            ",MAX(DECODE(A.WORK_DT,'" + p_from_dt + "',a.TIME_IN,'')) as in_1 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+1,'YYYYMMDD'),a.TIME_IN,'')) as in_2 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+2,'YYYYMMDD'),a.TIME_IN,'')) as in_3 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+3,'YYYYMMDD'),a.TIME_IN,'')) as in_4 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+4,'YYYYMMDD'),a.TIME_IN,'')) as in_5 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+5,'YYYYMMDD'),a.TIME_IN,'')) as in_6 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+6,'YYYYMMDD'),a.TIME_IN,'')) as in_7 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+7,'YYYYMMDD'),a.TIME_IN,'')) as in_8 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+8,'YYYYMMDD'),a.TIME_IN,'')) as in_9 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+9,'YYYYMMDD'),a.TIME_IN,'')) as in_10 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+10,'YYYYMMDD'),a.TIME_IN,'')) as in_11 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+11,'YYYYMMDD'),a.TIME_IN,'')) as in_12 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+12,'YYYYMMDD'),a.TIME_IN,'')) as in_13 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+13,'YYYYMMDD'),a.TIME_IN,'')) as in_14 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+14,'YYYYMMDD'),a.TIME_IN,'')) as in_15 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+15,'YYYYMMDD'),a.TIME_IN,'')) as in_16 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+16,'YYYYMMDD'),a.TIME_IN,'')) as in_17 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+17,'YYYYMMDD'),a.TIME_IN,'')) as in_18 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+18,'YYYYMMDD'),a.TIME_IN,'')) as in_19 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+19,'YYYYMMDD'),a.TIME_IN,'')) as in_20 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+20,'YYYYMMDD'),a.TIME_IN,'')) as in_21 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+21,'YYYYMMDD'),a.TIME_IN,'')) as in_22 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+22,'YYYYMMDD'),a.TIME_IN,'')) as in_23 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+23,'YYYYMMDD'),a.TIME_IN,'')) as in_24 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+24,'YYYYMMDD'),a.TIME_IN,'')) as in_25 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+25,'YYYYMMDD'),a.TIME_IN,'')) as in_26 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+26,'YYYYMMDD'),a.TIME_IN,'')) as in_27 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+27,'YYYYMMDD'),a.TIME_IN,'')) as in_28 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+28,'YYYYMMDD'),a.TIME_IN,'')) as in_29 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+29,'YYYYMMDD'),a.TIME_IN,'')) as in_30 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+30,'YYYYMMDD'),a.TIME_IN,'')) as in_31 " +
            ",MAX(DECODE(A.WORK_DT,'" + p_from_dt + "',a.TIME_OUT,'')) as out_1 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+1,'YYYYMMDD'),a.TIME_OUT,'')) as out_2 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+2,'YYYYMMDD'),a.TIME_OUT,'')) as out_3 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+3,'YYYYMMDD'),a.TIME_OUT,'')) as out_4 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+4,'YYYYMMDD'),a.TIME_OUT,'')) as out_5 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+5,'YYYYMMDD'),a.TIME_OUT,'')) as out_6 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+6,'YYYYMMDD'),a.TIME_OUT,'')) as out_7 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+7,'YYYYMMDD'),a.TIME_OUT,'')) as out_8 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+8,'YYYYMMDD'),a.TIME_OUT,'')) as out_9 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+9,'YYYYMMDD'),a.TIME_OUT,'')) as out_10 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+10,'YYYYMMDD'),a.TIME_OUT,'')) as out_11 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+11,'YYYYMMDD'),a.TIME_OUT,'')) as out_12 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+12,'YYYYMMDD'),a.TIME_OUT,'')) as out_13 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+13,'YYYYMMDD'),a.TIME_OUT,'')) as out_14 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+14,'YYYYMMDD'),a.TIME_OUT,'')) as out_15 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+15,'YYYYMMDD'),a.TIME_OUT,'')) as out_16 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+16,'YYYYMMDD'),a.TIME_OUT,'')) as out_17 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+17,'YYYYMMDD'),a.TIME_OUT,'')) as out_18 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+18,'YYYYMMDD'),a.TIME_OUT,'')) as out_19 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+19,'YYYYMMDD'),a.TIME_OUT,'')) as out_20 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+20,'YYYYMMDD'),a.TIME_OUT,'')) as out_21 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+21,'YYYYMMDD'),a.TIME_OUT,'')) as out_22 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+22,'YYYYMMDD'),a.TIME_OUT,'')) as out_23 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+23,'YYYYMMDD'),a.TIME_OUT,'')) as out_24 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+24,'YYYYMMDD'),a.TIME_OUT,'')) as out_25 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+25,'YYYYMMDD'),a.TIME_OUT,'')) as out_26 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+26,'YYYYMMDD'),a.TIME_OUT,'')) as out_27 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+27,'YYYYMMDD'),a.TIME_OUT,'')) as out_28 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+28,'YYYYMMDD'),a.TIME_OUT,'')) as out_29 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+29,'YYYYMMDD'),a.TIME_OUT,'')) as out_30 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+30,'YYYYMMDD'),a.TIME_OUT,'')) as out_31 " +
            ", NVL (c.seq, 0),SUM(NVL(A.WORK_TIME,0)),MAX(F.OT),MAX(F.NT),MAX(F.HT)" +
            " from thr_time_machine a,thr_employee b,tco_org c " +
            ",(SELECT  E.THR_EMP_PK,sum(decode(e.ot_type,'OT',nvl(e.ot_time,0),0)) AS OT " +
            "    ,sum(decode(e.ot_type,'NT',nvl(e.ot_time,0),0)) AS NT " +
            "    ,sum(decode(e.ot_type,'HT',nvl(e.ot_time,0),0)) AS HT " +
            "        FROM THR_EXTRA_TIME E WHERE E.DEL_IF=0            " +
            "        AND E.WORK_DT BETWEEN '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "        GROUP BY E.THR_EMP_PK) F                          " +
            "where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
            "and a.THR_EMP_PK=b.pk and b.tco_org_pk=c.pk " +
            "and a.WORK_DT between '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "and a.WORK_DT between b.join_dt and nvl(b.left_dt,'" + p_to_dt + "') " +
            "and b.join_dt<=a.WORK_DT " +
            "and (b.left_dt>a.WORK_DT or b.left_dt is null) " +
            "AND A.THR_EMP_PK=F.THR_EMP_PK(+) " +
            "and (b.tco_org_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_tco_dept_pk + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_tco_dept_pk + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
            "and decode('" + p_thr_group_pk + "','ALL','ALL',b.thr_wg_pk)='" + p_thr_group_pk + "'" +
            "and a.emp_id in ('" + p_lstEmpID + "')" + 
            "and decode('" + p_status + "','ALL','ALL',b.status)='" + p_status + "'" +
            " and decode('" + p_salary_period + "','ALL','ALL',nvl(b.sal_period,' '))='" + p_salary_period + "' " +
            " and decode('" + p_nation + "','ALL','ALL',nvl(b.nation,'01'))='" + p_nation + "' " +
            " GROUP BY A.THR_EMP_PK,c.org_NM,b.emp_id,b.full_name,b.join_dt,NVL (c.seq, 0) " +
            " ORDER BY NVL (c.seq, 0),c.org_nm, b.emp_id ";

        SQL_work_from = " select m.from_dt " +
            "from thr_close m " +
            "where  m.del_if=0 and m.id='01' and m.month_close='" + p_work_mon + "' ";

        DataTable dt_from = ESysLib.TableReadOpen(SQL_work_from);


        l_work_from = dt_from.Rows[0][0].ToString();

        SQL1= "select c.org_NM,b.emp_id,b.full_name " +
            ",to_char(to_date(b.join_dt,'yyyymmdd'),'dd/mm/yyyy') " +
            ",MAX(DECODE(A.WORK_DT,'" + l_work_from + "',a.TIME_IN,'')) as in_1 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+1,'YYYYMMDD'),a.TIME_IN,'')) as in_2 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+2,'YYYYMMDD'),a.TIME_IN,'')) as in_3 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+3,'YYYYMMDD'),a.TIME_IN,'')) as in_4 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+4,'YYYYMMDD'),a.TIME_IN,'')) as in_5 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+5,'YYYYMMDD'),a.TIME_IN,'')) as in_6 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+6,'YYYYMMDD'),a.TIME_IN,'')) as in_7 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+7,'YYYYMMDD'),a.TIME_IN,'')) as in_8 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+8,'YYYYMMDD'),a.TIME_IN,'')) as in_9 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+9,'YYYYMMDD'),a.TIME_IN,'')) as in_10 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+10,'YYYYMMDD'),a.TIME_IN,'')) as in_11 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+11,'YYYYMMDD'),a.TIME_IN,'')) as in_12 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+12,'YYYYMMDD'),a.TIME_IN,'')) as in_13 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+13,'YYYYMMDD'),a.TIME_IN,'')) as in_14 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+14,'YYYYMMDD'),a.TIME_IN,'')) as in_15 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+15,'YYYYMMDD'),a.TIME_IN,'')) as in_16 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+16,'YYYYMMDD'),a.TIME_IN,'')) as in_17 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+17,'YYYYMMDD'),a.TIME_IN,'')) as in_18 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+18,'YYYYMMDD'),a.TIME_IN,'')) as in_19 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+19,'YYYYMMDD'),a.TIME_IN,'')) as in_20 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+20,'YYYYMMDD'),a.TIME_IN,'')) as in_21 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+21,'YYYYMMDD'),a.TIME_IN,'')) as in_22 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+22,'YYYYMMDD'),a.TIME_IN,'')) as in_23 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+23,'YYYYMMDD'),a.TIME_IN,'')) as in_24 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+24,'YYYYMMDD'),a.TIME_IN,'')) as in_25 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+25,'YYYYMMDD'),a.TIME_IN,'')) as in_26 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+26,'YYYYMMDD'),a.TIME_IN,'')) as in_27 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+27,'YYYYMMDD'),a.TIME_IN,'')) as in_28 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+28,'YYYYMMDD'),a.TIME_IN,'')) as in_29 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+29,'YYYYMMDD'),a.TIME_IN,'')) as in_30 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+30,'YYYYMMDD'),a.TIME_IN,'')) as in_31 " +
            ",MAX(DECODE(A.WORK_DT,'" + l_work_from + "',a.TIME_OUT,'')) as out_1 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+1,'YYYYMMDD'),a.TIME_OUT,'')) as out_2 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+2,'YYYYMMDD'),a.TIME_OUT,'')) as out_3 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+3,'YYYYMMDD'),a.TIME_OUT,'')) as out_4 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+4,'YYYYMMDD'),a.TIME_OUT,'')) as out_5 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+5,'YYYYMMDD'),a.TIME_OUT,'')) as out_6 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+6,'YYYYMMDD'),a.TIME_OUT,'')) as out_7 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+7,'YYYYMMDD'),a.TIME_OUT,'')) as out_8 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+8,'YYYYMMDD'),a.TIME_OUT,'')) as out_9 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+9,'YYYYMMDD'),a.TIME_OUT,'')) as out_10 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+10,'YYYYMMDD'),a.TIME_OUT,'')) as out_11 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+11,'YYYYMMDD'),a.TIME_OUT,'')) as out_12 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+12,'YYYYMMDD'),a.TIME_OUT,'')) as out_13 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+13,'YYYYMMDD'),a.TIME_OUT,'')) as out_14 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+14,'YYYYMMDD'),a.TIME_OUT,'')) as out_15 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+15,'YYYYMMDD'),a.TIME_OUT,'')) as out_16 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+16,'YYYYMMDD'),a.TIME_OUT,'')) as out_17 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+17,'YYYYMMDD'),a.TIME_OUT,'')) as out_18 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+18,'YYYYMMDD'),a.TIME_OUT,'')) as out_19 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+19,'YYYYMMDD'),a.TIME_OUT,'')) as out_20 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+20,'YYYYMMDD'),a.TIME_OUT,'')) as out_21 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+21,'YYYYMMDD'),a.TIME_OUT,'')) as out_22 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+22,'YYYYMMDD'),a.TIME_OUT,'')) as out_23 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+23,'YYYYMMDD'),a.TIME_OUT,'')) as out_24 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+24,'YYYYMMDD'),a.TIME_OUT,'')) as out_25 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+25,'YYYYMMDD'),a.TIME_OUT,'')) as out_26 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+26,'YYYYMMDD'),a.TIME_OUT,'')) as out_27 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+27,'YYYYMMDD'),a.TIME_OUT,'')) as out_28 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+28,'YYYYMMDD'),a.TIME_OUT,'')) as out_29 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+29,'YYYYMMDD'),a.TIME_OUT,'')) as out_30 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+30,'YYYYMMDD'),a.TIME_OUT,'')) as out_31 " +
            ", NVL (c.seq, 0),SUM(NVL(A.WORK_TIME,0)),MAX(F.OT),MAX(F.NT),MAX(F.HT)" +
            " from thr_time_machine a,thr_employee b,tco_org c " +
            ",(SELECT  E.THR_EMP_PK,sum(decode(e.ot_type,'OT',nvl(e.ot_time,0),0)) AS OT " +
            "    ,sum(decode(e.ot_type,'NT',nvl(e.ot_time,0),0)) AS NT " +
            "    ,sum(decode(e.ot_type,'HT',nvl(e.ot_time,0),0)) AS HT " +
            "        FROM THR_EXTRA_TIME E WHERE E.DEL_IF=0            " +
            "        AND E.WORK_DT BETWEEN '" + l_work_from + "' and '" + p_to_dt + "' " +
            "        GROUP BY E.THR_EMP_PK) F                          " +
            "where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
            "and a.THR_EMP_PK=b.pk and b.tco_org_pk=c.pk " +
            "and a.WORK_DT between '" + l_work_from + "' and '" + p_to_dt + "' " +
            "and a.WORK_DT between b.join_dt and nvl(b.left_dt,'" + p_to_dt + "') " +
            "and b.join_dt<=a.WORK_DT " +
            " AND b.left_dt BETWEEN '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "and b.left_dt is not null " +
            "AND A.THR_EMP_PK=F.THR_EMP_PK(+) " +
            "and (b.tco_org_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_tco_dept_pk + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_tco_dept_pk + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
            "and decode('" + p_thr_group_pk + "','ALL','ALL',b.thr_wg_pk)='" + p_thr_group_pk + "'" +
            "and a.emp_id in ('" + p_lstEmpID + "')" + 
            "and decode('" + p_status + "','ALL','ALL',b.status)='" + p_status + "'" +
            " and decode('" + p_nation + "','ALL','ALL',nvl(b.nation,'01'))='" + p_nation + "' " +
            " GROUP BY A.THR_EMP_PK,c.org_NM,b.emp_id,b.full_name,b.join_dt,NVL (c.seq, 0) " +
            " ORDER BY NVL (c.seq, 0),c.org_nm, b.emp_id ";
    } //if (p_lstEmpID=="")
    else
    {
        SQL = "select c.org_NM,b.emp_id,b.full_name " +
            ",to_char(to_date(b.join_dt,'yyyymmdd'),'dd/mm/yyyy') " +
            ",MAX(DECODE(A.WORK_DT,'" + p_from_dt + "',a.TIME_IN,'')) as in_1 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+1,'YYYYMMDD'),a.TIME_IN,'')) as in_2 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+2,'YYYYMMDD'),a.TIME_IN,'')) as in_3 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+3,'YYYYMMDD'),a.TIME_IN,'')) as in_4 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+4,'YYYYMMDD'),a.TIME_IN,'')) as in_5 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+5,'YYYYMMDD'),a.TIME_IN,'')) as in_6 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+6,'YYYYMMDD'),a.TIME_IN,'')) as in_7 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+7,'YYYYMMDD'),a.TIME_IN,'')) as in_8 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+8,'YYYYMMDD'),a.TIME_IN,'')) as in_9 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+9,'YYYYMMDD'),a.TIME_IN,'')) as in_10 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+10,'YYYYMMDD'),a.TIME_IN,'')) as in_11 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+11,'YYYYMMDD'),a.TIME_IN,'')) as in_12 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+12,'YYYYMMDD'),a.TIME_IN,'')) as in_13 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+13,'YYYYMMDD'),a.TIME_IN,'')) as in_14 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+14,'YYYYMMDD'),a.TIME_IN,'')) as in_15 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+15,'YYYYMMDD'),a.TIME_IN,'')) as in_16 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+16,'YYYYMMDD'),a.TIME_IN,'')) as in_17 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+17,'YYYYMMDD'),a.TIME_IN,'')) as in_18 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+18,'YYYYMMDD'),a.TIME_IN,'')) as in_19 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+19,'YYYYMMDD'),a.TIME_IN,'')) as in_20 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+20,'YYYYMMDD'),a.TIME_IN,'')) as in_21 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+21,'YYYYMMDD'),a.TIME_IN,'')) as in_22 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+22,'YYYYMMDD'),a.TIME_IN,'')) as in_23 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+23,'YYYYMMDD'),a.TIME_IN,'')) as in_24 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+24,'YYYYMMDD'),a.TIME_IN,'')) as in_25 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+25,'YYYYMMDD'),a.TIME_IN,'')) as in_26 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+26,'YYYYMMDD'),a.TIME_IN,'')) as in_27 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+27,'YYYYMMDD'),a.TIME_IN,'')) as in_28 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+28,'YYYYMMDD'),a.TIME_IN,'')) as in_29 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+29,'YYYYMMDD'),a.TIME_IN,'')) as in_30 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+30,'YYYYMMDD'),a.TIME_IN,'')) as in_31 " +
            ",MAX(DECODE(A.WORK_DT,'" + p_from_dt + "',a.TIME_OUT,'')) as out_1 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+1,'YYYYMMDD'),a.TIME_OUT,'')) as out_2 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+2,'YYYYMMDD'),a.TIME_OUT,'')) as out_3 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+3,'YYYYMMDD'),a.TIME_OUT,'')) as out_4 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+4,'YYYYMMDD'),a.TIME_OUT,'')) as out_5 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+5,'YYYYMMDD'),a.TIME_OUT,'')) as out_6 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+6,'YYYYMMDD'),a.TIME_OUT,'')) as out_7 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+7,'YYYYMMDD'),a.TIME_OUT,'')) as out_8 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+8,'YYYYMMDD'),a.TIME_OUT,'')) as out_9 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+9,'YYYYMMDD'),a.TIME_OUT,'')) as out_10 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+10,'YYYYMMDD'),a.TIME_OUT,'')) as out_11 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+11,'YYYYMMDD'),a.TIME_OUT,'')) as out_12 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+12,'YYYYMMDD'),a.TIME_OUT,'')) as out_13 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+13,'YYYYMMDD'),a.TIME_OUT,'')) as out_14 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+14,'YYYYMMDD'),a.TIME_OUT,'')) as out_15 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+15,'YYYYMMDD'),a.TIME_OUT,'')) as out_16 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+16,'YYYYMMDD'),a.TIME_OUT,'')) as out_17 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+17,'YYYYMMDD'),a.TIME_OUT,'')) as out_18 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+18,'YYYYMMDD'),a.TIME_OUT,'')) as out_19 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+19,'YYYYMMDD'),a.TIME_OUT,'')) as out_20 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+20,'YYYYMMDD'),a.TIME_OUT,'')) as out_21 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+21,'YYYYMMDD'),a.TIME_OUT,'')) as out_22 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+22,'YYYYMMDD'),a.TIME_OUT,'')) as out_23 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+23,'YYYYMMDD'),a.TIME_OUT,'')) as out_24 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+24,'YYYYMMDD'),a.TIME_OUT,'')) as out_25 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+25,'YYYYMMDD'),a.TIME_OUT,'')) as out_26 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+26,'YYYYMMDD'),a.TIME_OUT,'')) as out_27 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+27,'YYYYMMDD'),a.TIME_OUT,'')) as out_28 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+28,'YYYYMMDD'),a.TIME_OUT,'')) as out_29 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+29,'YYYYMMDD'),a.TIME_OUT,'')) as out_30 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+30,'YYYYMMDD'),a.TIME_OUT,'')) as out_31 " +
            ", NVL (c.seq, 0),SUM(NVL(A.WORK_TIME,0)),MAX(F.OT),MAX(F.NT),MAX(F.HT)" +
            " from thr_time_machine a,thr_employee b,tco_org c " +
            ",(SELECT  E.THR_EMP_PK,sum(decode(e.ot_type,'OT',nvl(e.ot_time,0),0)) AS OT " +
            "    ,sum(decode(e.ot_type,'NT',nvl(e.ot_time,0),0)) AS NT " +
            "    ,sum(decode(e.ot_type,'HT',nvl(e.ot_time,0),0)) AS HT " +
            "        FROM THR_EXTRA_TIME E WHERE E.DEL_IF=0            " +
            "        AND E.WORK_DT BETWEEN '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "        GROUP BY E.THR_EMP_PK) F                          " +
            "where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
            "and a.THR_EMP_PK=b.pk and b.tco_org_pk=c.pk " +
            "and a.WORK_DT between '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "and a.WORK_DT between b.join_dt and nvl(b.left_dt,'" + p_to_dt + "') " +
            "and b.join_dt<=a.WORK_DT " +
            "and (b.left_dt>a.WORK_DT or b.left_dt is null) " +
            "AND A.THR_EMP_PK=F.THR_EMP_PK(+) " +
            "and (b.tco_org_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_tco_dept_pk + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_tco_dept_pk + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
            "and decode('" + p_thr_group_pk + "','ALL','ALL',b.thr_wg_pk)='" + p_thr_group_pk + "'" +
            "and b.emp_id like '%" + p_emp_id + "%' " +
            "and decode('" + p_status + "','ALL','ALL',b.status)='" + p_status + "'" +
            " and decode('" + p_salary_period + "','ALL','ALL',nvl(b.sal_period,' '))='" + p_salary_period + "' " +
            " and decode('" + p_nation + "','ALL','ALL',nvl(b.nation,'01'))='" + p_nation + "' " +
            " GROUP BY A.THR_EMP_PK,c.org_NM,b.emp_id,b.full_name,b.join_dt,NVL (c.seq, 0) " +
            " ORDER BY NVL (c.seq, 0),c.org_nm, b.emp_id ";

        SQL_work_from = " select m.from_dt " +
            "from thr_close m " +
            "where  m.del_if=0 and m.id='01' and m.month_close='" + p_work_mon + "' ";

        DataTable dt_from = ESysLib.TableReadOpen(SQL_work_from);


        l_work_from = dt_from.Rows[0][0].ToString();

        SQL1= "select c.org_NM,b.emp_id,b.full_name " +
            ",to_char(to_date(b.join_dt,'yyyymmdd'),'dd/mm/yyyy') " +
            ",MAX(DECODE(A.WORK_DT,'" + l_work_from + "',a.TIME_IN,'')) as in_1 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+1,'YYYYMMDD'),a.TIME_IN,'')) as in_2 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+2,'YYYYMMDD'),a.TIME_IN,'')) as in_3 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+3,'YYYYMMDD'),a.TIME_IN,'')) as in_4 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+4,'YYYYMMDD'),a.TIME_IN,'')) as in_5 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+5,'YYYYMMDD'),a.TIME_IN,'')) as in_6 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+6,'YYYYMMDD'),a.TIME_IN,'')) as in_7 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+7,'YYYYMMDD'),a.TIME_IN,'')) as in_8 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+8,'YYYYMMDD'),a.TIME_IN,'')) as in_9 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+9,'YYYYMMDD'),a.TIME_IN,'')) as in_10 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+10,'YYYYMMDD'),a.TIME_IN,'')) as in_11 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+11,'YYYYMMDD'),a.TIME_IN,'')) as in_12 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+12,'YYYYMMDD'),a.TIME_IN,'')) as in_13 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+13,'YYYYMMDD'),a.TIME_IN,'')) as in_14 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+14,'YYYYMMDD'),a.TIME_IN,'')) as in_15 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+15,'YYYYMMDD'),a.TIME_IN,'')) as in_16 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+16,'YYYYMMDD'),a.TIME_IN,'')) as in_17 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+17,'YYYYMMDD'),a.TIME_IN,'')) as in_18 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+18,'YYYYMMDD'),a.TIME_IN,'')) as in_19 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+19,'YYYYMMDD'),a.TIME_IN,'')) as in_20 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+20,'YYYYMMDD'),a.TIME_IN,'')) as in_21 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+21,'YYYYMMDD'),a.TIME_IN,'')) as in_22 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+22,'YYYYMMDD'),a.TIME_IN,'')) as in_23 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+23,'YYYYMMDD'),a.TIME_IN,'')) as in_24 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+24,'YYYYMMDD'),a.TIME_IN,'')) as in_25 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+25,'YYYYMMDD'),a.TIME_IN,'')) as in_26 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+26,'YYYYMMDD'),a.TIME_IN,'')) as in_27 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+27,'YYYYMMDD'),a.TIME_IN,'')) as in_28 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+28,'YYYYMMDD'),a.TIME_IN,'')) as in_29 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+29,'YYYYMMDD'),a.TIME_IN,'')) as in_30 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+30,'YYYYMMDD'),a.TIME_IN,'')) as in_31 " +
            ",MAX(DECODE(A.WORK_DT,'" + l_work_from + "',a.TIME_OUT,'')) as out_1 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+1,'YYYYMMDD'),a.TIME_OUT,'')) as out_2 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+2,'YYYYMMDD'),a.TIME_OUT,'')) as out_3 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+3,'YYYYMMDD'),a.TIME_OUT,'')) as out_4 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+4,'YYYYMMDD'),a.TIME_OUT,'')) as out_5 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+5,'YYYYMMDD'),a.TIME_OUT,'')) as out_6 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+6,'YYYYMMDD'),a.TIME_OUT,'')) as out_7 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+7,'YYYYMMDD'),a.TIME_OUT,'')) as out_8 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+8,'YYYYMMDD'),a.TIME_OUT,'')) as out_9 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+9,'YYYYMMDD'),a.TIME_OUT,'')) as out_10 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+10,'YYYYMMDD'),a.TIME_OUT,'')) as out_11 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+11,'YYYYMMDD'),a.TIME_OUT,'')) as out_12 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+12,'YYYYMMDD'),a.TIME_OUT,'')) as out_13 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+13,'YYYYMMDD'),a.TIME_OUT,'')) as out_14 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+14,'YYYYMMDD'),a.TIME_OUT,'')) as out_15 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+15,'YYYYMMDD'),a.TIME_OUT,'')) as out_16 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+16,'YYYYMMDD'),a.TIME_OUT,'')) as out_17 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+17,'YYYYMMDD'),a.TIME_OUT,'')) as out_18 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+18,'YYYYMMDD'),a.TIME_OUT,'')) as out_19 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+19,'YYYYMMDD'),a.TIME_OUT,'')) as out_20 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+20,'YYYYMMDD'),a.TIME_OUT,'')) as out_21 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+21,'YYYYMMDD'),a.TIME_OUT,'')) as out_22 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+22,'YYYYMMDD'),a.TIME_OUT,'')) as out_23 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+23,'YYYYMMDD'),a.TIME_OUT,'')) as out_24 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+24,'YYYYMMDD'),a.TIME_OUT,'')) as out_25 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+25,'YYYYMMDD'),a.TIME_OUT,'')) as out_26 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+26,'YYYYMMDD'),a.TIME_OUT,'')) as out_27 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+27,'YYYYMMDD'),a.TIME_OUT,'')) as out_28 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+28,'YYYYMMDD'),a.TIME_OUT,'')) as out_29 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+29,'YYYYMMDD'),a.TIME_OUT,'')) as out_30 " +
            ",MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + l_work_from + "','YYYYMMDD')+30,'YYYYMMDD'),a.TIME_OUT,'')) as out_31 " +
            ", NVL (c.seq, 0),SUM(NVL(A.WORK_TIME,0)),MAX(F.OT),MAX(F.NT),MAX(F.HT)" +
            " from thr_time_machine a,thr_employee b,tco_org c " +
            ",(SELECT  E.THR_EMP_PK,sum(decode(e.ot_type,'OT',nvl(e.ot_time,0),0)) AS OT " +
            "    ,sum(decode(e.ot_type,'NT',nvl(e.ot_time,0),0)) AS NT " +
            "    ,sum(decode(e.ot_type,'HT',nvl(e.ot_time,0),0)) AS HT " +
            "        FROM THR_EXTRA_TIME E WHERE E.DEL_IF=0            " +
            "        AND E.WORK_DT BETWEEN '" + l_work_from + "' and '" + p_to_dt + "' " +
            "        GROUP BY E.THR_EMP_PK) F                          " +
            "where a.del_if=0 and b.del_if=0 and c.del_if=0 " +
            "and a.THR_EMP_PK=b.pk and b.tco_org_pk=c.pk " +
            "and a.WORK_DT between '" + l_work_from + "' and '" + p_to_dt + "' " +
            "and a.WORK_DT between b.join_dt and nvl(b.left_dt,'" + p_to_dt + "') " +
            "and b.join_dt<=a.WORK_DT " +
            " AND b.left_dt BETWEEN '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "and b.left_dt is not null " +
            "AND A.THR_EMP_PK=F.THR_EMP_PK(+) " +
            "and (b.tco_org_pk in ( " +
            "                              SELECT     g.pk " +
            "                                    FROM tco_org g " +
            "                                   WHERE g.del_if = 0 " +
            "                              START WITH g.pk = " +
            "                                            DECODE ('" + p_tco_dept_pk + "', " +
            "                                                    'ALL', 0, " +
            "                                                    '" + p_tco_dept_pk + "' " +
            "                                                   ) " +
            "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
            "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
            "and decode('" + p_thr_group_pk + "','ALL','ALL',b.thr_wg_pk)='" + p_thr_group_pk + "'" +
            "and b.emp_id like '%" + p_emp_id + "%' " +
            "and decode('" + p_status + "','ALL','ALL',b.status)='" + p_status + "'" +
            " and decode('" + p_nation + "','ALL','ALL',nvl(b.nation,'01'))='" + p_nation + "' " +
            " GROUP BY A.THR_EMP_PK,c.org_NM,b.emp_id,b.full_name,b.join_dt,NVL (c.seq, 0) " +
            " ORDER BY NVL (c.seq, 0),c.org_nm, b.emp_id ";
    }


   
    
    
    //Response.Write(SQL);
    //Response.End();     
    if (p_status == "R")
    {
        SQL = SQL1;
    }

            
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
    = "select substr(t.car_date,-2),t.hol_type " +
        "from thr_calendar T,thr_close m " +
        "where t.del_if=0 and m.del_if=0 and m.id='" + p_salary_period + "' and m.month_close='" + p_work_mon + "' " +
        "   and m.tco_company_pk=(select tco_company_pk from tco_org g where g.del_if=0 and g.pk='" + p_tco_dept_pk + "' ) " +
		" and t.tco_company_pk=(select tco_company_pk from tco_org g where g.del_if=0 and g.pk='" + p_tco_dept_pk + "' ) " +
        "    and t.car_date between m.from_dt and '" + p_to_dt + "' order by t.car_date ";
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
<link rel=File-List href="rpt_in_out_summary_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_in_out_summary_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_in_out_summary_files/oledata.mso">
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
  <o:LastPrinted>2008-08-25T06:13:20Z</o:LastPrinted>
  <o:Created>2008-08-12T02:55:49Z</o:Created>
  <o:LastSaved>2008-08-25T07:01:49Z</o:LastSaved>
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
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	color:navy;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	color:navy;
	font-size:30.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	color:navy;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl31
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
.xl32
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
.xl33
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
.xl34
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
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
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
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Time";
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
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
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
.xl42
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
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
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
.xl44
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
	border-bottom:.5pt hairline windowtext;
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
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl47
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
.xl48
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
.xl49
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
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	color:navy;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yyyy";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl52
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
.xl53
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
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
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
.xl56
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
.xl57
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
.xl58
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
.xl59
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
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>48</x:Scale>
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
  </x:ExcelWorksheets>
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
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

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2123 style='border-collapse:
 collapse;table-layout:fixed;width:1610pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=64 style='width:48pt'>
 <col width=186 style='mso-width-source:userset;mso-width-alt:6802;width:140pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=50 span=32 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2500;width:56pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2500;width:56pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2500;width:56pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2500;width:56pt'>
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
   <v:imagedata src="rpt_in_out_summary_files/image001.png" o:title="vinagenuwin"/>
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
  <td class=xl28 colspan=2 width=250 style='mso-ignore:colspan;width:188pt'><% = dt_Com.Rows[0][0].ToString()%></td>
  <td width=66 style='width:50pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td class=xl27 width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td class=xl27 width=50 style='width:38pt'></td>
  <td class=xl27 width=50 style='width:38pt'></td>
  <td class=xl27 width=50 style='width:38pt'></td>
  <td class=xl27 width=50 style='width:38pt'></td>
  <td class=xl27 width=50 style='width:38pt'></td>
  <td class=xl27 width=50 style='width:38pt'></td>
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
  <td width=74 style='width:56pt'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 colspan=2 style='height:31.5pt;mso-ignore:colspan'></td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'><% = dt_Com.Rows[0][1].ToString()%></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl29>IN - OUT SUMMARY <% if (p_tco_dept_pk!="ALL") 
                                     Response.Write(" - " + p_dept_nm); %></td>
  <td colspan=18 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 colspan=2 style='height:24.75pt;mso-ignore:colspan'></td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'>Phone :<span
  style='mso-spacerun:yes'>  </span><% = dt_Com.Rows[0][2].ToString()%></td>
  <td colspan=14 style='mso-ignore:colspan'></td>
  <td class=xl30>Month:</td>
  <td colspan=2 class=xl51 width=100 style='width:76pt' x:num><%=dt_Com.Rows[0][4].ToString()%></td>
  <td colspan=17 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl41 style='height:27.0pt;font-style:italic;'>No.</td>
  <td class=xl41 style='border-left:none;font-style:italic;'>Group</td>
  <td class=xl41 style='border-left:none;font-style:italic;'>Emp ID</td>
  <td class=xl41 style='border-left:none;font-style:italic;'>Full Name</td>
  <td class=xl41 style='border-left:none;font-style:italic;'>Join Date</td>
  <td class=xl42 style='border-left:none;font-style:italic;'>Note</td>
  <%
    for (int j = 0; j < iDate_Num; j++) 
    {
   %>
  <td rowspan=2 class=xl49 style='border-bottom:.5pt solid black;font-style:italic;' x:num><%= dt_Cal.Rows[j][0].ToString() %></td>
  <%
    }
   %>
  <td class=xl45 style='mso-width-source:userset;mso-width-alt:2500;width:56pt'>WT(H)</td>
  <td class=xl45 style='mso-width-source:userset;mso-width-alt:2500;width:56pt'>OT</td>
  <td class=xl45 style='mso-width-source:userset;mso-width-alt:2500;width:56pt'>NT</td>
  <td class=xl45 style='mso-width-source:userset;mso-width-alt:2500;width:56pt'>HT</td>
  <td class=xl45 style='border-left:none;font-style:italic;'>Sign</td>
 </tr>
 <tr class=xl24 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl43 style='height:27.0pt;border-top:none;font-style:italic;'>STT</td>
  <td class=xl43 style='border-top:none;border-left:none;font-style:italic;'>Nhóm</td>
  <td class=xl43 style='border-top:none;border-left:none;font-style:italic;'>Mã s&#7889;</td>
  <td class=xl43 style='border-top:none;border-left:none;font-style:italic;'>H&#7885; và tên</td>
  <td class=xl43 style='border-top:none;border-left:none;font-style:italic;'>Ngày vào</td>
  <td class=xl44 style='border-top:none;border-left:none;font-style:italic;'>Ghi chú</td>
  <td class=xl46 style='border-top:none;border-left:none;font-style:italic;'>Tổng công</td>
  <td class=xl46 style='border-top:none;border-left:none;font-style:italic;'>T.C Thường</td>
  <td class=xl46 style='border-top:none;border-left:none;font-style:italic;'>Làm Đêm</td>
  <td class=xl46 style='border-top:none;border-left:none;font-style:italic;'>T.C CN-Lễ</td>
  <td class=xl46 style='border-top:none;border-left:none;font-style:italic;'>Ch&#7919; ký</td>
 </tr>
 <% 
   
    for (int i = 0; i < irow_emp; i++) 
    {
    %> 
 <tr class=xl25 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td rowspan=2 height=84 class=xl52 style='border-bottom:.5pt solid black;
  height:63.0pt;border-top:none' x:num><%= i+1 %></td>
  <td rowspan=2 class=xl52 width=102 style='border-bottom:.5pt solid black;
  border-top:none;width:77pt'><%= dt_Emp.Rows[i][0].ToString() %></td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none'><%= dt_Emp.Rows[i][1].ToString() %></td>
  <td rowspan=2 class=xl52 width=186 style='border-bottom:.5pt solid black;
  border-top:none;width:140pt'><%= dt_Emp.Rows[i][2].ToString() %></td>
  <td rowspan=2 class=xl56 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%= dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none;font-style:italic;'>IN</td>
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
  <td class=xl39 style='border-top:none;border-left:none<%=sformat %>'><%= dt_Emp.Rows[i][j+4].ToString() %></td>
  <%
    }//end of "for" of IN
   %>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%= dt_Emp.Rows[i][67].ToString() %></td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%= dt_Emp.Rows[i][68].ToString() %></td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%= dt_Emp.Rows[i][69].ToString() %></td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none' x:num><%= dt_Emp.Rows[i][70].ToString() %></td>
  <td rowspan=2 class=xl54 style='border-bottom:.5pt solid black;border-top:
  none'>&nbsp;</td>
 </tr>
 
 <tr class=xl25 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl33 style='height:31.5pt;border-top:none;border-left:
  none;font-style:italic;'>OUT</td>
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
  <td class=xl40 style='border-top:none;border-left:none<%=sformat %>'
  ><%= dt_Emp.Rows[i][j+35].ToString() %></td>
  <%
    } //end of "for" of OUT 
   %>
 </tr>
 <%
    } //end of "for" of employee 
  %>
 
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=42 style='width:32pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=186 style='width:140pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=39 style='width:29pt'></td>
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
  <td width=74 style='width:56pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
