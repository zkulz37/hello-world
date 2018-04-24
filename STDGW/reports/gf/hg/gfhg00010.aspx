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
    string p_seq = "" + Request["seq"];
    string p_pk = "" + Request["pk"];
    string p_trans_date = "";
    string p_voucher_no = "";
    string p_company_name = "";
    string p_dept_name = "";
    string p_trans_type = "";
    string p_trans_name = "";
    string p_pro_by = "";
    string p_sign_date = "";
    string p_app_by = "";
    string p_remark = "";
    string p_remark2 = "";
    string p_trans_ccy = "";
    string p_total_bookamt = "";
    string p_ex_bookrate = "";
    string p_book_ccy = "";
    String p_xls_ccy_format = "";
    string p_total_debit = "0";
    string p_total_credit = "0";
    string p_company_pk = "";
    string p_enclose = "";
    String e1 = "";
    String e2 = "";
    String e3 = "";
    String e4 = "";
    String e5 = "";

    String v1 = "";
    String v2 = "";
    String v3 = "";
    String v4 = "";
    String v5 = "";

    string p_sumdr = "";
    string p_sumcr = "";
    string cur = "";
    string tran_rate="";
    string SQL = "SELECT H.VOUCHERNO, TO_CHAR(H.TR_DATE,'DD/MM/YYYY') TRANS_DATE,  " +
        " D.org_NM,A.TR_TYPE,A.TR_TPNM,V1.FULL_NAME PRO_BY, " +
        "  h.SIGN_DATE ,V2.FULL_NAME APP_BY,  " +
        " REMARK,REMARK2,C.PARTNER_NAME,C.PK, H.TR_ENCLOSE" +
        " FROM TAC_HGTRH H,TCO_COMPANY C, TCO_org D,TAC_ABTRTYPE A,VCO_BSUSER V1, VCO_BSUSER V2 " +
        " WHERE H.DEL_IF =0 " +
        " AND C.DEL_IF =0  " +
        " AND H.TCO_org_PK = D.PK(+) " +
        " AND H.TAC_ABTRTYPE_PK = A.PK(+) " +
        " AND H.TCO_COMPANY_PK = C.PK " +
        " AND H.TCO_BSUSER_PK = V1.PK(+) " +
        " AND H.SIGN_MEMB = V2.USER_ID(+) " +
        " AND H.PK = " + p_seq;


    
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        p_voucher_no = dt.Rows[0][0].ToString();
        p_trans_date = dt.Rows[0][1].ToString();
        p_dept_name = dt.Rows[0][2].ToString();
        p_trans_type = dt.Rows[0][3].ToString();
        p_trans_name = dt.Rows[0][4].ToString();
        p_pro_by = dt.Rows[0][5].ToString();
        p_sign_date = dt.Rows[0][6].ToString();
        p_app_by = dt.Rows[0][7].ToString();
        p_remark = dt.Rows[0][8].ToString();
        p_remark2 = dt.Rows[0][9].ToString();
        p_company_name = dt.Rows[0][10].ToString();
        p_company_pk = dt.Rows[0][11].ToString();
        p_enclose = dt.Rows[0][12].ToString();
    }
//---------------------------------------------------------------------------------

    SQL = "SELECT " +
        " TO_CHAR(SUM(DECODE(DRCR_TYPE,'D',TR_BOOKAMT,0)),DECODE('" + p_book_ccy + "','VND','9,999,999,999,990','9,999,999,999,990.99')) SUM_DEBIT, " +
        " TO_CHAR(SUM(DECODE(DRCR_TYPE,'C',TR_BOOKAMT,0)),DECODE('" + p_book_ccy + "','VND','9,999,999,999,990','9,999,999,999,990.99')) SUM_CREDIT " +
        " FROM TAC_HGTRD D " +
        " WHERE D.DEL_IF = 0 " +
        " AND D.TAC_HGTRH_PK = " + p_seq;
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    if (dt_total.Rows.Count > 0)
    {
        p_total_debit = dt_total.Rows[0][0].ToString();
        p_total_credit = dt_total.Rows[0][1].ToString();
    }
//---------------------------------------------------------------------------------
    
   SQL = "SELECT B.CODE, B.CODE_NM FROM TAC_COMMCODE_MASTER A, TAC_COMMCODE_DETAIL B WHERE A.PK = B.TAC_COMMCODE_MASTER_PK AND A.ID = 'ACBG0040' and a.del_if = 0 and b.del_if = 0 and b.DEF_YN = 'Y' ";


    dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        p_book_ccy = dt.Rows[0][0].ToString();
    }
//---------------------------------------------------------------------------------

    SQL = "SELECT MAX(CCY), TO_CHAR(SUM(TR_BOOKAMT),DECODE('" + p_book_ccy + "','VND','9,999,999,999,990','9,999,999,999,990.99')) BOOK_AMT, TO_CHAR(MAX(BK_RATE),'9,999,999,999,990'), TO_CHAR(MAX(TR_RATE),'9,999,999,999,990') " +
        " FROM TAC_HGTRD D  " +
        " WHERE D.DEL_IF = 0 " +
        " AND D.TAC_HGTRH_PK = " + p_seq +
        " AND DRCR_TYPE ='D' ";
    dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        p_trans_ccy = dt.Rows[0][0].ToString();
        p_total_bookamt = dt.Rows[0][1].ToString();
        p_ex_bookrate = dt.Rows[0][2].ToString();
        tran_rate = dt.Rows[0][3].ToString();
    }

    SQL = "SELECT CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='N'";
    DataTable dtccy= ESysLib.TableReadOpen(SQL);
    if (dtccy.Rows.Count > 0)
    {
        cur = dtccy.Rows[0][0].ToString();
    }	
