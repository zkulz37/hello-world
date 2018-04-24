
<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("imex");%>

<%
    string l_contract_pk, l_curr, SQL;
    l_contract_pk = Request.QueryString["contract_pk"];
	l_curr = Request.QueryString["curr"];
    
    SQL = "  select CONTR_NO, to_char(to_date(contr_date,'yyyymmdd'),'dd/mm/yyyy') as contr_date   " +
        "        , to_char(to_date(EXP_DATE,'yyyymmdd'),'Mon ddth, YYYY') as exp_date   " +
        "        , to_char(to_date(shipment_date,'yyyymmdd'),'Mon ddth, YYYY') as ship_date   " +
        "        , item_orgin,  s1.code_nm   " +
        "        , vendor.partner_name, vendor.addr1, v.bank_account    " +
        "        , nvl(ship.partner_name,comp.partner_name), nvl(ship.addr1,comp.addr1)  " +
        "        , nvl(ship.fax_no,paid.fax_no), nvl(ship.phone_no,paid.phone_no)  " +
        "        , paid.partner_name  " +
        " from imex.tex_contr_mst v, comm.tco_buspartner ship, tco_company comp  " +
        "        , comm.tco_buspartner vendor, comm.tco_buspartner paid    " +
        "        ,(  select code, code_nm     " +
        "            FROM comm.tco_abcode a, comm.tco_abcodegrp b     " +
        "            WHERE a.tco_abcodegrp_pk = b.pk  AND b.ID = 'ACCR0020'    " +
        "                 AND a.use_if = 1 AND a.del_if = 0 AND b.del_if = 0    " +
        "        ) s1          " +
        " where v.del_if=0    " +
        "    and tco_buspartner_pk1 = ship.pk(+)   " +
        "    and tco_buspartner_pk = vendor.pk    " +
        "    and tco_buspartner_pk2 = paid.pk(+)  " +
        "    and tco_buspartner_pk1 = comp.pk(+)  " +
        "    and upper(pay_term) = upper(s1.code(+))  " +
        "    and v.pk= '" +  l_contract_pk + "' ";

	
    DataTable dtMas= ESysLib.TableReadOpen(SQL);

    SQL  = " select item_code, item_name,  v.unit_cd, v.u_price, v.qty  " +
         "    , nvl(v.u_price,0)* nvl(v.qty,0)  " +
         "  from imex.tex_contr_dtl v, comm.tco_item v2  " +
         "  where v.del_if=0   " +
         "  and v.tco_item_pk=v2.pk  " +
         "  and v.tex_contr_mst_pk ='" +  l_contract_pk + "' ";

	
	DataTable dtDetail= ESysLib.TableReadOpen(SQL);
    //Response.Write(SQL);
    //Response.End();
    Response.ContentType = "application/vnd.ms-excel";
    //Response.ContentType = "application/x-excel";    
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_epac00010_saleContract_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_epac00010_saleContract_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_epac00010_saleContract_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2008-06-09T08:16:58Z</o:LastPrinted>
  <o:Created>2008-06-09T05:54:09Z</o:Created>
  <o:LastSaved>2008-06-09T08:18:29Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.82in .75in .44in 1.09in;
	mso-header-margin:.16in;
	mso-footer-margin:.32in;}
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl27
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl28
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";}
.xl37
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0000_\)\;_\(* \\\(\#\,\#\#0\.0000\\\)\;_\(* \0022-\0022????_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl45
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl48
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl50
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl54
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl64
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>74</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>1</x:ActiveRow>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=792 style='border-collapse:
 collapse;table-layout:fixed;width:594pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl24 width=41 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col class=xl24 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl24 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl24 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl24 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl24 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <tr height=36 style='height:27.0pt'>
  <td colspan=10 height=36 class=xl49 width=664 style='height:27.0pt;
  width:498pt'>SALE CONTRACT</td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl25 height=22 style='height:16.5pt'>
  <td height=22 colspan=12 class=xl25 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=9 class=xl25 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl26><%=dtMas.Rows[0][0]%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=3 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td class=xl25>Date:</td>
  <td class=xl36 align=right ><%=dtMas.Rows[0][1]%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl25 colspan=5 style='height:21.0pt;mso-ignore:colspan'>It
  has been agreed between:</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl28 colspan=3 style='height:18.75pt;mso-ignore:colspan'>THE
  SELLER:</td>
  <td class=xl35 colspan=2 style='mso-ignore:colspan'><%=dtMas.Rows[0][6]%></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan' x:str><%=dtMas.Rows[0][7]%><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25 colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>BANK:</td>
  <td class=xl25 colspan=7 style='mso-ignore:colspan'>HUN NAN COMMERCIAL BANK,
  LTD HONG KONG BRANCH</td>
 </tr>
 <tr class=xl25 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>BENEFICIARY</td>
  <td class=xl25>DRAGON</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>A/C NO</td>
  <td class=xl25><%=dtMas.Rows[0][8]%></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>SWIFT CODE:</td>
  <td class=xl25>HNBKHK</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 class=xl25 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=3 style='mso-ignore:colspan'>Hereinafter called The
  Seller</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl28 colspan=2 style='height:20.25pt;mso-ignore:colspan'>THE
  BUYER:</td>
  <td class=xl25></td>
  <td class=xl35 colspan=2 style='mso-ignore:colspan'><%=dtMas.Rows[0][9]%></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=3 class=xl25 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl25>Add:</td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'><%=dtMas.Rows[0][10]%></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=3 class=xl25 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl25>Tel:</td>
  <td class=xl25><%=dtMas.Rows[0][12]%></td>
  <td class=xl25></td>
  <td class=xl25>Fax:</td>
  <td class=xl25><%=dtMas.Rows[0][11]%></td>
  <td class=xl28></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=3 class=xl25 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=3 style='mso-ignore:colspan'>Hereinafter called The
  Buyer</td>
  <td class=xl25></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 class=xl25 colspan=5 style='height:24.75pt;mso-ignore:colspan'>On
  terms and conditional as follow:</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl25 colspan=5 style='height:22.5pt;mso-ignore:colspan'>COMMODITY
  - QUANTITY - PRICE:</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=5  height=48 class=xl54 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:36.0pt'>COMMODITY</td>
  <td  class=xl54 style='border-bottom:.5pt solid black;border-top:
  none'>QUANTITY</td>
  <td class=xl54 style='border-bottom:.5pt solid black;'>UNIT</td>
  <td class=xl54 style='border-bottom:.5pt solid black;'>UNIT PRICE</td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black;border-bottom:.5pt solid black;'>AMOUNT</td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <%
    for (int i = 0; i < dtDetail.Rows.Count; i++)
{ 
 %> 
 <tr class=xl33 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=5 height=28 class=xl60 style='border-right:.5pt solid black;
  height:21.0pt'><%=dtDetail.Rows[i][1] %></td>
  <td class=xl44 style='border-left:none' x:num><%=dtDetail.Rows[i][3] %></td>
  <td class=xl45 style='border-top:none' x:str><%=dtDetail.Rows[i][2] %></td>
  <td class=xl43 style='border-left:none' x:num><%=dtDetail.Rows[i][4]%> </td>
  <td colspan=2 class=xl52 style='border-left:none' x:num><%=dtDetail.Rows[i][5]  %></td>
  <td class=xl42>&nbsp;</td>
  <td class=xl33></td>
 </tr>
 <%
 }
 %>
 <tr class=xl34 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl37 style='height:28.5pt;border-top:none'>TOTAL:</td>
  <td colspan=3 class=xl63>&nbsp;</td>
  <td class=xl38 style='border-top:none'>&nbsp;</td>
  <td class=xl39 style='border-top:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none'>&nbsp;</td>
  <td class=xl40 style='border-left:none;text-align:right'><%=l_curr %></td>
  <td class=xl41 colspan=2 x:num x:fmla="=SUM(I20:J<%=dtDetail.Rows.Count + 19 %>)"><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl25 colspan=5 style='height:27.0pt;mso-ignore:colspan'>Say
  Total: <%=l_curr %> &nbsp; <!-So tien></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl25 style='height:23.25pt' x:str="QUATITY ">QUATITY<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25>:</td>
  <td class=xl25 colspan=6 style='mso-ignore:colspan'>As per th Buyer's
  requirement, from <%=dtMas.Rows[0][4]%>.</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl25 style='height:23.25pt'>PACKING</td>
  <td class=xl25>:</td>
  <td class=xl25 colspan=4 style='mso-ignore:colspan'>As per the export'
  standard.</td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl25 style='height:23.25pt'>DELIVERY</td>
  <td class=xl25>:</td>
  <td class=xl25 colspan=4 style='mso-ignore:colspan'>:To <%=dtMas.Rows[0][3]%></td>
  <td colspan=6 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl25 style='height:23.25pt'>PAYMENT</td>
  <td class=xl25>:</td>
  <td class=xl25 colspan=8 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span><%=dtMas.Rows[0][5]%>&nbsp; Pay for &nbsp; <%=dtMas.Rows[0][13]%></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=2 class=xl25 style='height:19.5pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>A/C NO:</td>
  <td class=xl25><%=dtMas.Rows[0][8]%></td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl25 colspan=5 style='height:24.0pt;mso-ignore:colspan'>GENEGAL
  CONDITION:</td>
  <td colspan=7 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=47 style='mso-height-source:userset;height:35.25pt'>
  <td colspan=11 height=47 class=xl48 width=728 style='height:35.25pt;
  width:546pt'
  x:str="The two parties undertake to carry out complete and strictly this contract, if there is any difficult,&#10; both parties will disscuss to solve the problem and any change must be confirmed by written form. ">The
  two parties undertake to carry out complete and strictly this contract, if
  there is any difficult,<br>
    <span style='mso-spacerun:yes'> </span>both parties will disscuss to solve
  the problem and any change must be confirmed by written form.<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl34 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl34 colspan=10 style='height:22.5pt;mso-ignore:colspan'
  x:str="This contract is made 04 copies, half of which is for each party having the same value. ">This
  contract is made 04 copies, half of which is for each party having the same
  value.<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl34 colspan=6 style='height:22.5pt;mso-ignore:colspan'>This
  contract effected still <%=dtMas.Rows[0][2]%></td>
  <td colspan=6 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl34 height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=12 class=xl34 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=4 height=28 class=xl47 style='height:21.0pt'>THE SELLER</td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl35>THE BUYER</td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=98 style='width:74pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=91 style='width:68pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=59 style='width:44pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
