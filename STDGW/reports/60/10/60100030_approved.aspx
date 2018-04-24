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

    string SQL = "";
    string p_compk              = ""+ Request["l_compk"];
    string p_seq                = ""+ Request["l_seq"];
    string p_paydue_fr          = ""+ Request["l_paydue_fr"];
    string p_paydue_to          = ""+ Request["l_paydue_to"];
    string p_datefr             = ""+ Request["l_datefr"];
    string p_dateto             = ""+ Request["l_dateto"];
    string p_tco_buspartner_pk  = ""+ Request["l_tco_buspartner_pk"];
    string p_voucher_no         = ""+ Request["l_voucher_no"];
    string p_tac_abplcenter_pk  = ""+ Request["l_tac_abplcenter_pk"];
    string p_type               = ""+ Request["l_type"];
    string p_tab                = ""+ Request["l_tab"];
    string p_pay_date           = ""+ Request["l_pay_date"];
    string p_date               = "";
    string p_cmp_name           = "";
    string p_cmp_add            = "";
    string p_cmp_taxcode        = "";
    string p_bal_opt = Request["bal_opt"];
    
    float  p_famt   = 0;
	float  p_amt    = 0;
	p_voucher_no = p_voucher_no.ToUpper();
    //if (p_bal_opt == "0")
    //{
	SQL = 
	" select c.pk seq, c.voucherno, to_char(c.tr_date, 'dd/mm/yyyy') prps_date, to_char(to_date(c.sign_date, 'yyyymmdd'), 'dd/mm/yyyy') appr_date, c.voucherno_app appr_no,  " +
	" to_char(to_date(a.pay_date, 'YYYYMMDD'), 'DD/MM/YYYY') pay_date, b.buspartner_lnm, d.pay_ccy, " +
	" decode(d.pay_type, '03', d.pay_famt, 0) bank_usd, decode(d.pay_type, '04', d.pay_famt, 0) bank_vnd, " +
	" decode(d.pay_type, '01', d.pay_famt, 0) cash_usd, decode(d.pay_type, '02', d.pay_famt, 0) cash_vnd, " +
        "(select to_char(to_date(d.item, 'YYYYMMDD'), 'dd/mm/yyyy') from tac_hgtrditem d , tac_abacctitem e " +
        "    where d.tac_hgtrd_pk = b.pk " +
        "    and d.del_if = 0 " +
        "    and e.del_if = 0 " +
        "    and d.tac_abacctitem_pk = e.pk " +
        "    and e.TAC_ABITEM_ALIAS = 'INVOICE DATE' " +
		"	 and rownum < 2 ) inv_date, " +
		" to_char(to_date(a.plandue_date, 'YYYYMMDD'), 'DD/MM/YYYY') due_date, a.tr_remark, a.tr_remark2, d.pay_amt books_amt, b.tco_buspartner_pk, " +
        " (select e.bank_id from tac_abdepomt e where e.pk = d.tac_bfdepomt_pk) bank_deposit, " +
        " (select e.partner_id from tco_buspartner e where e.pk = d.tco_buspartner_pk) partner_id " +
        "from tfn_eppay a, tac_hgtrd b, tac_hgtrh c, tfn_eppaytr d " +
        "where a.del_if = 0 " +
        "and b.del_if = 0 " +
        "and c.del_if = 0 " +
		"and d.del_if = 0 " +
        "and a.tac_hgtrd_pk = b.pk " +
        "and b.tac_hgtrh_pk = c.pk " +
		"and d.tfn_eppay_pk = a.pk " +
        " AND c.tco_company_pk = '" + p_compk + "' " +       
        " AND a.pay_date BETWEEN '" + p_datefr + "' AND '" + p_dateto + "' " +
        " AND (b.tac_abplcenter_pk LIKE '" + p_tac_abplcenter_pk + "' || '%' OR '" + p_tac_abplcenter_pk + "' IS NULL) " +
        " AND (b.tco_buspartner_pk LIKE '" + p_tco_buspartner_pk + "' || '%' OR '" + p_tco_buspartner_pk + "' IS NULL) " +
        " AND c.pk LIKE '" + p_seq + "' || '%' " +
        " AND upper(c.voucherno) || '%' LIKE '" + p_voucher_no + "' || '%' " +
        " AND c.tr_tablenm LIKE " +
        "        DECODE ('" + p_type + "', " +
        "                'AL', '%', " +
        "                'SE', 'TAC_HGTRH', " +
        "                'AP', 'TAC_CRDA' " +
        "               ) " +
        " AND a.confirm_yn = 'Y' " +
        " order by bank_deposit asc, partner_id asc ";
    //Response.Write(SQL);
    //Response.End();		
    DataTable dt3 =ESysLib.TableReadOpen(SQL);
    SQL = " SELECT PARTNER_LNAME, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + p_compk + "' ";
	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if (dt1.Rows.Count >0)
	{
		p_cmp_name      = dt1.Rows[0][0].ToString();
		p_cmp_add       = dt1.Rows[0][1].ToString();
		p_cmp_taxcode   = dt1.Rows[0][2].ToString();
	}
	
	SQL = "SELECT TO_CHAR(TO_DATE('" + p_pay_date + "','YYYYMMDD'),'DD/MM/YYYY') FROM DUAL";
	DataTable dt2 = ESysLib.TableReadOpen(SQL);
	if (dt2.Rows.Count >0)
	{
		p_date          = dt2.Rows[0][0].ToString();
	}
	string l_custnm = "";
	if(dt3.Rows.Count > 0)
	{
		l_custnm = dt3.Rows[0][17].ToString();
	}
	
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Page_files/filelist.xml">
<style id="Appr.Method (Approval) report_18464_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in 0in 1.0in 0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}	
.xl2418464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2518464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2618464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2718464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2818464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	white-space:nowrap;}
.xl2918464
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
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3018464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3118464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
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
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3218464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
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
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3318464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
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
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3418464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3518464
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
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3618464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;	
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3718464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
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
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3818464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
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
	white-space:normal;}
