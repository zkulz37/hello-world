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
    SQLD += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, a.buspartner_lnm, ";
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

    string l_parameter = "'" + p_com + "','" + p_month + "','2','none','" + p_ccy + "','" + p_status + "','" + p_cust_pk + "','" + l_invoiceno + "','" + l_ac_cd + "','" + p_tac_hgtrh_pk + "','" + p_voucherno + "','" + p_BalType + "','" + p_dtfr + "','" + p_dtto + "','" + p_voucher_type + "'";
    DataTable dt_none = ESysLib.TableReadOpenCursor("acnt.sp_sel_gflv00020_1", l_parameter);
    
    string SQL0 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL0 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, a.buspartner_lnm, ";
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
    SQL5 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, a.buspartner_lnm, ";
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
    SQL10 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, a.buspartner_lnm, ";
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
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_VAT_In_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_VAT_In_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_VAT_In_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-08-04T10:09:50Z</o:LastPrinted>
  <o:Created>2008-08-04T09:01:52Z</o:Created>
  <o:LastSaved>2008-08-09T09:59:31Z</o:LastSaved>
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
	border:.5pt solid windowtext;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
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
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	text-align:left;}
.xl56
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
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl58
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
.xl59
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
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl61
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
	border-left:.5pt solid windowtext;}
