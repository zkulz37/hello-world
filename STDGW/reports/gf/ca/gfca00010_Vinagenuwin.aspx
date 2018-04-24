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
    string SQL = "", ls_tac_hgtrh_pk = "", ls_tac_crca_pk = "", lcompany_pk = "";
    int i;
    ls_tac_hgtrh_pk = Request["tac_hgtrh_pk"];
    lcompany_pk = Request["company_pk"];
    ls_tac_crca_pk = Request["tac_crca_pk"];
    string l_invoice_date = "", l_cust_nm = "", l_cust_addr = "", l_tax_code = "", l_tax_rate = "";
    string l_net_amt = "", l_vat_amt = "", l_total_amt = "";
    string l_remark2 = "", l_tr_ccy = "", l_amount_words = "";
    double l_tot_amt_num = 0;
    decimal l_tr_rate = 0;
    SQL
    = "select partner_name, tax_code, nvl(addr1, '') || nvl(addr2, ' ') || nvl(addr3, ' ') address  " +
        "from comm.tco_company  " +
        "where del_if = 0  " +
        "and pk = " + lcompany_pk;
    DataTable dtComp = new DataTable();
    dtComp = ESysLib.TableReadOpen(SQL);
    if (dtComp.Rows.Count == 0)
    {
        Response.Write("There is not enough information to display!!!");
        Response.End();
    }
    SQL
        = "select h.voucherno, t.invoice_no, substr(t.tr_date, 7, 2) || '/' || substr(t.tr_date, 5, 2) || '/' || substr(t.tr_date, 1, 4) trans_date, " +
            "    c.partner_lname partner_name, nvl(c.addr1, '') || nvl(c.addr2, ' ') || nvl(c.addr3, '') address, t.remark2, substr(t.invoice_date, 7, 2) || '/' || substr(t.invoice_date, 5, 2) || '/' || substr(t.invoice_date, 1, 4) invoice_date_date, h.pk seq, " +
            " t.voucher_type, replace(to_char(nvl(tot_net_bk_amt, 0), '999,999,999,999'), ',', '.') tot_net_bk_amt, replace(to_char(nvl(tot_vat_bk_amt, 0), '999,999,999,999'), ',', '.') tot_vat_bk_amt, replace(to_char(nvl(tot_net_bk_amt, 0) + nvl(tot_vat_bk_amt, 0), '999,999,999,999'), ',', '.') tot_bkamt " +
            ", (select d.vat_rate from tac_crcad d where d.tac_crca_pk = t.pk and d.del_if = 0 and d.vat_rate is not null and rownum = 1) vat_rate " +
            ", t.order_ccy, t.order_trrate, t.invoice_date, c.tax_code, nvl(tot_net_bk_amt, 0) + nvl(tot_vat_bk_amt, 0) total_amt " +
            "from acnt.tac_crca t, comm.tco_buspartner c, tac_hgtrh h " +
            "where t.del_if = 0 " +
            "and c.del_if(+) = 0 " +
            " and h.del_if = 0 " +
            "and t.tco_buspartner_pk = c.pk(+) " +
            " and h.tr_tablenm = 'TAC_CRCA' " +
            " and h.tr_status in ('2', '0') " +
            " and h.tr_table_pk = t.pk " +
            "and h.pk = " + ls_tac_hgtrh_pk;

    DataTable dtMaster = new DataTable();
    dtMaster = ESysLib.TableReadOpen(SQL);
    if (dtMaster.Rows.Count == 0)
    {
        Response.Write("!!!");
        Response.End();
    }
    else
    {
        l_invoice_date = dtMaster.Rows[0][15].ToString();
        l_cust_nm = dtMaster.Rows[0][3].ToString();
        l_cust_addr = dtMaster.Rows[0][4].ToString();
        l_tax_code = dtMaster.Rows[0][16].ToString();
        l_tax_rate = dtMaster.Rows[0][12].ToString();
        l_tr_ccy = dtMaster.Rows[0][13].ToString();             
        l_net_amt = dtMaster.Rows[0][9].ToString();             
        l_vat_amt = dtMaster.Rows[0][10].ToString();
        l_total_amt = dtMaster.Rows[0][11].ToString();
        l_tot_amt_num = double.Parse(dtMaster.Rows[0][17].ToString());
        if(dtMaster.Rows[0][13].ToString() != "")
            l_tr_rate = decimal.Parse(dtMaster.Rows[0][14].ToString());                
    }
    SQL = "";
    DataTable dtItem = new DataTable();
    string ls_accdr = "", ls_acccr = "", ls_acvat = "";
    decimal v_tot_item_632 = 0;
    DataTable dtARDRCR_VAT = new DataTable();

    SQL
        = "	 select num_1, num_2, num_4 " +
            "	 from tac_commcode_detail a, tac_commcode_master b  " +
            "	 where a.del_if = 0 and b.del_if = 0  " +
            "	 and a.tac_commcode_master_pk = b.pk  " +
            "	 and b.tco_company_pk = '" + lcompany_pk + "' " +
            "	 and a.code = '60030010' ";
    dtARDRCR_VAT = ESysLib.TableReadOpen(SQL);
    if (dtARDRCR_VAT.Rows.Count > 0)
    {
        ls_accdr = dtARDRCR_VAT.Rows[0][0].ToString();
        ls_acccr = dtARDRCR_VAT.Rows[0][1].ToString();
        ls_acvat = dtARDRCR_VAT.Rows[0][2].ToString();
    }
    //if (dtMaster.Rows[0][0].ToString().Trim().Substring(0, 2) == "AR")
    //{
        SQL
            = "select b.item_code, b.item_name, b.uom, a.qty, a.u_price, decode(c.tr_ccy, 'VND', replace(to_char(a.ext_price, '999,999,999,999,999'), ',', '.'), to_char(a.ext_price, '999,999,999,999.99')) ext_price, decode(c.bk_rate, 1, replace(to_char(a.net_bk_amt, '999,999,999,999,999'), ',', '.'), to_char(a.net_bk_amt, '999,999,999,999.99')) net_bk_amt, a.remark2 " +
                "from acnt.tac_crcad a, comm.tco_item b, acnt.tac_crca c  " +
                "where a.del_if = 0 and c.del_if = 0 " +
                "and a.tco_item_pk = b.pk(+) " +
                "and a.tac_crca_pk = c.pk " +
                "and c.pk = " + ls_tac_crca_pk;
        dtItem = ESysLib.TableReadOpen(SQL);
    //}
    SQL
       = "select trim(code) code, a.code code_nm " +
           "  from tac_commcode_detail a, tac_commcode_master b " +
           " where a.del_if = 0 " +
           "   and b.del_if = 0 " +
           "   and a.tac_commcode_master_pk = b.pk " +
           "   and trim(b.id) = 'ACBG0040' " +
           "   and a.def_yn = 'Y' ";
    DataTable dtBook_CCY = new DataTable();

    string ls_BookCCY = "USD";
    dtBook_CCY = ESysLib.TableReadOpen(SQL);
    ls_BookCCY = dtBook_CCY.Rows[0][0].ToString();

    string l_xls_format = "";
    if (dtMaster.Rows[0][13].ToString() != "VND")
    {
        l_xls_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        l_xls_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    string l_xls_book_ccy = "";
    if (ls_BookCCY != "VND")
        l_xls_book_ccy = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    else
        l_xls_book_ccy = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="IBC_files/filelist.xml">
<link rel=Edit-Time-Data href="IBC_files/editdata.mso">
<link rel=OLE-Object-Data href="IBC_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>genuwin</o:Author>
  <o:LastAuthor>genu</o:LastAuthor>
  <o:LastPrinted>2009-07-15T03:50:41Z</o:LastPrinted>
  <o:Created>2009-06-27T08:48:37Z</o:Created>
  <o:LastSaved>2011-02-22T07:58:34Z</o:LastSaved>
  <o:Company>company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .1in .25in .5in;
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
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}	
.xl45
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
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
     <x:TopRowVisible>6</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8415</x:WindowHeight>
  <x:WindowWidth>14610</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=702 style='border-collapse:
 collapse;table-layout:fixed;width:527pt'>
 <col class=xl24 width=7 style='mso-width-source:userset;mso-width-alt:256;
 width:5pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=234 style='mso-width-source:userset;mso-width-alt:8557;
 width:176pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=131 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl24 width=7 style='height:14.1pt;width:5pt'></td>
  <td class=xl24 width=32 style='width:24pt'></td>
  <td class=xl24 width=234 style='width:176pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=33 style='width:25pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=131 style='width:98pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl27 width=61 style='vertical-align:top; width:46pt'><%= l_invoice_date.Substring(6, 2)%></td>
  <td class=xl27 width=54 style='vertical-align:top; width:41pt'><%= l_invoice_date.Substring(4, 2)%></td>
  <td class=xl28 width=75 style='vertical-align:top; width:56pt'><%= l_invoice_date.Substring(0, 4)%></td>
  <td class=xl29></td>
  <td colspan=2 class=xl55 width=206 style='width:154pt'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td colspan=5 class=xl27 width=456 style='width:343pt'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl52 width=206 style='width:154pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl30></td>
  <td class=xl24></td>
  <td class=xl33></td>
  <td class=xl30></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl30></td>
  <td class=xl24></td>
  <td class=xl35></td>
  <td class=xl30></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl30></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=2 class=xl24 style='height:17.1pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl36 width=663 style='width:498pt'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl37></td>
  <td class=xl24></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl24 style='height:15.95pt'></td>
  <td class=xl30></td>
  <td class=xl24></td>
  <td class=xl33 colspan=2 style='mso-ignore:colspan'><%=l_cust_nm%></td>
  <td class=xl33></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl30></td>
  <td class=xl24></td>
  <td class=xl34 colspan=6 style='mso-ignore:colspan'><%=l_cust_addr%></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl30></td>
  <td class=xl24></td>
  <td colspan=2 class=xl35 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td class=xl30></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33>C/K</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl33><%=l_tax_code%></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.95pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=25 style='mso-height-source:userset;height:18.95pt'>
  <td height=25 class=xl38 style='height:18.95pt'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl31 width=295 style='width:222pt'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 width=108 style='width:81pt'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl39 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl39 style='height:24.95pt'></td>
  <td class=xl40></td>
  <td colspan=2 class=xl40 width=295 style='width:222pt'></td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl40 width=108 style='width:81pt'></td>
  <td class=xl31></td>
 </tr>
 <% 
     for (i = 0; i < dtItem.Rows.Count; i++)
     {
         l_remark2 = dtItem.Rows[i][7].ToString();
 %>
 <tr class=xl38 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl38 style='height:22.5pt'></td>
  <td class=xl27 width=32 style='vertical-align:bottom; width:24pt' x:num><%=i+1 %></td>
  <td colspan=2 rowspan='2' class=xl53 width=295 style='vertical-align:center; width:222pt'><%=l_remark2 %></td>
  <td class=xl41 style='vertical-align:bottom;' ><%=dtItem.Rows[i][2].ToString() %></td>
  <td class=xl42 style='vertical-align:bottom;' x:num><%=dtItem.Rows[i][3].ToString() %></td>
  <td class=xl43 style='vertical-align:bottom;' x:str><span style='mso-spacerun:yes'> </span>VND<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 style='vertical-align:bottom;' ><%=dtItem.Rows[i][5] %></td>
  <td class=xl44 style='vertical-align:bottom;' ><%=dtItem.Rows[i][6] %></td>
 </tr>
 <tr>
     <td height=30 class=xl38 style='height:22.5pt'></td>
     <td class=xl27 width=32 style='vertical-align:bottom; width:24pt' x:num></td>
     <td class=xl41 style='vertical-align:bottom;' ></td>
     <td class=xl42 style='vertical-align:bottom;' x:num></td>
     <td class=xl43 style='vertical-align:bottom;' x:str><span style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 style='vertical-align:bottom;' ></td>
  <td class=xl44 style='vertical-align:bottom;' ></td>  
 </tr>
 <%
     }
     if(dtItem.Rows.Count < 5)
     {
        for(i = dtItem.Rows.Count; i < 5; i++)
        {
 %>
 <tr class=xl38 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl38 style='height:22.5pt'></td>
  <td class=xl27 width=32 style='width:24pt' x:num></td>
  <td colspan=2 rowspan=2 class=xl53 width=295 style='width:222pt'></td>
  <td class=xl41></td>
  <td class=xl42></td>
  <td class=xl43 x:str><span style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44></td>
  <td class=xl44></td>
 </tr>
 <tr>
     <td height=30 class=xl38 style='height:22.5pt'></td>
     <td class=xl27 width=32 style='vertical-align:bottom; width:24pt' x:num></td>
     <td class=xl41 style='vertical-align:bottom;' ></td>
     <td class=xl42 style='vertical-align:bottom;' x:num></td>
     <td class=xl43 style='vertical-align:bottom;' x:str><span style='mso-spacerun:yes'> </span><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl44 style='vertical-align:bottom;' ></td>
  <td class=xl44 style='vertical-align:bottom;' ></td>  
 </tr>

<% 
        }    
     }
