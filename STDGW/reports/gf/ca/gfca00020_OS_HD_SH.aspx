<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<%
	string SQL = "", ls_tac_hgtrh_pk = "", ls_tac_crca_pk = "", lcompany_pk = "";	
    	ls_tac_hgtrh_pk = Request["tac_hgtrh_pk"];
    	lcompany_pk = Request["company_pk"];
    	ls_tac_crca_pk = Request["tac_crca_pk"];
	
	SQL = "select a.code_nm from tac_commcode_detail a, tac_commcode_master b where a.del_if = 0 and b.del_if = 0 and a.tac_commcode_master_pk = b.pk and b.id = 'EACBK016' and a.code = 'AROS' ";
	DataTable dtLength = new DataTable();
	dtLength = ESysLib.TableReadOpen(SQL);
	SQL
	= "select substr(a.invoice_date, 1, 4) yyyy, substr(a.invoice_date, 5, 2) mm, substr(a.invoice_date, 7, 2) dd,  " + 
        "				 c.partner_name, nvl(c.addr1, '') || nvl(c.addr2, ' ') || nvl(c.addr3, ' ') address, " +
        "				 NVL((        select c.item_lnm " +
        "          from tac_crcaditem b, tac_abitem c " +
        "         where b.del_if       = 0 " +
        "           and c.del_if       = 0 " +
        "           and b.tac_crca_pk  = '" + ls_tac_crca_pk + "' " +
        "           and b.tac_abitem_pk = c.pk " +
        "	    and c.item_nm = 'PAYMENT METHOD' ), 'CK') pay_method, " +
        "	    c.tax_code, decode(a.vat_rate, '01', '0', '00', '0', a.vat_rate) vat_rate,  " +
        "	    decode(a.tr_ccy, 'VND', to_char(a.tot_net_bk_amt, '999,999,999,999,999'), to_char(a.tot_net_bk_amt, '999,999,999,999,999.99')) tot_net_bk_amt,  " +
        "	decode(a.tr_ccy, 'VND', to_char(a.tot_vat_bk_amt, '999,999,999,999,999'), to_char(a.tot_vat_bk_amt, '999,999,999,999,999.99') ) tot_vat_bk_amt, " + 
        "	decode(a.tr_ccy, 'VND', to_char(nvl(a.tot_net_bk_amt, 0) + nvl(a.tot_vat_bk_amt, 0), '999,999,999,999,999'), to_char(nvl(a.tot_net_bk_amt, 0) + nvl(a.tot_vat_bk_amt, 0), '999,999,999,999,999.99')) tot_inc_vattax, a.invoice_no, " +
        "		(        select c.item_lnm " +
        "          from tac_crcaditem b, tac_abitem c " +
        "         where b.del_if       = 0 " +
        "           and c.del_if       = 0 " +
        "           and b.tac_crca_pk  = '" + ls_tac_crca_pk + "' " +
        "           and b.tac_abitem_pk = c.pk " +
        "	    and c.item_nm = 'DECLARATION NO' ) contract_no, length(c.tax_code) length_taxcd, to_char(to_date(a.tr_date, 'YYYYMMDD'), 'DD/MM/YYYY') trans_dt, a.tr_ccy, to_char(a.tr_rate,'999,999,999,999') tr_rate, " + 
        " decode(a.tr_ccy, 'VND', to_char(a.tot_net_tr_amt,'999,999,999,999,999,999,999,999'), to_char(a.tot_net_tr_amt,'999,999,999,999,999,999,999,999.99')) tot_net_tr_amt, a.serial_no, a.invoice_date, a.tr_date " +
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
    string ls_account_no = "";
    if(dtMst.Rows[0][18].ToString() != "")
    {
        ls_account_no = dtMst.Rows[0][18].ToString() + " " ;
    }
    if(dtMst.Rows[0][11].ToString() != "")
    {
        ls_account_no += dtMst.Rows[0][11].ToString() + "/XK/KD ";
    }
    if (dtMst.Rows[0][19].ToString() != "")
    {
        ls_account_no += "ngày " + dtMst.Rows[0][20].ToString().Substring(6, 2) + "/" + dtMst.Rows[0][20].ToString().Substring(4, 2) + "/" + dtMst.Rows[0][20].ToString().Substring(0, 4);
    }        
	if(dtMst.Rows[0][3].ToString() != "")
	{
	    ls_partner = "Bán cho " + dtMst.Rows[0][3].ToString() ;	
	}
	else
	{
	    ls_partner = "Bán cho " ;	
	}
 SQL
	= "						select tbl_sum.item_name, tbl_sum.uom, round(tbl_sum.qty, 3) qty,  " + 
        "									 decode(tbl_sum.tr_ccy, 'VND', to_char(round(tbl_sum.u_price, 5), '999,999,999,999'), to_char(round(tbl_sum.u_price, 5), '999,999,999,999.99999') ) uprice, " +
        "									 decode(tbl_sum.tr_ccy, 'VND', to_char(round(tbl_sum.net_tr_amt, 2), '999,999,999,999,999,999'), to_char(round(tbl_sum.net_tr_amt, 2), '999,999,999,999,999,999.99') ) net_tr_amt, " +
        "									 tbl_sum.item_desc, tbl_sum.sizea, tbl_sum.cap_color, tbl_sum.body_color, tbl_sum.tr_ccy, round(tbl_sum.net_tr_amt, 2) net_tr_amt_1  " +
        "						from ( " +
        "	                         select tbl.item_name, tbl.uom, tbl.qty qty, tbl.u_price,      " +
        "                           tbl.net_tr_amt net_tr_amt,  " +
        "                            tbl.item_desc, sf_get_sizea_sign(tbl.sizea) sizea, tbl.cap_color,      " +
        "                            tbl.body_color, tbl.tr_ccy   " +
        "          from (      " +
                        " select i.item_name, '1000Viên' uom, d.qty, d.u_price, d.net_tr_amt, d.item_desc, i.size_code sizea, " +
                           " s1.color_code cap_color, s.color_code body_color, a.tr_ccy, d.order_no " +
                            " from tac_crcad d, comm.tco_item i, prod.tsh_color s, tac_crca a, prod.tsh_color s1 " +
                            " where d.del_if = 0 " +
                            " and a.del_if = 0 " +
                            " and i.del_if = 0 " +
                            " and d.tco_item_pk = i.pk " +
                            " and s.pk = i.body_color_pk " +
                            " and s1.pk = i.cap_color_pk " +
                            " and d.tac_crca_pk    = a.pk " +
                            " and d.tac_crca_pk =  '" + ls_tac_crca_pk + "' " +
        "      ) tbl                                              " +
        "                                                            ) tbl_sum  " +
        "                                                             " ;
 
        DataTable dtDetail = new DataTable();
        dtDetail = ESysLib.TableReadOpen(SQL);
       
		string l_gelatin = "Vỏ viên nang Gelatin";
	string ls_uprice = "", ls_sizea = "";
	string ls_tr_amt = "" ;
	string ls_ccy = dtMst.Rows[0][15].ToString();
	if(dtLength.Rows.Count > 0)
	    k = int.Parse(dtLength.Rows[0][0].ToString());
    SQL = "select a.code from tac_commcode_detail a, tac_commcode_master b where a.del_if = 0 and b.del_if = 0 and a.tac_commcode_master_pk = b.pk and b.id = 'ACBG0040' and a.def_yn = 'Y'";
    DataTable dtBook_Ccy = new DataTable();
    dtBook_Ccy = ESysLib.TableReadOpen(SQL);
    string ls_book_ccy = dtBook_Ccy.Rows[0][0].ToString();
    decimal l_sum_net_tramt = 0;
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
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Moi%20nhatHD_tren%20may%20Loan_files/filelist.xml">
<link rel=Edit-Time-Data
href="Moi%20nhatHD_tren%20may%20Loan_files/editdata.mso">
<link rel=OLE-Object-Data
href="Moi%20nhatHD_tren%20may%20Loan_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>genuwin</o:Author>
  <o:LastAuthor>admin</o:LastAuthor>
  <o:LastPrinted>2009-10-17T07:22:03Z</o:LastPrinted>
  <o:Created>2009-06-27T08:48:37Z</o:Created>
  <o:LastSaved>2009-10-17T07:41:49Z</o:LastSaved>
  <o:Company>company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .1in .25in .6in;
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
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;}
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
	vertical-align:middle;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
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
.xl51
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
.xl52
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
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	vertical-align:middle;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:8.5pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	}
	
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
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>6</x:ActiveCol>
       <x:RangeSelection>$G:$G</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1575</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=654 style='border-collapse:
 collapse;table-layout:fixed;width:492pt'>
 <col class=xl24 width=6 style='mso-width-source:userset;mso-width-alt:219;
 width:5pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=234 style='mso-width-source:userset;mso-width-alt:8557;
 width:176pt'>
 <col class=xl24 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=117 style='mso-width-source:userset;mso-width-alt:4278;
 width:88pt'>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl24 width=6 style='height:14.1pt;width:5pt'></td>
  <td class=xl24 width=32 style='width:24pt'></td>
  <td class=xl24 width=234 style='width:176pt'></td>
  <td class=xl24 width=40 style='width:30pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=82 style='width:62pt'></td>
  <td class=xl24 width=96 style='width:72pt'></td>
  <td class=xl24 width=117 style='width:88pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl43 width=40 style='width:30pt'><%=dtMst.Rows[0][2]%></td>
  <td class=xl27 width=47 style='width:35pt'><%=dtMst.Rows[0][1]%></td>
  <td class=xl28 width=82 style='width:62pt' x:str><%=dtMst.Rows[0][0]%></td>
  <td colspan=2 class=xl62 width=213 style='width:160pt'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td colspan=5 class=xl27 width=435 style='width:327pt'></td>
  <td colspan=2 class=xl63 width=213 style='width:160pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl29></td>
  <td class=xl24></td>
  <td class=xl32></td>
  <td class=xl29></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl29></td>
  <td class=xl24></td>
  <td class=xl33></td>
  <td class=xl29></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl29></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=2 class=xl24 style='height:14.1pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 width=616 style='width:463pt'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl35></td>
  <td class=xl24></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 style='height:15.95pt'></td>
  <td class=xl36></td>
  <td></td>
  <td class=xl37 colspan=4 style='mso-ignore:colspan'><%=dtMst.Rows[0][3]%></td>
  <td class=xl37></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 style='height:18.0pt'></td>
  <td class=xl36></td>
  <td></td>
  <td class=xl38 colspan=5 style='mso-ignore:colspan'><%=dtMst.Rows[0][4]%></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 style='height:15.95pt'></td>
  <td class=xl36></td>
  <td></td>
  <td colspan=2 class=xl39 style='mso-ignore:colspan'><%=ls_account_no %></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 style='height:18.0pt'></td>
  <td class=xl36></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl37><%=dtMst.Rows[0][5]%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl37><%=dtMst.Rows[0][6]%></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl40 height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl40 style='height:18.95pt'></td>
  <td class=xl30></td>
  <td colspan=2 class=xl30 width=274 style='width:206pt'></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl41 height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl41 style='height:14.1pt'></td>
  <td class=xl42></td>
  <td colspan=2 class=xl42 width=274 style='width:206pt'></td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl40 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl40 style='height:22.5pt'></td>
  <td class=xl46></td>
  <td class=xl47 width=234 style='width:176pt'><%=l_gelatin%></td>
  <td class=xl48></td>
  <td class=xl49></td>
  <td class=xl50 x:str=" "><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl51 x:str=" "><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl51 x:str=" "><span style='mso-spacerun:yes'>   </span></td>
 </tr>
