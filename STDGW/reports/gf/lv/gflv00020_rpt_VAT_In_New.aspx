<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("acnt");%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    
    string p_com = "" + Request["compk"];
    string p_month = "" + Request["month"];
    string p_status = "" + Request["status"];
    string p_vat_rate = "" + Request["vat_rate"];
    string p_ccy = "" + Request["ccy"];
    string p_cust_pk = "" + Request["cust_pk"];
    string p_acc_pk = "" + Request["acc_pk"];
    string month = p_month.Substring(4,2);
    string year = p_month.Substring(0,4);
    string lname ="";
    string name ="";
    string tax_code ="";
    string address ="";
    string seri ="";
    string invoice_no = "";
	 string l_invoiceno = "" + Request["invoiceno"];
	 string l_ac_cd = "" + Request["ac_cd"];
	 string p_tac_hgtrh_pk = "" + Request["txtSeq"];
	 string p_voucherno  = "" + Request["voucherno"];
	 string p_BalType  = "" + Request["BalType"];
	 string p_dtfr  = "" + Request["p_dtfr"];
	 string p_dtto  = "" + Request["p_dtto"];
	 string p_voucher_type  = "" + Request["voucher_type"];
	 
    string invoice_dt = "";
    string invoice_date="";
    string cust_name = "";
    string cust_tax = "";
    string cust_addr ="";
    string item = "";
    string tax_rate ="";
    string    net_amt = "";
    string    vat_amt = "";
    string vat_note = "";
    string    seq = "";
    string voucher ="";
    double    stt0 = 0;
    double stt5 = 0;
    double stt10 = 0;
    double sttnone = 0;
    double net_none = 0;
    double net_0 = 0;
    double net_5 = 0;
    double net_10 = 0;
    double vat_0 = 0;
    double vat_5 = 0;
    double vat_10 = 0;
    double vat_sum = 0;
    double net_sum = 0;
    double sttsub = 0;
    double net_sub = 0;
    double vat_sub = 0;
    
    string SQL = " SELECT pk, partner_name, partner_lname, addr1 ||addr2||addr3 address, tax_code ";
    SQL += "  FROM tco_company ";
    SQL += " WHERE del_if = 0 AND pk = '" + p_com + "'";
    DataTable dtCom = ESysLib.TableReadOpen(SQL);
    if (dtCom.Rows.Count >0)
    {
		name  = dtCom.Rows[0][1].ToString();
		lname = dtCom.Rows[0][2].ToString();
		address = dtCom.Rows[0][3].ToString();
		tax_code = dtCom.Rows[0][4].ToString();
	}
	
	string SQLD = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQLD += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, (select partner_lname from tco_buspartner where pk = a.tco_buspartner_pk) buspartner_lnm, ";
    SQLD += "         a.tax_code, a.address, a.tco_ciitem_nm, a.ccy, nvl(a.net_amt,0) net_amt,nvl(a.tax_amt,0) tax_amt, ";
    SQLD += "         a.tax_amt, h.VOUCHERNO_APP ,a.VAT_NOTE ";
    SQLD += "    FROM tac_mtvat a, tac_hgtrd d , tac_hgtrh h";
    SQLD += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0";
    SQLD += "     AND a.tac_hgtrd_pk = d.pk ";
    SQLD += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','"+ p_acc_pk +"')";
    SQLD += "     AND d.tac_hgtrh_pk = h.pk ";
    SQLD += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQLD += "     AND a.std_ym = '"+ p_month +"' ";
    SQLD += "     AND a.vat_type = '1' ";
    SQLD += "     AND a.tax_rate = 'none' ";
    SQLD += "     AND a.tr_status IN ('" + p_status + "') ";
    SQLD += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQLD += "ORDER BY (SELECT substr(acnt.F_COMMONCODE_ORD('EACBK041','',''), 1,length(acnt.F_COMMONCODE_ORD('EACBK041','',''))-1) FROM DUAL)";
	
	string l_parameter = "'" + p_com + "','" + p_month + "','1','none','"+p_ccy+"','" + p_status + "','"+p_cust_pk+"','"+l_invoiceno+"','"+l_ac_cd+"','"+p_tac_hgtrh_pk+"','"+p_voucherno+"','"+p_BalType+"','"+p_dtfr+"','"+p_dtto+"','"+p_voucher_type+"'";
    //DataTable dt_none = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);

    //DataTable dt_none = ESysLib.TableReadOpen(SQLD);
    
    string SQL0 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL0 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, (select partner_lname from tco_buspartner where pk = a.tco_buspartner_pk) buspartner_lnm, ";
    SQL0 += "         a.tax_code, a.address, a.tco_ciitem_nm, a.ccy, a.tax_rate, nvl(a.net_amt,0) net_amt, ";
    SQL0 += "         nvl(a.tax_amt,0) tax_amt, h.VOUCHERNO_APP ,a.VAT_NOTE";
    SQL0 += "    FROM tac_mtvat a, tac_hgtrd d, tac_hgtrh h ";
    SQL0 += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if= 0";
    SQL0 += "     AND a.tac_hgtrd_pk = d.pk ";
    SQL0 += "     AND d.tac_hgtrh_pk = h.pk ";
    SQL0 += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQL0 += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQL0 += "     AND a.std_ym = '"+ p_month +"' ";
    SQL0 += "     AND a.vat_type = '1' ";
    SQL0 += "     AND a.tax_rate in ('0%') ";
    SQL0 += "     AND a.tr_status IN ('" + p_status + "') ";
    SQL0 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL0 += "ORDER BY (SELECT substr(acnt.F_COMMONCODE_ORD('EACBK041','',''), 1,length(acnt.F_COMMONCODE_ORD('EACBK041','',''))-1) FROM DUAL) ";
    //Response.Write(SQL0);
    //Response.End();
	l_parameter = "'" + p_com + "','" + p_month + "','1','0%','"+p_ccy+"','" + p_status + "','"+p_cust_pk+"','"+l_invoiceno+"','"+l_ac_cd+"','"+p_tac_hgtrh_pk+"','"+p_voucherno+"','"+p_BalType+"','"+p_dtfr+"','"+p_dtto+"','"+p_voucher_type+"'";
	//DataTable dt_0 = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);	
   // DataTable dt_0 = ESysLib.TableReadOpen(SQL0);
    
    string SQL5 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL5 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, (select partner_lname from tco_buspartner where pk = a.tco_buspartner_pk) buspartner_lnm, ";
    SQL5 += "         a.tax_code, a.address, a.tco_ciitem_nm, a.ccy, a.tax_rate,  ";
    SQL5 += "         nvl(a.net_amt,0) net_amt,nvl(a.tax_amt,0) tax_amt, h.VOUCHERNO_APP ,a.VAT_NOTE";
    SQL5 += "    FROM tac_mtvat a, tac_hgtrd d, tac_hgtrh h ";
    SQL5 += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0";
    SQL5 += "     AND a.tac_hgtrd_pk = d.pk ";
    SQL5 += "     AND d.tac_hgtrh_pk = h.pk ";
    SQL5 += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQL5 += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQL5 += "     AND a.std_ym = '"+ p_month +"' ";
    SQL5 += "     AND a.vat_type = '1' ";
    SQL5 += "     AND a.tax_rate like '%'||'5%' ";
    SQL5 += "     AND a.tr_status IN ('" + p_status + "') ";
    SQL5 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL5 += "ORDER BY (SELECT substr(acnt.F_COMMONCODE_ORD('EACBK041','',''), 1,length(acnt.F_COMMONCODE_ORD('EACBK041','',''))-1) FROM DUAL) ";
    
    l_parameter = "'" + p_com + "','" + p_month + "','1','5%','"+p_ccy+"','" + p_status + "','"+p_cust_pk+"','"+l_invoiceno+"','"+l_ac_cd+"','"+p_tac_hgtrh_pk+"','"+p_voucherno+"','"+p_BalType+"','"+p_dtfr+"','"+p_dtto+"','"+p_voucher_type+"'";
	//DataTable dt_5 = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);	
    //DataTable dt_5 = ESysLib.TableReadOpen(SQL5);
    //  Response.Write(l_parameter);
    //Response.End();
    string SQL10 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL10 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, (select partner_lname from tco_buspartner where pk = a.tco_buspartner_pk) buspartner_lnm, ";
    SQL10 += "         a.tax_code, a.address, a.tco_ciitem_nm, a.ccy, a.tax_rate, ";
    SQL10 += "         nvl(a.net_amt,0) net_amt,nvl(a.tax_amt,0) tax_amt, h.VOUCHERNO_APP ,a.VAT_NOTE";
    SQL10 += "    FROM tac_mtvat a, tac_hgtrd d , tac_hgtrh h";
    SQL10 += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0";
    SQL10 += "     AND a.tac_hgtrd_pk = d.pk ";
    SQL10 += "     AND d.tac_hgtrh_pk = h.pk ";
    SQL10 += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQL10 += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQL10 += "     AND a.std_ym = '"+ p_month +"' ";
    SQL10 += "     AND a.vat_type = '1' ";
    SQL10 += "     AND a.tax_rate like '%' || '10%' ";
    SQL10 += "     AND a.tr_status IN ('" + p_status + "') ";
    SQL10 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL10 += "ORDER BY (SELECT substr(acnt.F_COMMONCODE_ORD('EACBK041','',''), 1,length(acnt.F_COMMONCODE_ORD('EACBK041','',''))-1) FROM DUAL) ";
    //DataTable dt_10 = ESysLib.TableReadOpen(SQL10);
	
	 l_parameter = "'" + p_com + "','" + p_month + "','1','ALL','"+p_ccy+"','" + p_status + "','"+p_cust_pk+"','"+l_invoiceno+"','"+l_ac_cd+"','"+p_tac_hgtrh_pk+"','"+p_voucherno+"','"+p_BalType+"','"+p_dtfr+"','"+p_dtto+"','"+p_voucher_type+"'";
	DataTable dt_10 = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);

    string SQLsub = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL10 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, (select partner_lname from tco_buspartner where pk = a.tco_buspartner_pk) buspartner_lnm, ";
    SQL10 += "         a.tax_code, a.address, a.tco_ciitem_nm, a.ccy, a.tax_rate, ";
    SQL10 += "         nvl(a.net_amt,0) net_amt,nvl(a.tax_amt,0) tax_amt, h.VOUCHERNO_APP ,a.VAT_NOTE";
    SQL10 += "    FROM tac_mtvat a, tac_hgtrd d , tac_hgtrh h";
    SQL10 += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0";
    SQL10 += "     AND a.tac_hgtrd_pk = d.pk ";
    SQL10 += "     AND d.tac_hgtrh_pk = h.pk ";
    SQL10 += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQL10 += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQL10 += "     AND a.std_ym = '" + p_month + "' ";
    SQL10 += "     AND a.vat_type = '1' ";
    SQL10 += "     AND a.tax_rate like '-' ";
    SQL10 += "     AND a.tr_status IN ('" + p_status + "') ";
    SQL10 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL10 += "ORDER BY a.invoice_date, a.invoice_no ";
    //DataTable dt_10 = ESysLib.TableReadOpen(SQL10);

    l_parameter = "'" + p_com + "','" + p_month + "','1','-%','" + p_ccy + "','" + p_status + "','" + p_cust_pk + "','" + l_invoiceno + "','" + l_ac_cd + "','" + p_tac_hgtrh_pk + "','" + p_voucherno + "','" + p_BalType + "','" + p_dtfr + "','" + p_dtto + "','" + p_voucher_type + "'";
    //DataTable dt_sub = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);	
   
    //Response.Write(l_parameter);
    //Response.End();
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Page_VAT_In_files/filelist.xml">
<style id="BẢNG KÊ HÓA ĐƠN, CHỨNG TỪ HÀNG HÓA DICH VỤ BÁN RA_11410_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font511410
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font611410
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font711410
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1511410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2411410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2511410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2611410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2711410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl2811410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2911410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3011410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3111410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3211410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3311410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3411410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3511410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3611410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3711410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl3811410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl3911410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4011410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4111410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4211410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl4311410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4411410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4511410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4611410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4711410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4811410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4911410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5011410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5111410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5211410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5311410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:justify;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5411410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl5511410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl5611410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5711410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5811410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5911410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6011410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6111410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6211410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6311410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6411410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6511410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6611410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6711410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6811410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl6911410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7011410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7111410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7211410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7311410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7411410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7511410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl7611410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7711410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7811410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7911410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:18.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8011410
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
-->
</style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="BẢNG KÊ HÓA ĐƠN, CHỨNG TỪ HÀNG HÓA DICH VỤ BÁN RA_11410" align=center
x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1093 style='border-collapse:
 collapse;table-layout:fixed;width:821pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1408;width:25pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2858;width:50pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2986;width:53pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3968;width:70pt'>
 <col width=174 style='mso-width-source:userset;mso-width-alt:7424;width:131pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3754;width:66pt'>
 <col width=187 style='mso-width-source:userset;mso-width-alt:7978;width:140pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:4266;width:75pt'>
 <col width=44 style='mso-width-source:userset;mso-width-alt:1877;width:33pt'>
 <col width=87 style='mso-width-source:userset;mso-width-alt:3712;width:65pt'>
 <col width=150 style='mso-width-source:userset;mso-width-alt:6400;width:113pt'>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl1511410 width=33 style='height:22.5pt;width:25pt'></td>
  <td class=xl1511410 width=67 style='width:50pt'></td>
  <td class=xl1511410 width=70 style='width:53pt'></td>
  <td class=xl1511410 width=93 style='width:70pt'></td>
  <td class=xl1511410 width=174 style='width:131pt'></td>
  <td class=xl1511410 width=88 style='width:66pt'></td>
  <td class=xl1511410 width=187 style='width:140pt'></td>
  <td class=xl1511410 width=100 style='width:75pt'></td>
  <td colspan=3 rowspan=4 class=xl6711410 width=281 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:211pt'>Mẫu số:01-2/GTGT<font
  class="font511410"><br>
    </font><font class="font711410">(Ban hành theo Thông tư số 28/2011/TT-BTC
  ngày 28/02/2011 của Bộ Tài Chính )</font></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl1511410 style='height:12.75pt'></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl1511410 style='height:12.75pt'></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl1511410 style='height:12.75pt'></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
  <td class=xl1511410></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=11 height=30 class=xl7611410 style='height:22.5pt'>BẢNG KÊ HÓA
  ĐƠN, CHỨNG TỪ HÀNG HÓA DICH VỤ MUA VÀO</td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=11 height=25 class=xl7711410 style='height:18.75pt'>(Kèm theo tờ
  khai thuế GTGT mẫu số 01/GTGT ngày ….. tháng ….. năm …..)</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=11 height=26 class=xl7811410 style='height:19.5pt'>[01] <font
  class="font611410">Kỳ tính thuế: tháng <%=month%> năm <%=year%> </font></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2511410 colspan=3>[02] Tên người nộp thuế:</td>
  <td class=xl2411410><%=lname%></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410 colspan=2>[03] Mã số thuế:</td>
  <td colspan=3 class=xl2611410><%=tax_code%></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2511410 colspan=3>[04] Tên đại lý thuế (nếu có):</td>
  <td class=xl2511410></td>
  <td class=xl2511410></td>
  <td class=xl2511410></td>
  <td class=xl2511410></td>
  <td class=xl2511410></td>
  <td class=xl2511410></td>
  <td class=xl2511410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410 colspan=2>[05] Mã số thuế</td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td colspan=4 class=xl6311410>Đơn vị tiền<span style='mso-spacerun:yes'> 
  </span>:<span style='mso-spacerun:yes'>  </span>đồng Việt nam</td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td rowspan=2 height=68 class=xl6111410 width=33 style='border-bottom:.5pt solid black;
  height:51.0pt;width:25pt'>STT</td>
  <td colspan=3 class=xl6411410 width=230 style='border-right:.5pt solid black;
  border-left:none;width:173pt'>Hóa đơn, chứng từ, biên lai nộp thuế</td>
  <td rowspan=2 class=xl6111410 width=174 style='border-bottom:.5pt solid black;
  width:131pt'>Tên người bán</td>
  <td rowspan=2 class=xl6111410 width=88 style='border-bottom:.5pt solid black;
  width:66pt'>Mã số thuế người bán</td>
  <td rowspan=2 class=xl6111410 width=187 style='border-bottom:.5pt solid black;
  width:140pt'>Mặt hàng</td>
  <td rowspan=2 class=xl6111410 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Giá trị HHDV mua vào chưa có thuế</td>
  <td rowspan=2 class=xl6111410 width=44 style='border-bottom:.5pt solid black;
  width:33pt'>Thuế suất<br>
    (%)</td>
  <td rowspan=2 class=xl6111410 width=87 style='border-bottom:.5pt solid black;
  width:65pt'>Thuế GTGT</td>
  <td rowspan=2 class=xl6111410 width=150 style='border-bottom:.5pt solid black;
  width:113pt'>Ghi chú hoặc thời hạn thanh toán trả chậm</td>
 </tr>
 <tr class=xl2411410 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl2711410 width=67 style='height:26.25pt;width:50pt'>Ký
  hiệu</td>
  <td class=xl2711410 width=70 style='width:53pt'>Số</td>
  <td class=xl2711410 width=93 style='width:70pt'>Ngày, tháng, năm phát hành</td>
 </tr>
 <tr class=xl2411410 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2811410 style='height:15.0pt'>(1)</td>
  <td class=xl2811410 style='border-left:none'>(2)</td>
  <td class=xl2811410 style='border-left:none'>(3)</td>
  <td class=xl2811410 style='border-left:none'>(4)</td>
  <td class=xl2811410 style='border-left:none'>(5)</td>
  <td class=xl2811410 style='border-left:none'>(6)</td>
  <td class=xl2811410 style='border-left:none'>(7)</td>
  <td class=xl2811410 style='border-left:none'>(8)</td>
  <td class=xl2811410 style='border-left:none'>(9)</td>
  <td class=xl2811410 style='border-left:none'>(10)</td>
  <td class=xl2811410 style='border-left:none'>(11)</td>
 </tr>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl2911410 colspan=5 style='height:17.25pt'>1.Hàng hóa,
  dịch vụ dùng riêng cho SXKD chịu thuế GTGT đủ điề<span style='display:none'>u
  kiện khấu trừ thuế:</span></td>
  <td class=xl3111410>&nbsp;</td>
  <td class=xl3111410>&nbsp;</td>
  <td class=xl3111410>&nbsp;</td>
  <td class=xl3111410>&nbsp;</td>
  <td class=xl3111410>&nbsp;</td>
  <td class=xl3211410>&nbsp;</td>
 </tr>
  <%
      //none VAT
      /*if (dt_0.Rows.Count > 0)
      {
          for (int i = 0; i < dt_0.Rows.Count; i++)
          {
              stt0 += 1;
              seq = dt_0.Rows[i][0].ToString();
              seri = dt_0.Rows[i][4].ToString();
              invoice_dt = dt_0.Rows[i][5].ToString();
              if (invoice_dt != "")
              {
                  invoice_date = invoice_dt.Substring(6, 2) + "/" + invoice_dt.Substring(4, 2) + "/" + invoice_dt.Substring(0, 4);
              }
              invoice_no = dt_0.Rows[i][6].ToString();
              cust_name = dt_0.Rows[i][8].ToString();
              cust_tax = dt_0.Rows[i][9].ToString();
              cust_addr = dt_0.Rows[i][10].ToString();
              item = dt_0.Rows[i][11].ToString();
              tax_rate = dt_0.Rows[i][13].ToString();
              net_amt = dt_0.Rows[i][14].ToString();
              vat_amt = dt_0.Rows[i][15].ToString();
              voucher = dt_0.Rows[i][16].ToString();
              vat_note = dt_0.Rows[i][17].ToString();
              if (!net_amt.Equals(""))
              {
                  net_sum += double.Parse(net_amt);
                  net_0 += double.Parse(net_amt);
              }
              if (!vat_amt.Equals(""))
              {
                  vat_0 += double.Parse(vat_amt);
                  vat_sum += double.Parse(vat_amt);
              }


      }
      }
        //5%
      if (dt_5.Rows.Count > 0)
      {
          for (int i = 0; i < dt_5.Rows.Count; i++)
          {
              stt5 += 1;
              seq = dt_5.Rows[i][0].ToString();
              seri = dt_5.Rows[i][4].ToString();
              invoice_dt = dt_5.Rows[i][5].ToString();
              if (invoice_dt != "")
              {
                  invoice_date = invoice_dt.Substring(6, 2) + "/" + invoice_dt.Substring(4, 2) + "/" + invoice_dt.Substring(0, 4);
              }
              invoice_no = dt_5.Rows[i][6].ToString();
              cust_name = dt_5.Rows[i][8].ToString();
              cust_tax = dt_5.Rows[i][9].ToString();
              cust_addr = dt_5.Rows[i][10].ToString();
              item = dt_5.Rows[i][11].ToString();
              tax_rate = dt_5.Rows[i][13].ToString();
              net_amt = dt_5.Rows[i][14].ToString();
              vat_amt = dt_5.Rows[i][15].ToString();
              voucher = dt_5.Rows[i][16].ToString();
              vat_note = dt_5.Rows[i][17].ToString();
              if (!net_amt.Equals(""))
              {
                  net_5 += double.Parse(net_amt);
                  net_sum += double.Parse(net_amt);
              }
              if (!vat_amt.Equals(""))
              {
                  vat_5 += double.Parse(vat_amt);
                  vat_sum += double.Parse(vat_amt);
              } 
        
 
     }
      }
      */
    // ALL
      if (dt_10.Rows.Count > 0)
      {
          for (int i = 0; i < dt_10.Rows.Count; i++)
          {
              stt10 += 1;
              seq = dt_10.Rows[i][0].ToString();
              seri = dt_10.Rows[i][3].ToString();
              invoice_dt = dt_10.Rows[i][4].ToString();
              if (invoice_dt != "")
              {
                  invoice_date = invoice_dt.Substring(6, 2) + "/" + invoice_dt.Substring(4, 2) + "/" + invoice_dt.Substring(0, 4);
              }
              invoice_no = dt_10.Rows[i][5].ToString();
              cust_name = dt_10.Rows[i][7].ToString();
              cust_tax = dt_10.Rows[i][8].ToString();
              cust_addr = dt_10.Rows[i][9].ToString();
              item = dt_10.Rows[i][10].ToString();
              tax_rate = dt_10.Rows[i][12].ToString();
              net_amt = dt_10.Rows[i][13].ToString();
              vat_amt = dt_10.Rows[i][14].ToString();
              voucher = dt_10.Rows[i][15].ToString();
              vat_note = dt_10.Rows[i][16].ToString();
              if (!net_amt.Equals(""))
              {
                  net_10 += double.Parse(net_amt);
                  net_sum += double.Parse(net_amt);
              }
              if (!vat_amt.Equals(""))
              {
                  vat_10 += double.Parse(vat_amt);
                  vat_sum += double.Parse(vat_amt);
              }    
            
            %>
  <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl3711410 style='height:17.25pt'><%=stt10%></td>
  <td class=xl3811410><%=seri%></td>
  <td class=xl3811410><%=invoice_no%></td>
  <td class=xl3811410><%=invoice_date%></td>
  <td class=xl3811410><%=cust_name%></td>
  <td class=xl3911410 style='border-top:none'><%=cust_tax%></td>
  <td class=xl3911410 style='border-top:none'><%=item%></td>
  <td class=xl4011410 style='border-top:none' x:num><%=net_amt%></td>
  <td class=xl4011410 style='border-top:none'><%=tax_rate%></td>
  <td class=xl4011410 style='border-top:none' x:num><%=vat_amt%></td>
  <td class=xl4011410 style='border-top:none'><%=voucher%> (<%=seq%>)(<%=vat_note%>)</td>
 </tr>
    <% 
    }
      }
    %>            
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl5611410 style='height:17.25pt'>Tổng</td>
  <td class=xl3311410>&nbsp;</td>
  <td class=xl3311410>&nbsp;</td>
  <td class=xl4211410 x:num><span style='mso-spacerun:yes'> </span><%=net_sum %> </td>
  <td class=xl4211410>&nbsp;</td>
  <td class=xl4211410 x:num><span style='mso-spacerun:yes'> </span><%=vat_sum %> </td>
  <td class=xl4211410>&nbsp;</td>
 </tr>
 <% 
     l_parameter = "'" + p_com + "','" + p_month + "','1','ALL','" + p_ccy + "','" + p_status + "','" + p_cust_pk + "','" + l_invoiceno + "','" + l_ac_cd + "','" + p_tac_hgtrh_pk + "','" + p_voucherno + "','" + p_BalType + "','" + p_dtfr + "','" + p_dtto + "','" + p_voucher_type + "'";
     DataTable dt_invalid = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_2", l_parameter);	
     
 %>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl2911410 colspan=5 style='height:17.25pt'>2.Hàng hóa,
  dịch vụ không đủ điều kiện khấu trừ thuế:</td>
  <td class=xl3111410>&nbsp;</td>
  <td class=xl3111410>&nbsp;</td>
  <td class=xl3111410>&nbsp;</td>
  <td class=xl3111410>&nbsp;</td>
  <td class=xl3111410>&nbsp;</td>
  <td class=xl3211410>&nbsp;</td>
 </tr>
 <% 
     int stt_invalid = 0 ;
     double net_invalid = 0, vat_invalid = 0;
     if (dt_invalid.Rows.Count > 0)
     {
         for (int i = 0; i < dt_invalid.Rows.Count; i++)
         {
             stt_invalid += 1;
             seq = dt_invalid.Rows[i][0].ToString();
             seri = dt_invalid.Rows[i][3].ToString();
             invoice_dt = dt_invalid.Rows[i][4].ToString();
             if (invoice_dt != "")
             {
                 invoice_date = invoice_dt.Substring(6, 2) + "/" + invoice_dt.Substring(4, 2) + "/" + invoice_dt.Substring(0, 4);
             }
             invoice_no = dt_invalid.Rows[i][5].ToString();
             cust_name = dt_invalid.Rows[i][7].ToString();
             cust_tax = dt_invalid.Rows[i][8].ToString();
             cust_addr = dt_invalid.Rows[i][9].ToString();
             item = dt_invalid.Rows[i][10].ToString();
             tax_rate = dt_invalid.Rows[i][12].ToString();
             net_amt = dt_invalid.Rows[i][13].ToString();
             vat_amt = dt_invalid.Rows[i][14].ToString();
             voucher = dt_invalid.Rows[i][15].ToString();
             vat_note = dt_invalid.Rows[i][16].ToString();
             if (!net_amt.Equals(""))
             {
                 net_invalid += double.Parse(net_amt);
                 net_sum += double.Parse(net_amt);
             }
             if (!vat_amt.Equals(""))
             {
                 vat_invalid += double.Parse(vat_amt);
                 vat_sum += double.Parse(vat_amt);
             }    
     
 %>
  <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl3711410 style='height:17.25pt'><%=stt10%></td>
  <td class=xl3811410><%=seri%></td>
  <td class=xl3811410><%=invoice_no%></td>
  <td class=xl3811410><%=invoice_date%></td>
  <td class=xl3811410><%=cust_name%></td>
  <td class=xl3911410 style='border-top:none'><%=cust_tax%></td>
  <td class=xl3911410 style='border-top:none'><%=item%></td>
  <td class=xl4011410 style='border-top:none' x:num><%=net_amt%></td>
  <td class=xl4011410 style='border-top:none'><%=tax_rate%></td>
  <td class=xl4011410 style='border-top:none' x:num><%=vat_amt%></td>
  <td class=xl4011410 style='border-top:none'><%=voucher%> (<%=seq%>)(<%=vat_note%>)</td>
<% 
        }
     }
