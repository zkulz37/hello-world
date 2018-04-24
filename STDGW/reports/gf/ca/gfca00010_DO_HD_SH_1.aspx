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
	string SQL = "", ls_tac_hgtrh_pk = "", ls_tac_crca_pk = "", lcompany_pk = "";	
    	ls_tac_hgtrh_pk = Request["tac_hgtrh_pk"];
    	lcompany_pk = Request["company_pk"];
    	ls_tac_crca_pk = Request["tac_crca_pk"];
	
	SQL = "select a.code_nm from tac_commcode_detail a, tac_commcode_master b where a.del_if = 0 and b.del_if = 0 and a.tac_commcode_master_pk = b.pk and b.id = 'EACBK016' and a.code = 'AROS' ";
	DataTable dtLength = new DataTable();
	dtLength = ESysLib.TableReadOpen(SQL);
	SQL
	= "select substr(a.tr_date, 1, 4) yyyy, substr(a.tr_date, 5, 2) mm, substr(a.tr_date, 7, 2) dd,  " + 
        "				 c.partner_name, nvl(c.addr1, '') || nvl(c.addr2, ' ') || nvl(c.addr3, ' ') address, " +
        "				 NVL((        select c.item_lnm " +
        "          from tac_crcaditem b, tac_abitem c " +
        "         where b.del_if       = 0 " +
        "           and c.del_if       = 0 " +
        "           and b.tac_crca_pk  = '" + ls_tac_crca_pk + "' " +
        "           and b.tac_abitem_pk = c.pk " +
        "	    and c.item_nm = 'PAYMENT METHOD' ), 'CK') pay_method, " +
        "	    c.tax_code, decode(a.vat_rate, '01', '0', '00', '0', a.vat_rate) vat_rate,  " +
        "	    a.tot_net_bk_amt tot_net_bk_amt,  " +
        "	a.tot_vat_bk_amt, " + 
        "	nvl(a.tot_net_bk_amt, 0) + nvl(a.tot_vat_bk_amt, 0) tot_inc_vattax, a.invoice_no, " +
        "		(        select c.item_lnm " +
        "          from tac_crcaditem b, tac_abitem c " +
        "         where b.del_if       = 0 " +
        "           and c.del_if       = 0 " +
        "           and b.tac_crca_pk  = '" + ls_tac_crca_pk + "' " +
        "           and b.tac_abitem_pk = c.pk " +
        "	    and c.item_nm = 'DECLARATION NO' ) contract_no, length(c.tax_code) length_taxcd, to_char(to_date(a.tr_date, 'YYYYMMDD'), 'DD/MM/YYYY') trans_dt, a.tr_ccy, to_char(a.tr_rate,'999,999,999,999') tr_rate, " + 
        " a.tot_net_tr_amt  tot_net_tr_amt, decode(a.tr_ccy, 'VND', to_char(a.tot_net_tr_amt, '999,999,999,999,999'), to_char(a.tot_net_tr_amt, '999,999,999,999,999.99')) tot_net_tr_amt_1, " +
		" decode(a.tr_ccy, 'VND', to_char(a.tot_net_bk_amt, '999,999,999,999,999'), to_char(a.tot_net_bk_amt, '999,999,999,999,999.99')) tot_net_bk_amt_1, " +
		" decode(a.tr_ccy, 'VND', to_char(a.tot_vat_bk_amt, '999,999,999,999,999'), to_char(a.tot_vat_bk_amt, '999,999,999,999,999.99')) tot_vat_bk_amt_1, " +
		" decode(a.tr_ccy, 'VND', to_char(nvl(a.tot_net_bk_amt, 0) + nvl(a.tot_vat_bk_amt, 0), '999,999,999,999,999'), to_char(nvl(a.tot_net_bk_amt, 0) + nvl(a.tot_vat_bk_amt, 0), '999,999,999,999,999.99')) tot_inc_vattax_1 " +
        "from tac_crca a, comm.tco_buspartner c " +
        "where a.del_if = 0 " +
        "and c.del_if(+) = 0 " +
        "and a.tco_buspartner_pk = c.pk(+) " +
        "and a.pk = '" + ls_tac_crca_pk + "' " ;

    DataTable dtMst = new DataTable();
    dtMst = ESysLib.TableReadOpen(SQL); 

	string ls_partner = "" ;
	string[] l_tax_num = new string[15];
	string ls_taxcd = "" ;
	int j, k = 0;
	String ls_tax_code = "" ;
        string ls_contract_no = "" ;
	ls_contract_no = " " + dtMst.Rows[0][12].ToString() + " Ngày " + dtMst.Rows[0][14].ToString();
	if(dtMst.Rows[0][3].ToString() != "")
	{
	    ls_partner = "Bán cho " + dtMst.Rows[0][3].ToString() ;	
	}
	else
	{
	    ls_partner = "Bán cho " ;	
	}
 SQL
	= "SELECT tbl_sum.item_name, tbl_sum.uom, ROUND(tbl_sum.qty, 0) qty, " + 
        "       DECODE (tbl_sum.tr_ccy, " +
        "               'VND', TO_CHAR (ROUND (tbl_sum.u_price, 2), '999,999,999,999.99'), " +
        "               TO_CHAR (ROUND (tbl_sum.u_price, 5), '999,999,999,999.99999') " +
        "              ) uprice, " +
        "       DECODE (tbl_sum.tr_ccy, " +
        "               'VND', TO_CHAR (ROUND (tbl_sum.net_tr_amt, 2), " +
        "                               '999,999,999,999,999,999' " +
        "                              ), " +
        "               TO_CHAR (ROUND (tbl_sum.net_tr_amt, 2), " +
        "                        '999,999,999,999,999,999.99' " +
        "                       ) " +
        "              ) net_tr_amt, " +
        "       tbl_sum.item_desc, tbl_sum.sizea, tbl_sum.cap_color, " +
        "       tbl_sum.body_color, tbl_sum.tr_ccy, " +
        "       ROUND (tbl_sum.net_tr_amt, 2) net_tr_amt_1, to_char(ROUND(tbl_sum.qty, 0), '999,999,999') qty_1 " +
        "  FROM (SELECT tbl.item_name, tbl.uom, tbl.qty qty, tbl.u_price, " +
        "               tbl.net_tr_amt net_tr_amt, tbl.item_desc, " +
        "               sf_get_sizea_sign (tbl.sizea) sizea, tbl.cap_color, " +
        "               tbl.body_color, tbl.tr_ccy " +
        "          FROM (SELECT DISTINCT i.item_name, 'Vien' uom, d.qty, d.u_price, " +
        "                                d.net_tr_amt, d.item_desc, " +
        "                                i.size_code sizea, " +
        "                                (select color_code from prod.tsh_color where pk = i.cap_color_pk ) cap_color, " +
        "                                (select color_code from prod.tsh_color where pk = i.body_color_pk) body_color, " +
        "                                a.tr_ccy, d.order_no " +
        "                           FROM tac_crcad d, " +
        "                                comm.tco_item i, " +
        "                                tac_crca a " +
        "                          WHERE d.tac_crca_pk = '" + ls_tac_crca_pk + "'  " +
        "                          AND d.del_if = 0 " +
        "                            AND d.tac_crca_pk = a.pk " +
        "                            AND a.del_if = 0 " +
        "                            AND d.tco_item_pk = i.pk " +
        "                            AND i.del_if = 0 " +
        "                            ) tbl) tbl_sum " ;

 //Response.Write(SQL);
 //Response.End();
        DataTable dtDetail = new DataTable();
        dtDetail = ESysLib.TableReadOpen(SQL);
		string l_gelatin = "Vỏ viên nang Gelatin";
	string ls_uprice = "", ls_sizea = "";
	string ls_tr_amt = "" ;
	string ls_ccy = dtMst.Rows[0][15].ToString();
	//if(dtLength.Rows.Count > 0)
	    //k = int.Parse(dtLength.Rows[0][0].ToString());
    k = 10;
    SQL = "select a.code from tac_commcode_detail a, tac_commcode_master b where a.del_if = 0 and b.del_if = 0 and a.tac_commcode_master_pk = b.pk and b.id = 'ACBG0040' and a.def_yn = 'Y'";
    DataTable dtBook_Ccy = new DataTable();
    dtBook_Ccy = ESysLib.TableReadOpen(SQL);
    string ls_book_ccy = dtBook_Ccy.Rows[0][0].ToString();

	string l_xls_format = "" ;
	if(dtMst.Rows[0][15].ToString()!="VND")
	{
		l_xls_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	}
	else
	{
		l_xls_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	}
    string l_xls_book_ccy = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="uh_files/filelist.xml">
