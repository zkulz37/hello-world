<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

    string p_tco_dept_pk,p_wg_pk,p_status,p_emp_id,p_work_mon,p_from_dt,p_to_dt,p_dept_nm;
    
    p_tco_dept_pk = Request["l_tco_dept_pk"].ToString();
    p_wg_pk = Request["l_thr_group_pk"].ToString();
    p_status = Request["l_status"].ToString();
    p_emp_id = Request["l_emp_id"].ToString();
    p_work_mon = Request["l_work_mon"].ToString();
    p_to_dt = Request["l_to_dt"].ToString();
    p_from_dt = Request["l_from_dt"].ToString();
    p_dept_nm = Request["l_dept_nm"].ToString();
    
    //-----------------information of company-----------------
    string SQL_Com
	= "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY') " + 
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               comm.tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_org g " +
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
   
    string SQL
    = "select w.GROUP_NM,b.emp_id,b.full_name   " +
        "    ,to_char(to_date(b.join_dt,'yyyymmdd'),'dd/mm/yyyy')   " +
        "    ,MAX(DECODE(A.WORK_DT,'"+p_from_dt +"',a.TIME_IN,'')) as in_1   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+1,'YYYYMMDD'),a.TIME_IN,'')) as in_2   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+2,'YYYYMMDD'),a.TIME_IN,'')) as in_3   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+3,'YYYYMMDD'),a.TIME_IN,'')) as in_4   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+4,'YYYYMMDD'),a.TIME_IN,'')) as in_5   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+5,'YYYYMMDD'),a.TIME_IN,'')) as in_6   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+6,'YYYYMMDD'),a.TIME_IN,'')) as in_7   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+7,'YYYYMMDD'),a.TIME_IN,'')) as in_8   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+8,'YYYYMMDD'),a.TIME_IN,'')) as in_9   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+9,'YYYYMMDD'),a.TIME_IN,'')) as in_10   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+10,'YYYYMMDD'),a.TIME_IN,'')) as in_11   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+11,'YYYYMMDD'),a.TIME_IN,'')) as in_12   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+12,'YYYYMMDD'),a.TIME_IN,'')) as in_13   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+13,'YYYYMMDD'),a.TIME_IN,'')) as in_14   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+14,'YYYYMMDD'),a.TIME_IN,'')) as in_15   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+15,'YYYYMMDD'),a.TIME_IN,'')) as in_16   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+16,'YYYYMMDD'),a.TIME_IN,'')) as in_17   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+17,'YYYYMMDD'),a.TIME_IN,'')) as in_18   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+18,'YYYYMMDD'),a.TIME_IN,'')) as in_19   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+19,'YYYYMMDD'),a.TIME_IN,'')) as in_20   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+20,'YYYYMMDD'),a.TIME_IN,'')) as in_21   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+21,'YYYYMMDD'),a.TIME_IN,'')) as in_22   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+22,'YYYYMMDD'),a.TIME_IN,'')) as in_23   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+23,'YYYYMMDD'),a.TIME_IN,'')) as in_24   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+24,'YYYYMMDD'),a.TIME_IN,'')) as in_25   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+25,'YYYYMMDD'),a.TIME_IN,'')) as in_26   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+26,'YYYYMMDD'),a.TIME_IN,'')) as in_27   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+27,'YYYYMMDD'),a.TIME_IN,'')) as in_28   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+28,'YYYYMMDD'),a.TIME_IN,'')) as in_29   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+29,'YYYYMMDD'),a.TIME_IN,'')) as in_30   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+30,'YYYYMMDD'),a.TIME_IN,'')) as in_31   " +
        "    ,MAX(DECODE(A.WORK_DT,'"+p_from_dt +"',a.TIME_OUT,'')) as out_1   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+1,'YYYYMMDD'),a.TIME_OUT,'')) as out_2   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+2,'YYYYMMDD'),a.TIME_OUT,'')) as out_3   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+3,'YYYYMMDD'),a.TIME_OUT,'')) as out_4   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+4,'YYYYMMDD'),a.TIME_OUT,'')) as out_5   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+5,'YYYYMMDD'),a.TIME_OUT,'')) as out_6   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+6,'YYYYMMDD'),a.TIME_OUT,'')) as out_7   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+7,'YYYYMMDD'),a.TIME_OUT,'')) as out_8   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+8,'YYYYMMDD'),a.TIME_OUT,'')) as out_9   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+9,'YYYYMMDD'),a.TIME_OUT,'')) as out_10   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+10,'YYYYMMDD'),a.TIME_OUT,'')) as out_11   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+11,'YYYYMMDD'),a.TIME_OUT,'')) as out_12   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+12,'YYYYMMDD'),a.TIME_OUT,'')) as out_13   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+13,'YYYYMMDD'),a.TIME_OUT,'')) as out_14   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+14,'YYYYMMDD'),a.TIME_OUT,'')) as out_15   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+15,'YYYYMMDD'),a.TIME_OUT,'')) as out_16   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+16,'YYYYMMDD'),a.TIME_OUT,'')) as out_17   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+17,'YYYYMMDD'),a.TIME_OUT,'')) as out_18   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+18,'YYYYMMDD'),a.TIME_OUT,'')) as out_19   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+19,'YYYYMMDD'),a.TIME_OUT,'')) as out_20   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+20,'YYYYMMDD'),a.TIME_OUT,'')) as out_21   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+21,'YYYYMMDD'),a.TIME_OUT,'')) as out_22   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+22,'YYYYMMDD'),a.TIME_OUT,'')) as out_23   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+23,'YYYYMMDD'),a.TIME_OUT,'')) as out_24   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+24,'YYYYMMDD'),a.TIME_OUT,'')) as out_25   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+25,'YYYYMMDD'),a.TIME_OUT,'')) as out_26   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+26,'YYYYMMDD'),a.TIME_OUT,'')) as out_27   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+27,'YYYYMMDD'),a.TIME_OUT,'')) as out_28   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+28,'YYYYMMDD'),a.TIME_OUT,'')) as out_29   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+29,'YYYYMMDD'),a.TIME_OUT,'')) as out_30   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+30,'YYYYMMDD'),a.TIME_OUT,'')) as out_31   " +
        "    ,MAX(DECODE(A.WORK_DT,'"+p_from_dt +"','',TM.D1)) as OT_1   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+1,'YYYYMMDD'),'',TM.D2)) as OT_2   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+2,'YYYYMMDD'),'',TM.D3)) as OT_3   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+3,'YYYYMMDD'),'',TM.D4)) as OT_4   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+4,'YYYYMMDD'),'',TM.D5)) as OT_5   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+5,'YYYYMMDD'),'',TM.D6)) as OT_6   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+6,'YYYYMMDD'),'',TM.D7)) as OT_7   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+7,'YYYYMMDD'),'',TM.D8)) as OT_8   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+8,'YYYYMMDD'),'',TM.D9)) as OT_9   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+9,'YYYYMMDD'),'',TM.D10)) as OT_10   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+10,'YYYYMMDD'),'',TM.D11)) as OT_11   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+11,'YYYYMMDD'),'',TM.D12)) as OT_12   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+12,'YYYYMMDD'),'',TM.D13)) as OT_13   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+13,'YYYYMMDD'),'',TM.D14)) as OT_14   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+14,'YYYYMMDD'),'',TM.D15)) as OT_15   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+15,'YYYYMMDD'),'',TM.D16)) as OT_16   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+16,'YYYYMMDD'),'',TM.D17)) as OT_17   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+17,'YYYYMMDD'),'',TM.D18)) as OT_18   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+18,'YYYYMMDD'),'',TM.D19)) as OT_19   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+19,'YYYYMMDD'),'',TM.D20)) as OT_20   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+20,'YYYYMMDD'),'',TM.D21)) as OT_21   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+21,'YYYYMMDD'),'',TM.D22)) as OT_22   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+22,'YYYYMMDD'),'',TM.D23)) as OT_23   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+23,'YYYYMMDD'),'',TM.D24)) as OT_24   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+24,'YYYYMMDD'),'',TM.D25)) as OT_25   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+25,'YYYYMMDD'),'',TM.D26)) as OT_26   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+26,'YYYYMMDD'),'',TM.D27)) as OT_27   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+27,'YYYYMMDD'),'',TM.D28)) as OT_28   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+28,'YYYYMMDD'),'',TM.D29)) as OT_29   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+29,'YYYYMMDD'),'',TM.D30)) as OT_30   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+30,'YYYYMMDD'),'',TM.D31)) as OT_31  " +						
        "         ,0 AS wt_70 " +
        "         ,sum(nvl(a.work_time,0))/8 AS wt_100                            " +
        "         ,0 as nt_70 " +
        "         ,max(extra.nt_100) " +
        "         ,0 as ot_70 " +
        "         ,max(extra.ot_100) " +
        "         ,0 as ont_70 " +
        "         ,max(extra.ont_100) " +
        "         ,0 as st_70 " +
        "         ,nvl(max(extra.st_100),0) " +
        "         ,0 as ht_70 " +
        "         ,nvl(max(extra.ht_100),0) " +		
        "    ,MAX(DECODE(A.WORK_DT,'"+p_from_dt +"',W.D1,W.D1)) as WT_1   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+1,'YYYYMMDD'),W.D2,W.D2)) as WT_2   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+2,'YYYYMMDD'),W.D3,W.D3)) as WT_3   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+3,'YYYYMMDD'),W.D4,W.D4)) as WT_4   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+4,'YYYYMMDD'),W.D5,W.D5)) as WT_5   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+5,'YYYYMMDD'),W.D6,W.D6)) as WT_6   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+6,'YYYYMMDD'),W.D7,W.D7)) as WT_7   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+7,'YYYYMMDD'),W.D8,W.D8)) as WT_8   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+8,'YYYYMMDD'),W.D9,W.D9)) as WT_9   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+9,'YYYYMMDD'),W.D10,W.D10)) as WT_10   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+10,'YYYYMMDD'),W.D11,W.D11)) as WT_11   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+11,'YYYYMMDD'),W.D12,W.D12)) as WT_12   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+12,'YYYYMMDD'),W.D13,W.D13)) as WT_13   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+13,'YYYYMMDD'),W.D14,W.D14)) as WT_14   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+14,'YYYYMMDD'),W.D15,W.D15)) as WT_15   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+15,'YYYYMMDD'),W.D16,W.D16)) as WT_16   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+16,'YYYYMMDD'),W.D17,W.D17)) as WT_17   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+17,'YYYYMMDD'),W.D18,W.D18)) as WT_18   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+18,'YYYYMMDD'),W.D19,W.D19)) as WT_19   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+19,'YYYYMMDD'),W.D20,W.D20)) as WT_20   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+20,'YYYYMMDD'),W.D21,W.D21)) as WT_21   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+21,'YYYYMMDD'),W.D22,W.D22)) as WT_22   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+22,'YYYYMMDD'),W.D23,W.D23)) as WT_23   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+23,'YYYYMMDD'),W.D24,W.D24)) as WT_24   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+24,'YYYYMMDD'),W.D25,W.D25)) as WT_25   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+25,'YYYYMMDD'),W.D26,W.D26)) as WT_26   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+26,'YYYYMMDD'),W.D27,W.D27)) as WT_27   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+27,'YYYYMMDD'),W.D28,W.D28)) as WT_28   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+28,'YYYYMMDD'),W.D29,W.D29)) as WT_29   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('"+p_from_dt +"','YYYYMMDD')+29,'YYYYMMDD'),W.D30,W.D30)) as WT_30   " +
        "    ,MAX(DECODE(A.WORK_DT,TO_CHAR(TO_DATE('" + p_from_dt + "','YYYYMMDD')+30,'YYYYMMDD'),W.D31,W.D31)) as WT_31 , W.DEPT_NM " +
        " , 0 " +
        " , 0, nvl(abs.abs_100,0)/8,nvl(hol.hol_100,0)/8 " +
        " FROM thr_time_machine_ur a, " + 
        "         thr_employee b, " +
        "         thr_work_mon_ur w, " +
        "         thr_extra_month_ur tm, " +
        "         ( select t.thr_emp_pk , " +
        "              0 AS nt_70, " +
        "         SUM (CASE " +
        "                 WHEN t.ot_type = 'NT'  " +
        "                      AND NVL (ws.during_day, 1) = 1 " +
        "                    THEN t.ot_time " +
        "                 ELSE 0 " +
        "              END " +
        "             ) AS nt_100, " +
        "              0 AS ot_70, " +
        "         SUM (CASE " +
        "                 WHEN t.ot_type = 'OT' and hol_type is null " +
        "                    THEN t.ot_time " +
        "                 ELSE 0 " +
        "              END " +
        "             ) AS ot_100, " +
        "              0 AS ont_70, " +
        "              0  AS ont_100, " +
        "              0 AS st_70, " +
        "         SUM (CASE " +
        "                 WHEN t.hol_type = 'SUN' " +
        "                    THEN t.ot_time " +
        "                 ELSE 0 " +
        "              END " +
        "             ) AS st_100, " +
        "              0 AS ht_70, " +
        "         SUM (CASE " +
        "                 WHEN t.hol_type = 'HOL' " +
        "                    THEN t.ot_time " +
        "                 ELSE 0 " +
        "              END " +
        "             ) AS ht_100 " +
        "         from thr_extra_time_ur t, thr_work_shift ws " +
        "         where t.del_if=0  and ws.del_if=0 and ws.pk=t.thr_ws_pk " +
        "         and t.work_dt  BETWEEN  '" + p_from_dt + "' and '" + p_to_dt + "'  " +
        "         group by t.thr_emp_pk             " +
        "         ) extra          " +
        ",(select ta.THR_EMP_PK,  0 as abs_70 " +
        "         ,  sum(case when ta.ABSENCE_TYPE in ('01','02','08','09','12','14') and nvl(COMPANY_PAY_YN,'N')='Y' " +
        "                then nvl(ta.ABSENCE_TIME,0) else 0 end) as abs_100    " +
        "         from thr_absence_ur ta  " +
        "         where ta.DEL_IF=0 " +
        "         and ta.ABSENCE_DT  between '" + p_from_dt + "' and '" + p_to_dt + "'  " +
        "         group by ta.THR_EMP_PK " +
        "         ) abs          " +
		",( select g.THR_EMP_PK, 0 as hol_70 " + 
        "            , sum(8) as hol_100 " +
        "            from thr_wg_sch_detail g" +
        "            where g.DEL_IF=0  " +
        "            and g.HOL_TYPE='HOL' " +
        "            and g.WORK_DT between '" + p_from_dt + "' AND '" + p_to_dt + "' " +
        "            group by g.THR_EMP_PK ) hol "+
	    " WHERE a.del_if(+) = 0 " + 
        "     AND b.del_if = 0 " +
        "     AND w.del_if = 0 " +
        "     AND tm.del_if = 0      " +
        "     and extra.thr_emp_pk(+) = b.pk " +
        "     AND b.pk = w.thr_emp_pk " +
        "     AND b.pk = a.thr_emp_pk(+) " +
        "     AND b.pk = tm.thr_emp_pk " +
        "	  and hol.thr_emp_pk(+)=b.pk	" +
        "     AND ABS.thr_emp_pk(+) = b.pk      " +
        " and (b.tco_org_pk in (  " +
        "                      SELECT     g.pk  " +
        "                            FROM comm.tco_org g  " +
        "                           WHERE g.del_if = 0  " +
        "                      START WITH g.pk =  " +
        "                                    DECODE ('" + p_tco_dept_pk + "',  " +
        "                                            'ALL', 0,  " +
        "                                            '" + p_tco_dept_pk + "'  " +
        "                                           )  " +
        "                      CONNECT BY PRIOR g.pk = g.p_pk)  " +
        "                OR '" + p_tco_dept_pk + "' = 'ALL')  " +
        " and decode('" + p_wg_pk + "','ALL','" + p_wg_pk + "',w.thr_group_pk)='" + p_wg_pk + "' " +        
        " and decode('" + p_status + "','ALL','" + p_status + "',b.status)='" +p_status+"' " +       
        " and b.emp_id like '%" + p_emp_id + "%'  " +
        "and w.WORK_MON='" + p_work_mon + "' " +
        "and tm.WORK_MON='" + p_work_mon + "' " +
        "and a.WORK_DT(+) between '" + p_from_dt + "' and '" + p_to_dt + "'  " +
        "and a.WORK_DT(+) between b.join_dt and nvl(b.left_dt,'" + p_to_dt + "') " +
        "and b.pk not in (select r.THR_EMP_PK from thr_absence_reg r where r.DEL_IF=0 and r.start_dt<= '" + p_from_dt + "' and r.END_DT>= '" + p_to_dt + "' )" +
        "GROUP BY A.THR_EMP_PK,w.GROUP_NM,b.emp_id,b.full_name,b.join_dt , abs_70, abs_100,hol.hol_70, hol.hol_100,W.DEPT_NM " +
        "ORDER BY  w.group_nm,W.DEPT_NM, b.emp_id ";

    //Response.Write(SQL);
    //Response.End();     
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
	= "select substr(car_date,-2),hol_type " + 
        "from tco_abcalendar  " +
        "where del_if=0 and car_date between '" + p_from_dt + "' and '" + p_to_dt + "' " ;
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
<link rel=File-List href="rpt_in_out_summary_wooyang2_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_in_out_summary_wooyang2_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_in_out_summary_wooyang2_files/oledata.mso">
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
  <o:LastAuthor>WOYANG2</o:LastAuthor>
  <o:LastPrinted>2008-08-25T06:13:20Z</o:LastPrinted>
  <o:Created>2008-08-12T02:55:49Z</o:Created>
  <o:LastSaved>2009-09-04T09:14:34Z</o:LastSaved>
  <o:Company>genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.37in .19in 0in .2in;
	mso-header-margin:.32in;
	mso-footer-margin:0in;
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
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:navy;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	color:navy;
	font-size:30.0pt;
	font-weight:700;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	color:navy;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;}
