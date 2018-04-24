<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<html xmlns:gw>
<%
	string p_compk = "", p_custpk = "",  p_bankpk = "", p_sdt = "", p_edt = "";
	string SQL = "";
	string l_bank_nm = "", l_bank_id = "";
	string l_ex_rate = "", l_ccy_bank = "";
	string l_approved_by = "", l_proposed_by = "";
	int i;
	p_compk 		= Request["compk"];
	p_custpk 		= Request["custpk"];
	p_bankpk  	= Request["bankpk"];
	p_sdt 		= Request["sdt"];
	p_edt 		= Request["edt"];
    string l_crt_by = Request["crt_by"];

	SQL = " SELECT B.PARTNER_LNAME, C.BANK_ID, C.CCY";
	SQL = SQL +  "   FROM TAC_ABDEPOMT C, COMM.TCO_BUSPARTNER B";
	SQL = SQL +  "  WHERE C.DEL_IF = 0 ";
	SQL = SQL +  "    AND B.DEL_IF = 0 ";
	SQL = SQL +  "    AND C.TCO_BUSPARTNER_PK = B.PK ";
	SQL = SQL +  "    AND C.PK like 	'" + p_bankpk + "' ";
	DataTable rs = new DataTable();
	rs = ESysLib.TableReadOpen(SQL);	
	if(rs.Rows.Count == 0)
	{
		//Response.Write("No data found");
		//Response.End();
	}
	else
	{
		l_bank_nm = rs.Rows[0][0].ToString();
		l_bank_id = rs.Rows[0][1].ToString();
		l_ccy_bank =  rs.Rows[0][2].ToString();
	}
    SQL
    = "SELECT ttm_rate FROM tac_abexrates WHERE del_if = 0 AND ccy = '" + l_ccy_bank + "'  AND tco_company_pk = '" + p_compk + "' AND std_ymd = '" + p_edt + "' ";
	rs = ESysLib.TableReadOpen(SQL);	
	if(rs.Rows.Count > 0)
		l_ex_rate = rs.Rows[0][0].ToString();
	else
		l_ex_rate = "";
	SQL
	= "select tb.seq, tb.voucherno, tb.voucherno_app, max(tb.buspartner_lnm) buspartner_lnm, max(tb.remark2) remark2,    " + 
        "max(tb.pl_code) pl_code, max(tb.ac_dr) ac_dr, max(tb.ac_cr) ac_cr,   " +
        "  sum(tb.tr_amt) tr_amt, sum(tb.tr_bookamt) tr_bookamt, max(tb.tr_ccy) tr_ccy, max(tb.pay_ccy) pay_ccy, max(tb.partner_id) partner_id    " +
        "from  " +
        "(  " +
        "select  b.tac_hgtrh_pk seq, c.voucherno, c.voucherno_app, a.buspartner_lnm, a.remark2,    " +
        "( select d.pl_cd from v_abplcenter d    " +
        "    where d.tac_abplcenter_pk = a.tac_abplcenter_pk ) pl_code,   " +
        "  sf_a_get_accd(a.tac_abacctcode_pk, '" + p_compk + "') ac_dr, '' ac_cr,   " +
        "  b.tr_amt, b.tr_bookamt,  " +
        "  (select e.tr_ccy from tfn_eppaytr e where e.tfn_eppaytrh_pk = t.pk and e.del_if = 0 and rownum = 1) tr_ccy,  " +
        "  (select e.pay_ccy from tfn_eppaytr e where e.tfn_eppaytrh_pk = t.pk and e.del_if = 0 and rownum = 1) pay_ccy,  " +
        "  (select p.partner_id from comm.tco_buspartner p,  tfn_eppaytr e where e.tfn_eppaytrh_pk = t.pk and e.del_if = 0 and  p.pk = e.tco_buspartner_pk and rownum=1 ) partner_id      " +
        "from tac_hgtrd a, tac_hgtrd_ref b, tac_hgtrh c, tfn_eppaytrh t   " +
        "where t.tr_date between '" + p_sdt + "' and '" + p_edt + "'    " +
        "and t.del_if = 0 " +
        "and t.tr_status = '2'  " +
        "and t.pk = c.tr_table_pk " +
        "and c.tr_tablenm = 'TFN_EPPAYTRH'  " +
        "and c.del_if = 0 " +
        "and c.pk = a.tac_hgtrh_pk " +
        "and a.del_if = 0     " +
        "and a.pk = b.tac_hgtrd_pk " +
        "and b.del_if = 0 " +
        "and a.drcr_type = 'D' " +
        "and exists (select 'X' from tfn_eppaytr e where e.tfn_eppaytrh_pk = t.pk and e.del_if = 0 and e.tac_bfdepomt_pk like '" + p_bankpk + "' )   " +
        "union all  " +
        "select  b.tac_hgtrh_pk seq, c.voucherno, c.voucherno_app, a.buspartner_lnm, a.remark2,    " +
        "( select d.pl_cd from v_abplcenter d    " +
        "    where d.tac_abplcenter_pk = a.tac_abplcenter_pk ) pl_code, '' ac_dr,  " +
        "  sf_a_get_accd(a.tac_abacctcode_pk, '" + p_compk + "') ac_cr,    " +
        "  0 tr_amt, 0 tr_bookamt,  " +
        "  (select e.tr_ccy from tfn_eppaytr e where e.tfn_eppaytrh_pk = t.pk and e.del_if = 0 and rownum = 1) tr_ccy,  " +
        "  (select e.pay_ccy from tfn_eppaytr e where e.tfn_eppaytrh_pk = t.pk and e.del_if = 0 and rownum = 1) pay_ccy,  " +
        "  (select p.partner_id from comm.tco_buspartner p,  tfn_eppaytr e where e.tfn_eppaytrh_pk = t.pk and e.del_if = 0 and  p.pk = e.tco_buspartner_pk and rownum=1 ) partner_id      " +
        "from tac_hgtrd a, tac_hgtrd_ref b, tac_hgtrh c, tfn_eppaytrh t   " +
        "where t.tr_date between '" + p_sdt + "' and '" + p_edt + "'    " +
        "and t.del_if = 0 " +
        "and t.tr_status = '2'  " +
        "and t.pk = c.tr_table_pk " +
        "and c.tr_tablenm = 'TFN_EPPAYTRH'  " +
        "and c.del_if = 0 " +
        "and c.pk = a.tac_hgtrh_pk " +
        "and a.del_if = 0     " +
        "and a.pk = b.tac_hgtrd_pk " +
        "and b.del_if = 0 " +
        "and a.drcr_type = 'C' " +
        "and exists (select 'X' from tfn_eppaytr e where e.tfn_eppaytrh_pk = t.pk and e.del_if = 0 and e.tac_bfdepomt_pk like '" + p_bankpk + "' )   " +
        ") tb  " +
        "group by tb.seq, tb.voucherno, tb.voucherno_app  " +
        "order by partner_id, tb.voucherno " ;
    //Response.Write(SQL);
    //Response.End();
	rs = ESysLib.TableReadOpen(SQL);
	if(rs.Rows.Count == 0)
	{
		Response.Write("No data found");
		Response.End();
	}		
    SQL = " SELECT PARTNER_LNAME, ADDR2, TAX_CODE  FROM TCO_COMPANY WHERE PK = '" + p_compk + "' ";
	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	string p_cmp_name = "", p_cmp_add = "", p_cmp_taxcode = "";
	if (dt1.Rows.Count >0)
	{
		p_cmp_name      = dt1.Rows[0][0].ToString();
		p_cmp_add       = dt1.Rows[0][1].ToString();
		p_cmp_taxcode   = dt1.Rows[0][2].ToString();
	}
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Page_files/filelist.xml">
<link rel=Edit-Time-Data href="Page_files/editdata.mso">
<link rel=OLE-Object-Data href="Page_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>PCPro</o:Author>
  <o:LastAuthor>Poslilama server</o:LastAuthor>
  <o:LastPrinted>2008-05-24T02:41:18Z</o:LastPrinted>
  <o:Created>2008-04-24T03:54:58Z</o:Created>
  <o:LastSaved>2010-02-06T08:40:52Z</o:LastSaved>
  <o:Company>PCPro., LTD..</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.25in 0in 0in .25in;
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
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;}
.xl84
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl86
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl88
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl90
	{mso-style-parent:style16;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl91
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl92
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl93
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl94
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl95
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl97
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl98
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl100
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl101
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl107
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl122
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl123
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl124
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl125
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl126
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl127
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl128
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl129
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl130
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl131
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl132
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl133
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl134
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl135
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl136
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl137
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl138
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl139
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl140
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl141
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl142
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl143
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl144
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl145
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl146
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl147
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl148
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";	
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
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
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>3</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
       <x:RangeSelection>$J$15:$K$15</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8610</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1875</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$13:$14</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
<meta http-equiv=Expires content="Mon,06 Jan 1990 00:00:01 GMT">
</head>
<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1077 style='border-collapse:
 collapse;table-layout:fixed;width:809pt'>
 <col class=xl25 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl25 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl25 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl25 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=155 style='mso-width-source:userset;mso-width-alt:5668;
 width:116pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl24 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl24 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl24 width=40 span=10 style='mso-width-source:userset;mso-width-alt:
 1462;width:30pt'>
 <col class=xl24 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <tr class=xl25 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl26 width=19 style='height:24.95pt;width:14pt'>&nbsp;</td>
  <td class=xl26 width=56 style='width:42pt'>&nbsp;</td>
  <td class=xl26 width=96 style='width:72pt'>&nbsp;</td>
  <td class=xl26 width=66 style='width:50pt'>&nbsp;</td>
  <td class=xl26 width=155 style='width:116pt'>&nbsp;</td>
  <td class=xl26 width=94 style='width:71pt'>&nbsp;</td>
  <td class=xl26 width=52 style='width:39pt'>&nbsp;</td>
  <td class=xl26 width=46 style='width:35pt'>&nbsp;</td>
  <td class=xl26 width=74 style='width:56pt'>&nbsp;</td>
  <td colspan=6 class=xl45 width=240 style='width:180pt'>Voucher Approval No :</td>
  <td colspan=5 class=xl46 width=179 style='width:134pt'
  x:str="                                               "><span
  style='mso-spacerun:yes'>                                               </span></td>
 </tr>
 <tr class=xl25 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl27 style='height:24.95pt;border-top:none'>&nbsp;</td>
  <td colspan=18 class=xl47>ACCOUNTING SLIP/PHIẾU KẾ TOÁN</td>
  <td class=xl28>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl29 style='height:30.0pt'>&nbsp;</td>
  <td colspan=4 rowspan=3 class=xl48 width=373 style='border-bottom:.5pt solid black;
  width:280pt'>Transaction Approval/ <br>
    Ký duyệt</td>
  <td colspan=2 class=xl54 width=146 style='border-right:.5pt solid black;
  width:110pt'>Date/ <br>
    Ngày</td>
  <td colspan=2 class=xl56 width=120 style='border-right:.5pt solid black;
  border-left:none;width:91pt'>Charger/<br>
    Người lập</td>
  <td colspan=3 class=xl56 width=120 style='border-right:.5pt solid black;
  border-left:none;width:90pt'>Check/<br>
    Người kiểm</td>
  <td colspan=3 class=xl56 width=120 style='border-right:.5pt solid black;
  border-left:none;width:90pt'>Chief Acc./ <br>
    Kế toán trưởng</td>
  <td colspan=2 class=xl56 width=80 style='border-right:.5pt solid black;
  border-left:none;width:60pt'>Manager/ <br>
    Trưởng phòng</td>
  <td colspan=2 class=xl56 width=80 style='border-right:.5pt solid black;
  border-left:none;width:60pt'>Director/<br>
    Giám đốc</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 style='height:18.0pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl57 width=146 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:110pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl57 width=120 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:91pt'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl57 width=120 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:90pt'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl57 width=120 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:90pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl63 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl63 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl29 style='height:18.0pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl29 style='height:8.1pt'>&nbsp;</td>
  <td colspan=18 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl29 style='height:17.1pt'>&nbsp;</td>
  <td colspan=2 class=xl67 style='border-right:.5pt solid black'>Company/ Tên
  công ty:</td>
  <td colspan=5 class=xl69 width=413 style='border-right:.5pt solid black;
  border-left:none;width:311pt'><%=p_cmp_name%></td>
  <td colspan=5 class=xl73 width=234 style='border-right:.5pt solid black;
  border-left:none;width:176pt'>Date/ ngày:</td>
  <td colspan=6 class=xl76 style='border-right:.5pt solid black;border-left:
  none'><%=p_edt.Substring(6,2) + "/" + p_edt.Substring(4,2) + "/" + p_edt.Substring(0,4)%></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=9 style='mso-height-source:userset;height:6.95pt'>
  <td height=9 class=xl29 style='height:6.95pt'>&nbsp;</td>
  <td colspan=18 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl31 style='height:17.1pt'>&nbsp;</td>
  <td colspan=2 class=xl78 width=152 style='border-right:.5pt solid black;
  width:114pt'>Proposed By/Người lập</td>
  <td colspan=2 class=xl80 style='border-right:.5pt solid black;border-left:
  none'><%=l_crt_by %></td>
  <td colspan=3 class=xl83 style='border-right:.5pt solid black;border-left:
  none'>Exchange Rate/ Tỷ giá</td>
  <td colspan=2 class=xl85 width=114 style='border-right:.5pt solid black;
  border-left:none;width:86pt' x:num><%=l_ex_rate%></td>
  <td colspan=5 class=xl78 width=200 style='border-right:.5pt solid black;
  border-left:none;width:150pt'>Bank code/Ngân hàng</td>
  <td colspan=4 class=xl89 style='border-right:.5pt solid black;border-left:
  none'><%=l_bank_id%></td>
  <td class=xl28>&nbsp;</td>
 </tr>
 <tr class=xl25 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl31 style='height:17.1pt'>&nbsp;</td>
  <td colspan=2 class=xl91 style='border-right:.5pt solid black'>Approved
  Date/Ngày duyệt</td>
  <td colspan=2 class=xl94 style='border-right:.5pt solid black;border-left:
  none'><%=p_edt.Substring(6,2) + "/" + p_edt.Substring(4,2) + "/" + p_edt.Substring(0,4)%></td>
  <td colspan=3 class=xl96 style='border-right:.5pt solid black;border-left:
  none'>Approved By/Người duyệt</td>
  <td colspan=2 class=xl94 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=5 class=xl94 style='border-right:.5pt solid black;border-left:
  none'>Bank Name/Tên ngân hàng</td>
  <td colspan=4 class=xl94 style='border-right:.5pt solid black;border-left:
  none'><%=l_bank_nm%></td>
  <td class=xl28>&nbsp;</td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:8.1pt'>
  <td height=10 class=xl29 style='height:8.1pt'>&nbsp;</td>
  <td colspan=18 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl29 style='height:14.25pt'>&nbsp;</td>
  <td colspan=18 class=xl99 style='border-right:.5pt solid black'>TRANSACTION
  DETAILS/ CHI TIẾT</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl29 style='height:12.75pt'>&nbsp;</td>
  <td rowspan=2 class=xl102 style='border-bottom:.5pt solid black;border-top:
  none'>Seq</td>
  <td rowspan=2 class=xl104 style='border-bottom:.5pt solid black;border-top:
  none'>Voucher No</td>
  <td rowspan=2 class=xl147 width=66 style='border-bottom:.5pt solid black;
  border-top:none;width:50pt'>Approval <br>
    Number</td>
  <td rowspan=2 class=xl107 width=155 style='border-bottom:.5pt solid black;
  border-top:none;width:116pt'>Supplier / Nhà cung cấp</td>
  <td colspan=3 rowspan=2 class=xl109 width=192 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:145pt'>Description / Diễn giải</td>
  <td rowspan=2 class=xl107 width=74 style='border-bottom:.5pt solid black;
  border-top:none;width:56pt'>Project Code</td>
  <td colspan=4 class=xl69 width=160 style='border-right:.5pt solid black;
  border-left:none;width:120pt'>Account code / TK</td>
  <td colspan=6 class=xl69 width=240 style='border-right:.5pt solid black;
  border-left:none;width:180pt'>Amount / Số Tiền</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl29 style='height:26.25pt'>&nbsp;</td>
  <td colspan=2 class=xl69 width=80 style='border-right:.5pt solid black;
  border-left:none;width:60pt'>Debit/ Nợ</td>
  <td colspan=2 class=xl69 width=80 style='border-right:.5pt solid black;
  border-left:none;width:60pt' x:str>Credit/ Có<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl69 width=120 style='border-right:.5pt solid black;
  border-left:none;width:90pt'>Transaction /Hạch toán</td>
  <td colspan=3 class=xl117 width=120 style='border-right:.5pt solid black;
  border-left:none;width:90pt'><span style='mso-spacerun:yes'> </span>Book /
  Ghi sổ</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <%
	decimal l_tot_book = 0, l_tot_trans = 0;
	
	for(i = 0; i < rs.Rows.Count; i++)
	{
		if(rs.Rows[i][9].ToString() != "")
		{
			l_tot_book += decimal.Parse(rs.Rows[i][9].ToString());
		}
		if(rs.Rows[i][8].ToString() != "")
		{
			l_tot_trans += decimal.Parse(rs.Rows[i][8].ToString());
		}
		
 %>
 <tr height=90 style='mso-height-source:userset;height:67.5pt'>
  <td height=90 class=xl32 style='height:67.5pt'>&nbsp;</td>
  <td class=xl33 style='border-top:none' x:num><%=rs.Rows[i][0] %></td>
  <td class=xl33 style='border-top:none'><%=rs.Rows[i][1] %></td>
  <td class=xl34><%=rs.Rows[i][2] %></td>
  <td class=xl35 width=155 style='border-top:none;width:116pt'><%=rs.Rows[i][3] %></td>
  <td colspan=3 class=xl118 width=192 style='border-right:.5pt solid black;
  border-left:none;width:145pt'><%=rs.Rows[i][4]%></td>
  <td class=xl36 width=74 style='width:56pt'><%=rs.Rows[i][5] %></td>
  <td colspan=2 class=xl121 style='border-right:.5pt solid black;border-left:
  none' x:str><%=rs.Rows[i][6]%></td>
  <td colspan=2 class=xl123 style='border-right:.5pt solid black;border-left:
  none' x:str><%=rs.Rows[i][7] %></td>
  <% if(rs.Rows[i][10].ToString() == "VND") { %>
  <td colspan=3 class=xl148 style='border-right:.5pt solid black;border-left:
  none' x:num><%=rs.Rows[i][8] %></td>
  <% } else { %>
  <td colspan=3 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=rs.Rows[i][8] %></td>
<% } %>  
  <td colspan=3 class=xl124 style='border-right:.5pt solid black;border-left:
  none' x:num><%=rs.Rows[i][9] %></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <%
	}
 %>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl39 style='height:20.1pt'>&nbsp;</td>
  <td colspan=8 class=xl130 style='border-right:.5pt solid black'>Total/ Tổng
  cộng</td>
  <td colspan=2 class=xl133 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl135 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl127 style='border-right:.5pt solid black;border-left:
  none' x:str=" "><span style='mso-spacerun:yes'>   </span></td>
  <td colspan=3 class=xl127 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'> </span><%=l_tot_book%></td>
  <td class=xl28>&nbsp;</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl40 style='height:14.1pt'>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=20 class=xl24 style='height:9.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=7 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl136 style='border-right:.5pt solid black'>Trans
  Currency</td>
  <td colspan=5 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>Debit</td>
  <td colspan=3 class=xl140 style='border-right:.5pt solid black;border-left:
  none'>Credit</td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=7 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl136 style='border-right:.5pt solid black'><%=l_ccy_bank%></td>
  <td colspan=5 class=xl142 style='border-right:.5pt solid black;border-left:
  none' x:num><%=l_tot_trans%></td>
  <td colspan=3 class=xl145 style='border-right:.5pt solid black;border-left:
  none' x:num><%=l_tot_book%></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 colspan=7 class=xl25 style='height:9.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl44 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=19 style='width:14pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=155 style='width:116pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=19 style='width:14pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
