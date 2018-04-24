<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    
    string p_com = "" + Request["com"];
    string p_month = "" + Request["yyyymm"];
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
    double stt0 = 0;
    double stt5 = 0;
    double stt10 = 0;
    double sttnone = 0;
    double net_none = 0;
    double vat_none = 0;
    double net_0 = 0;
    double net_5 = 0;
    double net_10 = 0;
    double vat_0 = 0;
    double vat_5 = 0;
    double vat_10 = 0;
    double vat_sum = 0;
    double net_sum = 0;
    double rate = 0;
    
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
    SQLD += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, b.PARTNER_LNAME,";
    SQLD += "         b.tax_code,b.ADDR1|| b.ADDR2||b.ADDR3 address, a.tco_ciitem_nm, a.ccy, a.tax_rate, nvl(a.net_amt,0), ";
    SQLD += "         nvl(a.tax_amt,0), a.voucherno ,a.vat_note";
    SQLD += "    FROM tac_mtvat a, tac_hgtrd d , tac_hgtrh h, tco_buspartner b";
    SQLD += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0 and b.del_if(+) = 0";
    SQLD += "     AND a.TCO_BUSPARTNER_PK = b.pk(+)";
    SQLD += "     AND a.tac_hgtrd_pk = d.pk ";
    SQLD += "     AND d.tac_hgtrh_pk = h.pk ";
    SQLD += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQLD += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQLD += "     AND a.std_ym = '"+ p_month +"' ";
    SQLD += "     AND a.vat_type = '2' ";
    SQLD += "     AND a.tax_rate = 'none%' ";
    SQLD += "     AND a.tr_status = '" + p_status + "' ";
    SQLD += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQLD += "ORDER BY a.invoice_date, a.invoice_no ";
    DataTable dt_none = ESysLib.TableReadOpen(SQLD);
    
    string SQL0 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL0 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, b.PARTNER_LNAME, ";
    SQL0 += "         b.tax_code,b.ADDR1|| b.ADDR2||b.ADDR3 address, a.tco_ciitem_nm, a.ccy, a.tax_rate, nvl(a.net_amt,0), ";
    SQL0 += "         nvl(a.tax_amt,0), h.voucherno ,a.vat_note";
    SQL0 += "    FROM tac_mtvat a, tac_hgtrd d, tac_hgtrh h, tco_buspartner b ";
    SQL0 += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if= 0 and b.del_if(+) = 0";
    SQL0 += "     AND a.tac_hgtrd_pk = d.pk ";
    SQL0 += "     AND d.tac_hgtrh_pk = h.pk ";
    SQL0 += "     AND a.TCO_BUSPARTNER_PK = b.pk(+)";
    SQL0 += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQL0 += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQL0 += "     AND a.std_ym = '"+ p_month +"' ";
    SQL0 += "     AND a.vat_type = '2' ";
    SQL0 += "     AND a.tax_rate = '0%' ";
    SQL0 += "     AND a.tr_status = '" + p_status + "' ";
    SQL0 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL0 += "ORDER BY a.invoice_date, a.invoice_no ";
    DataTable dt_0 = ESysLib.TableReadOpen(SQL0);

    string SQL5 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL5 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, b.PARTNER_LNAME,  ";
    SQL5 += "         b.tax_code,b.ADDR1|| b.ADDR2||b.ADDR3 address, a.tco_ciitem_nm, a.ccy, a.tax_rate, nvl(a.net_amt,0), ";
    SQL5 += "         nvl(a.tax_amt,0), h.voucherno ,a.vat_note";
    SQL5 += "    FROM tac_mtvat a, tac_hgtrd d, tac_hgtrh h, tco_buspartner b  ";
    SQL5 += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0 and b.del_if(+) = 0";
    SQL5 += "     AND a.tac_hgtrd_pk = d.pk ";
    SQL5 += "     AND d.tac_hgtrh_pk = h.pk ";
    SQL5 += "     AND a.TCO_BUSPARTNER_PK = b.pk(+)";
    SQL5 += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQL5 += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQL5 += "     AND a.std_ym = '" + p_month + "' ";
    SQL5 += "     AND a.vat_type = '2' ";
    SQL5 += "     AND a.tax_rate = '5%' ";
    SQL5 += "     AND a.tr_status = '" + p_status + "' ";
    SQL5 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL5 += "ORDER BY a.invoice_date, a.invoice_no ";
    DataTable dt_5 = ESysLib.TableReadOpen(SQL5);

    string SQL10 = " SELECT   d.tac_hgtrh_pk seq, a.pk, a.tco_company_pk, a.vat_type, a.seri_no, ";
    SQL10 += "         a.invoice_date, a.invoice_no, a.tco_buspartner_pk, b.PARTNER_LNAME,   ";
    SQL10 += "         b.tax_code,b.ADDR1|| b.ADDR2||b.ADDR3 address, a.tco_ciitem_nm, a.ccy, a.tax_rate, nvl(a.net_amt,0), ";
    SQL10 += "         nvl(a.tax_amt,0), h.voucherno ,a.vat_note";
    SQL10 += "    FROM tac_mtvat a, tac_hgtrd d , tac_hgtrh h, tco_buspartner b";
    SQL10 += "   WHERE a.del_if = 0 AND d.del_if = 0 AND h.del_if = 0 and b.del_if(+) = 0";
    SQL10 += "     AND a.tac_hgtrd_pk = d.pk ";
    SQL10 += "     AND d.tac_hgtrh_pk = h.pk ";
    SQL10 += "     AND a.TCO_BUSPARTNER_PK = b.pk(+)";
    SQL10 += "     AND a.TAC_ABACCTCODE_PK like decode('" + p_acc_pk + "','','%','" + p_acc_pk + "')";
    SQL10 += "     AND a.tco_company_pk = '" + p_com + "' ";
    SQL10 += "     AND a.std_ym = '" + p_month + "' ";
    SQL10 += "     AND a.vat_type = '2' ";
    SQL10 += "     AND a.tax_rate = '10%' ";
    SQL10 += "     AND a.tr_status = '" + p_status + "' ";
    SQL10 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL10 += "ORDER BY a.invoice_date, a.invoice_no ";
    DataTable dt_10 = ESysLib.TableReadOpen(SQL10);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gflv00400_import_VAT_out_files/filelist.xml">