<%
    decimal l_out_qty = 0, l_price = 0;
     for(j = 0; j < dtDetail.Rows.Count; j++)
     {
	ls_sizea = "Size " + dtDetail.Rows[j][6].ToString() ;
    l_out_qty = decimal.Round(decimal.Parse(dtDetail.Rows[j][2].ToString()) / 1000, 3);
    l_price = decimal.Round(decimal.Parse(dtDetail.Rows[j][3].ToString()) * 1000, 5);          
      	if(dtMst.Rows[0][15].ToString()!="VND")
	{
	     ls_uprice = dtMst.Rows[0][15].ToString() + " " + l_price.ToString();	
	}
	else
	{
	      ls_uprice = l_price.ToString();
	}
%>
 <tr class=xl40 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl40 style='height:22.5pt'></td>
  <td class=xl46 width=32 style='width:24pt' x:num><%=j + 1%></td>
  <td class=xl47 width=234 style='width:176pt'><%=ls_sizea%></td>
  <td class=xl48></td>
  <td class=xl64>1000Viên</td>
  <td class=xl50 x:num><span
  style='mso-spacerun:yes'> </span><%=l_out_qty%> </td>
  <td class=xl51 x:str><span style='mso-spacerun:yes'>  </span><%=ls_uprice%><span style='mso-spacerun:yes'> </span></td>
  <td class=xl52 x:str><span style='mso-spacerun:yes'>  
  </span><%=dtDetail.Rows[j][4]%><span style='mso-spacerun:yes'> </span></td>
 </tr>
<%
     }
      if(dtDetail.Rows.Count < k) // maximum for total rows of AR Domestics
      {
        for (j = dtDetail.Rows.Count; j < k; j++)
        {		
%>
 <tr class=xl40 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl40 style='height:22.5pt'></td>
  <td class=xl46></td>
  <td colspan=2 class=xl48 style='mso-ignore:colspan'></td>
  <td class=xl49></td>
  <td class=xl50></td>
  <td class=xl51></td>
  <td class=xl52></td>
 </tr>
<% 
        }
} 
%>
<!---------------------------------->
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl24 style='height:22.5pt'></td>
  <td class=xl53 width=32 style='width:24pt'></td>
