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
    string SQL = "";
    string p_date_fr = "", p_date_to = "";
    string p_com_pk = "", p_month = "", p_year = "";
    string l_tax_code = "", l_book_ccy = "";
    int i;
    string l_serial_no = "", l_invoice_no = "", l_invoice_date = "";
    string l_partner_name = "", l_tax_code_cust = "", l_vat_desc = "";
    double l_net_amt = 0, l_vat_tax_amt = 0;
    string l_voucherno = "", l_partner_deli = "";
    double l_net_tr_amt = 0, l_tr_rate = 0, l_sum_qty = 0;
    ///////----------------------------------------------
    double l_tot_net_amt = 0, l_tot_vat_amt = 0, l_tot_qty = 0, l_tot_tr_amt = 0;
    double l_grand_net_amt = 0, l_grand_vat_amt = 0;
    
    p_date_fr = Request["tr_date_fr"];
    p_date_to = Request["tr_date_to"];
    p_com_pk = Request["tco_company_pk"];
    p_month = p_date_to.Substring(4, 2);
    p_year = p_date_to.Substring(0, 4);
    SQL = "select tax_code from tco_company where pk = '" + p_com_pk + "' ";
    DataTable dtTaxCode = new DataTable();
    dtTaxCode = ESysLib.TableReadOpen(SQL);
    if (dtTaxCode.Rows.Count > 0)
    {
        l_tax_code = dtTaxCode.Rows[0][0].ToString();
    }
    SQL = "select d.code " ;
    SQL += "from tac_commcode_master a, tac_commcode_detail d " ;
    SQL += "where a.id = 'ACBG0040' ";
    SQL += "and a.del_if = 0 ";
    SQL += "and a.pk = d.tac_commcode_master_pk ";
    SQL += "and d.del_if = 0 ";
    SQL += "and d.use_yn = 'Y' ";
    SQL += "and d.def_yn = 'Y'";
    DataTable dtBKCcy = new DataTable();
    dtBKCcy = ESysLib.TableReadOpen(SQL);
    if (dtBKCcy.Rows.Count > 0)
    {
        l_book_ccy = dtBKCcy.Rows[0][0].ToString();
        if (l_book_ccy == "VND")
            l_book_ccy = "đồng Việt Nam";
        else if (l_book_ccy == "USD")
            l_book_ccy = "đôla Mỹ";        
    }
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Report_VAT_OUT_files/filelist.xml">
<link rel=Edit-Time-Data href="Report_VAT_OUT_files/editdata.mso">
<link rel=OLE-Object-Data href="Report_VAT_OUT_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Daewon02</o:Author>
  <o:LastAuthor>van</o:LastAuthor>
  <o:LastPrinted>2011-05-17T07:54:31Z</o:LastPrinted>
  <o:Created>2011-05-12T03:29:06Z</o:Created>
  <o:LastSaved>2011-05-19T04:05:01Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
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
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
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
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
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
.xl32
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
.xl33
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
.xl34
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
.xl35
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
.xl36
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
.xl37
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
.xl38
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	background:white;
	mso-pattern:auto none;}
.xl39
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
.xl40
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:0%;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
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
.xl45
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
.xl46
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
.xl47
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	background:white;
	mso-pattern:auto none;
	padding-left:180px;
	mso-char-indent-count:15;}
