<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
   
	string p_company_pk = Request["company_pk"];
	string p_dt_from = Request["dtfrom"];
	string p_dt_to =  Request["dtto"];
	string p_status = Request["status"];
	string p_ccy = Request["ccy"];
	string p_rate = Request["rate"];
	string p_level = Request["level"];
	string p_post_sum = Request["post"];
	string p_ac_cd = Request["accd"];
	string p_report_type = Request["rptType"];//1:monthly, 2:period
    string p_language = Request["language"];
    string p_check = Request["check"];
    string p_acctype = Request["acctype"];
	string SQL = "";
	string SQL_SUM = "";
	String p_xls_ccy_format ="";
	string p_cmp_name = "";
    string p_cmp_add = "";
    string p_cmp_taxcode = "";
	string p_rpt_frdate ="";
	string p_rpt_todate ="";
	string p_rpt_dd="";
	string p_rpt_mm ="";
	string p_rpt_yyyy="";
    
   // string p_xls_ccy_format = "";
    if (p_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
	
	string p_report_dsp_date = "";
	
	SQL = " SELECT partner_lname, addr2, tax_code,TO_CHAR(TO_DATE('"+p_dt_from+"01','YYYYMMDD'),'MM/YYYY'),TO_CHAR(TO_DATE('"+p_dt_to+"01','YYYYMMDD'),'MM/YYYY'),TO_CHAR(SYSDATE,'DD'),TO_CHAR(SYSDATE,'MM'), TO_CHAR(SYSDATE,'YYYY')  FROM tco_company WHERE pk = '" + p_company_pk + "' ";

    DataTable dt_comp = ESysLib.TableReadOpen(SQL);

    if (dt_comp.Rows.Count >0)
    {
        p_cmp_name = dt_comp.Rows[0][0].ToString();
        p_cmp_add = dt_comp.Rows[0][1].ToString();
        p_cmp_taxcode = dt_comp.Rows[0][2].ToString();
		p_rpt_frdate = dt_comp.Rows[0][3].ToString();
		p_rpt_todate = dt_comp.Rows[0][4].ToString();
		p_rpt_dd = dt_comp.Rows[0][5].ToString();
		p_rpt_mm = dt_comp.Rows[0][6].ToString();
		p_rpt_yyyy = dt_comp.Rows[0][7].ToString();
    }
	
	if (p_ccy=="VND")
	{
		p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	}
	else
	{
		p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	}
	if(p_report_type=="")
	{
		p_report_type="2";//period is default
	}
	
	if (p_report_type=="2")
	{
        //SQL = "SELECT '', PK, (DECODE (bold_yn, 'B', '<b>', 'I', '<i>', '')|| LPAD(ac_cd, 6 + (ac_level - 1)*12, '&' || 'nbsp;&'||'nbsp;')|| DECODE (bold_yn, 'B', '</b>', 'I', '</i></span>', '')) AC_CD, AC_NM_V, AC_NM_E, AC_NM_K, AC_LEVEL, " + 
        SQL = "SELECT '', PK, (DECODE (bold_yn, 'B', '<b>', 'I', '<i>', '')|| ac_cd|| DECODE (bold_yn, 'B', '</b>', 'I', '</i></span>', '')) AC_CD, AC_NM_V, AC_NM_E, AC_NM_K, AC_LEVEL, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',DR_OP*" + p_rate + ",DR_OP/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_OP, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',CR_OP*" + p_rate + ",CR_OP/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_OP, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',DR_PS*" + p_rate + ",DR_PS/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_PS, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',CR_PS*" + p_rate + ",CR_PS/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_PS, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',DR_ACC*" + p_rate + ",DR_ACC/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_ACC, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',CR_ACC*" + p_rate + ",CR_ACC/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_ACC, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',DR_BL*" + p_rate + ",DR_BL/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_BL, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',CR_BL*" + p_rate + ",CR_BL/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_BL, " +
        "                 BOLD_YN, ('#'||SUBSTR(COLOR,7,2)||SUBSTR(COLOR,5,2)||SUBSTR(COLOR,3,2)) COLOR " +
        "            FROM (SELECT E.AC_CD AC_CD,AC_LNM  AC_NM_V,AC_NM  AC_NM_E,AC_KNM AC_NM_K, KD AC_LEVEL,   " +
        "                         DECODE(DC, 1, (DC*(NVL(LAST_AMT, 0) + NVL(YMAMT, 0))), 0) DR_OP, " +
        "                         DECODE(DC,-1, (DC*(NVL(LAST_AMT, 0) + NVL(YMAMT, 0))), 0) CR_OP, " +
        "                         NVL(DR_PS, 0) DR_PS, " +
        "                         NVL(CR_PS, 0) CR_PS, " +
        "                         NVL(DR_LK, 0) DR_ACC, " +
        "                         NVL(CR_LK, 0) CR_ACC, " +
        "                         DECODE(DC, 1,(DC*(NVL(LAST_AMT,0)+NVL(YMAMT,0))+DC*(NVL(DR_LK,0)-NVL(CR_LK,0))),0) DR_BL, " +
        "                         DECODE(DC,-1,(DC*(NVL(LAST_AMT,0)+NVL(YMAMT,0))+DC*(NVL(DR_LK,0)-NVL(CR_LK,0))),0) CR_BL, " +
        "                         E.BOLD_YN BOLD_YN, NVL(COLOR,'FFFFFFFF') COLOR, E.PK PK " +
        "                    FROM (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK, " +
        "                                 NVL(SUM(THIS_DRBAL),0) - NVL(SUM(THIS_CRBAL),0) LAST_AMT " +
        "                            FROM TAC_HGMMBAL " +
        "                           WHERE STD_YM=SUBSTR(Sf_Get_Lastclosemm(TO_CHAR('" + p_dt_from + "')," + p_company_pk + "),1,6) " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) A, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                  NVL(SUM(YMD_DRBOOKS),0) - NVL(SUM(YMD_CRBOOKS),0) YMAMT " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(Sf_Get_Lastclosemm(TO_CHAR('" + p_dt_to + "')||'01'," + p_company_pk + "),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "                                 AND TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(TO_CHAR('" + p_dt_from + "')||'01','YYYYMMDD'),-1)),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk +
        "                             AND DEL_IF=0 " +
        "                             AND TR_STATUS =  '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) B, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                 NVL(SUM(YMD_DRBOOKS),0) DR_LK, " +
        "                                 NVL(SUM(YMD_CRBOOKS),0) CR_LK " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR('" + p_dt_from + "')||'01' AND TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR('" + p_dt_to + "')||'01','YYYYMMDD')),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) C, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                 NVL(SUM(YMD_DRBOOKS),0) DR_PS, " +
        "                                 NVL(SUM(YMD_CRBOOKS),0) CR_PS " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR('" + p_dt_to + "')||'01' AND TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR('" + p_dt_to + "')||'01','YYYYMMDD')),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) D, " +
        "                         (SELECT A.PK,AC_CD,DECODE(DRCR_TYPE,'D',1,-1) DC,AC_LEVEL KD,AC_NM,AC_KNM,AC_LNM, FONT_STYPE BOLD_YN,  " +
        "                                   B.PRN_COLOR COLOR " +
        "                             FROM TAC_ABACCTCODE A,TAC_KAFINANCEFORM_LEVEL B " +
        "                            WHERE A.DEL_IF    = 0 " +
        "                             AND A.TCO_COMPANY_PK = " + p_company_pk +
        "                              AND A.AC_LEVEL = B.PRN_LEVEL(+) " +
        "                              AND B.DEL_IF(+)    = 0 " +
        "                              and a.ac_level <> '0' " +
        "                              AND A.AC_CD LIKE '" + p_ac_cd + "' || '%' " +
        "                              AND A.AC_LEVEL LIKE decode('" + p_level + "', '', '%', '" + p_level + "') " +
        "                              AND A.LEAF_YN  LIKE decode('" + p_post_sum + "', '', '%', '" + p_post_sum + "')) E " +
        "                    WHERE E.PK = D.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = C.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = B.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = A.TAC_ABACCTCODE_PK(+)  " +
        "                    ORDER BY E.AC_CD) ";


        SQL_SUM = "SELECT 1,                  TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(DR_OP)*" + p_rate + ",SUM(DR_OP)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_OP, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(CR_OP)*" + p_rate + ",SUM(CR_OP)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_OP, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(DR_PS)*" + p_rate + ",SUM(DR_PS)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_PS, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(CR_PS)*" + p_rate + ",SUM(CR_PS)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_PS, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(DR_ACC)*" + p_rate + ",SUM(DR_ACC)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_ACC, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(CR_ACC)*" + p_rate + ",SUM(CR_ACC)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_ACC, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(DR_BL)*" + p_rate + ",SUM(DR_BL)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_BL, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(CR_BL)*" + p_rate + ",SUM(CR_BL)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_BL " +
        "            FROM (SELECT DECODE(DC, 1, (DC*(NVL(LAST_AMT, 0) + NVL(YMAMT, 0))), 0) DR_OP, " +
        "                         DECODE(DC,-1, (DC*(NVL(LAST_AMT, 0) + NVL(YMAMT, 0))), 0) CR_OP, " +
        "                         NVL(DR_PS, 0) DR_PS, " +
        "                         NVL(CR_PS, 0) CR_PS, " +
        "                         NVL(DR_LK, 0) DR_ACC, " +
        "                         NVL(CR_LK, 0) CR_ACC, " +
        "                         DECODE(DC, 1,(DC*(NVL(LAST_AMT,0)+NVL(YMAMT,0))+DC*(NVL(DR_LK,0)-NVL(CR_LK,0))),0) DR_BL, " +
        "                         DECODE(DC,-1,(DC*(NVL(LAST_AMT,0)+NVL(YMAMT,0))+DC*(NVL(DR_LK,0)-NVL(CR_LK,0))),0) CR_BL " +
        "                    FROM (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK, " +
        "                                 NVL(SUM(THIS_DRBAL),0) - NVL(SUM(THIS_CRBAL),0) LAST_AMT " +
        "                            FROM TAC_HGMMBAL " +
        "                           WHERE STD_YM=SUBSTR(Sf_Get_Lastclosemm(TO_CHAR('" + p_dt_from + "')," + p_company_pk + "),1,6) " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) A, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                  NVL(SUM(YMD_DRBOOKS),0) - NVL(SUM(YMD_CRBOOKS),0) YMAMT " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(Sf_Get_Lastclosemm(TO_CHAR('" + p_dt_from + "')||'01'," + p_company_pk + "),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "                                 AND TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(TO_CHAR('" + p_dt_from + "')||'01','YYYYMMDD'),-1)),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk +
        "                             AND DEL_IF=0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) B, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                 NVL(SUM(YMD_DRBOOKS),0) DR_LK, " +
        "                                 NVL(SUM(YMD_CRBOOKS),0) CR_LK " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR('" + p_dt_from + "')||'01' AND TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR('" + p_dt_to + "')||'01','YYYYMMDD')),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) C, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                 NVL(SUM(YMD_DRBOOKS),0) DR_PS, " +
        "                                 NVL(SUM(YMD_CRBOOKS),0) CR_PS " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR('" + p_dt_to + "')||'01' AND TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR('" + p_dt_to + "')||'01','YYYYMMDD')),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) D, " +
        "                         (SELECT A.PK, DECODE(DRCR_TYPE,'D',1,-1) DC " +
        "                            FROM TAC_ABACCTCODE A " +
        "                           WHERE A.DEL_IF    = 0 " +
        "                             AND A.TCO_COMPANY_PK = " + p_company_pk +
        "                             AND A.LEAF_YN   = 'Y'  and a.AC_TABLE_IO='I') E " +
        "                    WHERE E.PK = D.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = C.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = B.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = A.TAC_ABACCTCODE_PK(+)) ";
        p_report_dsp_date = "T&#7915; th&aacute;ng " + p_rpt_frdate + "-&gt; " + p_rpt_todate;
    }

    else
    {
        p_dt_from = p_dt_to;
        p_report_dsp_date = "Th&aacute;ng " + p_rpt_todate;
        //SQL= "SELECT '',PK, (DECODE (bold_yn, 'B', '<b>', 'I', '<i>', '')|| LPAD(ac_cd, 6 + (ac_level - 1)*12, '&' || 'nbsp;&'||'nbsp;')|| DECODE (bold_yn, 'B', '</b>', 'I', '</i></span>', '')) AC_CD, AC_NM_V, AC_NM_E, AC_NM_K, AC_LEVEL,             TRIM(TO_CHAR(DECODE('"+p_ccy+"','VND',DR_OP*"+p_rate+",DR_OP/"+p_rate+"),DECODE('"+p_ccy+"','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_OP, " +
        SQL = "SELECT '',PK, (DECODE (bold_yn, 'B', '<b>', 'I', '<i>', '')|| ac_cd|| DECODE (bold_yn, 'B', '</b>', 'I', '</i></span>', '')) AC_CD, AC_NM_V, AC_NM_E, AC_NM_K, AC_LEVEL,             TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',DR_OP*" + p_rate + ",DR_OP/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_OP, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',CR_OP*" + p_rate + ",CR_OP/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_OP, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',DR_PS*" + p_rate + ",DR_PS/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_PS, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',CR_PS*" + p_rate + ",CR_PS/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_PS, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',DR_ACC*" + p_rate + ",DR_ACC/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_ACC, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',CR_ACC*" + p_rate + ",CR_ACC/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_ACC, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',DR_BL*" + p_rate + ",DR_BL/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_BL, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',CR_BL*" + p_rate + ",CR_BL/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_BL, " +
        "                 BOLD_YN, ('#'||SUBSTR(COLOR,7,2)||SUBSTR(COLOR,5,2)||SUBSTR(COLOR,3,2))  COLOR " +
        "            FROM (SELECT E.AC_CD AC_CD,AC_LNM  AC_NM_V,AC_NM  AC_NM_E,AC_KNM AC_NM_K, KD AC_LEVEL,   " +
        "                         DECODE(DC, 1, (DC*(NVL(LAST_AMT, 0) + NVL(YMAMT, 0))), 0) DR_OP, " +
        "                         DECODE(DC,-1, (DC*(NVL(LAST_AMT, 0) + NVL(YMAMT, 0))), 0) CR_OP, " +
        "                         NVL(DR_PS, 0) DR_PS, " +
        "                         NVL(CR_PS, 0) CR_PS, " +
        "                         NVL(DR_LK, 0) DR_ACC, " +
        "                         NVL(CR_LK, 0) CR_ACC, " +
        "                         DECODE(DC, 1,(DC*(NVL(LAST_AMT,0)+NVL(YMAMT,0))+DC*(NVL(DR_PS,0)-NVL(CR_PS,0))),0) DR_BL, " +
        "                         DECODE(DC,-1,(DC*(NVL(LAST_AMT,0)+NVL(YMAMT,0))+DC*(NVL(DR_PS,0)-NVL(CR_PS,0))),0) CR_BL, " +
        "                         E.BOLD_YN BOLD_YN, NVL(COLOR,'FFFFFFFF') COLOR, E.PK PK " +
        "                    FROM (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK, " +
        "                                 NVL(SUM(THIS_DRBAL),0) - NVL(SUM(THIS_CRBAL),0) LAST_AMT " +
        "                            FROM TAC_HGMMBAL " +
        "                           WHERE STD_YM=SUBSTR(Sf_Get_Lastclosemm(TO_CHAR('" + p_dt_to + "')," + p_company_pk + "),1,6) " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk + " " +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) A, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                  NVL(SUM(YMD_DRBOOKS),0) - NVL(SUM(YMD_CRBOOKS),0) YMAMT " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(Sf_Get_Lastclosemm(TO_CHAR('" + p_dt_to + "')||'01'," + p_company_pk + "),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "                                 AND TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(TO_CHAR('" + p_dt_to + "')||'01','YYYYMMDD'),-1)),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk + " " +
        "                             AND DEL_IF=0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) B, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                 NVL(SUM(YMD_DRBOOKS),0) DR_LK, " +
        "                                 NVL(SUM(YMD_CRBOOKS),0) CR_LK " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR('" + p_dt_to + "')||'01' AND TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR('" + p_dt_to + "')||'01','YYYYMMDD')),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk + " " +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) C, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                 NVL(SUM(YMD_DRBOOKS),0) DR_PS, " +
        "                                 NVL(SUM(YMD_CRBOOKS),0) CR_PS " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR('" + p_dt_to + "')||'01' AND TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR('" + p_dt_to + "')||'01','YYYYMMDD')),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk + " " +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) D, " +
        "                         (SELECT A.PK,AC_CD,DECODE(DRCR_TYPE,'D',1,-1) DC,AC_LEVEL KD,AC_NM,AC_KNM,AC_LNM, FONT_STYPE BOLD_YN,  " +
        "                                   B.PRN_COLOR COLOR " +
        "                             FROM TAC_ABACCTCODE A, TAC_KAFINANCEFORM_LEVEL B " +
        "                            WHERE  A.DEL_IF    = 0 " +
        "                             AND A.TCO_COMPANY_PK = " + p_company_pk +
       "                              AND A.AC_LEVEL = B.PRN_LEVEL(+) " +
        "                              AND B.DEL_IF(+)    = 0 " +
        "                              and a.ac_level <> '0' " +
        "                              AND A.AC_CD LIKE '" + p_ac_cd + "' || '%' " +
        "                              AND A.AC_LEVEL LIKE decode('" + p_level + "', '', '%', '" + p_level + "') " +
        "                              AND A.LEAF_YN  LIKE decode('" + p_post_sum + "', '', '%', '" + p_post_sum + "')) E " +
        "                    WHERE E.PK = D.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = C.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = B.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = A.TAC_ABACCTCODE_PK(+)  " +
        "                    ORDER BY E.AC_CD) ";


        SQL_SUM = "SELECT 1, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(DR_OP)*" + p_rate + ",SUM(DR_OP)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_OP, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(CR_OP)*" + p_rate + ",SUM(CR_OP)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_OP, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(DR_PS)*" + p_rate + ",SUM(DR_PS)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_PS, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(CR_PS)*" + p_rate + ",SUM(CR_PS)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_PS, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(DR_ACC)*" + p_rate + ",SUM(DR_ACC)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_ACC, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(CR_ACC)*" + p_rate + ",SUM(CR_ACC)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_ACC, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(DR_BL)*" + p_rate + ",SUM(DR_BL)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) DR_BL, " +
        "                 TRIM(TO_CHAR(DECODE('" + p_ccy + "','VND',SUM(CR_BL)*" + p_rate + ",SUM(CR_BL)/" + p_rate + "),DECODE('" + p_ccy + "','VND',Sf_Get_Format('ACBG0040'),'9,999,999,999,990.99'))) CR_BL " +
        "            FROM (SELECT DECODE(DC, 1, (DC*(NVL(LAST_AMT, 0) + NVL(YMAMT, 0))), 0) DR_OP, " +
        "                         DECODE(DC,-1, (DC*(NVL(LAST_AMT, 0) + NVL(YMAMT, 0))), 0) CR_OP, " +
        "                         NVL(DR_PS, 0) DR_PS, " +
        "                         NVL(CR_PS, 0) CR_PS, " +
        "                         NVL(DR_LK, 0) DR_ACC, " +
        "                         NVL(CR_LK, 0) CR_ACC, " +
        "                         DECODE(DC, 1,(DC*(NVL(LAST_AMT,0)+NVL(YMAMT,0))+DC*(NVL(DR_PS,0)-NVL(CR_PS,0))),0) DR_BL, " +
        "                         DECODE(DC,-1,(DC*(NVL(LAST_AMT,0)+NVL(YMAMT,0))+DC*(NVL(DR_PS,0)-NVL(CR_PS,0))),0) CR_BL " +
        "                    FROM (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK, " +
        "                                 NVL(SUM(THIS_DRBAL),0) - NVL(SUM(THIS_CRBAL),0) LAST_AMT " +
        "                            FROM TAC_HGMMBAL " +
        "                           WHERE STD_YM=SUBSTR(Sf_Get_Lastclosemm(TO_CHAR('" + p_dt_to + "')," + p_company_pk + "),1,6) " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk + "  " +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) A, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                  NVL(SUM(YMD_DRBOOKS),0) - NVL(SUM(YMD_CRBOOKS),0) YMAMT " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE(Sf_Get_Lastclosemm(TO_CHAR('" + p_dt_to + "')||'01'," + p_company_pk + "),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "                                 AND TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(TO_CHAR('" + p_dt_to + "')||'01','YYYYMMDD'),-1)),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk + "  " +
        "                             AND DEL_IF=0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) B, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                 NVL(SUM(YMD_DRBOOKS),0) DR_LK, " +
        "                                 NVL(SUM(YMD_CRBOOKS),0) CR_LK " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR('" + p_dt_to + "')||'01' AND TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR('" + p_dt_to + "')||'01','YYYYMMDD')),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk + "  " +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) C, " +
        "                         (SELECT MAX(TAC_ABACCTCODE_PK) TAC_ABACCTCODE_PK,  " +
        "                                 NVL(SUM(YMD_DRBOOKS),0) DR_PS, " +
        "                                 NVL(SUM(YMD_CRBOOKS),0) CR_PS " +
        "                            FROM TAC_HGDDBAL " +
        "                           WHERE STD_YMD BETWEEN TO_CHAR('" + p_dt_to + "')||'01' AND TO_CHAR(LAST_DAY(TO_DATE(TO_CHAR('" + p_dt_to + "')||'01','YYYYMMDD')),'YYYYMMDD') " +
        "                             AND TCO_COMPANY_PK = " + p_company_pk + "  " +
        "                             AND DEL_IF = 0 " +
        "                             AND TR_STATUS = '" + p_status + "' " +
        "                           GROUP BY TAC_ABACCTCODE_PK) D, " +
        "                         (SELECT A.PK, DECODE(DRCR_TYPE,'D',1,-1) DC " +
        "                            FROM TAC_ABACCTCODE A " +
        "                           WHERE A.DEL_IF    = 0 " +
        "                             AND A.TCO_COMPANY_PK = " + p_company_pk +
        "                             AND A.LEAF_YN   = 'Y'  and a.AC_TABLE_IO='I') E " +
        "                    WHERE E.PK = D.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = C.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = B.TAC_ABACCTCODE_PK(+) " +
        "                      AND E.PK = A.TAC_ABACCTCODE_PK(+)) ";
    }

    //Response.Write("aaaa");
    //Response.End(); 
    string l_parameter = "'" + p_company_pk + "', ";
    l_parameter += "'" + p_language + "', ";
    l_parameter += "'" + p_dt_from + "', ";
    l_parameter += "'" + p_dt_to + "', ";
    l_parameter += "'" + p_status + "', ";
    l_parameter += "'" + p_ccy + "', ";
    l_parameter += "'" + p_rate + "', ";
    l_parameter += "'" + p_level + "', ";
    l_parameter += "'" + p_post_sum + "', ";
    l_parameter += "'" + p_ac_cd + "', ";
    l_parameter += "'" + p_check + "', ";
    l_parameter += "'" + p_acctype + "' ";
    //Response.Write(l_parameter);
    //Response.End(); 
    DataTable dt_detail = ESysLib.TableReadOpenCursor("SP_SEL_GRD_DTL_GENERAL_LEDGER1", l_parameter);
	DataTable dt_sum = ESysLib.TableReadOpen(SQL_SUM);

