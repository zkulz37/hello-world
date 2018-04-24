<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%Response.ContentType = "application/vnd.ms-excel"; %>
<% ESysLib.SetUser("comm");%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

    string SQL, l_item_code, l_item_group;
    l_item_code = Request["Item_CD"];
    l_item_group = Request["Item_GP"];
    DataTable dt, dt1;
    SQL = @" SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
             FROM comm.tco_company
             WHERE del_if = 0 
             AND pk = (SELECT MAX (pk)
                       FROM comm.tco_company
                       WHERE del_if = 0 AND active_yn = 'Y')";
    dt = ESysLib.TableReadOpen(SQL);

    SQL = "select   i.pk,g.grp_nm, i.item_code, i.item_name, i.weight, i.lot_weight,i.uom , decode(i.use_yn,'Y','Yes','No') use_yn,a.AC_CD, a.AC_NM   " +
         " from tco_itemgrp g, tco_stitem i ,acnt.TAC_ABACCTCODE a " +
         " where i.tco_itemgrp_pk = g.pk  " +
         " and i.del_if = 0  " +
         " and a.DEL_IF(+) =0 and a.PK(+) = i.TAC_ABACCTCODE_PK  " +
         " and (('" + l_item_code + "' is null) or (i.item_code like  '%'||upper('" + l_item_code + "') || '%') or (i.item_name like  '%'||upper('" + l_item_code + "') || '%'))  " +
         " and g.pk in ( " +

         " SELECT pk FROM comm.tco_itemgrp WHERE del_if = 0 CONNECT BY PRIOR pk = p_pk " +
         " START WITH p_pk like DECODE('" + l_item_group + "','','%','" + l_item_group + "') " +

         " OR i.tco_itemgrp_pk LIKE '" + l_item_group + "' ) " +
         " order by i.item_code ";
    dt1 = ESysLib.TableReadOpen(SQL);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_agci00060_1_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_agci00060_1_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_agci00060_1_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Server_Test</o:LastAuthor>
  <o:LastPrinted>2011-06-29T08:16:29Z</o:LastPrinted>
  <o:Created>1996-10-14T23:33:28Z</o:Created>
  <o:LastSaved>2011-06-29T08:16:33Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CPage &P of &N";
	margin:.1in .25in .1in .25in;
	mso-header-margin:0in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font8
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Tahoma, sans-serif;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	color:blue;
	font-size:26.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
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
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
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
       <x:ActiveRow>12</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
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
  <x:WindowHeight>9300</x:WindowHeight>
  <x:WindowWidth>15135</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:AcceptLabelsInFormulas/>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1084 style='border-collapse:
 collapse;table-layout:fixed;width:814pt'>
 <col class=xl24 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl24 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl24 width=94 style='mso-width-source:userset;mso-width-alt:3437;
 width:71pt'>
 <col class=xl24 width=188 style='mso-width-source:userset;mso-width-alt:6875;
 width:141pt'>
 <col class=xl24 width=107 span=2 style='mso-width-source:userset;mso-width-alt:
 3913;width:80pt'>
 <col class=xl24 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=139 style='mso-width-source:userset;mso-width-alt:5083;
 width:104pt'>
 <col class=xl24 width=146 style='mso-width-source:userset;mso-width-alt:5339;
 width:110pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=65 style='mso-height-source:userset;height:48.75pt'>
  <td colspan=10 height=65 class=xl32 width=1020 style='height:48.75pt;
  width:766pt'><v:shape id="_x0000_s2051" type="#_x0000_t75" style='position: absolute; margin-left: 1.5pt;
                    margin-top: 1.5pt; width: 78.75pt; height: 51pt; z-index: 1'>
                    <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto"
                        o:title="image001" />
                    <x:clientdata objecttype="Pict">
                        <x:sizewithcells />
                        <x:cf>Bitmap</x:cf>
                    </x:clientdata>
                </v:shape>Item Inquiry</td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=9 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>Print Date:<font
  class="font8"> <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %></font></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl26 style='height:15.0pt'>No</td>
  <td class=xl27>Group</td>
  <td class=xl27>Item Code</td>
  <td class=xl27>Item Name</td>
  <td class=xl27>Weight</td>
  <td class=xl27>Lot Weight</td>
  <td class=xl27>Unit</td>
  <td class=xl27>Active</td>
  <td class=xl27>Account Code</td>
  <td class=xl27>Account Name</td>
  <td class=xl24></td>
 </tr>
 <%
     for (int i = 0; i < dt1.Rows.Count; i++)
     {
  %>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl28 style='height:21.0pt' x:num><%= i + 1 %></td>
  <td class=xl30><%= dt1.Rows[i]["grp_nm"] %></td>
  <td class=xl30><%= dt1.Rows[i]["item_code"] %></td>
  <td class=xl31 width=188 style='width:141pt'><%= dt1.Rows[i]["item_name"]%></td>
  <td class=xl30><%= dt1.Rows[i]["weight"]%></td>
  <td class=xl30><%= dt1.Rows[i]["lot_weight"]%></td>
  <td class=xl29><%= dt1.Rows[i]["uom"]%></td>
  <td class=xl29><%= dt1.Rows[i]["use_yn"]%></td>
  <td class=xl30><%= dt1.Rows[i]["AC_CD"]%></td>
  <td class=xl30><%= dt1.Rows[i]["AC_NM"]%></td>
  <td class=xl24></td>
 </tr>
 <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=43 style='width:32pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=94 style='width:71pt'></td>
  <td width=188 style='width:141pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=139 style='width:104pt'></td>
  <td width=146 style='width:110pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
