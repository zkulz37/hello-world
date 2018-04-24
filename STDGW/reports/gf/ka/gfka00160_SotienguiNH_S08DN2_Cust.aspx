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
    string l_company_pk = "" +Request["company_pk"];
	string l_bank_pk = "" +Request["bank_pk"];
	string l_date_from	= Request["dtbFrom"];
	string l_date_to = Request["dtbTo"];
	string l_book_ccy = Request["Bookccy"];
	string l_status = Request["status"];
    string l_acc_pk = Request["account_pk"];
	
    string p_cmp_name = "";
	string p_cmp_add = "";	
	string p_cmp_taxcode = "";
	
	string p_bank_name = "";
    string p_bank_acc = "";
    string p_bank_ccy = "";
   
    string p_open_trans = "0";
    string p_open_books = "0";
    
    string p_deposit_trans = "0";
    string p_widrawal_trans = "0";
    string p_close_trans = "0";
    
    string p_deposit_books = "0";
    string p_widrawal_books = "0";
    string p_close_books = "0";

	string p_date_frm ="";
	string p_date_to = "";
	int i = 0;
    string p_bank_id = "";
    string p_cust_pk = ""; 
	
   String p_xls_ccy_format ="";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    } 	
   string SQL = " SELECT partner_lname, addr2, tax_code,to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
	SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date  FROM tco_company WHERE pk = '" + l_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
		p_date_frm = dt.Rows[0][3].ToString();
		p_date_to = dt.Rows[0][4].ToString();
    }

    SQL = " SELECT b.PARTNER_NAME, a.ACCOUNT_NO,a.CCY, a.BANK_ID, a.TCO_BUSPARTNER_PK  " + 
        " FROM TAC_ABDEPOMT a,  TCO_BUSPARTNER b " +
        " WHERE A.TCO_BUSPARTNER_PK = B.PK    " +
        " AND A.DEL_IF = 0 AND B.DEL_IF = 0 " +
        " AND a.PK like decode('" + l_bank_pk + "',0,'%','" + l_bank_pk + "')";
        
   dt = ESysLib.TableReadOpen(SQL);
   if (dt.Rows.Count >0)
    {
        p_bank_name = dt.Rows[0][0].ToString();
        p_bank_acc = dt.Rows[0][1].ToString();
        p_bank_ccy = dt.Rows[0][2].ToString();
        p_bank_id = dt.Rows[0][3].ToString();
        p_cust_pk = dt.Rows[0][4].ToString();
    } 

	SQL = "SELECT C.PK  " + 
        "  FROM TCO_ABCODE a, TCO_ABCODEGRP b ,TAC_ABACCTCODE C  " +
        "  WHERE b.ID='FUAB0045'  " +
        "  AND a.TCO_ABCODEGRP_PK=b.PK  " +
        "  AND a.CODE = c.AC_CD  " +
        "  AND a.del_if=0  " +
        "  AND b.del_if=0  " +
        " AND c.del_if=0  " +
        " AND a.USE_IF=1 " +
        " AND c.TCO_COMPANY_PK = " +l_company_pk ;
		
	string p_acct_pk_bank = "";
	dt = ESysLib.TableReadOpen(SQL);
	string p_tmp ="";
	for(i=0;i<dt.Rows.Count;i++)
	{
		p_acct_pk_bank = p_acct_pk_bank+ p_tmp + dt.Rows[i][0].ToString();
		p_tmp = ",";
	}

    SQL = "SELECT pk FROM tac_abacctcode  WHERE del_if = 0 AND leaf_yn = 'Y'  CONNECT BY pac_pk = PRIOR pk START WITH pk = " + l_acc_pk + " ";
    string p_acc_grp = "";
    dt = ESysLib.TableReadOpen(SQL);
    p_tmp = "";
    for (i = 0; i < dt.Rows.Count; i++)
    {
        p_acc_grp = p_acc_grp + p_tmp + dt.Rows[i][0].ToString();
        p_tmp = ",";
    }
    l_acc_pk = p_acc_grp;
     

        SQL = "SELECT   TO_CHAR (NVL (openingtransbalance, 0), '9,999,999,999,990.99') AS open_trans, " +
            "               TO_CHAR (NVL (openingbalance, 0), ac_get_format ('ACBG0040')) AS open_books, " +
            "               a.ccy, " +
            "               TO_CHAR (NVL (TransDeposit, 0), '9,999,999,999,990.99') AS debit_trans_amt, " +
            "               TO_CHAR (NVL (TransWithdrawal, 0), '9,999,999,999,990.99') AS credit_trans_amt, " +
            "               TO_CHAR (NVL (closingtransbalance, 0), '9,999,999,999,990.99') AS bal_trans_amt, " +
            "                " +
            "               TO_CHAR (NVL (BookDeposit, 0), ac_get_format ('ACBG0040')) AS debit_book_amt,  " +
            "               TO_CHAR (NVL (BookWithdrawal, 0), ac_get_format ('ACBG0040')) AS credit_book_amt, " +
            "               TO_CHAR (NVL (closingbalance, 0), ac_get_format ('ACBG0040')) AS bal_book_amt " +
            "          FROM (SELECT  NVL(SUM(YMD_DRTRANS),0) AS TransDeposit " +
            "                ,NVL(SUM(YMD_DRBOOKS),0) AS BookDeposit " +
            "                ,NVL(SUM(YMD_CRTRANS),0) AS TransWithdrawal " +
            "                ,NVL(SUM(YMD_CRBOOKS),0) AS BookWithdrawal " +
            "                ,CCY " +
            "                ,MAX(TAC_ABDEPOMT_PK) TAC_ABDEPOMT_PK " +
            "            FROM TAC_HGDEPODDBAL " +
            "            WHERE DEL_IF = 0 " +
            "            AND TAC_ABDEPOMT_PK  like  decode('" + l_bank_pk + "',0,'%','" + l_bank_pk + "')" +
            "            AND TR_STATUS = " + l_status +
            "            AND TCO_COMPANY_PK like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
            "            AND STD_YMD BETWEEN '"+ l_date_from +"'   AND '"+l_date_to +"'  " +
             "           AND TAC_ABACCTCODE_PK IN (" + l_acc_pk + ") " +
            "            GROUP BY CCY) a, " +
            "               (SELECT DECODE(a.TAC_ABDEPOMT_PK,'',d.TAC_ABDEPOMT_PK,a.TAC_ABDEPOMT_PK) TAC_ABDEPOMT_PK, " +
            "                       (a.mr_amt  + c.dd_amt ) openingbalance, " +
            "                       (a.mr_amt  + c.dd_amt  + d.t_amt) AS closingbalance, " +
            "                       (a.mr_famt  + c.dd_famt ) openingtransbalance, " +
            "                       (a.mr_famt  + c.dd_famt  + d.t_famt) AS closingtransbalance " +
            "                  FROM (SELECT NVL((SUM (NVL(this_drbal,0)) - SUM (NVL(this_crbal,0))),0) mr_amt, " +
            "                               NVL((SUM(NVL(THIS_DRFBAL,0)) -SUM(NVL(THIS_CRFBAL,0))),0) MR_FAMT, " +
            "                               MAX(TAC_ABDEPOMT_PK) TAC_ABDEPOMT_PK " +
            "                          FROM TAC_HGDEPOMMBAL " +
            "                         WHERE del_if = 0 " +
            "                           AND tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
            "                           AND TAC_ABDEPOMT_PK like decode('" + l_bank_pk + "',0,'%','" + l_bank_pk + "')" +
             "           AND TAC_ABACCTCODE_PK IN (" + l_acc_pk + ") " +
            "                           AND tr_status = " + l_status +
            "                           AND std_ym = SUBSTR (ac_get_lastclosemm ('"+ l_date_from +"' , " + l_company_pk +"),1,6)) a, " +
            "                       (SELECT  " +
            "                               NVL((SUM (ymd_drbooks) - SUM (ymd_crbooks)),0) dd_amt, " +
            "                               NVL((SUM (YMD_DRTRANS) - SUM (YMD_CRTRANS)),0) dd_famt " +
            "                                " +
            "                          FROM TAC_HGDEPODDBAL " +
            "                         WHERE del_if = 0 " +
            "                           AND tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
            "                           AND TAC_ABDEPOMT_PK  like decode('" + l_bank_pk + "',0,'%','" + l_bank_pk + "')" +
            "                           AND tr_status = " + l_status +
             "           AND TAC_ABACCTCODE_PK IN (" + l_acc_pk + ") " +
            "                           AND std_ymd " +
            "                                  BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (ac_get_lastclosemm('"+ l_date_from +"' ,  " + l_company_pk +" ),'YYYYMMDD'),+1),'YYYYMMDD') " +
            "                                      AND TO_CHAR (  TO_DATE ('"+ l_date_from +"' ,'YYYYMMDD')- 1,'YYYYMMDD')) c, " +
            "                                       " +
            "                       (SELECT NVL((SUM (NVL(ymd_drbooks,0)) - SUM (NVL(ymd_crbooks,0))),0) t_amt, " +
            "                               NVL((SUM (NVL(YMD_DRTRANS,0)) - SUM (NVL(YMD_CRTRANS,0))),0) t_famt " +
            "                               ,MAX(TAC_ABDEPOMT_PK) TAC_ABDEPOMT_PK " +
            "                          FROM TAC_HGDEPODDBAL " +
            "                         WHERE del_if = 0 " +
            "                           AND tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
             "           AND TAC_ABACCTCODE_PK IN (" + l_acc_pk + ") " +
            "                           AND TAC_ABDEPOMT_PK  like decode('" + l_bank_pk + "',0,'%','" + l_bank_pk + "')" +
            "                           AND tr_status =" + l_status +
            "                           AND (std_ymd BETWEEN '"+ l_date_from +"'  AND '"+l_date_to +"' )) d) b " +
            "         WHERE a.TAC_ABDEPOMT_PK(+) = b.TAC_ABDEPOMT_PK ";


       
		DataTable dt_total = ESysLib.TableReadOpen(SQL);
        if (dt_total.Rows.Count >0)
        {
            p_open_trans = dt_total.Rows[0][0].ToString();
            p_open_books = dt_total.Rows[0][1].ToString();
            
            p_deposit_trans = dt_total.Rows[0][3].ToString();
            p_widrawal_trans = dt_total.Rows[0][4].ToString();
            p_close_trans = dt_total.Rows[0][5].ToString();
            
            p_deposit_books = dt_total.Rows[0][6].ToString();
            p_widrawal_books = dt_total.Rows[0][7].ToString();
            p_close_books = dt_total.Rows[0][8].ToString();
        } 

