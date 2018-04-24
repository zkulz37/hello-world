<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% 
string p_comp           = "" ;
string p_from           = "";
string p_to             = "";
string p_voucher_type   = "";
string p_tr_type        = "";
string p_voucherno      = "";
string p_serial_no      = "";
string p_invoceno       = "";
string p_cust_pk        = "";
string p_cust_id        = "";
string p_status         = "";
string p_seq            = "";
p_seq                   = Request["p_seq"];
p_comp                  = Request["p_comp"];
p_from                  = Request["p_from"];
p_to                    = Request["p_to"];
p_voucher_type          = Request["p_voucher_type"];
p_tr_type               = Request["p_tr_type"];
p_voucherno             = Request["p_voucherno"];
p_serial_no             = Request["p_serial_no"];
p_invoceno              = Request["p_invoceno"];
p_cust_pk               = Request["p_cust_pk"];
p_cust_id               = Request["p_cust_id"];
p_status                = Request["p_status"];
p_voucher_type          = p_voucher_type.ToUpper();
string SQL
	= "   select a.pk, h.pk seq, nvl(h.voucher_type, a.voucher_type) voucher_type, NVL(h.voucherno, a.voucherno) voucherno, to_char(to_date(a.tr_date, 'yyyymmdd'), 'dd/mm/yyyy'), " + 
        "    a.tr_ccy, a.tr_rate, a.bk_rate,a.serial_no, a.invoice_date, a.invoice_no, " +
        "    a.tco_buspartner_pk, t.partner_id, t.partner_name, " +
        "    decode(h.voucher_type, 'XTP', sf_get_tramt_costing(h.pk), a.tot_net_tr_amt) tot_net_tr_amt, decode(h.voucher_type, 'XTP', sf_get_bkamt_costing(h.pk), a.tot_net_bk_amt) tot_net_bk_amt, " +
        "    decode(h.voucher_type, 'XTP', 0, a.tot_ex_tax_tr_amt) tot_ex_tax_tr_amt, decode(h.voucher_type, 'XTP', 0, a.tot_ex_tax_bk_amt) tot_ex_tax_bk_amt, " +
        "    a.vat_rate, decode(h.voucher_type, 'XTP', 0, a.tot_vat_tr_amt) tot_vat_tr_amt, decode(h.voucher_type, 'XTP', 0, a.tot_vat_bk_amt) tot_vat_bk_amt, " +
        "    a.tac_abacctcode_pk, b.ac_cd,b.ac_nm, " +
        "    a.remark, a.remark2, a.remark3, a.tco_company_pk, u.user_id   " +
        "      from tac_crca a, tac_hgtrh h, tac_abacctcode b, tco_buspartner t, gasp.tes_user u " +
        "     where a.del_if = 0 and h.del_if(+) = 0 " +
        "       and b.del_if = 0 and t.del_if(+) = 0 and u.del_if(+) = 0 " +        
        "       and h.tr_tablenm(+) = 'TAC_CRCA' " +
        "       and h.tr_table_pk(+) = a.pk " +
        "       and a.tac_abacctcode_pk = b.pk " +
        "       and a.tco_buspartner_pk(+) = t.pk " +
        "       and h.tco_bsuser_pk = u.pk(+) " +
        "       and a.tco_company_pk = " + p_comp + 
        "       and a.tr_date between '" + p_from + "' and '" + p_to + "' " +
        "       and decode('" + p_voucher_type + "', 'ALL', '" + p_voucher_type + "', h.voucher_type) = '" + p_voucher_type + "' " +
        "       and decode('" + p_tr_type + "', 'ALL', '" + p_tr_type + "', a.tr_type) = '" + p_tr_type + "' " +
        "       and a.voucherno like '%' || '" + p_voucherno + "' || '%' " +
        "       and (h.pk = '" + p_seq + "' or '" + p_seq + "' is null) " +
        "       and a.serial_no like '%' || '" + p_serial_no + "' || '%'  " +
        "       and a.invoice_no like '%' || '" + p_invoceno + "' || '%' " +
        "       and (a.tco_buspartner_pk = '" + p_cust_pk + "' or '" + p_cust_pk + "' is null) " +
        "       and t.partner_id like '%' || '" + p_cust_id + "' || '%' " +
        "       and a.tr_status like decode('" + p_status + "', 'ALL','%' , '" + p_status + "') " ;
    DataTable dt    = new DataTable();
    dt              = ESysLib.TableReadOpen(SQL);