%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Trial%20Balance_files/filelist.xml">
<link rel=Edit-Time-Data href="Trial%20Balance_files/editdata.mso">
<link rel=OLE-Object-Data href="Trial%20Balance_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-06-29T05:46:33Z</o:LastPrinted>
  <o:Created>2008-08-11T07:52:23Z</o:Created>
  <o:LastSaved>2010-06-29T05:47:38Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Comma;
	mso-style-id:3;}
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl34
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl45
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl51
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl53
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	mso-protection:unlocked visible;
	white-space:normal;}
.xl54
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
	white-space:normal;}
.xl55
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
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Trial Balance</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>63</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
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
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12180</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Trial Balance'!$A$8:$L$8</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1547 style='border-collapse:
 collapse;table-layout:fixed;width:1163pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=245 style='mso-width-source:userset;mso-width-alt:8960;
 width:184pt'>
 <col class=xl24 width=245 style='mso-width-source:userset;mso-width-alt:8960;
 width:184pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl24 width=117 span=8 style='mso-width-source:userset;mso-width-alt:
 4278;width:88pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 colspan=2 width=324 style='height:15.75pt;
  mso-ignore:colspan;width:243pt'><%= p_cmp_name %></td>
  <td class=xl24 width=245 style='width:184pt'></td>
  <td class=xl24 width=42 style='width:32pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl27 width=117 style='width:88pt'></td>
  <td class=xl27 width=117 style='width:88pt'></td>
  <td class=xl27 width=117 style='width:88pt'></td>
  <td class=xl28 width=117 style='width:88pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%= p_cmp_add %></td>
  <td class=xl25></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Mã
  số thuế:<%= p_cmp_taxcode %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=12 height=30 class=xl45 style='height:22.5pt'>BẢNG CÂN ĐỐI SỐ
  PHÁT SINH - TRIAL BALANCE</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=12 height=26 class=xl29 style='height:19.5pt'><%= p_report_dsp_date %></td>
 </tr>
 <tr class=xl25 height=22 style='height:16.5pt'>
  <td height=22 colspan=8 class=xl25 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl31>Đơn vị tính:</td>
  <td class=xl25><%= p_ccy %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td rowspan=2 height=51 class=xl46 width=79 style='border-bottom:.5pt solid black;
  height:38.25pt;width:59pt'>Account ID<br>
    Mã TK</td>
  <td colspan=2 rowspan=2 class=xl61 width=490 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:368pt'>Account Name<br>
    Tên TK</td>
  <td rowspan=2 class=xl48 style='border-bottom:.5pt solid black'>Level</td>
  <td colspan=2 class=xl50 width=234 style='border-right:.5pt solid black;
  border-left:none;width:176pt' x:str="Openning Balance&#10;SỐ DƯ ĐẦU KỲ"><span
  style='mso-spacerun:yes'> </span>Openning Balance<br>
    SỐ DƯ ĐẦU KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl50 width=234 style='border-right:.5pt solid black;
  border-left:none;width:176pt' x:str="Period amount&#10;SỐ PHÁT SINH TRONG KỲ"><span
  style='mso-spacerun:yes'> </span>Period amount<br>
    SỐ PHÁT SINH TRONG KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl50 width=234 style='border-right:.5pt solid black;
  border-left:none;width:176pt' x:str="Acc. Amount&#10;SỐ PHÁT SINH LŨY KẾ TRONG KỲ"><span
  style='mso-spacerun:yes'> </span>Acc. Amount<br>
    SỐ PHÁT SINH LŨY KẾ TRONG KỲ<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl50 width=234 style='border-right:1.0pt solid black;
  border-left:none;width:176pt' x:str="Ending Balance&#10;SỐ DƯ CUỐI KỲ"><span
  style='mso-spacerun:yes'> </span>Ending Balance<br>
    SỐ DƯ CUỐI KỲ<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt' x:str="NỢ"><span
  style='mso-spacerun:yes'> </span>NỢ<span style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="CÓ"><span style='mso-spacerun:yes'> </span>CÓ<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="NỢ"><span style='mso-spacerun:yes'> </span>NỢ<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="CÓ"><span style='mso-spacerun:yes'> </span>CÓ<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="NỢ"><span style='mso-spacerun:yes'> </span>NỢ<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="CÓ"><span style='mso-spacerun:yes'> </span>CÓ<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="NỢ"><span style='mso-spacerun:yes'> </span>NỢ<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl34 x:str="CÓ"><span style='mso-spacerun:yes'> </span>CÓ<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
  <%
	int i=0;
	string strBegin="";
	string strEnd="";
    string _color = "";
    string _class = "";
    //if (dt_detail.Rows.Count >0)
    //{
		for(i=1;i<dt_detail.Rows.Count;i++)
		{
           
			strBegin="";
			strEnd="";
			if (dt_detail.Rows[i][19].ToString()=="I")
			{
				strBegin="<i>";
				strEnd="</i>";
			}
			if (dt_detail.Rows[i][19].ToString()=="B")
			{
				strBegin="<b>";
				strEnd="</b>";
			}
  
 %>

 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 style="height:15.0pt;background-color:<%=_class%>;"><%=dt_detail.Rows[i][21].ToString()%></td>
 
  <td colspan=2 class=xl36 width=490 style="width:368pt;background-color:<%=_class%>;"><%=strBegin%><%=dt_detail.Rows[i][22].ToString()%><%=strEnd%></td>
  <td class=xl36  width=42 style="text-align:right;width:32pt;background-color:<%=_class%>;"><%=strBegin%><%=dt_detail.Rows[i][23].ToString()%><%=strEnd%></td>
  <td class=xl37 x:num style='mso-number-format:"<%= p_xls_ccy_format%>";background-color:<%=_class%>;'><%=strBegin%><%=dt_detail.Rows[i][3].ToString()%><%=strEnd%></td>
  <td class=xl37 x:num style='mso-number-format:"<%= p_xls_ccy_format%>";background-color:<%=_class%>;'><%=strBegin%><%=dt_detail.Rows[i][4].ToString()%><%=strEnd%></td>
  <td class=xl37 x:num style='mso-number-format:"<%= p_xls_ccy_format%>";background-color:<%=_class%>;'><%=strBegin%><%=dt_detail.Rows[i][7].ToString()%><%=strEnd%></td>
  <td class=xl37 x:num style='mso-number-format:"<%= p_xls_ccy_format%>";background-color:<%=_class%>;'><%=strBegin%><%=dt_detail.Rows[i][8].ToString()%><%=strEnd%></td>
  <td class=xl37 x:num style='mso-number-format:"<%= p_xls_ccy_format%>";background-color:<%=_class%>;'><%=strBegin%><%=dt_detail.Rows[i][11].ToString()%><%=strEnd%></td>
  <td class=xl38 x:num style='mso-number-format:"<%= p_xls_ccy_format%>";background-color:<%=_class%>;'><%=strBegin%><%=dt_detail.Rows[i][12].ToString()%><%=strEnd%></td>
  <td class=xl37 x:num style='mso-number-format:"<%= p_xls_ccy_format%>";background-color:<%=_class%>;'><%=strBegin%><%=dt_detail.Rows[i][15].ToString()%><%=strEnd%></td>
  <td class=xl38 x:num style='mso-number-format:"<%= p_xls_ccy_format%>";background-color:<%=_class%>;'><%=strBegin%><%=dt_detail.Rows[i][16].ToString()%><%=strEnd%></td>
 </tr>
  <%
		}
    //}
