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
    string month = p_month.Substring(4, 2);
    string year = p_month.Substring(0, 4);
    string lname ="";
    string name ="";
    string tax_code ="";
    string address ="";
    string seri ="";
    string invoice_no = "";
    string l_invoiceno = "" + Request["invoiceno"];
    string l_ac_cd = "" + Request["ac_cd"];
    string p_tac_hgtrh_pk = "" + Request["txtSeq"];
    string p_voucherno = "" + Request["voucherno"];
    string p_BalType = "" + Request["BalType"];
    string p_dtfr = "" + Request["p_dtfr"];
    string p_dtto = "" + Request["p_dtto"];
    string p_voucher_type = "" + Request["voucher_type"];
    string invoice_dt = "";
    string invoice_date="";
    string cust_name = "";
    string cust_tax = "";
    string cust_addr ="";
    string item = "";
    string tax_rate ="";
    string    net_amt = "";
    string    vat_amt = "";
    string    seq = "";
    string voucher ="";
    string vat_note = "";
    int    stt0 = 0;
    double    stt5 = 0;
    double    stt10 = 0;
    double    stt_none = 0;
    double    net_none = 0;  
    double    net_0 = 0;
    double    net_5 = 0;
    double    net_10 = 0;
    double    vat_none = 0;
    double    vat_0 = 0;
    double    vat_5 = 0;
    double    vat_10 = 0;
    double    vat_sum = 0;
    double    net_sum = 0;
    
    
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
    SQLD += "         a.tax_code, a.address, a.tco_ciitem_nm, a.ccy, a.tax_rate, a.net_amt, ";
    SQLD += "         a.tax_amt, h.voucherno , a.VAT_NOTE ";
    SQLD += "    FROM tac_mtvat a, tac_hgtrd d, tac_hgtrh h ";
    SQLD += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0";
    SQLD += "     AND a.tac_hgtrd_pk = d.pk ";
    SQLD += "     AND d.tac_hgtrh_pk = h.pk ";
    SQLD += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQLD += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQLD += "     AND a.std_ym = '"+ p_month +"' ";
    SQLD += "     AND a.vat_type = '2' ";
    SQLD += "     AND a.tax_rate = 'none' ";
    SQLD += "     AND a.tr_status IN ('" + p_status + "') ";
    SQLD += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQLD += "ORDER BY a.invoice_date, a.invoice_no ";
    //DataTable dt_none = ESysLib.TableReadOpen(SQLD);

    string l_parameter = "'" + p_com + "','" + p_month + "','2','No VAT%','" + p_ccy + "','" + p_status + "','" + p_cust_pk + "','" + l_invoiceno + "','" + l_ac_cd + "','" + p_tac_hgtrh_pk + "','" + p_voucherno + "','" + p_BalType + "','" + p_dtfr + "','" + p_dtto + "','" + p_voucher_type + "'";
    DataTable dt_none = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);
    
    string SQL0 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL0 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, (select partner_lname from tco_buspartner where pk = a.tco_buspartner_pk) buspartner_lnm, ";
    SQL0 += "         a.tax_code, a.address, a.tco_ciitem_nm, a.ccy, a.tax_rate, a.net_amt, ";
    SQL0 += "         a.tax_amt, h.voucherno , a.VAT_NOTE ";
    SQL0 += "    FROM tac_mtvat a, tac_hgtrd d, tac_hgtrh h ";
    SQL0 += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0";
    SQL0 += "     AND a.tac_hgtrd_pk = d.pk ";
    SQL0 += "     AND d.tac_hgtrh_pk = h.pk ";
    SQL0 += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQL0 += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQL0 += "     AND a.std_ym = '"+ p_month +"' ";
    SQL0 += "     AND a.vat_type = '2' ";
    SQL0 += "     AND a.tax_rate = '0%' ";
    SQL0 += "     AND a.tr_status IN ('" + p_status + "') ";
    SQL0 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL0 += "ORDER BY a.invoice_date, a.invoice_no ";
   // DataTable dt_0 = ESysLib.TableReadOpen(SQL0);
    l_parameter = "'" + p_com + "','" + p_month + "','2','0%','" + p_ccy + "','" + p_status + "','" + p_cust_pk + "','" + l_invoiceno + "','" + l_ac_cd + "','" + p_tac_hgtrh_pk + "','" + p_voucherno + "','" + p_BalType + "','" + p_dtfr + "','" + p_dtto + "','" + p_voucher_type + "'";
    DataTable dt_0 = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);	
   
    string SQL5 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL5 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, (select partner_lname from tco_buspartner where pk = a.tco_buspartner_pk) buspartner_lnm, ";
    SQL5 += "         a.tax_code, a.address, a.tco_ciitem_nm, a.ccy, a.tax_rate, a.net_amt, ";
    SQL5 += "         a.tax_amt, a.voucherno , a.VAT_NOTE ";
    SQL5 += "    FROM tac_mtvat a, tac_hgtrd d, tac_hgtrh h ";
    SQL5 += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0";
    SQL5 += "     AND a.tac_hgtrd_pk = d.pk ";
    SQL5 += "     AND d.tac_hgtrh_pk = h.pk ";
    SQL5 += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQL5 += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQL5 += "     AND a.std_ym = '"+ p_month +"' ";
    SQL5 += "     AND a.vat_type = '2' ";
    SQL5 += "     AND a.tax_rate = '5%' ";
    SQL5 += "     AND a.tr_status IN ('" + p_status + "') ";
    SQL5 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL5 += "ORDER BY a.invoice_date, a.invoice_no ";
   // DataTable dt_5 = ESysLib.TableReadOpen(SQL5);
    l_parameter = "'" + p_com + "','" + p_month + "','2','5%','" + p_ccy + "','" + p_status + "','" + p_cust_pk + "','" + l_invoiceno + "','" + l_ac_cd + "','" + p_tac_hgtrh_pk + "','" + p_voucherno + "','" + p_BalType + "','" + p_dtfr + "','" + p_dtto + "','" + p_voucher_type + "'";
    DataTable dt_5 = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);	
   
    string SQL10 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL10 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, (select partner_lname from tco_buspartner where pk = a.tco_buspartner_pk) buspartner_lnm, ";
    SQL10 += "         a.tax_code, a.address, a.tco_ciitem_nm, a.ccy, a.tax_rate, a.net_amt, ";
    SQL10 += "         a.tax_amt, h.voucherno , a.VAT_NOTE ";
    SQL10 += "    FROM tac_mtvat a, tac_hgtrd d, tac_hgtrh h ";
    SQL10 += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0 ";
    SQL10 += "     AND a.tac_hgtrd_pk = d.pk ";
    SQL10 += "     AND d.tac_hgtrh_pk = h.pk ";
    SQL10 += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQL10 += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQL10 += "     AND a.std_ym = '"+ p_month +"' ";
    SQL10 += "     AND a.vat_type = '2' ";
    SQL10 += "     AND a.tax_rate = '10%' ";
    SQL10 += "     AND a.tr_status IN ('" + p_status + "') ";
    SQL10 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL10 += "ORDER BY a.invoice_date, a.invoice_no ";
    //DataTable dt_10 = ESysLib.TableReadOpen(SQL10);
    
    l_parameter = "'" + p_com + "','" + p_month + "','2','10%','" + p_ccy + "','" + p_status + "','" + p_cust_pk + "','" + l_invoiceno + "','" + l_ac_cd + "','" + p_tac_hgtrh_pk + "','" + p_voucherno + "','" + p_BalType + "','" + p_dtfr + "','" + p_dtto + "','" + p_voucher_type + "'";
   // Response.Write(l_parameter);
   // Response.End();
    DataTable dt_10 = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);	
   
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Page_files/filelist.xml">
<style id="BẢNG KÊ HÓA ĐƠN, CHỨNG TỪ HÀNG HÓA DICH VỤ BÁN RA_14075_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font514075
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font614075
	{color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font714075
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl1514075
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
.xl2414075
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
.xl2514075
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
.xl2614075
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
.xl2714075
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
.xl2814075
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
.xl2914075
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
.xl3014075
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
.xl3114075
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
.xl3214075
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
.xl3314075
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
.xl3414075
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
.xl3514075
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
.xl3614075
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
.xl3714075
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
.xl3814075
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
.xl3914075
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
.xl4014075
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
.xl4114075
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
.xl4214075
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
.xl4314075
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
.xl4414075
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
.xl4514075
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
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4614075
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
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4714075
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
.xl4814075
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
.xl4914075
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
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5014075
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
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5114075
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
.xl5214075
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
.xl5314075
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
.xl5414075
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
.xl5514075
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
.xl5614075
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
.xl5714075
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
.xl5814075
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
.xl5914075
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
.xl6014075
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
.xl6114075
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
.xl6214075
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
.xl6314075
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
.xl6414075
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
.xl6514075
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
.xl6614075
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
.xl6714075
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
.xl6814075
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
.xl6914075
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
.xl7014075
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
.xl7114075
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
.xl7214075
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
.xl7314075
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
.xl7414075
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
.xl7514075
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
.xl7614075
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
.xl7714075
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
.xl7814075
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
.xl7914075
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
.xl8014075
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
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl8114075
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
.xl8214075
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
.xl8314075
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

<div id="BẢNG KÊ HÓA ĐƠN, CHỨNG TỪ HÀNG HÓA DICH VỤ BÁN RA_14075" align=center
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
  <td height=30 class=xl1514075 width=33 style='height:22.5pt;width:25pt'></td>
  <td class=xl1514075 width=67 style='width:50pt'></td>
  <td class=xl1514075 width=70 style='width:53pt'></td>
  <td class=xl1514075 width=93 style='width:70pt'></td>
  <td class=xl1514075 width=174 style='width:131pt'></td>
  <td class=xl1514075 width=88 style='width:66pt'></td>
  <td class=xl1514075 width=187 style='width:140pt'></td>
  <td class=xl1514075 width=100 style='width:75pt'></td>
  <td colspan=3 rowspan=4 class=xl5714075 width=281 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:211pt'>Mẫu số:01-1/GTGT<font
  class="font514075"><br>
    </font><font class="font714075">(Ban hành theo Thông tư số 28/2011/TT-BTC
  ngày 28/02/2011 của Bộ Tài Chính )</font></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl1514075 style='height:12.75pt'></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl1514075 style='height:12.75pt'></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl1514075 style='height:12.75pt'></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
  <td class=xl1514075></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=11 height=30 class=xl6614075 style='height:22.5pt'>BẢNG KÊ HÓA
  ĐƠN, CHỨNG TỪ HÀNG HÓA DICH VỤ BÁN RA</td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=11 height=25 class=xl6714075 style='height:18.75pt'>(Kèm theo tờ
  khai thuế GTGT mẫu số 01/GTGT ngày ….. tháng ….. năm …..)</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=11 height=26 class=xl6814075 style='height:19.5pt'>[01] <font
  class="font614075">Kỳ tính thuế: tháng <%=month%> năm <%=year %></font></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2514075 colspan=3>[02] Tên người nộp thuế:</td>
  <td class=xl2414075><%=lname%></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075 colspan=2>[03] Mã số thuế:</td>
  <td colspan=3 class=xl2614075><%=tax_code%></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2514075 colspan=3>[04] Tên đại lý thuế (nếu có):</td>
  <td class=xl2514075></td>
  <td class=xl2514075></td>
  <td class=xl2514075></td>
  <td class=xl2514075></td>
  <td class=xl2514075></td>
  <td class=xl2514075></td>
  <td class=xl2514075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075 colspan=2>[05] Mã số thuế</td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td colspan=4 class=xl7014075>Đơn vị tiền<span style='mso-spacerun:yes'> 
  </span>:<span style='mso-spacerun:yes'>  </span>đồng Việt nam</td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td rowspan=2 height=68 class=xl7114075 width=33 style='border-bottom:.5pt solid black;
  height:51.0pt;width:25pt'>STT</td>
  <td colspan=3 class=xl7314075 width=230 style='border-right:.5pt solid black;
  border-left:none;width:173pt'>Hóa đơn, chứng từ bán ra</td>
  <td rowspan=2 class=xl7114075 width=174 style='border-bottom:.5pt solid black;
  width:131pt'>Tên người mua</td>
  <td rowspan=2 class=xl7114075 width=88 style='border-bottom:.5pt solid black;
  width:66pt'>Mã số thuế người mua</td>
  <td rowspan=2 class=xl7114075 width=187 style='border-bottom:.5pt solid black;
  width:140pt'>Mặt hàng</td>
  <td rowspan=2 class=xl7114075 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Giá trị HHDV bán ra chưa có thuế</td>
  <td rowspan=2 class=xl7114075 width=44 style='border-bottom:.5pt solid black;
  width:33pt'>Thuế suất<br>
    (%)</td>
  <td rowspan=2 class=xl7114075 width=87 style='border-bottom:.5pt solid black;
  width:65pt'>Thuế GTGT</td>
  <td rowspan=2 class=xl7114075 width=150 style='border-bottom:.5pt solid black;
  width:113pt'>Ghi chú</td>
 </tr>
 <tr class=xl2414075 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl2714075 width=67 style='height:26.25pt;width:50pt'>Ký
  hiệu</td>
  <td class=xl2714075 width=70 style='width:53pt'>Số</td>
  <td class=xl2714075 width=93 style='width:70pt'>Ngày, tháng, năm phát hành</td>
 </tr>
 <tr class=xl2414075 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl2814075 style='height:15.0pt'>(1)</td>
  <td class=xl2814075 style='border-left:none'>(2)</td>
  <td class=xl2814075 style='border-left:none'>(3)</td>
  <td class=xl2814075 style='border-left:none'>(4)</td>
  <td class=xl2814075 style='border-left:none'>(5)</td>
  <td class=xl2814075 style='border-left:none'>(6)</td>
  <td class=xl2814075 style='border-left:none'>(7)</td>
  <td class=xl2814075 style='border-left:none'>(8)</td>
  <td class=xl2814075 style='border-left:none'>(9)</td>
  <td class=xl2814075 style='border-left:none'>(10)</td>
  <td class=xl2814075 style='border-left:none'>(11)</td>
 </tr>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl2914075 colspan=5 style='height:17.25pt'>1.Hàng hóa,
  dịch vụ không chịu thuế GTGT:</td>
  <td class=xl3114075>&nbsp;</td>
  <td class=xl3114075>&nbsp;</td>
  <td class=xl3114075>&nbsp;</td>
  <td class=xl3114075>&nbsp;</td>
  <td class=xl3114075>&nbsp;</td>
  <td class=xl3214075>&nbsp;</td>
 </tr>
 <%      
     for (int i = 0; i < dt_none.Rows.Count; i++)
     {
         stt_none += 1;
         seq = dt_none.Rows[i][0].ToString();
         seri = dt_none.Rows[i][4].ToString();
         invoice_dt = dt_none.Rows[i][5].ToString();
         invoice_date = invoice_dt.Substring(6, 2) + "/" + invoice_dt.Substring(4, 2) + "/" + invoice_dt.Substring(0, 4);
         invoice_no = dt_none.Rows[i][6].ToString();
         cust_name = dt_none.Rows[i][8].ToString();
         cust_tax = dt_none.Rows[i][9].ToString();
         cust_addr = dt_none.Rows[i][10].ToString();
         item = dt_none.Rows[i][11].ToString();
         tax_rate = dt_none.Rows[i][13].ToString();
         net_amt = dt_none.Rows[i][14].ToString();
         vat_amt = dt_none.Rows[i][15].ToString();
         voucher = dt_none.Rows[i][16].ToString();
         vat_note = dt_none.Rows[i][17].ToString();
         if (net_amt.Trim() != "")
             net_none += double.Parse(net_amt);
         if (vat_amt.Trim() != "")
             vat_none += double.Parse(vat_amt);
         if (net_amt.Trim() != "")
             net_sum += double.Parse(net_amt);
         if (vat_amt.Trim() != "")
             vat_sum += double.Parse(vat_amt);
     
 %>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl3714075 style='height:17.25pt'><%=stt_none%></td>
  <td class=xl3814075><%=seri%></td> <!--Serial no-->
  <td class=xl3814075><%=invoice_no%></td> <!--Invoice no-->
  <td class=xl3814075><%=invoice_date%></td> <!--Invoice date-->
  <td class=xl3814075><%=cust_name%></td>
  <td class=xl3914075 style='border-top:none'><%=cust_tax%></td>
  <td class=xl3914075 style='border-top:none'><%=item%></td>
  <td class=xl4014075 style='border-top:none' x:num ><%=net_amt%></td>
  <td class=xl4014075 style='border-top:none'><%=tax_rate%></td>
  <td class=xl4014075 style='border-top:none' x:num><%=vat_amt%></td>
  <td class=xl4014075 style='border-top:none'><%=voucher%> (<%=seq%>)<%=vat_note%>)</td>
 </tr>
 <% 
     } 
 %>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl7614075 style='height:17.25pt'>Tổng</td>
  <td class=xl3314075>&nbsp;</td>
  <td class=xl3314075>&nbsp;</td>
  <td class=xl3414075 x:num><span
  style='mso-spacerun:yes'>                     </span><%=net_none%></td>
  <td class=xl3514075>&nbsp;</td>
  <td class=xl3514075 x:num><span
  style='mso-spacerun:yes'>                  </span><%=vat_none%> </td>
  <td class=xl3514075>&nbsp;</td>
 </tr>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl2914075 colspan=5 style='height:17.25pt'>2.Hàng hóa,
  dịch vụ chịu thuế suất thuế GTGT 0%:</td>
  <td class=xl3114075>&nbsp;</td>
  <td class=xl3114075>&nbsp;</td>
  <td class=xl3114075>&nbsp;</td>
  <td class=xl3114075>&nbsp;</td>
  <td class=xl3114075>&nbsp;</td>
  <td class=xl3214075>&nbsp;</td>
 </tr>
 <%
     if (dt_0.Rows.Count > 0)
     {
         for (int i = 0; i < dt_0.Rows.Count; i++)
         {
             stt0 += 1;
             seq = dt_0.Rows[i][0].ToString();
             seri = dt_0.Rows[i][4].ToString();
             invoice_dt = dt_0.Rows[i][5].ToString();
             invoice_date = invoice_dt.Substring(6, 2) + "/" + invoice_dt.Substring(4, 2) + "/" + invoice_dt.Substring(0, 4);
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
             if (net_amt.Trim() != "")
                 net_0 += double.Parse(net_amt);
             if (vat_amt.Trim() != "")
                 vat_0 += double.Parse(vat_amt);
             if (net_amt.Trim() != "")
                 net_sum += double.Parse(net_amt);
             if (vat_amt.Trim() != "")
                 vat_sum += double.Parse(vat_amt);
  %>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl3714075 style='height:17.25pt'><%=stt0%></td>
  <td class=xl3814075><%=seri%></td>
  <td class=xl3814075><%=invoice_no%></td>
  <td class=xl3814075><%=invoice_date%></td>
  <td class=xl3814075><%=cust_name%></td>
  <td class=xl3914075 style='border-top:none'><%=cust_tax%></td>
  <td class=xl3914075 style='border-top:none'><%=item%></td>
  <td class=xl4014075 style='border-top:none' x:num><%=net_amt%></td>
  <td class=xl4014075 style='border-top:none'><%=tax_rate%></td>
  <td class=xl4014075 style='border-top:none' x:num><%=vat_amt%></td>
  <td class=xl4014075 style='border-top:none'><%=voucher%> (<%=seq%>)<%=vat_note%>)</td>
 </tr>
<% 
     }
     }