<link rel=Edit-Time-Data href="uh_files/editdata.mso">
<link rel=OLE-Object-Data href="uh_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>genuwin</o:Author>
  <o:LastAuthor>Minh</o:LastAuthor>
  <o:LastPrinted>2009-10-17T07:22:03Z</o:LastPrinted>
  <o:Created>2009-06-27T08:48:37Z</o:Created>
  <o:LastSaved>2010-10-08T09:44:37Z</o:LastSaved>
  <o:Company>company</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .15in 0in .15in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl48
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	white-space:nowrap;
	text-align:right;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	text-align:center;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl64
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>AR</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>12</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>31</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$32:$H$33</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11715</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2505</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=704 style='border-collapse:
 collapse;table-layout:fixed;width:530pt'>
 <col class=xl24 width=6 style='mso-width-source:userset;mso-width-alt:219;
 width:5pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=234 style='mso-width-source:userset;mso-width-alt:8557;
 width:176pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl24 width=6 style='height:14.1pt;width:5pt'></td>
  <td class=xl24 width=32 style='width:24pt'></td>
  <td class=xl24 width=234 style='width:176pt'></td>
  <td class=xl24 width=52 style='width:39pt'></td>
  <td class=xl24 width=65 style='width:49pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=96 style='width:72pt'></td>
  <td class=xl24 width=137 style='width:103pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td class=xl59 width=52 style='width:39pt'><%=dtMst.Rows[0][2]%></td>
  <td class=xl59 width=65 style='width:49pt'><%=dtMst.Rows[0][1]%></td>
  <td class=xl59 width=82 style='width:62pt'><%=dtMst.Rows[0][0]%></td>
  <td colspan=2 class=xl65 width=233 style='width:175pt'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td colspan=5 class=xl66 width=465 style='width:350pt'></td>
  <td colspan=2 class=xl67 width=233 style='width:175pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl27></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td class=xl28></td>
  <td class=xl26></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td class=xl29></td>
  <td class=xl26></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=8 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=2 class=xl24 style='height:21.0pt;mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 style='height:21.75pt'></td>
  <td class=xl32></td>
  <td class=xl24></td>
  <td class=xl31 colspan=5 style='mso-ignore:colspan'><%=dtMst.Rows[0][3]%></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 style='height:19.5pt'></td>
  <td class=xl34></td>
  <td></td>
  <td class=xl33 colspan=5 style='mso-ignore:colspan'><%=dtMst.Rows[0][4]%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 style='height:18.0pt'></td>
  <td class=xl34></td>
  <td></td>
  <td class=xl24></td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 style='height:18.0pt'></td>
  <td class=xl34></td>
  <td></td>
  <td class=xl24></td>
  <td class=xl31><%=dtMst.Rows[0][5]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl63><%=dtMst.Rows[0][6]%></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl24 style='height:21.75pt'></td>
  <td class=xl34></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl35 height=43 style='mso-height-source:userset;height:32.25pt'>
  <td height=43 class=xl35 style='height:32.25pt'></td>
  <td class=xl24></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl61 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl61 style='height:22.5pt'></td>
  <td class=xl46></td>
  <td class=xl47 width=234 style='width:176pt'><%=l_gelatin%></td>
  <td class=xl47></td>
  <td class=xl62></td>
  <td class=xl48 x:str=" "><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl49 x:str=" "><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl49 x:str=" "><span style='mso-spacerun:yes'>   </span></td>
 </tr>
 <%
	string l_net_tramt = "", l_net_tramt_1 = "";
	int l_decimal = 0, l_pos = 0;
    int l_price_vnd = 0;
     string l_uprice_format = "";
     for(j = 0; j < dtDetail.Rows.Count; j++)
     {
      	if(dtMst.Rows[0][15].ToString()!="VND")
	{
        l_pos = l_uprice_format.IndexOf(".", 0, l_uprice_format.Length - 1) ;
        
        l_price_vnd = int.Parse(l_uprice_format.Substring(l_pos + 1, l_uprice_format.Length - l_pos - 1));
        if (l_price_vnd == 0)
        {
            l_uprice_format = l_uprice_format.Substring(0, l_pos).Replace(",", ".");
        }
        else
        {
            l_uprice_format = l_uprice_format.Substring(0, l_pos).Replace(",", ".") + "," + l_uprice_format.Substring(l_pos + 1, l_uprice_format.Length - l_pos - 1);
        }            
         ls_uprice = dtMst.Rows[0][15].ToString() + " " + l_uprice_format;	
	}
	else
	{
          l_uprice_format = dtDetail.Rows[j][3].ToString();
          l_pos = l_uprice_format.IndexOf(".", 0, l_uprice_format.Length - 1);
          l_price_vnd = int.Parse(l_uprice_format.Substring(l_pos + 1, l_uprice_format.Length - l_pos - 1));
          if (l_price_vnd == 0)
          {
              l_uprice_format = l_uprice_format.Substring(0, l_pos).Replace(",", ".");
          }
          else
          {
              l_uprice_format = l_uprice_format.Substring(0, l_pos).Replace(",", ".") + "," + l_uprice_format.Substring(l_pos + 1, l_uprice_format.Length - l_pos - 1);
          }
          ls_uprice = l_uprice_format;
	}
	ls_sizea = "Size " + dtDetail.Rows[j][6].ToString() + " - " + dtDetail.Rows[j][7].ToString() + " / " + dtDetail.Rows[j][8].ToString();
	l_net_tramt = dtDetail.Rows[j][4].ToString();
	l_decimal = l_net_tramt.IndexOf(".", 0, l_net_tramt.Length - 1);
	if( l_decimal == -1)
	{
		l_net_tramt = l_net_tramt.Replace(",", ".");	
	}
	else
	{
		l_net_tramt_1 = l_net_tramt.Substring(0, l_decimal ); 
		l_net_tramt_1 = l_net_tramt_1.Replace(",", ".");
		l_net_tramt = l_net_tramt.Substring(l_decimal + 1, l_net_tramt.Length - l_decimal - 1  );
		l_net_tramt = l_net_tramt_1 + "," + l_net_tramt ;
	}
	l_net_tramt_1 = dtDetail.Rows[j][11].ToString();
	l_net_tramt_1 = l_net_tramt_1.Replace(",", ".");
%>

 <tr class=xl51 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl51 style='height:22.5pt'></td>
  <td class=xl46 width=32 style='width:24pt' x:num><%=j + 1%></td>
  <td class=xl47 width=234 style='width:176pt'><%=ls_sizea%></td>
  <td class=xl47></td>
  <td class=xl60>Viên</td>
  <td class=xl48 x:str><span
  style='mso-spacerun:yes'> </span><%=l_net_tramt_1%> </td>
  <td class=xl50 x:str><span style='mso-spacerun:yes'>   </span><%=ls_uprice%><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl50 x:str><span style='mso-spacerun:yes'>   
  </span><%=l_net_tramt%><span style='mso-spacerun:yes'>  </span></td>
 </tr>
 <%
     }
      if(dtDetail.Rows.Count < k) // maximum for total rows of AR Domestics
      {
        for (j = dtDetail.Rows.Count; j < k; j++)
        {		
%>

 <tr class=xl51 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl51 style='height:22.5pt'></td>
  <td class=xl46 width=32 style='width:24pt' x:num></td>
  <td class=xl47 width=234 style='width:176pt'></td>
  <td class=xl47></td>
  <td class=xl60></td>
  <td class=xl48 x:num><span
  style='mso-spacerun:yes'> </span> </td>
  <td class=xl50 x:str><span style='mso-spacerun:yes'>   </span><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl50 x:str><span style='mso-spacerun:yes'>   
  </span><span style='mso-spacerun:yes'>  </span></td>
 </tr>
 <% 
        }
} 
string l_sum_net_tramt = "";
l_sum_net_tramt = dtMst.Rows[0][18].ToString();
	l_decimal = l_sum_net_tramt.IndexOf(".", 0, l_sum_net_tramt.Length - 1);
	if( l_decimal == -1)
	{
		l_sum_net_tramt = l_sum_net_tramt.Replace(",", ".");	
	}
	else
	{
		l_net_tramt_1 = l_sum_net_tramt.Substring(0, l_decimal ); 
		l_net_tramt_1 = l_net_tramt_1.Replace(",", ".");
		l_sum_net_tramt = l_sum_net_tramt.Substring(l_decimal + 1, l_sum_net_tramt.Length - l_decimal - 1  );
		l_sum_net_tramt = l_net_tramt_1 + "," + l_sum_net_tramt ;
	}

