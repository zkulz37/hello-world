<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company_pk = "" +Request["company_pk"];
	string l_account_pk = "" +Request["account_pk"];
	string l_date_from	= Request["dtbFrom"];
	string l_date_to = Request["dtbTo"];
	string l_ccy = Request["ccy"];
	string l_status = Request["status"];
	string l_book_ccy = Request["bookccy"];
    string l_rpt_Option = Request["rptOption"];
	string p_cmp_name = "";
	string p_cmp_add = "";	
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_acc_type = "";
	string p_dt_from ="";
	string p_dt_to ="";
	string p_dt_today = "";
	string p_status = "";
	string p_status_bal = "";
    string p_status_bal_trans = "";

	string p_open_bal_dr_xls = "0";
	string p_open_bal_cr_xls = "0";
	string p_close_bal_dr_xls = "0";
	string p_close_bal_cr_xls = "0";
	string p_debit_xls = "0";
	string p_credit_xls = "0";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
    string p_open_trans_bal = "";
    string p_close_trans_bal = "";
    string p_drcr = "";
	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
     
	if (l_status == "2")
    {
		p_status = "Confirmed";
		p_status_bal = "CFM Balance";
        p_status_bal_trans = "CFM Trans Balance";
    }
	else if (l_status == "0") 
    {
		p_status = "Approved";
		p_status_bal = "APP Balance";
        p_status_bal_trans = "APP Trans Balance";
    }
	else if (l_status == "4" )
    {
		p_status = "Not Approved";
		p_status_bal = "NAPP Balance";
        p_status_bal_trans = "NAPP Trans Balance";
    }

    string SQL = " SELECT partner_lname, addr2, tax_code  FROM tco_company WHERE pk = '" + l_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][2].ToString();
    }
      
	SQL = " SELECT AC_CD,AC_LNM, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date,INITCAP(To_char (sysdate, 'day, month dd  yyyy')), DECODE (drcr_type, 'D', 1, -1) , drcr_type  ";
	SQL += " FROM TAC_localCODE a WHERE a.pk = '" + l_account_pk + "' ";
    //Response.Write(SQL);
    //Response.End();
	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if(dt1.Rows.Count>0)
	{
		p_acc_code = dt1.Rows[0][0].ToString();
	    p_acc_name = dt1.Rows[0][1].ToString();
	    p_dt_from = dt1.Rows[0][2].ToString();
		p_dt_to = dt1.Rows[0][3].ToString();
		p_dt_today = dt1.Rows[0][4].ToString();
		p_acc_type = dt1.Rows[0][5].ToString();
        p_drcr = dt1.Rows[0][6].ToString();
	}

    SQL = "SELECT CCY,TO_CHAR (SUM(OPEN_BAL),Sf_Get_Format ('ACBG0040')) openingbalance,   " +
        "            TO_CHAR (SUM(DR_TRANS),'9,999,999,999,999,999,990.99') AS debittransamount, " +
        "            TO_CHAR (SUM(DR_BOOK), Sf_Get_Format ('ACBG0040')) AS debitbookamount,  " +
        "            TO_CHAR (SUM(CR_TRANS), '9,999,999,999,999,999,990.99') AS credittransamount, " +
        "            TO_CHAR (SUM(CR_BOOK), Sf_Get_Format ('ACBG0040')) AS creditbookamount, " +
        "            TO_CHAR ((SUM(OPEN_BAL) +(SUM(DR_BOOK) - SUM(CR_BOOK))*TO_NUMBER('" + p_acc_type + "')),Sf_Get_Format ('ACBG0040')) AS closingbalance, " +
        "            (SUM(OPEN_BAL) +(SUM(DR_BOOK) - SUM(CR_BOOK))*TO_NUMBER('" + p_acc_type + "'))  AS OB, " +
        "            TO_CHAR (SUM(OPEN_FBAL), '9,999,999,999,999,999,990.99') AS openingtransbalance, " +
        "            TO_CHAR ((SUM(OPEN_FBAL) +(SUM(DR_TRANS) - SUM(CR_TRANS))*TO_NUMBER('" + p_acc_type + "')), '9,999,999,999,999,999,990.99') AS closingtransbalance" +
        "          FROM " +
        "          ( " +
        "          SELECT M.TAC_localCODE_PK, M.CCY,   " +
        "            NVL((SUM(NVL(M.THIS_DRAMT,0)) - SUM(NVL(M.THIS_CRAMT,0))),0)*TO_NUMBER('" + p_acc_type + "') OPEN_BAL " + 
        "          , NVL((SUM(NVL(M.THIS_DRFAMT,0)) - SUM(NVL(M.THIS_CRFAMT,0))),0)*TO_NUMBER('" + p_acc_type + "') OPEN_FBAL, " +
        "            0 DR_TRANS, 0 CR_TRANS, 0 DR_BOOK, 0 CR_BOOK " +
        "                          FROM TAC_HGMMBAL_local M " +
        "                         WHERE del_if = 0 " +
        "                           AND tco_company_pk = " + l_company_pk +
        "                           AND tac_localcode_pk = " + l_account_pk +
        "                           AND tr_status = '" + l_status + "' " +
        "                           AND std_ym = SUBSTR (Sf_Get_Lastclosemm ('" + l_date_from + "'," + l_company_pk + "),1,6) " +
        "                           GROUP BY M.TAC_localCODE_PK,M.CCY " +
        "          UNION ALL " +
        "          SELECT D.TAC_localCODE_PK,D.CCY, " +
        "          NVL((SUM(NVL(D.YMD_DRBOOKS,0)) - SUM(NVL(D.YMD_CRBOOKS,0))),0)*TO_NUMBER('" + p_acc_type + "') OPEN_BAL " + 
        "         ,NVL((SUM(NVL(D.YMD_DRTRANS,0)) - SUM(NVL(D.YMD_CRTRANS,0))),0)*TO_NUMBER('" + p_acc_type + "') OPEN_FBAL, " +
        "           0 DR_TRANS, 0 CR_TRANS, 0 DR_BOOK, 0 CR_BOOK " +
        "                          FROM TAC_HGDDBAL_local D " +
        "                         WHERE del_if = 0 " +
        "                           AND tco_company_pk = " + l_company_pk +
        "                           AND tac_localcode_pk = " + l_account_pk +
        "                           AND tr_status = '" + l_status + "' " +
        "                           AND std_ymd " +
        "                                  BETWEEN TO_CHAR(ADD_MONTHS(TO_DATE (Sf_Get_Lastclosemm('" + l_date_from + "', " + l_company_pk + " ),'YYYYMMDD'),+1),'YYYYMMDD') " +
        "                                      AND TO_CHAR (  TO_DATE ('" + l_date_from + "','YYYYMMDD')- 1,'YYYYMMDD') " +
        "                          GROUP BY D.TAC_localCODE_PK,D.CCY " +
        "          UNION ALL " +
        "          SELECT D.TAC_localCODE_PK, D.CCY, 0 OPEN_BAL,0 OPEN_FBAL, " +
        "                SUM(NVL(D.YMD_DRTRANS,0)) DR_TRANS, SUM(NVL(D.YMD_CRTRANS,0)) CR_TRANS, SUM(NVL(D.YMD_DRBOOKS,0)) DR_BOOK, SUM(NVL(D.YMD_CRBOOKS,0)) CR_BOOK " +
        "                FROM TAC_HGDDBAL_local D " +
        "                         WHERE del_if = 0 " +
        "                           AND tco_company_pk = " + l_company_pk +
        "                           AND tac_localcode_pk = " + l_account_pk +
        "                           AND tr_status = '" + l_status + "' " +
        "                           AND (std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "')    " +
        "                         GROUP BY D.TAC_localCODE_PK,D.CCY            " +
        "          )  " +
        "          WHERE UPPER (CCY) LIKE DECODE('" + l_ccy + "','ALL','%%','" + l_ccy + "') " +
        "      GROUP BY CCY ";
    //Response.Write(SQL);
    //Response.End();
	DataTable dt_total = ESysLib.TableReadOpen(SQL);
	if (dt_total.Rows.Count >0)
	{
		p_open_bal = dt_total.Rows[0][1].ToString();
        p_open_trans_bal = dt_total.Rows[0][8].ToString();
	}

    //Response.Write(l_rpt_Option);
    //Response.End();
	  if (l_rpt_Option == "DRCR")
    {
	SQL = " select h.pk, h.VOUCHERNO, to_char(h.tr_date,'DD/MM/YYYY') date1 ";
SQL += " , A.USER_ID  ";
SQL += ",d.ccy ";
SQL += ", TO_NUMBER('" +p_open_bal + "','9,999,999,999,999,990.99') open_bal ";
SQL += ",DECODE(D.DRCR_TYPE,'D',D.TR_AMT,0)  ";
SQL += ",DECODE(D.DRCR_TYPE,'D',D.TR_BOOKAMT,0) ";
SQL += ",DECODE(D.DRCR_TYPE,'C',D.TR_AMT,0)  ";
SQL += ",DECODE(D.DRCR_TYPE,'C',D.TR_BOOKAMT,0) ";
SQL += ", TO_CHAR(TO_NUMBER ('" + p_open_bal + "','9,999,999,999,999,990.99') + SUM (  NVL (d.tr_bookamt, 0) * DECODE (d.drcr_type, 'D', 1, -1) *to_number('" + p_acc_type + "')) OVER (ORDER BY h.tr_date,DECODE(d.drcr_type,'" + p_drcr + "',1,2), h.VOUCHERNO, h.PK,d.pk), sf_get_format ('ACBG0040')) AS closingbalance ";
SQL += ",D.BUSPARTNER_LNM ";
SQL += ",D.REMARK ";
SQL += ",D.REMARK2 ";
SQL += ", DECODE(D.TAC_ABPLCENTER_PK,'','',SF_GET_PL_FROM_PLCENTER(D.TAC_ABPLCENTER_PK)) ";
SQL += ",SF_A_GET_AGTRITEM(D.PK),  h.TR_ENCLOSE  ";
SQL += ", TO_NUMBER('" + p_open_trans_bal + "','9,999,999,999,999,990.99') open_trans_bal ";
SQL += ", TO_CHAR(TO_NUMBER ('" + p_open_trans_bal + "','9,999,999,999,999,990.99') + SUM (  NVL (d.TR_AMT, 0) * DECODE (d.drcr_type, 'D', 1, -1) *to_number('" + p_acc_type + "')) OVER (ORDER BY h.tr_date, DECODE(d.drcr_type,'" + p_drcr + "',1,2),  h.VOUCHERNO, h.PK,d.pk), '9,999,999,999,999,990.99') AS closingtransBAL "; 
SQL += "from tac_hgtrh h, tac_hgtrd d, vco_bsuser a ";
SQL += "where h.del_if =0 and d.del_if =0 ";
SQL += "           AND A.PK(+) = h.TCO_BSUSER_PK ";
SQL += "and h.pk= d.tac_hgtrh_pk ";
SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
SQL += "     AND d.TAC_ABACCTCODE_PK IN (  select pk from tac_abacctcode where del_if =0 and  USE_YN ='Y' and TAC_LOCALCODE_PK in     (SELECT hg.TAC_localCODE_PK  FROM TAC_HGDDBAL_local hg WHERE hg.DEL_IF =0 AND hg.tco_company_pk =  '"+ l_company_pk +"'  AND hg.tac_localcode_pk in ( SELECT pk ";
SQL += "                                       FROM tac_localcode ";
SQL += "                                      WHERE del_if = 0 AND leaf_yn = 'Y' ";
SQL += "                                 CONNECT BY pac_pk = PRIOR pk ";
SQL += "                                 START WITH pk = " + l_account_pk + "))) ";
SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' ";
SQL += "     ORDER BY h.tr_date,DECODE(d.drcr_type,'" + p_drcr + "',1,2), h.VOUCHERNO, h.PK,d.pk";
}
    else if (l_rpt_Option == "FIFO")
    {
        SQL = " select h.pk, h.VOUCHERNO, to_char(h.tr_date,'DD/MM/YYYY') date1 ";
        SQL += " , A.USER_ID  ";
        SQL += ",d.ccy ";
        SQL += ", TO_NUMBER('" + p_open_bal + "','9,999,999,999,999,990.99') open_bal ";
        SQL += ",DECODE(D.DRCR_TYPE,'D',D.TR_AMT,0)  ";
        SQL += ",DECODE(D.DRCR_TYPE,'D',D.TR_BOOKAMT,0) ";
        SQL += ",DECODE(D.DRCR_TYPE,'C',D.TR_AMT,0)  ";
        SQL += ",DECODE(D.DRCR_TYPE,'C',D.TR_BOOKAMT,0) ";
        SQL += ", TO_CHAR(TO_NUMBER ('" + p_open_bal + "','9,999,999,999,999,990.99') + SUM (  NVL (d.tr_bookamt, 0) * DECODE (d.drcr_type, 'D', 1, -1) *to_number('" + p_acc_type + "')) OVER (ORDER BY h.tr_date,  h.PK,d.pk), sf_get_format ('ACBG0040')) AS closingbalance ";
        SQL += ",D.BUSPARTNER_LNM ";
        SQL += ",D.REMARK ";
        SQL += ",D.REMARK2 ";
        SQL += ", DECODE(D.TAC_ABPLCENTER_PK,'','',SF_GET_PL_FROM_PLCENTER(D.TAC_ABPLCENTER_PK)) ";
        SQL += ",SF_A_GET_AGTRITEM(D.PK),  h.TR_ENCLOSE  ";
        SQL += ", TO_NUMBER('" + p_open_trans_bal + "','9,999,999,999,999,990.99') open_trans_bal ";
        SQL += ", TO_CHAR(TO_NUMBER ('" + p_open_trans_bal + "','9,999,999,999,999,990.99') + SUM (  NVL (d.TR_AMT, 0) * DECODE (d.drcr_type, 'D', 1, -1) *to_number('" + p_acc_type + "')) OVER (ORDER BY h.tr_date, DECODE(d.drcr_type,'" + p_drcr + "',1,2),  h.VOUCHERNO, h.PK,d.pk), '9,999,999,999,999,990.99') AS closingtransBAL ";
        SQL += "from tac_hgtrh h, tac_hgtrd d, vco_bsuser a ";
        SQL += "where h.del_if =0 and d.del_if =0 ";
        SQL += "           AND A.PK(+) = h.TCO_BSUSER_PK ";
        SQL += "and h.pk= d.tac_hgtrh_pk ";
        SQL += "     AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
        SQL += "     AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
        SQL += "     AND d.TAC_ABACCTCODE_PK IN (  select pk from tac_abacctcode where del_if =0 and  USE_YN ='Y' and TAC_LOCALCODE_PK in     (SELECT hg.TAC_localCODE_PK  FROM TAC_HGDDBAL_local hg WHERE hg.DEL_IF =0 AND hg.tco_company_pk =  '"+ l_company_pk +"'  AND hg.tac_localcode_pk in ( SELECT pk ";
SQL += "                                       FROM tac_localcode ";
SQL += "                                      WHERE del_if = 0 AND leaf_yn = 'Y' ";
SQL += "                                 CONNECT BY pac_pk = PRIOR pk ";
SQL += "                                 START WITH pk = " + l_account_pk + "))) ";
        SQL += "     AND h.tco_company_pk = '" + l_company_pk + "' ";
        SQL += "     ORDER BY h.tr_date,  h.PK,d.pk"; 
    }
    //Response.Write(SQL);
    //Response.End();
	%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00020_DailySL_1_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00020_DailySL_1_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00020_DailySL_1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>comp</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2009-01-06T06:41:53Z</o:LastPrinted>
  <o:Created>2005-01-28T07:20:51Z</o:Created>
  <o:LastSaved>2009-01-06T06:42:17Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .25in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font7
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:black;
	font-size:11.0pt;
	font-weight:400;
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
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl48
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
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
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
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>SL Daily</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>50</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>95</x:Zoom>
     <x:Selected/>
     <x:LeftColumnVisible>1</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='SL Daily'!$6:$7</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1967 style='border-collapse:
 collapse;table-layout:fixed;width:1477pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=68 span=2 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=89 span=8 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl24 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl24 width=240 style='mso-width-source:userset;mso-width-alt:8777;
 width:180pt'>
 <col class=xl24 width=187 style='mso-width-source:userset;mso-width-alt:6838;
 width:140pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col class=xl24 width=127 style='mso-width-source:userset;mso-width-alt:4644;
 width:95pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 colspan=4 width=272 style='height:15.0pt;mso-ignore:
  colspan;width:204pt'><%= p_cmp_name %></td>
  <td class=xl25 width=40 style='width:30pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl25 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=180 style='width:135pt'></td>
  <td class=xl24 width=240 style='width:180pt'></td>
  <td class=xl24 width=187 style='width:140pt'></td>
  <td class=xl24 width=78 style='width:59pt'></td>
  <td class=xl24 width=131 style='width:98pt'></td>
  <td class=xl24 width=127 style='width:95pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 colspan=3 style='height:15.0pt;mso-ignore:colspan'>as
  at <%= p_dt_today %></td>
  <td colspan=8 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl27 colspan=6 style='mso-ignore:colspan'>Account Code:<font
  class="font9"> <%= p_acc_code %>&nbsp;&nbsp; <%= p_acc_name %></font></td>
  <td class=xl27></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl29 colspan=3 style='mso-ignore:colspan'>Date:<font class="font9">
  <%= p_dt_from %> ~ <%= p_dt_to %></font></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl28 colspan=2 style='mso-ignore:colspan'>Status:<font class="font7">
  Confirmed</font></td>
  <td class=xl28></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=19 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl46 style='border-bottom:.5pt solid black;
  height:30.0pt'>Seq</td>
  <td rowspan=2 class=xl48 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Voucher<br>
    No</td>
  <td rowspan=2 class=xl48 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Trans Date</td>
  <td rowspan=2 class=xl48 width=75 style='border-bottom:.5pt solid black;
  width:56pt'>Proposed<br>
    By</td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black'>Ccy</td>
  <td rowspan=2 class=xl48 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Openning Trans Balance</td>
  <td rowspan=2 class=xl48 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Openning Book Balance</td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Debit</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>Credit</td>
  <td rowspan=2 class=xl48 width=89 style='border-bottom:.5pt solid black;
  width:67pt'><%= p_status_bal_trans %></td>
  <td rowspan=2 class=xl48 width=89 style='border-bottom:.5pt solid black;
  width:67pt'><%= p_status_bal %></td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black'>Customer</td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black'>PL</td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black'>Item Control</td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black'>Enclose</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'>Transaction</td>
  <td class=xl31>Book</td>
  <td class=xl31>Transaction</td>
  <td class=xl31>Book</td>
  <td class=xl31>Foreign</td>
  <td class=xl31>Local</td>
 </tr>
  <%		
	int i = 0;

    //Response.Write(SQL);
    //Response.End();  
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	
	if (dt_detail.Rows.Count >0)
	{
		for(i=0;i<dt_detail.Rows.Count;i++)
		{
	%> 
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl32 style='height:20.1pt' x:num><%= dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl33><%= dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl33><%= dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl34><%= dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl33><%= dt_detail.Rows[i][4].ToString()%></td>
   <% if( i ==0) { %>
  <td class=xl35  x:num  style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%=dt_detail.Rows[i][17].ToString() %></td>
  <td class=xl35  x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';"><%=dt_detail.Rows[i][5].ToString() %></td>
  <% } else { %>
  <td class=xl35  x:num  style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_detail.Rows[i-1][18].ToString()%></td>
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_detail.Rows[i-1][10].ToString()%></td>
  <% } %>
    <% if (dt_detail.Rows[i][4].ToString() =="VND") { %>  
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_detail.Rows[i][8].ToString()%></td>
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_detail.Rows[i][9].ToString()%></td>
   <%
  }
  else
  {
  %>
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_detail.Rows[i][8].ToString()%></td>
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_detail.Rows[i][9].ToString()%></td>
     <%
  }
  %>
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_detail.Rows[i][18].ToString()%></td>
  <td class=xl35 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_detail.Rows[i][10].ToString()%></td>
  
  <td class=xl36><%= dt_detail.Rows[i][11].ToString()%></td>
  <td class=xl34><%= dt_detail.Rows[i][12].ToString()%></td>
  <td class=xl34><%= dt_detail.Rows[i][13].ToString()%></td>
  <td class=xl34><%= dt_detail.Rows[i][14].ToString()%></td>
  <td class=xl34><%= dt_detail.Rows[i][15].ToString()%></td>
  <td class=xl37><%= dt_detail.Rows[i][16].ToString()%></td>
 </tr>
   <%
		}
	}
	
