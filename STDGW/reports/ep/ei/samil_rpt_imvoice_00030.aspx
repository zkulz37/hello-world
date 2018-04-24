<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel";  %>
<% ESysLib.SetUser("imex");%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<% 
    string l_invoice_pk, SQL, l_company_pk, l_curr_nm="";
    string l_com_name = "", l_com_add = "";
    string l_vendor_name = "", l_vendor_add = "", l_ship_name = "", l_ship_add = "", l_notify_name = "";
    string l_notify_add = "", l_notify_tel = "", l_destination = "", l_loading_port = "", l_carrier_cd = "";
    string l_carrier_nm = "", l_ship_date="", l_invoice_no="", l_invoice_dt="", l_lc_no="", l_lc_dt="" ;
    string l_pay_term_nm = "", l_remark="", l_tot_amt="", l_curr="", l_desc_of_goods="", l_man_marks="";
    string l_trade_term = "", l_lc_mark = "", l_packing_mark = "", l_marks = "", l_pay_term="";
    string l_bank_name="", l_bank_add="";
    
    l_invoice_pk = Request.QueryString["pk"];
    
    l_company_pk = Request.QueryString["com_pk"];

    SQL = " select  a.partner_name, a.addr1  " +
        " from    tco_company a   " +
        " where pk='" + l_company_pk + "' ";
    System.Data.DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    { 
        l_com_name = (string)dt.Rows[0][0].ToString();
        l_com_add = (string)dt.Rows[0][1].ToString();        
    }
    
    SQL = " select co_invoice_no , to_char(to_date(co_invoice_date ,'yyyymmdd'),'MON. dd,yyyy') as inv_date      " + 
        "        , vendor.partner_name, vendor.addr1, vendor.fax_no, vendor.phone_no, vendor.email_address      " +
        "        , nvl(ship.partner_name,comp.partner_name), nvl(ship.addr1,comp.addr1)    " +
        "        , nvl(ship.fax_no,comp.fax_no), nvl(ship.phone_no  ,comp.phone_no), v.pay_ccy  " +
        "        , v.lc_no, to_char(to_date(v.lc_dt,'yyyymmdd'),'MON. dd,yyyy') lc_dt  " +
        "        , v.carrier_code, v.carrier_name, to_char(to_date(v.ship_date,'yyyymmdd'),'MON. dd,yyyy') ship_date  " +
        "        , v1.partner_name notify_name, v1.addr1 notify_add, v1.phone_no   " +
        "        , v2.port_nm plc_discharge, v3.port_nm plc_loading   " +
        "        , decode(v.pay_ccy, 'VND',to_char(v.tot_amt,'9,999,999'),to_char(v.tot_amt,'9,999,990.99')) tot_amt  " +
        "        , s.code_nm pay_term, REPLACE(v.description, CHR (10), '<br>') description, REPLACE(v.desc_of_goods, CHR (10), '<br>') desc_of_goods " +
        "        , REPLACE(v.man_marks, CHR (10), '<br>') man_marks, REPLACE(v.trade_terms, CHR (10), '<br>') trade_terms " +
        "        , REPLACE(v.lc_marks, CHR (10), '<br>') lc_marks, REPLACE(v.packing_marks, CHR (10), '<br>') packing_marks " +
        "        , REPLACE(v.marks, CHR (10), '<br>') marks, v.pay_term , bank.partner_name bank_name, bank.addr1 bank_add " +
        " from imex.tex_cinv_mst_a v, comm.tco_buspartner ship  " +
        "    , comm.tco_buspartner vendor ,tco_company comp    " +
        "    , comm.tco_buspartner v1 , comm.tco_buspartner bank  " +
        "    , tie_port v2, tie_port v3, tex_contr_mst v4  " +
        "    ,(  " +
        "        select   a.code, a.code_nm  " +
        "               from tco_abcode a, tco_abcodegrp b  " +
        "               where tco_abcodegrp_pk = b.pk  " +
        "                     and b.id = 'ACCR0020'  " +
        "                     and a.del_if = 0  " +
        "                     and b.del_if = 0  " +
        "    )s  " +
        " where v.del_if=0       " +
        "    and v.tco_buspartner_pk1 = ship.pk (+)     " +
        "    and v.tco_buspartner_pk = vendor.pk(+)     " +
        "    and v.tco_buspartner_pk1=comp.pk(+)    " +
        "    and v.notify_pk = v1.pk (+)   " +
        "    and v.CONTRACT_PK = v4.pk(+) " +
        "    and v4.TCO_BUSPARTNER_PK4 = bank.pk(+)  " +
        "    and v.plc_discharge = v2.port_cd(+)  " +
        "    and v.plc_loading = v3.port_cd(+)  " +
        "    and upper(v.pay_term) = upper(s.code(+))  " +
        "    and comp.del_if(+)=0    " +
        "    and v.pk='" + l_invoice_pk  + "'" ;
    
    dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        l_vendor_name = (string)dt.Rows[0][2].ToString();
        l_vendor_add = (string)dt.Rows[0][3].ToString();
        l_ship_name = (string)dt.Rows[0][7].ToString();
        l_ship_add = (string)dt.Rows[0][8].ToString();
        l_notify_name = (string)dt.Rows[0][17].ToString();
        l_notify_add = (string)dt.Rows[0][18].ToString();
        l_notify_tel = (string)dt.Rows[0][19].ToString();
        l_destination = (string)dt.Rows[0][20].ToString();
        l_loading_port = (string)dt.Rows[0][21].ToString();
        l_carrier_cd = (string)dt.Rows[0][14].ToString();
        l_carrier_nm = (string)dt.Rows[0][15].ToString();
        l_ship_date = (string)dt.Rows[0][16].ToString();
        l_invoice_no = (string)dt.Rows[0][0].ToString();
        l_invoice_dt = (string)dt.Rows[0][1].ToString();
        l_lc_no = (string)dt.Rows[0][12].ToString();
        l_lc_dt = (string)dt.Rows[0][13].ToString();
        l_pay_term_nm  = (string)dt.Rows[0][23].ToString();
        l_remark = (string)dt.Rows[0][24].ToString();
        l_tot_amt = (string)dt.Rows[0][22].ToString();
        l_curr = (string)dt.Rows[0][11].ToString();
        l_desc_of_goods = (string)dt.Rows[0][25].ToString();
        l_man_marks = (string)dt.Rows[0][26].ToString(); 
        l_trade_term =  (string)dt.Rows[0][27].ToString();  
        l_lc_mark =  (string)dt.Rows[0][28].ToString();
        l_packing_mark = (string)dt.Rows[0][29].ToString();
        l_marks = (string)dt.Rows[0][30].ToString();
        l_pay_term  = (string)dt.Rows[0][31].ToString();
        l_bank_name = (string)dt.Rows[0][32].ToString();
        l_bank_add = (string)dt.Rows[0][33].ToString(); 
    }

    SQL = " select item_code, item_name,  v.unit_cd " + 
        "        , decode(' + l_curr + ','VND',to_char(v.u_price,'9,999,999'),to_char(v.u_price,'9,999,999.99')) u_price " +
        "        , to_char(v.qty,'999,999,990.99')   " +
        "        , decode(' + l_curr + ','VND',to_char(nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1),'9,999,999'),to_char(nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1),'9,999,990.99')) amount  " +
        "        , v.pk , v.qty, to_char(decode(nvl(v3.CNV_RATIO,1),1,'',nvl(v3.CNV_RATIO,1)),'9,999') || ' ' || v3.UOM_NM uom  " +
        "        , GRP_NM, nvl(v.u_price,0)* nvl(v.qty,0)/nvl(v3.cnv_ratio,1) amt  " +
        " from imex.tex_cinv_dtl v, comm.tco_item v2, comm.tco_uom v3, comm.TCO_ITEMGRP v4 " +
        " where v.del_if=0    " +
        "            and v.tco_item_pk=v2.pk   " +
        "            and v.unit_cd = v3.uom_code(+)  " +
        "            and v2.TCO_ITEMGRP_PK = v4.pk " +
        "            and v.tex_cinv_mst_a_pk = '" + l_invoice_pk + "' " +
        " order by v.pk ";

    System.Data.DataTable dtDetail = ESysLib.TableReadOpen(SQL);

    SQL = "SELECT a.code, upper(a.code_nm) " +
        "   FROM tco_abcode a, tco_abcodegrp b  " +
        "  WHERE tco_abcodegrp_pk = b.pk  " +
        "    AND b.ID = 'ACAB0110'  " +
        "    AND a.del_if = 0  " +
        "    AND b.del_if = 0 " +
        "    and a.code ='" + l_curr + "' ";
    dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
        l_curr_nm = (string)dt.Rows[0][1].ToString();    
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="samil_rpt_imvoice_000101_files/filelist.xml">
<link rel=Edit-Time-Data href="samil_rpt_imvoice_000101_files/editdata.mso">
<link rel=OLE-Object-Data href="samil_rpt_imvoice_000101_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2008-11-01T08:12:28Z</o:LastPrinted>
  <o:Created>2008-10-31T06:46:59Z</o:Created>
  <o:LastSaved>2008-11-01T08:12:29Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .25in 0in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-horizontal-page-align:center;
	mso-vertical-page-align:center;}
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
.style21
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\BC14\D0D5\CCB4, serif;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:\D45C\C900_INVOICE;}
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
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Medium Date";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl49
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl52
	{mso-style-parent:style16;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;}
