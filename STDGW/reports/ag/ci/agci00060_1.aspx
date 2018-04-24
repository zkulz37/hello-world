<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("comm");%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%

    string SQL,l_item_code,l_item_group;
    l_item_code = Request["Item_CD"];
    l_item_group = Request["Item_GP"];

    SQL = "select   i.pk, i.item_code, i.item_name, i.weight, i.lot_weight,i.uom , decode(i.use_yn,'Y','Yes','No'),a.AC_CD, a.AC_NM   " +
        " from tco_itemgrp g, tco_stitem i ,acnt.TAC_ABACCTCODE a " +
        " where i.tco_itemgrp_pk = g.pk  " +
        " and i.del_if = 0  " +
        " and a.DEL_IF(+) =0 and a.PK(+) = i.TAC_ABACCTCODE_PK  " +
        " and (('" + l_item_code + "' is null) or (i.item_code like  '%'||upper('" +  l_item_code + "') || '%') or (i.item_name like  '%'||upper('" +  l_item_code + "') || '%'))  " +
        " and g.pk in ( " +
        
        " SELECT pk FROM comm.tco_itemgrp WHERE del_if = 0 CONNECT BY PRIOR pk = p_pk " +
        " START WITH p_pk like DECODE('" + l_item_group + "','','%','" + l_item_group + "') " +

        " OR i.tco_itemgrp_pk LIKE '" + l_item_group + "' ) " +
        " order by i.item_code "  ;
    

    
    DataTable dt = ESysLib.TableReadOpen(SQL);
    
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="agci00060.xls_files/filelist.xml">
<link rel=Edit-Time-Data href="agci00060.xls_files/editdata.mso">
<link rel=OLE-Object-Data href="agci00060.xls_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2008-04-01T02:17:16Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2008-12-27T06:32:08Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .25in .25in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-horizontal-page-align:center;}
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Item Inquiry</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>93</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>4</x:SplitHorizontal>
     <x:TopRowBottomPane>4</x:TopRowBottomPane>
     <x:SplitVertical>1</x:SplitVertical>
     <x:LeftColumnRightPane>1</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Item Inquiry'!$1:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=942 style='border-collapse:
 collapse;table-layout:fixed;width:707pt'>
 <col class=xl25 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl24 width=189 style='mso-width-source:userset;mso-width-alt:6912;
 width:142pt'>
 <col class=xl24 width=217 style='mso-width-source:userset;mso-width-alt:7936;
 width:163pt'>
 <col class=xl24 width=168 style='mso-width-source:userset;mso-width-alt:6144;
 width:126pt'>
 <col class=xl24 width=191 style='mso-width-source:userset;mso-width-alt:6985;
 width:143pt'>
 <col class=xl25 width=64 span=2 style='width:48pt'>
 
 <col class=xl24 width=168 style='mso-width-source:userset;mso-width-alt:6144;
 width:126pt'>
 <col class=xl24 width=191 style='mso-width-source:userset;mso-width-alt:6985;
 width:143pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 width=49 style='height:12.75pt;width:37pt'></td>
  <td class=xl24 width=189 style='width:142pt'></td>
  <td class=xl24 width=217 style='width:163pt'></td>
  <td class=xl24 width=168 style='width:126pt'></td>
  <td class=xl24 width=191 style='width:143pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl24 width=168 style='width:126pt'></td>
  <td class=xl24 width=191 style='width:143pt'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td colspan=7 height=24 class=xl32 style='height:18.0pt'>Item Inquiry</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'>No</td>
  <td class=xl27>Item Code</td>
  <td class=xl27>Item Name</td>
  <td class=xl27  >Weight</td>
  <td class=xl27 >Lot Weight</td>
  <td class=xl27>Unit</td>
  <td class=xl27>Active</td>
  <td class=xl27>Account Code</td>
  <td class=xl27>Account Name</td>
 </tr>
 <%
    for(int i=0; i<dt.Rows.Count;i++)
    {
        if (i<dt.Rows.Count-1)
        {
 %>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl28 style='height:16.5pt' x:num><%=i+1 %></td>
  <td class=xl33><%=dt.Rows[i][1] %></td>
  <td class=xl33><%=dt.Rows[i][2] %></td>
  <td class=xl33 align=right><%=dt.Rows[i][3] %></td>
  <td class=xl33 align=right><%=dt.Rows[i][4] %></td>
  <td class=xl34><%=dt.Rows[i][5] %></td>
  <td class=xl34><%=dt.Rows[i][6] %></td>
  <td class=xl33><%=dt.Rows[i][7] %></td>
  <td class=xl33><%=dt.Rows[i][8] %></td>
 </tr>
 <%}
    else
    {
  %>
 <tr class=xl24 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl29 style='height:16.5pt' x:num><%=i+1 %></td>
  <td class=xl30><%=dt.Rows[i][1] %></td>
  <td class=xl30><%=dt.Rows[i][2] %></td>
  <td class=xl30 align=right ><%=dt.Rows[i][3] %></td>
  <td class=xl30 align=right ><%=dt.Rows[i][4] %></td>
  <td class=xl31><%=dt.Rows[i][5] %></td>
  <td class=xl31><%=dt.Rows[i][6] %></td>
  <td class=xl30><%=dt.Rows[i][7] %></td>
  <td class=xl30><%=dt.Rows[i][8] %></td>
 </tr>
 <%}
 } %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=49 style='width:37pt'></td>
  <td width=189 style='width:142pt'></td>
  <td width=217 style='width:163pt'></td>
  <td width=168 style='width:126pt'></td>
  <td width=191 style='width:143pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=168 style='width:126pt'></td>
  <td width=191 style='width:143pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