.xl49
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:justify;
	background:white;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl51
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
.xl52
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
.xl53
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
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:1.0pt solid windowtext;
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
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl56
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
.xl57
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
.xl58
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
.xl59
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
.xl60
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
.xl61
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl66
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	border:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl67
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:1.0pt solid windowtext;
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>6</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>22</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>10140</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1028"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1317 style='border-collapse:
 collapse;table-layout:fixed;width:989pt'>
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
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl24 width=71 span=2 style='mso-width-source:userset;mso-width-alt:
 2596;width:53pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl24 width=13 style='height:25.5pt;width:10pt'>&nbsp;</td>
  <td rowspan=2 height=34 width=51 style='height:25.5pt;width:38pt' align=left
  valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1027" style='position:absolute;
   direction:LTR;text-align:left;margin-left:2.25pt;margin-top:12pt;width:147pt;
   height:51pt;z-index:1;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;direction:ltr'><font class="font0">Mẫu số:
    01- 2/GTGT<br>
        (Ban hành kèm theo Thông tư số 60/2007/TT-BTC ngày<span
    style='mso-spacerun:yes'>  </span><br>
        14/6/2007 của<span style='mso-spacerun:yes'>  </span>Bộ Tài chính)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:2px;margin-top:15px;width:198px;height:70px'><img
  width=198 height=70 src="Report_VAT_OUT_files/image002.gif"
  alt="Text Box: Mẫu số: 01- 2/GTGT&#10;(Ban hành kèm theo Thông tư số 60/2007/TT-BTC ngày  &#10;14/6/2007 của  Bộ Tài chính)"
  v:shapes="_x0000_s1027"></span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=34 class=xl50 width=51 style='height:25.5pt;
    width:38pt'><br>
        &nbsp;</td>
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
  <td rowspan=2 class=xl24 width=98 style='width:74pt'>&nbsp;</td>
  <td class=xl24 width=87 style='width:65pt'>&nbsp;</td>
  <td class=xl24 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl24 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl24 width=72 style='width:54pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl24 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td colspan=2 class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'>&nbsp;</td>
  <td colspan=11 class=xl26>BẢNG KÊ HOÁ ĐƠN, CHỨNG TỪ HÀNG HOÁ, DỊCH VỤ BÁN RA</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=0 style='display:none'>
  <td class=xl24 align=left>B<span style='display:none'>angkemuavao.xls</span></td>
  <td colspan=11 class=xl26>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl27>(Kèm theo tờ khai thuế GTGT theo mẫu số 01/GTGT)</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl27>Kỳ tính thuế: Tháng <%=p_month %> năm <%=p_year %></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl27>&nbsp;</td>
  <td colspan=2 class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl25 x:str="Người nộp thuế:        ">Người nộp
  thuế:<span style='mso-spacerun:yes'>        </span></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl25>Mã số thuế: <%=l_tax_code %></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td colspan=2 class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td colspan=11 class=xl51>Đơn vị tiền: <%=l_book_ccy%></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td rowspan=3 class=xl53 width=51 style='border-bottom:1.0pt solid black;
  border-top:none;width:38pt'>STT</td>
  <td colspan=3 rowspan=2 class=xl55 width=219 style='border-right:1.0pt solid black;
  border-bottom:1.0pt solid black;width:164pt'>Hoá đơn, chứng từ, biên lai nộp
  thuế</td>
  <td rowspan=3 class=xl53 width=204 style='border-bottom:1.0pt solid black;
  border-top:none;width:153pt'>Tên người bán</td>
  <td rowspan=3 class=xl53 width=105 style='border-bottom:1.0pt solid black;
  border-top:none;width:79pt'>Mã số thuế người bán</td>
  <td rowspan=3 class=xl53 width=113 style='border-bottom:1.0pt solid black;
  border-top:none;width:85pt'>Mặt hàng</td>
  <td rowspan=3 class=xl53 width=90 style='border-bottom:1.0pt solid black;
  border-top:none;width:68pt'>Doanh số mua chưa có thuế</td>
  <td rowspan=3 class=xl53 width=37 style='border-bottom:1.0pt solid black;
  border-top:none;width:28pt'>Thuế suất</td>
  <td rowspan=3 class=xl53 width=86 style='border-bottom:1.0pt solid black;
  border-top:none;width:65pt'>Thuế GTGT</td>
  <td rowspan=3 class=xl53 width=98 style='border-bottom:1.0pt solid black;
  border-top:none;width:74pt'>Ghi chú</td>
  <td rowspan=3 class=xl53 width=87 style='width:65pt'
  x:str="Tên cty nhận hàng ">Tên cty nhận hàng<span
  style='mso-spacerun:yes'> </span></td>
  <td rowspan=3 class=xl53 width=71 style='border-bottom:1.0pt solid black;
  width:53pt'>Tổng tiền USD</td>
  <td class=xl29 width=71 style='width:53pt'>&nbsp;</td>
  <td rowspan=3 class=xl53 width=72 style='border-bottom:1.0pt solid black;
  width:54pt'>Tổng số mét</td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl24 style='height:4.5pt'>&nbsp;</td>
  <td class=xl30 width=71 style='width:53pt'>&nbsp;</td>
 </tr>
 <tr height=47 style='mso-height-source:userset;height:35.25pt'>
  <td height=47 class=xl24 style='height:35.25pt'>&nbsp;</td>
  <td class=xl31 width=72 style='width:54pt'>Ký hiệu hoá đơn</td>
  <td class=xl31 width=71 style='width:53pt'>Số hoá đơn</td>
  <td class=xl32 width=76 style='width:57pt'>Ngày, tháng, năm phát hành</td>
  <td class=xl33 width=71 style='width:53pt'>Tỷ giá</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl34 width=51 style='width:38pt'>[1]</td>
  <td class=xl35 width=72 style='width:54pt'>[2]</td>
  <td class=xl35 width=71 style='width:53pt'>[3]</td>
  <td class=xl36 width=76 style='width:57pt'>[4]</td>
  <td class=xl35 width=204 style='width:153pt'>[5]</td>
  <td class=xl37 width=105 style='width:79pt'>[6]</td>
  <td class=xl37 width=113 style='width:85pt'>[7]</td>
  <td class=xl35 width=90 style='width:68pt'>[8]</td>
  <td class=xl35 width=37 style='width:28pt'>[9]</td>
  <td class=xl35 width=86 style='width:65pt'>[10]</td>
  <td class=xl62 width=98 style='width:74pt'>[11]</td>
  <td class=xl65>&nbsp;</td>
  <td class=xl66 style='border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td colspan=11 class=xl59 align=left width=1003 style='width:754pt'>1.Hàng
  hóa, dịch vụ không chịu thuế GTGT:</td>
  <td class=xl65 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>            </span><span
  style='mso-spacerun:yes'>   </span></td>
 </tr>
 <%
     SQL
         = "select a.serial_no, a.invoice_no, to_char(to_date(a.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') invoice_date, c.partner_name, c.tax_code,  " +
             "( select i.item " +
             "from tac_crcaditem i, tac_abitem b " +
             "where i.tac_crca_pk = a.pk " +
             "and i.del_if = 0 " +
             "and i.tac_abitem_pk = b.pk " +
             "and b.del_if = 0 " +
             "and b.item_nm = 'PRODUCT ITEM') desc_vat, ( select i.item " +
             "from tac_crcaditem i, tac_abitem b " +
             "where i.tac_crca_pk = a.pk " +
             "and i.del_if = 0 " +
             "and i.tac_abitem_pk = b.pk " +
             "and b.del_if = 0 " +
             "and b.item_nm = 'NET AMOUNT') net_amt, " +
             "(select sum(d.vat_tax_amt) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) vat_tax_amt, " +
             "a.voucherno || '(' || h.pk || ')' voucherno,  " +
             "( select partner_name from tco_buspartner where pk = a.tco_buspartner_pk_ar and del_if = 0) partner_name_ar, " +
             "(select sum(d.net_tr_amt) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) net_tr_amt, " +
             "a.tr_rate, (select sum(d.qty) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) sum_qty " +
             "from tac_crca a, tco_buspartner c, tac_hgtrh h " +
             "where a.tr_date between '" + p_date_fr + "' and '" + p_date_to + "' " +
             " and a.tco_company_pk = " + p_com_pk +
             "and a.del_if = 0 " +
             "and a.tr_status in ('2', '0') " +
             "and exists (select 'X' from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0 and d.vat_rate in ('01', 'NO')) " +
             "and a.tco_buspartner_pk = c.pk " +
             "and a.pk = h.tr_table_pk " +
             "and h.tr_tablenm = 'TAC_CRCA' " +
             "and h.del_if = 0 " +
             "and h.tr_status in ('2', '0') " +
             " order by a.serial_no, a.invoice_no";
     DataTable dtItem = new DataTable();
     dtItem = ESysLib.TableReadOpen(SQL);
     for (i = 0; i < dtItem.Rows.Count; i++)
     {         
        l_serial_no = dtItem.Rows[i][0].ToString();
        l_invoice_no = dtItem.Rows[i][1].ToString();
        l_invoice_date = dtItem.Rows[i][2].ToString();
        l_partner_name = dtItem.Rows[i][3].ToString();
        l_tax_code_cust = dtItem.Rows[i][4].ToString();
        l_vat_desc = dtItem.Rows[i][5].ToString();
        if(dtItem.Rows[i][6].ToString() != "")
            l_net_amt = double.Parse(dtItem.Rows[i][6].ToString());
        if(dtItem.Rows[i][7].ToString() != "") 
            l_vat_tax_amt = double.Parse(dtItem.Rows[i][7].ToString());         
        l_voucherno = dtItem.Rows[i][8].ToString();
        l_partner_deli = dtItem.Rows[i][9].ToString();
        if(dtItem.Rows[i][10].ToString() != "")
            l_net_tr_amt = double.Parse(dtItem.Rows[i][10].ToString());
        if( dtItem.Rows[i][11].ToString() != "")
            l_tr_rate = double.Parse(dtItem.Rows[i][11].ToString());
        if( dtItem.Rows[i][12].ToString() != "")        
            l_sum_qty = double.Parse(dtItem.Rows[i][12].ToString());
        l_tot_net_amt += l_net_amt;
        l_tot_vat_amt += l_vat_tax_amt;
        l_tot_qty += l_sum_qty;
        l_tot_tr_amt += l_net_tr_amt;  
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl39 width=51 style='width:38pt'><%=i + 1%></td>
  <td class=xl40><%=l_serial_no %></td>
  <td class=xl41><%=l_invoice_no %></td>
  <td class=xl41><%=l_invoice_date %></td>
  <td class=xl41><%=l_partner_name %></td>
  <td class=xl41><%=l_tax_code_cust %></td>
  <td class=xl41><%=l_vat_desc %></td>
  <td class=xl41><%=l_net_amt %></td>
  <td class=xl42 align=left><span style='mso-spacerun:yes'> </span></td>
  <td class=xl43><%=l_vat_tax_amt %></td>
  <td class=xl63><%=l_voucherno %></td>
  <td class=xl65 style='border-top:none'><%=l_partner_deli %></td>
  <% if (l_tr_rate > 1)
     { %>
  <td class=xl66 style='border-top:none;border-left:none'><%=l_net_tr_amt%></td>
  <td class=xl67 style='border-top:none;border-left:none'><%=l_tr_rate%></td>
  <% }
     else
     { %>
  <td class=xl66 style='border-top:none;border-left:none'></td>
  <td class=xl67 style='border-top:none;border-left:none'></td>
  <% } %>
  
  <td class=xl68 style='border-top:none;border-left:none'><%=l_sum_qty %></td>
 </tr>
 <% 
     }
     l_grand_net_amt += l_tot_net_amt;
     l_grand_vat_amt += l_tot_vat_amt;
       %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl44 align=left width=51 style='width:38pt'>Tổng</td>
  <td class=xl45 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl45 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl46 width=76 style='width:57pt'>&nbsp;</td>
  <td class=xl45 width=204 style='width:153pt'>&nbsp;</td>
  <td class=xl45 width=105 style='width:79pt'>&nbsp;</td>
  <td class=xl45 width=113 style='width:85pt'>&nbsp;</td>
  <td class=xl41 align=right x:num><%=l_tot_net_amt%></td>
  <td class=xl45 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl43 align=right x:num><%=l_tot_vat_amt%></td>
  <td class=xl64 width=98 style='width:74pt'>&nbsp;</td>
  <td class=xl65 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none' x:num ><%=l_tot_tr_amt%></td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none' x:num ><%=l_tot_qty%></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td colspan=11 class=xl59 align=left width=1003 style='width:754pt'>2.Hàng
  hoá, dịch vụ chịu thuế suất thuế GTGT 0%</td>
  <td class=xl65 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
     SQL
         = "select a.serial_no, a.invoice_no, to_char(to_date(a.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') invoice_date, c.partner_name, c.tax_code,  " +
             "( select i.item " +
             "from tac_crcaditem i, tac_abitem b " +
             "where i.tac_crca_pk = a.pk " +
             "and i.del_if = 0 " +
             "and i.tac_abitem_pk = b.pk " +
             "and b.del_if = 0 " +
             "and b.item_nm = 'PRODUCT ITEM') desc_vat, ( select i.item " +
             "from tac_crcaditem i, tac_abitem b " +
             "where i.tac_crca_pk = a.pk " +
             "and i.del_if = 0 " +
             "and i.tac_abitem_pk = b.pk " +
             "and b.del_if = 0 " +
             "and b.item_nm = 'NET AMOUNT') net_amt, " +
             "(select sum(d.vat_tax_amt) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) vat_tax_amt, " +
             "a.voucherno || '(' || h.pk || ')' voucherno,  " +
             "( select partner_name from tco_buspartner where pk = a.tco_buspartner_pk_ar and del_if = 0) partner_name_ar, " +
             "(select sum(d.net_tr_amt) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) net_tr_amt, " +
             "a.tr_rate, (select sum(d.qty) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) sum_qty " +
             "from tac_crca a,tco_buspartner c, tac_hgtrh h " +
             "where a.tr_date between '" + p_date_fr + "' and '" + p_date_to + "' " +
             " and a.tco_company_pk = " + p_com_pk +
             "and a.del_if = 0 " +
             "and a.tr_status in ('2', '0') " +
             "and exists (select 'X' from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0 and d.vat_rate in ('00')) " +
             "and a.tco_buspartner_pk = c.pk " +
             "and a.pk = h.tr_table_pk " +
             "and h.tr_tablenm = 'TAC_CRCA' " +
             "and h.del_if = 0 " +
             "and h.tr_status in ('2', '0') " +
             " order by a.serial_no, a.invoice_no";
     DataTable dtItem_0 = new DataTable();
     dtItem_0 = ESysLib.TableReadOpen(SQL);
     for (i = 0; i < dtItem_0.Rows.Count; i++)
     {
         l_serial_no = dtItem_0.Rows[i][0].ToString();
         l_invoice_no = dtItem_0.Rows[i][1].ToString();
         l_invoice_date = dtItem_0.Rows[i][2].ToString();
         l_partner_name = dtItem_0.Rows[i][3].ToString();
         l_tax_code_cust = dtItem_0.Rows[i][4].ToString();
         l_vat_desc = dtItem_0.Rows[i][5].ToString();
         if(dtItem_0.Rows[i][6].ToString() != "")
            l_net_amt = double.Parse(dtItem_0.Rows[i][6].ToString());
         if(dtItem_0.Rows[i][7].ToString() != "")
            l_vat_tax_amt = double.Parse(dtItem_0.Rows[i][7].ToString());         
         l_voucherno = dtItem_0.Rows[i][8].ToString();
         l_partner_deli = dtItem_0.Rows[i][9].ToString();
         if(dtItem_0.Rows[i][10].ToString() != "")
            l_net_tr_amt = double.Parse(dtItem_0.Rows[i][10].ToString());
         if(dtItem_0.Rows[i][11].ToString() != "")
            l_tr_rate = double.Parse(dtItem_0.Rows[i][11].ToString());
         if(dtItem_0.Rows[i][12].ToString() != "")
            l_sum_qty = double.Parse(dtItem_0.Rows[i][12].ToString());
         l_tot_net_amt += l_net_amt;
         l_tot_vat_amt += l_vat_tax_amt;
         l_tot_qty += l_sum_qty;
         l_tot_tr_amt += l_net_tr_amt;                
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl39 align=left width=51 style='width:38pt'><%=i + 1%></td>
  <td class=xl40 align=left><%=l_serial_no%></td>
  <td class=xl41 align=left><%=l_invoice_no%></td>
  <td class=xl41 align=left><%=l_invoice_date%></td>
  <td class=xl41 align=left><%=l_partner_name%></td>
  <td class=xl41 x:str><%=l_tax_code_cust%></td>
  <td class=xl41 align=left><%=l_vat_desc%></td>
  <td class=xl47 align=left x:num><span
  style='mso-spacerun:yes'> </span><%=l_net_amt%> </td>
  <td class=xl42 align=right x:num="0">0%</td>
  <td class=xl47 align=left x:num><span style='mso-spacerun:yes'> </span><%=l_vat_tax_amt%> </td>
  <td class=xl63 align=left><%=l_voucherno%><span style='display:none'></span></td>
  <td class=xl65 style='border-top:none'><%=l_partner_deli%></td>
  <td class=xl66 style='border-top:none;border-left:none' x:num ><%=l_net_tr_amt%></td>
  <td class=xl67 style='border-top:none;border-left:none' x:num ><%=l_tr_rate%></td>
  <td class=xl68 style='border-top:none;border-left:none' x:num ><%=l_sum_qty%></td>
 </tr>
 <%  
     }
     l_grand_net_amt += l_tot_net_amt;
     l_grand_vat_amt += l_tot_vat_amt;
     
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl44 align=left width=51 style='width:38pt'>Tổng</td>
  <td class=xl45 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl45 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl46 width=76 style='width:57pt'>&nbsp;</td>
  <td class=xl45 width=204 style='width:153pt'>&nbsp;</td>
  <td class=xl45 width=105 style='width:79pt'>&nbsp;</td>
  <td class=xl45 width=113 style='width:85pt'>&nbsp;</td>
  <td class=xl47 align=left x:num><span
  style='mso-spacerun:yes'> </span><%=l_tot_net_amt%> </td>
  <td class=xl45 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl47 align=left x:num><span style='mso-spacerun:yes'> </span><%=l_tot_vat_amt%> </td>
  <td class=xl64 width=98 style='width:74pt'>&nbsp;</td>
  <td class=xl65 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none' x:num><%=l_tot_tr_amt%></td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none' x:num><%=l_tot_qty%></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td colspan=11 class=xl59 align=left width=1003 style='width:754pt'>3.Hàng
  hoá, dịch vụ chịu thuế suất thuế GTGT 5%</td>
  <td class=xl65 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <% 
     SQL
         = "select a.serial_no, a.invoice_no, to_char(to_date(a.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') invoice_date, c.partner_name, c.tax_code,  " +
             "( select i.item " +
             "from tac_crcaditem i, tac_abitem b " +
             "where i.tac_crca_pk = a.pk " +
             "and i.del_if = 0 " +
             "and i.tac_abitem_pk = b.pk " +
             "and b.del_if = 0 " +
             "and b.item_nm = 'PRODUCT ITEM') desc_vat, ( select i.item " +
             "from tac_crcaditem i, tac_abitem b " +
             "where i.tac_crca_pk = a.pk " +
             "and i.del_if = 0 " +
             "and i.tac_abitem_pk = b.pk " +
             "and b.del_if = 0 " +
             "and b.item_nm = 'NET AMOUNT') net_amt, " +
             "(select sum(d.vat_tax_amt) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) vat_tax_amt, " +
             "a.voucherno || '(' || h.pk || ')' voucherno,  " +
             "( select partner_name from tco_buspartner where pk = a.tco_buspartner_pk_ar and del_if = 0) partner_name_ar, " +
             "(select sum(d.net_tr_amt) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) net_tr_amt, " +
             "a.tr_rate, (select sum(d.qty) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) sum_qty " +
             "from tac_crca a, tco_buspartner c, tac_hgtrh h " +
             "where a.tr_date between '" + p_date_fr + "' and '" + p_date_to + "' " +
             " and a.tco_company_pk = " + p_com_pk +
             "and a.del_if = 0 " +
             "and a.tr_status in ('2', '0') " +
             "and exists (select 'X' from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0 and d.vat_rate in ('05')) " +
             "and a.tco_buspartner_pk = c.pk " +
             "and a.pk = h.tr_table_pk " +
             "and h.tr_tablenm = 'TAC_CRCA' " +
             "and h.del_if = 0 " +
             "and h.tr_status in ('2', '0') " +
             " order by a.serial_no, a.invoice_no";
     DataTable dtItem_2 = new DataTable();
     dtItem_2 = ESysLib.TableReadOpen(SQL);
     for (i = 0; i < dtItem_2.Rows.Count; i++)
     {
         l_serial_no = dtItem_2.Rows[i][0].ToString();
         l_invoice_no = dtItem_2.Rows[i][1].ToString();
         l_invoice_date = dtItem_2.Rows[i][2].ToString();
         l_partner_name = dtItem_2.Rows[i][3].ToString();
         l_tax_code_cust = dtItem_2.Rows[i][4].ToString();
         l_vat_desc = dtItem_2.Rows[i][5].ToString();
         if(dtItem_2.Rows[i][6].ToString() != "")
            l_net_amt = double.Parse(dtItem_2.Rows[i][6].ToString());
         if(dtItem_2.Rows[i][7].ToString() != "")
            l_vat_tax_amt = double.Parse(dtItem_2.Rows[i][7].ToString());         
         l_voucherno = dtItem_2.Rows[i][8].ToString();
         l_partner_deli = dtItem_2.Rows[i][9].ToString();
         if(dtItem_2.Rows[i][10].ToString() != "")
            l_net_tr_amt = double.Parse(dtItem_2.Rows[i][10].ToString());
         if(dtItem_2.Rows[i][11].ToString() != "")
            l_tr_rate = double.Parse(dtItem_2.Rows[i][11].ToString());
         if(dtItem_2.Rows[i][12].ToString() != "")
            l_sum_qty = double.Parse(dtItem_2.Rows[i][12].ToString());
         l_tot_net_amt += l_net_amt;
         l_tot_vat_amt += l_vat_tax_amt;
         l_tot_qty += l_sum_qty;
         l_tot_tr_amt += l_net_tr_amt;                     
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'></td>
  <td class=xl39 width=51 style='width:38pt'><%=i + 1%></td>
  <td class=xl40><%=l_serial_no%></td>
  <td class=xl41><%=l_invoice_no%></td>
  <td class=xl41><%=l_invoice_date%></td>
  <td class=xl41><%=l_partner_name%></td>
  <td class=xl41><%=l_tax_code_cust%></td>
  <td class=xl41><%=l_vat_desc%></td>
  <td class=xl47 align="right"><%=l_net_amt%></td>
  <td class=xl42 align=left><span style='mso-spacerun:yes'> </span>5%</td>
  <td class=xl47 align="right"><%=l_vat_tax_amt%></td>
  <td class=xl63><%=l_voucherno%></td>
  <td class=xl65 style='border-top:none'><%=l_partner_deli%></td>
  <td class=xl66 style='border-top:none;border-left:none'><%=l_net_tr_amt%></td>
  <td class=xl67 style='border-top:none;border-left:none'><%=l_tr_rate%></td>
  <td class=xl68 style='border-top:none;border-left:none'><%=l_sum_qty%></td>
 </tr>
 <%
     }
     l_grand_net_amt += l_tot_net_amt;
     l_grand_vat_amt += l_tot_vat_amt;
     
 %>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl44 align=left width=51 style='width:38pt'>Tổng</td>
  <td class=xl45 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl45 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl46 width=76 style='width:57pt'>&nbsp;</td>
  <td class=xl45 width=204 style='width:153pt'>&nbsp;</td>
  <td class=xl45 width=105 style='width:79pt'>&nbsp;</td>
  <td class=xl45 width=113 style='width:85pt'>&nbsp;</td>
  <td class=xl47 align=left x:num><span style='mso-spacerun:yes'> </span><%=l_tot_net_amt%> </td>
  <td class=xl45 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl47 align=left x:num><span style='mso-spacerun:yes'> </span><%=l_tot_vat_amt%> </td>
  <td class=xl64 width=98 style='width:74pt'>&nbsp;</td>
  <td class=xl65 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none' x:num ><%=l_tot_tr_amt %></td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none' x:num ><%=l_tot_qty%></td>
 </tr>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td colspan=11 class=xl59 align=left width=1003 style='width:754pt'>4. Hàng
  hoá, dịch vụ chịu thuế suất thuế GTGT 10%:</td>
  <td class=xl65 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