%>

 <!---------------------------------->

 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 style='height:22.5pt'></td>
  <td class=xl52></td>
  <td colspan=2 class=xl47 width=286 style='width:215pt'></td>
  <td class=xl53></td>
  <td class=xl49></td>
  <td class=xl64 x:str><span style='mso-spacerun:yes'>  
  </span><%=dtMst.Rows[0][15]%><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl54 x:str><span
  style='mso-spacerun:yes'> </span><%=l_sum_net_tramt%> </td>
 </tr>
 <%
l_sum_net_tramt = dtMst.Rows[0][19].ToString();
	l_decimal = l_sum_net_tramt.IndexOf(".", 0, l_sum_net_tramt.Length - 1);
	if( l_decimal == -1)
	{
		l_sum_net_tramt = l_sum_net_tramt.Replace(",", ".");	
	}
	else
	{
		l_net_tramt_1 = l_sum_net_tramt.Substring(0, l_decimal ); 
		l_net_tramt_1 = l_net_tramt_1.Replace(",", ".");
		l_sum_net_tramt = l_sum_net_tramt.Substring(l_decimal + 1, l_sum_net_tramt.Length - l_decimal - 1  );
		l_sum_net_tramt = l_net_tramt_1 + "," + l_sum_net_tramt ;
	}

 %>
 <tr class=xl57 height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl57 style='height:7.5pt'></td>
  <td class=xl55></td>
  <td colspan=6 class=xl56 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl57 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl57 style='height:18.75pt'></td>
  <td class=xl55></td>
  <td colspan=2 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 width=243 style='width:183pt'></td>
  <td class=xl58 x:str><%=l_sum_net_tramt%> </td>
 </tr>
 <%
