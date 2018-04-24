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
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="VAT_Out%2011%20_files/filelist.xml">
<link rel=Edit-Time-Data href="VAT_Out%2011%20_files/editdata.mso">
<link rel=OLE-Object-Data href="VAT_Out%2011%20_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2011-11-04T05:58:22Z</o:LastPrinted>
  <o:Created>2008-08-04T09:01:52Z</o:Created>
  <o:LastSaved>2011-11-04T06:01:57Z</o:LastSaved>
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
.xl27
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
.xl28
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl44
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;}
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
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl50
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
.xl51
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl54
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
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	text-align:left;}
.xl57
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
.xl58
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
.xl59
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
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl61
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
.xl62
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
.xl63
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
.xl64
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
.xl65
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
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl67
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
.xl68
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
	border-left:none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl78
	{mso-style-parent:style0;
	text-align:right;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:.5pt hairline windowtext;
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
     <x:TopRowBottomPane>37</x:TopRowBottomPane>
     <x:SplitVertical>4</x:SplitVertical>
     <x:LeftColumnRightPane>6</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>10</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>12</x:ActiveCol>
       <x:RangeSelection>$M$21:$M$22</x:RangeSelection>
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
  <x:WindowHeight>9825</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1183 style='border-collapse:
 collapse;table-layout:fixed;width:888pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:1152;width:20pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2858;width:50pt'>
 <col width=70 style='mso-width-source:userset;mso-width-alt:2986;width:53pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3968;width:70pt'>
 <col width=174 style='mso-width-source:userset;mso-width-alt:7424;width:131pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:4266;width:75pt'>
 <col width=143 style='mso-width-source:userset;mso-width-alt:6101;width:107pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:4266;width:75pt'>
 <col width=52 style='mso-width-source:userset;mso-width-alt:2218;width:39pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3584;width:63pt'>
 <col width=145 style='mso-width-source:userset;mso-width-alt:6186;width:109pt'>
 <col width=1 style='mso-width-source:userset;mso-width-alt:42;width:1pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:3370;width:59pt'>
 <col width=48 style='mso-width-source:userset;mso-width-alt:2048;width:36pt'>
 <col width=53 style='mso-width-source:userset;mso-width-alt:2261;width:40pt'>
 <tr height=31 style='height:23.25pt'>
  <td colspan=11 height=31 class=xl24 width=1055 style='height:23.25pt;
  width:792pt'>BẢNG KÊ HÓA ĐƠN, CHỨNG TỪ HÀNG HÓA DICH VỤ BÁN RA</td>
  <td width=1 style='width:1pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=48 style='width:36pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=3 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl60 style='border-right:.5pt solid black'>Tháng 10<span
  style='mso-spacerun:yes'>    </span>năm 2011</td>
  <td colspan=4 rowspan=4 class=xl62 width=381 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:286pt'>Mẫu số:01-2/GTGT<br>
    (Ban hành theo thông tư số60/2007/TT-BTC ngày 14/6/2007 của Bộ Tài Chính )</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>Tên cơ sở kinh doanh :</td>
  <td colspan=3 class=xl56><%=lname %></td>
  <td></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25>Địa chỉ<span style='mso-spacerun:yes'>    </span>:</td>
  <td></td>
  <td colspan=3 class=xl56><%=address%></td>
  <td></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>Mã số thuế:</td>
  <td colspan=3 class=xl56><%=tax_code%></td>
  <td></td>
  <td colspan=3 class=xl26>Đơn vị tiền<span style='mso-spacerun:yes'> 
  </span>:<span style='mso-spacerun:yes'>  </span>ĐỒNG VIỆT NAM</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=2 height=57 class=xl54 width=27 style='border-bottom:.5pt solid black;
  height:42.75pt;width:20pt'>STT</td>
  <td colspan=3 class=xl57 width=230 style='border-right:.5pt solid black;
  border-left:none;width:173pt'>Hóa đơn, chứng từ, biên lai nộp thuế</td>
  <td rowspan=2 class=xl54 width=174 style='border-bottom:.5pt solid black;
  width:131pt'>Tên người bán</td>
  <td rowspan=2 class=xl54 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Mã số thuế của người mua</td>
  <td rowspan=2 class=xl54 width=143 style='border-bottom:.5pt solid black;
  width:107pt'>Mặt hàng</td>
  <td rowspan=2 class=xl54 width=100 style='border-bottom:.5pt solid black;
  width:75pt'>Doanh số bán chưa có thuế</td>
  <td rowspan=2 class=xl54 width=52 style='border-bottom:.5pt solid black;
  width:39pt'>Thuế suất</td>
  <td rowspan=2 class=xl54 width=84 style='border-bottom:.5pt solid black;
  width:63pt'>Thuế GTGT đầu ra</td>
  <td rowspan=2 class=xl54 width=145 style='border-bottom:.5pt solid black;
  width:109pt'>Ghi chú</td>
  <td rowspan=3 class=xl70>&nbsp;</td>
  <td rowspan=2 class=xl54 width=79 style='border-bottom:.5pt solid black;
  width:59pt' x:str="Thành tiền ">Thành tiền<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl54 width=48 style='border-bottom:.5pt solid black;
  width:36pt'>Tỷ giá</td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl27 width=67 style='height:26.25pt;width:50pt'>Ký hiệu
  hóa đơn</td>
  <td class=xl27 width=70 style='width:53pt'>Số hóa đơn</td>
  <td class=xl27 width=93 style='width:70pt'>Ngày, tháng, năm phát hành</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt' x:num>1</td>
  <td class=xl29 x:num>2</td>
  <td class=xl29 x:num>3</td>
  <td class=xl29 x:num>4</td>
  <td class=xl29 x:num>5</td>
  <td class=xl29 x:num>6</td>
  <td class=xl29 x:num>7</td>
  <td class=xl29 x:num>8</td>
  <td class=xl29 x:num>9</td>
  <td class=xl29 x:num>10</td>
  <td class=xl29 x:num>11</td>
  <td class=xl72 style='border-left:none'>&nbsp;</td>
  <td class=xl72 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl52 style='height:17.25pt'>1.Hàng hóa, dịch vụ
  không chịu thuế GTGT</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td></td>
  <td class=xl71 style='border-top:none'>&nbsp;</td>
  <td class=xl73 style='border-top:none'>&nbsp;</td>
 </tr>
  <%
      decimal v_tot_trans_usd = 0, v_grand_tot_trans_usd = 0;
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
            if (dt_none.Rows[i][19].ToString().Trim() != "")
              {
                  v_tot_trans_usd += decimal.Parse(dt_none.Rows[i][19].ToString());
              }                            
  %>
  <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 align=right style='height:17.25pt;border-top:none'
  x:str><%=stt0%></td>
  <td class=xl35 style='border-top:none'><%=seri %></td>
  <td class=xl35 style='border-top:none'><%=invoice_no %></td>
  <td class=xl35 style='border-top:none'><%=invoice_date %></td>
  <td class=xl35 style='border-top:none'><%=cust_name%><span
  style='display:none'></span></td>
  <td class=xl35><%=cust_tax%></td>
  <td class=xl35><%=item%></span></td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>         
  </span><%=net_amt %> </td>
  <td class=xl36 ><span style='mso-spacerun:yes'> </span><%=tax_rate%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:num><span
  style='mso-spacerun:yes'>                        </span><%=vat_amt%> </td>
  <td class=xl36 style='border-top:none' x:str><span
  style='mso-spacerun:yes'> </span><%=voucher%> (<%=seq%>)<%=vat_note%>)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl76 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_none.Rows[i][19].ToString()%> </td>
  <td class=xl80 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_none.Rows[i][20].ToString()%><span style='mso-spacerun:yes'> </span></td>
 </tr>
