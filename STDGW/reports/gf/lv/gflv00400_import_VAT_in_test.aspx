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
    SQLD += "     AND a.vat_type = '1' ";
    SQLD += "     AND UPPER(a.tax_rate) IN ('NONE%','NO VAT%') ";
    SQLD += "     AND a.tr_status IN ('" + p_status + "') ";
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
    SQL0 += "     AND a.vat_type = '1' ";
    SQL0 += "     AND UPPER(a.tax_rate) NOT IN ('NONE','NO VAT%') ";
    SQL0 += "     AND a.tr_status IN ('" + p_status + "') ";
    SQL0 += "     AND h.tr_status IN ('0', '" + p_status + "') ";
    SQL0 += "ORDER BY a.invoice_date, a.invoice_no ";
    DataTable dt_0 = ESysLib.TableReadOpen(SQL0);
    string l_test = "-";
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Page_files/filelist.xml">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style id="PHAN MEM IN 03-2010_6525_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font56525
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font66525
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font76525
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl236525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl246525
	{padding:0px;
	mso-ignore:padding;
	color:blue;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl256525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl266525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl276525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl286525
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	padding-left:48px;
	mso-char-indent-count:4;}
.xl296525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl306525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl316525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl326525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:top;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl336525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl346525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:top;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl356525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:general;
	vertical-align:top;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl366525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl376525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:general;
	vertical-align:top;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl386525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:general;
	vertical-align:top;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl396525
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	padding-left:180px;
	mso-char-indent-count:15;}