l_sum_net_tramt = dtMst.Rows[0][20].ToString();
	l_decimal = l_sum_net_tramt.IndexOf(".", 0, l_sum_net_tramt.Length - 1);
	if( l_decimal == -1)
	{
		l_sum_net_tramt = l_sum_net_tramt.Replace(",", ".");	
	}
	else
	{
		l_net_tramt_1 = l_sum_net_tramt.Substring(0, l_decimal ); 
		l_net_tramt_1 = l_net_tramt_1.Replace(",", ".");
		l_sum_net_tramt = l_sum_net_tramt.Substring(l_decimal + 1, l_sum_net_tramt.Length - l_decimal - 1  );
		l_sum_net_tramt = l_net_tramt_1 + "," + l_sum_net_tramt ;
	}

%>
 <tr class=xl57 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl57 style='height:18.0pt'></td>
  <td class=xl55></td>
  <td class=xl46 width=234 style='width:176pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dtMst.Rows[0][7]%></td>
  <td class=xl55></td>
  <td colspan=3 class=xl69 width=243 style='width:183pt'></td>
  <td class=xl58 x:str><%=l_sum_net_tramt%> </td>
 </tr>
  <%
l_sum_net_tramt = dtMst.Rows[0][21].ToString();
	l_decimal = l_sum_net_tramt.IndexOf(".", 0, l_sum_net_tramt.Length - 1);
	if( l_decimal == -1)
	{
		l_sum_net_tramt = l_sum_net_tramt.Replace(",", ".");	
	}
	else
	{
		l_net_tramt_1 = l_sum_net_tramt.Substring(0, l_decimal ); 
		l_net_tramt_1 = l_net_tramt_1.Replace(",", ".");
		l_sum_net_tramt = l_sum_net_tramt.Substring(l_decimal + 1, l_sum_net_tramt.Length - l_decimal - 1  );
		l_sum_net_tramt = l_net_tramt_1 + "," + l_sum_net_tramt ;
	}

%>

 <tr class=xl57 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl57 style='height:19.5pt'></td>
  <td class=xl55></td>
  <td colspan=2 class=xl56 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl69 width=243 style='width:183pt'></td>
  <td class=xl58 x:str><%=l_sum_net_tramt%> </td>
 </tr>
 <tr class=xl42 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl42 style='height:23.25pt'></td>
  <td class=xl43></td>
  <td class=xl44></td>
  <td colspan=5 rowspan=2 class=xl68 width=432 style='width:325pt'><%=CommondLib.Num2VNText(dtMst.Rows[0][10].ToString(), ls_book_ccy)%> Chẵn./.</td>
 </tr>
 <tr class=xl42 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl42 style='height:15.95pt'></td>
  <td class=xl43></td>
  <td class=xl44></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td colspan=6 class=xl44 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl24 style='height:28.5pt'></td>
  <td colspan=7 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=6 style='width:5pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=234 style='width:176pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=137 style='width:103pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
