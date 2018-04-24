<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("imex");%>

<%
    if (Request.QueryString["random"] == null) return;

    string SQL, l_company, l_vendor, l_dtst, l_dtet, l_curr, l_contract;
    string l_order_no, l_invoice_no, l_status, l_fromdt, l_todt;
    DataTable dt = new DataTable ();
    DataTable dtTT = new DataTable ();
    
    l_company = Request["company_pk"];
    l_vendor = Request["vendor_pk"];
    l_dtst = Request["fromdate"];
    l_dtet = Request["todate"];
    l_curr = Request["curr"];
    l_contract = Request["contract_no"];
    l_order_no = Request["order_no"]; 
    l_invoice_no = Request["invoice_no"];
    l_status = Request["status"];
    l_fromdt = Request["fromdt"];
    l_todt = Request["todt"];
    
    SQL = " select  distinct v4.partner_name, v2.contr_no ";
    SQL = SQL + "  , decode(v2.close_yn,'Y','x','') contr_closed, v3.order_no ";
    SQL = SQL + "  , decode(v3.close_yn,'Y','x','') ord_closed ";
    SQL = SQL + "  , v.co_invoice_no, to_char(to_date(v.co_invoice_date,'yyyymmdd'),'dd/mm/yyyy') ";
    SQL = SQL + "  , v.tr_ccy, v.ex_rate, v.tot_amt, nvl(v.ex_rate,0)*nvl(v.tot_amt,0) booking ";
    SQL = SQL + "  , to_char(to_date(v.ship_date,'yyyymmdd'),'dd/mm/yyyy'), t.code_nm, s.code_nm ";
    SQL = SQL + "  from tex_cinv_mst_a v, tex_cinv_mst_b v1 ";
    SQL = SQL + "      , tex_contr_mst v2, tex_order v3, tco_buspartner v4 ";
    SQL = SQL + "      , ( select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  ";
    SQL = SQL + "           where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0140'  ";
    SQL = SQL + "                and a.del_if=0 and b.del_if=0  ";
    SQL = SQL + "         ) s ";
    SQL = SQL + "      , ( select a.CODE,  a.CODE_NM from TCO_ABCODE a, TCO_ABCODEGRP b  ";
    SQL = SQL + "           where TCO_ABCODEGRP_PK=b.pk and b.id='ACCR0020'  ";
    SQL = SQL + "                and a.del_if=0 and b.del_if=0  ";
    SQL = SQL + "         ) t ";
    SQL = SQL + "  where  v.del_if=0 and v1.del_if=0  ";
    SQL = SQL + "       and v2.del_if=0 and v3.del_if(+) =0  ";
    SQL = SQL + "       and v.pk=v1.tex_cinv_mst_a_pk ";
    SQL = SQL + "       and v1.tex_contr_mst_pk=v2.pk ";
    SQL = SQL + "       and v1.tex_order_pk=v3.pk(+) ";
    SQL = SQL + "       and upper(v.pay_meth) = upper(s.code) ";
    SQL = SQL + "       and upper(v.pay_term) = upper(t.code) ";
    SQL = SQL + "       and v.tco_buspartner_pk = v4.pk(+)";
    SQL = SQL + "       and (v.tco_company_pk ='" + l_company + "' or '" + l_company + "'='-1') ";
    SQL = SQL + "       and ( v.tco_buspartner_pk ='" + l_vendor + "' or ' " + l_vendor + "' =' ') ";
    SQL = SQL + "       and v.co_invoice_date between '" + l_dtst + "' and '" + l_dtet + "' ";
    SQL = SQL + "       and (v.tr_ccy='" + l_curr + "' or upper('" + l_curr + "')='ALL') ";
    SQL = SQL + "       and v2.contr_no like '%' || '" + l_contract + "' || '%' ";
    SQL = SQL + "       and v3.order_no(+) like '%' || '" + l_order_no + "'|| '%' ";
    SQL = SQL + "       and v.co_invoice_no like '%' || '" + l_invoice_no + "' || '%' ";
    SQL = SQL + "       and (v.status='" + l_status + "'or " + l_status + "=0) ";

   dt = ESysLib.TableReadOpen(SQL);    
    
    SQL = " select 'Sub total', s.tr_ccy, sum(nvl(s.tot_amt,0)), sum(nvl(booking,0)) ";
    SQL = SQL + "  from ( ";
    SQL = SQL + "      select  distinct v.pk, v.tr_ccy, v.tot_amt, nvl(v.ex_rate,0)*nvl(v.tot_amt,0) booking ";
    SQL = SQL + "      from tex_cinv_mst_a v, tex_cinv_mst_b v1 ";
    SQL = SQL + "          , tex_contr_mst v2, tex_order v3 ";
    SQL = SQL + "  where  v.del_if=0 and v1.del_if=0  ";
    SQL = SQL + "       and v2.del_if=0 and v3.del_if(+) =0  ";
    SQL = SQL + "       and v.pk=v1.tex_cinv_mst_a_pk ";
    SQL = SQL + "       and v1.tex_contr_mst_pk=v2.pk ";
    SQL = SQL + "       and v1.tex_order_pk=v3.pk(+) ";
    SQL = SQL + "       and (v.tco_company_pk ='" + l_company + "' or '" + l_company + "'='-1') ";
    SQL = SQL + "       and ( v.tco_buspartner_pk ='" + l_vendor + "' or ' " + l_vendor + "' =' ') ";
    SQL = SQL + "       and v.co_invoice_date between '" + l_dtst + "' and '" + l_dtet + "' ";
    SQL = SQL + "       and (v.tr_ccy='" + l_curr + "' or upper('" + l_curr + "')='ALL') ";
    SQL = SQL + "       and v2.contr_no like '%' || '" + l_contract + "' || '%' ";
    SQL = SQL + "       and v3.order_no(+) like '%' || '" + l_order_no + "'|| '%' ";
    SQL = SQL + "       and v.co_invoice_no like '%' || '" + l_invoice_no + "' || '%' ";
    SQL = SQL + "       and (v.status='" + l_status + "'or " + l_status + "=0) ";
    SQL = SQL + "            ) s ";
    SQL = SQL + "        group by s.tr_ccy ";
    dtTT = ESysLib.TableReadOpen(SQL);
    
   

   //Response.Write(SQL);
   //Response.End();
    