.xl3918464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4018464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4118464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	white-space:nowrap;}
.xl4218464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
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
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4318464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4418464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4518464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4618464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	white-space:nowrap;}
.xl4718464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
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
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4818464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
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
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4918464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	white-space:nowrap;}
.xl5018464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	white-space:nowrap;}
.xl5118464
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>gfep00020_paylist_cfm</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>88</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12360</x:WindowHeight>
  <x:WindowWidth>19065</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>
<body>
<div id="Appr.Method (Approval) report_18464" align=center
x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1164 class=xl2418464
 style='border-collapse:collapse;table-layout:fixed;width:875pt'>
 <col class=xl2418464 width=38 style='mso-width-source:userset;mso-width-alt:
 1389;width:29pt'>
 <col class=xl2418464 width=355 style='mso-width-source:userset;mso-width-alt:
 12982;width:266pt'>
 <col class=xl2418464 width=145 style='mso-width-source:userset;mso-width-alt:
 5302;width:109pt'>
 <col class=xl2418464 width=111 style='mso-width-source:userset;mso-width-alt:
 4059;width:83pt'>
 <col class=xl2418464 width=110 span=4 style='mso-width-source:userset;
 mso-width-alt:4022;width:83pt'>
 <col class=xl2418464 width=75 style='mso-width-source:userset;mso-width-alt:
 2742;width:56pt'>
 <tr class=xl2518464 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td colspan=2 height=21 class=xl5118464 width=393 style='height:15.95pt;
  width:295pt'><%=p_cmp_name%></td>
  <td class=xl2518464 width=145 style='width:109pt'></td>
  <td class=xl2618464 width=111 style='width:83pt'></td>
  <td class=xl2718464 width=110 style='width:83pt'>In Change</td>
  <td class=xl2818464 width=110 style='width:83pt'>Ass. Manager</td>
  <td class=xl2818464 width=110 style='width:83pt'>Chief Accountant</td>
  <td class=xl2818464 width=110 style='width:83pt'>G. Director</td>
  <td class=xl2518464 width=75 style='width:56pt'></td>
 </tr>
 <tr class=xl2518464 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl2518464 style='height:15.95pt'></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td rowspan=4 class=xl4618464 style='border-bottom:.5pt solid black;
  border-top:none'>&nbsp;</td>
  <td rowspan=4 class=xl4618464 style='border-bottom:.5pt solid black;
  border-top:none'>&nbsp;</td>
  <td rowspan=4 class=xl4618464 style='border-bottom:.5pt solid black;
  border-top:none'>&nbsp;</td>
  <td rowspan=4 class=xl4618464 style='border-bottom:.5pt solid black;
  border-top:none'>&nbsp;</td>
  <td class=xl2518464></td>
 </tr>
 <tr class=xl2518464 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl2518464 style='height:15.95pt'></td>
  <td class=xl2918464>LIST OF PAYMENT</td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
 </tr>
 <tr class=xl2518464 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl2518464 style='height:15.95pt'></td>
  <td class=xl3018464>At date <%=p_dateto.Substring(6,2) + "/" + p_dateto.Substring(4,2) + "/" + p_dateto.Substring(0,4)%></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
 </tr>
 <tr class=xl2518464 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl2518464 style='height:15.95pt'></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
 </tr>
 <tr class=xl2518464 height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 class=xl2518464 style='height:9.95pt'></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td class=xl2518464></td>
  <td class=xl3118464>&nbsp;</td>
  <td class=xl2518464></td>
 </tr>
 <tr class=xl2518464 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td rowspan=2 height=44 class=xl4118464 style='border-bottom:.5pt solid black;
  height:34.2pt'>No</td>
  <td rowspan=2 class=xl4118464 style='border-bottom:.5pt solid black'>Description</td>
  <td rowspan=2 class=xl4118464 style='border-bottom:.5pt solid black'>Supplier</td>
  <td colspan=2 class=xl4918464 style='border-right:.5pt solid black;
  border-left:none'>By Transfer</td>
  <td colspan=2 class=xl4918464 style='border-right:.5pt solid black;
  border-left:none'>By Cash</td>
  <td rowspan=2 class=xl4118464 style='border-bottom:.5pt solid black'>Book</td>
  <td rowspan=2 class=xl4118464 style='border-right:none;border-top:none;border-bottom:none;'></td>
 </tr>
 <tr class=xl2518464 height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl3218464 style='height:17.1pt'>USD</td>
  <td class=xl3218464>VND</td>
  <td class=xl3218464>USD</td>
  <td class=xl3218464>VND</td>
 </tr>
 <%
	
	int i;
	decimal l_bank_usd = 0, l_bank_vnd = 0, l_cash_usd = 0, l_cash_vnd = 0, l_books_amt = 0;
	decimal l_tot_bank_usd = 0, l_tot_bank_vnd = 0, l_tot_cash_usd = 0, l_tot_cash_vnd = 0, l_tot_book_amt = 0;
    string l_bank_acc_no = "";
    if (dt3.Rows.Count > 0)
    {
        l_bank_acc_no = "Sub Total - " + dt3.Rows[0][18].ToString();
    }    
	for( i = 0 ; i < dt3.Rows.Count ; i++)
	{
        
		if(l_custnm != dt3.Rows[i][17].ToString().Trim())
		{
            
	%>	
		 <tr class=xl2518464 height=33 style='mso-height-source:userset;height:24.95pt'>
		  <td height=33 class=xl3318464 style='height:24.95pt' x:num></td>
		  <td class=xl3418464 width=355 style='width:266pt'><b><%=l_bank_acc_no%></b></td>
		  <td class=xl3518464 width=145 style='width:109pt'></td>
		  <td class=xl3618464 style='font:weight:700;' x:num><b><%=l_bank_usd%></b></td>
		  <td class=xl3718464 style='font:weight:700;' x:num><b><%=l_bank_vnd%></b></td>
		  <td class=xl3618464 style='font:weight:700;' x:num><b><%=l_cash_usd%></b></td>
		  <td class=xl3718464 style='font:weight:700;' x:num><b><%=l_cash_vnd%></b></td>
		  <td class=xl3918464 width=110 style='width:83pt; font:weight:700;' x:num><b><%=l_books_amt%></b></td>
		  <td class=xl3818464 width=75 style='border-left:none;width:56pt; border-right:none;border-top:none;border-bottom:none;'></td>
		 </tr>		
		 <tr class=xl2518464 height=33 style='mso-height-source:userset;height:24.95pt'>
		  <td height=33 class=xl3318464 style='height:24.95pt' x:num><%= i + 1%></td>
		  <td class=xl3418464 width=355 style='width:266pt'><%=dt3.Rows[i][14]%></td>
		  <td class=xl3518464 width=145 style='width:109pt'><%=dt3.Rows[i][6]%></td>
		  <td class=xl3618464 x:num><%=dt3.Rows[i][8]%></td>
		  <td class=xl3718464 x:num><%=dt3.Rows[i][9]%></td>
		  <td class=xl3618464 x:num><%=dt3.Rows[i][10]%></td>
		  <td class=xl3718464 x:num><%=dt3.Rows[i][11]%></td>
		  <td class=xl3918464 width=110 style='width:83pt' x:num ><%=dt3.Rows[i][16]%></td>
		  <td class=xl3818464 width=75 style='border-left:none;border-right:none;border-top:none;border-bottom:none;'></td>
		 </tr>	
<%		 
		l_bank_usd = 0; l_bank_vnd = 0;
		l_cash_usd = 0; l_cash_vnd = 0; l_books_amt = 0;		
		if(dt3.Rows[i][8].ToString() != "")
		{
			l_bank_usd += decimal.Parse(dt3.Rows[i][8].ToString());
			l_tot_bank_usd += decimal.Parse(dt3.Rows[i][8].ToString());
		}	
		if(dt3.Rows[i][9].ToString() != "")
		{
			l_bank_vnd += decimal.Parse(dt3.Rows[i][9].ToString());
			l_tot_bank_vnd += decimal.Parse(dt3.Rows[i][9].ToString());
		}	
		if(dt3.Rows[i][10].ToString() != "")
		{
			l_cash_usd += decimal.Parse(dt3.Rows[i][10].ToString());
			l_tot_cash_usd += decimal.Parse(dt3.Rows[i][10].ToString());
		}	
		if(dt3.Rows[i][11].ToString() != "")
		{
			l_cash_vnd += decimal.Parse(dt3.Rows[i][11].ToString());
			l_tot_cash_vnd += decimal.Parse(dt3.Rows[i][11].ToString());
		}	
		if(dt3.Rows[i][16].ToString() != "") {
			l_books_amt += decimal.Parse(dt3.Rows[i][16].ToString());			
			l_tot_book_amt += decimal.Parse(dt3.Rows[i][16].ToString());
		}	
		l_custnm = dt3.Rows[i][17].ToString();
        l_bank_acc_no = "Sub Total - " + dt3.Rows[i][18].ToString();    
		}	
		else
		{	
 %>
 <tr class=xl2518464 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl3318464 style='height:24.95pt' x:num><%= i + 1%></td>
  <td class=xl3418464 width=355 style='width:266pt'><%=dt3.Rows[i][14]%></td>
  <td class=xl3518464 width=145 style='width:109pt'><%=dt3.Rows[i][6]%></td>
  <td class=xl3618464 x:num><%=dt3.Rows[i][8]%></td>
  <td class=xl3718464 x:num><%=dt3.Rows[i][9]%></td>
  <td class=xl3618464 x:num><%=dt3.Rows[i][10]%></td>
  <td class=xl3718464 x:num><%=dt3.Rows[i][11]%></td>
  <td class=xl3918464 width=110 style='width:83pt' x:num><%=dt3.Rows[i][16]%></td>
  <td class=xl3818464 width=75 style='border-left:none;width:56pt; border-right:none;border-top:none;border-bottom:none;'></td>
 </tr>
 <%
		if(dt3.Rows[i][8].ToString() != "")
		{
			l_bank_usd += decimal.Parse(dt3.Rows[i][8].ToString());
			l_tot_bank_usd += decimal.Parse(dt3.Rows[i][8].ToString());
		}	
		if(dt3.Rows[i][9].ToString() != "")
		{
			l_bank_vnd += decimal.Parse(dt3.Rows[i][9].ToString());
			l_tot_bank_vnd += decimal.Parse(dt3.Rows[i][9].ToString());
		}	
		if(dt3.Rows[i][10].ToString() != "")
		{
			l_cash_usd += decimal.Parse(dt3.Rows[i][10].ToString());
			l_tot_cash_usd += decimal.Parse(dt3.Rows[i][10].ToString());
		}	
		if(dt3.Rows[i][11].ToString() != "")
		{
			l_cash_vnd += decimal.Parse(dt3.Rows[i][11].ToString());
			l_tot_cash_vnd += decimal.Parse(dt3.Rows[i][11].ToString());
		}	
		if(dt3.Rows[i][16].ToString() != "") {
			l_books_amt += decimal.Parse(dt3.Rows[i][16].ToString());			
			l_tot_book_amt += decimal.Parse(dt3.Rows[i][16].ToString());
		}				
		}
	}
    l_bank_acc_no = "Sub Total - " + dt3.Rows[dt3.Rows.Count-1][18].ToString();
 %>
 <tr class=xl2518464 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl3318464 style='height:24.95pt' x:num></td>
  <td class=xl3418464 width=355 style='width:266pt'><b><%=l_bank_acc_no%></b></td>
  <td class=xl3518464 width=145 style='width:109pt'></td>
  <td class=xl3618464 x:num style='font-weight:700;' ><b><%=l_bank_usd%></b></td>
  <td class=xl3718464 x:num style='font-weight:700;' ><b><%=l_bank_vnd%></b></td>
  <td class=xl3618464 x:num style='font-weight:700;' ><b><%=l_cash_usd%></b></td>
  <td class=xl3718464 x:num style='font-weight:700;' ><b><%=l_cash_vnd%></b></td>
  <td class=xl3918464 width=110 style='width:83pt;font-weight:700;' x:num><b><%=l_books_amt%></b></td>
  <td class=xl3818464 width=75 style='border-left:none; border-right:none;border-top:none;border-bottom:none;width:56pt'></td>
 </tr>		

 <tr class=xl2518464 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td colspan=3 height=33 class=xl4318464 style='border-right:.5pt solid black;
  height:24.95pt'>Total</td>
  <td class=xl3918464 style='border-top:none;font-weight:700;' x:num><b><%=l_tot_bank_usd%></b></td>
  <td class=xl4018464 style='border-top:none;font-weight:700;' x:num><b><%=l_tot_bank_vnd%></b></td>
  <td class=xl3918464 style='border-top:none;font-weight:700;' x:num><b><%=l_tot_cash_usd%></b></td>
  <td class=xl4018464 style='border-top:none;font-weight:700;' x:num><b><%=l_tot_cash_vnd%></b></td>
  <td class=xl3918464 width=110 style='border-top:none;width:83pt;font-weight:700;' x:num ><b><%=l_tot_book_amt%></b></td>
  <td class=xl3418464 style='border-left:none;border-right:none;border-top:none;border-bottom:none;' ></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=38 style='width:29pt'></td>
  <td width=355 style='width:266pt'></td>
  <td width=145 style='width:109pt'></td>
  <td width=111 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=75 style='width:56pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