<%
      if(dtMst.Rows[0][15].ToString() != "VND")	 
      {
%>
  <td colspan=2 class=xl47 width=274 style='width:206pt'>Tỷ giá: <%=dtMst.Rows[0][16]%></td>
<%
      }	 
      else
      {
%>
  <td colspan=2 class=xl47 width=274 style='width:206pt'></td>
<%
       }	
%>
  <td class=xl54></td>
  <td class=xl51></td>
  <td class=xl56 x:str><span style='mso-spacerun:yes'>  </span><%=dtMst.Rows[0][15]%><span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl52 style="mso-number-format:'<%=l_xls_format%>';" x:num><span style='mso-spacerun:yes'>  
  </span><%=dtMst.Rows[0][17]%><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl44 height=9 style='mso-height-source:userset;height:6.95pt'>
  <td height=9 class=xl44 style='height:6.95pt'></td>
  <td class=xl57></td>
  <td colspan=6 class=xl58 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl44 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl44 style='height:18.75pt'></td>
  <td class=xl57></td>
  <td colspan=2 class=xl58 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl61 width=225 style='width:169pt'></td>
  <td class=xl59 style="mso-number-format:'<%=l_xls_book_ccy%>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dtMst.Rows[0][8]%> </td>
 </tr>
 <tr class=xl44 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl44 style='height:20.25pt'></td>
  <td class=xl57></td>
  <%
    if(dtMst.Rows[0][7].ToString()!="01")
    {
   %>
  <td class=xl60 width=234 style='width:176pt'><span
  style='mso-spacerun:yes'>                   </span><%=dtMst.Rows[0][7]%></td>
  <%
    }
    else
    {        
   %>
  <td class=xl60 width=234 style='width:176pt'>.<span
  style='mso-spacerun:yes'>                   </span><%=dtMst.Rows[0][7]%></td>
<% 
    }
