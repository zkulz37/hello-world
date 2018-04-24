<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("imex");%>

<%
    if (Request.QueryString["random"] == null) return;
    
    string SQL, l_company, l_vendor, l_dtst, l_dtet, l_curr, l_decl_no;
    string l_decl_type, l_close_yn, l_status, l_fromdt, l_todt;
    DataTable dt = new DataTable ();
    DataTable dtTT = new DataTable ();
    
    l_company = Request["company_pk"];
    l_vendor = Request["vendor_pk"];
    l_dtst = Request["fromdate"];
    l_dtet = Request["todate"];
    l_curr = Request["curr"]; 
    l_decl_type = Request["decl_type"];
    l_decl_no = Request["decl_no"]; 
    l_close_yn = Request["close_yn"];
    l_status = Request["status"];
    l_fromdt = Request["fromdt"];
    l_todt = Request["todt"];
    
    SQL = " select decode(close_yn,'Y',-1,0), partner_name   ";
    SQL = SQL + "  , decl_type, decl_no, to_char(to_date(decl_date,'yyyymmdd'),'dd/mm/yyyy')";
    SQL = SQL + "  , to_char(to_date(import_date,'yyyymmdd'),'dd/mm/yyyy'), to_char(to_date(close_date,'yyyymmdd'),'')" ;
    SQL = SQL + "  , tr_ccy, ex_rate, tot_im_tax_amt, nvl(ex_rate,0)*nvl(tot_im_tax_amt,0) bookingAmt ";
    SQL = SQL + "  , to_char(to_date(bill.arrival_date,'yyyymmdd'),'dd/mm/yyyy'), PAY_TERM ";
    SQL = SQL + "  , s.code_nm, v.description   ";
    SQL = SQL + " from TIM_DECL_MST v, tco_buspartner v1,tie_bl_mst bill ";
    SQL = SQL + "  ,(select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  ";
    SQL = SQL + "   where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140'  ";
    SQL = SQL + "            and a.del_if=0 and b.del_if=0 order by a.CODE) s ";
    SQL = SQL + " where v.del_if=0 and v1.del_if=0 ";
    SQL = SQL + "      and v.tco_buspartner_pk1 =v1.pk and s.code=v.pay_meth ";
    SQL = SQL + "      and v.tie_bl_mst_pk = bill.pk ";
    SQL = SQL + "      and (v.TCO_BUSPARTNER_PK1 ='" + l_vendor + "' or ' " + l_vendor + "'=' ') ";
    SQL = SQL + "      and decl_date between '" + l_dtst + "' and '" + l_dtet + "'";
    SQL = SQL + "      and (upper('" + l_curr + "')=tr_ccy or upper('" + l_curr + "')='ALL') ";
    SQL = SQL + "      and decl_no like '%' || '" + l_decl_no + "' || '%' ";
    SQL = SQL + "      and (close_yn='" + l_close_yn + "' or upper('" + l_close_yn + "')='ALL') ";
    SQL = SQL + "      and (status='" + l_status + "' or '" + l_status + "'='0') ";
    SQL = SQL + "      and (v.TCO_COMPANY_PK ='" + l_company + "' or '" + l_company + "' ='-1') ";
    SQL = SQL + " order by decl_no, decl_date ";
    
    dt = ESysLib.TableReadOpen(SQL); 
    
    SQL = " select tr_ccy, sum(tot_im_tax_amt) ";
    SQL = SQL + "     , sum(nvl(ex_rate,0)*nvl(tot_im_tax_amt,0)) bookingAmt ";
    SQL = SQL + " from TIM_DECL_MST v, tco_buspartner v1,tie_bl_mst bill ";
    SQL = SQL + "     ,(select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  ";
    SQL = SQL + "      where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140'  ";
    SQL = SQL + "         and a.del_if=0 and b.del_if=0 order by a.CODE) s ";
    SQL = SQL + " where v.del_if=0 and v1.del_if=0 ";
    SQL = SQL + "      and v.tco_buspartner_pk1 =v1.pk and s.code=v.pay_meth ";
    SQL = SQL + "      and v.tie_bl_mst_pk = bill.pk ";
    SQL = SQL + "      and (v.TCO_BUSPARTNER_PK1 ='" + l_vendor + "' or ' " + l_vendor + "'=' ') ";
    SQL = SQL + "      and decl_date between '" + l_dtst + "' and '" + l_dtet + "'";
    SQL = SQL + "      and (upper('" + l_curr + "')=tr_ccy or upper('" + l_curr + "')='ALL') ";
    SQL = SQL + "      and decl_no like '%' || '" + l_decl_no + "' || '%' ";
    SQL = SQL + "      and (close_yn='" + l_close_yn + "' or upper('" + l_close_yn + "')='ALL') ";
    SQL = SQL + "      and (status='" + l_status + "' or '" + l_status + "'='0') ";
    SQL = SQL + "      and (v.TCO_COMPANY_PK ='" + l_company + "' or '" + l_company + "' ='-1') ";
    SQL = SQL + " group by tr_ccy ";
    SQL = SQL + " order by tr_ccy ";
    
    dtTT = ESysLib.TableReadOpen(SQL); 
    
    Response.ContentType = "application/vnd.ms-excel";
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_ephd00020_DeclInq_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_ephd00020_DeclInq_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_ephd00020_DeclInq_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2008-07-12T05:59:22Z</o:LastPrinted>
  <o:Created>2008-07-12T04:05:46Z</o:Created>
  <o:LastSaved>2008-07-12T06:00:06Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.44in .16in .4in .28in;
	mso-header-margin:.32in;
	mso-footer-margin:.4in;
	mso-page-orientation:landscape;}
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
	border:.5pt solid windowtext;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:fuchsia;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:fuchsia;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:lime;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	text-align:center;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl47
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	background:lime;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl53
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	padding-left:12px;
	mso-char-indent-count:1;}
