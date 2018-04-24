<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("prod");%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string tpr_prodresult_pk = "", weight_yn="";

    weight_yn = Request.QueryString["weight_yn"];
    tpr_prodresult_pk = Request.QueryString["tpr_prodresult_pk"];

    string SQL
     = "SELECT * FROM ( select a.att09 thickness , a.att10 width, a.att08 treatment, a.att07 i_length  " +
         "    , b.att06 tape ,  " +
         "     to_char(  to_number(sale.sf_get_dsbs00010_2 (4, a.tco_item_pk) ) " +
         "       * to_number(sale.sf_get_dsbs00010_2 (5, a.tco_item_pk)) " +
         "       * to_number(a.att07)  " +
         "       * to_number(prod.sf_get_gravity (a.tco_item_pk, NULL)), '999,999.00') item_weight " +
         "    , to_char(to_date(b.prod_date,'yyyymmdd'),'yyyy/MM/DD') prod_date, a.att12 mac_no  " +
         "    , 'BOPP ' || e.grp_nm || ' ' || e.grp_cd|| SALE.sf_get_dsbs00013_6(2, a.TCO_ITEM_PK )  item_class " +
         "    , item_bc , v.FULL_NAME charger" +
         " from prod.tpr_itembcm a, prod.tpr_prodresult b, prod.tpr_prodresultd c  " +
         "       , comm.tco_item d , comm.tco_itemgrp e, hr.thr_employee v " +
         " where a.del_if = 0 and b.del_if(+) = 0  and v.del_if(+) =0  " +
         "    and a.tpr_prodresult_pk = b.pk(+)   " +
         "    and a.tpr_prodresultd_pk = c.pk   " +
         "    and a.TCO_ITEM_PK = d.pk(+)  " +
         "    and d.TCO_ITEMGRP_PK = e.pk  " +
         "    and b.CHARGER_EMP_PK = v.pk(+) " +
         "    and a.tpr_prodresult_pk = '" + tpr_prodresult_pk + "' " +
         "    AND c.att07 IN ('1', '3', '5', '7', '9')  " +
         " order by c.att07) a1 " +
         " Union all " +
         "SELECT * FROM ( select a.att09 thickness , a.att10 width, a.att08 treatment, a.att07 i_length  " +
         "    , b.att06 tape ,  " +
         "     to_char(  to_number(sale.sf_get_dsbs00010_2 (4, a.tco_item_pk) ) " +
         "       * to_number(sale.sf_get_dsbs00010_2 (5, a.tco_item_pk)) " +
         "       * to_number(a.att07)  " +
         "       * to_number(prod.sf_get_gravity (a.tco_item_pk, NULL)), '999,999.00') item_weight " +
         "    , to_char(to_date(b.prod_date,'yyyymmdd'),'yyyy/MM/DD') prod_date, a.att12 mac_no  " +
         "    , 'BOPP ' || e.grp_nm || ' ' || e.grp_cd|| SALE.sf_get_dsbs00013_6(2, a.TCO_ITEM_PK ) item_class " +
         "    , item_bc , v.FULL_NAME charger" +
         " from prod.tpr_itembcm a, prod.tpr_prodresult b, prod.tpr_prodresultd c  " +
         "       , comm.tco_item d , comm.tco_itemgrp e, hr.thr_employee v " +
         " where a.del_if = 0 and b.del_if(+) = 0  and v.del_if(+) =0  " +
         "    and a.tpr_prodresult_pk = b.pk(+)   " +
         "    and a.tpr_prodresultd_pk = c.pk   " +
         "    and a.TCO_ITEM_PK = d.pk(+)  " +
         "    and d.TCO_ITEMGRP_PK = e.pk  " +
         "    and b.CHARGER_EMP_PK = v.pk(+) " +
         "    and a.tpr_prodresult_pk = '" + tpr_prodresult_pk + "' " +
         "    AND c.att07 IN ('2', '4', '6', '8', '10')  " +
         " order by to_number(c.att07) ) b1 ";
         

        
    DataTable dt = ESysLib.TableReadOpen(SQL);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="YC_Barcode_files/filelist.xml">