<link rel=Edit-Time-Data href="gflv00400_import_VAT_out_files/editdata.mso">
<link rel=OLE-Object-Data href="gflv00400_import_VAT_out_files/oledata.mso">
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
  <o:LastAuthor>Acc</o:LastAuthor>
  <o:LastPrinted>2008-09-15T03:28:39Z</o:LastPrinted>
  <o:Created>2008-09-15T03:21:10Z</o:Created>
  <o:LastSaved>2008-11-10T05:06:24Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .75in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font6
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;
	padding-left:48px;
	mso-char-indent-count:4;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	mso-number-format:0%;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;
	padding-left:180px;
	mso-char-indent-count:15;}
.xl44
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:justify;
	background:white;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl46
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
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
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>15</x:SplitHorizontal>
     <x:TopRowBottomPane>21</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>30</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
       <x:RangeSelection>$J$31:$J$32</x:RangeSelection>
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
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026" u1:ext="edit"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1007 style='border-collapse:
 collapse;table-layout:fixed;width:757pt'>
 <col class=xl24 width=13 style='mso-width-source:userset;mso-width-alt:475;
 width:10pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl25 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=204 style='mso-width-source:userset;mso-width-alt:7460;
 width:153pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=37 style='mso-width-source:userset;mso-width-alt:1353;
 width:28pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl24 width=13 style='height:25.5pt;width:10pt'>&nbsp;</td>
  <td rowspan=2 height=34 width=51 style='height:25.5pt;width:38pt' align=left
  valign=top><u3:shapetype id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe"><u3:stroke joinstyle="miter"/><u3:path gradientshapeok="t" o:connecttype="rect"/></u3:shapetype><u3:shape id="_x0000_s1025" type="#_x0000_t202" style="position:absolute;&#13;&#10;   margin-left:.75pt;margin-top:10.5pt;width:118.5pt;height:46.5pt;z-index:1;&#13;&#10;   mso-wrap-style:tight"><u3:textbox style="mso-next-textbox:#_x0000_s1025;mso-direction-alt:auto"><!--[if gte vml 1]><v:shapetype
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" alt="Text Box: Mẫu số: 01- 1/GTGT&#10;(Ban hành kèm theo Thông tư số 60/2007/TT-BTC ngày  &#10;14/6/2007 của  Bộ Tài chính)&#10;&nbsp;"
   style='position:absolute;margin-left:0;margin-top:12.75pt;width:120pt;
   height:48pt;z-index:1'>
   <v:imagedata src="gflv00400_import_VAT_out_files/image001.gif"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:17px;width:160px;
  height:64px'><img width=160 height=64
  src="gflv00400_import_VAT_out_files/image001.gif"
  alt="Text Box: Mẫu số: 01- 1/GTGT&#10;(Ban hành kèm theo Thông tư số 60/2007/TT-BTC ngày  &#10;14/6/2007 của  Bộ Tài chính)&#10;&nbsp;"
  u3:shapes="_x0000_s1025" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=34 class=xl45 width=51 style='height:25.5pt;
    width:38pt'>Mẫu số: <font class="font7">01- 2/GTGT</font><font class="font6"><br>
        </font><font class="font8">(Ban hành kèm theo Thông tư số
    60/2007/TT-BTC ngày<span style='mso-spacerun:yes'>  </span></font><font
    class="font6"><br>
        </font><font class="font8">14/6/2007 của<span
    style='mso-spacerun:yes'>  </span>Bộ Tài chính)</font><font class="font6"><br>
        &nbsp;</font></td>
   </tr>
  </table>
  </span></td>
  <td rowspan=2 class=xl24 width=72 style='width:54pt'>&nbsp;</td>
  <td rowspan=2 class=xl24 width=71 style='width:53pt'>&nbsp;</td>
  <td rowspan=2 class=xl25 width=76 style='width:57pt'>&nbsp;</td>
  <td rowspan=2 class=xl24 width=204 style='width:153pt'>&nbsp;</td>
  <td rowspan=2 class=xl24 width=105 style='width:79pt'>&nbsp;</td>
  <td rowspan=2 class=xl24 width=113 style='width:85pt'>&nbsp;</td>
  <td rowspan=2 class=xl24 width=90 style='width:68pt'>&nbsp;</td>
  <td rowspan=2 class=xl24 width=37 style='width:28pt'>&nbsp;</td>
  <td rowspan=2 class=xl24 width=86 style='width:65pt'>&nbsp;</td>
  <td rowspan=2 class=xl24 width=89 style='width:67pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  </u3:textbox></u3:shape>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl24>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl24>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'>&nbsp;</td>
  <td colspan=11 class=xl26>BẢNG KÊ HOÁ ĐƠN, CHỨNG TỪ HÀNG HOÁ, DỊCH VỤ BÁN RA</td>
 </tr>
 <tr height=0 style='display:none'>
  <td class=xl24>B<span style='display:none'>angkemuavao.xls</span></td>
  <td colspan=11 class=xl26>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl27>(Kèm theo tờ khai thuế GTGT theo mẫu số 01/GTGT)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl27>Kỳ tính thuế: Tháng <%=month%> năm <%=year%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td colspan=2 class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl24>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl25 x:str="Người nộp thuế:        ">Người nộp
  thuế:<span style='mso-spacerun:yes'>        </span><%=lname%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl25>Mã số thuế:<%=tax_code%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl24>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td colspan=11 class=xl46>Đơn vị tiền: đồng Việt Nam</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td rowspan=3 class=xl48 width=51 style='border-bottom:1.0pt solid black;
  border-top:none;width:38pt'>STT</td>
  <td colspan=3 rowspan=2 class=xl50 width=219 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;width:164pt'>Hoá đơn, chứng từ, biên lai nộp
  thuế</td>
  <td rowspan=3 class=xl48 width=204 style='border-bottom:1.0pt solid black;
  border-top:none;width:153pt'>Tên người bán</td>
  <td rowspan=3 class=xl48 width=105 style='border-bottom:1.0pt solid black;
  border-top:none;width:79pt'>Mã số thuế người bán</td>
  <td rowspan=3 class=xl48 width=113 style='border-bottom:1.0pt solid black;
  border-top:none;width:85pt'>Mặt hàng</td>
  <td rowspan=3 class=xl48 width=90 style='border-bottom:1.0pt solid black;
  border-top:none;width:68pt'>Doanh số mua chưa có thuế</td>
  <td rowspan=3 class=xl48 width=37 style='border-bottom:1.0pt solid black;
  border-top:none;width:28pt'>Thuế suất</td>
  <td rowspan=3 class=xl48 width=86 style='border-bottom:1.0pt solid black;
  border-top:none;width:65pt'>Thuế GTGT</td>
  <td rowspan=3 class=xl48 width=89 style='border-bottom:1.0pt solid black;
  border-top:none;width:67pt'>Ghi chú</td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl24 style='height:4.5pt'>&nbsp;</td>
 </tr>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl24 style='height:35.25pt'>&nbsp;</td>
  <td class=xl29 width=72 style='width:54pt'>Ký hiệu hoá đơn</td>
  <td class=xl29 width=71 style='width:53pt'>Số hoá đơn</td>
  <td class=xl30 width=76 style='width:57pt'>Ngày, tháng, năm phát hành</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl31 width=51 style='width:38pt'>[1]</td>
  <td class=xl32 width=72 style='width:54pt'>[2]</td>
  <td class=xl32 width=71 style='width:53pt'>[3]</td>
  <td class=xl33 width=76 style='width:57pt'>[4]</td>
  <td class=xl32 width=204 style='width:153pt'>[5]</td>
  <td class=xl34 width=105 style='width:79pt'>[6]</td>
  <td class=xl34 width=113 style='width:85pt'>[7]</td>
  <td class=xl32 width=90 style='width:68pt'>[8]</td>
  <td class=xl32 width=37 style='width:28pt'>[9]</td>
  <td class=xl32 width=86 style='width:65pt'>[10]</td>
  <td class=xl32 width=89 style='width:67pt'>[11]</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td colspan=11 class=xl56 width=994 style='border-right:1.0pt solid black;
  width:747pt'>1.Hàng hóa, dịch vụ không chịu thuế GTGT:</td>
 </tr>
 <%
     if (dt_none.Rows.Count > 0)
     {
         for (int i = 0; i < dt_none.Rows.Count; i++)
         {
             sttnone += 1;
             seq = dt_none.Rows[i][0].ToString();
             seri = dt_none.Rows[i][4].ToString();
             invoice_dt = dt_none.Rows[i][5].ToString();
             if (invoice_dt != "")
             {
                 invoice_date = invoice_dt.Substring(6, 2) + "/" + invoice_dt.Substring(4, 2) + "/" + invoice_dt.Substring(0, 4);
             } 
             invoice_no = dt_none.Rows[i][6].ToString();
             cust_name = dt_none.Rows[i][8].ToString();
             cust_tax = dt_none.Rows[i][9].ToString();
             cust_addr = dt_none.Rows[i][10].ToString();
             item = dt_none.Rows[i][11].ToString();
             tax_rate = dt_none.Rows[i][13].ToString();
             tax_rate = tax_rate.Substring(0, tax_rate.Length - 1);
             rate = 0;
             net_amt = dt_none.Rows[i][14].ToString();
             vat_amt = dt_none.Rows[i][15].ToString();
             voucher = dt_none.Rows[i][16].ToString();
             vat_note = dt_none.Rows[i][17].ToString();
             net_none += double.Parse(net_amt);
             vat_none += double.Parse(vat_amt);
             net_sum += double.Parse(net_amt);
             vat_sum += double.Parse(vat_amt);
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl35 width=51 style='width:38pt'><%=sttnone%></td>
  <td class=xl36><%=seri%></td>
  <td class=xl37><%=invoice_no%></td>
  <td class=xl37><%=invoice_date%></td>
  <td class=xl37><%=cust_name%></td>
  <td class=xl37 x:str><%=cust_tax%></td>
  <td class=xl37><%=item%></td>
  <td class=xl37 x:num><%=net_amt%></td>
  <td class=xl38 x:num><%=rate%></td>
  <td class=xl37 x:num><%=vat_amt%></td>
  <td class=xl37><%=voucher%></td>
 </tr>
 <%     }
    }
  %><%else { %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl35 width=51 style='width:38pt'>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38><span style='mso-spacerun:yes'> </span></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <%
        }
   %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl39 width=51 style='width:38pt'>Tổng</td>
  <td class=xl40 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl40 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl41 width=76 style='width:57pt'>&nbsp;</td>
  <td class=xl40 width=204 style='width:153pt'>&nbsp;</td>
  <td class=xl40 width=105 style='width:79pt'>&nbsp;</td>
  <td class=xl40 width=113 style='width:85pt'>&nbsp;</td>
  <td class=xl42 style='border-top:none' x:num><%=net_none%></td>
  <td class=xl40 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl42 style='border-top:none' x:num><%=vat_none%></td>
  <td class=xl40 width=89 style='width:67pt'>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td colspan=11 class=xl56 width=994 style='border-right:1.0pt solid black;
  width:747pt'>2.Hàng hoá, dịch vụ chịu thuế suất thuế GTGT 0%</td>
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
            tax_rate = tax_rate.Substring(0,tax_rate.Length -1);
            rate = double.Parse(tax_rate);// / 100;
            net_amt = dt_0.Rows[i][14].ToString();
            vat_amt = dt_0.Rows[i][15].ToString();
            voucher = dt_0.Rows[i][16].ToString();
            vat_note = dt_0.Rows[i][17].ToString();
            net_0 += double.Parse(net_amt);
            vat_0 += double.Parse(vat_amt);
            net_sum += double.Parse(net_amt);
            vat_sum += double.Parse(vat_amt);
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl35 width=51 style='width:38pt'><%=stt0 %></td>
  <td class=xl36><%=seri %></td>
  <td class=xl37><%=invoice_no %></td>
  <td class=xl37><%=invoice_date %></td>
  <td class=xl37><%=cust_name %></td>
  <td class=xl37 x:str><%=cust_tax %></td>
  <td class=xl37><%=item %></td>
  <td class=xl37 x:num><%=net_amt %></td>
  <td class=xl38 x:str><%=rate %></td>
  <td class=xl37 x:num><%=vat_amt %></td>
  <td class=xl37><%=voucher %>(<%=seq%>)(<%=vat_note%>)</td>
 </tr>
 <%     }
    }
  %><%else { %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl35 width=51 style='width:38pt'>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38><span style='mso-spacerun:yes'> </span></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <%
        }
   %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl39 width=51 style='width:38pt'>Tổng</td>
  <td class=xl40 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl40 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl41 width=76 style='width:57pt'>&nbsp;</td>
  <td class=xl40 width=204 style='width:153pt'>&nbsp;</td>
  <td class=xl40 width=105 style='width:79pt'>&nbsp;</td>
  <td class=xl40 width=113 style='width:85pt'>&nbsp;</td>
  <td class=xl42 style='border-top:none' x:num><%=net_0%></td>
  <td class=xl40 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl42 style='border-top:none' x:num><%=vat_0%></td>
  <td class=xl40 width=89 style='width:67pt'>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td colspan=11 class=xl56 width=994 style='border-right:1.0pt solid black;
  width:747pt'>3.Hàng hoá, dịch vụ chịu thuế suất thuế GTGT 5%</td>
 </tr>
 <%
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
             tax_rate = tax_rate.Substring(0, tax_rate.Length - 1);
             rate = double.Parse(tax_rate); /// 100;
             net_amt = dt_5.Rows[i][14].ToString();
             vat_amt = dt_5.Rows[i][15].ToString();
             voucher = dt_5.Rows[i][16].ToString();
             vat_note = dt_5.Rows[i][17].ToString();
             net_5 += double.Parse(net_amt);
             vat_5 += double.Parse(vat_amt);
             net_sum += double.Parse(net_amt);
             vat_sum += double.Parse(vat_amt);
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl35 width=51 style='width:38pt'><%=stt5%></td>
  <td class=xl36><%=seri%></td>
  <td class=xl37><%=invoice_no%></td>
  <td class=xl37><%=invoice_date%></td>
  <td class=xl37><%=cust_name%></td>
  <td class=xl37 x:str><%=cust_tax%></td>
  <td class=xl37><%=item%></td>
  <td class=xl37 x:num><%=net_amt%></td>
  <td class=xl38 style='mso-number-format:"\@";' x:str><%=rate %></td>
  <td class=xl37 x:num><%=vat_amt%></td>
  <td class=xl37><%=voucher%>(<%=seq%>)(<%=vat_note%>)</td>
 </tr>
 <%     }
    } %><%else { %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl35 width=51 style='width:38pt'>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38><span style='mso-spacerun:yes'> </span></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <%
        }
   %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl39 width=51 style='width:38pt'>Tổng</td>
  <td class=xl40 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl40 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl41 width=76 style='width:57pt'>&nbsp;</td>
  <td class=xl40 width=204 style='width:153pt'>&nbsp;</td>
  <td class=xl40 width=105 style='width:79pt'>&nbsp;</td>
  <td class=xl40 width=113 style='width:85pt'>&nbsp;</td>
  <td class=xl42 style='border-top:none' x:num><%=net_5%></td>
  <td class=xl40 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl42 style='border-top:none' x:num><%=vat_5%></td>
  <td class=xl40 width=89 style='width:67pt'>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td colspan=11 class=xl56 width=994 style='border-right:1.0pt solid black;
  width:747pt'>4. Hàng hoá, dịch vụ chịu thuế suất thuế GTGT 10%:</td>
 </tr>
 <%
     if (dt_10.Rows.Count > 0)
     {
         for (int i = 0; i < dt_10.Rows.Count; i++)
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
             tax_rate = tax_rate.Substring(0, tax_rate.Length - 1);
             rate = double.Parse(tax_rate);// / 100;
             net_amt = dt_10.Rows[i][14].ToString();
             vat_amt = dt_10.Rows[i][15].ToString();
             voucher = dt_10.Rows[i][16].ToString();
             vat_note = dt_10.Rows[i][17].ToString();
             net_10 += double.Parse(net_amt);
             vat_10 += double.Parse(vat_amt);
             net_sum += double.Parse(net_amt);
             vat_sum += double.Parse(vat_amt);
  %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl35 width=51 style='width:38pt'><%=stt10%></td>
  <td class=xl36><%=seri%></td>
  <td class=xl37><%=invoice_no%></td>
  <td class=xl37><%=invoice_date%></td>
  <td class=xl37><%=cust_name%></td>
  <td class=xl37 x:str><%=cust_tax%></td>
  <td class=xl37><%=item%></td>
  <td class=xl37 x:num><%=net_amt%></td>
  <td class=xl38 style='mso-number-format:"\@";' x:str><%=rate %></td>
  <td class=xl37 x:num><%=vat_amt%></td>
  <td class=xl37><%=voucher%>(<%=seq%>)(<%=vat_note%>)</td>
 </tr>
 <%     }
    } %><%else { %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl35 width=51 style='width:38pt'>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38><span style='mso-spacerun:yes'> </span></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
 </tr>
 <%
        }
   %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl39 width=51 style='width:38pt'>Tổng</td>
  <td class=xl40 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl40 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl41 width=76 style='width:57pt'>&nbsp;</td>
  <td class=xl40 width=204 style='width:153pt'>&nbsp;</td>
  <td class=xl40 width=105 style='width:79pt'>&nbsp;</td>
  <td class=xl40 width=113 style='width:85pt'>&nbsp;</td>
  <td class=xl42 style='border-top:none' x:num><%=net_10%></td>
  <td class=xl40 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl42 style='border-top:none' x:num><%=vat_10%></td>
  <td class=xl40 width=89 style='width:67pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl43>&nbsp;</td>
  <td colspan=2 class=xl59>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl59>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td colspan=5 class=xl24>Tổng giá trị hàng hoá, dịch vụ bán ra:<%=net_none+net_0+net_5+net_10 %></td>
  <td colspan=6 class=xl24>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td colspan=5 class=xl24>Tổng thuế GTGT của hàng hoá, dịch vụ bán ra:<%=vat_none+vat_0+vat_5+vat_10 %></td>
  <td colspan=6 class=xl24>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td colspan=2 class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl24>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td colspan=2 class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=3 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl27>..............., ngày......... tháng...........
  năm..........</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=3 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl27>NGƯỜI NỘP THUẾ hoặc</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=3 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl27>ĐẠI DIỆN HỢP PHÁP CỦA NGƯỜI NỘP THUẾ</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=3 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl27><span style='mso-spacerun:yes'> </span>Ký tên, đóng
  dấu (ghi rõ họ tên và chức vụ)</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=13 style='width:10pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=204 style='width:153pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=89 style='width:67pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