/*
        SQL = "SELECT TO_CHAR (tr_date, 'DD/MM/YYYY') trans_date, " +
            " h.voucherno, h.remark2,h.remark, ac_get_ACCD(DECODE(D.DRCR_TYPE,'D',DECODE(R.DRCR_TYPE,'C',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR),DECODE(R.DRCR_TYPE,'D',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR)),'" + l_company_pk + "') ACCT_CODE, " +
            " DECODE(d.drcr_type,'D',R.TR_AMT,0) in_amt, " +
            " DECODE(d.drcr_type,'C',R.TR_AMT,0) out_amt, " +
            " (TO_NUMBER('" + p_open_trans + "','9,999,999,999,999,999.99')+SUM(DECODE(d.drcr_type,'D',R.TR_AMT,0) - DECODE(d.drcr_type,'C',R.TR_AMT,0))OVER (ORDER BY  tr_date,h.voucherno,h.pk,r.DRCR_ORD ))BAL_AMT, " +
            " DECODE(d.drcr_type,'D',R.TR_BOOKAMT,0) in_bamt, " +
            " DECODE(d.drcr_type,'C',R.TR_BOOKAMT,0) out_bamt, " +
            " (TO_NUMBER('" + p_open_books + "','9,999,999,999,999,999.99') + SUM(DECODE(d.drcr_type,'D',R.TR_BOOKAMT,0) - DECODE(d.drcr_type,'C',R.TR_BOOKAMT,0))OVER (ORDER BY tr_date,h.voucherno,h.pk,d.pk,r.pk )) BAL_BAMT, " +
            " h.pk h_pk " +
            " FROM  " +
            " TAC_HGTRH h, TAC_HGTRD d, TAC_HGTRDITEM i,TAC_ABDEPOMT e,TAC_HGTRD_REF r " +
            " WHERE H.DEL_IF =0 " +
            " AND D.DEL_IF =0 " +
            " AND I.DEL_IF =0 " +
            " AND E.DEL_IF =0 " +
            " AND R.DEL_IF =0 " +
            " AND H.PK = D.TAC_HGTRH_PK " +
            " AND D.TAC_HGTRH_PK = R.TAC_HGTRH_PK " +
             "           AND TAC_ABACCTCODE_PK IN (" + l_acc_pk + ") " +
            " AND D.PK = R.TAC_HGTRD_PK " +
            " AND D.PK = I.TAC_HGTRD_PK " +
            " AND (   TRIM (e.account_no) = TRIM (i.item_nm) " +
            "                  OR TRIM (e.account_no) = TRIM (i.item) " +
            "                  OR TRIM (e.bank_id) = TRIM (i.item_nm) " +
            "                  OR TRIM (e.bank_id) = TRIM (i.item) " +
            "    ) " +
            " AND H.TR_STATUS IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) " +
            " AND H.TCO_COMPANY_PK =  " + l_company_pk +
            " AND E.PK =  " + l_bank_pk +
            " AND H.TR_DATE BETWEEN TO_DATE('" + l_date_from + "','YYYYMMDD') AND TO_DATE('" + l_date_to + "','YYYYMMDD') " +
            " ORDER BY  tr_date,h.voucherno,h.pk,d.pk,r.pk ";
*/
        SQL = "SELECT TO_CHAR (tr_date, 'DD/MM/YYYY') trans_date,  " +
                "         h.voucherno, r.remark2,r.remark,ac_get_ACCD(DECODE(D.DRCR_TYPE,'D',DECODE(R.DRCR_TYPE,'C',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR),DECODE(R.DRCR_TYPE,'D',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR)),'" + l_company_pk + "') ACCT_CODE,  " +
                "         DECODE(d.drcr_type,'D',R.TR_AMT,0) in_amt,  " +
                "         DECODE(d.drcr_type,'C',R.TR_AMT,0) out_amt,  " +
                "         (TO_NUMBER('" + p_open_trans + "','9,999,999,999,999,999.99')+SUM(DECODE(d.drcr_type,'D',R.TR_AMT,0) - DECODE(d.drcr_type,'C',R.TR_AMT,0))OVER (ORDER BY  tr_date,h.voucherno,h.pk,d.pk,r.pk ))BAL_AMT,  " +
                "         DECODE(d.drcr_type,'D',R.TR_BOOKAMT,0) in_bamt,  " +
                "         DECODE(d.drcr_type,'C',R.TR_BOOKAMT,0) out_bamt,  " +
                "         (TO_NUMBER('" + p_open_books + "','9,999,999,999,999,999.99') + SUM(DECODE(d.drcr_type,'D',R.TR_BOOKAMT,0) - DECODE(d.drcr_type,'C',R.TR_BOOKAMT,0))OVER (ORDER BY tr_date,h.voucherno,h.pk,d.pk,r.pk )) BAL_BAMT,  " +
                "         h.pk, (select PARTNER_ID from TCO_BUSPARTNER where del_if = 0 and pk = r.TCO_BUSPARTNER_PK) PARTNER_ID, (select PARTNER_NAME from TCO_BUSPARTNER where del_if = 0 and pk = r.TCO_BUSPARTNER_PK) PARTNER_NAME   " +
                "         FROM TAC_HGTRH H, TAC_HGTRD D,TAC_HGTRD_REF R, TAC_HGTRDITEM I " +
                "         WHERE H.DEL_IF =0  " +
                "        AND H.TCO_COMPANY_PK like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
                "        AND H.TR_DATE BETWEEN TO_DATE('" + l_date_from + "','YYYYMMDD') AND TO_DATE('" + l_date_to + "','YYYYMMDD') " +
                "        AND D.DEL_IF =0 AND I.DEL_IF =0 AND R.DEL_IF = 0 " +
                "         AND R.TAC_HGTRD_PK = D.PK " +
                "         AND ( ((I.ITEM_TABLE_PK = '" + l_bank_pk + "') OR (I.ITEM_TABLE_PK = '" + p_cust_pk + "'))  AND (I.ITEM_NM =  '" + p_bank_id + "' OR I.ITEM =  '" + p_bank_id + "') )  " +
                "        AND H.PK = D.TAC_HGTRH_PK " +
                "        AND H.PK = R.TAC_HGTRH_PK " +
                "        AND D.PK = I.TAC_HGTRD_PK " +
                "        AND D.TAC_ABACCTCODE_PK =  " + l_acc_pk +
                "        AND H.PK IN (SELECT DISTINCT(B.TAC_HGTRH_PK) FROM TAC_HGDEPODDBAL B " +
                "        WHERE B.DEL_IF =0 AND B.TCO_COMPANY_PK like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')" +
                "        AND B.TAC_ABACCTCODE_PK = " + l_acc_pk +
                "        AND B.TAC_ABDEPOMT_PK like decode('" + l_bank_pk + "',0,'%','" + l_bank_pk + "')" +
                "        AND B.TR_STATUS =  " + l_status +
                "        AND B.STD_YMD BETWEEN '" + l_date_from + "'AND  '" + l_date_to + "'  ) " +
                "        AND H.TR_STATUS IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) " +
                
                "        ORDER BY H.TR_DATE,H.VOUCHERNO,H.PK,D.PK,R.PK "; 

				  //  Response.Write(SQL);
    //Response.End();
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00160_SotienguiNH_S08DN2_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00160_SotienguiNH_S08DN2_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00160_SotienguiNH_S08DN2_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-07-31T08:14:49Z</o:LastPrinted>
  <o:Created>2008-02-02T09:03:07Z</o:Created>
  <o:LastSaved>2008-08-04T07:52:56Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font6
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
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
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
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
	border-left:.5pt solid black;
	white-space:normal;}