%>   
  <td class=xl57></td>
  <td colspan=3 class=xl61 width=225 style='width:169pt'></td>
  <td class=xl59 style="mso-number-format:'<%=l_xls_book_ccy%>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dtMst.Rows[0][9]%> </td>
 </tr>
 <tr class=xl44 height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl44 style='height:18.95pt'></td>
  <td class=xl57></td>
  <td colspan=2 class=xl58 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl61 width=225 style='width:169pt'></td>
  <td class=xl59 style="mso-number-format:'<%=l_xls_book_ccy%>';" x:num><span
  style='mso-spacerun:yes'> </span><%=dtMst.Rows[0][10]%> </td>
 </tr>
 <tr class=xl44 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl44 style='height:15.95pt'></td>
  <td class=xl57></td>
  <td class=xl58></td>
  <td colspan=5 rowspan=2 class=xl48 width=382 style='width:287pt'><%=CommondLib.Num2VNText(dtMst.Rows[0][10].ToString(), ls_book_ccy)%> Chẵn./.</td>
 </tr>
 <tr class=xl44 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl44 style='height:15.95pt'></td>
  <td class=xl57></td>
  <td class=xl58></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl57></td>
  <td colspan=6 class=xl58 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=7 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=7 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl24 style='height:28.5pt'></td>
  <td colspan=7 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=6 style='width:5pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=234 style='width:176pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=117 style='width:88pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