%>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl5611410 style='height:17.25pt'>Tổng</td>
  <td class=xl3311410>&nbsp;</td>
  <td class=xl3311410>&nbsp;</td>
  <td class=xl3411410 x:num><span
  style='mso-spacerun:yes'>                     </span><%=net_invalid%> </td>
  <td class=xl3511410>&nbsp;</td>
  <td class=xl3511410 x:num><span
  style='mso-spacerun:yes'>                  </span><%=vat_invalid%> </td>
  <td class=xl3511410>&nbsp;</td>
 </tr>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl2911410 colspan=7 style='height:17.25pt'>3.Hàng hóa,
  dịch vụ dùng chung cho SXKD chịu thuế và không chịu thuế đủ điều kiện khấu
  trừ thuế:</td>
  <td class=xl3011410 style='border-top:none'>&nbsp;</td>
  <td class=xl3011410 style='border-top:none'>&nbsp;</td>
  <td class=xl3011410 style='border-top:none'>&nbsp;</td>
  <td class=xl3611410 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl3711410 style='height:17.25pt'></td>
  <td class=xl3811410></td>
  <td class=xl3811410></td>
  <td class=xl3811410></td>
  <td class=xl3811410><span style='display:none'>
  </span></td>
  <td class=xl3911410 style='border-top:none'></td>
  <td class=xl3911410 style='border-top:none'><span
  style='display:none'></span></td>
  <td class=xl4011410 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span> </td>
  <td class=xl4011410 style='border-top:none' x:str><span
  style='mso-spacerun:yes'> </span><span style='mso-spacerun:yes'> </span></td>
  <td class=xl4011410 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span> </td>
  <td class=xl4011410 style='border-top:none' x:str><span
  style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl5611410 style='height:17.25pt'>Tổng</td>
  <td class=xl3311410>&nbsp;</td>
  <td class=xl3311410>&nbsp;</td>
  <td class=xl4211410 x:num><span
  style='mso-spacerun:yes'> </span> </td>
  <td class=xl4211410>&nbsp;</td>
  <td class=xl4211410 x:num><span
  style='mso-spacerun:yes'> </span> </td>
  <td class=xl4211410>&nbsp;</td>
 </tr>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl4311410 colspan=6 style='height:17.25pt'>4.Hàng hóa,
  dịch vụ dùng cho dự án đầu tư đủ điều kiện khấu trừ thuế:</td>
  <td class=xl4411410 style='border-top:none'>&nbsp;</td>
  <td class=xl4411410 style='border-top:none'>&nbsp;</td>
  <td class=xl4411410 style='border-top:none'>&nbsp;</td>
  <td class=xl4411410 style='border-top:none'>&nbsp;</td>
  <td class=xl4511410 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl3711410 style='height:17.25pt'>&nbsp;</td>
  <td class=xl3811410>&nbsp;</td>
  <td class=xl3811410>&nbsp;</td>
  <td class=xl3811410>&nbsp;</td>
  <td class=xl3811410>&nbsp;</td>
  <td class=xl3911410>&nbsp;</td>
  <td class=xl3911410>&nbsp;</td>
  <td class=xl4011410>&nbsp;</td>
  <td class=xl4011410>&nbsp;</td>
  <td class=xl4011410>&nbsp;</td>
  <td class=xl4011410>&nbsp;</td>
 </tr>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl5611410 style='height:17.25pt'>Tổng</td>
  <td class=xl3311410>&nbsp;</td>
  <td class=xl3311410>&nbsp;</td>
  <td class=xl4211410 x:num><span style='mso-spacerun:yes'> </span> </td>
  <td class=xl4211410>&nbsp;</td>
  <td class=xl4211410 x:num><span style='mso-spacerun:yes'> </span> </td>
  <td class=xl4211410>&nbsp;</td>
 </tr>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=6 height=23 class=xl5811410 style='height:17.25pt'>5.Hàng hóa,
  dịch vụ không phải tổng hợp trên tờ khai 01/GTGT:</td>
  <td class=xl2411410></td>
  <td class=xl4611410></td>
  <td class=xl2411410></td>
  <td class=xl4611410></td>
  <td class=xl4711410>&nbsp;</td>
 </tr>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl3711410 style='height:17.25pt'>&nbsp;</td>
  <td class=xl3811410>&nbsp;</td>
  <td class=xl3811410>&nbsp;</td>
  <td class=xl3811410>&nbsp;</td>
  <td class=xl3811410>&nbsp;</td>
  <td class=xl3811410>&nbsp;</td>
  <td class=xl3811410>&nbsp;</td>
  <td class=xl4111410>&nbsp;</td>
  <td class=xl4111410>&nbsp;</td>
  <td class=xl4111410>&nbsp;</td>
  <td class=xl4111410>&nbsp;</td>
 </tr>
 <tr class=xl2411410 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl5611410 style='height:17.25pt'>Tổng</td>
  <td class=xl3311410>&nbsp;</td>
  <td class=xl3311410>&nbsp;</td>
  <td class=xl4211410>&nbsp;</td>
  <td class=xl4211410>&nbsp;</td>
  <td class=xl4211410>&nbsp;</td>
  <td class=xl4211410>&nbsp;</td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 colspan=4 style='height:15.0pt'>Tổng giá trị
  hàng hóa, dịch vụ mua vào (*):</td>
  <td class=xl4811410></td>
  <td class=xl4911410></td>
  <td class=xl2411410></td>
  <td class=xl5011410 x:num><span
  style='mso-spacerun:yes'> </span><%=net_sum %> </td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 colspan=5 style='height:15.0pt'>Tổng số thuế
  GTGT của hàng hóa, dịch vụ mua vào (**):</td>
  <td class=xl4911410></td>
  <td class=xl2411410></td>
  <td class=xl5011410 x:num><span
  style='mso-spacerun:yes'> </span><%=vat_sum %> </td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4911410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='page-break-before:always;height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410 colspan=6>Tôi cam đoan số liệu khai trên là đúng và chịu
  trách nhiệm trước pháp luật về những<span style='mso-spacerun:yes'> 
  </span>số liệu đã khai./.</td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td colspan=4 class=xl6011410 width=381 style='width:286pt'>Ngày …....tháng
  …....năm …....</td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl5111410 colspan=3>NHÂN VIÊN ĐẠI LÝ THUẾ</td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl5211410></td>
  <td colspan=4 class=xl5411410 width=381 style='width:286pt'
  x:str="NGƯỜI NỘP THUẾ hoặc ">NGƯỜI NỘP THUẾ hoặc<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2611410 colspan=3>Họ và tên:…………………….</td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td colspan=4 class=xl5411410 width=381 style='width:286pt'>ĐẠI DIỆN HỢP PHÁP
  CỦA NGƯỜI NỘP THUẾ</td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2611410 colspan=3>Chứng chỉ hành nghề số:..........</td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td colspan=4 class=xl5511410 width=381 style='width:286pt'>Ký, ghi rõ họ
  tên; chức vụ và đóng dấu (nếu có)</td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl5311410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
  <td class=xl4811410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <tr class=xl2411410 height=20 style='height:15.0pt'>
  <td height=20 class=xl2411410 style='height:15.0pt'></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
  <td class=xl2411410></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=33 style='width:25pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=187 style='width:140pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=150 style='width:113pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