//company
    SQL = "select partner_name from tco_company where pk = '" + p_comp + "' " ; 
    DataTable dtComp = new DataTable();
    dtComp           = ESysLib.TableReadOpen(SQL);
//today
    DateTime dt_Today = DateTime.Today;
    string ls_today = dt_Today.ToString("D");
// customer    
    string ls_cust_id = "" ;
    string ls_cust_nm = "" ;
    SQL
	= "select partner_id, partner_name from tco_buspartner where del_if = 0 and pk = '" + p_cust_pk + "' " ;

    DataTable dtCust = new DataTable();
    dtCust           = ESysLib.TableReadOpen(SQL);
    
	if(dtCust.Rows.Count > 0)
	{
	    ls_cust_id = dtCust.Rows[0][0].ToString();
	    ls_cust_nm = dtCust.Rows[0][1].ToString();
    }
    
// from date to date
    string ls_date_from = p_from.Substring(6, 2) + "/" + p_from.Substring(4, 2) + "/" + p_from.Substring(0, 4);
    string ls_date_to   = p_to.Substring(6, 2) + "/" + p_to.Substring(4, 2) + "/" + p_to.Substring(0, 4);
// status
    string ls_status = "";
    if(p_status == "1")
        ls_status = "Saved";
    else if(p_status == "2")         
        ls_status = "Confirmed";
    else if(p_status == "3")         
        ls_status = "Cancelled";
    else if(p_status == "0")         
        ls_status = "Approved";
    else if(p_status == "4")         
        ls_status = "Not Approved";
// Domestic hay Oversea
string ls_tr_type = "";
if(p_tr_type == "DO")        
    ls_tr_type = "Domestic";
else if(p_tr_type == "OS")        
    ls_tr_type = "Foreign";
else if(p_tr_type == "ALL")
    ls_tr_type = "Domestic & Foreign";