.xl56
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
.xl57
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>S&#7893; ti&#7873;n g&#7917;i NH (S08-DN)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>402</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
	 
	 <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>11</x:SplitHorizontal>
     <x:TopRowBottomPane>29</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
	 
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10485</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; ti&#7873;n g&#7917;i NH (S08-DN)'!$A$10:$J$10</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1287 style='border-collapse: collapse;table-layout:fixed;width:967pt'>
 <col class=xl24 width=89 span=3 style='mso-width-source:userset;mso-width-alt: 3254;width:67pt'>
 <col class=xl24 width=271 span=2 style='mso-width-source:userset;mso-width-alt: 9910;width:203pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035; width:62pt'>
 <col class=xl24 width=110 span=3 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377; width:49pt'>
 <col class=xl24 width=110 style='mso-width-source:userset;mso-width-alt: 4022;width:83pt'>
 <col class=xl24 width=271  style='mso-width-source:userset;mso-width-alt: 9910;width:203pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=4 width=538 style='height:15.75pt;
  mso-ignore:colspan;width:404pt'><b><%= p_cmp_name %></b></td>
  <td class=xl24 width=271 style='width:203pt'></td>
  <td class=xl24 width=83 style='width:62pt'></td>
  <td colspan=4 class=xl51 width=395 style='width:298pt'><span
  style='mso-spacerun:yes'> </span>M&#7851;u s&#7889; S08-DN</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=4 style='height:15.75pt;mso-ignore:colspan'><%= p_cmp_add %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl26
  x:str="(Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày ">(Ban
  hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl24 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Tax
  Code/MST:&nbsp;&nbsp;<%= p_cmp_taxcode %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl26>20 tháng 03 n&#259;m 2006 c&#7911;a B&#7897;
  tr&#432;&#7901;ng B&#7897; Tài chính)</td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td colspan=12 height=34 class=xl57 style='height:25.5pt'>S&#7892; TI&#7872;N
  G&#7916;I NGÂN HÀNG</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=12 height=21 class=xl26 style='height:15.75pt'>T&#7915;
  ngày&nbsp;&nbsp;<%= p_date_frm %>&nbsp;&#273;&#7871;n&nbsp;<%= p_date_to %></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 colspan=2 style='height:20.1pt;mso-ignore:colspan'>N&#417;i
  m&#7903; tài kho&#7843;n giao d&#7883;ch:<font class="font6">&nbsp;</font></td>
  <td class=xl24></td>
  <td class=xl25><%=  p_bank_name %></td>
  <td colspan=2 class=xl26 x:str="S&#7889; hi&#7879;u tài kho&#7843;n t&#7841;i n&#417;i g&#7917;i: ">S&#7889;
  hi&#7879;u tài kho&#7843;n t&#7841;i n&#417;i g&#7917;i:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl51><%=  p_bank_acc %></td>
  <td class=xl27 x:str="&#272;&#417;n v&#7883; tính: ">&#272;&#417;n v&#7883;
  tính:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl26><%= l_book_ccy %></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=10 class=xl24 style='height:10.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td rowspan=2 height=42 class=xl52 width=89 style='border-bottom:.5pt solid black;
  height:31.5pt;width:67pt'>Ngày tháng ghi s&#7893;</td>
  <td colspan=2 class=xl54 width=178 style='border-right:.5pt solid black;
  border-left:none;width:134pt'>Ch&#7913;ng t&#7915;</td>
  <td rowspan=2 class=xl52 width=271 style='border-bottom:.5pt solid black;
  width:203pt'>Di&#7877;n gi&#7843;i</td>
  <td class=xl28 width=271 style='width:203pt'>Description</td>
  <td rowspan=2 class=xl52 width=83 style='border-bottom:.5pt solid black;
  width:62pt'>Tài kho&#7843;n &#273;&#7889;i &#7913;ng</td>
  <td colspan=3 class=xl55 width=330 style='border-right:.5pt solid black;
  width:249pt'>S&#7889; phát sinh(Tiền Ghi sổ <%= l_book_ccy %>)</td>
  <td rowspan=2 class=xl52 width=65 style='border-bottom:.5pt solid black;
  width:49pt'>Ghi chú</td>
  <td colspan=2 class=xl52 width=271 style='border-bottom:.5pt solid black;  width:203pt'>Customer</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 width=89 style='height:15.75pt;width:67pt'>S&#7889;
  hi&#7879;u</td>
  <td class=xl29 width=89 style='width:67pt'>Ngày tháng</td>
  <td class=xl30 width=271 style='width:203pt'>&nbsp;</td>
  <td class=xl30 width=110 style='width:83pt'>Thu (g&#7917;i vào)</td>
  <td class=xl30 width=110 style='width:83pt'>Chi (rút ra)</td>
  <td class=xl30 width=110 style='width:83pt'>Còn l&#7841;i</td>
  <td class=xl30 width=110 style='width:83pt'>Code</td>
  <td class=xl30 width=110 style='width:83pt'>Name</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl31 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$10:$J$10" width=89 style='height:20.1pt;width:67pt'>A</td>
  <td class=xl32 id="_x0000_s1026" x:autofilter="all" width=89
  style='width:67pt'>B</td>
  <td class=xl32 id="_x0000_s1027" x:autofilter="all" width=89
  style='width:67pt'>C</td>
  <td class=xl30 id="_x0000_s1028" x:autofilter="all" width=271
  style='width:203pt'>D</td>
  <td class=xl30 id="_x0000_s1037" x:autofilter="all" width=271
  style='width:203pt'>&nbsp;</td>
  <td class=xl30 id="_x0000_s1029" x:autofilter="all" width=83
  style='width:62pt'>E</td>
  <td class=xl30 id="_x0000_s1033" x:autofilter="all" width=110
  style='width:83pt' x:num>1</td>
  <td class=xl30 id="_x0000_s1034" x:autofilter="all" width=110
  style='width:83pt' x:num>2</td>
  <td class=xl30 id="_x0000_s1035" x:autofilter="all" width=110
  style='width:83pt' x:num>3</td>
  <td class=xl30 id="_x0000_s1036" x:autofilter="all" width=65
  style='width:49pt'>F</td>
  <td class=xl30 id="_x0000_s1036" x:autofilter="all" width=65
  style='width:49pt'></td>
  <td class=xl30 id="_x0000_s1036" x:autofilter="all" width=65
  style='width:49pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>S&#7888; T&#7890;N &#272;&#7846;U K&#7922;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48 align=right x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= p_open_books %> </td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'>&nbsp;</td>
  <td class=xl34></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>S&#7889; phát sinh trong k&#7923;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <%		
    //Response.Write(SQL);
    //Response.End();
        
    
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	
	string strDate = "";
	string strDate_Dsp = "";
	
	if (dt_detail.Rows.Count >0)
	{
		for(i=0;i<dt_detail.Rows.Count;i++)
		{
			if (strDate!= dt_detail.Rows[i][0].ToString())
			{
				strDate_Dsp = dt_detail.Rows[i][0].ToString();
				strDate = dt_detail.Rows[i][0].ToString();
			}
			else
			{
				strDate_Dsp = "";
			}
	%> 
 <tr height=42 style='height:31.5pt;mso-height-source:auto'>
  <td height=42 class=xl44 style='height:31.5pt' x:str="<%= strDate_Dsp %>" ><%= strDate_Dsp %></td>
  <td class=xl45 style='white-space:nowrap;mso-text-control:shrinktofit;' ><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl46 x:str="<%= dt_detail.Rows[i][0].ToString() %>"  ><%= dt_detail.Rows[i][0].ToString() %></td>
  <td class=xl35 width=271 style='width:203pt'><%= dt_detail.Rows[i][3].ToString() %></td>
  <td class=xl35 width=271 style='width:203pt'><%= dt_detail.Rows[i][2].ToString() %></td>
  <td class=xl45 x:num><%= dt_detail.Rows[i][4].ToString() %></td>
  <td class=xl36 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_detail.Rows[i][8].ToString() %></td>
  <td class=xl36 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_detail.Rows[i][9].ToString() %></td>
  <td class=xl36 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_detail.Rows[i][10].ToString() %></td>
  <td class=xl58 x:num><%= dt_detail.Rows[i][11].ToString() %></td>
  <td class=xl58 style='white-space:normal'><%= dt_detail.Rows[i][12].ToString() %></td>
  <td class=xl58 style='white-space:normal'><%= dt_detail.Rows[i][13].ToString() %></td>
 </tr>
 <%
		}
	}
	
%> 
 
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt'>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>C&#7897;ng phát sinh trong k&#7923;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl38 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=p_deposit_books %></td>
  <td class=xl38 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=p_widrawal_books %></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>S&#7888; T&#7890;N CU&#7888;I K&#7922;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
  <td class=xl42 align=right x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= p_close_books %></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=10 class=xl24 style='height:8.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 colspan=4 style='height:20.1pt;mso-ignore:colspan'>S&#7893;
  này có ............. trang, &#273;ánh s&#7889; t&#7915; trang s&#7889; 01
  &#273;&#7871;n trang ................</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 colspan=3 style='height:20.1pt;mso-ignore:colspan'>Ngày
  m&#7903; s&#7893;: .............................</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 colspan=2 class=xl24 style='height:9.75pt;mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl50></td>
 </tr>
<%
    SQL = "SELECT   " +
            "    D.CODE, " +
            "    D.CHAR_1,  " +
            "    D.CHAR_2,  " +
            "    D.CHAR_3,  " +
            "    D.CHAR_4,  " +
            "    D.CHAR_5,  " +
            "    D.REMARK " +
            " FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M " +
            " WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK " +
            " AND M.ID='EACAB012' " +
            " order by D.ORD ";
    DataTable dt1 = ESysLib.TableReadOpen(SQL);
    String e1 = "";
    String e2 = "";
    String e3 = "";
    String e4 = "";
    String e5 = "";
    String e6 = "";
    String v1 = "";
    String v2 = "";
    String v3 = "";
    String v4 = "";
    String v5 = "";
    String v6 = "";
    String g1 = "";
    String g2 = "";
    String g3 = "";
    String g4 = "";
    String g5 = "";
    String g6 = "";
    String n1 = "";
    String n2 = "";
    String n3 = "";
    String n4 = "";
    String n5 = "";
    String n6 = "";

    for (int k = 0; k < dt1.Rows.Count; k++)
    {

        string strTmp = dt1.Rows[k][0].ToString();
        if (strTmp == "ENG")
        {
            e1 = "" + dt1.Rows[k][1].ToString();
            e2 = "" + dt1.Rows[k][2].ToString();
            e3 = "" + dt1.Rows[k][3].ToString();
            e4 = "" + dt1.Rows[k][4].ToString();
            e5 = "" + dt1.Rows[k][5].ToString();
            e6 = "" + dt1.Rows[k][6].ToString();
        }

        if (strTmp == "VIE")
        {
            v1 = dt1.Rows[k][1].ToString();
            v2 = dt1.Rows[k][2].ToString();
            v3 = dt1.Rows[k][3].ToString();
            v4 = dt1.Rows[k][4].ToString();
            v5 = dt1.Rows[k][5].ToString();
            v6 = dt1.Rows[k][6].ToString();
        }
        if (strTmp == "SIG")
        {
            g1 = dt1.Rows[k][1].ToString();
            g2 = dt1.Rows[k][2].ToString();
            g3 = dt1.Rows[k][3].ToString();
            g4 = dt1.Rows[k][4].ToString();
            g5 = dt1.Rows[k][5].ToString();
            g6 = dt1.Rows[k][6].ToString();
        }

        if (strTmp == "NAM")
        {
            n1 = dt1.Rows[k][1].ToString();
            n2 = dt1.Rows[k][2].ToString();
            n3 = dt1.Rows[k][3].ToString();
            n4 = dt1.Rows[k][4].ToString();
            n5 = dt1.Rows[k][5].ToString();
            n6 = dt1.Rows[k][6].ToString();
        }
    }


 %>    
 
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl51 style='height:17.25pt'><%= v1 %></td>
  <td colspan=3 class=xl51><%= v2 %></td>
  <td colspan=4 class=xl51><%= v3 %></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl50 style='height:17.25pt'><%=g1 %></td>
  <td colspan=3 class=xl50><%=g2 %></td>
  <td colspan=4 class=xl50><%=g3 %></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=10 height=23 class=xl51 style='height:17.25pt'></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=10 height=23 class=xl51 style='height:17.25pt'></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=10 height=23 class=xl51 style='height:17.25pt'></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=10 height=23 class=xl51 style='height:17.25pt'></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=10 height=23 class=xl51 style='height:17.25pt'></td>
 </tr>    
   <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl51 style='height:17.25pt'><%= n1 %></td>
  <td colspan=3 class=xl51><%= n2 %></td>
  <td colspan=4 class=xl51><%= n3 %></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=271 style='width:203pt'></td>
  <td width=271 style='width:203pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=65 style='width:49pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