<%
    }
    }
%>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl47 style='height:17.25pt'>Tổng</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32 x:num><span
  style='mso-spacerun:yes'>                             </span>- </td>
  <td class=xl33>&nbsp;</td>
  <td class=xl33 x:num><span
  style='mso-spacerun:yes'>                        </span>- </td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl74>&nbsp;</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl52 style='height:17.25pt'>2.Hàng hóa, dịch vụ
  chịu thuế GTGT 0%</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td></td>
  <td class=xl71>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
 </tr>
  <%
      
      v_grand_tot_trans_usd += v_tot_trans_usd;
      v_tot_trans_usd = 0;
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
              if (dt_0.Rows[i][19].ToString().Trim() != "")
              {
                  v_tot_trans_usd += decimal.Parse(dt_0.Rows[i][19].ToString());
              }                
  %>

 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 align=right style='height:17.25pt;border-top:none'
  x:num><%=stt0%></td>
  <td class=xl35 style='border-top:none'><%=seri%></td>
  <td class=xl35 style='border-top:none'><%=invoice_no%></td>
  <td class=xl35 style='border-top:none'><%=invoice_date%></td>
  <td class=xl35 style='border-top:none'><%=cust_name%><span
  style='display:none'></span></td>
  <td class=xl35><%=cust_tax%></td>
  <td class=xl35><%=item%></span></td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>         
  </span><%=net_amt%> </td>
  <td class=xl36 x:str><span style='mso-spacerun:yes'> </span><%=tax_rate%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:num><span
  style='mso-spacerun:yes'>                        </span><%=vat_amt%> </td>
  <td class=xl36 style='border-top:none' x:str><span
  style='mso-spacerun:yes'> </span><%=voucher%> (<%=seq%>)<%=vat_note%>)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl76 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_0.Rows[i][19].ToString()%> </td>
  <td class=xl80 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_0.Rows[i][20].ToString()%><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <% 
      }
      }
            %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl47 style='height:17.25pt'>Tổng</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=net_0%> </td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%=vat_0%> </td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td></td>
  <td class=xl77 style='border-top:none' x:num
  ><span style='mso-spacerun:yes'>     </span><%=v_tot_trans_usd %>
  </td>
  <td class=xl78 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
  <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl52 style='height:17.25pt'>3.Hàng hóa, dịch vụ chịu thuế GTGT 5%</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td></td>
  <td class=xl71>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
 </tr>
  <%
      v_grand_tot_trans_usd += v_tot_trans_usd;
      v_tot_trans_usd = 0;
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
            if (dt_5.Rows[i][19].ToString().Trim() == "")
            {
                v_tot_trans_usd += decimal.Parse(dt_5.Rows[i][19].ToString().Trim());
            }
  %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 align=right style='height:17.25pt;border-top:none'
  x:num><%=stt0%></td>
  <td class=xl35 style='border-top:none'><%=seri%></td>
  <td class=xl35 style='border-top:none'><%=invoice_no%></td>
  <td class=xl35 style='border-top:none'><%=invoice_date%></td>
  <td class=xl35 style='border-top:none'><%=cust_name%><span
  style='display:none'></span></td>
  <td class=xl35><%=cust_tax%></td>
  <td class=xl35><%=item%></span></td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>         
  </span><%=net_amt%> </td>
  <td class=xl36 x:str><span style='mso-spacerun:yes'> </span><%=tax_rate%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:num><span
  style='mso-spacerun:yes'>                        </span><%=vat_amt%> </td>
  <td class=xl36 style='border-top:none' x:str><span
  style='mso-spacerun:yes'> </span><%=voucher%> (<%=seq%>)<%=vat_note%>)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl76 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_5.Rows[i][19].ToString()%> </td>
  <td class=xl80 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_5.Rows[i][20].ToString()%><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <% 
      }
      }
            %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl47 style='height:17.25pt'>Tổng</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=net_5%> </td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%=vat_5%> </td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td></td>
  <td class=xl77 style='border-top:none' x:num
  ><span style='mso-spacerun:yes'>     </span><%=v_tot_trans_usd %>
  </td>
  <td class=xl78 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
  <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl52 style='height:17.25pt'>4.Hàng hóa, dịch vụ chịu thuế GTGT 10%</td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td></td>
  <td class=xl71>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
 </tr>
  <%
      v_grand_tot_trans_usd += v_tot_trans_usd;
      v_tot_trans_usd = 0;
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
            if (dt_10.Rows[i][19].ToString().Trim() != "")
            {
                v_tot_trans_usd += decimal.Parse(dt_10.Rows[i][19].ToString());
            }
    %>


 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 align=right style='height:17.25pt;border-top:none'
  x:num><%=stt0%></td>
  <td class=xl35 style='border-top:none'><%=seri%></td>
  <td class=xl35 style='border-top:none'><%=invoice_no%></td>
  <td class=xl35 style='border-top:none'><%=invoice_date%></td>
  <td class=xl35 style='border-top:none'><%=cust_name%><span
  style='display:none'></span></td>
  <td class=xl35><%=cust_tax%></td>
  <td class=xl35><%=item%></span></td>
  <td class=xl36 x:num><span style='mso-spacerun:yes'>         
  </span><%=net_amt%> </td>
  <td class=xl36 x:str><span style='mso-spacerun:yes'> </span><%=tax_rate%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 x:num><span
  style='mso-spacerun:yes'>                        </span><%=vat_amt%> </td>
  <td class=xl36 style='border-top:none' x:str><span
  style='mso-spacerun:yes'> </span><%=voucher%> (<%=seq%>)<%=vat_note%>)<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl76 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_10.Rows[i][19].ToString()%> </td>
  <td class=xl80 style='border-top:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt_10.Rows[i][20].ToString()%><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <% 
      }
      }
            %>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl47 style='height:17.25pt'>Tổng</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl31 style='border-top:none'>&nbsp;</td>
  <td class=xl32 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=net_10%> </td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>                        </span><%=vat_10%> </td>
  <td class=xl79 style='border-top:none;border-left:none'>&nbsp;</td>
  <td></td>
  <td class=xl77 style='border-top:none' x:num
  ><span style='mso-spacerun:yes'>     </span><%=v_tot_trans_usd %>
  </td>
  <td class=xl78 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>

 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=5 height=23 class=xl49 style='height:17.25pt'>Tổng cộng</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl32 x:num><span style='mso-spacerun:yes'> 
  </span><%=net_none + net_0 + net_5 + net_10 %> </td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40 x:num><span style='mso-spacerun:yes'> 
  </span><%=vat_none + vat_0 + vat_5 + vat_10 %> </td>
  <td class=xl41>&nbsp;</td>
  <td></td>
  <td class=xl77 x:num><span style='mso-spacerun:yes'>    
  </span><%=v_grand_tot_trans_usd %> </td>
  <td class=xl75 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=4 class=xl51>Tổng giá trị hàng hóa, dịch vụ bán ra:</td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'> 
  </span><%=net_none + net_0 + net_5 + net_10 %> </td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=5 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl43></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 style='height:13.5pt'></td>
  <td colspan=4 class=xl51>Số tiền thuế GTGT của hàng hóa, dich vụ bán ra:</td>
  <td class=xl43 x:num><span style='mso-spacerun:yes'>      
  </span><%=vat_none + vat_0 + vat_5 + vat_10 %> </td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl45>,Ngày<span style='mso-spacerun:yes'>   
  </span>tháng<span style='mso-spacerun:yes'>   </span>năm</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 colspan=2 style='height:13.5pt;mso-ignore:colspan'></td>
  <td class=xl37 colspan=2 style='mso-ignore:colspan'>Người lập phiếu</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl37>Kế toán Trưởng</td>
  <td></td>
  <td colspan=3 class=xl46>Giám Đốc</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=27 style='width:20pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=174 style='width:131pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=1 style='width:1pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=48 style='width:36pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
