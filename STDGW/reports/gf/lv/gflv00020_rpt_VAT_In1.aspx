<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
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
    SQLD += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, a.buspartner_lnm, ";
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
    DataTable dt_none = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);

    //DataTable dt_none = ESysLib.TableReadOpen(SQLD);
    
    string SQL0 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL0 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, a.buspartner_lnm, ";
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
    SQL0 += "     AND a.tax_rate = '0%' ";
    SQL0 += "     AND a.tr_status IN ('" + p_status + "') ";
    SQL0 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL0 += "ORDER BY (SELECT substr(acnt.F_COMMONCODE_ORD('EACBK041','',''), 1,length(acnt.F_COMMONCODE_ORD('EACBK041','',''))-1) FROM DUAL) ";
    //Response.Write(SQL0);
    //Response.End();
	l_parameter = "'" + p_com + "','" + p_month + "','1','0%','"+p_ccy+"','" + p_status + "','"+p_cust_pk+"','"+l_invoiceno+"','"+l_ac_cd+"','"+p_tac_hgtrh_pk+"','"+p_voucherno+"','"+p_BalType+"','"+p_dtfr+"','"+p_dtto+"','"+p_voucher_type+"'";
	DataTable dt_0 = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);	
   // DataTable dt_0 = ESysLib.TableReadOpen(SQL0);
    
    string SQL5 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL5 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, a.buspartner_lnm, ";
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
	DataTable dt_5 = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);	
    //DataTable dt_5 = ESysLib.TableReadOpen(SQL5);
    //  Response.Write(l_parameter);
    //Response.End();
    string SQL10 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL10 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, a.buspartner_lnm, ";
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
	
	 l_parameter = "'" + p_com + "','" + p_month + "','1','10%','"+p_ccy+"','" + p_status + "','"+p_cust_pk+"','"+l_invoiceno+"','"+l_ac_cd+"','"+p_tac_hgtrh_pk+"','"+p_voucherno+"','"+p_BalType+"','"+p_dtfr+"','"+p_dtto+"','"+p_voucher_type+"'";
	DataTable dt_10 = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);

    string SQLsub = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL10 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, a.buspartner_lnm, ";
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
    DataTable dt_sub = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);	
   
    //Response.Write(l_parameter);
    //Response.End();
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gflv00020_rpt_VAT_In_files/filelist.xml">
<link rel=Edit-Time-Data href="gflv00020_rpt_VAT_In_files/editdata.mso">
<link rel=OLE-Object-Data href="gflv00020_rpt_VAT_In_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-08-04T10:09:50Z</o:LastPrinted>
  <o:Created>2008-08-04T09:01:52Z</o:Created>
  <o:LastSaved>2008-08-20T07:14:01Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in 0in .5in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.25in;
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
	font-family:"Times New Roman";
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
	font-family:"Times New Roman";
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
	font-size:18.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