.xl406525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:justify;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl416525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl426525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl436525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl446525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl456525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl466525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0_\)\;\\\(0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl476525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl486525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl496525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl506525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl516525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl526525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl536525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl546525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl556525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl566525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl576525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:000000;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl586525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl596525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl606525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl616525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl626525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl636525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl646525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:000000;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl656525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl666525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:000000;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl676525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl686525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl696525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl706525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl716525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:top;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl726525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl736525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl746525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl756525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl766525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl776525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl786525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl796525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl806525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl816525
	{padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl826525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl836525
	{padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
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

<div id="PHAN MEM IN 03-2010_6525" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1850 class=xl236525
 style='border-collapse:collapse;table-layout:fixed;width:1390pt'>
 <col class=xl236525 width=15 style='mso-width-source:userset;mso-width-alt:
 548;width:11pt'>
 <col class=xl236525 width=64 style='width:48pt'>
 <col class=xl256525 width=78 style='mso-width-source:userset;mso-width-alt:
 2852;width:59pt'>
 <col class=xl236525 width=67 style='mso-width-source:userset;mso-width-alt:
 2450;width:50pt'>
 <col class=xl256525 width=86 style='mso-width-source:userset;mso-width-alt:
 3145;width:65pt'>
 <col class=xl256525 width=297 style='mso-width-source:userset;mso-width-alt:
 10861;width:223pt'>
 <col class=xl256525 width=125 style='mso-width-source:userset;mso-width-alt:
 4571;width:94pt'>
 <col class=xl256525 width=139 style='mso-width-source:userset;mso-width-alt:
 5083;width:104pt'>
 <col class=xl236525 width=135 style='mso-width-source:userset;mso-width-alt:
 4937;width:101pt'>
 <col class=xl266525 width=73 style='mso-width-source:userset;mso-width-alt:
 2669;width:55pt'>
 <col class=xl696525 width=161 style='mso-width-source:userset;mso-width-alt:
 5888;width:121pt'>
 <col class=xl256525 width=178 style='mso-width-source:userset;mso-width-alt:
 6509;width:134pt'>
 <col class=xl236525 width=154 style='mso-width-source:userset;mso-width-alt:
 5632;width:116pt'>
 <col class=xl236525 width=64 style='width:48pt'>
 <col class=xl506525 width=86 style='mso-width-source:userset;mso-width-alt:
 3145;width:65pt'>
 <col class=xl506525 width=64 span=2 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl236525 width=15 style='height:15.75pt;width:11pt'></td>
  <td width=64 style='width:48pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t202" style='position:absolute;
   margin-left:.75pt;margin-top:10.5pt;width:132.75pt;height:53.25pt;z-index:1;
   mso-wrap-style:tight'>
   <v:textbox style='mso-next-textbox:#_x0000_s1025;mso-direction-alt:auto'>
    <div style='text-align:left'><font class="font56525">Mẫu số: </font><font
    class="font66525">01- 2/GTGT</font><font class="font56525"><br>
        </font><font class="font76525">(Ban hành kèm theo Thông tư số
    60/2007/TT-BTC ngày<span style='mso-spacerun:yes'>  </span></font><font
    class="font56525"><br>
        </font><font class="font76525">14/6/2007 của<span
    style='mso-spacerun:yes'>  </span>Bộ Tài chính)</font><font
    class="font56525"><br>
        &nbsp;</font></div>
   </v:textbox>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:13px;width:179px;
  height:73px'><img width=179 height=73
  src="Page_files/PHAN%20MEM%20IN%2003-2010_6525_image001.gif"
  alt="Text Box: Mẫu số: 01- 2/GTGT&#10;(Ban hành kèm theo Thông tư số 60/2007/TT-BTC ngày  &#10;14/6/2007 của  Bộ Tài chính)&#10;&nbsp;"
  v:shapes="_x0000_s1025"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl456525 width=64 style='height:15.75pt;width:48pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl446525 width=78 style='width:59pt'>&nbsp;</td>
  <td class=xl416525 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl466525 width=86 style='border-left:none;width:65pt'>&nbsp;</td>
  <td class=xl426525 width=297 style='width:223pt'>&nbsp;</td>
  <td class=xl436525 width=125 style='width:94pt'>&nbsp;</td>
  <td class=xl476525 width=139 style='width:104pt'>&nbsp;</td>
  <td class=xl486525 width=135 style='width:101pt'>&nbsp;</td>
  <td class=xl496525 width=73 style='width:55pt'>&nbsp;</td>
  <td class=xl686525 width=161 style='width:121pt'>&nbsp;</td>
  <td class=xl346525 width=178 style='border-left:none;width:134pt'>&nbsp;</td>
  <td class=xl236525 width=154 style='width:116pt'></td>
  <td class=xl236525 width=64 style='width:48pt'></td>
  <td class=xl506525 width=86 style='width:65pt'></td>
  <td class=xl506525 width=64 style='width:48pt'></td>
  <td class=xl506525 width=64 style='width:48pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl266525></td>
  <td class=xl696525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl236525 style='height:15.75pt'></td>
  <td class=xl246525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl266525></td>
  <td class=xl696525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl236525 style='height:15.75pt'></td>
  <td colspan=11 class=xl246525>BẢNG KÊ HOÁ ĐƠN, CHỨNG TỪ HÀNG HOÁ, DỊCH VỤ MUA
  VÀO</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=0 style='display:none'>
  <td class=xl236525>B<span style='display:none'>angkemuavao.xls</span></td>
  <td colspan=11 class=xl246525></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td colspan=11 class=xl276525>(Kèm theo tờ khai thuế GTGT theo mẫu số
  01/GTGT)</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td colspan=11 class=xl276525>Kỳ tính thuế: Tháng <%=p_month.Substring(4,2) %> năm <%=p_month.Substring(0, 4)%></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl276525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl266525></td>
  <td class=xl696525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td colspan=11 class=xl776525
  x:str>Người nộp thuế: <%=name%>
  </td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td colspan=11 class=xl776525>Mã số thuế: <%=tax_code%></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl286525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl266525></td>
  <td class=xl696525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td colspan=11 class=xl786525>Đơn vị tiền: đồng Việt Nam</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl236525 style='height:12.75pt'></td>
  <td rowspan=3 class=xl296525 width=64 style='width:48pt'>STT</td>
  <td colspan=3 rowspan=2 class=xl296525 width=231 style='width:174pt'>Hoá đơn,
  chứng từ, biên lai nộp thuế</td>
  <td rowspan=3 class=xl296525 width=297 style='width:223pt'>Tên người bán</td>
  <td rowspan=3 class=xl296525 width=125 style='width:94pt'>Mã số thuế người
  bán</td>
  <td rowspan=3 class=xl296525 width=139 style='width:104pt'>Mặt hàng</td>
  <td rowspan=3 class=xl296525 width=135 style='width:101pt'>Doanh số mua chưa
  có thuế</td>
  <td rowspan=3 class=xl826525 width=73 style='width:55pt'>Thuế suất</td>
  <td rowspan=3 class=xl836525 width=161 style='width:121pt' x:str="Thuế GTGT"><span
  style='mso-spacerun:yes'> </span>Thuế GTGT<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl296525 width=178 style='width:134pt'>Ghi chú</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl236525 style='height:4.5pt'></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl236525 style='height:35.25pt'></td>
  <td class=xl296525 width=78 style='border-top:none;border-left:none;
  width:59pt'>Ký hiệu hoá đơn</td>
  <td class=xl296525 width=67 style='border-top:none;border-left:none;
  width:50pt'>Số hoá đơn</td>
  <td class=xl296525 width=86 style='border-top:none;border-left:none;
  width:65pt'>Ngày, tháng, năm phát hành</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl306525 width=64 style='border-top:none;width:48pt'>[1]</td>
  <td class=xl316525 width=78 style='border-top:none;border-left:none;
  width:59pt'>[2]</td>
  <td class=xl306525 width=67 style='border-top:none;border-left:none;
  width:50pt'>[3]</td>
  <td class=xl316525 width=86 style='border-top:none;border-left:none;
  width:65pt'>[4]</td>
  <td class=xl316525 width=297 style='border-top:none;border-left:none;
  width:223pt'>[5]</td>
  <td class=xl326525 width=125 style='border-top:none;border-left:none;
  width:94pt'>[6]</td>
  <td class=xl326525 width=139 style='border-top:none;border-left:none;
  width:104pt'>[7]</td>
  <td class=xl306525 width=135 style='border-top:none;border-left:none;
  width:101pt'>[8]</td>
  <td class=xl336525 width=73 style='border-top:none;border-left:none;
  width:55pt'>[9]</td>
  <td class=xl706525 width=161 style='border-top:none;border-left:none;
  width:121pt' x:str="[10]"><span style='mso-spacerun:yes'> </span>[10]<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl316525 width=178 style='border-top:none;border-left:none;
  width:134pt'>[11]</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td colspan=11 class=xl346525 width=1403 style='width:1054pt'>1.Hàng hoá,
  dịch vụ dùng riêng cho SXKD chịu thuế GTGT:</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
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
            if (tax_rate != "0" && tax_rate != "-")
            {
                rate = double.Parse(tax_rate) / 100;
            }
            else
            {
                rate = 0;
            }
            //rate = 0;
            net_amt = dt_0.Rows[i][14].ToString();
            vat_amt = dt_0.Rows[i][15].ToString();
            voucher = dt_0.Rows[i][16].ToString();
            vat_note = dt_0.Rows[i][17].ToString();
		   if(net_amt != "")	
		   {
				net_0 += double.Parse(net_amt);
		   }
		   if(vat_amt != "")	
		   {
				vat_0 += double.Parse(vat_amt);
		   }
		   if(net_amt != "")	
		   {
				net_sum += double.Parse(net_amt);
		   }
		   if(vat_amt != "")
		   {	
				vat_sum += double.Parse(vat_amt);
		   }	    
 %>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl236525 style='height:25.5pt'></td>
  <td class=xl516525 align=right x:num><%=stt0 %></td>
  <td class=xl546525><%=seri %></td>
  <td class=xl576525 x:str><%=invoice_no %></td>
  <td class=xl626525><%=invoice_date %></td>
  <td class=xl556525><%=cust_name %></td>
  <td class=xl566525 style='border-left:none'><%=cust_tax %></td>
  <td class=xl526525 width=139 style='border-left:none;width:104pt'><%=item %></td>
  <td class=xl616525 style='border-left:none' x:num><%=net_amt %> </td>
  <% 
        if(rate != 0)
        {            
  %>
  <td class=xl536525 style='border-left:none' x:num="<%=rate %>"></td>
  <% 
        }     
        else
        {
  %>
    <td class=xl536525 style='border-top:none;border-left:none'>-</td>
    <% 
        }
    %>    
  <td class=xl726525 style='border-left:none' x:num><%=vat_amt %></td>
  <td class=xl516525 style='border-left:none'><%=voucher %>(<%=seq%>)(<%=vat_note%>)</td>
  <td class=xl676525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <%
        }
    }
    else
    {
  %>
   <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl356525 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl356525 width=78 style='border-top:none;border-left:none;
  width:59pt'>&nbsp;</td>
  <td class=xl356525 width=67 style='border-top:none;border-left:none;
  width:50pt'>&nbsp;</td>
  <td class=xl356525 width=86 style='border-top:none;border-left:none;
  width:65pt'>&nbsp;</td>
  <td class=xl356525 width=297 style='border-top:none;border-left:none;
  width:223pt'>&nbsp;</td>
  <td class=xl366525 width=125 style='border-top:none;border-left:none;
  width:94pt'>&nbsp;</td>
  <td class=xl356525 width=139 style='border-top:none;border-left:none;
  width:104pt'>&nbsp;</td>
  <td class=xl376525 width=135 style='border-top:none;border-left:none;
  width:101pt'>&nbsp;</td>
  <td class=xl386525 width=73 style='border-top:none;border-left:none;
  width:55pt'>&nbsp;</td>
  <td class=xl716525 width=161 style='border-top:none;border-left:none;
  width:121pt'>&nbsp;</td>
  <td class=xl356525 width=178 style='border-top:none;border-left:none;
  width:134pt'>&nbsp;</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
<% 
}
%>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl236525 style='height:15.75pt'></td>
  <td class=xl736525>&nbsp;</td>
  <td colspan=4 class=xl796525 style='border-right:.5pt solid black;border-left:
  none'>Tổng</td>
  <td class=xl746525>&nbsp;</td>
  <td class=xl756525 width=139 style='width:104pt'>&nbsp;</td>
  <td class=xl616525 style='border-top:none;border-left:none' x:num><%=net_0%></td>
  <td class=xl766525>&nbsp;</td>
  <td class=xl616525 style='border-top:none;border-left:none' x:num><%=vat_0%></td>
  <td class=xl746525>&nbsp;</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td colspan=11 class=xl346525 width=1403 style='width:1054pt'>2.Hàng hoá,
  dịch vụ dùng riêng cho SXKD không chịu thuế GTGT:</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
  <%
     if (dt_none.Rows.Count > 0)
     {
         for (int i = 0; i < dt_none.Rows.Count; i++)
         {
             stt0 += 1;
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
             //tax_rate = dt_none.Rows[i][13].ToString();
             //tax_rate = tax_rate.Substring(0, tax_rate.Length - 1);
             //rate = double.Parse(tax_rate) / 100;
             net_amt = dt_none.Rows[i][14].ToString();
             vat_amt = dt_none.Rows[i][15].ToString();
             voucher = dt_none.Rows[i][16].ToString();
             vat_note = dt_none.Rows[i][17].ToString();
             if (net_amt != "")
             {
                 net_none += double.Parse(net_amt);
             }
             if (vat_amt != "")
             {
                 vat_none += double.Parse(vat_amt);
             }
             if (net_amt != "")
             {
                 net_sum += double.Parse(net_amt);
             }
             if (vat_amt != "")
             {
                 vat_sum += double.Parse(vat_amt);
             }	
  %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl356525 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl356525 width=78 style='border-top:none;border-left:none;
  width:59pt'><%=stt0%></td>
  <td class=xl356525 width=67 style='border-top:none;border-left:none;
  width:50pt'><%=seri%></td>
  <td class=xl356525 width=86 style='border-top:none;border-left:none;
  width:65pt'><%=invoice_no%></td>
  <td class=xl356525 width=297 style='border-top:none;border-left:none;
  width:223pt'><%=invoice_date%></td>
  <td class=xl366525 width=125 style='border-top:none;border-left:none;
  width:94pt'><%=cust_name%></td>
  <td class=xl356525 width=139 style='border-top:none;border-left:none;
  width:104pt'><%=cust_tax%></td>
  <td class=xl376525 width=135 style='border-top:none;border-left:none;
  width:101pt'><%=item%></td>
  <td class=xl386525 width=73 style='border-top:none;border-left:none;
  width:55pt' x:num><%=net_amt%></td>
  <td class=xl716525 width=161 style='border-top:none;border-left:none;
  width:121pt'>&nbsp;</td>
  <td class=xl356525 width=178 style='border-top:none;border-left:none;
  width:134pt' x:num><%=vat_amt %></td>
  <td class=xl236525><%=voucher %>(<%=seq%>)(<%=vat_note%>)</td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <% 
      }    
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl346525 width=64 style='border-top:none;width:48pt'>Tổng</td>
  <td class=xl356525 width=78 style='border-top:none;border-left:none;
  width:59pt'>&nbsp;</td>
  <td class=xl346525 width=67 style='border-top:none;border-left:none;
  width:50pt'>&nbsp;</td>
  <td class=xl356525 width=86 style='border-top:none;border-left:none;
  width:65pt'>&nbsp;</td>
  <td class=xl356525 width=297 style='border-top:none;border-left:none;
  width:223pt'>&nbsp;</td>
  <td class=xl356525 width=125 style='border-top:none;border-left:none;
  width:94pt'>&nbsp;</td>
  <td class=xl356525 width=139 style='border-top:none;border-left:none;
  width:104pt'>&nbsp;</td>
  <td class=xl346525 width=135 style='border-top:none;border-left:none;
  width:101pt'>&nbsp;</td>
  <td class=xl386525 width=73 style='border-top:none;border-left:none;
  width:55pt' x:num ><%=net_none %></td>
  <td class=xl716525 width=161 style='border-top:none;border-left:none;
  width:121pt'>&nbsp;</td>
  <td class=xl356525 width=178 style='border-top:none;border-left:none;
  width:134pt' x:num><%=vat_none%> </td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <% 
    }
     else
     {     
 %>
  <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl356525 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl356525 width=78 style='border-top:none;border-left:none;
  width:59pt'></td>
  <td class=xl356525 width=67 style='border-top:none;border-left:none;
  width:50pt'></td>
  <td class=xl356525 width=86 style='border-top:none;border-left:none;
  width:65pt'></td>
  <td class=xl356525 width=297 style='border-top:none;border-left:none;
  width:223pt'></td>
  <td class=xl366525 width=125 style='border-top:none;border-left:none;
  width:94pt'></td>
  <td class=xl356525 width=139 style='border-top:none;border-left:none;
  width:104pt'></td>
  <td class=xl376525 width=135 style='border-top:none;border-left:none;
  width:101pt'></td>
  <td class=xl386525 width=73 style='border-top:none;border-left:none;
  width:55pt' x:num></td>
  <td class=xl716525 width=161 style='border-top:none;border-left:none;
  width:121pt'>&nbsp;</td>
  <td class=xl356525 width=178 style='border-top:none;border-left:none;
  width:134pt' x:num></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
<% } %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td colspan=11 class=xl346525 width=1403 style='width:1054pt'>3.Hàng hoá,
  dịch vụ dùng chung cho SXKD chịu thuế GTGT và không chịu thuế GTGT:</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl356525 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl356525 width=78 style='border-top:none;border-left:none;
  width:59pt'>&nbsp;</td>
  <td class=xl356525 width=67 style='border-top:none;border-left:none;
  width:50pt'>&nbsp;</td>
  <td class=xl356525 width=86 style='border-top:none;border-left:none;
  width:65pt'>&nbsp;</td>
  <td class=xl356525 width=297 style='border-top:none;border-left:none;
  width:223pt'>&nbsp;</td>
  <td class=xl366525 width=125 style='border-top:none;border-left:none;
  width:94pt'>&nbsp;</td>
  <td class=xl356525 width=139 style='border-top:none;border-left:none;
  width:104pt'>&nbsp;</td>
  <td class=xl376525 width=135 style='border-top:none;border-left:none;
  width:101pt'>&nbsp;</td>
  <td class=xl386525 width=73 style='border-top:none;border-left:none;
  width:55pt'>&nbsp;</td>
  <td class=xl716525 width=161 style='border-top:none;border-left:none;
  width:121pt'>&nbsp;</td>
  <td class=xl356525 width=178 style='border-top:none;border-left:none;
  width:134pt'>&nbsp;</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl346525 width=64 style='border-top:none;width:48pt'>Tổng</td>
  <td class=xl356525 width=78 style='border-top:none;border-left:none;
  width:59pt'>&nbsp;</td>
  <td class=xl346525 width=67 style='border-top:none;border-left:none;
  width:50pt'>&nbsp;</td>
  <td class=xl356525 width=86 style='border-top:none;border-left:none;
  width:65pt'>&nbsp;</td>
  <td class=xl356525 width=297 style='border-top:none;border-left:none;
  width:223pt'>&nbsp;</td>
  <td class=xl356525 width=125 style='border-top:none;border-left:none;
  width:94pt'>&nbsp;</td>
  <td class=xl356525 width=139 style='border-top:none;border-left:none;
  width:104pt'>&nbsp;</td>
  <td class=xl346525 width=135 style='border-top:none;border-left:none;
  width:101pt'>&nbsp;</td>
  <td class=xl386525 width=73 style='border-top:none;border-left:none;
  width:55pt'>&nbsp;</td>
  <td class=xl716525 width=161 style='border-top:none;border-left:none;
  width:121pt'>&nbsp;</td>
  <td class=xl356525 width=178 style='border-top:none;border-left:none;
  width:134pt'>&nbsp;</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td colspan=11 class=xl346525 width=1403 style='width:1054pt'>4.Hàng hóa dịch
  vụ dùng cho dự án đầu tư:</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl356525 width=64 style='border-top:none;width:48pt'>&nbsp;</td>
  <td class=xl356525 width=78 style='border-top:none;border-left:none;
  width:59pt'>&nbsp;</td>
  <td class=xl356525 width=67 style='border-top:none;border-left:none;
  width:50pt'>&nbsp;</td>
  <td class=xl356525 width=86 style='border-top:none;border-left:none;
  width:65pt'>&nbsp;</td>
  <td class=xl356525 width=297 style='border-top:none;border-left:none;
  width:223pt'>&nbsp;</td>
  <td class=xl366525 width=125 style='border-top:none;border-left:none;
  width:94pt'>&nbsp;</td>
  <td class=xl356525 width=139 style='border-top:none;border-left:none;
  width:104pt'>&nbsp;</td>
  <td class=xl376525 width=135 style='border-top:none;border-left:none;
  width:101pt'>&nbsp;</td>
  <td class=xl386525 width=73 style='border-top:none;border-left:none;
  width:55pt'>&nbsp;</td>
  <td class=xl716525 width=161 style='border-top:none;border-left:none;
  width:121pt'>&nbsp;</td>
  <td class=xl356525 width=178 style='border-top:none;border-left:none;
  width:134pt'>&nbsp;</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl346525 width=64 style='border-top:none;width:48pt'>Tổng</td>
  <td class=xl356525 width=78 style='border-top:none;border-left:none;
  width:59pt'>&nbsp;</td>
  <td class=xl346525 width=67 style='border-top:none;border-left:none;
  width:50pt'>&nbsp;</td>
  <td class=xl356525 width=86 style='border-top:none;border-left:none;
  width:65pt'>&nbsp;</td>
  <td class=xl356525 width=297 style='border-top:none;border-left:none;
  width:223pt'>&nbsp;</td>
  <td class=xl356525 width=125 style='border-top:none;border-left:none;
  width:94pt'>&nbsp;</td>
  <td class=xl356525 width=139 style='border-top:none;border-left:none;
  width:104pt'>&nbsp;</td>
  <td class=xl346525 width=135 style='border-top:none;border-left:none;
  width:101pt'>&nbsp;</td>
  <td class=xl386525 width=73 style='border-top:none;border-left:none;
  width:55pt'>&nbsp;</td>
  <td class=xl716525 width=161 style='border-top:none;border-left:none;
  width:121pt'>&nbsp;</td>
  <td class=xl356525 width=178 style='border-top:none;border-left:none;
  width:134pt'>&nbsp;</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl396525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl266525></td>
  <td class=xl696525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl236525 colspan=5>Tổng giá trị hàng hoá, dịch vụ mua vào:</td>
  <td class=xl256525 x:num><%=net_none+net_0 %> </td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl266525></td>
  <td class=xl696525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl236525 colspan=5>Tổng thuế GTGT của hàng hoá, dịch vụ mua
  vào: </td>
  <td class=xl256525 x:num><%=vat_none + vat_0%></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl266525></td>
  <td class=xl696525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl406525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl266525></td>
  <td class=xl696525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl406525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td colspan=4 class=xl276525>..............., ngày......... tháng...........
  năm..........</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td colspan=4 class=xl276525>NGƯỜI NỘP THUẾ hoặc</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td colspan=4 class=xl276525>ĐẠI DIỆN HỢP PHÁP CỦA NGƯỜI NỘP THUẾ</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl236525 style='height:15.0pt'></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl236525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td class=xl256525></td>
  <td colspan=4 class=xl276525><span style='mso-spacerun:yes'> </span>Ký tên,
  đóng dấu (ghi rõ họ tên và chức vụ)</td>
  <td class=xl236525></td>
  <td class=xl236525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
  <td class=xl506525></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=15 style='width:11pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=297 style='width:223pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=139 style='width:104pt'></td>
  <td width=135 style='width:101pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=161 style='width:121pt'></td>
  <td width=178 style='width:134pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
