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
    string p_tco_dept_pk, p_thr_group_pk, p_status, p_emp_id, p_work_mon, p_from_dt, p_to_dt, p_dept_nm, p_salary_period, p_company_pk, p_lstEmpID;
    
    p_tco_dept_pk = Request["l_tco_dept_pk"].ToString();
    p_thr_group_pk = Request["l_thr_group_pk"].ToString();
    p_status = Request["l_status"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();
    p_to_dt = Request["l_to_dt"].ToString();
    p_from_dt = Request["l_from_dt"].ToString();
    p_dept_nm = Request["l_dept_nm"].ToString();
    p_salary_period = Request["l_SalaryPeriod"].ToString();
    //p_company_pk = Request["l_company_pk"].ToString();
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
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    //-----------------working time-----------------

    string SQL = "";
    string SQL1 = "";    

    if (p_lstEmpID != "")
    {

        SQL = "select c.org_NM,b.emp_id,b.full_name  " +
            ",to_char(to_date(b.join_dt,'yyyymmdd'),'dd/mm/yyyy')  " +
            ",MAX(DECODE(A.ABSENCE_DT,'" + p_from_dt + "',abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ) ,'')) as in_1  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+1,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_2  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+2,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_3  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+3,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_4  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+4,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_5  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+5,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_6  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+6,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_7  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+7,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_8  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+8,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_9  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+9,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_10  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+10,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_11  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+11,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_12  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+12,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_13  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+13,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_14  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+14,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_15  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+15,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_16  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+16,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_17  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+17,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_18  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+18,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_19  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+19,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_20  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+20,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_21  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+21,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_22  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+22,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_23  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+23,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_24  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+24,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_25  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+25,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_26  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+26,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_27  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+27,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_28  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+28,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_29  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+29,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_30  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+30,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_31  " +
            " , NVL (c.seq, 0), SUM (NVL (a.absence_time, 0) / 8) AS total_abs  " +
            "from thr_absence_ur a,thr_employee b,tco_org c  " +
            ",(select d.code,d.char_1 from vhr_hr_code d where id='HR0003') abs_type " +
            "where a.del_if=0 and b.del_if=0 and c.del_if=0  " +
            "and a.THR_EMP_PK=b.pk and b.tco_org_pk=c.pk " +
            "and a.ABSENCE_TYPE=abs_type.code  " +
            "and a.absence_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "and B.LEFT_DT between '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "and B.LEFT_DT IS NOT NULL " +
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
            "and UPPER(b.emp_id) in ('" + p_lstEmpID + "')" + 
            "and decode('" + p_status + "','ALL','ALL',b.status)='" + p_status + "'" +
            " and decode('" + p_salary_period + "','ALL','ALL',nvl(b.sal_period,' '))='" + p_salary_period + "' " +
            " GROUP BY A.THR_EMP_PK,c.org_NM,b.emp_id,b.full_name,b.join_dt,NVL (c.seq, 0) " +
            " order by NVL (c.seq, 0),c.org_NM,b.emp_id ";


        SQL1
        = "select c.org_NM,b.emp_id,b.full_name  " +
            ",to_char(to_date(b.join_dt,'yyyymmdd'),'dd/mm/yyyy')  " +
            ",MAX(DECODE(A.ABSENCE_DT,'" + p_from_dt + "',abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ) ,'')) as in_1  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+1,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_2  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+2,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_3  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+3,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_4  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+4,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_5  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+5,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_6  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+6,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_7  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+7,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_8  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+8,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_9  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+9,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_10  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+10,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_11  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+11,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_12  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+12,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_13  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+13,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_14  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+14,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_15  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+15,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_16  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+16,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_17  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+17,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_18  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+18,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_19  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+19,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_20  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+20,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_21  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+21,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_22  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+22,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_23  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+23,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_24  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+24,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_25  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+25,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_26  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+26,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_27  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+27,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_28  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+28,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_29  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+29,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_30  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+30,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_31  " +
            " , NVL (c.seq, 0), SUM (NVL (a.absence_time, 0) / 8) AS total_abs  " +
            "from thr_absence_ur a,thr_employee b,tco_org c  " +
            ",(select d.code,d.char_1 from vhr_hr_code d where id='HR0003') abs_type " +
            "where a.del_if=0 and b.del_if=0 and c.del_if=0  " +
            "and a.THR_EMP_PK=b.pk and b.tco_org_pk=c.pk " +
            "and a.ABSENCE_TYPE=abs_type.code  " +
            "and a.absence_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
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
            " and decode('" + p_salary_period + "','ALL','ALL',nvl(b.sal_period,' '))='" + p_salary_period + "' " +
            "and UPPER(b.emp_id) in ('" + p_lstEmpID + "')" + 
            "and decode('" + p_status + "','ALL','ALL',b.status)='" + p_status + "'" +
            " GROUP BY A.THR_EMP_PK,c.org_NM,b.emp_id,b.full_name,b.join_dt,NVL (c.seq, 0) " +
            " order by NVL (c.seq, 0),c.org_NM,b.emp_id ";
    }
    else  // if (p_lstEmpID == "")
    {
            SQL = "select c.org_NM,b.emp_id,b.full_name  " +
            ",to_char(to_date(b.join_dt,'yyyymmdd'),'dd/mm/yyyy')  " +
            ",MAX(DECODE(A.ABSENCE_DT,'" + p_from_dt + "',abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ) ,'')) as in_1  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+1,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_2  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+2,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_3  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+3,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_4  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+4,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_5  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+5,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_6  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+6,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_7  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+7,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_8  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+8,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_9  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+9,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_10  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+10,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_11  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+11,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_12  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+12,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_13  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+13,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_14  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+14,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_15  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+15,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_16  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+16,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_17  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+17,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_18  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+18,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_19  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+19,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_20  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+20,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_21  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+21,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_22  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+22,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_23  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+23,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_24  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+24,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_25  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+25,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_26  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+26,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_27  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+27,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_28  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+28,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_29  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+29,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_30  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+30,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_31  " +
            " , NVL (c.seq, 0), SUM (NVL (a.absence_time, 0) / 8) AS total_abs  " +
            "from thr_absence_ur a,thr_employee b,tco_org c  " +
            ",(select d.code,d.char_1 from vhr_hr_code d where id='HR0003') abs_type " +
            "where a.del_if=0 and b.del_if=0 and c.del_if=0  " +
            "and a.THR_EMP_PK=b.pk and b.tco_org_pk=c.pk " +
            "and a.ABSENCE_TYPE=abs_type.code  " +
            "and a.absence_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "and B.LEFT_DT between '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "and B.LEFT_DT IS NOT NULL " +
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
            " GROUP BY A.THR_EMP_PK,c.org_NM,b.emp_id,b.full_name,b.join_dt,NVL (c.seq, 0) " +
            " order by NVL (c.seq, 0),c.org_NM,b.emp_id ";


       SQL1 = "select c.org_NM,b.emp_id,b.full_name  " +
            ",to_char(to_date(b.join_dt,'yyyymmdd'),'dd/mm/yyyy')  " +
            ",MAX(DECODE(A.ABSENCE_DT,'" + p_from_dt + "',abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ) ,'')) as in_1  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+1,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_2  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+2,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_3  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+3,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_4  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+4,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_5  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+5,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_6  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+6,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_7  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+7,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_8  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+8,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_9  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+9,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_10  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+10,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_11  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+11,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_12  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+12,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_13  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+13,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_14  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+14,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_15  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+15,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_16  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+16,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_17  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+17,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_18  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+18,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_19  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+19,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_20  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+20,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_21  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+21,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_22  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+22,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_23  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+23,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_24  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+24,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_25  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+25,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_26  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+26,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_27  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+27,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_28  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+28,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_29  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+29,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_30  " +
            ",MAX(DECODE(A.ABSENCE_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+30,'YYYYMMDD'),abs_type.char_1 || decode(nvl(absence_time,8),8,'','(' || absence_time || ')' ),'')) as in_31  " +
            " , NVL (c.seq, 0), SUM (NVL (a.absence_time, 0) / 8) AS total_abs  " +
            "from thr_absence_ur a,thr_employee b,tco_org c  " +
            ",(select d.code,d.char_1 from vhr_hr_code d where id='HR0003') abs_type " +
            "where a.del_if=0 and b.del_if=0 and c.del_if=0  " +
            "and a.THR_EMP_PK=b.pk and b.tco_org_pk=c.pk " +
            "and a.ABSENCE_TYPE=abs_type.code  " +
            "and a.absence_dt between '" + p_from_dt + "' and '" + p_to_dt + "' " +
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
            " and decode('" + p_salary_period + "','ALL','ALL',nvl(b.sal_period,' '))='" + p_salary_period + "' " +
            "and b.emp_id like '%" + p_emp_id + "%' " +
            "and decode('" + p_status + "','ALL','ALL',b.status)='" + p_status + "'" +
            " GROUP BY A.THR_EMP_PK,c.org_NM,b.emp_id,b.full_name,b.join_dt,NVL (c.seq, 0) " +
            " order by NVL (c.seq, 0),c.org_NM,b.emp_id ";     
    }

    //Response.Write(SQL);
    //Response.End();
    if (p_status != "R")
    {
        SQL = SQL1;
    }
   
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);          
    
   
    int irow_emp;
    irow_emp = dt_Emp.Rows.Count;
    if (irow_emp == 0)
    {
        Response.Write("There is no data of absence time");
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
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
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
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
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
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
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
      <x:FitHeight>0</x:FitHeight>
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
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=2123 style='border-collapse:
 collapse;table-layout:fixed;width:1610pt'>
 <col width=42 style='mso-width-source:userset;mso-width-alt:1536;width:32pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=64 style='width:48pt'>
 <col width=186 style='mso-width-source:userset;mso-width-alt:6802;width:140pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=50 span=31 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col width=124 style='mso-width-source:userset;mso-width-alt:3706;width:56pt'>
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
  <td class=xl29>ABSENCE SUMMARY <% if (p_tco_dept_pk!="ALL") 
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
  <%
    for (int j = 0; j < iDate_Num; j++) 
    {
   %>
  <td rowspan=2 class=xl49 style='border-bottom:.5pt solid black;font-style:italic;' x:num><%= dt_Cal.Rows[j][0].ToString() %></td>
  <%
    }
   %>
  <td class=xl45 style='border-left:none;font-style:italic;'>Total Absent</td>
  <td class=xl45 style='border-left:none;font-style:italic;'>Sign</td>
 </tr>
 <tr class=xl24 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl43 style='height:27.0pt;border-top:none;font-style:italic;'>STT</td>
  <td class=xl43 style='border-top:none;border-left:none;font-style:italic;'>Nhóm</td>
  <td class=xl43 style='border-top:none;border-left:none;font-style:italic;'>Mã s&#7889;</td>
  <td class=xl43 style='border-top:none;border-left:none;font-style:italic;'>H&#7885; và tên</td>
  <td class=xl43 style='border-top:none;border-left:none;font-style:italic;'>Ngày vào</td>
  <td class=xl43 style='border-top:none;border-left:none;font-style:italic;'>Tổng Vắng</td>
  <td class=xl46 style='border-top:none;border-left:none;font-style:italic;'>Ch&#7919; ký</td>
 </tr>
 <% 
     int jrow=0;
     string s_format;
    for (int i = 0; i < irow_emp; i++) 
    {
        jrow = jrow + 1;
        if (i == 0)
        {
            jrow = 1;
        }
        else
        {
            if (dt_Emp.Rows[i][0].ToString() != dt_Emp.Rows[i - 1][0].ToString())
                jrow = 1;
        }
        if (i == irow_emp - 1)
            s_format = ";border-bottom:.5pt solid windowtext";
        else
            s_format = ";";
    %> 
 <tr class=xl25 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td  height=84 class=xl54 style='height:31.5pt;border-top:none<%=s_format %>' x:num><%= jrow%></td>
  <td  class=xl52 width=102 style='border-top:none;width:77pt<%=s_format %>'><%= dt_Emp.Rows[i][0].ToString() %></td>
  <td  class=xl54 style='border-top:
  none<%=s_format %>'><%= dt_Emp.Rows[i][1].ToString() %></td>
  <td  class=xl52 width=186 style='border-top:none;width:140pt<%=s_format %>'><%= dt_Emp.Rows[i][2].ToString() %></td>
  <td  class=xl56 style='border-top:none<%=s_format %>' x:num><%= dt_Emp.Rows[i][3].ToString() %></td>
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
  <td class=xl39 style='border-left:none<%=s_format %><%=sformat %>'><%= dt_Emp.Rows[i][j+4].ToString() %></td>
  <%
    }
   %>
  <td  class=xl54 style='border-top:none<%=s_format %>'x:num><%= dt_Emp.Rows[i][36].ToString() %></td> 
  <td  class=xl54 style='border-top:
  none<%=s_format %>'>&nbsp;</td>
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