%> 
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl7614075 style='height:17.25pt'>Tổng</td>
  <td class=xl3314075>&nbsp;</td>
  <td class=xl3314075>&nbsp;</td>
  <td class=xl3414075 x:num><span
  style='mso-spacerun:yes'>                     </span><%=net_0%> </td>
  <td class=xl3514075>&nbsp;</td>
  <td class=xl3514075 x:num><span
  style='mso-spacerun:yes'>                  </span><%=vat_0%> </td>
  <td class=xl3514075>&nbsp;</td>
 </tr>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl2914075 colspan=5 style='height:17.25pt'>3.Hàng hóa,
  dịch vụ chịu thuế suất thuế GTGT 5%:</td>
  <td class=xl3014075 style='border-top:none'>&nbsp;</td>
  <td class=xl3014075 style='border-top:none'>&nbsp;</td>
  <td class=xl3014075 style='border-top:none'>&nbsp;</td>
  <td class=xl3014075 style='border-top:none'>&nbsp;</td>
  <td class=xl3014075 style='border-top:none'>&nbsp;</td>
  <td class=xl3614075 style='border-top:none'>&nbsp;</td>
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
            invoice_date = invoice_dt.Substring(6,2) +"/" + invoice_dt.Substring(4,2)+ "/" + invoice_dt.Substring(0,4);
            invoice_no = dt_5.Rows[i][6].ToString();
            cust_name = dt_5.Rows[i][8].ToString();
            cust_tax = dt_5.Rows[i][9].ToString();
            cust_addr = dt_5.Rows[i][10].ToString();
            item = dt_5.Rows[i][11].ToString();
            tax_rate = dt_5.Rows[i][13].ToString();
            net_amt = dt_5.Rows[i][14].ToString();
            vat_amt = dt_5.Rows[i][15].ToString();
            voucher = dt_5.Rows[i][16].ToString();
            vat_note  = dt_5.Rows[i][17].ToString();
            if(net_amt.Trim() != "")
                net_5 += double.Parse(net_amt);
            if (vat_amt.Trim() != "")
                vat_5 += double.Parse(vat_amt);
            if (net_amt.Trim() != "")
                net_sum += double.Parse(net_amt);

            if (vat_amt.Trim() != "")
                vat_sum += double.Parse(vat_amt);
  %>

 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl3714075 style='height:17.25pt' x:num><%=stt5 %></td>
  <td class=xl3814075><%=seri%></td>
  <td class=xl3814075><%=invoice_no%></td>
  <td class=xl3814075><%=invoice_date%></td>
  <td class=xl3814075><%=cust_name%></td>
  <td class=xl3914075 style='border-top:none'><%=cust_tax%></td>
  <td class=xl3914075 style='border-top:none'><%=item%></td>
  <td class=xl4014075 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span><%=net_amt%> </td>
  <td class=xl4014075 style='border-top:none' x:str><span
  style='mso-spacerun:yes'> </span><%=tax_rate%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl4014075 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span><%=vat_amt%> </td>
  <td class=xl4014075 style='border-top:none' x:str><span
  style='mso-spacerun:yes'> </span><%=voucher%> (<%=seq%>)<%=vat_note%>)<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <% 
        }
    }
 %>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl7614075 style='height:17.25pt'>Tổng</td>
  <td class=xl3314075>&nbsp;</td>
  <td class=xl3314075>&nbsp;</td>
  <td class=xl4214075 x:num><span
  style='mso-spacerun:yes'> </span><%=net_5%></td>
  <td class=xl4214075>&nbsp;</td>
  <td class=xl4214075 x:num><span
  style='mso-spacerun:yes'> </span><%=vat_5%></td>
  <td class=xl4214075>&nbsp;</td>
 </tr>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl2914075 style='height:17.25pt;border-top:none'>3.Hà<span
  style='display:none'>ng hóa, dịch vụ chịu thuế suất thuế GTGT 10%:</span></td>
  <td class=xl4314075 style='border-top:none'>&nbsp;</td>
  <td class=xl4314075 style='border-top:none'>&nbsp;</td>
  <td class=xl4314075 style='border-top:none'>&nbsp;</td>
  <td class=xl4314075 style='border-top:none'>&nbsp;</td>
  <td class=xl4314075 style='border-top:none'>&nbsp;</td>
  <td class=xl4314075 style='border-top:none'>&nbsp;</td>
  <td class=xl4314075 style='border-top:none'>&nbsp;</td>
  <td class=xl4314075 style='border-top:none'>&nbsp;</td>
  <td class=xl4314075 style='border-top:none'>&nbsp;</td>
  <td class=xl4414075 style='border-top:none'>&nbsp;</td>
 </tr>
 <%
    if(dt_10.Rows.Count > 0)
    {
        for(int i=0;i< dt_10.Rows.Count; i++)
        {
            stt10 += 1;
            seq = dt_10.Rows[i][0].ToString();
            seri = dt_10.Rows[i][4].ToString();
            invoice_dt = dt_10.Rows[i][5].ToString();
            invoice_date = invoice_dt.Substring(6,2) +"/" + invoice_dt.Substring(4,2)+ "/" + invoice_dt.Substring(0,4);
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
            if(net_amt.Trim() != "")
                net_10 += double.Parse(net_amt);
            if (vat_amt.Trim() != "")
                vat_10 += double.Parse(vat_amt);
            if (net_amt.Trim() != "")
                net_sum += double.Parse(net_amt);
            if (vat_amt.Trim() != "")
                vat_sum += double.Parse(vat_amt);
    %>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl3714075 style='height:17.25pt'><%=stt10 %></td>
  <td class=xl3814075><%=seri%></td>
  <td class=xl3814075><%=invoice_no%></td>
  <td class=xl3814075><%=invoice_date%></td>
  <td class=xl3814075><%=cust_name%></td>
  <td class=xl3814075><%=cust_tax%></td>
  <td class=xl3814075><%=item%></td>
  <td class=xl4114075 x:num><%=net_amt%></td>
  <td class=xl4114075><%=tax_rate%></td>
  <td class=xl4114075 x:num><%=vat_amt%></td>
  <td class=xl4114075><%=voucher%> (<%=seq%>)<%=vat_note%>)</td>
 </tr>
 <% 
        }
    }
 %> 
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl7614075 style='height:17.25pt'>Tổng</td>
  <td class=xl4514075>&nbsp;</td>
  <td class=xl4514075 style='border-left:none'>&nbsp;</td>
  <td class=xl4614075 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                     </span><%=net_10%></td>
  <td class=xl4614075 style='border-left:none'>&nbsp;</td>
  <td class=xl4614075 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%=vat_10%></td>
  <td class=xl4614075 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=6 height=23 class=xl8114075 style='height:17.25pt'>5.Hàng hóa,
  dịch vụ không phải tổng hợp trên tờ khai 01/GTGT:</td>
  <td class=xl2414075></td>
  <td class=xl4714075></td>
  <td class=xl2414075></td>
  <td class=xl4714075></td>
  <td class=xl4814075>&nbsp;</td>
 </tr>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl4514075 style='height:17.25pt'>&nbsp;</td>
  <td class=xl4514075 style='border-left:none'>&nbsp;</td>
  <td class=xl4514075 style='border-left:none'>&nbsp;</td>
  <td class=xl4514075 style='border-left:none'>&nbsp;</td>
  <td class=xl4514075 style='border-left:none'>&nbsp;</td>
  <td class=xl4514075 style='border-left:none'>&nbsp;</td>
  <td class=xl4514075 style='border-left:none'>&nbsp;</td>
  <td class=xl4914075 style='border-left:none'>&nbsp;</td>
  <td class=xl4514075 style='border-left:none'>&nbsp;</td>
  <td class=xl4914075 style='border-left:none'>&nbsp;</td>
  <td class=xl4514075 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl2414075 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl8014075 style='height:17.25pt'>Tổng</td>
  <td class=xl4514075 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl4514075 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl4614075 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl5014075 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl4614075 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl5014075 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 colspan=5 style='height:15.0pt'>Tổng doanh thu
  hàng hóa, dịch vụ bán ra (*)</td>
  <td class=xl5214075></td>
  <td class=xl2414075></td>
  <td class=xl5314075 x:num><span
  style='mso-spacerun:yes'> </span><%=net_none + net_0 + net_5 + net_10 %> </td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 colspan=5 style='height:15.0pt'>Tổng doanh thu
  hàng hóa, dịch vụ bán ra chịu thuế GTGT (**)</td>
  <td class=xl5214075></td>
  <td class=xl2414075></td>
  <td class=xl5314075 x:num><span
  style='mso-spacerun:yes'> </span><%=net_0 + net_5 + net_10 %> </td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 colspan=5 style='height:15.0pt'>Tổng số thuế
  GTGT của hàng hóa, dịch vụ bán vào (***):</td>
  <td class=xl5214075></td>
  <td class=xl2414075></td>
  <td class=xl5314075 x:num><span
  style='mso-spacerun:yes'> </span><%=vat_0 + vat_5 + vat_10 %></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5214075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075 colspan=6>Tôi cam đoan số liệu khai trên là đúng và chịu
  trách nhiệm trước pháp luật về những<span style='mso-spacerun:yes'> 
  </span>số liệu đã khai./.</td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='page-break-before:always;height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td colspan=4 class=xl8314075 width=381 style='width:286pt'>Ngày …....tháng
  …....năm …....</td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl5414075 colspan=3>NHÂN VIÊN ĐẠI LÝ THUẾ</td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl5514075></td>
  <td colspan=4 class=xl7814075 width=381 style='width:286pt'
  x:str="NGƯỜI NỘP THUẾ hoặc ">NGƯỜI NỘP THUẾ hoặc<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2614075 colspan=3>Họ và tên:…………………….</td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td colspan=4 class=xl7814075 width=381 style='width:286pt'>ĐẠI DIỆN HỢP PHÁP
  CỦA NGƯỜI NỘP THUẾ</td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2614075 colspan=3>Chứng chỉ hành nghề số:..........</td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td colspan=4 class=xl7914075 width=381 style='width:286pt'>Ký, ghi rõ họ
  tên; chức vụ và đóng dấu (nếu có)</td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl5614075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
  <td class=xl5114075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
 </tr>
 <tr class=xl2414075 height=20 style='height:15.0pt'>
  <td height=20 class=xl2414075 style='height:15.0pt'></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
  <td class=xl2414075></td>
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