.xl56
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	padding-left:12px;
	mso-char-indent-count:1;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#00CCFF;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:fuchsia;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	padding-left:12px;
	mso-char-indent-count:1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>57</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1045"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1668 style='border-collapse:
 collapse;table-layout:fixed;width:1254pt'>
 <col class=xl41 width=36 style='mso-width-source:userset;mso-width-alt:1316;
 width:27pt'>
 <col class=xl41 width=64 style='mso-width-source:userset;mso-width-alt:2340;
 width:48pt'>
 <col width=246 style='mso-width-source:userset;mso-width-alt:8996;width:185pt'>
 <col width=94 style='mso-width-source:userset;mso-width-alt:3437;width:71pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2852;width:59pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=84 style='mso-width-source:userset;mso-width-alt:3072;width:63pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=109 style='mso-width-source:userset;mso-width-alt:3986;width:82pt'>
 <col width=126 style='mso-width-source:userset;mso-width-alt:4608;width:95pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <col width=115 style='mso-width-source:userset;mso-width-alt:4205;width:86pt'>
 <col width=179 style='mso-width-source:userset;mso-width-alt:6546;width:134pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=117 style='mso-width-source:userset;mso-width-alt:4278;width:88pt'>
 <tr height=24 style='height:18.0pt'>
  <td colspan=16 height=24 class=xl48 width=1668 style='height:18.0pt;
  width:1254pt'><span style='mso-spacerun:yes'> </span>DECLARATION INQUIRY</td>
 </tr>
 <tr class=xl51 height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl49 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl50 style='mso-ignore:colspan'></td>
  <td class=xl52>From:</td>
  <td class=xl59 ><%=l_fromdt %></td>
  <td class=xl52>To:</td>
  <td class=xl59 ><%=l_todt %></td>
  <td colspan=5 class=xl50 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl41 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t128"
   coordsize="21600,21600" o:spt="128" path="m,l21600,,10800,21600xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="custom" o:connectlocs="10800,0;5400,10800;10800,21600;16200,10800"
    textboxrect="5400,0,16200,10800"/>
  </v:shapetype><v:shape id="_x0000_s1027" type="#_x0000_t128" style='position:absolute;
   margin-left:45.75pt;margin-top:12.75pt;width:15pt;height:0;z-index:3'
   fillcolor="window [65]" strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:3;margin-left:60px;
  margin-top:16px;width:22px;height:2px'><img width=22 height=2
  src="rpt_ephd00020_DeclInq_files/image001.gif" v:shapes="_x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=85 style='height:12.75pt;width:64pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1026"
   type="#_x0000_t128" style='position:absolute;margin-left:48.75pt;
   margin-top:12.75pt;width:0;height:0;z-index:2' fillcolor="window [65]"
   strokecolor="windowText [64]" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     9, 120, 3, 0, 9, 87, 3, 0</x:Anchor>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1028" type="#_x0000_t128" style='position:absolute;
   margin-left:48.75pt;margin-top:12.75pt;width:0;height:0;z-index:4'
   fillcolor="window [65]" strokecolor="windowText [64]" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     9, 119, 3, 0, 9, 140, 3, 0</x:Anchor>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1041" type="#_x0000_t128" style='position:absolute;
   margin-left:48.75pt;margin-top:12.75pt;width:2.25pt;height:0;z-index:7'
   fillcolor="window [65]" strokecolor="windowText [64]" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     9, 66, 3, 0, 10, 3, 3, 0</x:Anchor>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1042" type="#_x0000_t128" style='position:absolute;
   margin-left:48.75pt;margin-top:12.75pt;width:.75pt;height:0;z-index:8'
   fillcolor="window [65]" strokecolor="windowText [64]" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     9, 68, 3, 0, 10, 1, 3, 0</x:Anchor>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:64px;margin-top:16px;width:5px;
  height:2px'><img width=5 height=2
  src="rpt_ephd00020_DeclInq_files/image002.gif" v:shapes="_x0000_s1026 _x0000_s1028 _x0000_s1041 _x0000_s1042"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=65 style='height:12.75pt;width:49pt'></td>
   </tr>
  </table>
  </span></td>
  <td></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1038"
   type="#_x0000_t128" style='position:absolute;margin-left:90pt;margin-top:12.75pt;
   width:4.5pt;height:0;z-index:6' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     11, 120, 3, 0, 11, 140, 3, 0</x:Anchor>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:6;margin-left:119px;margin-top:16px;width:8px;
  height:2px'><img width=8 height=2
  src="rpt_ephd00020_DeclInq_files/image003.gif" v:shapes="_x0000_s1038"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=126 style='height:12.75pt;width:95pt'></td>
   </tr>
  </table>
  </span></td>
  <td></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shape id="_x0000_s1025"
   type="#_x0000_t128" style='position:absolute;margin-left:87.75pt;
   margin-top:12.75pt;width:0;height:0;z-index:1' fillcolor="window [65]"
   strokecolor="windowText [64]" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     13, 155, 3, 0, 14, 0, 3, 0</x:Anchor>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1032" type="#_x0000_t128" style='position:absolute;
   margin-left:87.75pt;margin-top:12.75pt;width:0;height:0;z-index:5'
   fillcolor="window [65]" strokecolor="windowText [64]" o:insetmode="auto">
   <x:ClientData ObjectType="Shape">
    <x:Anchor>
     13, 155, 3, 0, 14, 0, 3, 0</x:Anchor>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:116px;margin-top:16px;width:2px;
  height:2px'><img width=2 height=2
  src="rpt_ephd00020_DeclInq_files/image004.gif" v:shapes="_x0000_s1025 _x0000_s1032"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 width=117 style='height:12.75pt;width:88pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl58 height=21 style='mso-height-source:userset;height:15.95pt'>
  <td height=21 class=xl57 style='height:15.95pt'>No.</td>
  <td class=xl57 style='border-left:none'>Close Y/N</td>
  <td class=xl57 style='border-left:none'>Customer Name</td>
  <td class=xl57 style='border-left:none'>Dec. Type</td>
  <td class=xl57 style='border-left:none'>Dec No.</td>
  <td class=xl57 style='border-left:none'>Reg. Date</td>
  <td class=xl57 style='border-left:none'>IM-EX Date</td>
  <td class=xl57 style='border-left:none'>Close Date</td>
  <td class=xl57 style='border-left:none'>Trans. Curr.</td>
  <td class=xl57 style='border-left:none'>Ex. Rate</td>
  <td class=xl57 style='border-left:none'>Trans. Amt</td>
  <td class=xl57 style='border-left:none'>Booking Amt</td>
  <td class=xl57 style='border-left:none'>Shipment Date</td>
  <td class=xl57 style='border-left:none'>Price Terms</td>
  <td class=xl57 style='border-left:none'>Payment Method</td>
  <td class=xl57 style='border-left:none'>Description</td>
 </tr>
 <%
    for(int i=0; i< dt.Rows.Count; i++)
    { 
  %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl67 style='height:15.0pt; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>' x:num><%=i+1 %></td>
  <td class=xl67 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>' ><%=dt.Rows[i][0] %></td>
  <td class=xl68 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>'><%=dt.Rows[i][1] %></td>
  <td class=xl60 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>'><%=dt.Rows[i][2] %></td>
  <td class=xl61 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>'><%=dt.Rows[i][3] %></td>
  <td class=xl62 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>' x:num><%=dt.Rows[i][4] %></td>
  <td class=xl62 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>' x:num><%=dt.Rows[i][5] %></td>
  <td class=xl62 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>' x:num><%=dt.Rows[i][6] %></td>
  <td class=xl63 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>'><%=dt.Rows[i][7] %></td>
  <td class=xl64 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>' x:num><%=dt.Rows[i][8] %> </td>
  <td class=xl65 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>' x:num><%=dt.Rows[i][9] %> </td>
  <td class=xl64 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>' x:num ><%=dt.Rows[i][10] %></td>
  <td class=xl63 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>' x:num><%=dt.Rows[i][11] %></td>
  <td class=xl63 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>'><%=dt.Rows[i][12] %></td>
  <td class=xl65 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>' x:str><%=dt.Rows[i][13] %></td>
  <td class=xl66 style='border-left:none; <% if (i==dt.Rows.Count-1) %> border-bottom:.5pt solid windowtext <%; %>'><%=dt.Rows[i][14] %></td>
 </tr>
 <%
    }
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl41 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td class=xl46></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24>Sub Total</td>
  <td class=xl36 style='border-left:none'>USD</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl37 x:num="103000" x:fmla="=SUM(K5:K6)"><span
  style='mso-spacerun:yes'>         </span>103,000.00 </td>
  <td class=xl47 style='border-left:none' x:num="1638400000"
  x:fmla="=SUM(L5:L6)"><span style='mso-spacerun:yes'>       
  </span>1,638,400,000 </td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <% 
    for(int i=0; i< dtTT.Rows.Count; i++)
    {
  %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24 style='border-top:none'>Sub Total</td>
  <td class=xl36 style='border-top:none;border-left:none'><%=dtTT.Rows[i][0] %></td>
  <td class=xl38>&nbsp;</td>
  <td class=xl37 style='border-top:none' x:num><span
  style='mso-spacerun:yes'>  </span><%=dtTT.Rows[i][1] %></td>
  <td class=xl47 style='border-top:none;border-left:none' x:num><%=dtTT.Rows[i][2] %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <%
 }
  %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl41 style='height:15.0pt;mso-ignore:colspan'></td>
  <td></td>
  <td class=xl35></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl24 style='border-top:none'>Total</td>
  <td class=xl39 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40 style='border-top:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none' x:num
  x:fmla="=SUM(L<%=4+dt.Rows.Count %>:L<%=(4 + dt.Rows.Count + dtTT.Rows.Count) %>)"><span style='mso-spacerun:yes'>    
  </span></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=36 style='width:27pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=246 style='width:185pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=126 style='width:95pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=179 style='width:134pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