.xl62
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
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl67
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;}
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
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>0</x:ActiveCol>
       <x:RangeSelection>$A$14:$E$14</x:RangeSelection>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1127 style='border-collapse:
 collapse;table-layout:fixed;width:847pt'>
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
 <col width=64 style='width:48pt'>
 <tr height=31 style='height:23.25pt'>
  <td colspan=11 height=31 class=xl24 width=1127 style='height:23.25pt;
  width:847pt'>B&#7842;NG KÊ HÓA &#272;&#416;N, CH&#7912;NG T&#7914; HÀNG HÓA
  DICH V&#7908; BÁN RA</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=3 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl57>Tháng <%=month%><span style='mso-spacerun:yes'>   
  </span>n&#259;m <%=year%></td>
  <td colspan=4 rowspan=4 class=xl58 width=340 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:256pt'>M&#7851;u
  s&#7889;:01-2/GTGT<br>
    (Ban hành theo thông t&#432; s&#7889;60/2007/TT-BTC ngày 14/6/2007
  c&#7911;a B&#7897; Tài Chính )</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>Tên c&#417; s&#7903; kinh
  doanh :</td>
  <td colspan=3 class=xl55><%=lname%></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25>&#272;&#7883;a ch&#7881;<span style='mso-spacerun:yes'>   
  </span>:</td>
  <td></td>
  <td colspan=3 class=xl55><%=address%></td>
  <td></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25>Mã s&#7889; thu&#7871;:</td>
  <td></td>
  <td colspan=3 class=xl55><%=tax_code%></td>
  <td></td>
  <td colspan=3 class=xl56>&#272;&#417;n v&#7883; ti&#7873;n<span
  style='mso-spacerun:yes'>  </span>:<span style='mso-spacerun:yes'> 
  </span>&#272;&#7890;NG VI&#7878;T NAM</td>
  <td class=xl56></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=2 height=57 class=xl26 width=31 style='height:42.75pt;width:23pt'>STT</td>
  <td colspan=3 class=xl26 width=269 style='border-left:none;width:203pt'>Hóa
  &#273;&#417;n, ch&#7913;ng t&#7915;, biên lai n&#7897;p thu&#7871;</td>
  <td rowspan=2 class=xl26 width=203 style='width:152pt'>Tên ng&#432;&#7901;i
  bán</td>
  <td rowspan=2 class=xl26 width=117 style='width:88pt'>Mã s&#7889; thu&#7871;
  c&#7911;a ng&#432;&#7901;i mua</td>
  <td rowspan=2 class=xl26 width=167 style='width:125pt'>M&#7863;t hàng</td>
  <td rowspan=2 class=xl26 width=117 style='width:88pt'>Doanh s&#7889; bán
  ch&#432;a có thu&#7871;</td>
  <td rowspan=2 class=xl26 width=61 style='width:46pt'>Thu&#7871; su&#7845;t</td>
  <td rowspan=2 class=xl26 width=98 style='width:74pt'>Thu&#7871; GTGT
  &#273;&#7847;u ra</td>
  <td rowspan=2 class=xl26 width=64 style='width:48pt'>Ghi chú</td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl26 width=78 style='height:26.25pt;border-top:none;
  border-left:none;width:59pt'>Ký hi&#7879;u hóa &#273;&#417;n</td>
  <td class=xl26 width=82 style='border-top:none;border-left:none;width:62pt'>S&#7889;
  hóa &#273;&#417;n</td>
  <td class=xl26 width=109 style='border-top:none;border-left:none;width:82pt'>Ngày,
  tháng, n&#259;m phát hành</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt;border-top:none' x:num>1</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num>8</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num>9</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num>10</td>
  <td class=xl27 style='border-top:none;border-left:none' x:num>11</td>
 </tr>
 
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl49 style='height:17.25pt'>1.Hàng hóa,
  d&#7883;ch v&#7909; không ch&#7883;u thu&#7871; GTGT </td>
  <td colspan=5 style='mso-ignore:colspan;border-top:none'></td>
  <td class=xl31>&nbsp;</td>
 </tr>
 <%
    if(dt_none.Rows.Count > 0)
    {
        for (int i = 0; i < dt_none.Rows.Count; i++)
        {
            stt_none += 1;
            seq = dt_none.Rows[i][0].ToString();
            seri = dt_none.Rows[i][4].ToString();
            invoice_dt = dt_none.Rows[i][5].ToString();
            invoice_date = invoice_dt.Substring(6,2) +"/" + invoice_dt.Substring(4,2)+ "/" + invoice_dt.Substring(0,4);
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
            if(net_amt.Trim() != "")
                net_none += double.Parse(net_amt);
            if (vat_amt.Trim() != "")
                vat_none += double.Parse(vat_amt);
            if (net_amt.Trim() != "")
                net_sum += double.Parse(net_amt);
            if (vat_amt.Trim() != "")
                vat_sum += double.Parse(vat_amt);
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl29 style='height:17.25pt' x:num><%=stt_none%></td>
  <td class=xl29 style='border-left:none'><%=seri%></td>
  <td class=xl29 style='border-left:none'><%=invoice_no%></td>
  <td class=xl29 style='border-left:none'><%=invoice_date%></td>
  <td class=xl29 style='border-left:none'><%=cust_name%></td>
  <td class=xl29 style='border-left:none'><%=cust_tax%></td>
  <td class=xl29 style='border-left:none'><%=item%></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>               </span><%=net_amt%></td>
  <td class=xl34 style='border-left:none'><%=tax_rate%></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%=vat_amt%></td>
  <td class=xl34 style='border-left:none'><%=voucher%> (<%=seq%>)<%=vat_note%>)</td>
  <td class=xl29 style='border-left:none'></td>
 </tr>
  <%
        }
    }
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl47 style='height:17.25pt'>T&#7893;ng</td>
  <td class=xl30 style='border-top:.5pt hairline windowtext'>&nbsp;</td>
  <td class=xl30 style='border-top:.5pt hairline windowtext'>&nbsp;</td>
  <td class=xl37 style='border-top:.5pt hairline windowtext' x:num><span
  style='mso-spacerun:yes'>                 </span><%=net_none%></td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none' x:num><span
  style='mso-spacerun:yes'>                     </span><%=vat_none%></td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl51 style='height:17.25pt'>2.Hàng hóa,
  d&#7883;ch v&#7909; ch&#7883;u thu&#7871; GTGT 0%</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl31>&nbsp;</td>
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
            invoice_date = invoice_dt.Substring(6,2) +"/" + invoice_dt.Substring(4,2)+ "/" + invoice_dt.Substring(0,4);
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
            if(net_amt.Trim() != "")
                net_0 += double.Parse(net_amt);
            if (vat_amt.Trim() != "")            
                vat_0 += double.Parse(vat_amt);
            if (net_amt.Trim() != "")                        
                net_sum += double.Parse(net_amt);
            if (vat_amt.Trim() != "")                        
                vat_sum += double.Parse(vat_amt);
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl29 style='height:17.25pt' x:num><%=stt0%></td>
  <td class=xl29 style='border-left:none'><%=seri%></td>
  <td class=xl29 style='border-left:none'><%=invoice_no%></td>
  <td class=xl29 style='border-left:none'><%=invoice_date%></td>
  <td class=xl29 style='border-left:none'><%=cust_name%></td>
  <td class=xl29 style='border-left:none'><%=cust_tax%></td>
  <td class=xl29 style='border-left:none'><%=item%></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>               </span><%=net_amt%></td>
  <td class=xl34 style='border-left:none'><%=tax_rate%></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%=vat_amt%></td>
  <td class=xl34 style='border-left:none'><%=voucher%> (<%=seq%>)<%=vat_note%>)</td>
  <td class=xl29 style='border-left:none'></td>
 </tr>
 <%
        }
    }
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl47 style='height:17.25pt'>T&#7893;ng</td>
  <td class=xl30 style='border-top:.5pt hairline windowtext'>&nbsp;</td>
  <td class=xl30 style='border-top:.5pt hairline windowtext'>&nbsp;</td>
  <td class=xl37 style='border-top:.5pt hairline windowtext' x:num><span
  style='mso-spacerun:yes'>                 </span><%=net_0%></td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none' x:num><span
  style='mso-spacerun:yes'>                     </span><%=vat_0%></td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl51 style='height:17.25pt'>3.Hàng hóa,
  d&#7883;ch v&#7909; ch&#7883;u thu&#7871; GTGT 5%</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td></td>
  <td class=xl32></td>
  <td class=xl31>&nbsp;</td>
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

 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl29 style='height:17.25pt' x:num><%=stt5%></td>
  <td class=xl29 style='border-left:none'><%=seri%></td>
  <td class=xl29 style='border-left:none'><%=invoice_no%></td>
  <td class=xl29 style='border-left:none'><%=invoice_date%></td>
  <td class=xl29 style='border-left:none'><%=cust_name%></td>
  <td class=xl29 style='border-left:none'><%=cust_tax%></td>
  <td class=xl29 style='border-left:none'><%=item%></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>               </span><%=net_amt%></td>
  <td class=xl34 style='border-left:none'><%=tax_rate%></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%=vat_amt%></td>
  <td class=xl34 style='border-left:none'><%=voucher%> (<%=seq%>)<%=vat_note%>)</td>
  <td class=xl29 style='border-left:none'></td>
 </tr>
 <%
        }
    }
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl47 style='height:17.25pt'>T&#7893;ng</td>
  <td class=xl30 style='border-top:.5pt hairline windowtext'>&nbsp;</td>
  <td class=xl30 style='border-top:.5pt hairline windowtext'>&nbsp;</td>
  <td class=xl37 style='border-top:.5pt hairline windowtext' x:num><span
  style='mso-spacerun:yes'>                 </span><%=net_5%></td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none' x:num><span
  style='mso-spacerun:yes'>                     </span><%=vat_5%></td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=6 height=23 class=xl49 style='height:17.25pt'>4.Hàng hóa,
  d&#7883;ch v&#7909; ch&#7883;u thu&#7871; GTGT 10%</td>
  <td></td>
  <td class=xl32></td>
  <td></td>
  <td class=xl32></td>
  <td class=xl31>&nbsp;</td>
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

 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl29 style='height:17.25pt' x:num><%=stt10%></td>
  <td class=xl29 style='border-left:none'><%=seri%></td>
  <td class=xl29 style='border-left:none'><%=invoice_no%></td>
  <td class=xl29 style='border-left:none'><%=invoice_date%></td>
  <td class=xl29 style='border-left:none'><%=cust_name%></td>
  <td class=xl29 style='border-left:none'><%=cust_tax%></td>
  <td class=xl29 style='border-left:none'><%=item%></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>               </span><%=net_amt%></td>
  <td class=xl34 style='border-left:none'><%=tax_rate%></td>
  <td class=xl34 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%=vat_amt%></td>
  <td class=xl34 style='border-left:none'><%=voucher%> (<%=seq%>)<%=vat_note%>)</td>
  <td class=xl29 style='border-left:none'></td>
 </tr>
 <%
        }
    }
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl47 style='height:17.25pt'>T&#7893;ng</td>
  <td class=xl30 style='border-top:.5pt hairline windowtext'>&nbsp;</td>
  <td class=xl30 style='border-top:.5pt hairline windowtext'>&nbsp;</td>
  <td class=xl37 style='border-top:.5pt hairline windowtext' x:num><span
  style='mso-spacerun:yes'>                 </span><%=net_10%></td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none' x:num><span
  style='mso-spacerun:yes'>                     </span><%=vat_10%></td>
  <td class=xl37 style='border-top:.5pt hairline windowtext;border-left:none'>&nbsp;</td>
 </tr>
 
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl45 style='height:17.25pt'>T&#7893;ng
  c&#7897;ng</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'>       
  </span><%=net_none + net_0 + net_5 + net_10 %></td>
  <td class=xl43 style='border-left:.5pt hairline windowtext'>&nbsp;</td>
  <td class=xl37 style='border-left:.5pt hairline windowtext' x:num><span
  style='mso-spacerun:yes'>       </span><%=vat_none + vat_0 + vat_5 + vat_10 %></td>
  <td class=xl44>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=4 class=xl66>T&#7893;ng giá tr&#7883; hàng hóa, d&#7883;ch
  v&#7909; bán ra:</td>
  <td class=xl37 style="border-left:none; border-bottom:none; border-right:none " x:num><span style='mso-spacerun:yes'>           
  </span><%=net_none + net_0 + net_5 + net_10 %></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl33></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=4 class=xl66>S&#7889; ti&#7873;n thu&#7871; GTGT c&#7911;a hàng
  hóa, dich v&#7909; bán ra:</td>
  <td class=xl33 x:num><span style='mso-spacerun:yes'>               
  </span><%=vat_none + vat_0 + vat_5 + vat_10 %></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=11 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl67>,Ngày<span style='mso-spacerun:yes'>   
  </span>tháng<span style='mso-spacerun:yes'>   </span>n&#259;m</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl40 colspan=2 style='mso-ignore:colspan'>Ng&#432;&#7901;i
  l&#7853;p phi&#7871;u</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl40>K&#7871; toán Tr&#432;&#7903;ng</td>
  <td></td>
  <td colspan=3 class=xl68>Giám &#272;&#7889;c</td>
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
 </tr>
 <![endif]>
</table>

</body>

</html>