%> 
 <tr class=xl38 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl38 style='height:22.5pt'></td>
  <td class=xl27></td>
  <td class=xl41></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl38 style='height:22.5pt'></td>
  <td class=xl27></td>
  <%if (l_tr_rate != 0)
    { %>
  <td class=xl41>Tỷ giá : <%=l_tr_rate%> VND/USD</td>
  <% } 
    else
    { %>
    <td class=xl41></td>
  <%} %>  
  <td class=xl42></td>
  <td class=xl43></td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <!---
 <tr class=xl38 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl38 style='height:22.5pt'></td>
  <td class=xl27></td>
  <td class=xl41></td>
  <td class=xl42></td>
  <td class=xl43></td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl38 style='height:22.5pt'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl52 width=295 style='width:222pt'></td>
  <td class=xl46></td>
  <td class=xl45></td>
  <td class=xl43></td>
  <td class=xl47></td>
  <td class=xl45></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl24 style='height:22.5pt'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl54 width=295 style='width:222pt'></td>
  <td class=xl46></td>
  <td class=xl45></td>
  <td class=xl43></td>
  <td class=xl47></td>
  <td class=xl45></td>
 </tr>
 --->
 <tr class=xl48 height=9 style='mso-height-source:userset;height:6.95pt'>
  <td height=9 colspan=2 class=xl48 style='height:6.95pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl48 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl48 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl52 width=237 style='width:178pt'></td>
  <td class=xl44 style='vertical-align:top;' ><%=l_net_amt %></td>
 </tr>
 <tr class=xl48 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=2 class=xl48 style='height:20.25pt;mso-ignore:colspan'></td>
  <% if(l_tax_rate == "" || l_tax_rate == "NO" || l_tax_rate == "01" || l_tax_rate == "0" || l_tax_rate == "00" ) { %>
  <td class=xl49 width=234 style='width:176pt' x:str>-<span
  style='mso-spacerun:yes'>                  </span></td>  
  <% } else { %>
  <td class=xl49 width=234 style='width:176pt' x:str><%=l_tax_rate%><span
  style='mso-spacerun:yes'>                  </span></td>
  <% } %>
  <td class=xl48></td>
  <td colspan=4 class=xl52 width=237 style='width:178pt'></td>
  <% if (double.Parse(l_vat_amt.Replace(".", "")) == 0)
     { %>
  <td class=xl44 style='vertical-align:top;' >-</td>
  <% }
     else
     { %>  
    <td class=xl44 style='vertical-align:top;' ><%=l_vat_amt%></td>
    <%} %>    
 </tr>
 <tr class=xl48 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 class=xl48 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl52 width=237 style='width:178pt'></td>
  <td class=xl44 style='vertical-align:top;' ><%=l_total_amt %></td>
 </tr>
 <% 
     
 %>
 <tr class=xl48 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=2 class=xl48 style='height:15.95pt;mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=6 rowspan=2 class=xl53 width=429 style='width:322pt'><%=CommondLib.Num2VNText(l_tot_amt_num.ToString(), "VND")%></td>
 </tr>
 <tr class=xl48 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 colspan=2 class=xl48 style='height:15.95pt;mso-ignore:colspan'></td>
  <td class=xl36></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl50 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td colspan=5 class=xl36 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td colspan=2 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl24 style='height:28.5pt'></td>
  <td colspan=5 class=xl51 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td colspan=2 class=xl51 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=7 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=7 style='width:5pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=234 style='width:176pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=131 style='width:98pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