%> 
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=15 class=xl38 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 rowspan=2 height=40 class=xl54 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:30.0pt'>Total</td>
  <td rowspan=2 class=xl46 style='border-bottom:.5pt solid black'>Ccy</td>
  <td rowspan=2 class=xl48 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Openning Trans Balance</td>
  <td rowspan=2 class=xl48 width=89 style='border-bottom:.5pt solid black;
  width:67pt'>Openning Book Balance</td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black;border-left:
  none'>Debit</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none'>Credit</td>
  <td rowspan=2 class=xl48 width=89 style='border-bottom:.5pt solid black;
  width:67pt'><%= p_status_bal_trans %></td>
  <td rowspan=2 class=xl48 width=89 style='border-bottom:.5pt solid black;
  width:67pt'><%= p_status_bal %></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'>Transaction</td>
  <td class=xl31>Book</td>
  <td class=xl31>Transaction</td>
  <td class=xl31>Book</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
<%
if (dt_total.Rows.Count > 0)
{
	for(int j =0;j<dt_total.Rows.Count;j++)
	{
		if (j==0)
		{
%>   
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl39 style='height:20.1pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42><%= dt_total.Rows[j][0].ToString() %></td>
  <td class=xl35  x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_total.Rows[j][8].ToString()   %></td>
  <td rowspan=2 class=xl60 rowspan="<%= dt_total.Rows.Count %>" x:num style="mso-number-format:'<%= p_xls_ccy_format %>';border-bottom:.5pt solid windowtext;" ><%= dt_total.Rows[j][1].ToString()   %></td>
   <% if (  dt_total.Rows[j][0].ToString() =="VND") { %>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_total.Rows[j][2].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dt_total.Rows[j][3].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dt_total.Rows[j][4].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dt_total.Rows[j][5].ToString()   %></td>
   <% }else{ %>
   <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_total.Rows[j][2].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dt_total.Rows[j][3].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';" ><%= dt_total.Rows[j][4].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dt_total.Rows[j][5].ToString()   %></td>
   <% } %>  
  <td class=xl35  x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_total.Rows[j][9].ToString()   %></td>
  <td class=xl60 rowspan="<%= dt_total.Rows.Count %>" x:num style="mso-number-format:'<%= p_xls_ccy_format %>';border-bottom:.5pt solid windowtext;" ><%= dt_total.Rows[j][6].ToString()   %></td>
  <td class=xl44></td>
  <td class=xl45></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <% 
		}
		else
		{
%>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl39 style='height:20.1pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42><%= dt_total.Rows[j][0].ToString() %></td>
  <td class=xl35  x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_total.Rows[j][8].ToString()   %></td>
     <% if (  dt_total.Rows[j][0].ToString() =="VND") { %>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= dt_total.Rows[j][2].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dt_total.Rows[j][3].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dt_total.Rows[j][4].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dt_total.Rows[j][5].ToString()   %></td>
     <% }else{ %>
     <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_total.Rows[j][2].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dt_total.Rows[j][3].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';" ><%= dt_total.Rows[j][4].ToString()   %></td>
  <td class=xl43 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%= dt_total.Rows[j][5].ToString()   %></td>
     
       <% } %>  
  <td class=xl35  x:num style="mso-number-format:'<%= p_xls_ccy_format_usd %>';"><%= dt_total.Rows[j][9].ToString()   %></td>
  <td class=xl44></td>
  <td class=xl45></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
<%
			}
		}
	} 
%> 
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=61 style='width:46pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=240 style='width:180pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=127 style='width:95pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
