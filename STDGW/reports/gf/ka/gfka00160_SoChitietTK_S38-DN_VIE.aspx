<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string com_pk = "" + Request["company_pk"];
    string ac_pk = "" + Request["account_pk"];
    string cust_pk = "" + Request["cust_pk"];
    string d_from = "" + Request["dtbFrom"];
    string d_to = "" + Request["dtbTo"];
    string ccy = "" + Request["bookccy"];
    string p_book_ccy = ccy; 
    string status = "" + Request["status"];
    string from_date = d_from.Substring(6, 2) + "/" + d_from.Substring(4, 2) + "/" + d_from.Substring(0, 4);
    string to_date = d_to.Substring(6, 2) + "/" + d_to.Substring(4, 2) + "/" + d_to.Substring(0, 4);
    string name = "";
    string lname = "";
    string address = "";
    string tax_code = "";
    string ac_cd = "";
    string ac_nm = "";
    string drcr_type = "";
    string seq = "";
    string tr_date = "";
    string voucher = "";
    string acc_cor = "";
    string remark = "";
    string remark2 = "";
    
    double dr_openning = 0;
    double cr_openning = 0;
    double dr_closing = 0;
    double cr_closing = 0;
    double dr_amt = 0;
    double cr_amt = 0;
    double dr_sum = 0;
    double cr_sum = 0;
    double dr_end = 0;
    double cr_end = 0;


    string SQL = " SELECT pk, partner_name, partner_lname, addr2 address, tax_code ";
    SQL += "  FROM tco_company ";
    SQL += " WHERE del_if = 0 AND pk = '" + com_pk + "'";
    DataTable dtCom = ESysLib.TableReadOpen(SQL);
    if (dtCom.Rows.Count > 0)
    {
        name = dtCom.Rows[0][1].ToString();
        lname = dtCom.Rows[0][2].ToString();
        address = dtCom.Rows[0][3].ToString();
        tax_code = dtCom.Rows[0][4].ToString();
    }
    
    string SQLAC = "SELECT pk, ac_cd, ac_lnm, UPPER(drcr_type)  FROM tac_abacctcode ";
    SQLAC += " WHERE del_if = 0 and tco_company_pk ='" + com_pk + "' and pk ='" + ac_pk + "'";

    DataTable dtAcc = ESysLib.TableReadOpen(SQLAC);
    if (dtAcc.Rows.Count > 0)
    {
        ac_cd = dtAcc.Rows[0][1].ToString();
        ac_nm = dtAcc.Rows[0][2].ToString();
        drcr_type = dtAcc.Rows[0][3].ToString();
    }
    /*
    string SQLB   = " select nvl(a.tac_abacctcode_pk, b.tac_abacctcode_pk) tac_abacctcode_pk ";
            SQLB += "       ,nvl(openning,0) + nvl(ymd_drbooks,0) - nvl(ymd_crbooks,0)  ";
            SQLB += "       ,nvl(openning,0) - nvl(ymd_drbooks,0) + nvl(ymd_crbooks,0)  ";
            SQLB += "  from ";
            SQLB += "      ( ";
            SQLB += "        select TAC_ABACCTCODE_PK, SUM(YMD_DRBOOKS) YMD_DRBOOKS, SUM(YMD_CRBOOKS) YMD_CRBOOKS ";
            SQLB += "          from tac_hgddbal ";
            SQLB += "         where del_if = 0 ";
            SQLB += "           and TCO_COMPANY_PK = '" + com_pk + "' ";
            SQLB += "           and TAC_ABACCTCODE_PK = '" + ac_pk + "' ";
           // SQLB += "           and CCY = '" + ccy + "'";
            SQLB += "           and STD_YMD > ac_get_lastclosemm ('" + d_from + "', '" + com_pk + "') ";
            SQLB += "           and STD_YMD < '" + d_from + "' ";
            SQLB += "           and tr_status IN (DECODE ('" + status + "', '0', '0', DECODE ('" + status + "', '2', '0', '')), ";
            SQLB += "                             DECODE ('" + status + "', '2', '2', ''), ";
            SQLB += "                             DECODE ('" + status + "', '2', '4', DECODE ('" + status + "', '4', '4', '')) ";
            SQLB += "                            ) ";
            SQLB += "         group by TAC_ABACCTCODE_PK) a ";
            SQLB += " full outer join ";
            SQLB += "       ( ";
            SQLB += "        select TAC_ABACCTCODE_PK, NVL(THIS_DRBAL,0)+NVL(THIS_CRBAL,0) OPENNING ";
            SQLB += "          from tac_hgmmbal ";
            SQLB += "         where del_if = 0 ";
            SQLB += "           and TCO_COMPANY_PK = '" + com_pk + "' ";
            SQLB += "           and TAC_ABACCTCODE_PK = '" + ac_pk + "' ";
            //SQLB += "           and CCY = 'VND' ";
            SQLB += "           and STD_YM = substr(ac_get_lastclosemm ('" + d_from + "', '" + com_pk + "'),1,6) ";
            SQLB += "           and tr_status IN (DECODE ('" + status + "', '0', '0', DECODE ('" + status + "', '2', '0', '')), ";
            SQLB += "                             DECODE ('" + status + "', '2', '2', ''), ";
            SQLB += "                             DECODE ('" + status + "', '2', '4', DECODE ('" + status + "', '4', '4', '')) ";
            SQLB += "                            )) b ";
            SQLB += " on (a.tac_abacctcode_pk = b.tac_abacctcode_pk) ";
            */
    string SQLB = " SELECT ac_get_DRCR_OPENBAL('" + com_pk + "','" + ac_pk + "','','" + d_from + "','" + status + "','D','BOOK') DR_BOOK, ac_get_DRCR_OPENBAL('" + com_pk + "','" + ac_pk + "','','" + d_from + "','" + status + "','C','BOOK') CR_BOOK FROM DUAL ";
     
            DataTable dtB = ESysLib.TableReadOpen(SQLB);
            if (dtB.Rows.Count > 0)
            {
                if (drcr_type == "D")
                {
                    dr_openning = double.Parse(dtB.Rows[0][0].ToString()) - double.Parse(dtB.Rows[0][1].ToString());
                    cr_openning = 0;
                }
                else 
                {
                    dr_openning = 0;
                    cr_openning = double.Parse(dtB.Rows[0][1].ToString()) - double.Parse(dtB.Rows[0][0].ToString());
                    
                }
            }

            /*
            string SQLD = " select h.pk, to_char(h.TR_DATE,'YYYYMMDD') TR_DATE, h.voucherno, ";
                    SQLD += "       a.ac_cd, b.PARTNER_ID, b.PARTNER_NAME, ";
                    SQLD += "       decode(r.drcr_type,'C',TR_BOOKAMT,0) Debit, ";
                    SQLD += "       decode(r.drcr_type,'D',TR_BOOKAMT,0) Credit, ";
                    SQLD += "       h.remark, h.remark2 ";
                    SQLD += "  from tac_hgtrh h, tac_hgtrd_ref r, tco_buspartner b,  ";
                    SQLD += "       tac_abacctcode a ";
                    SQLD += " where h.del_if = 0 and r.del_if = 0 and b.del_if(+) = 0 ";
                    SQLD += "   and a.del_if = 0  ";
                    SQLD += "   and r.tac_hgtrh_pk = h.pk ";
                    SQLD += "   and r.tco_buspartner_pk = b.pk(+) ";
                    SQLD += "   and r.TAC_ABACCTCODE_PK_DR = a.PK ";
                    SQLD += "   and h.tco_company_pk = '" + com_pk + "' ";
                    SQLD += "   and to_char(h.tr_date,'YYYYMMDD') between '" + d_from + "' and '" + d_to + "'  ";
                    SQLD += "   and (r.TAC_ABACCTCODE_PK_CR = '" + ac_pk + "') ";
                    SQLD += "   and h.tr_status in   (decode ('" + status + "', '0', '0', decode ('" + status + "', '2', '0', '')), ";
                    SQLD += "                         decode ('" + status + "', '2', '2', ''), ";
                    SQLD += "                         decode ('" + status + "', '2', '4', decode ('" + status + "', '4', '4', '')) ";
                    SQLD += "                        ) ";
                    SQLD += " order by h.tr_date ";
            */
 
            string SQLD
            = "SELECT TO_CHAR(H.TR_DATE,'DD/MM/YYYY') TRANS_DATE, H.VOUCHERNO, " +
                "H.REMARK, H.REMARK2,SF_A_GET_ACCD(DECODE(D.DRCR_TYPE,'D',DECODE(R.DRCR_TYPE,'C',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR), " +
                "DECODE(R.DRCR_TYPE,'D',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR)),'" + com_pk +"') ACCT_CODE, " +
                "DECODE(D.DRCR_TYPE,'D',R.TR_BOOKAMT,0) PS_DEBIT, DECODE(D.DRCR_TYPE,'C',R.TR_BOOKAMT,0) PS_CREDIT, " +
                "(TO_NUMBER('" + dr_openning + "') + SUM(DECODE(D.DRCR_TYPE,'D',R.TR_BOOKAMT,0)) OVER (ORDER BY H.TR_DATE,H.VOUCHERNO,H.PK,D.PK,R.PK)) TOTAL_DEBIT, " +
                "(TO_NUMBER('" + cr_openning + "') + SUM(DECODE(D.DRCR_TYPE,'C',R.TR_BOOKAMT,0)) OVER (ORDER BY H.TR_DATE,H.VOUCHERNO,H.PK,D.PK,R.PK)) TOTAL_CREDIT, " +
                " H.PK " +
                " FROM TAC_HGTRH H, TAC_HGTRD D, TAC_HGTRD_REF R " +
                " WHERE H.DEL_IF =0 AND D.DEL_IF =0 AND R.DEL_IF = 0 " +
                " AND H.PK = D.TAC_HGTRH_PK " +
                " AND H.PK = R.TAC_HGTRH_PK " +
                " AND D.PK = R.TAC_HGTRD_PK " +
                " AND D.TAC_ABACCTCODE_PK IN (SELECT pk FROM tac_abacctcode  WHERE del_if = 0 AND leaf_yn = 'Y'  CONNECT BY pac_pk = PRIOR pk START WITH pk = " + ac_pk + ")  " +
                " AND H.TCO_COMPANY_PK like  DECODE ('" + com_pk + "', 0, '%%', '" + com_pk + "')" +
                " AND H.TR_DATE BETWEEN TO_DATE('" + d_from + "','YYYYMMDD') AND TO_DATE('" + d_to + "','YYYYMMDD')  " +
                " AND H.TR_STATUS IN ('" + status + "',DECODE('" + status + "',2,0,'" + status + "'),DECODE('" + status + "',2,4,'" + status + "')) " +
                " ORDER BY H.TR_DATE,H.VOUCHERNO,H.PK,D.PK,R.PK ";

            //Response.Write(SQLD);
            //Response.End();
            DataTable dt = ESysLib.TableReadOpen(SQLD);

            String p_xls_ccy_format = "";

            if (p_book_ccy == "VND")
            {
                p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
            }
            else
            {
                p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
            } 
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00160_SoChitietTK_S38-DN_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00160_SoChitietTK_S38-DN_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00160_SoChitietTK_S38-DN_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Acc</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-09-04T03:05:10Z</o:LastPrinted>
  <o:Created>2008-01-29T03:54:09Z</o:Created>
  <o:LastSaved>2008-09-06T06:09:04Z</o:LastSaved>
  <o:Company>Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .75in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.5in;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
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
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
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
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
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
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
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
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
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
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
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
.xl62
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
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
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
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
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
.xl74
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
.xl75
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
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl80
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl81
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
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl83
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
.xl84
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>S&#7893; chi ti&#7871;t TK</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>402</x:DefaultRowHeight>
     <x:Unsynced/>
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
     <x:SplitHorizontal>11</x:SplitHorizontal>
     <x:TopRowBottomPane>11</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>3</x:LeftColumnRightPane>
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
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; chi ti&#7871;t TK'!$A$11:$J$11</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1374 style='border-collapse:
 collapse;table-layout:fixed;width:1029pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=271 span=1 style='mso-width-source:userset;mso-width-alt:
 9910;width:203pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=107 span=2 style='mso-width-source:userset;mso-width-alt:
 3913;width:80pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=5 height=20 class=xl76 width=885 style='height:15.0pt;width:663pt'><%=lname%></td>
  <td colspan=4 class=xl79 width=426 style='width:319pt'>M&#7851;u s&#7889;
  S38-DN</td>
  <td class=xl24 width=63 style='width:47pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=5 height=20 class=xl76 style='height:15.0pt'><%=address %></td>
  <td colspan=4 class=xl78
  x:str="                 (Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày "><span
  style='mso-spacerun:yes'>                 </span>(Ban hành theo Quy&#7871;t
  &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=5 height=20 class=xl76 style='height:15.0pt'>TAX CODE: <%=tax_code %></td>
  <td colspan=4 class=xl78>&nbsp;&nbsp;&nbsp;<span
  style='mso-spacerun:yes'>            </span>20 tháng 03 n&#259;m 2006
  c&#7911;a B&#7897; tr&#432;&#7901;ng B&#7897; Tài chính)</td>
  <td class=xl24></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td colspan=9 height=35 class=xl77 style='height:26.25pt'>S&#7892; CHI
  TI&#7870;T TÀI KHO&#7842;N</td>
  <td class=xl24></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=9 height=27 class=xl80 style='height:20.25pt'>T&#7915; ngày
  <%=from_date%> &#272;&#7871;n ngày <%=to_date%></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl25 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl26 style='height:18.75pt'>Tài kho&#7843;n:</td>
  <td class=xl27><%=ac_cd %></td>
  <td colspan=2 class=xl55>Tên tài kho&#7843;n:</td>
  <td colspan=5 class=xl27><%=ac_nm %></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 class=xl26 style='height:15.75pt'>&#272;&#7889;i
  t&#432;&#7907;ng:</td>
  <td colspan=2 class=xl26></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl55>&#272;&#417;n v&#7883; tính:</td>
  <td class=xl56><%= p_book_ccy %></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl25 height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl28 style='height:6.0pt'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td rowspan=2 height=42 class=xl74 width=83 style='border-bottom:.5pt solid black;
  height:31.5pt;border-top:none;width:62pt'>Ngày tháng ghi s&#7893;</td>
  <td colspan=2 class=xl81 width=185 style='border-right:.5pt solid black;
  border-left:none;width:139pt'>Ch&#7913;ng t&#7915;</td>
  <td rowspan=2 class=xl74 width=271 style='border-bottom:.5pt solid black;
  border-top:none;width:203pt'>Di&#7877;n gi&#7843;i</td>
 
  <td rowspan=2 class=xl74 width=75 style='border-bottom:.5pt solid black;
  border-top:none;width:56pt'>TK &#273;&#7889;i &#7913;ng</td>
  <td colspan=2 class=xl81 width=214 style='border-right:.5pt solid black;
  border-left:none;width:160pt'>S&#7889; phát sinh</td>
  <td colspan=2 class=xl83 width=212 style='border-right:.5pt solid black;
  border-left:none;width:159pt'>S&#7889; d&#432;</td>
  <td class=xl49>Ghi Chú</td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 class=xl34 width=96 style='height:15.75pt;width:72pt'>S&#7889;
  hi&#7879;u</td>
  <td class=xl34 width=89 style='width:67pt'>Ngày, tháng</td>
  <td class=xl34 width=107 style='width:80pt'>N&#7907;</td>
  <td class=xl34 width=107 style='width:80pt'>Có</td>
  <td class=xl34 width=105 style='width:79pt'>N&#7907;</td>
  <td class=xl34 width=107 style='width:80pt'>Có</td>
  <td class=xl30>SEQ</td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl29 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$11:$J$11" style='height:20.1pt'>A</td>
  <td class=xl30 id="_x0000_s1026" x:autofilter="all">B</td>
  <td class=xl30 id="_x0000_s1027" x:autofilter="all">C</td>
  <td class=xl30 id="_x0000_s1028" x:autofilter="all">D</td>
  
  <td class=xl30 id="_x0000_s1030" x:autofilter="all">E</td>
  <td class=xl30 id="_x0000_s1031" x:autofilter="all" x:num>1</td>
  <td class=xl30 id="_x0000_s1032" x:autofilter="all" x:num>2</td>
  <td class=xl30 id="_x0000_s1033" x:autofilter="all" x:num>3</td>
  <td class=xl30 id="_x0000_s1034" x:autofilter="all" x:num>4</td>
  <td class=xl50 style='border-top:none;border-left:none'>G</td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl35 style='height:20.1pt'>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl61 width=271 style='width:203pt'>S&#7888; D&#431; &#272;&#7846;U
  K&#7922;</td>
  
  <td class=xl57>&nbsp;</td>
  <td class=xl31 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%=dr_openning %></td>
  <td class=xl31 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%=cr_openning %></td>
  <td class=xl31 x:str=" "><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl31 x:str=" "><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl58 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <%
     string strdate0 = "";
     string strdate1 = "";
     if (dt.Rows.Count > 0)
     {
         dr_end = dr_openning;
         cr_end = cr_openning;
         dr_sum = 0;
         cr_sum = 0;
         dr_closing = 0;
         cr_closing = 0;
         
         for (int i = 0; i < dt.Rows.Count; i++)
         {
             seq = dt.Rows[i][9].ToString();
             tr_date = dt.Rows[i][0].ToString();
             //tr_date = tr_date.Substring(6, 2) + "/" + tr_date.Substring(4, 2) + "/" + tr_date.Substring(0, 4);
             voucher = dt.Rows[i][1].ToString();
             acc_cor = dt.Rows[i][4].ToString();
             dr_amt = double.Parse(dt.Rows[i][5].ToString());
             cr_amt = double.Parse(dt.Rows[i][6].ToString());
             remark = dt.Rows[i][2].ToString();
             remark2 = dt.Rows[i][3].ToString();
             dr_sum += dr_amt;
             cr_sum += cr_amt;
             dr_end += dr_amt;
             cr_end += cr_amt;
             if (strdate0 != tr_date)
             {
                 strdate0 = tr_date;
                 strdate1 = tr_date;
             }
             else
             {
                 strdate1 = ""; 
             }     
 %>
 <tr class=xl25 height=26 style='mso-height-source:auto;'>
  <td height=26 class=xl39 style='border-top:none'><%=strdate1%></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=voucher%></td>
  <td class=xl40 style='border-top:none;border-left:none'><%=tr_date%></td>
  <td class=xl41 width=271 style='border-left:none;width:203pt'><%=remark2%></td>
  
  <td class=xl59 x:num><%=acc_cor%></td>
  <td class=xl32 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%=dr_amt %></td>
  <td class=xl32 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%=cr_amt %></td>
  <td class=xl32 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%=dr_end %></td>
  <td class=xl32 x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%=cr_end %></td>
  <td class=xl51 style='border-left:none'>&nbsp;<%=seq %></td>
 </tr>
 <%
         }
       
     }
     if (drcr_type == "D")
     {
         dr_closing = dr_openning + dr_sum - cr_sum;
         cr_closing = 0;
     }
     else
     {
         dr_closing = 0;
         cr_closing = cr_openning - dr_sum + cr_sum;
     }
 %>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl63 style='height:20.1pt'>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl68 width=271 style='border-top:none;border-left:none;width:203pt'>T&#7893;ng
  c&#7897;ng s&#7889; phát sinh</td>
  
  <td class=xl40 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl69 style='border-top:none;border-left:none' x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%=dr_sum %></td>
  <td class=xl69 style='border-top:none;border-left:none' x:num  style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%=cr_sum %></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl52 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl37 style='height:20.1pt;border-top:.5pt hairline windowtext;'>&nbsp;</td>
  <td class=xl38 style="border-top:.5pt hairline windowtext;">&nbsp;</td>
  <td class=xl38  style="border-top:.5pt hairline windowtext;">&nbsp;</td>
  <td class=xl62 width=271 style='border-top:none;border-left:none;width:203pt'>S&#7888;
  D&#431; CU&#7888;I K&#7922;</td>
  
  <td class=xl60>&nbsp;</td>
  <td class=xl33 x:num   style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%=dr_closing %></td>
  <td class=xl33 x:num   style="mso-number-format:'<%= p_xls_ccy_format %>';" ><%=cr_closing %></td>
  <td class=xl33  style="border-top:.5pt hairline windowtext;" ></td>
  <td class=xl33  style="border-top:.5pt hairline windowtext;"></td>
  <td class=xl54 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=10 class=xl25 style='height:20.1pt;mso-ignore:colspan'></td>
  <td class=xl42></td>
 </tr>
 <tr class=xl43 height=21 style='height:15.75pt'>
  <td colspan=8 height=21 class=xl71 style='height:15.75pt'>S&#7893; có…. Trang
  , &#273;ánh s&#7889; t&#7915;<span style='mso-spacerun:yes'>  </span>trang 01
  &#273;&#7871;n<span style='mso-spacerun:yes'>  </span>trang……</td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td class=xl42></td>
 </tr>
 <tr class=xl43 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl44 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl72>Ngày <%= d_to.Substring(6, 2)%> tháng <%= d_to.Substring(4, 2)%> năm <%= d_to.Substring(0, 4)%></td>
  <td class=xl45></td>
  <td class=xl42></td>
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
 <tr class=xl43 height=23 style='height:17.25pt'>
  <td colspan=3 height=23 class=xl46 style='height:17.25pt'><%= v1 %></td>
  <td colspan=1 height=23 class=xl46 style='height:17.25pt'><%= v2 %></td>
  <td class=xl46><%= v3 %></td>
  <td class=xl46></td>
  <td colspan=3 class=xl73><%= v4 %></td>
  <td class=xl47></td>
  <td class=xl42></td>
 </tr>
 <tr class=xl43 height=23 style='height:17.25pt'>
  <td colspan=3 height=23 class=xl48 style='height:17.25pt'><%=g1 %></td>
  <td colspan=1 height=23 class=xl48 style='height:17.25pt'><%=g2 %></td>
  <td class=xl48><%=g3 %></td>
  <td class=xl48></td>
  <td colspan=3 class=xl70><%=g4 %></td>
  <td class=xl45></td>
  <td class=xl42></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=10 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl53></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=10 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl53></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=10 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl53></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=10 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl53></td>
 </tr>

<tr class=xl43 height=23 style='height:17.25pt'>
  <td colspan=3 height=23 class=xl46 style='height:17.25pt'><%= n1 %></td>
  <td colspan=1 height=23 class=xl46 style='height:17.25pt'><%= n2 %></td>
  <td class=xl46><%= n3 %></td>
  <td class=xl46></td>
  <td colspan=3 class=xl73><%= n4 %></td>
  <td class=xl47></td>
  <td class=xl42></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=83 style='width:62pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=271 style='width:203pt'></td>
  <td width=271 style='width:203pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=63 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