%>

<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epei00010_inquiry_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epei00010_inquiry_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epei00010_inquiry_files/oledata.mso">
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
  <o:LastPrinted>2008-06-30T09:37:25Z</o:LastPrinted>
  <o:Created>2008-06-30T03:16:45Z</o:Created>
  <o:LastSaved>2008-06-30T09:38:06Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.53in .17in .51in .44in;
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
	text-align:center;}
.xl25
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl27
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl28
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style16;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	mso-number-format:"Short Date";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl61
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	text-align:right;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";}
.xl66
	{mso-style-parent:style0;
	border-top:.5pt solid windowtext;
	text-align:center;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:Scale>67</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>5</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>14</x:ActiveRow>
       <x:ActiveCol>10</x:ActiveCol>
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
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1467 style='border-collapse:
 collapse;table-layout:fixed;width:1101pt'>
 <col class=xl24 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col width=197 style='mso-width-source:userset;mso-width-alt:7204;width:148pt'>
 <col width=101 style='mso-width-source:userset;mso-width-alt:3693;width:76pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col width=85 style='mso-width-source:userset;mso-width-alt:3108;width:64pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=88 style='mso-width-source:userset;mso-width-alt:3218;width:66pt'>
 <col width=80 style='mso-width-source:userset;mso-width-alt:2925;width:60pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=96 style='mso-width-source:userset;mso-width-alt:3510;width:72pt'>
 <col width=112 style='mso-width-source:userset;mso-width-alt:4096;width:84pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3657;width:75pt'>
 <col width=147 style='mso-width-source:userset;mso-width-alt:5376;width:110pt'>
 <col width=115 style='mso-width-source:userset;mso-width-alt:4205;width:86pt'>
 <tr height=24 style='height:18.0pt'>
  <td colspan=15 height=24 class=xl60 width=1403 style='height:18.0pt;
  width:1053pt'>INVOICE INQUIRY</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td></td>
  <td class=xl24></td>
  <td class=xl64 x:str="From ">From<span style='mso-spacerun:yes'> </span></td>
  <td class=xl65 align=right ><%=l_fromdt%></td>
  <td class=xl64>To</td>
  <td class=xl65 align=right ><%=l_todt%></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td></td>
  <td class=xl24></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl38 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl37 style='height:15.75pt'>No.</td>
  <td class=xl37 style='border-left:none'>Customer Name</td>
  <td class=xl37 style='border-left:none'>Contract No.</td>
  <td class=xl37 style='border-left:none'>Close Y/N</td>
  <td class=xl37 style='border-left:none'>Order No.</td>
  <td class=xl37 style='border-left:none'>Close Y/N</td>
  <td class=xl37 style='border-left:none'>Invoice No.</td>
  <td class=xl37 style='border-left:none'>Invoice Date</td>
  <td class=xl37 style='border-left:none'>Trans. Curr.</td>
  <td class=xl37 style='border-left:none'>Ex. Rate</td>
  <td class=xl37 style='border-left:none'>Trans. Amt</td>
  <td class=xl37 style='border-left:none'>Booking Amt</td>
  <td class=xl37 style='border-left:none'>Shipment Date</td>
  <td class=xl37 style='border-left:none'>Price Terms</td>
  <td class=xl37 style='border-left:none'>Payment Method</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
%>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td class=xl39 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=i+1 %></td>
  <td class=xl52 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][0] %></td>
  <td class=xl55 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][1] %></td>
  <td class=xl45 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][2] %></td>
  <td class=xl52 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][3] %></td>
  <td class=xl45 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][4] %></td>
  <td class=xl58 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][5] %></td>
  <td class=xl47 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][6] %></td>
  <td class=xl46 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][7] %></td>
  <td class=xl48 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][8] %></td>
  <td class=xl49 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][9] %></td>
  <td class=xl48 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>' x:num><%=dt.Rows[i][10] %></td>
  <td class=xl50 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>' x:num><%=dt.Rows[i][11] %></td>
  <td class=xl46 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>'><%=dt.Rows[i][12] %></td>
  <td class=xl49 style='border-left:none; <%if (i==dt.Rows.Count-1)%> border-bottom:.5pt solid windowtext;<%; %>' x:str><%=dt.Rows[i][13] %></td>
 </tr>
 <% } %>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl66 style='height:15.0pt'></td>
  <td colspan=2 class=xl66 style='mso-ignore:colspan'></td>
  <td class=xl66></td>
  <td class=xl66></td>
  <td class=xl66></td>
  <td colspan=9 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <%
     for (int i = 0; i < dtTT.Rows.Count; i++)
     {
 %>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl30></td>
  <td class=xl31></td>
  <td class=xl30></td>
  <td class=xl36 style='border-top:.5pt solid windowtext'>Sub Total</td>
  <td class=xl61 style='border-top:.5pt solid windowtext;border-left:none'><%=dtTT.Rows[i][1] %></td>
  <td class=xl62 style='border-top:.5pt solid windowtext'>&nbsp;</td>
  <td class=xl34 style='border-top:.5pt solid windowtext;border-left:none' x:num ><%=dtTT.Rows[i][2] %> </td>
  <td class=xl35 style='border-top:.5pt solid windowtext;border-left:none' x:num ><%=dtTT.Rows[i][3] %></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
  <% } %>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl31 style='height:15.0pt'></td>
  <td class=xl30></td>
  <td class=xl32></td>
  <td class=xl31></td>
  <td class=xl30></td>
  <td class=xl31></td>
  <td class=xl30></td>
  <td class=xl36 style='border-top:none'>Total</td>
  <td class=xl63 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
  <td class=xl36 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none' x:num="2719840000"
  x:fmla="=SUM(L<%=6+dt.Rows.Count%>:L<%=5+dtTT.Rows.Count+dt.Rows.Count%>)"><span style='mso-spacerun:yes'> </span>2,719,840,000 </td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl30></td>
  <td class=xl31></td>
  <td colspan=9 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=17 style='height:12.75pt'>
  <td height=17 class=xl31 style='height:12.75pt'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl30></td>
  <td class=xl31></td>
  <td colspan=9 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=41 style='width:31pt'></td>
  <td width=197 style='width:148pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=115 style='width:86pt'></td>
 </tr>
 <![endif]>
</table>

</body>
<%
Response.End();
 %>
</html>
