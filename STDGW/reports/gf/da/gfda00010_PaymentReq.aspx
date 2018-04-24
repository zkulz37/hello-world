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
<% 
    // TAC_CRDA_PK
    string p_crda_pk = "";
    // TAC_HGTRH_PK
    string p_hgtrh_pk = "";
    // TCO_COMPANY_PK
    string p_com_pk = "";
    // Get URL Parameters
    p_hgtrh_pk = Request["tac_hgtrh_pk"];
    p_crda_pk = Request["tac_crda_pk"];  
    p_com_pk = Request["company_pk"];            
    // SQL Code
    string SQL = "";
    // DataTable Master
    DataTable dtM = new DataTable();
    // Master Information    
    string p_cust_name = ""; // customer name
    string p_tr_date = ""; //  Date
    string p_org_nm = ""; // department name
    string p_proposed_nm = ""; //Proposed By
    string p_voucherno = "";// Voucher No
    string p_remark = "", p_remark2 = ""; // description
    string p_tr_ccy = "";

    decimal p_net_amt = 0; // net amount
    decimal p_imp_amt = 0; // import tax amount
    decimal p_vat_famt = 0; // VAT tax amount
    decimal p_other_expense = 0; //other expense amt    
    decimal p_total = 0; // total amount
    // counter for loop
    int i; 
    // DataTAble Details
    DataTable dtD = new DataTable();
    // Description for items
    string l_desc_item = "";
    
    SQL
       = "select (select org_nm from comm.tco_org where pk = a.tco_org_pk ) org_nm, " +
           "to_char(to_date(a.tr_date, 'YYYYMMDD'), 'DD-Mon-YY') tr_date, (select u.user_name from comm.tco_bsuser u where u.pk = a.tco_bsuser_pk ) full_name, " +
           "a.voucherno, (select c.partner_name from comm.tco_buspartner c where c.pk = a.tco_buspartner_pk ) cust_nm, " +
           "a.remark, a.remark2, (select sum(d.ap_trfamt) from tac_crdad d where d.tac_crda_pk = a.pk and d.del_if = 0) net_amt, " +
           "nvl((select sum(d.imp_famt) from tac_crdad d where d.tac_crda_pk = a.pk and d.del_if = 0), 0) imp_famt, " +
           "nvl((select sum(d.impvat_famt) from tac_crdad d where d.tac_crda_pk = a.pk and d.del_if = 0), 0) vat_famt, " +
           "0 other_expense, a.tr_ccy  " +
           "from tac_crda a " +
           "where a.pk = '" + p_crda_pk + "' ";
    dtM = ESysLib.TableReadOpen(SQL);
    if (dtM.Rows.Count > 0)
    {
        p_org_nm = dtM.Rows[0][0].ToString();
        p_tr_date = dtM.Rows[0][1].ToString();
        p_proposed_nm = dtM.Rows[0][2].ToString();
        p_voucherno = dtM.Rows[0][3].ToString();
        p_cust_name = dtM.Rows[0][4].ToString();
        p_remark = dtM.Rows[0][5].ToString();
        p_remark2 = dtM.Rows[0][6].ToString();
        if (dtM.Rows[0][7].ToString() != "")
            p_net_amt = decimal.Parse(dtM.Rows[0][7].ToString());
        else
            p_net_amt = 0;
        if (dtM.Rows[0][8].ToString() != "")
            p_imp_amt = decimal.Parse(dtM.Rows[0][8].ToString());
        else
            p_imp_amt = 0;
        if (dtM.Rows[0][9].ToString() != "")
            p_vat_famt = decimal.Parse(dtM.Rows[0][9].ToString());
        else
            p_vat_famt = 0;
        if (dtM.Rows[0][10].ToString() != "")
            p_other_expense = decimal.Parse(dtM.Rows[0][10].ToString());
        else
            p_other_expense = 0;
        p_total = p_net_amt + p_imp_amt + p_vat_famt + p_other_expense;     
        p_tr_ccy = dtM.Rows[0][11].ToString();
    }
    SQL
	= "select d.ccy, acnt.sf_a_get_accd(d.tac_abacctcode_pk, '" + p_com_pk + "') accd, acnt.sf_a_get_acnm(d.tac_abacctcode_pk, '" + p_com_pk + "', 'ENG') acnm, " + 
        "    to_char(d.tr_rate, '999,999.90') tr_rate, to_char(d.tr_bookamt, '999,999,999,999,999.90') tr_bookamt, d.tr_bookamt book_amt " +
        "from tac_hgtrd d " +
        "where d.tac_hgtrh_pk = '" + p_hgtrh_pk + "' " +
        "and d.del_if = 0 " +
        "and d.drcr_type = 'D' " +
        "order by d.pk " ;
    dtD = ESysLib.TableReadOpen(SQL);
    
      
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="PaymentRequestAP_files/filelist.xml">
<link rel=Edit-Time-Data href="PaymentRequestAP_files/editdata.mso">
<link rel=OLE-Object-Data href="PaymentRequestAP_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2011-07-14T04:24:04Z</o:LastPrinted>
  <o:Created>2011-07-13T09:06:44Z</o:Created>
  <o:LastSaved>2011-07-14T04:24:18Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.76in 0in .5in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