//------------------------------------------------------------------------

 
    string l_book_ccy = "";
  
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




    decimal total_cr = 0;
    decimal total_dr = 0;
    decimal ccy_dr = 0;
    decimal ccy_cr = 0;
    decimal exchange = 0;
    decimal multiply_dr = 0;
    decimal multiply_cr = 0;
    string amount = "";

   
    SQL = "SELECT ac_get_ACCD(D.TAC_ABACCTCODE_PK, " + p_company_pk + ") ACCD, ac_get_ACNM(D.TAC_ABACCTCODE_PK, " + p_company_pk + ", 'ENG'), " +
       "d.REMARK,d.REMARK2,ac_get_AGTRITEM(D.PK), " +
       "  + DECODE(DRCR_TYPE,'D',TO_CHAR(abs(TR_BOOKAMT),DECODE('" + p_book_ccy + "','VND','9,999,999,999,990','9,999,999,999,990.99')),'') DEBIT_AMT,  " +
       "   + DECODE(DRCR_TYPE,'D','',TO_CHAR(abs(TR_BOOKAMT),DECODE('" + p_book_ccy + "','VND','9,999,999,999,990','9,999,999,999,990.99'))) CREDIT_AMT , " +
       "  D.BUSPARTNER_ID, D.BUSPARTNER_LNM, f.PLC_CD,f.PLC_NM " +
       "   ,aaaa.tac_hgtrd_pk, aaaa.ITEM, aaaa.ITEM_NM, d.ccy, d.TR_RATE " +
       "  from( SELECT  A.ITEM ,ITEM_NM,a.tac_hgtrd_pk " +
       "      FROM TAC_HGTRDITEM a, TAC_ABACCTITEM b " +
       "     where TAC_ABACCTITEM_PK = b.PK " +

       "       AND B.TAC_ABITEM_ALIAS  = 'CONTRACT NOAR' " +
       "       AND a.DEL_IF = 0 " +
       "       AND b.DEL_IF = 0 " +
       "UNION ALL " +
       "SELECT  A.ITEM ,ITEM_NM, a.tac_hgtrd_pk " +
       "      FROM TAC_HGTRDITEM a, TAC_ABACCTITEM b " +
       "     where TAC_ABACCTITEM_PK = b.PK " +

       "       AND B.TAC_ABITEM_ALIAS  = 'CONTRACT NOAP' " +
       "       AND a.DEL_IF = 0 " +
       "       AND b.DEL_IF = 0)aaaa,             " +
       " TAC_HGTRD D, TAC_ABPLCENTER e, TAC_ABCENTER f " +
       " WHERE D.DEL_IF = 0  " +
       " AND D.TAC_HGTRH_PK = " + p_seq +
       "and aaaa.tac_hgtrd_pk(+) = D.pk " +
       "and e.del_if(+) = 0 " +
       "and f.del_if(+) = 0 " +
       "and e.TAC_ABCENTER_PK = f.pk(+) " +
       "and d.TAC_ABPLCENTER_PK = e.pk(+) " +
       " ORDER BY DRCR_TYPE DESC, DRCR_ORD ASC,TYPE_REF  ";


    DataTable dt_detail = ESysLib.TableReadOpen(SQL);
    //Response.Write(dt_detail.Rows.Count);
    //Response.End();
    
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="amb_files/filelist.xml">
<link rel=Edit-Time-Data href="amb_files/editdata.mso">
<link rel=OLE-Object-Data href="amb_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Long</o:Author>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:LastPrinted>2010-03-30T04:14:25Z</o:LastPrinted>
  <o:Created>2010-03-30T03:47:14Z</o:Created>
  <o:LastSaved>2010-03-30T04:21:25Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in 0in 1.0in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
.font5
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Arial Narrow", sans-serif;
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
.style22
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:돋움, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"Normal_Slip form";}
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
.xl25
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style22;
	font-size:8.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl34
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl38
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0\.00\;\[Red\]\[$VND\]\\ \#\,\#\#0\.00";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\[Red\]\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:aqua;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:aqua;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style22;
	font-size:12.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl51
	{mso-style-parent:style22;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\[Red\]\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt hairline black;}
.xl53
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;}
.xl60
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl64
	{mso-style-parent:style16;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl65
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl69
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl70
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt hairline black;}
.xl71
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl73
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:none;
	border-left:none;}
.xl74
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt hairline black;}
.xl75
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl77
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline black;}
.xl79
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style22;
	font-size:9.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:.5pt solid windowtext;}
.xl83
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl84
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\\ ?\/?";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl85
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt hairline black;}
.xl86
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl88
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:none;
	border-left:none;}
.xl89
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl90
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl91
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:#FFFF99;
	mso-pattern:auto none;}
.xl92
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid black;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid black;
	border-left:.5pt solid black;}
.xl96
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid black;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;}
.xl97
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl98
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl99
	{mso-style-parent:style22;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid black;
	border-left:.5pt solid black;}