<link rel=Edit-Time-Data href="YC_Barcode_files/editdata.mso">
<link rel=OLE-Object-Data href="YC_Barcode_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>khk</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2009-03-17T04:18:26Z</o:LastPrinted>
  <o:Created>2008-12-06T06:07:19Z</o:Created>
  <o:LastSaved>2009-03-17T04:20:54Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .1in 0in .17in;
	mso-header-margin:.08in;
	mso-footer-margin:.08in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
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
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl24
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	color:silver;
	font-size:9.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:30.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl31
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:24.0pt;
	font-family:"Code39\(2\:3\)", sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl33
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0_ ";
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl35
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:top;
	background:white;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	background:white;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Barcode</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>270</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>256</x:PaperSizeIndex>
      <x:HorizontalResolution>200</x:HorizontalResolution>
      <x:VerticalResolution>200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>1</x:ActiveCol>
       <x:RangeSelection>$B$14:$D$15</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8925</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>675</x:WindowTopX>
  <x:WindowTopY>825</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=365 style='border-collapse:
 collapse;table-layout:fixed;width:276pt'>
 <col width=18 style='mso-width-source:userset;mso-width-alt:512;width:14pt'>
 <col width=21 style='mso-width-source:userset;mso-width-alt:597;width:16pt'>
 <col width=78 style='mso-width-source:userset;mso-width-alt:2218;width:59pt'>
 <col width=41 style='mso-width-source:userset;mso-width-alt:1166;width:31pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:2901;width:77pt'>
 <col width=105 style='mso-width-source:userset;mso-width-alt:2986;width:79pt'>
 <%
    for(int i = 0; i<dt.Rows.Count;i++)
    {          
%>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 width=18 style='height:18.75pt;width:14pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=105 style='width:79pt'></td>
 </tr>
 <tr class=xl24 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=2 class=xl24 style='height:14.25pt;mso-ignore:colspan'>&nbsp;</td>
  <td colspan=4 rowspan=3 class=xl37 width=326 style='width:246pt'><%=dt.Rows[i]["item_class"]%></td>
 </tr>
 <tr class=xl24 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=2 class=xl24 style='height:14.25pt;mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 colspan=2 class=xl24 style='height:9.75pt;mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=2 class=xl24 style='height:7.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl24 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl29 x:num><%=dt.Rows[i]["thickness"]%></td>
  <td colspan=2 rowspan=2 class=xl29 x:num><%=dt.Rows[i]["width"]%></td>
 </tr>
 <tr class=xl24 height=19 style='height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl24 height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl30><%=dt.Rows[i]["Treatment"]%></td>
  <td colspan=2 rowspan=2 class=xl31 x:num><%=dt.Rows[i]["i_length"]%></td>
 </tr>
 <tr class=xl24 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl24 style='height:21.0pt'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl27 width=140 style='width:106pt' x:num><%=dt.Rows[i]["tape"]%></td>
  <td colspan=2 rowspan=2 class=xl28  ><% if (weight_yn == "Y") Response.Write((string) dt.Rows[i]["item_weight"].ToString()); %></td>
 </tr>
 <tr class=xl24 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=2 class=xl24 style='height:10.5pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl26>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
 </tr>
 <tr class=xl24 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'>&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl35 ><%=dt.Rows[i]["prod_date"]%></td>
  <td colspan=2 rowspan=2 class=xl36><%=dt.Rows[i]["charger"]%></td>
 </tr>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'>&nbsp;</td>
 </tr>
 <tr class=xl24 height=42 style='mso-height-source:userset;height:31.5pt'>
  <td colspan=6 height=42 class=xl32 style='height:31.5pt'>*<%=dt.Rows[i]["item_bc"]%>*</td>
 </tr>
 <tr class=xl24 height=30 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=6 height=30 class=xl33 style='height:22.5pt'><%=dt.Rows[i]["item_bc"]%> </td>
 </tr>
 <tr class=xl24 height=59 style='mso-height-source:userset;height:44.25pt'>
  <td height=59 class=xl24 style='height:44.25pt'>&nbsp;</td>
  <td colspan=5 class=xl34>&nbsp;</td>
 </tr>
 <tr class=xl24 height=46 style='mso-height-source:userset;height:34.5pt'>
  <td colspan=6 height=46 class=xl32 style='height:34.5pt'>*<%=dt.Rows[i]["item_bc"]%>*</td>
 </tr>
 <tr class=xl24 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=6 height=26 class=xl33 style='height:19.5pt'><%=dt.Rows[i]["item_bc"]%> </td>
 </tr>
 <%
 }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=18 style='width:14pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=105 style='width:79pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>