//                        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfca00030_AR%20History_files/filelist.xml">
<link rel=Edit-Time-Data href="gfca00030_AR%20History_files/editdata.mso">
<link rel=OLE-Object-Data href="gfca00030_AR%20History_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>AA</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2009-01-08T01:43:23Z</o:LastPrinted>
  <o:Created>2009-01-08T01:24:24Z</o:Created>
  <o:LastSaved>2009-01-08T02:07:55Z</o:LastSaved>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .5in .5in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font9
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
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
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:left;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
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
	font-family:"Times New Roman", serif;
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
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>AR History</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>50</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8340</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='AR History'!$A$7:$U$7</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl26>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1969 style='border-collapse:
 collapse;table-layout:fixed;width:1481pt'>
 <col class=xl26 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl26 width=68 span=2 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl26 width=58 style='mso-width-source:userset;mso-width-alt:2121;
 width:44pt'>
 <col class=xl26 width=40 style='mso-width-source:userset;mso-width-alt:1462;
 width:30pt'>
 <col class=xl26 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl26 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl26 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl26 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl26 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl26 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl26 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl26 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl26 width=110 span=2 style='mso-width-source:userset;mso-width-alt:
 4022;width:83pt'>
 <col class=xl26 width=180 style='mso-width-source:userset;mso-width-alt:6582;
 width:135pt'>
 <col class=xl26 width=165 style='mso-width-source:userset;mso-width-alt:6034;
 width:124pt'>
 <col class=xl26 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl26 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 colspan=7 width=434 style='height:15.0pt;mso-ignore:
  colspan;width:327pt'><%=dtComp.Rows[0][0].ToString()%></td>
  <td class=xl26 width=76 style='width:57pt'></td>
  <td class=xl26 width=63 style='width:47pt'></td>
  <td class=xl26 width=61 style='width:46pt'></td>
  <td class=xl26 width=180 style='width:135pt'></td>
  <td class=xl26 width=110 style='width:83pt'></td>
  <td class=xl26 width=110 style='width:83pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl26 width=110 style='width:83pt'></td>
  <td class=xl26 width=110 style='width:83pt'></td>
  <td class=xl26 width=180 style='width:135pt'></td>
  <td class=xl26 width=165 style='width:124pt'></td>
  <td class=xl26 width=50 style='width:38pt'></td>
  <td class=xl26 width=114 style='width:86pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 colspan=3 style='height:15.0pt;mso-ignore:colspan'><%=ls_today %></td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=12 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'></td>
  <td class=xl28 colspan=3 style='mso-ignore:colspan'>Customer:<font
  class="font11"><span style='mso-spacerun:yes'>  </span><%=ls_cust_id %> || <%=ls_cust_nm %></font></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=12 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'></td>
  <td class=xl30 colspan=5 style='mso-ignore:colspan'>Date:<font class="font11"><span
  style='mso-spacerun:yes'>                    </span><%=ls_date_from %> ~ <%=ls_date_to %></font></td>
  <td class=xl27></td>
  <td class=xl29 colspan=3 style='mso-ignore:colspan'>Status:<font class="font9"><span
  style='mso-spacerun:yes'>          </span><%=ls_status %><span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl26></td>
  <td class=xl29 colspan=2 style='mso-ignore:colspan'>Origin:<font class="font9"><span
  style='mso-spacerun:yes'>          </span><%=ls_tr_type %><span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=8 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=21 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl52 style='border-bottom:.5pt solid black;
  height:30.0pt'>Seq</td>
  <td rowspan=2 class=xl54 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Voucher<br>
    <span style='mso-spacerun:yes'> </span>No</td>
  <td rowspan=2 class=xl54 width=68 style='border-bottom:.5pt solid black;
  width:51pt'>Trans Date</td>
  <td rowspan=2 class=xl54 width=58 style='border-bottom:.5pt solid black;
  width:44pt'>Proposed<br>
    <span style='mso-spacerun:yes'> </span>By</td>
  <td rowspan=2 class=xl52 style='border-bottom:.5pt solid black'>Ccy</td>
  <td rowspan=2 class=xl52 style='border-bottom:.5pt solid black'>Ex.Rate</td>
  <td colspan=3 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>Invoice</td>
  <td colspan=2 class=xl31 style='border-left:none'>Customer</td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>Net Amount</td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>VAT</td>
  <td colspan=2 class=xl46 style='border-right:.5pt solid black;border-left:
  none'>Total Amount</td>
  <td colspan=2 class=xl31 style='border-left:none'>Description</td>
  <td colspan=2 class=xl31 style='border-left:none'>Account Code</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 id="_x0000_s1031" x:autofilter="all"
  style='height:15.0pt'>Serial</td>
  <td class=xl32 id="_x0000_s1032" x:autofilter="all">No</td>
  <td class=xl32 id="_x0000_s1033" x:autofilter="all">Date</td>
  <td class=xl31 id="_x0000_s1034" x:autofilter="all" style='border-top:none;
  border-left:none'>Code</td>
  <td class=xl31 id="_x0000_s1035" x:autofilter="all" style='border-top:none;
  border-left:none'>Name</td>
  <td class=xl32 id="_x0000_s1036" x:autofilter="all">Transction</td>
  <td class=xl32 id="_x0000_s1037" x:autofilter="all">Book</td>
  <td class=xl32 id="_x0000_s1038" x:autofilter="all">Transction</td>
  <td class=xl32 id="_x0000_s1039" x:autofilter="all">Book</td>
  <td class=xl32 id="_x0000_s1040" x:autofilter="all">Transction</td>
  <td class=xl32 id="_x0000_s1041" x:autofilter="all">Book</td>
  <td class=xl31 id="_x0000_s1042" x:autofilter="all" style='border-top:none;
  border-left:none'>Foreign</td>
  <td class=xl31 id="_x0000_s1043" x:autofilter="all" style='border-top:none;
  border-left:none'>Local</td>
  <td class=xl31 id="_x0000_s1044" x:autofilter="all" style='border-top:none;
  border-left:none'>Code</td>
  <td class=xl31 id="_x0000_s1045" x:autofilter="all" style='border-top:none;
  border-left:none'>Name</td>
 </tr>
 <% 
    int i;
    
    decimal tot_trans_amt = 0 ;
    decimal tot_book_amt = 0 ;
    decimal sum_net_trans_amt_vnd   = 0;
    decimal sum_net_book_amt_vnd    = 0;
    decimal sum_vat_trans_amt_vnd   = 0;
    decimal sum_vat_book_amt_vnd    = 0;
    decimal sum_tot_trans_amt_vnd   = 0;
    decimal sum_tot_book_amt_vnd    = 0;

    decimal sum_net_trans_amt_usd   = 0;
    decimal sum_net_book_amt_usd    = 0;
    decimal sum_vat_trans_amt_usd   = 0;
    decimal sum_vat_book_amt_usd    = 0;
    decimal sum_tot_trans_amt_usd   = 0;
    decimal sum_tot_book_amt_usd    = 0;
    
    for(i = 0; i < dt.Rows.Count ; i++)
    {     
        tot_trans_amt = 0;
        tot_book_amt = 0;
        if( dt.Rows[i][14].ToString().Trim() != "")
            tot_trans_amt += Decimal.Parse(dt.Rows[i][14].ToString());
        if( dt.Rows[i][19].ToString().Trim() != "")
            tot_trans_amt += Decimal.Parse(dt.Rows[i][19].ToString());
        if( dt.Rows[i][15].ToString().Trim() != "")
            tot_book_amt += Decimal.Parse(dt.Rows[i][15].ToString());
        if( dt.Rows[i][20].ToString().Trim() != "")
            tot_book_amt += Decimal.Parse(dt.Rows[i][20].ToString());
                                           
        if(dt.Rows[i][5].ToString() == "VND")
        {
            if(dt.Rows[i][14].ToString().Trim() != "")
                sum_net_trans_amt_vnd       += Decimal.Parse(dt.Rows[i][14].ToString());
            if(dt.Rows[i][15].ToString().Trim() != "")    
                sum_net_book_amt_vnd        += Decimal.Parse(dt.Rows[i][15].ToString());
            if(dt.Rows[i][19].ToString().Trim() != "")        
                sum_vat_trans_amt_vnd       += Decimal.Parse(dt.Rows[i][19].ToString());
            if(dt.Rows[i][20].ToString().Trim() != "")        
                sum_vat_book_amt_vnd        += Decimal.Parse(dt.Rows[i][20].ToString());                
            sum_tot_trans_amt_vnd       += tot_trans_amt;
            sum_tot_book_amt_vnd        += tot_book_amt;
        }            
        else if(dt.Rows[i][5].ToString() == "USD")
        {
        
            if(dt.Rows[i][14].ToString().Trim() != "")
                sum_net_trans_amt_usd       += Decimal.Parse(dt.Rows[i][14].ToString());
            if(dt.Rows[i][15].ToString().Trim() != "")    
                sum_net_book_amt_usd        += Decimal.Parse(dt.Rows[i][15].ToString());
            if(dt.Rows[i][19].ToString().Trim() != "")        
                sum_vat_trans_amt_usd       += Decimal.Parse(dt.Rows[i][19].ToString());
            if(dt.Rows[i][20].ToString().Trim() != "")        
                sum_vat_book_amt_usd        += Decimal.Parse(dt.Rows[i][20].ToString());                
            sum_tot_trans_amt_usd       += tot_trans_amt;
            sum_tot_book_amt_usd        += tot_book_amt;
        }
 %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl33 style='height:20.1pt' x:num><%=dt.Rows[i][1] %></td>
  <td class=xl34><%=dt.Rows[i][3] %></td>
  <td class=xl56><%=dt.Rows[i][4] %></td>
  <td class=xl35><%=dt.Rows[i][28] %></td>
  <td class=xl34><%=dt.Rows[i][5] %></td>
  <td class=xl57 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6] %></td>
  <td class=xl34><%=dt.Rows[i][8] %></td>
  <td class=xl34><%=dt.Rows[i][10] %></td>
  <td class=xl56><%=dt.Rows[i][9] %></td>
  <td class=xl59 style='border-top:none;border-left:none'><%=dt.Rows[i][12] %></td>
  <td class=xl37 style='border-top:none;border-left:none'><%=dt.Rows[i][13] %></td>
  <td class=xl60 style='border-top:none' x:num><%=dt.Rows[i][14] %></td>
  <td class=xl38 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dt.Rows[i][15] %></td>
  <td class=xl60 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][19] %>
  </td>
  <td class=xl60 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][20] %>
  </td>
  <td class=xl60 style='border-top:none;border-left:none' x:num><%=tot_trans_amt %>
  </td>
  <td class=xl60 style='border-top:none;border-left:none' x:num><%=tot_book_amt %>
  </td>
  <td class=xl35><%=dt.Rows[i][23] %></td>
  <td class=xl35><%=dt.Rows[i][24] %></td>
  <td class=xl35><%=dt.Rows[i][21] %></td>
  <td class=xl35><%=dt.Rows[i][22] %></td>
 </tr>
 <% 
    }
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl48 style='border-right:.5pt solid black;
  height:15.0pt'>TOTAL</td>
  <td class=xl40 style='border-top:none;border-left:none'>VND</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 align=right style='border-top:none;border-left:none'
  x:num><%=sum_net_trans_amt_vnd %></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num
  ><%=sum_net_book_amt_vnd %></td>
  <td class=xl61 align=right style='border-top:none;border-left:none'
  x:num><%=sum_vat_trans_amt_vnd %></td>  
  <td class=xl61 align=right style='border-top:none;border-left:none'
  x:num><%=sum_vat_book_amt_vnd %></td>
  <td class=xl61 align=right style='border-top:none;border-left:none'
  x:num><%=sum_tot_trans_amt_vnd %></td>
  <td class=xl61 align=right style='border-top:none;border-left:none'
  x:num><%=sum_tot_book_amt_vnd %></td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl48 style='border-right:.5pt solid black;
  height:15.0pt'></td>
  <td class=xl40 style='border-top:none;border-left:none'>USD</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 align=right style='border-top:none;border-left:none'
  x:num><%=sum_net_trans_amt_usd %></td>
  <td class=xl39 style='border-top:none;border-left:none' x:num
  ><%=sum_net_book_amt_usd %></td>
  <td class=xl61 align=right style='border-top:none;border-left:none'
  x:num><%=sum_vat_trans_amt_usd %></td>  
  <td class=xl61 align=right style='border-top:none;border-left:none'
  x:num><%=sum_vat_book_amt_usd %></td>
  <td class=xl61 align=right style='border-top:none;border-left:none'
  x:num><%=sum_tot_trans_amt_usd %></td>
  <td class=xl61 align=right style='border-top:none;border-left:none'
  x:num><%=sum_tot_book_amt_usd %></td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=21 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=17 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl45>Giám đốc</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl42></td>
  <td colspan=3 class=xl45>Người ghi sổ</td>
  <td class=xl41></td>
  <td class=xl26></td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=3 class=xl45>Kế toán trưởng</td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl44>( Ký, họ tên, đóng dấu )</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td colspan=3 class=xl44>( Ký, họ tên )</td>
  <td class=xl41></td>
  <td class=xl26></td>
  <td colspan=3 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=3 class=xl44>( Ký, họ tên )</td>
  <td colspan=7 class=xl26 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=61 style='width:46pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=180 style='width:135pt'></td>
  <td width=165 style='width:124pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=114 style='width:86pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