.xl29
	{mso-style-parent:style0;
	font-size:16.0pt;
	text-align:center;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:16.0pt;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, serif;
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
.xl39
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid gray;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:hairline gray;
	border-bottom:.5pt solid gray;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt dashed gray;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dashed gray;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt dashed gray;
	border-left:.5pt dotted windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:none;
	border-left:.5pt hairline windowtext;}
.xl47
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt dashed gray;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-style:italic;
	font-size:14.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	color:navy;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"mmm\\-yyyy";
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
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
.xl59
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl64
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
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
.xl70
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl72
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
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
.xl73
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
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
.xl74
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt dotted windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:Arial, serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt dotted windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt hairline black;}
.xl81
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt dashed gray;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:.5pt hairline black;}
.xl83
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt dashed gray;
	border-left:.5pt hairline black;}
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
      <x:Scale>39</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>6</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>6</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
       <x:ActiveCol>18</x:ActiveCol>
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
            icur_row+=3;
            cur_group=dt_Emp.Rows[i][140].ToString();
            next_group=dt_Emp.Rows[i+1][140].ToString();
            if (next_group != cur_group)
            {
            //icur_row+=3;
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
  <x:WindowHeight>12990</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$5:$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1027" u1:ext="edit"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2993 style='border-collapse:
 collapse;table-layout:fixed;width:2264pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=129 style='mso-width-source:userset;mso-width-alt:4717;width:97pt'>
 <col width=57 style='mso-width-source:userset;mso-width-alt:2084;width:43pt'>
 <col width=220 style='mso-width-source:userset;mso-width-alt:8045;width:165pt'>
 <col width=106 style='mso-width-source:userset;mso-width-alt:3876;width:80pt'>
 <col width=39 style='mso-width-source:userset;mso-width-alt:1426;width:29pt'>
 <col width=50 span=31 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col width=61 span=13 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 colspan=2 style='height:31.5pt;mso-ignore:colspan'></td>
  <td class=xl24><% = dt_Com.Rows[0][1].ToString()%></td>
  <td class=xl24></td>
  <td></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26>IN - OUT SUMMARY</td>
  <td colspan=29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 colspan=2 style='height:24.75pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan' x:str>
  <span style='mso-spacerun:yes'> </span></td>
  <td></td>
  <td colspan=13 style='mso-ignore:colspan'></td>
  <td class=xl27>Month:</td>
  <td colspan=4 class=xl57 width=100 style='width:76pt'><%=dt_Com.Rows[0][4].ToString()%></td>
  <td colspan=28 style='mso-ignore:colspan'></td>
 </tr>
 
 <tr class=xl29 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl30 style='height:27.0pt'>EmpID</td>
  <td class=xl31>WorkGroup</td>
  <td class=xl31>No.</td>
  <td class=xl31>Full Name</td>
  <td class=xl31>Join Date</td>
  <td class=xl32>Note</td>
  <%
    for (int j = 0; j < iDate_Num; j++) 
    {
   %>
  <td rowspan=2 class=xl58 style='border-bottom:.5pt solid black'><%= dt_Cal.Rows[j][0].ToString() %>&nbsp;</td>
  <%
    }
   %>
  <td colspan=2 class=xl60 style='border-right:.5pt solid black;border-left:
  none'>Working(day)</td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Absence(day)</td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Holiday</td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>OT</td>
  <td colspan=2 class=xl63 style='border-right:.5pt solid black;border-left:
  none'>NT</td>
  <td colspan=2 class=xl63 style='border-right:.5pt solid black;border-left:
  none'>HT</td>
  <td colspan=2 class=xl63 style='border-right:.5pt solid black;border-left:
  none'>Sign</td>
 </tr>
 <tr class=xl29 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl33 style='height:27.0pt'>&nbsp;</td>
  <td class=xl34>Nhóm</td>
  <td class=xl34></td>
  <td class=xl34>Họ và tên</td>
  <td class=xl34>Ngày vào</td>
  <td class=xl35>Ghi chú</td>
  <td colspan=2  class=xl36>Tổng công</td>

  <td colspan=2  class=xl36>Tổng vắng</td>

  <td colspan=2  class=xl36>Ngày lễ</td>

  <td colspan=2  class=xl36>T.C thường</td>

  <td colspan=2  class=xl36>T.C đêm</td>

  <td colspan=2  class=xl36>T.C lễ</td>

  <td colspan=2  class=xl36>Ký tên</td>
 </tr>
 <% 
     double[] total_1 = new double[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,0 };
     double[] total_2 = new double[31];
     double abs_70_tmp = 0;
     double abs_100_tmp = 0;
     for (int l = 0; l < 31; l++)
         total_2[l] = 0;
    for (int i = 0; i < irow_emp; i++) 
    {
        abs_70_tmp += double.Parse(dt_Emp.Rows[i][141].ToString());
        abs_100_tmp += double.Parse(dt_Emp.Rows[i][142].ToString());
        for (int k = 0; k < 12; k++)
        {
            if(dt_Emp.Rows[i][k + 97].ToString()!="")
                total_1[k] += double.Parse(dt_Emp.Rows[i][k + 97].ToString());
        }
        for (int x = 0; x < 31; x++)
        {
            
            try
            {
                if(char.IsNumber(dt_Emp.Rows[i][x + 109].ToString(),0))
                    total_2[x] += double.Parse(dt_Emp.Rows[i][x + 109].ToString());                
            }
            catch (Exception ex)
            {
                
            }
        }
    %>
 <tr class=xl37 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td rowspan=3 height=126 class=xl66 width=99 style='border-bottom:.5pt solid black;
  height:94.5pt;border-top:none;width:74pt'><%= dt_Emp.Rows[i][1].ToString() %>&nbsp;</td>
  <td rowspan=3 class=xl66 width=0 style='border-bottom:.5pt solid black;
  border-top:none'><%= dt_Emp.Rows[i][0].ToString() %>&nbsp;</td>
  <td rowspan=3 class=xl69 style='border-bottom:.5pt solid black;border-top:
  none'><%= i + 1%>&nbsp;</td>
  <td rowspan=2 class=xl66 width=166 style='border-top:none;width:125pt'><%= dt_Emp.Rows[i][2].ToString() %>&nbsp;</td>
  <td rowspan=3 class=xl72 style='border-bottom:.5pt solid black;border-top:
  none'><%= dt_Emp.Rows[i][3].ToString() %>&nbsp;</td>
  <td class=xl38>IN</td>
  <%
      double wt_70 = 0, wt_100 = 0;
    for (int j = 0; j < iDate_Num; j++) 
    {
        string sformat;
        string test="";
        if (dt_Cal.Rows[j][1].ToString()=="HOL")
        {
            sformat = ";background:#FF99CC;mso-pattern:auto none; border-bottom: dashed gray";
            test="HOL";
        }
        else if (dt_Cal.Rows[j][1].ToString() == "SUN")
        {
            sformat = ";background:silver;mso-pattern:auto none; border-bottom: dashed gray";
            test = "SUN";
        }
        else
        {
            sformat = "; border-bottom: dashed gray";
        }
            
   %><%if (dt_Emp.Rows[i][j + 4].ToString() == "" && dt_Emp.Rows[i][j + 35].ToString() == "")
      { %>
  <td rowspan=2 class=xl74 style='border-bottom:.5pt hairline black;border-top:
  none;border-left:none<%=sformat%>'><%= dt_Emp.Rows[i][j + 109].ToString()%>&nbsp;</td>
  <%}
      else
      {
          sformat="";
        %>
  <td class=xl39 style='border-left:none none<%=sformat %>'><%= dt_Emp.Rows[i][j + 4].ToString()%>&nbsp;</td>
  <%} %><%
    }//end of "for" of IN
   %>
  
  <td rowspan=3 colspan=2  class=xl41><%= dt_Emp.Rows[i][98].ToString() %>&nbsp;</td>
  
  <td rowspan=3 colspan=2  class=xl40><%= dt_Emp.Rows[i][143].ToString() %>&nbsp;</td>
  
  <td rowspan=3 colspan=2  class=xl53><%= dt_Emp.Rows[i][144].ToString() %>&nbsp;</td>
  
  <td rowspan=3 colspan=2  class=xl53><%= dt_Emp.Rows[i][102].ToString() %>&nbsp;</td>
  
  <td rowspan=3 colspan=2  class=xl53><%= dt_Emp.Rows[i][100].ToString() %>&nbsp;</td>
  
  <td rowspan=3 colspan=2  class=xl54><%= double.Parse(dt_Emp.Rows[i][108].ToString())+double.Parse(dt_Emp.Rows[i][106].ToString())  %>&nbsp;</td>
  <td rowspan=3 colspan=2  class=xl54>&nbsp;</td>
 </tr>
 <tr class=xl37 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl44 style='height:31.5pt'>OUT</td>
  <%
    for (int j = 0; j < iDate_Num; j++) 
    {
         string sformat;
        if (dt_Cal.Rows[j][1].ToString()=="HOL")
            sformat=";background:#FF99CC;mso-pattern:auto none;";
        else if (dt_Cal.Rows[j][1].ToString()=="SUN")
            sformat = ";background:silver;mso-pattern:auto none;";
        else
        
            sformat="";
    
   %><%if (dt_Emp.Rows[i][j + 4].ToString() == "" && dt_Emp.Rows[i][j + 35].ToString() == "")
     { continue; }
     else
     {%>
  <td class=xl45 style='border-left:none <%=sformat %>'><%= dt_Emp.Rows[i][j+35].ToString() %></td>
  <%} %><%
    } //end of "for" of OUT 
   %>
  <!-- <td class=xl40 ><%= dt_Emp.Rows[i][141].ToString() %>&nbsp;</td>
  <td class=xl40><%= dt_Emp.Rows[i][142].ToString() %>&nbsp;</td>
  <td class=xl46>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl81>&nbsp;</td>
  <td class=xl83>&nbsp;</td> -->
  <td colspan=29 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl37 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl48 style='height:31.5pt'><%= dt_Emp.Rows[i][140].ToString() %>&nbsp;</td>
  <td class=xl49>OT</td>
  <%
    for (int j = 0; j < iDate_Num; j++) 
    {
         string sformat;
        if (dt_Cal.Rows[j][1].ToString()=="HOL")
            sformat=";background:#FF99CC;mso-pattern:auto none;";
        else if (dt_Cal.Rows[j][1].ToString()=="SUN")
            sformat=";background:silver;mso-pattern:auto none;";
        else        
            sformat="";    
   %><%if (dt_Emp.Rows[i][j + 4].ToString() == "" && dt_Emp.Rows[i][j + 35].ToString() == "")
     { 
     %>
  <td class=xl50 style='border-top:none;border-left:none <%=sformat %>'>&nbsp;</td>
  <%}
    else
    { %>
  <td class=xl51 style='border-left:none <%=sformat %>'><%= dt_Emp.Rows[i][j + 66].ToString()%>&nbsp;</td>
  <%} %><%
    } //end of "for" of OT 
   %>
 
  <td colspan=29 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <%
    } //end of "for" of employee 
  %>
  
  
 
 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=49 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>      
 </tr>
 <![endif]>
</table>

</body>

</html>