.xl53
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl56
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:justify;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.00_ ";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;}
.xl60
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:justify;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl62
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:justify;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;}
.xl64
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:justify;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl71
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl76
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl78
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl81
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	color:black;
	font-size:22.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl87
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl88
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl94
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid black;}
.xl95
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:none;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid black;
	border-left:none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid black;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid black;}
.xl104
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl106
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl107
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl108
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl109
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl110
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl111
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl115
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl116
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl117
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl118
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid black;
	border-left:none;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl123
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl124
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl125
	{mso-style-parent:style21;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid black;
	border-left:none;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl127
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl128
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl129
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl130
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl131
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl132
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl133
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl134
	{mso-style-parent:style16;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl135
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl136
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl137
	{mso-style-parent:style0;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl138
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl139
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl140
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl141
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl142
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl143
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl144
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl145
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl146
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl147
	{mso-style-parent:style0;
	color:blue;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:justify;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl148
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl149
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl150
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl151
	{mso-style-parent:style16;
	color:black;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.0_-\;\\-* \#\,\#\#0\.0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl152
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl153
	{mso-style-parent:style16;
	color:red;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:1.0pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl154
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>92</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>15</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>36</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=763 style='border-collapse:
 collapse;table-layout:fixed;width:572pt'>
 <col class=xl25 width=120 style='mso-width-source:userset;mso-width-alt:4388;
 width:90pt'>
 <col class=xl25 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl25 width=203 style='mso-width-source:userset;mso-width-alt:7424;
 width:152pt'>
 <col class=xl25 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl26 width=48 style='mso-width-source:userset;mso-width-alt:1755;
 width:36pt'>
 <col class=xl27 width=64 style='width:48pt'>
 <col class=xl25 width=124 style='mso-width-source:userset;mso-width-alt:4534;
 width:93pt'>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td colspan=7 height=49 class=xl86 width=763 style='height:36.75pt;
  width:572pt'>COMMERCIAL INVOICE</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl28 style='height:16.5pt;border-top:none'>Shipper/Export</td>
  <td class=xl29 width=97 style='border-top:none;width:73pt'>&nbsp;</td>
  <td class=xl30 width=203 style='border-top:none;width:152pt'>&nbsp;</td>
  <td colspan=4 class=xl88 width=343 style='border-right:1.0pt solid black;
  border-left:none;width:257pt'>No.&amp; date of Invoice</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 height=22 class=xl90 width=420 style='border-right:1.0pt solid black;
  height:16.5pt;width:315pt'><%=l_com_name %></td>
  <td colspan=3 class=xl94 style='border-left:none'><%=l_invoice_no %></td>
  <td class=xl32><%=l_invoice_dt %></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 rowspan=3 height=65 class=xl95 width=420 style='border-right:
  1.0pt solid black;border-bottom:1.0pt solid black;height:48.75pt;width:315pt'><%=l_com_add %></td>
  <td colspan=4 class=xl101 width=343 style='border-right:1.0pt solid black;
  border-left:none;width:257pt'>No.&amp; date of L/C</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 height=22 class=xl103 style='height:16.5pt;border-left:none'><%=l_lc_no %></td>
  <td class=xl33><%=l_lc_dt %></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=4 height=21 class=xl101 width=343 style='border-right:1.0pt solid black;
  height:15.75pt;border-left:none;width:257pt'>L/C issuing bank</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl34 width=120 style='height:16.5pt;width:90pt'>Consignee</td>
  <td class=xl31></td>
  <td class=xl35 width=203 style='width:152pt'>&nbsp;</td>
  <td colspan=4 class=xl106 style='border-right:1.0pt solid black;border-left:
  none'><%=l_bank_name %></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 height=22 class=xl108 style='border-right:1.0pt solid black;
  height:16.5pt'><%=l_vendor_name %></td>
  <td colspan=4 rowspan=2 class=xl111 width=343 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;width:257pt'><%=l_bank_add %></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=3 rowspan=3 height=66 class=xl115 width=420 style='height:49.5pt;width:315pt'><%=l_vendor_add %></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=4 height=22 class=xl87 width=343 style='border-right:1.0pt solid black;
  height:16.5pt;width:257pt' x:str="Remark : ">Remark :<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=4 rowspan=7 height=159 class=xl119 width=343 style='border-right:
  1.0pt solid black;border-bottom:1.0pt solid black;height:119.25pt;width:257pt'><%=l_remark %></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl34 width=120 style='height:17.25pt;width:90pt'>Notify
  party</td>
  <td class=xl31></td>
  <td class=xl35 width=203 style='width:152pt'>&nbsp;</td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl108 style='border-right:1.0pt solid black;
  height:17.25pt'><%=l_notify_name %></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 rowspan=4 height=91 class=xl115 width=420 style='border-right:
  1.0pt solid black;border-bottom:1.0pt solid black;height:68.25pt;width:315pt'><%=l_notify_add %></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl36 style='height:16.5pt'>Port of loading</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>Final destination</td>
  <td colspan=4 class=xl88 width=343 style='border-right:1.0pt solid black;
  border-left:none;width:257pt' x:str="Terms of delivery ">Terms of
  delivery<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl126 style='border-right:1.0pt solid black;
  height:16.5pt'><%=l_loading_port %></td>
  <td class=xl39><%=l_destination %></td>
  <td colspan=4 rowspan=3 class=xl34 width=343 style='border-right:1.0pt solid black;
  width:257pt'><%=l_trade_term %></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl36 style='height:16.5pt'>Carrier</td>
  <td class=xl40 width=97 style='width:73pt'>&nbsp;</td>
  <td class=xl41>Sailing on or about</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td colspan=2 height=22 class=xl129 width=217 style='border-right:1.0pt solid black;
  height:16.5pt;width:163pt'><%=l_carrier_nm %></td>
  <td class=xl42><%=l_ship_date %></td>
 </tr>
 <%
     double l_tt_qty = 0, l_tt_amt = 0;    
 %>
 <tr class=xl43 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl44 width=120 style='height:16.5pt;width:90pt' >Mark & No.</td>
  <td colspan=2 class=xl131 width=300 style='border-right:1.0pt solid black;
  width:225pt'>Goods description</td>
  <td class=xl45 width=107 style='width:80pt'>Quantity</td>
  <td colspan=2 class=xl133 width=112 style='border-right:1.0pt solid black;
  width:84pt'>Unit Price</td>
  <td class=xl46 width=124 style='width:93pt'>Amount</td>
 </tr>
 <% if (dtDetail.Rows.Count >0) 
    {
        l_tt_qty+= Convert.ToDouble( dtDetail.Rows[0][7]);
        l_tt_amt+=Convert.ToDouble(dtDetail.Rows[0][10]);
    }           
 %>
 <tr class=xl47 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td rowspan=10 height=274 class=xl136 width=120 style='border-bottom:1.0pt solid black;
  height:205.5pt;border-top:none;width:90pt'>&nbsp;<%=l_marks%></td>
  <td colspan=2 class=xl138 style='border-right:1.0pt solid black;border-left:
  none'><% if (dtDetail.Rows.Count >0) Response.Write(dtDetail.Rows[0][0].ToString()); %></td>
  <td class=xl48 width=107 style='width:80pt'><% if (dtDetail.Rows.Count >0) Response.Write(dtDetail.Rows[0][2].ToString()); %></td>
  <td class=xl49 width=48 style='width:36pt'>&nbsp;</td>
  <td class=xl50 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl51 width=124 style='width:93pt'><%=l_curr %></td>
 </tr>
 <tr class=xl47 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=2 height=25 class=xl106 style='border-right:1.0pt solid black;
  height:18.75pt;border-left:none'><% if (dtDetail.Rows.Count >0) Response.Write(dtDetail.Rows[0][9].ToString()); %></td>
  <td class=xl48></td>
  <td class=xl49 width=48 style='width:36pt'>&nbsp;</td>
  <td class=xl50 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl51 width=124 style='width:93pt'>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 rowspan=2 height=56 class=xl140 width=300 style='border-right:
  1.0pt solid black;height:42.0pt;width:225pt'
  x:str><% if (dtDetail.Rows.Count >0) Response.Write(dtDetail.Rows[0][1].ToString()); %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl153 style='border-left:none'><% if (dtDetail.Rows.Count >0) Response.Write(dtDetail.Rows[0][4].ToString()); %></td>
  <td class=xl148><% if (dtDetail.Rows.Count >0) Response.Write(dtDetail.Rows[0][3]); %></td>
  <td class=xl53><%=l_curr %>/<% if (dtDetail.Rows.Count >0) Response.Write(dtDetail.Rows[0][8].ToString()); %></td>
  <td class=xl154><% if (dtDetail.Rows.Count >0) Response.Write(dtDetail.Rows[0][5]); %></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl55 style='height:21.0pt'></td>
  <td class=xl149>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl142 style='border-right:1.0pt solid black;
  height:21.0pt;border-left:none'>&nbsp;</td>
  <td class=xl52></td>
  <td class=xl150>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
<% if (dtDetail.Rows.Count >1) 
    {
        l_tt_qty+=Convert.ToDouble( dtDetail.Rows[1][7]);
        l_tt_amt+=Convert.ToDouble(  dtDetail.Rows[1][10]);
    }           
 %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl144 style='border-right:1.0pt solid black;
  height:21.0pt;border-left:none'><% if (dtDetail.Rows.Count >1) Response.Write(dtDetail.Rows[1][0].ToString()); %></td>
  <td class=xl48 width=107 style='width:80pt'><% if (dtDetail.Rows.Count >1) Response.Write(dtDetail.Rows[1][2].ToString()); %></td>
  <td class=xl151 width=48 style='width:36pt'>&nbsp;</td>
  <td class=xl50 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl58 width=124 style='width:93pt'><%=l_curr %></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl106 style='border-right:1.0pt solid black;
  height:21.0pt;border-left:none'><% if (dtDetail.Rows.Count >1) Response.Write(dtDetail.Rows[1][9].ToString()); %></td>
  <td class=xl59></td>
  <td class=xl152>&nbsp;</td>
  <td class=xl56>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 rowspan=2 height=56 class=xl140 width=300 style='border-right:
  1.0pt solid black;height:42.0pt;width:225pt'
  x:str><% if (dtDetail.Rows.Count >1) Response.Write(dtDetail.Rows[1][1].ToString()); %><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl153 style='border-left:none'><% if (dtDetail.Rows.Count >1) Response.Write(dtDetail.Rows[1][4]); %></td>
  <td class=xl148><% if (dtDetail.Rows.Count >1) Response.Write(dtDetail.Rows[1][3].ToString()); %></td>
  <td class=xl53><%=l_curr %>/<% if (dtDetail.Rows.Count >1) Response.Write(dtDetail.Rows[1][8].ToString()); %></td>
  <td class=xl154><% if (dtDetail.Rows.Count >1) Response.Write(dtDetail.Rows[1][5]); %></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl59 style='height:21.0pt'></td>
  <td class=xl60>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=2 height=28 class=xl146 style='border-right:1.0pt solid black;
  height:21.0pt;border-left:none'>&nbsp;</td>
  <td class=xl63></td>
  <td class=xl60>&nbsp;</td>
  <td class=xl64>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
 </tr>
 <tr class=xl65 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl66 style='height:19.5pt'>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td class=xl68>TOTAL:</td>
  <td class=xl69 x:num x><%=l_tt_qty %></td>
  <td class=xl70>&nbsp;</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl72 x:num ><%=l_tt_amt %></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl73 width=120 style='height:14.25pt;width:90pt'>&nbsp;</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl27></td>
  <td class=xl75>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl73 width=120 style='height:24.0pt;width:90pt'>&nbsp;</td>
  <td class=xl25></td>
  <td class=xl74></td>
  <td class=xl25></td>
  <td class=xl76></td>
  <td class=xl77></td>
  <td class=xl78>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl73 width=120 style='height:24.0pt;width:90pt'>&nbsp;</td>
  <td colspan=2 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl79 x:str="Signed by: ">Signed by:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl80></td>
  <td class=xl25></td>
  <td class=xl75>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl73 width=120 style='height:24.0pt;width:90pt'>&nbsp;</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl25></td>
  <td class=xl75>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl73 width=120 style='height:24.0pt;width:90pt'>&nbsp;</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl25></td>
  <td class=xl75>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl73 width=120 style='height:24.0pt;width:90pt'>&nbsp;</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl25></td>
  <td class=xl75>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl73 width=120 style='height:24.0pt;width:90pt'>&nbsp;</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl25></td>
  <td class=xl75>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl73 width=120 style='height:24.0pt;width:90pt'>&nbsp;</td>
  <td colspan=3 class=xl74 style='mso-ignore:colspan'></td>
  <td class=xl80></td>
  <td class=xl25></td>
  <td class=xl75>&nbsp;</td>
 </tr>
 <tr height=57 style='mso-height-source:userset;height:42.75pt'>
  <td height=57 class=xl81 width=120 style='height:42.75pt;width:90pt'>&nbsp;</td>
  <td class=xl82 width=97 style='width:73pt'>&nbsp;</td>
  <td class=xl82 width=203 style='width:152pt'>&nbsp;</td>
  <td class=xl82 width=107 style='width:80pt'>&nbsp;</td>
  <td class=xl83>&nbsp;</td>
  <td class=xl84>&nbsp;</td>
  <td class=xl85>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=120 style='width:90pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=203 style='width:152pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=124 style='width:93pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