.style18
	{mso-number-format:"_\(\0022$\0022* \#\,\#\#0\.00_\)\;_\(\0022$\0022* \\\(\#\,\#\#0\.00\\\)\;_\(\0022$\0022* \0022-\0022??_\)\;_\(\@_\)";
	mso-style-name:Currency;
	mso-style-id:4;}
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
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]dd\\-mmm\\-yyyy\;\@";
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style18;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style16;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:silver;
	mso-pattern:auto gray-25;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl52
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl65
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl70
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl73
	{mso-style-parent:style22;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl80
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl83
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-rotate:90;}
.xl85
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl86
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl89
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl94
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl95
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl96
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	layout-flow:vertical;}
.xl97
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;
	layout-flow:vertical;}
.xl98
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	layout-flow:vertical;}
.xl99
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl100
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl101
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl105
	{mso-style-parent:style18;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style16;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style18;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl108
	{mso-style-parent:style18;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl109
	{mso-style-parent:style18;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PaymentRequestAP_rpt</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:TopRowVisible>6</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$9:$J$9</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15210</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1232 style='border-collapse:
 collapse;table-layout:fixed;width:926pt'>
 <col class=xl24 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl24 width=78 style='mso-width-source:userset;mso-width-alt:2852;
 width:59pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl24 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <col class=xl24 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=52 span=241 style='mso-width-source:userset;mso-width-alt:
 1901;width:39pt'>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=11 height=34 class=xl94 width=680 style='height:25.5pt;
  width:512pt' x:str="PHIẾU CHI/ THU / CHUYỂN TIỀN ">PHIẾU CHI/ THU / CHUYỂN
  TIỀN<span style='mso-spacerun:yes'> </span></td>
  <td class=xl24 width=124 style='width:93pt'></td>
  <td class=xl24 width=118 style='width:89pt'></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=52 style='width:39pt'></td>
  <td class=xl24 width=52 style='width:39pt'></td>
  <td class=xl24 width=52 style='width:39pt'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td colspan=11 height=34 class=xl95 style='height:25.5pt'>PAYMENT/INCOME/TRANSFER<span
  style='mso-spacerun:yes'>  </span>VOUCHER</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=11 class=xl24 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl26 colspan=2 style='height:18.0pt;mso-ignore:colspan'>Dept
  <font class="font5">-</font><font class="font9">&nbsp; </font><font
  class="font8">Bộ Phận</font><font class="font10">:</font></td>
  <td class=xl27 colspan=3 style='mso-ignore:colspan'><%=p_org_nm%></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl24><span style='mso-spacerun:yes'> </span></td>
  <td class=xl26>Date<font class="font5">-</font><font class="font9">&nbsp; </font><font
  class="font8">Ngày</font><font class="font10">:</font></td>
  <td class=xl28 x:str><%=p_tr_date%></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl29 colspan=4 style='height:22.5pt;mso-ignore:colspan'>Request
  by<font class="font5">-</font><font class="font8">Người Yêu Cầu</font><font
  class="font10">: </font><font class="font5"><%=p_proposed_nm %></font></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>Số/Voucher No<font class="font5">:</font></td>
  <td class=xl27 x:str><%=p_voucherno%></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=11 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td rowspan=9 height=268 class=xl96 width=29 style='border-bottom:.5pt solid black;
  height:201.0pt;width:22pt'>SUMMARY</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Total Amt - Tổng Số</td>
  <td colspan=7 class=xl99 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl54 style='border-right:.5pt solid black;
  height:21.0pt;border-left:none'>Client- Khách Hàng</td>
  <td colspan=7 class=xl49 style='border-right:.5pt solid black;border-left:
  none'>Description<font class="font5">- </font><font class="font8">Diễn Giải</font></td>
  <td class=xl31>Amount<font class="font5">/ </font><font class="font8">Số Tiền</font></td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=2 height=36 class=xl102 width=138 style='border-right:.5pt solid black;
  height:27.0pt;border-left:none;width:104pt'><%=p_cust_name %></td>
  <td colspan=7 class=xl102 width=400 style='border-right:.5pt solid black;
  border-left:none;width:301pt'><%=p_remark%></td>
  <td class=xl33>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=2 height=36 class=xl88 style='border-right:.5pt solid black;
  height:27.0pt;border-left:none'>&nbsp;</td>
  <td colspan=7 class=xl90 width=400 style='border-right:.5pt solid black;
  border-left:none;width:301pt'><%=p_remark2%></td>
  <td class=xl34>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl88 style='border-right:.5pt solid black;
  height:21.0pt;border-left:none'>&nbsp;</td>
  <td colspan=7 class=xl62 style='border-right:.5pt solid black;border-left:
  none' x:str><%=p_voucherno%></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl88 style='border-right:.5pt solid black;
  height:21.0pt;border-left:none'>&nbsp;</td>
  <td colspan=7 class=xl90 width=400 style='border-right:.5pt solid black;
  border-left:none;width:301pt'>Net Amount</td>
  <td class=xl105 x:num><span style='mso-spacerun:yes'>          
  </span><%=p_net_amt %> </td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl88 style='border-right:.5pt solid black;
  height:21.0pt;border-left:none'>&nbsp;</td>
  <td colspan=7 class=xl90 width=400 style='border-right:.5pt solid black;
  border-left:none;width:301pt'>IM Duties Amount</td>
  <td class=xl106 x:num><span
  style='mso-spacerun:yes'>                       </span><%=p_imp_amt%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl88 style='border-right:.5pt solid black;
  height:21.0pt;border-left:none'>&nbsp;</td>
  <td colspan=7 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>VAT Amount</td>
  <td class=xl105 x:num><span style='mso-spacerun:yes'>            
  </span><%=p_vat_famt%> </td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl57 style='border-right:.5pt solid black;
  height:21.0pt;border-left:none'>&nbsp;</td>
  <td colspan=7 class=xl79 style='border-right:.5pt solid black;border-left:
  none'>Other Expense</td>
  <td class=xl107 x:num><span
  style='mso-spacerun:yes'>                       </span><%=p_other_expense%><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=3 height=103 class=xl82 width=29 style='border-bottom:.5pt solid black;
  height:77.25pt;border-top:none;width:22pt' x:str="Request &amp; Confirmation ">Request
  &amp; Confirmation<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Member</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:str="Chief ">Chief<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:str="Manager ">Manager<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none'>Director</td>
  <td rowspan=3 class=xl85 width=100 style='border-bottom:.5pt solid black;
  border-top:none;width:75pt'>TOTAL<br>
    TỔNG CỘNG</td>
  <td rowspan=2 class=xl108 style='border-bottom:.5pt solid black' x:num
  ><span style='mso-spacerun:yes'>          
  </span><%=p_total %> </td>
  <td class=xl24></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=2 height=19 class=xl54 style='border-right:.5pt solid black;
  height:14.25pt;border-left:none'>Yêu Cầu</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none'>Kiểm tra</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none'>Ký duyệt</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none'>Ký duyệt</td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=62 style='mso-height-source:userset;height:46.5pt'>
  <td colspan=2 height=62 class=xl56 style='border-right:.5pt solid black;
  height:46.5pt;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl35 style='border-top:none'><%=p_tr_ccy %></td>
  <td class=xl25></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=11 height=26 class=xl76 style='border-right:.5pt solid black;
  height:19.5pt'>USE FOR ACCOUNT ONLY - PHẦN CHỈ SỬ DỤNG CHO KẾ TOÁN</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl54 style='border-right:.5pt solid black;
  height:19.5pt'>Acc Code</td>
  <td class=xl36 style='border-top:none'>Item</td>
  <td colspan=5 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Description-Diễn tả</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none'>Debit- Nợ</td>
  <td class=xl36 style='border-top:none'>Credit- Có</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     for (i = 0; i < dtD.Rows.Count; i++)
     {
         l_desc_item = dtD.Rows[i][2].ToString() + "[" + dtD.Rows[i][0].ToString() + ", " + dtD.Rows[i][4].ToString() + "]" + " [Rate: " + dtD.Rows[i][3].ToString() + "]";          
 %>
 <tr height=36 style='mso-height-source:userset;height:41.3pt'>
  <td colspan=2 height=36 class=xl69 style='border-right:.5pt solid black;
  height:27.0pt' x:str><%=dtD.Rows[i][1] %></td>
  <td class=xl32>&nbsp;</td>
  <td colspan=5 class=xl71 width=246 style='border-right:.5pt solid black;
  border-left:none;width:185pt'><%=l_desc_item%></td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:
  none' x:num><span style='mso-spacerun:yes'>                 
  </span><%=dtD.Rows[i][5]%> </td>
  <td class=xl37>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <% 
     }
     SQL
     = "select d.ccy, acnt.sf_a_get_accd(d.tac_abacctcode_pk, '" + p_com_pk + "') accd, acnt.sf_a_get_acnm(d.tac_abacctcode_pk, '" + p_com_pk + "', 'ENG') acnm, " +
         "    to_char(d.tr_rate, '999,999.90') tr_rate, to_char(d.tr_bookamt, '999,999,999,999,999.90') tr_bookamt, d.tr_bookamt book_amt " +
         "from tac_hgtrd d " +
         "where d.tac_hgtrh_pk = '" + p_hgtrh_pk + "' " +
         "and d.del_if = 0 " +
         "and d.drcr_type = 'C' " +
         "order by d.pk ";
     dtD = ESysLib.TableReadOpen(SQL);
     for (i = 0; i < dtD.Rows.Count; i++)
     {
         l_desc_item = dtD.Rows[i][2].ToString() + "[" + dtD.Rows[i][0].ToString() + ", " + dtD.Rows[i][4].ToString() + "]" + " [Rate: " + dtD.Rows[i][3].ToString() + "]";          
 %>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=2 height=36 class=xl62 style='border-right:.5pt solid black;
  height:27.0pt' x:str><%=dtD.Rows[i][1] %></td>
  <td class=xl32>&nbsp;</td>
  <td colspan=5 class=xl64 width=246 style='border-right:.5pt solid black;
  border-left:none;width:185pt'><%=l_desc_item %></td>
  <td colspan=2 class=xl67 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl37 x:num><span style='mso-spacerun:yes'>       
  </span><%=dtD.Rows[i][5] %> </td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>    
 <% 
     }
    %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=2 height=27 class=xl57 style='border-right:.5pt solid black;
  height:20.25pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td colspan=5 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl57 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=8 height=24 class=xl54 style='border-right:.5pt solid black;
  height:18.0pt'>Accounting Dept</td>
  <td colspan=3 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Head Office</td>
  <td colspan=7 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl54 style='border-right:.5pt solid black;
  height:15.0pt'>Member</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Chief Acc</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none'>Manager</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Director</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Manager</td>
  <td class=xl36 style='border-top:none'>President</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl54 style='border-right:.5pt solid black;
  height:15.75pt'>Kiểm tra</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Ký duyệt</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Ký duyệt</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Ký duyệt</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Kiểm tra</td>
  <td class=xl31>Ký duyệt</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=74 style='mso-height-source:userset;height:55.5pt'>
  <td colspan=2 height=74 class=xl56 style='border-right:.5pt solid black;
  height:55.5pt'>&nbsp;</td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 height=30 class=xl54 style='border-right:.5pt solid black;
  height:22.5pt'>Cashier-Thủ quỹ</td>
  <td colspan=4 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>Received by- Người nhận</td>
  <td colspan=5 class=xl54 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 rowspan=2 height=45 class=xl41 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:33.75pt'>&nbsp;</td>
  <td colspan=4 rowspan=2 class=xl41 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:str="Bank Name ">Bank Name<span style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl49 style='border-right:.5pt solid black;
  height:18.0pt;border-left:none'>Check #</td>
  <td colspan=3 class=xl51 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=29 style='width:22pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=124 style='width:93pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=52 style='width:39pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