<% 
     SQL
         = "select a.serial_no, a.invoice_no, to_char(to_date(a.invoice_date, 'YYYYMMDD'), 'DD/MM/YYYY') invoice_date, c.partner_name, c.tax_code,  " +
             "( select i.item " +
             "from tac_crcaditem i, tac_abitem b " +
             "where i.tac_crca_pk = a.pk " +
             "and i.del_if = 0 " +
             "and i.tac_abitem_pk = b.pk " +
             "and b.del_if = 0 " +
             "and b.item_nm = 'PRODUCT ITEM') desc_vat, ( select i.item " +
             "from tac_crcaditem i, tac_abitem b " +
             "where i.tac_crca_pk = a.pk " +
             "and i.del_if = 0 " +
             "and i.tac_abitem_pk = b.pk " +
             "and b.del_if = 0 " +
             "and b.item_nm = 'NET AMOUNT') net_amt, " +
             "(select sum(d.vat_tax_amt) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) vat_tax_amt, " +
             "a.voucherno || '(' || h.pk || ')' voucherno,  " +
             "( select partner_name from tco_buspartner where pk = a.tco_buspartner_pk_ar and del_if = 0) partner_name_ar, " +
             "(select sum(d.net_tr_amt) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) net_tr_amt, " +
             "a.tr_rate, (select sum(d.qty) from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0) sum_qty " +
             "from tac_crca a, tco_buspartner c, tac_hgtrh h " +
             "where a.tr_date between '" + p_date_fr + "' and '" + p_date_to + "' " +
             " and a.tco_company_pk = " + p_com_pk +
             "and a.del_if = 0 " +
             "and a.tr_status in ('2', '0') " +
             "and exists (select 'X' from tac_crcad d where d.tac_crca_pk = a.pk and d.del_if = 0 and d.vat_rate in ('10')) " +
             "and a.tco_buspartner_pk = c.pk " +
             "and a.pk = h.tr_table_pk " +
             "and h.tr_tablenm = 'TAC_CRCA' " +
             "and h.del_if = 0 " +
             "and h.tr_status in ('2', '0') " +
             " order by a.serial_no, a.invoice_no";
     DataTable dtItem_3 = new DataTable();
     dtItem_3 = ESysLib.TableReadOpen(SQL);
     for (i = 0; i < dtItem_3.Rows.Count; i++)
     {
         l_serial_no = dtItem_3.Rows[i][0].ToString();
         l_invoice_no = dtItem_3.Rows[i][1].ToString();
         l_invoice_date = dtItem_3.Rows[i][2].ToString();
         l_partner_name = dtItem_3.Rows[i][3].ToString();
         l_tax_code_cust = dtItem_3.Rows[i][4].ToString();
         l_vat_desc = dtItem_3.Rows[i][5].ToString();
         if (dtItem_3.Rows[i][6].ToString() != "")
             l_net_amt = double.Parse(dtItem_3.Rows[i][6].ToString());
         if (dtItem_3.Rows[i][7].ToString() != "")
             l_vat_tax_amt = double.Parse(dtItem_3.Rows[i][7].ToString());
         l_voucherno = dtItem_3.Rows[i][8].ToString();
         l_partner_deli = dtItem_3.Rows[i][9].ToString();
         if (dtItem_3.Rows[i][10].ToString() != "")
             l_net_tr_amt = double.Parse(dtItem_3.Rows[i][10].ToString());
         if (dtItem_3.Rows[i][11].ToString() != "")
             l_tr_rate = double.Parse(dtItem_3.Rows[i][11].ToString());
         if (dtItem_3.Rows[i][12].ToString() != "")
             l_sum_qty = double.Parse(dtItem_3.Rows[i][12].ToString());
         l_tot_net_amt += l_net_amt;
         l_tot_vat_amt += l_vat_tax_amt;
         l_tot_qty += l_sum_qty;
         l_tot_tr_amt += l_net_tr_amt;                     
    
%>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl39 align=left width=51 style='width:38pt'><%=i + 1 %></td>
  <td class=xl40 align=left><%=l_serial_no%></td>
  <td class=xl41 align=left><%=l_invoice_no %></td>
  <td class=xl41 align=left><%=l_invoice_date%></td>
  <td class=xl41 align=left><%=l_partner_name%></td>
  <td class=xl41 align=left><%=l_tax_code_cust%></td>
  <td class=xl41 align=left><%=l_vat_desc%><span style='display:none'></span></td>
  <td class=xl47 align=left x:num><span
  style='mso-spacerun:yes'> </span><%=l_net_amt%> </td>
  <td class=xl42 align=right x:num="0.1">10%</td>
  <td class=xl47 align=left x:num><span
  style='mso-spacerun:yes'> </span><%=l_vat_tax_amt%> </td>
  <td class=xl63 align=left><%=l_voucherno %></td>
  <td class=xl65 style='border-top:none'><%=l_partner_deli %></td>
  <td class=xl66 style='border-top:none;border-left:none' x:num ><%=l_net_tr_amt%></td>
  <td class=xl67 style='border-top:none;border-left:none'><%=l_tr_rate%></td>
  <td class=xl68 style='border-top:none;border-left:none'><%=l_sum_qty%></td>
 </tr>
<% 
    }
     l_grand_net_amt += l_tot_net_amt;
     l_grand_vat_amt += l_tot_vat_amt;
    