.xl100
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt hairline black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl103
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl104
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl105
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl106
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl107
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl108
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl109
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl110
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl111
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl112
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt hairline black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl113
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt hairline black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl114
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl115
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline black;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl116
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl117
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl118
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt hairline black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl119
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl120
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl121
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl122
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl123
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl124
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl125
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt dotted windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl126
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline black;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl127
	{mso-style-parent:style22;
	font-size:11.0pt;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt hairline black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl128
	{mso-style-parent:style22;
	font-weight:700;
	font-family:"Arial Narrow", sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid black;
	background:aqua;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl129
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl130
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
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
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$14:$E$14</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    
    
    
    
    
    <x:PageBreaks>
     <x:RowBreaks>
            <%
            int i_row_break = 28 ;
            int j = 0; 
            for (j=0; j <= dt_detail.Rows.Count/6 ;j++)
            {
                    if (j==0)
                        i_row_break = 28 ;
                    else 
                        i_row_break += 19  ;
            %>
                  <x:RowBreak>
                   <x:Row><%= i_row_break%></x:Row>
                  </x:RowBreak>
            <%
            }
            %>
                  
     </x:RowBreaks>
    </x:PageBreaks>
    
    
    
    
    
    
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12270</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>495</x:WindowTopX>
  <x:WindowTopY>660</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=954 style='border-collapse:
 collapse;table-layout:fixed;width:715pt'>
 <col width=22 style='mso-width-source:userset;mso-width-alt:804;width:17pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=64 span=4 style='width:48pt'>
 <col width=32 style='mso-width-source:userset;mso-width-alt:1170;width:24pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=59 style='mso-width-source:userset;mso-width-alt:2157;width:44pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=1 style='mso-width-source:userset;mso-width-alt:36;width:1pt'>
 <col width=4 span=2 style='mso-width-source:userset;mso-width-alt:146;
 width:3pt'>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl26 width=22 style='height:16.5pt;width:17pt'></td>
  <td class=xl27 width=96 style='width:72pt'></td>
  <td class=xl25 width=79 style='width:59pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=32 style='width:24pt'></td>
  <td class=xl25 width=80 style='width:60pt'></td>
  <td class=xl25 width=71 style='width:53pt'></td>
  <td width=67 style='width:50pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s1065" type="#_x0000_t75" style='position:absolute;
   margin-left:.75pt;margin-top:0;width:237.75pt;height:63pt;z-index:36'
   filled="t" fillcolor="white [9]" strokecolor="windowText [64]"
   strokeweight=".5pt" o:insetmode="auto">
   <v:imagedata src="amb_files/image001.emz" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:36;margin-left:1px;margin-top:0px;width:317px;
  height:84px'><img width=317 height=84 src="amb_files/image002.gif" v:shapes="_x0000_s1065"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=22 class=xl25 width=67 style='height:16.5pt;width:50pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 width=96 style='width:72pt'></td>
  <td class=xl25 width=59 style='width:44pt'></td>
  <td class=xl25 width=96 style='width:72pt'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 style='height:16.5pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1076" type="#_x0000_t75" style='position:absolute;margin-left:1.5pt;
   margin-top:10.5pt;width:153.75pt;height:36pt;z-index:47'>
   <v:imagedata src="amb_files/image003.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:47;margin-left:2px;margin-top:14px;width:205px;
  height:48px'><img width=205 height=48 src="amb_files/image004.jpg" v:shapes="_x0000_s1076"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=22 class=xl26 width=22 style='height:16.5pt;width:17pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl27></td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl26 style='height:16.5pt'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=9 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl26 style='height:16.5pt'></td>
  <td class=xl27></td>
  <td colspan=12 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl29 colspan=2 style='height:16.5pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>●<font class="font5"> Cash In / Out No :</font></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><%=p_voucher_no%></td>
  <td class=xl30 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>●<font class="font5"> Requester : <%=p_pro_by%></font></td>
  <td class=xl25></td>
  <td colspan=2 class=xl31>●<font class="font5"> Slip No :</font></td>
  <td colspan=2 class=xl106><%=p_trans_date%></td>
  <td colspan=2 height=22 class=xl25 width=155 style='mso-ignore:colspan-rowspan;
  height:16.5pt;width:116pt'><!--[if gte vml 1]><v:group id="Group_x0020_54"
   o:spid="_x0000_s1059" style='position:absolute;margin-left:1.5pt;
   margin-top:.75pt;width:106.5pt;height:15pt;z-index:35' coordorigin="905,84"
   coordsize="155,24">
   <o:lock v:ext="edit" text="t"/>
   <v:rect id="Rectangle_x0020_55" o:spid="_x0000_s1060" style='position:absolute;
    left:905;top:84;width:29;height:24;visibility:visible'>
    <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
     <div style='text-align:left'></div>
    </v:textbox>
   </v:rect><v:rect id="Rectangle_x0020_56" o:spid="_x0000_s1061" style='position:absolute;
    left:937;top:84;width:29;height:24;visibility:visible'>
    <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
     <div style='text-align:left'></div>
    </v:textbox>
   </v:rect><v:rect id="Rectangle_x0020_57" o:spid="_x0000_s1062" style='position:absolute;
    left:968;top:84;width:29;height:24;visibility:visible'>
    <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
     <div style='text-align:left'></div>
    </v:textbox>
   </v:rect><v:rect id="Rectangle_x0020_58" o:spid="_x0000_s1063" style='position:absolute;
    left:1000;top:84;width:29;height:24;visibility:visible' filled="f"
    stroked="f">
    <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
     <div style='text-align:left'></div>
    </v:textbox>
   </v:rect><v:rect id="Rectangle_x0020_59" o:spid="_x0000_s1064" style='position:absolute;
    left:1031;top:84;width:29;height:24;visibility:visible' filled="f"
    stroked="f">
    <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
     <div style='text-align:left'></div>
    </v:textbox>
   </v:rect></v:group><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=1 height=0></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=143 height=22 src="amb_files/image005.gif" v:shapes="Group_x0020_54 Rectangle_x0020_55 Rectangle_x0020_56 Rectangle_x0020_57 Rectangle_x0020_58 Rectangle_x0020_59"></td>
    <td width=11></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:116.25pt;height:16.5pt'></span><![endif]--></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl31 style='height:16.5pt'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td rowspan=3 height=66 class=xl107 style='border-bottom:.5pt solid black;height:49.5pt'>S Q</td>
  <td colspan=2 class=xl110 style='border-right:.5pt hairline black;border-left:none'>Account Code</td>
  <td colspan=2 class=xl112 style='border-right:.5pt hairline black;border-left:none'>Vender Code</td>
  <td colspan=3 rowspan=2 class=xl113 style='border-right:.5pt hairline black;border-bottom:.5pt solid black'>Managing Item</td>
  <td colspan=2 class=xl112 style='border-right:.5pt solid black;border-left:none'>Project Code</td>
  <td colspan=4 rowspan=2 class=xl120 style='border-right:.5pt solid black;border-bottom:.5pt solid black'>Voucher Information</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td colspan=2 height=22 class=xl124 style='border-right:.5pt hairline black;height:16.5pt;border-left:none'>Account Name</td>
  <td colspan=2 class=xl126 style='border-right:.5pt hairline black;border-left:none'>Vender Name</td>
  <td colspan=2 class=xl100 style='border-right:.5pt solid black;border-left:none'>Project Name</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td colspan=2 height=22 class=xl102 style='border-right:.5pt solid black;height:16.5pt;border-left:none'>Detail Item</td>
  <td colspan=5 class=xl97 style='border-right:.5pt solid black;border-left: none'>Description</td>
  <td colspan=2 class=xl105 style='border-right:.5pt solid black;border-left:none'>(Department Name)</td>
  <td colspan=2 class=xl97 style='border-right:.5pt solid black;border-left:none'>Dr</td>
  <td colspan=2 class=xl97 style='border-right:.5pt solid black;border-left:none'>Cr</td>
 </tr>
   <%
     
       int y = 0;
   
	for(int i=0;i<dt_detail.Rows.Count;i++)
	{

//-----------------------------------------------------------
        if (dt_detail.Rows[i][5].ToString().Trim() != "")
        {
            ccy_dr = decimal.Parse(dt_detail.Rows[i][5].ToString());
        }
        else
        {
            ccy_dr = 0;
        }
//--------------------------------------------------------------
        if (dt_detail.Rows[i][6].ToString().Trim() != "")
        {
            ccy_cr = decimal.Parse(dt_detail.Rows[i][6].ToString());
        }
        else
        {
            ccy_cr = 0;
        }
//-------------------------------------------------------------------------------------
        if (dt_detail.Rows[i][15].ToString().Trim() != "")
        {
            exchange = decimal.Parse(dt_detail.Rows[i][15].ToString());
        }
        else
        {
            exchange = 0;
        }

        multiply_dr = ccy_dr * exchange;
        multiply_cr = ccy_cr * exchange;


        //----------------sum total dr----------------
        if (multiply_dr.ToString().Trim() != "")
        {
            total_dr += decimal.Parse(multiply_dr.ToString());
        }
        else
        {
            total_dr = 0;
        }
        //------------sum total cr-------------------------
        if (multiply_cr.ToString().Trim() != "")
        {
            total_cr += decimal.Parse(multiply_cr.ToString());
        }
        else
        {
            total_cr = 0;
        }

        
       
        
 %>
<!--- 1 -->
 <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num><%=y+1%></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><%=dt_detail.Rows[i][0]%><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i][7]%></td>
  <td class=xl32><%=dt_detail.Rows[i][12]%></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i][9]%></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i][5]%></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_detail.Rows[i][6]%></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'><%=dt_detail.Rows[i][1]%></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i][8]%></td>
  <td class=xl36 width=64 style='width:48pt'><%=dt_detail.Rows[i][13]%></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i][10]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<%=dt_detail.Rows[i][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i][15]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><%=dt_detail.Rows[i][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i][15]%></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ><%=p_remark2%></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_dr%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_cr%><span style='mso-spacerun:yes'>   </span></td>
 </tr>
 
 
 <!-------2--->
 <% if(i+1<dt_detail.Rows.Count)
    {
        //-----------------------------------------------------------
        if (dt_detail.Rows[i+1][5].ToString().Trim() != "")
        {
            ccy_dr = decimal.Parse(dt_detail.Rows[i+1][5].ToString());
        }
        else
        {
            ccy_dr = 0;
        }
        //--------------------------------------------------------------
        if (dt_detail.Rows[i+1][6].ToString().Trim() != "")
        {
            ccy_cr = decimal.Parse(dt_detail.Rows[i+1][6].ToString());
        }
        else
        {
            ccy_cr = 0;
        }
        //-------------------------------------------------------------------------------------
        if (dt_detail.Rows[i+1][15].ToString().Trim() != "")
        {
            exchange = decimal.Parse(dt_detail.Rows[i+1][15].ToString());
        }
        else
        {
            exchange = 0;
        }

        multiply_dr = ccy_dr * exchange;
        multiply_cr = ccy_cr * exchange;
        
        //----------------sum total dr----------------
        if (multiply_dr.ToString().Trim() != "")
        {
            total_dr += decimal.Parse(multiply_dr.ToString());
        }
        else
        {
            total_dr = 0;
        }
        //------------sum total cr-------------------------
        if (multiply_cr.ToString().Trim() != "")
        {
            total_cr += decimal.Parse(multiply_cr.ToString());
        }
        else
        {
            total_cr = 0;
        }
        
        amount = CommondLib.Num2EngText(total_dr.ToString(), total_cr.ToString());
        
           %>
  <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num><%=y+2%></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><%=dt_detail.Rows[i+1][0]%><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i+1][7]%></td>
  <td class=xl32><%=dt_detail.Rows[i][12]%></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i+1][9]%></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+1][5]%></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_detail.Rows[i+1][6]%></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'><%=dt_detail.Rows[i+1][1]%></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i+1][8]%></td>
  <td class=xl36 width=64 style='width:48pt'><%=dt_detail.Rows[i+1][13]%></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i+1][10]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<%=dt_detail.Rows[i+1][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+1][15]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><%=dt_detail.Rows[i+1][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+1][15]%></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ><%=p_remark2%></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_dr%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_cr%><span style='mso-spacerun:yes'>   </span></td>
 </tr>
 
 <% 
}
    else
    { %>
 <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'></td>
  <td class=xl36 width=64 style='width:48pt'></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span>></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'>   </span></td>
 </tr>
 <%
     
 } %>
 <!-----3----->
 <% if(i+2<dt_detail.Rows.Count)
    {
        //-----------------------------------------------------------
        if (dt_detail.Rows[i + 2][5].ToString().Trim() != "")
        {
            ccy_dr = decimal.Parse(dt_detail.Rows[i + 2][5].ToString());
        }
        else
        {
            ccy_dr = 0;
        }
        //--------------------------------------------------------------
        if (dt_detail.Rows[i + 2][6].ToString().Trim() != "")
        {
            ccy_cr = decimal.Parse(dt_detail.Rows[i + 2][6].ToString());
        }
        else
        {
            ccy_cr = 0;
        }
        //-------------------------------------------------------------------------------------
        if (dt_detail.Rows[i + 2][15].ToString().Trim() != "")
        {
            exchange = decimal.Parse(dt_detail.Rows[i + 2][15].ToString());
        }
        else
        {
            exchange = 0;
        }

        multiply_dr = ccy_dr * exchange;
        multiply_cr = ccy_cr * exchange;

        //----------------sum total dr----------------
        if (multiply_dr.ToString().Trim() != "")
        {
            total_dr += decimal.Parse(multiply_dr.ToString());
        }
        else
        {
            total_dr = 0;
        }
        //------------sum total cr-------------------------
        if (multiply_cr.ToString().Trim() != "")
        {
            total_cr += decimal.Parse(multiply_cr.ToString());
        }
        else
        {
            total_cr = 0;
        }
        
        %>
  <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num><%=y+3%></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><%=dt_detail.Rows[i+2][0]%><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i+2][7]%></td>
  <td class=xl32><%=dt_detail.Rows[i][12]%></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i+2][9]%></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+2][5]%></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_detail.Rows[i+2][6]%></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'><%=dt_detail.Rows[i+2][1]%></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i+2][8]%></td>
  <td class=xl36 width=64 style='width:48pt'><%=dt_detail.Rows[i+2][13]%></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i+2][10]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<%=dt_detail.Rows[i+2][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+2][15]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><%=dt_detail.Rows[i+2][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+2][15]%></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ><%=p_remark2%></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_dr%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_cr%><span style='mso-spacerun:yes'>   </span></td>
 </tr>
 
 <% }
    else
    { %>
 <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'></td>
  <td class=xl36 width=64 style='width:48pt'></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'>   </span></td>
 </tr>
 <% } %>
 <!-----4---->
  <% if(i+3<dt_detail.Rows.Count)
    {

        //-----------------------------------------------------------
        if (dt_detail.Rows[i + 3][5].ToString().Trim() != "")
        {
            ccy_dr = decimal.Parse(dt_detail.Rows[i + 3][5].ToString());
        }
        else
        {
            ccy_dr = 0;
        }
        //--------------------------------------------------------------
        if (dt_detail.Rows[i + 3][6].ToString().Trim() != "")
        {
            ccy_cr = decimal.Parse(dt_detail.Rows[i + 3][6].ToString());
        }
        else
        {
            ccy_cr = 0;
        }
        //-------------------------------------------------------------------------------------
        if (dt_detail.Rows[i + 3][15].ToString().Trim() != "")
        {
            exchange = decimal.Parse(dt_detail.Rows[i + 3][15].ToString());
        }
        else
        {
            exchange = 0;
        }

        multiply_dr = ccy_dr * exchange;
        multiply_cr = ccy_cr * exchange;


        //----------------sum total dr----------------
        if (multiply_dr.ToString().Trim() != "")
        {
            total_dr += decimal.Parse(multiply_dr.ToString());
        }
        else
        {
            total_dr = 0;
        }
        //------------sum total cr-------------------------
        if (multiply_cr.ToString().Trim() != "")
        {
            total_cr += decimal.Parse(multiply_cr.ToString());
        }
        else
        {
            total_cr = 0;
        }
         %>
 <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num><%=y+4%></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><%=dt_detail.Rows[i+3][0]%><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i+3][7]%></td>
  <td class=xl32><%=dt_detail.Rows[i+3][12]%></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i+3][9]%></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+3][5]%></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_detail.Rows[i+3][6]%></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'><%=dt_detail.Rows[i+3][1]%></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i+3][8]%></td>
  <td class=xl36 width=64 style='width:48pt'><%=dt_detail.Rows[i+3][13]%></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i+3][10]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<%=dt_detail.Rows[i+3][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+3][15]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><%=dt_detail.Rows[i+3][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+3][15]%></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ><%=p_remark2%></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_dr%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_cr%><span style='mso-spacerun:yes'>   </span></td>
 </tr>
 
 <% }
    else
    { %>
    
    <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'></td>
  <td class=xl36 width=64 style='width:48pt'></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'>   </span></td>
 </tr>
  <% } %>

 <!----5----->
  <% if(i+4<dt_detail.Rows.Count)
    {
        //-----------------------------------------------------------
        if (dt_detail.Rows[i + 4][5].ToString().Trim() != "")
        {
            ccy_dr = decimal.Parse(dt_detail.Rows[i + 4][5].ToString());
        }
        else
        {
            ccy_dr = 0;
        }
        //--------------------------------------------------------------
        if (dt_detail.Rows[i + 4][6].ToString().Trim() != "")
        {
            ccy_cr = decimal.Parse(dt_detail.Rows[i + 4][6].ToString());
        }
        else
        {
            ccy_cr = 0;
        }
        //-------------------------------------------------------------------------------------
        if (dt_detail.Rows[i + 4][15].ToString().Trim() != "")
        {
            exchange = decimal.Parse(dt_detail.Rows[i + 4][15].ToString());
        }
        else
        {
            exchange = 0;
        }

        multiply_dr = ccy_dr * exchange;
        multiply_cr = ccy_cr * exchange;


        //----------------sum total dr----------------
        if (multiply_dr.ToString().Trim() != "")
        {
            total_dr += decimal.Parse(multiply_dr.ToString());
        }
        else
        {
            total_dr = 0;
        }
        //------------sum total cr-------------------------
        if (multiply_cr.ToString().Trim() != "")
        {
            total_cr += decimal.Parse(multiply_cr.ToString());
        }
        else
        {
            total_cr = 0;
        }
         %>
    
    
  <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num><%=y+5%></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><%=dt_detail.Rows[i+4][0]%><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i+4][7]%></td>
  <td class=xl32><%=dt_detail.Rows[i+4][12]%></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i+4][9]%></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+4][5]%></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_detail.Rows[i+4][6]%></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'><%=dt_detail.Rows[i+4][1]%></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i+4][8]%></td>
  <td class=xl36 width=64 style='width:48pt'><%=dt_detail.Rows[i+4][13]%></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i+4][10]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<%=dt_detail.Rows[i+4][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+4][15]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><%=dt_detail.Rows[i+4][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+4][15]%></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ><%=p_remark2%></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_dr%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_cr%><span style='mso-spacerun:yes'>   </span></td>
 </tr>
 
 <% }
    else
    { %>
    
    <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'></td>
  <td class=xl36 width=64 style='width:48pt'></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'>   </span></td>
 </tr>
  <% } %>
  
  <!-----6----->
  <% if(i+5<dt_detail.Rows.Count)
    {

        //-----------------------------------------------------------
        if (dt_detail.Rows[i + 5][5].ToString().Trim() != "")
        {
            ccy_dr = decimal.Parse(dt_detail.Rows[i + 5][5].ToString());
        }
        else
        {
            ccy_dr = 0;
        }
        //--------------------------------------------------------------
        if (dt_detail.Rows[i + 5][6].ToString().Trim() != "")
        {
            ccy_cr = decimal.Parse(dt_detail.Rows[i + 5][6].ToString());
        }
        else
        {
            ccy_cr = 0;
        }
        //-------------------------------------------------------------------------------------
        if (dt_detail.Rows[i + 5][15].ToString().Trim() != "")
        {
            exchange = decimal.Parse(dt_detail.Rows[i + 5][15].ToString());
        }
        else
        {
            exchange = 0;
        }

        multiply_dr = ccy_dr * exchange;
        multiply_cr = ccy_cr * exchange;


        //----------------sum total dr----------------
        if (multiply_dr.ToString().Trim() != "")
        {
            total_dr += decimal.Parse(multiply_dr.ToString());
        }
        else
        {
            total_dr = 0;
        }
        //------------sum total cr-------------------------
        if (multiply_cr.ToString().Trim() != "")
        {
            total_cr += decimal.Parse(multiply_cr.ToString());
        }
        else
        {
            total_cr = 0;
        }
         %>
  <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num><%=y+6%></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><%=dt_detail.Rows[i+5][0]%><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i+5][7]%></td>
  <td class=xl32><%=dt_detail.Rows[i+5][12]%></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i+5][9]%></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+5][5]%></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt_detail.Rows[i+5][6]%></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'><%=dt_detail.Rows[i+5][1]%></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'><%=dt_detail.Rows[i+5][8]%></td>
  <td class=xl36 width=64 style='width:48pt'><%=dt_detail.Rows[i+5][13]%></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[i+5][10]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<%=dt_detail.Rows[i+5][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+5][15]%></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><%=dt_detail.Rows[i+5][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=dt_detail.Rows[i+5][15]%></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ><%=p_remark2%></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_dr%><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=multiply_cr%><span style='mso-spacerun:yes'>   </span></td>
 </tr>
 
 <% }
    else
    { %>
    
    <tr height=18 style='height:13.5pt'>
  <td rowspan=3 height=55 class=xl99 style='height:41.25pt;border-top:none'x:num></td>
  <td colspan=2 class=xl83 width=175 style='border-right:.5pt hairline black;width:131pt' ><span style='mso-spacerun:yes'>    </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt hairline black;border-left:none'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl87 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:none'></td>
  <td class=xl33 x:str=" Currency "><span style='mso-spacerun:yes'> </span>Currency<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl34 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl28>Currency</td>
  <td class=xl35 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td colspan=2 height=19 class=xl76 width=175 style='border-right:.5pt hairline black;height:14.25pt;width:131pt'></td>
  <td colspan=2 class=xl78 style='border-right:.5pt hairline black;border-left:none'></td>
  <td class=xl36 width=64 style='width:48pt'></td>
  <td colspan=2 class=xl80 style='border-right:.5pt hairline black'>&nbsp;</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:none'></td>
  <td class=xl37 ><span style='mso-spacerun:yes'> </span>&nbsp;<%=dt_detail.Rows[i][14]%><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl38 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
  <td class=xl37 ><span style='mso-spacerun:yes'>  </span><span style='mso-spacerun:yes'>  </span></td>
  <td class=xl39 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl54 style='border-right:.5pt solid black;height:13.5pt'></td>
  <td colspan=5 class=xl56 style='border-right:.5pt solid black;border-left:none' ></td>
  <td colspan=2 class=xl59 style='border-right:.5pt solid black;border-left:none'></td>
  <td colspan=2 class=xl61 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl63 style="border-right:.5pt solid black;border-left:none;mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'>   </span></td>
 </tr>
  <% } %>
  <%amount = CommondLib.Num2EngText(total_dr.ToString(), total_cr.ToString()); %>
 <tr height=18 style='height:13.5pt'>
  <td colspan=2 height=18 class=xl48 style='border-right:1.0pt solid black;height:13.5pt'>Total</td>
  <td colspan=8 class=xl128 style='border-right:.5pt solid black;border-left: none'><%=amount%> <%=dt_detail.Rows[i][14]%></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="Line_x0020_7"
   o:spid="_x0000_s1025" style='position:absolute;z-index:1;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_22"
   o:spid="_x0000_s1033" style='position:absolute;z-index:9;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_28"
   o:spid="_x0000_s1039" style='position:absolute;z-index:15;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_35"
   o:spid="_x0000_s1046" style='position:absolute;z-index:22;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_41"
   o:spid="_x0000_s1052" style='position:absolute;z-index:28;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:1;margin-left:1px;
  margin-top:9px;width:2px;height:2px'><img width=2 height=2
  src="amb_files/image006.gif" v:shapes="Line_x0020_7 Line_x0020_22 Line_x0020_28 Line_x0020_35 Line_x0020_41"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=18 class=xl41 width=67 style='height:13.5pt;width:50pt'><%=dt_detail.Rows[i][14]%><span style='mso-spacerun:yes'> </span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><span style='mso-spacerun:yes'> </span><%=total_dr%></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="Line_x0020_8"
   o:spid="_x0000_s1026" style='position:absolute;z-index:2;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_9"
   o:spid="_x0000_s1027" style='position:absolute;z-index:3;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_10"
   o:spid="_x0000_s1028" style='position:absolute;z-index:4;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_11"
   o:spid="_x0000_s1029" style='position:absolute;z-index:5;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_13"
   o:spid="_x0000_s1030" style='position:absolute;z-index:6;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_20"
   o:spid="_x0000_s1031" style='position:absolute;z-index:7;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_21"
   o:spid="_x0000_s1032" style='position:absolute;z-index:8;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_23"
   o:spid="_x0000_s1034" style='position:absolute;z-index:10;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_24"
   o:spid="_x0000_s1035" style='position:absolute;z-index:11;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_25"
   o:spid="_x0000_s1036" style='position:absolute;z-index:12;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_26"
   o:spid="_x0000_s1037" style='position:absolute;z-index:13;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_27"
   o:spid="_x0000_s1038" style='position:absolute;z-index:14;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_29"
   o:spid="_x0000_s1040" style='position:absolute;z-index:16;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_30"
   o:spid="_x0000_s1041" style='position:absolute;z-index:17;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_31"
   o:spid="_x0000_s1042" style='position:absolute;z-index:18;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_32"
   o:spid="_x0000_s1043" style='position:absolute;z-index:19;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_33"
   o:spid="_x0000_s1044" style='position:absolute;z-index:20;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_34"
   o:spid="_x0000_s1045" style='position:absolute;z-index:21;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_36"
   o:spid="_x0000_s1047" style='position:absolute;z-index:23;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_37"
   o:spid="_x0000_s1048" style='position:absolute;z-index:24;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_38"
   o:spid="_x0000_s1049" style='position:absolute;z-index:25;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_39"
   o:spid="_x0000_s1050" style='position:absolute;z-index:26;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_40"
   o:spid="_x0000_s1051" style='position:absolute;z-index:27;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_42"
   o:spid="_x0000_s1053" style='position:absolute;z-index:29;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_43"
   o:spid="_x0000_s1054" style='position:absolute;z-index:30;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_44"
   o:spid="_x0000_s1055" style='position:absolute;z-index:31;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_45"
   o:spid="_x0000_s1056" style='position:absolute;z-index:32;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_46"
   o:spid="_x0000_s1057" style='position:absolute;z-index:33;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="Line_x0020_47"
   o:spid="_x0000_s1058" style='position:absolute;z-index:34;visibility:visible'
   from="1.5pt,7.5pt" to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="_x0000_s1066"
   style='position:absolute;z-index:37;visibility:visible' from="1.5pt,7.5pt"
   to="1.5pt,7.5pt" strokeweight="1.5pt"/><v:line id="_x0000_s1067" style='position:absolute;
   z-index:38;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1068" style='position:absolute;
   z-index:39;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1069" style='position:absolute;
   z-index:40;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1070" style='position:absolute;
   z-index:41;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1071" style='position:absolute;
   z-index:42;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1072" style='position:absolute;
   z-index:43;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1073" style='position:absolute;
   z-index:44;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1074" style='position:absolute;
   z-index:45;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1075" style='position:absolute;
   z-index:46;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1077" style='position:absolute;
   z-index:48;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1078" style='position:absolute;
   z-index:49;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1079" style='position:absolute;
   z-index:50;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1080" style='position:absolute;
   z-index:51;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1081" style='position:absolute;
   z-index:52;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1082" style='position:absolute;
   z-index:53;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1083" style='position:absolute;
   z-index:54;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1084" style='position:absolute;
   z-index:55;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1085" style='position:absolute;
   z-index:56;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1086" style='position:absolute;
   z-index:57;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1087" style='position:absolute;
   z-index:58;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1088" style='position:absolute;
   z-index:59;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1089" style='position:absolute;
   z-index:60;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1090" style='position:absolute;
   z-index:61;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1091" style='position:absolute;
   z-index:62;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1092" style='position:absolute;
   z-index:63;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1093" style='position:absolute;
   z-index:64;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1094" style='position:absolute;
   z-index:65;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1095" style='position:absolute;
   z-index:66;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1096" style='position:absolute;
   z-index:67;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1097" style='position:absolute;
   z-index:68;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1098" style='position:absolute;
   z-index:69;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1099" style='position:absolute;
   z-index:70;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1100" style='position:absolute;
   z-index:71;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1101" style='position:absolute;
   z-index:72;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1102" style='position:absolute;
   z-index:73;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1103" style='position:absolute;
   z-index:74;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1104" style='position:absolute;
   z-index:75;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1105" style='position:absolute;
   z-index:76;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1106" style='position:absolute;
   z-index:77;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1107" style='position:absolute;
   z-index:78;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1108" style='position:absolute;
   z-index:79;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1109" style='position:absolute;
   z-index:80;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1110" style='position:absolute;
   z-index:81;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1111" style='position:absolute;
   z-index:82;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1112" style='position:absolute;
   z-index:83;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1113" style='position:absolute;
   z-index:84;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1114" style='position:absolute;
   z-index:85;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1115" style='position:absolute;
   z-index:86;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><v:line id="_x0000_s1116" style='position:absolute;
   z-index:87;visibility:visible' from="1.5pt,7.5pt" to="1.5pt,7.5pt"
   strokeweight="1.5pt"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:1px;margin-top:9px;width:2px;
  height:2px'><img width=2 height=2 src="amb_files/image006.gif" v:shapes="Line_x0020_8 Line_x0020_9 Line_x0020_10 Line_x0020_11 Line_x0020_13 Line_x0020_20 Line_x0020_21 Line_x0020_23 Line_x0020_24 Line_x0020_25 Line_x0020_26 Line_x0020_27 Line_x0020_29 Line_x0020_30 Line_x0020_31 Line_x0020_32 Line_x0020_33 Line_x0020_34 Line_x0020_36 Line_x0020_37 Line_x0020_38 Line_x0020_39 Line_x0020_40 Line_x0020_42 Line_x0020_43 Line_x0020_44 Line_x0020_45 Line_x0020_46 Line_x0020_47 _x0000_s1066 _x0000_s1067 _x0000_s1068 _x0000_s1069 _x0000_s1070 _x0000_s1071 _x0000_s1072 _x0000_s1073 _x0000_s1074 _x0000_s1075 _x0000_s1077 _x0000_s1078 _x0000_s1079 _x0000_s1080 _x0000_s1081 _x0000_s1082 _x0000_s1083 _x0000_s1084 _x0000_s1085 _x0000_s1086 _x0000_s1087 _x0000_s1088 _x0000_s1089 _x0000_s1090 _x0000_s1091 _x0000_s1092 _x0000_s1093 _x0000_s1094 _x0000_s1095 _x0000_s1096 _x0000_s1097 _x0000_s1098 _x0000_s1099 _x0000_s1100 _x0000_s1101 _x0000_s1102 _x0000_s1103 _x0000_s1104 _x0000_s1105 _x0000_s1106 _x0000_s1107 _x0000_s1108 _x0000_s1109 _x0000_s1110 _x0000_s1111 _x0000_s1112 _x0000_s1113 _x0000_s1114 _x0000_s1115 _x0000_s1116"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=18 class=xl43 width=59 style='height:13.5pt;width:44pt'><%=dt_detail.Rows[i][14]%><span style='mso-spacerun:yes'> </span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl42 style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num<span style='mso-spacerun:yes'> </span><%=total_cr%></td>
 </tr>
 
  <%
      y += 6;
      i += 5;
     
    } %>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl26 style='height:16.5pt'></td>
  <td class=xl27></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl50>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl51></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=22 style='width:17pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=96 style='width:72pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
