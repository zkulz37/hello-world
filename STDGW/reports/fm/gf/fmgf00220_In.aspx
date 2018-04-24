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
	string ls_from_dt = "", ls_to_dt = "";
   string ls_compk = Request["company_pk"];
   ls_from_dt = Request["from_dt"];
   ls_to_dt = Request["to_dt"];
   string l_tuden_ngay = ls_from_dt.Substring(6,2) + "/" + ls_from_dt.Substring(4,2) + "/" + ls_from_dt.Substring(0, 4);
   l_tuden_ngay += " - " + ls_to_dt.Substring(6,2) + "/" + ls_to_dt.Substring(4,2) + "/" + ls_to_dt.Substring(0, 4);
string SQL
	= "select *  " + 
        "from " +
        "( " +
        "select a.voucherno, (select h.pk from tac_hgtrh h where h.tr_tablenm = 'TAC_CRDA' and h.tr_table_pk = a.pk  " +
        "    and h.del_if = 0 and h.tr_status in ('2', '0') ) seq " +
        "    , '' RFI, to_char(to_date(a.tr_date, 'YYYYMMDD'), 'DD/MM/YYYY') tr_date, i.item_code, i.item_name " +
        "    , d.ap_unit, d.ap_qty, nvl(i.weight, 0) * nvl(d.ap_qty, 0) weight, d.ap_uprice, t.in_tramt, t.in_amt " +
        "    , d.impvat_amt, d.impvat_famt, v.pl_cd, v.pl_nm, c.partner_id, c.partner_name " +
        "    , a.invoice_no, to_char(to_date(a.invoice_date, 'YYYYMMDD'), 'dd/mm/yyyy') inv_dt, a.serial_no, d.remark2   " +
        "from tac_crda a, tac_crdad d, tac_stocktr t, comm.tco_item i " +
        ", comm.tco_buspartner c, v_abplcenter v " +
        "where a.tr_date between '" + ls_from_dt + "' and '" + ls_to_dt + "' " +
        "and a.tco_company_pk = '" + ls_compk + "' " +
        "and a.del_if = 0 " +
        "and a.tr_status in ('2', '0') " +
        "and a.pk = d.tac_crda_pk " +
        "and d.del_if = 0 " +
        "and d.pk = t.tr_table_pk and t.tr_table_nm = 'TAC_CRDAD' " +
        "and t.del_if = 0 and t.tr_status in('2', '0') " +
        "and d.tco_item_pk = i.pk " +
        "and a.tco_buspartner_pk = c.pk " +
        "and d.tac_abplcenter_pk = v.tac_abplcenter_pk(+) " +
        "union all " +
        "select a.voucherno, (select h.pk from tac_hgtrh h where h.tr_tablenm = 'TAC_CRDA' and h.tr_table_pk = a.pk  " +
        "    and h.del_if = 0 and h.tr_status in ('2', '0') ) seq " +
        "    , '' RFI, to_char(to_date(a.tr_date, 'YYYYMMDD'), 'DD/MM/YYYY') tr_date, i.item_code, i.item_name " +
        "    , d.ap_unit, d.ap_qty, nvl(i.weight, 0) * nvl(d.ap_qty, 0) weight, d.ap_uprice, t.in_tramt, t.in_amt " +
        "    , 0 impvat_amt, 0 impvat_famt, v.pl_cd, v.pl_nm, c.partner_id, c.partner_name " +
        "    , '' invoice_no, '' invoice_date, '' serial_no, d.remark2   " +
        "from tac_crda_other a, tac_crdad_other d, tac_stocktr t, comm.tco_item i " +
        ", comm.tco_buspartner c, v_abplcenter v " +
        "where a.tr_date between '" + ls_from_dt + "' and '" + ls_to_dt + "' " +
        "and a.tco_company_pk = '" + ls_compk + "' " +
        "and a.del_if = 0 " +
        "and a.tr_status in ('2', '0') " +
        "and a.pk = d.tac_crda_other_pk " +
        "and d.del_if = 0 " +
        "and d.pk = t.tr_table_pk and t.tr_table_nm = 'TAC_CRDAD_OTHER' " +
        "and t.del_if = 0 and t.tr_status in('2', '0') " +
        "and d.tco_item_pk = i.pk " +
        "and a.tco_buspartner_pk = c.pk " +
        "and d.tac_abplcenter_pk = v.tac_abplcenter_pk(+) " +
        " union all " +        
	    "select a.voucher_no, (select h.pk from tac_hgtrh h where h.tr_tablenm = 'TAC_CRDA' and h.tr_table_pk = a.pk   " + 
        "    and h.del_if = 0 and h.tr_status in ('2', '0') ) seq  " +
        "    , '' RFI, to_char(to_date(a.RTN_DATE, 'YYYYMMDD'), 'DD/MM/YYYY') tr_date, i.item_code, i.item_name  " +
        "    , d.uom, d.RTN_QTY, nvl(i.weight, 0) * nvl(d.RTN_QTY, 0) weight, d.unit_price, t.in_tramt, t.in_amt  " +
        "    , 0 impvat_amt, 0 impvat_famt, v.pl_cd, v.pl_nm, c.partner_id, c.partner_name  " +
        "    , '' invoice_no, '' invoice_date, '' serial_no, d.remark2    " +
        "from TAC_CRGOODSRTN a, TAC_CRGOODSRTND d, tac_stocktr t, comm.tco_item i  " +
        ", comm.tco_buspartner c, v_abplcenter v  " +
        "where a.rtn_date between '" + ls_from_dt + "' and '" + ls_to_dt + "'  " +
        "and a.tco_company_pk = '" + ls_compk + "'  " +
        "and a.del_if = 0  " +
        "and a.pk = d.TAC_CRGOODSRTN_pk  " +
        "and d.del_if = 0  " +
        "and d.pk = t.tr_table_pk and t.tr_table_nm = 'TAC_CRGOODSRTND'  " +
        "and t.del_if = 0 and t.tr_status in('2', '0') and t.trin_type = '12' " +
        "and d.tco_item_pk = i.pk  " +
        "and a.tco_buspartner_pk = c.pk  " +
        "and d.tac_abplcenter_pk = v.tac_abplcenter_pk(+) " +        
        ") b " +
        "order by b.voucherno " ;
	DataTable dt = new DataTable();
	dt = ESysLib.TableReadOpen(SQL);
	int i;	
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00220_In_files/filelist.xml">
<link rel=Edit-Time-Data href="fmgf00220_In_files/editdata.mso">
<link rel=OLE-Object-Data href="fmgf00220_In_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:Created>2010-04-28T01:29:27Z</o:Created>
  <o:LastSaved>2010-04-28T02:36:43Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl28
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl29
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl38
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style16;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style16;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl53
	{mso-style-parent:style16;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	color:blue;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style16;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style16;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PublishObjects>
     <x:PublishObject>
      <x:Id>7418</x:Id>
      <x:DivID>Book1_7418</x:DivID>
      <x:SourceType>SourceSheet</x:SourceType>
      <x:HtmlType>HtmlStatic</x:HtmlType>
      <x:Location HRef="D:\Van Le\Poslilama\fmgf00220_In.htm"/>
     </x:PublishObject>
    </x:PublishObjects>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10065</x:WindowHeight>
  <x:WindowWidth>17145</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2447 style='border-collapse:
 collapse;table-layout:fixed;width:1839pt'>
 <col class=xl25 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <col class=xl25 width=42 style='mso-width-source:userset;mso-width-alt:1536;
 width:32pt'>
 <col class=xl25 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl26 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl25 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl25 width=153 style='mso-width-source:userset;mso-width-alt:5595;
 width:115pt'>
 <col class=xl26 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl25 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1938'>
 <col class=xl27 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl27 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl28 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl28 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl27 width=64 style='width:48pt'>
 <col class=xl27 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl27 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl28 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl25 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl25 width=158 style='mso-width-source:userset;mso-width-alt:5778;
 width:119pt'>
 <col class=xl25 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl25 width=185 style='mso-width-source:userset;mso-width-alt:6765;
 width:139pt'>
 <col class=xl25 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl25 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl25 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl25 width=164 style='mso-width-source:userset;mso-width-alt:5997;
 width:123pt'>
 <col class=xl25 width=64 span=8 style='width:48pt'>
 <tr height=27 style='height:20.25pt'>
  <td colspan=24 height=27 class=xl24 width=1935 style='height:20.25pt;
  width:1455pt'>LIST OF MATERIAL BUYING</td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 align=left style='height:12.75pt'>PERIOD: <%=l_tuden_ngay%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl25></td>
  <td colspan=2 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
  <td colspan=8 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl29 style='height:20.1pt'>Doc. No.</td>
  <td class=xl30>Seq</td>
  <td class=xl31 width=86 style='width:65pt'>RFI ( request for inspection)</td>
  <td class=xl30>Date</td>
  <td class=xl32>Code</td>
  <td class=xl30>Name of material</td>
  <td class=xl30>Unit</td>
  <td class=xl30>U.W</td>
  <td class=xl33 x:str="Q'ty"><span style='mso-spacerun:yes'> </span>Q'ty<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="Weight"><span
  style='mso-spacerun:yes'> </span>Weight<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl34 x:str="U.price"><span
  style='mso-spacerun:yes'> </span>U.price<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl34 x:str="Amount _ vnd"><span
  style='mso-spacerun:yes'> </span>Amount _ vnd<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="U.price_us"><span
  style='mso-spacerun:yes'> </span>U.price_us<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="Amount _ us"><span
  style='mso-spacerun:yes'> </span>Amount _ us<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl33 x:str="Vat_us"><span
  style='mso-spacerun:yes'> </span>Vat_us<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl34 x:str="VAT_vnd"><span
  style='mso-spacerun:yes'> </span>VAT_vnd<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl35 style='border-right:.5pt solid black;border-left:
  none'>Project</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>Supplier</td>
  <td class=xl30>Invoice</td>
  <td class=xl30>Date</td>
  <td class=xl30>Seri</td>
  <td class=xl30>Remark</td>
  <td colspan=8 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <%	
	decimal l_tot_amt_vnd = 0, l_tot_amt_us = 0;
	for(i = 0 ; i < dt.Rows.Count; i++)
	{
		l_tot_amt_vnd += decimal.Parse(dt.Rows[i][10].ToString());
		l_tot_amt_us += decimal.Parse(dt.Rows[i][11].ToString());
 %>
 <tr class=xl47 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl40 align=left style='height:20.1pt'><%=dt.Rows[i][0]%></td>
  <td class=xl41><%=dt.Rows[i][1]%></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42><%=dt.Rows[i][3]%></td>
  <td class=xl43 align=left><%=dt.Rows[i][4]%></td>
  <td class=xl44 align=left width=153 style='width:115pt'><%=dt.Rows[i][5]%></td>
  <td class=xl42><%=dt.Rows[i][6]%></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl45 align=left x:num><span style='mso-spacerun:yes'>        
  </span><%=dt.Rows[i][7]%> </td>
  <td class=xl45 align=left x:num="0"><span
  style='mso-spacerun:yes'>              </span>-<span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl46 align=left x:num><span
  style='mso-spacerun:yes'>        </span><%=dt.Rows[i][9]%> </td>
  <td class=xl46 align=left x:num><span
  style='mso-spacerun:yes'>              </span><%=dt.Rows[i][10]%> </td>
  <td class=xl45>&nbsp;</td>
  <td class=xl45 align=left x:num><span
  style='mso-spacerun:yes'>          </span><%=dt.Rows[i][11]%> </td>
  <td class=xl45 x:num><%=dt.Rows[i][12]%></td>
  <td class=xl46 x:num><%=dt.Rows[i][13]%></td>
  <td class=xl43 align=left><%=dt.Rows[i][14]%></td>
  <td class=xl44 align=left width=158 style='width:119pt'><%=dt.Rows[i][15]%></td>
  <td class=xl43 align=left><%=dt.Rows[i][16]%></td>
  <td class=xl44 align=left width=185 style='width:139pt'><%=dt.Rows[i][17]%></td>
  <td class=xl41 align=left><%=dt.Rows[i][18]%></td>
  <td class=xl42><%=dt.Rows[i][19]%></td>
  <td class=xl41 align=left><%=dt.Rows[i][20]%></td>
  <td class=xl44 width=164 style='width:123pt'><%=dt.Rows[i][21]%></td>
  <td colspan=8 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <%
	}
 %>
 <tr class=xl63 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl56 style='height:20.1pt'>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl59 align=left>Grand Total</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl61 align=left x:num><span
  style='mso-spacerun:yes'>        </span><%=l_tot_amt_vnd%> </td>
  <td class=xl60>&nbsp;</td>
  <td class=xl60 align=left x:num><span
  style='mso-spacerun:yes'>     </span><%=l_tot_amt_us%> </td>
  <td class=xl60>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td colspan=8 class=xl62 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=119 style='width:89pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=153 style='width:115pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=0></td>
  <td width=70 style='width:53pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=158 style='width:119pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=185 style='width:139pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=164 style='width:123pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