%>
 <tr class=xl25 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=3 height=21 class=xl54 width=569 style='height:15.75pt;width:427pt'>Tổng cộng</td>
  <td class=xl39 width=42 style='width:32pt'>&nbsp;</td>
  <td class=xl40 style='mso-number-format:"<%= p_xls_ccy_format%>"' x:num><%=dt_sum.Rows[0][1].ToString()%></td>
  <td class=xl41 style='mso-number-format:"<%= p_xls_ccy_format%>"' x:num><%=dt_sum.Rows[0][2].ToString()%></td>
  <td class=xl41 style='mso-number-format:"<%= p_xls_ccy_format%>"' x:num><%=dt_sum.Rows[0][3].ToString()%></td>
  <td class=xl41 style='mso-number-format:"<%= p_xls_ccy_format%>"' x:num><%=dt_sum.Rows[0][4].ToString()%></td>
  <td class=xl41 style='mso-number-format:"<%= p_xls_ccy_format%>"' x:num><%=dt_sum.Rows[0][5].ToString()%></td>
  <td class=xl42 style='mso-number-format:"<%= p_xls_ccy_format%>"' x:num><%=dt_sum.Rows[0][6].ToString()%></td>
  <td class=xl41 style='mso-number-format:"<%= p_xls_ccy_format%>"' x:num><%=dt_sum.Rows[0][7].ToString()%></td>
  <td class=xl42 style='mso-number-format:"<%= p_xls_ccy_format%>"' x:num><%=dt_sum.Rows[0][8].ToString()%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl29 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl29>Ngày <%=p_rpt_dd %> tháng <%=p_rpt_mm %> năm <%=p_rpt_yyyy %></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl56 style='height:15.75pt'>Người ghi sổ</td>
  <td colspan=2 class=xl56>Kế toán trưởng</td>
  <td class=xl29></td>
  <td colspan=4 class=xl56>Giám đốc</td>
  <td class=xl44></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl52 style='height:15.75pt'>( Ký, họ tên )</td>
  <td colspan=2 class=xl52>( Ký, họ tên )</td>
  <td class=xl29></td>
  <td colspan=4 class=xl52>( Ký, họ tên, đóng dấu )</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=7 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl43 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=7 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=79 style='width:59pt'></td>
  <td width=245 style='width:184pt'></td>
  <td width=245 style='width:184pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