.xl45
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	text-align:left;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl72
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl73
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
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
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>10</x:SplitHorizontal>
     <x:TopRowBottomPane>10</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>4</x:LeftColumnRightPane>
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
       <x:ActiveCol>0</x:ActiveCol>
       <x:RangeSelection>$A$11:$K$11</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
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
  <x:WindowHeight>9360</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1191 style='border-collapse:
 collapse;table-layout:fixed;width:895pt'>
 <col width=31 style='mso-width-source:userset;mso-width-alt:1133;width:23pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=82 style='mso-width-source:userset;mso-width-alt:2998;width:62pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=203 style='mso-width-source:userset;mso-width-alt:7424;width:152pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=167 style='mso-width-source:userset;mso-width-alt:6107;width:125pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=98 style='mso-width-source:userset;mso-width-alt:3584;width:74pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr height=31 style='height:23.25pt'>
  <td colspan=11 height=31 class=xl24 width=1127 style='height:23.25pt;
  width:847pt'>BẢNG KÊ HÓA ĐƠN, CHỨNG TỪ HÀNG HÓA DICH VỤ MUA VÀO</td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=3 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl50 style='border-right:.5pt solid black'>Tháng <%=month%><span
  style='mso-spacerun:yes'>     </span>năm <%=year%></td>
  <td colspan=4 rowspan=4 class=xl52 width=340 style='border-right:.5pt solid black;
  width:256pt'>Mẫu số:01-2/GTGT<br>
    (Ban hành theo thông tư số60/2007/TT-BTC ngày 14/6/2007 của Bộ Tài Chính )</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>Tên cơ sở kinh doanh :</td>
  <td colspan=3 class=xl58><%=lname%></td>
  <td></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25>Địa chỉ<span style='mso-spacerun:yes'>    </span>:</td>
  <td></td>
  <td colspan=3 class=xl58><%=address%></td>
  <td></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25>Mã số thuế:</td>
  <td></td>
  <td colspan=3 class=xl58><%=tax_code%></td>
  <td></td>
  <td colspan=3 class=xl59>Đơn vị tiền<span style='mso-spacerun:yes'> 
  </span>:<span style='mso-spacerun:yes'>  </span>ĐỒNG VIỆT NAM</td>
  <td style='mso-ignore:colspan;border-top:.5pt solid black'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=2 height=57 class=xl60 width=31 style='border-bottom:.5pt solid black;
  height:42.75pt;width:23pt'>STT</td>
  <td colspan=3 class=xl63 width=269 style='border-right:.5pt solid black;
  border-left:none;width:203pt'>Hóa đơn, chứng từ, biên lai nộp thuế</td>
  <td rowspan=2 class=xl60 width=203 style='border-bottom:.5pt solid black;
  width:152pt'>Tên người bán</td>
  <td rowspan=2 class=xl60 width=117 style='border-bottom:.5pt solid black;
  width:88pt'>Mã số thuế của người bán</td>
  <td rowspan=2 class=xl60 width=167 style='border-bottom:.5pt solid black;
  width:125pt'>Mặt hàng</td>
  <td rowspan=2 class=xl60 width=117 style='border-bottom:.5pt solid black;
  width:88pt'>Doanh số mua chưa có thuế</td>
  <td rowspan=2 class=xl60 width=61 style='border-bottom:.5pt solid black;
  width:46pt'>Thuế suất</td>
  <td rowspan=2 class=xl60 width=98 style='border-bottom:.5pt solid black;
  width:74pt'>Thuế GTGT đầu vào</td>
  <td rowspan=2 class=xl60 width=64 style='border-bottom:.5pt solid black;
  width:48pt'>Ghi chú</td>
  <td></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl26 width=78 style='height:26.25pt;width:59pt'>Ký hiệu
  hóa đơn</td>
  <td class=xl26 width=82 style='width:62pt'>Số hóa đơn</td>
  <td class=xl26 width=109 style='width:82pt'>Ngày, tháng, năm phát hành</td>
  <td></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt' x:num>1</td>
  <td class=xl28 x:num>2</td>
  <td class=xl28 x:num>3</td>
  <td class=xl28 x:num>4</td>
  <td class=xl28 x:num>5</td>
  <td class=xl28 x:num>6</td>
  <td class=xl28 x:num>7</td>
  <td class=xl28 x:num>8</td>
  <td class=xl28 x:num>9</td>
  <td class=xl28 x:num>10</td>
  <td class=xl28 x:num>11</td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl65 style='height:17.25pt'>1.Hàng hóa, dịch vụ
  dùng riêng cho sản xuất, kinh doanh chịu thuế GTGT 0%</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl29 style='border-top:none'>&nbsp;</td>
  <td class=xl76 style='border-top:none'>&nbsp;</td>
  <td></td>
 </tr>
 <%
    if(dt_0.Rows.Count > 0)
    {
        for(int i=0;i< dt_0.Rows.Count; i++)
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
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'><%=stt0%></td>
  <td class=xl32><%=seri%></td>
  <td class=xl32><%=invoice_no%></td>
  <td class=xl32><%=invoice_date%></td>
  <td class=xl32><%=cust_name%></td>
  <td class=xl33 style='border-top:none'><%=cust_tax%></td>
  <td class=xl33 style='border-top:none'><%=item%></td>
  <td class=xl34 style='border-top:none' x:num><span style='mso-spacerun:yes'></span><%=net_amt%></td>
  <td class=xl34 style='border-top:none'><%=tax_rate%></td>
  <td class=xl34 style='border-top:none' x:num><span style='mso-spacerun:yes'></span><%=vat_amt%></td>
  <td class=xl34 style='border-top:none'><%=voucher%> (<%=seq%>)(<%=vat_note%>)</td>
  <td class=xl35></td>
 </tr>
 <%
        }
    }
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl67 style='height:17.25pt'>Tổng</td>
  <td class=xl36 style='border-top:none'></td>
  <td class=xl36 style='border-top:none'></td>
  <td class=xl74 style='border-top:none' x:num><span style='mso-spacerun:yes'></span><%=net_0%></td>
  <td class=xl75 style='border-top:none'></td>
  <td class=xl75 style='border-top:none' x:num><span style='mso-spacerun:yes'></span><%=vat_0%></td>
  <td class=xl75 style='border-top:none'></td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl65 style='height:17.25pt'>2.Hàng hóa, dịch vụ
  dùng riêng cho sản xuất, kinh doanh chịu thuế GTGT 5%</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td></td>
 </tr>
 <%
    if(dt_5.Rows.Count > 0)
    {
        for(int i=0;i< dt_5.Rows.Count; i++)
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
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'><%=stt5%>&nbsp;</td>
  <td class=xl32><%=seri%></td>
  <td class=xl32><%=invoice_no%></td>
  <td class=xl32><%=invoice_date%></td>
  <td class=xl32><%=cust_name%></td>
  <td class=xl32><%=cust_tax%></td>
  <td class=xl32><%=item%></td>
  <td class=xl41 x:num><span style='mso-spacerun:yes'></span><%=net_amt%></td>
  <td class=xl41><%=tax_rate%></td>
  <td class=xl41 x:num><span style='mso-spacerun:yes'></span><%=vat_amt%></td>
  <td class=xl41><%=voucher%>(<%=seq%>)(<%=vat_note%>)</td>
  <td class=xl35></td>
 </tr>
 <%
        }
    }
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl67 style='height:17.25pt'>Tổng</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'></span><%=net_5%></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39 x:num><span style='mso-spacerun:yes'></span><%=vat_5%></td>
  <td class=xl39>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl65 style='height:17.25pt'>3.Hàng hóa, dịch vụ
  dùng riêng cho sản xuất, kinh doanh chịu thuế GTGT 10%</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td></td>
  <td class=xl42></td>
  <td class=xl30>&nbsp;</td>
  <td></td>
 </tr>
 <%
     //Response.Write("1");
     //Response.End();
    if(dt_10.Rows.Count > 0)
    {
        for(int i=0;i< dt_10.Rows.Count; i++)
        {
            stt10 += 1;
            seq = dt_10.Rows[i][0].ToString();
            seri = dt_10.Rows[i][4].ToString();
            invoice_dt = dt_10.Rows[i][5].ToString();
            if (invoice_dt != "")
            {
                invoice_date = invoice_dt.Substring(6, 2) + "/" + invoice_dt.Substring(4, 2) + "/" + invoice_dt.Substring(0, 4);
            }
            invoice_no = dt_10.Rows[i][6].ToString();
            cust_name = dt_10.Rows[i][8].ToString();
            cust_tax = dt_10.Rows[i][9].ToString();
            cust_addr = dt_10.Rows[i][10].ToString();
            item = dt_10.Rows[i][11].ToString();
            tax_rate = dt_10.Rows[i][13].ToString();
            net_amt = dt_10.Rows[i][14].ToString();
            vat_amt = dt_10.Rows[i][15].ToString();
            voucher = dt_10.Rows[i][16].ToString();
            vat_note = dt_10.Rows[i][17].ToString();
            if(!net_amt.Equals("")){
                net_10 += double.Parse(net_amt);
                net_sum += double.Parse(net_amt);
            }    
            if(!vat_amt.Equals("")){
                vat_10 += double.Parse(vat_amt);
                vat_sum += double.Parse(vat_amt);
            }    
         
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'><%=stt10%></td>
  <td class=xl32><%=seri%></td>
  <td class=xl32><%=invoice_no%></td>
  <td class=xl32><%=invoice_date%></td>
  <td class=xl32><%=cust_name%></td>
  <td class=xl33><%=cust_tax%></td>
  <td class=xl33><%=item%></td>
  <td class=xl34 x:num><span style='mso-spacerun:yes'></span><%=net_amt%></td>
  <td class=xl34><%=tax_rate%></td>
  <td class=xl34 x:num><span style='mso-spacerun:yes'></span><%=vat_amt%></td>
  <td class=xl34><%=voucher%> (<%=seq%>)(<%=vat_note%>)</td>
  <td class=xl35></td>
 </tr>
 <%
        }
    }
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl67 style='height:17.25pt'>Tổng</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'></span><%=net_10%></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39 x:num><span style='mso-spacerun:yes'></span><%=vat_10%></td>
  <td class=xl39>&nbsp;</td>
  <td></td>
 </tr>
  <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl65 style='height:17.25pt'>4.Hàng hóa, dịch vụ
  dùng riêng cho sản xuất, kinh doanh chịu thuế GTGT -%</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl42></td>
  <td></td>
  <td class=xl42></td>
  <td class=xl30>&nbsp;</td>
  <td></td>
 </tr>
 <%
     
     //Response.Write("1");
     //Response.End();
    if(dt_sub.Rows.Count > 0)
    {
        for(int i=0;i< dt_sub.Rows.Count; i++)
        {
            sttsub += 1;
            seq = dt_sub.Rows[i][0].ToString();
            seri = dt_sub.Rows[i][4].ToString();
            invoice_dt = dt_sub.Rows[i][5].ToString();
            if (invoice_dt != "")
            {
                invoice_date = invoice_dt.Substring(6, 2) + "/" + invoice_dt.Substring(4, 2) + "/" + invoice_dt.Substring(0, 4);
            }
            invoice_no = dt_sub.Rows[i][6].ToString();
            cust_name = dt_sub.Rows[i][8].ToString();
            cust_tax = dt_sub.Rows[i][9].ToString();
            cust_addr = dt_sub.Rows[i][10].ToString();
            item = dt_sub.Rows[i][11].ToString();
            tax_rate = dt_sub.Rows[i][13].ToString();
            net_amt = dt_sub.Rows[i][14].ToString();
            vat_amt = dt_sub.Rows[i][15].ToString();
            voucher = dt_sub.Rows[i][16].ToString();
            vat_note = dt_sub.Rows[i][17].ToString();
            if(!net_amt.Equals("")){
                net_sub += double.Parse(net_amt);
                net_sum += double.Parse(net_amt);
            }    
            if(!vat_amt.Equals("")){
                vat_sub += double.Parse(vat_amt);
                vat_sum += double.Parse(vat_amt);
            }    
         
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'><%=stt10%></td>
  <td class=xl32><%=seri%></td>
  <td class=xl32><%=invoice_no%></td>
  <td class=xl32><%=invoice_date%></td>
  <td class=xl32><%=cust_name%></td>
  <td class=xl33><%=cust_tax%></td>
  <td class=xl33><%=item%></td>
  <td class=xl34 x:num><span style='mso-spacerun:yes'></span><%=net_amt%></td>
  <td class=xl34><%=tax_rate%></td>
  <td class=xl34 x:num><span style='mso-spacerun:yes'></span><%=vat_amt%></td>
  <td class=xl34><%=voucher%> (<%=seq%>)(<%=vat_note%>)</td>
  <td class=xl35></td>
 </tr>
 <%
        }
    }
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl67 style='height:17.25pt'>Tổng</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38 x:num><span style='mso-spacerun:yes'></span><%=net_sub%></td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39 x:num><span style='mso-spacerun:yes'></span><%=vat_sub%></td>
  <td class=xl39>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=6 height=23 class=xl65 style='height:17.25pt'>5.Hàng hóa, dịch vụ
  dùng riêng cho sản xuất kinh doanh không chịu thuế GTGT</td>
  <td></td>
  <td class=xl42></td>
  <td></td>
  <td class=xl42></td>
  <td class=xl30>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl67 style='height:17.25pt'>Tổng</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=6 height=23 class=xl65 style='height:17.25pt'>5.Hàng hóa, dịch vụ
  dùng chung cho SXKD chịu thuế GTGT và không chịu thuế GTGT</td>
  <td></td>
  <td class=xl42></td>
  <td></td>
  <td class=xl42></td>
  <td class=xl30>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl67 style='height:17.25pt'>Tổng</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl69 style='height:17.25pt'>Tổng cộng</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45>&nbsp;</td>
  <td class=xl46 x:num><span style='mso-spacerun:yes'></span><%=net_0 + net_5 + net_10 + net_sub %></td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48 x:num><span style='mso-spacerun:yes'></span><%=vat_0 + vat_5 + vat_10 + vat_sub %></td>
  <td class=xl47>&nbsp;</td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=4 class=xl71>Tổng giá trị hàng hóa, dịch vụ mua vào:</td>
  <td class=xl49 x:num><span style='mso-spacerun:yes'></span><%=net_0 + net_5 + net_10 + net_sub %></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl49></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=4 class=xl71>Số tiền thuế GTGT của hàng hóa, dich vụ mua vào:</td>
  <td class=xl49 x:num><span style='mso-spacerun:yes'></span><%=vat_0 + vat_5 + vat_10 + vat_sub %></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=12 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl72>,Ngày&nbsp;&nbsp; <span style='mso-spacerun:yes'>   
  </span>tháng&nbsp;&nbsp; <span style='mso-spacerun:yes'>   </span>năm&nbsp;&nbsp; </td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl44 colspan=2 style='mso-ignore:colspan'>Người lập phiếu</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl44>Kế toán Trưởng</td>
  <td></td>
  <td colspan=3 class=xl73>Giám Đốc</td>
  <td></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=31 style='width:23pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=203 style='width:152pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=167 style='width:125pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=98 style='width:74pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