%>
 <tr height=18 style='height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'>&nbsp;</td>
  <td class=xl44 align=left width=51 style='width:38pt'>Tổng</td>
  <td class=xl45 width=72 style='width:54pt'>&nbsp;</td>
  <td class=xl45 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl46 width=76 style='width:57pt'>&nbsp;</td>
  <td class=xl45 width=204 style='width:153pt'>&nbsp;</td>
  <td class=xl45 width=105 style='width:79pt'>&nbsp;</td>
  <td class=xl45 width=113 style='width:85pt'>&nbsp;</td>
  <td class=xl47 align=left x:num><span
  style='mso-spacerun:yes'> </span><%=l_tot_net_amt%> </td>
  <td class=xl45 width=37 style='width:28pt'>&nbsp;</td>
  <td class=xl47 align=left x:num><span
  style='mso-spacerun:yes'> </span><%=l_tot_vat_amt%> </td>
  <td class=xl64 width=98 style='width:74pt'>&nbsp;</td>
  <td class=xl65 style='border-top:none'>&nbsp;</td>
  <td class=xl66 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl67 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl68 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td colspan=2 class=xl61>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl61>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl24 colspan=4 align=left style='mso-ignore:colspan'>Tổng giá trị
  hàng hoá, dịch vụ bán ra:</td>
  <td class=xl38 align=left x:num><span
  style='mso-spacerun:yes'>                          </span><%=l_grand_net_amt%> </td>
  <td colspan=6 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl24 colspan=4 align=left style='mso-ignore:colspan'>Tổng thuế GTGT
  của hàng hoá, dịch vụ bán ra:</td>
  <td class=xl38 align=left x:num><span
  style='mso-spacerun:yes'>                                </span><%=l_grand_vat_amt%> </td>
  <td colspan=6 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td colspan=2 class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=7 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td colspan=2 class=xl24>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=3 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl27>..............., ngày......... tháng...........
  năm..........</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=3 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl27>NGƯỜI NỘP THUẾ hoặc</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=3 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl27>ĐẠI DIỆN HỢP PHÁP CỦA NGƯỜI NỘP THUẾ</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl24 style='height:12.75pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=3 class=xl24>&nbsp;</td>
  <td colspan=4 class=xl27><span style='mso-spacerun:yes'> </span>Ký tên, đóng
  dấu (ghi rõ họ tên và chức vụ)</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
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
  <td width=98 style='width:74pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
