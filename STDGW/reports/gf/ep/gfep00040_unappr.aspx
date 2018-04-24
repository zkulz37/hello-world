<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

    string SQL = "";
    string p_compk              = ""+ Request["l_compk"];
    string p_seq                = ""+ Request["l_seq"];
    string p_paydue_fr          = ""+ Request["l_paydue_fr"];
    string p_paydue_to          = ""+ Request["l_paydue_to"];
    string p_datefr             = ""+ Request["l_datefr"];
    string p_dateto             = ""+ Request["l_dateto"];
    string p_tco_buspartner_pk  = ""+ Request["l_tco_buspartner_pk"];
    string p_voucher_no         = ""+ Request["l_voucher_no"];
    string p_tac_abplcenter_pk  = ""+ Request["l_tac_abplcenter_pk"];
    string p_type               = ""+ Request["l_type"];
    string p_tab                = ""+ Request["l_tab"];
    string p_pay_date           = ""+ Request["l_pay_date"];
    string p_date               = "";
    string p_cmp_name           = "";
    string p_cmp_add            = "";
    string p_cmp_taxcode        = "";
    string p_bal_opt = Request["bal_opt"];
    
    float  p_famt   = 0;
	float  p_amt    = 0;
    if (p_bal_opt == "0")
    {
        SQL = "SELECT   seq, voucherno, prps_date, appr_date, appr_no, customer, tr_ccy " +
            "       , SUM(tr_famt), SUM(tr_amt), invoice_date, due_date, tr_remark " +
            "       , tr_remark2, reject_remark " +
            "    FROM (SELECT h.pk seq, h.voucherno " +
            "               , TO_CHAR(TO_DATE(t.tr_date, 'YYYYMMDD') " +
            "                       , 'DD/MM/YYYY') prps_date " +
            "               , TO_CHAR(TO_DATE(h.sign_date, 'YYYYMMDD') " +
            "                       , 'DD/MM/YYYY') appr_date " +
            "               , DECODE(h.app_seq, '', '', h.app_seq) appr_no " +
            "               , DECODE(d.tco_buspartner_pk " +
            "                      , '', '' " +
            "                      , (SELECT partner_name " +
            "                           FROM tco_buspartner b " +
            "                          WHERE b.pk = d.tco_buspartner_pk AND b.del_if = 0) ) " +
            "                                                                     customer " +
            "               , t.tr_ccy, NVL(t.tr_famt, 0) tr_famt, NVL(t.tr_amt, 0) tr_amt " +
            "               , (SELECT to_char(to_date(e.item, 'YYYYMMDD'), 'DD/MM/YYYY') " +
            "                    FROM tac_hgtrditem e, tac_abacctitem f " +
            "                   WHERE e.tac_abacctitem_pk = f.pk " +
            "                         AND e.del_if = 0 AND f.del_if = 0 " +
            "                         AND f.tac_abitem_alias = 'INVOICE DATE' " +
            "                         AND e.tac_hgtrd_pk = d.pk and rownum = 1) invoice_date " +
			  " 			   , to_char(to_date(t.due_date, 'YYYYMMDD'), 'DD/MM/YYYY') due_date " +	 
            "               , t.tr_remark, t.tr_remark2, t.reject_remark " +
            "            FROM tfn_eppay t, tac_hgtrh h, tac_hgtrd d " +
            "           WHERE d.tac_hgtrh_pk = h.pk AND t.tac_hgtrd_pk = d.pk " +
            "                 AND t.del_if = 0 and t.confirm_yn = 'Y' AND h.del_if = 0 AND d.del_if = 0 " +
            "                 AND h.tco_company_pk = '" + p_compk + "' " +
            "                  AND NVL(t.tr_famt, 0) <> 0 " +
            "                 AND h.sign_date BETWEEN '20061231' AND '" + p_dateto + "' " +
            "                 AND(d.tac_abplcenter_pk LIKE " +
            "                                            '" + p_tac_abplcenter_pk + "' || '%' " +
            "                     OR '" + p_tac_abplcenter_pk + "' IS NULL) " +
            "                 AND d.tco_buspartner_pk LIKE DECODE(" +
            "                                            '" + p_tco_buspartner_pk + "', '', '%', '" + p_tco_buspartner_pk + "')  " +
            "                 AND h.pk LIKE '" + p_seq + "' || '%' " +
            "                 AND (h.voucherno LIKE '" + p_voucher_no + "' || '%' or '" + p_voucher_no + "' is null ) " +
            "                 AND h.tr_tablenm LIKE " +
            "                       DECODE('" + p_type + "' " +
            "                            , 'SE', 'TAC_HGTRH' " +
            "                            , 'AP', 'TAC_CRDA' " +
            "                            , 'ADV', 'TAC_EMPADVREQ' " +
            "                            , 'AL', '%') " +
            "          UNION ALL " +
            "          SELECT 0 trh_pk, b.req_no voucherno, a.tr_date prps_date " +
            "               , b.appr_date, '' appr_no " +
            "               , DECODE(b.tco_buspartner_pk " +
            "                      , '', c.full_name " +
            "                      , (SELECT partner_name " +
            "                           FROM tco_buspartner c " +
            "                          WHERE c.pk = b.tco_buspartner_pk AND c.del_if = 0) ) " +
            "                                                                     customer " +
            "               , a.tr_ccy, NVL(a.tr_famt, 0), NVL(a.tr_amt, 0), a.pay_date " +
            "               , b.req_date, a.tr_remark, a.tr_remark2, a.reject_remark " +
            "            FROM tfn_eppay a, tac_empadvreq b, tac_employee_adv c " +
            "           WHERE a.del_if = 0 AND b.del_if = 0 AND c.del_if = 0 " +
            "                 AND a.table_nm = 'TAC_EMPADVREQ' and a.confirm_yn = 'Y' AND a.table_pk = b.pk " +
            "                 AND b.charger_pk = c.pk AND a.confirm_yn = 'N' " +
            "                 AND NVL(a.approval_yn, 'N') = 'N' " +
            "                 AND b.tco_company_pk =  '" + p_compk + "' " +
            "                 AND NVL(a.tr_famt, 0) <> 0 " +
            "                 AND a.tr_date BETWEEN '20061231' AND '" + p_dateto + "' " +
            "                 AND(b.tac_abplcenter_pk LIKE '" + p_tac_abplcenter_pk + "' || '%' " +
            "                     OR '" + p_tac_abplcenter_pk + "' IS NULL) " +
            "                 AND b.tco_buspartner_pk LIKE '" + p_tco_buspartner_pk + "' or '" + p_tco_buspartner_pk + "' is null " +
            "                 AND(b.req_no LIKE '" + p_voucher_no + "' || '%' OR '" + p_voucher_no + "' IS NULL) " +
            "                 AND b.voucher_type LIKE " +
            "                                      DECODE('" + p_type + "' " +
            "                                           , 'ADV', 'ADV' " +
            "                                           , 'AL', '%') ) " +
            "GROUP BY seq " +
            "       , voucherno " +
            "       , prps_date " +
            "       , appr_date " +
            "       , appr_no " +
            "       , customer " +
            "       , tr_ccy " +
            "       , invoice_date " +
            "       , due_date " +
            "       , tr_remark " +
            "       , tr_remark2 " +
			  "       , reject_remark " +
            "ORDER BY customer, seq ";
    }  
    else if(p_bal_opt=="1")    
    {
        SQL = "SELECT   seq, voucherno, prps_date, appr_date, appr_no, customer, tr_ccy " +
            "       , SUM(tr_famt), SUM(tr_amt), invoice_date, due_date, tr_remark " +
            "       , tr_remark2, reject_remark " +
            "    FROM (SELECT h.pk seq, h.voucherno " +
            "               , TO_CHAR(TO_DATE(t.tr_date, 'YYYYMMDD') " +
            "                       , 'DD/MM/YYYY') prps_date " +
            "               , TO_CHAR(TO_DATE(h.sign_date, 'YYYYMMDD') " +
            "                       , 'DD/MM/YYYY') appr_date " +
            "               , DECODE(h.app_seq, '', '', h.app_seq) appr_no " +
            "               , DECODE(d.tco_buspartner_pk " +
            "                      , '', '' " +
            "                      , (SELECT partner_name " +
            "                           FROM tco_buspartner b " +
            "                          WHERE b.pk = d.tco_buspartner_pk AND b.del_if = 0) ) " +
            "                                                                     customer " +
            "               , t.tr_ccy, NVL(t.tr_famt, 0) tr_famt, NVL(t.tr_amt, 0) tr_amt " +
            "               , (SELECT to_char(to_date(e.item, 'YYYYMMDD'), 'DD/MM/YYYY') " +
            "                    FROM tac_hgtrditem e, tac_abacctitem f " +
            "                   WHERE e.tac_abacctitem_pk = f.pk " +
            "                         AND e.del_if = 0 AND f.del_if = 0 " +
            "                         AND f.tac_abitem_alias = 'INVOICE DATE' " +
            "                         AND e.tac_hgtrd_pk = d.pk and rownum = 1) invoice_date " +
			  "					, to_char(to_date(t.due_date, 'YYYYMMDD'), 'DD/MM/YYYY') due_date " +	
            "               , t.tr_remark, t.tr_remark2, t.reject_remark " +
            "            FROM tfn_eppay t, tac_hgtrh h, tac_hgtrd d " +
            "           WHERE d.tac_hgtrh_pk = h.pk AND t.tac_hgtrd_pk = d.pk " +
            "                 AND t.del_if = 0 and t.confirm_yn = 'Y' AND h.del_if = 0 AND d.del_if = 0 " +
            "                 AND h.tco_company_pk = '" + p_compk + "' " +
            "                  AND NVL(t.tr_famt, 0) = 0 " +
            "                 AND h.sign_date BETWEEN '20061231' AND '" + p_dateto + "' " +
            "                 AND(d.tac_abplcenter_pk LIKE " +
            "                                            '" + p_tac_abplcenter_pk + "' || '%' " +
            "                     OR '" + p_tac_abplcenter_pk + "' IS NULL) " +
            "                 AND d.tco_buspartner_pk LIKE DECODE('" + p_tco_buspartner_pk + "', '', '%', '" + p_tco_buspartner_pk + "') " +
            "                 AND h.pk LIKE '" + p_seq + "' || '%' " +
            "                 AND ( h.voucherno LIKE '" + p_voucher_no + "' || '%' or '" + p_voucher_no + "' is null " + 
            "                 AND h.tr_tablenm LIKE " +
            "                       DECODE('" + p_type + "' " +
            "                            , 'SE', 'TAC_HGTRH' " +
            "                            , 'AP', 'TAC_CRDA' " +
            "                            , 'ADV', 'TAC_EMPADVREQ' " +
            "                            , '%') " +
            "          UNION ALL " +
            "          SELECT 0 trh_pk, b.req_no voucherno, a.tr_date prps_date " +
            "               , b.appr_date, '' appr_no " +
            "               , DECODE(tco_buspartner_pk " +
            "                      , '', c.full_name " +
            "                      , (SELECT partner_name " +
            "                           FROM tco_buspartner c " +
            "                          WHERE c.pk = b.tco_buspartner_pk AND c.del_if = 0) ) " +
            "                                                                     customer " +
            "               , a.tr_ccy, NVL(a.tr_famt, 0), NVL(a.tr_amt, 0), a.pay_date " +
            "               , b.req_date, a.tr_remark, a.tr_remark2, a.reject_remark " +
            "            FROM tfn_eppay a, tac_empadvreq b, tac_employee_adv c " +
            "           WHERE a.del_if = 0 AND b.del_if = 0 AND c.del_if = 0 " +
            "                 AND a.table_nm = 'TAC_EMPADVREQ' and a.confirm_yn = 'Y' AND a.table_pk = b.pk " +
            "                 AND b.charger_pk = c.pk AND a.confirm_yn = 'Y' " +
            "                 AND b.tco_company_pk =  '" + p_compk + "' " +
            "                 AND NVL(a.tr_famt, 0) = 0" +
            "                 AND a.tr_date BETWEEN '20061231' AND '" + p_dateto + "' " +
            "                 AND(b.tac_abplcenter_pk LIKE '" + p_tac_abplcenter_pk + "' || '%' " +
            "                     OR '" + p_tac_abplcenter_pk + "' IS NULL) " +
            "                 AND b.tco_buspartner_pk LIKE '" + p_tco_buspartner_pk + "' or '" + p_tco_buspartner_pk + "' is null " +
            "                 AND(b.req_no LIKE '" + p_voucher_no + "' || '%' OR '" + p_voucher_no + "' IS NULL) " +
            "                 AND b.voucher_type LIKE " +
            "                                      DECODE('" + p_type + "' " +
            "                                           , 'ADV', 'ADV' " +
            "                                           , 'AL', '%') ) " +
            "GROUP BY seq " +
            "       , voucherno " +
            "       , prps_date " +
            "       , appr_date " +
            "       , appr_no " +
            "       , customer " +
            "       , tr_ccy " +
            "       , invoice_date " +
            "       , due_date " +
            "       , tr_remark " +
            "       , tr_remark2 " +
			"       , reject_remark " +
            "ORDER BY customer, seq ";        
    }
    else if (p_bal_opt == "2")
    {
        SQL = "SELECT   seq, voucherno, prps_date, appr_date, appr_no, customer, tr_ccy " +
            "       , SUM(tr_famt), SUM(tr_amt), invoice_date, due_date, tr_remark " +
            "       , tr_remark2, reject_remark " +
            "    FROM (SELECT h.pk seq, h.voucherno " +
            "               , TO_CHAR(TO_DATE(t.tr_date, 'YYYYMMDD') " +
            "                       , 'DD/MM/YYYY') prps_date " +
            "               , TO_CHAR(TO_DATE(h.sign_date, 'YYYYMMDD') " +
            "                       , 'DD/MM/YYYY') appr_date " +
            "               , DECODE(h.app_seq, '', '', h.app_seq) appr_no " +
            "               , DECODE(d.tco_buspartner_pk " +
            "                      , '', '' " +
            "                      , (SELECT partner_name " +
            "                           FROM tco_buspartner b " +
            "                          WHERE b.pk = d.tco_buspartner_pk AND b.del_if = 0) ) " +
            "                                                                     customer " +
            "               , t.tr_ccy, NVL(t.tr_famt, 0) tr_famt, NVL(t.tr_amt, 0) tr_amt " +
            "               , (SELECT to_char(to_date(e.item, 'YYYYMMDD'), 'DD/MM/YYYY') " +
            "                    FROM tac_hgtrditem e, tac_abacctitem f " +
            "                   WHERE e.tac_abacctitem_pk = f.pk " +
            "                         AND e.del_if = 0 AND f.del_if = 0 " +
            "                         AND f.tac_abitem_alias = 'INVOICE DATE' " +
            "                         AND e.tac_hgtrd_pk = d.pk and rownum = 1) invoice_date " +
			  "				   , to_char(to_date(t.due_date, 'YYYYMMDD'), 'DD/MM/YYYY') due_date " +
            "               , t.tr_remark, t.tr_remark2, t.reject_remark " +
            "            FROM tfn_eppay t, tac_hgtrh h, tac_hgtrd d " +
            "           WHERE d.tac_hgtrh_pk = h.pk AND t.tac_hgtrd_pk = d.pk " +
            "                 AND t.del_if = 0 and t.confirm_yn = 'Y' AND h.del_if = 0 AND d.del_if = 0 " +
            "                 AND h.tco_company_pk = '" + p_compk + "' " +
            "                  AND NVL(t.tr_famt, 0) > 0 " +
            "                 AND h.sign_date BETWEEN '20061231' AND '" + p_dateto + "' " +
            "                 AND(d.tac_abplcenter_pk LIKE " +
            "                  '" + p_tac_abplcenter_pk + "' || '%' " +
            "                     OR '" + p_tac_abplcenter_pk + "' IS NULL) " +
            "                 AND d.tco_buspartner_pk LIKE DECODE('" + p_tco_buspartner_pk + "', '', '%', '" + p_tco_buspartner_pk + "') " +
            "                 AND h.pk LIKE '" + p_seq + "' || '%' " +
            "                 AND ( h.voucherno LIKE '" + p_voucher_no + "' || '%' or '" + p_voucher_no + "' is null " + 
            "                 AND h.tr_tablenm LIKE " +
            "                       DECODE('" + p_type + "' " +
            "                            , 'SE', 'TAC_HGTRH' " +
            "                            , 'AP', 'TAC_CRDA' " +
            "                            , 'ADV', 'TAC_EMPADVREQ' " +
            "                            , 'AL', '%') " +
            "          UNION ALL " +
            "          SELECT 0 trh_pk, b.req_no voucherno, a.tr_date prps_date " +
            "               , b.appr_date, '' appr_no " +
            "               , DECODE(tco_buspartner_pk " +
            "                      , '', c.full_name " +
            "                      , (SELECT partner_name " +
            "                           FROM tco_buspartner c " +
            "                          WHERE c.pk = b.tco_buspartner_pk AND c.del_if = 0) ) " +
            "                                                                     customer " +
            "               , a.tr_ccy, NVL(a.tr_famt, 0), NVL(a.tr_amt, 0), a.pay_date " +
            "               , b.req_date, a.tr_remark, a.tr_remark2, a.reject_remark " +
            "            FROM tfn_eppay a, tac_empadvreq b, tac_employee_adv c " +
            "           WHERE a.del_if = 0 AND b.del_if = 0 AND c.del_if = 0 " +
            "                 AND a.table_nm = 'TAC_EMPADVREQ' and a.confirm_yn = 'Y' AND a.table_pk = b.pk " +
            "                 AND b.charger_pk = c.pk AND a.confirm_yn = 'N' " +
            "                 AND b.tco_company_pk =  '" + p_compk + "' " +
            "                 AND NVL(a.tr_famt, 0) > 0" +
            "                 AND a.tr_date BETWEEN '20061231' AND '" + p_dateto + "' " +
            "                 AND(b.tac_abplcenter_pk LIKE '" + p_tac_abplcenter_pk + "' || '%' " +
            "                     OR '" + p_tac_abplcenter_pk + "' IS NULL) " +
            "                 AND b.tco_buspartner_pk LIKE '" + p_tco_buspartner_pk + "' or '" + p_tco_buspartner_pk + "' is null " +
            "                 AND(b.req_no LIKE '" + p_voucher_no + "' || '%' OR '" + p_voucher_no + "' IS NULL) " +
            "                 AND b.voucher_type LIKE " +
            "                                      DECODE('" + p_type + "' " +
            "                                           , 'ADV', 'ADV' " +
            "                                           , 'AL', '%') ) " +
            "GROUP BY seq " +
            "       , voucherno " +
            "       , prps_date " +
            "       , appr_date " +
            "       , appr_no " +
            "       , customer " +
            "       , tr_ccy " +
            "       , invoice_date " +
            "       , due_date " +
            "       , tr_remark " +
            "       , tr_remark2 " +
			"       , reject_remark " +
            "ORDER BY customer, seq ";                
    }
    
    //Response.Write(SQL);    
    //Response.End();
    DataTable dt3 =ESysLib.TableReadOpen(SQL);
   if(dt3.Rows.Count == 0)
   {
	Response.Write("There isn't row to display!"); 
	Response.End();
    }	
    SQL = " SELECT PARTNER_LNAME, ADDR2, TAX_CODE  FROM TCO_COMPANY WHERE PK = '" + p_compk + "' ";
	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if (dt1.Rows.Count >0)
	{
		p_cmp_name      = dt1.Rows[0][0].ToString();
		p_cmp_add       = dt1.Rows[0][1].ToString();
		p_cmp_taxcode   = dt1.Rows[0][2].ToString();
	}
	
	SQL = "SELECT TO_CHAR(TO_DATE('" + p_pay_date + "','YYYYMMDD'),'DD/MM/YYYY') FROM DUAL";
	DataTable dt2 = ESysLib.TableReadOpen(SQL);
	if (dt2.Rows.Count >0)
	{
		p_date          = dt2.Rows[0][0].ToString();
	}

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfep00020_paylist1_files/filelist.xml">
<link rel=Edit-Time-Data href="gfep00020_paylist1_files/editdata.mso">
<link rel=OLE-Object-Data href="gfep00020_paylist1_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Tuyen</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2008-10-23T05:58:35Z</o:LastPrinted>
  <o:Created>2006-10-29T04:26:21Z</o:Created>
  <o:LastSaved>2008-10-23T05:59:22Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.25in 0in .25in .5in;
	mso-header-margin:.5in;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl42
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl48
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Payable List</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>25</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Payable List'!$A$8:$P$8</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Payable List'!$7:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1422 style='border-collapse:
 collapse;table-layout:fixed;width:1066pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl24 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:5302'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:6582'>
 <col class=xl24 width=201 style='mso-width-source:userset;mso-width-alt:7350;
 width:151pt'>
 <col class=xl24 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=75 span=2 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <col class=xl24 width=204 style='mso-width-source:userset;mso-width-alt:7460;
 width:153pt'>
 <col class=xl24 width=215 style='mso-width-source:userset;mso-width-alt:7862;
 width:161pt'>
 <col class=xl24 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl26 colspan=8 width=547 style='height:15.75pt;
  mso-ignore:colspan;width:410pt'><%=p_cmp_name%></td>
  <td class=xl30 width=49 style='width:37pt'></td>
  <td class=xl29 width=110 style='width:83pt'></td>
  <td class=xl28 width=103 style='width:77pt'></td>
  <td class=xl28 width=75 style='width:56pt'></td>
  <td class=xl28 width=75 style='width:56pt'></td>
  <td class=xl28 width=204 style='width:153pt'></td>
  <td class=xl28 width=215 style='width:161pt'></td>
  <td class=xl28 width=44 style='width:33pt'></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl28 colspan=10 style='height:15.75pt;mso-ignore:colspan'><%=p_cmp_add %></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=21 style='height:15.75pt'>
  <td height=21 class=xl28 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Tax
  Code/MST:&nbsp;&nbsp;<%=p_cmp_taxcode%></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=16 height=30 class=xl48 width=1422 style='height:22.5pt;
  width:1066pt'>PAYABLE LIST</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td colspan=16 height=20 class=xl49 width=1422 style='height:15.0pt;
  width:1066pt'>At date <%=p_date%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td rowspan=2 height=40 class=xl43 width=64 style='height:30.0pt;width:48pt'>Seq</td>
  <td rowspan=2 class=xl43 width=88 style='width:66pt'>Voucher No</td>
  <td rowspan=2 class=xl43 width=75 style='width:56pt'>Proposed<br>
    Date</td>
  <td colspan=2 class=xl45 width=119 style='border-right:.5pt solid black;
  border-left:none;width:89pt'>Arppoved Date</td>
  <td rowspan=2 class=xl43 width=0>Project</td>
  <td rowspan=2 class=xl43 width=0>Scope of work</td>
  <td rowspan=2 class=xl43 width=201 style='width:151pt'>Customer/Supplier</td>
  <td rowspan=2 class=xl43 width=49 style='border-bottom:.5pt solid black;
  width:37pt'>Ccy</td>
  <td colspan=2 class=xl45 width=213 style='border-right:.5pt solid black;
  border-left:none;width:160pt'>Amount</td>
  <td rowspan=2 class=xl43 width=75 style='width:56pt'>Invoice Date</td>
  <td rowspan=2 class=xl43 width=75 style='width:56pt'>Due Date</td>
  <td rowspan=2 class=xl43 width=204 style='width:153pt'>Description</td>
  <td rowspan=2 class=xl43 width=215 style='width:161pt'>Remark</td>
  <td rowspan=2 class=xl43 width=44 style='border-bottom:.5pt solid black;
  width:33pt'>Sign</td>
 </tr>
 <tr class=xl25 height=20 style='height:15.0pt'>
  <td height=20 class=xl37 id="_x0000_s1028" x:autofilter="all" width=75
  style='height:15.0pt;width:56pt'>Date</td>
  <td class=xl37 id="_x0000_s1029" x:autofilter="all" width=44
  style='width:33pt'>No</td>
  <td class=xl37 id="_x0000_s1033" x:autofilter="all" width=110
  style='width:83pt'>Trans</td>
  <td class=xl37 id="_x0000_s1034" x:autofilter="all" width=103
  style='width:77pt'>Book</td>
 </tr>
 <%		
	int i = 0;
	decimal l_sum_trans_cust = 0, l_sum_book_cust = 0;
	string l_customer = "";
	if(dt3.Rows[0][5].ToString().Trim() != "")
		l_customer = dt3.Rows[0][5].ToString().Trim();
	
	if (dt3.Rows.Count >0)
	{
		for(i=0; i<dt3.Rows.Count; i++)
		{
			p_famt = p_famt + float.Parse(dt3.Rows[i][7].ToString());
			p_amt  = p_amt  + float.Parse(dt3.Rows[i][8].ToString());
			if(l_customer != dt3.Rows[i][5].ToString().Trim())
			{
	%>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=9 height=20 class=xl51 width=596 style='border-right:.5pt solid black;
  height:15.0pt;width:447pt'>Sub Total</td>
  <td class=xl42 width=110 style='border-top:none;border-left:none;width:83pt'
  x:num></td>
  <td class=xl42 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num><%=l_sum_book_cust%></td>
  <td colspan=5 class=xl58 width=613 style='border-right:.5pt solid black;
  border-left:none;width:459pt'>&nbsp;</td>
 </tr>
<%			
				l_customer = dt3.Rows[i][5].ToString().Trim();
				l_sum_book_cust = 0;					
%>
 <tr height=40 style='height:30.0pt'>
  <td height=40 class=xl38 width=64 style='height:30.0pt;width:48pt' x:num><%= dt3.Rows[i][0].ToString()%></td>
  <td class=xl39 width=88 style='border-left:none;width:66pt'><%= dt3.Rows[i][1].ToString()%></td>
  <td class=xl38 width=75 style='border-left:none;width:56pt'><%= dt3.Rows[i][2].ToString()%></td>
  <td class=xl38 width=75 style='border-left:none;width:56pt'><%= dt3.Rows[i][3].ToString()%></td>
  <td class=xl40 width=44 style='border-left:none;width:33pt'><%= dt3.Rows[i][4].ToString()%></td>
  <td class=xl40 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl40 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl39 width=201 style='border-left:none;width:151pt'><%= dt3.Rows[i][5].ToString()%></td>
  <td class=xl38 width=49 style='border-top:none;border-left:none;width:37pt'><%= dt3.Rows[i][6].ToString()%></td>
  <td class=xl41 width=110 style='border-left:none;width:83pt' x:num><%= dt3.Rows[i][7].ToString()%></td>
  <td class=xl41 width=103 style='border-left:none;width:77pt' x:num><%= dt3.Rows[i][8].ToString()%></td>
  <td class=xl40 width=75 style='border-left:none;width:56pt'><%= dt3.Rows[i][9].ToString()%></td>
  <td class=xl40 width=75 style='border-left:none;width:56pt'><%= dt3.Rows[i][10].ToString()%></td>
  <td class=xl39 width=204 style='border-left:none;width:153pt'><%= dt3.Rows[i][11].ToString()%></td>
  <td class=xl39 width=215 style='border-left:none;width:161pt'><%= dt3.Rows[i][13].ToString()%></td>
  <td class=xl39 width=44 style='border-top:none;border-left:none;width:33pt'>&nbsp;</td>
 </tr>
<%				
				if(dt3.Rows[i][8].ToString().Trim() != "")				
					l_sum_book_cust += decimal.Parse(dt3.Rows[i][8].ToString()) ;
			}
			else
			{	
%>	
 <tr height=40 style='height:30.0pt'>
  <td height=40 class=xl38 width=64 style='height:30.0pt;width:48pt' x:num><%= dt3.Rows[i][0].ToString()%></td>
  <td class=xl39 width=88 style='border-left:none;width:66pt'><%= dt3.Rows[i][1].ToString()%></td>
  <td class=xl38 width=75 style='border-left:none;width:56pt'><%= dt3.Rows[i][2].ToString()%></td>
  <td class=xl38 width=75 style='border-left:none;width:56pt'><%= dt3.Rows[i][3].ToString()%></td>
  <td class=xl40 width=44 style='border-left:none;width:33pt'><%= dt3.Rows[i][4].ToString()%></td>
  <td class=xl40 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl40 width=0 style='border-left:none'>&nbsp;</td>
  <td class=xl39 width=201 style='border-left:none;width:151pt'><%= dt3.Rows[i][5].ToString()%></td>
  <td class=xl38 width=49 style='border-top:none;border-left:none;width:37pt'><%= dt3.Rows[i][6].ToString()%></td>
  <td class=xl41 width=110 style='border-left:none;width:83pt' x:num><%= dt3.Rows[i][7].ToString()%></td>
  <td class=xl41 width=103 style='border-left:none;width:77pt' x:num><%= dt3.Rows[i][8].ToString()%></td>
  <td class=xl40 width=75 style='border-left:none;width:56pt'><%= dt3.Rows[i][9].ToString()%></td>
  <td class=xl40 width=75 style='border-left:none;width:56pt'><%= dt3.Rows[i][10].ToString()%></td>
  <td class=xl39 width=204 style='border-left:none;width:153pt'><%= dt3.Rows[i][11].ToString()%></td>
  <td class=xl39 width=215 style='border-left:none;width:161pt'><%= dt3.Rows[i][13].ToString()%></td>
  <td class=xl39 width=44 style='border-top:none;border-left:none;width:33pt'>&nbsp;</td>
 </tr>
 <%
			if(dt3.Rows[i][8].ToString().Trim() != "")				
				l_sum_book_cust += decimal.Parse(dt3.Rows[i][8].ToString()) ;
		}
	}
}	
%>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=9 height=20 class=xl51 width=596 style='border-right:.5pt solid black;
  height:15.0pt;width:447pt'>Sub Total</td>
  <td class=xl42 width=110 style='border-top:none;border-left:none;width:83pt'
  x:num></td>
  <td class=xl42 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num><%=l_sum_book_cust%></td>
  <td colspan=5 class=xl58 width=613 style='border-right:.5pt solid black;
  border-left:none;width:459pt'>&nbsp;</td>
 </tr> 
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=9 height=20 class=xl45 width=596 style='border-right:.5pt solid black;
  height:15.0pt;width:447pt'>Grand Total</td>
  <td class=xl42 width=110 style='border-top:none;border-left:none;width:83pt'
  x:num><%=p_famt%></td>
  <td class=xl42 width=103 style='border-top:none;border-left:none;width:77pt'
  x:num><%=p_amt%></td>
  <td colspan=5 class=xl58 width=613 style='border-right:.5pt solid black;
  border-left:none;width:459pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl55>Ng&#432;&#7901;i l&#7853;p</td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl55>K&#7871; toán tr&#432;&#7903;ng</td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl56>Giám &#273;&#7889;c</td>
  <td class=xl24></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl54>( ký, h&#7885; tên )</td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl54>( ký, h&#7885; tên )</td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl57>( ký, h&#7885; tên, &#273;óng d&#7845;u )</td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=201 style='width:151pt'></td>
  <td width=49 style='width:37pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=204 style='width:153pt'></td>
  <td width=215 style='width:161pt'></td>
  <td width=44 style='width:33pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
