<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<% ESysLib.SetUser("imex");%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	
 %>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
string l_dtbFrom,l_dtbTo,l_Vendor_PK,l_txtPONo;
    string l_txtItem,l_cboStatus,l_cboOrganization;
l_dtbFrom			=	Request["dtbFrom"];
l_dtbTo				=	Request["dtbTo"];
l_Vendor_PK			=	Request["txtVendorPK"];
l_txtPONo			=	Request["txtPONo"];
l_txtItem			=	Request["txtItem"];
l_cboStatus			=	Request["cboStatus"];
l_cboOrganization	=	Request["cboOrganization"];

    string SQL;
SQL = " select h.po_no po_no, to_char(to_date(h.po_date,'YYYYMMDD'),'MM/DD/YYYY') po_date, SF_GET_BUSPARTNER_ID(h.tco_buspartner_pk) Vendor, ";
SQL = SQL + "        (SELECT i.item_code from tco_item i where i.pk = d.tco_item_pk) item_code, ";
SQL = SQL + "        (SELECT i.item_name from tco_item i where i.pk = d.tco_item_pk) item_name, ";
SQL = SQL + "        d.item_unit,  to_char(to_date(d.etd_date,'YYYYMMDD'),'MM/DD/YYYY') edt_date, ";
SQL = SQL + "        d.po_qty,  ";
SQL = SQL + "        (select sum(b.ITEM_QTY) from prod.tpr_blcontainerd b where b.TPR_PURORDD_PK = d.pk ) on_the_way,  ";
SQL = SQL + "        (select sum(b.IQCREQ_QTY) from prod.tpr_blcontainerd b where b.TPR_PURORDD_PK = d.pk ) Req_IQC, ";
SQL = SQL + "     d.takein_qty, ";
SQL = SQL + "     d.bl_qty, ";
SQL = SQL + "     d.description ";
SQL = SQL + "     from prod.tpr_purord h, prod.tpr_purordd d, comm.tco_item i ";
SQL = SQL + "        where h.del_if = 0  ";
SQL = SQL + "            and d.del_if =0  ";
SQL = SQL + "            and d.tpr_purord_pk = h.pk ";
SQL = SQL + "            and h.tco_company_pk like decode('" + l_cboOrganization +"','','%','" + l_cboOrganization +"') ";
SQL = SQL + "            and (decode(nvl('" + l_Vendor_PK +"',null),null,1,h.tco_buspartner_pk) = decode(nvl('" + l_Vendor_PK +"',null),null,1,'" + l_Vendor_PK +"')) ";
SQL = SQL + "            and h.po_date between '" + l_dtbFrom +"' and '" + l_dtbTo +"' ";
SQL = SQL + "            and upper(h.po_no) like '%'||upper('" + l_txtPONo +"')||'%' ";
SQL = SQL + "            and i.del_if(+) = 0 ";
SQL = SQL + "            and d.tco_item_pk = i.pk(+) ";
SQL = SQL + "             and ( ('" + l_txtItem +"' is null) or (i.item_code like '%'||upper('" + l_txtItem +"')||'%')  ";
SQL = SQL + "                or (i.item_name like '%'||upper('" + l_txtItem +"')||'%') ";
SQL = SQL + "                ) ";
SQL = SQL + "            and h.po_status like decode('" + l_cboStatus +"','ALL','%','" + l_cboStatus +"') ";
//Response.Write(SQL)   ;
//Response.End();
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="epbp00040_files/filelist.xml">
<link rel=Edit-Time-Data href="epbp00040_files/editdata.mso">
<link rel=OLE-Object-Data href="epbp00040_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:Created>2008-04-04T01:58:54Z</o:Created>
  <o:LastSaved>2008-09-05T02:03:23Z</o:LastSaved>
  <o:Company>vinagenuwin</o:Company>
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
	mso-footer-margin:.5in;}
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
	font-family:Tahoma;
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
	font-family:Tahoma;
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
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	mso-number-format:"\[ENG\]\[$-409\]dd\\-mmm\\-yy\;\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	mso-number-format:"\[ENG\]\[$-409\]dd\\-mmm\\-yy\;\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yy\;\@";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>PO Inquiry</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>5</x:SplitHorizontal>
     <x:TopRowBottomPane>5</x:TopRowBottomPane>
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
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11400</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1217 style='border-collapse:
 collapse;table-layout:fixed;width:915pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=97 style='mso-width-source:userset;mso-width-alt:3547;width:73pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=110 span=2 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col width=43 style='mso-width-source:userset;mso-width-alt:1572;width:32pt'>
 <col width=92 style='mso-width-source:userset;mso-width-alt:3364;width:69pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=81 style='mso-width-source:userset;mso-width-alt:2962;width:61pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=71 style='mso-width-source:userset;mso-width-alt:2596;width:53pt'>
 <col width=191 style='mso-width-source:userset;mso-width-alt:6985;width:143pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 width=50 style='height:12.75pt;width:38pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=191 style='width:143pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=5 style='height:18.0pt;mso-ignore:colspan'></td>
  <td class=xl24>PO Inquiry</td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=14 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>No</td>
  <td class=xl26>PO No</td>
  <td class=xl26>PO Date</td>
  <td class=xl26>Vendor</td>
  <td class=xl26>Item Code</td>
  <td class=xl26>Item Name</td>
  <td class=xl26>Unit</td>
  <td class=xl26>EDT Date</td>
  <td class=xl26>PO Qty</td>
  <td class=xl26>On the way</td>
  <td class=xl26>Req IQC</td>
  <td class=xl26>Take in Qty</td>
  <td class=xl26>Balance</td>
  <td class=xl26>Remark</td>
 </tr>
 <%
	DataTable dt= ESysLib.TableReadOpen(SQL);
	for(int i=0; i< dt.Rows.Count ;i++)
    {
        if (i<  dt.Rows.Count-1)
        {     
%>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'><%= i %>&nbsp;</td>
  <td class=xl28><%= dt.Rows[ i][0]%>&nbsp;</td>
  <td class=xl29><%= dt.Rows[ i][1]%>&nbsp;</td>
  <td class=xl28><%= dt.Rows[ i][2]%>&nbsp;</td>
  <td class=xl28><%= dt.Rows[ i][3]%>&nbsp;</td>
  <td class=xl28><%= dt.Rows[ i][4]%>&nbsp;</td>
  <td class=xl28 style="text-align:center"><%= dt.Rows[ i][5]%></td>
  <td class=xl30 style="text-align:center"><%= dt.Rows[ i][6]%></td>
  <td class=xl31 align=right x:num><%= dt.Rows[ i][7]%></td>
  <td class=xl31 align=right x:num><%= dt.Rows[ i][8]%></td>
  <td class=xl31 align=right x:num><%= dt.Rows[ i][9]%></td>
  <td class=xl31 align=right x:num><%= dt.Rows[ i][10]%></td>
  <td class=xl31 align=right x:num><%= dt.Rows[ i][11]%></td>
  <td class=xl28><%= dt.Rows[ i][12]%>&nbsp;</td>
 </tr>
 <%
	    }
%>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl32 style='height:12.75pt'><%= i %>&nbsp;</td>
  <td class=xl33><%= dt.Rows[ i][0]%>&nbsp;</td>
  <td class=xl34><%= dt.Rows[ i][1]%>&nbsp;</td>
  <td class=xl33><%= dt.Rows[ i][2]%>&nbsp;</td>
  <td class=xl33><%= dt.Rows[ i][3]%>&nbsp;</td>
  <td class=xl33><%= dt.Rows[ i][4]%>&nbsp;</td>
  <td class=xl33 style="text-align:center" ><%= dt.Rows[ i][5]%></td>
  <td class=xl35 style="text-align:center" ><%= dt.Rows[ i][6]%></td>
  <td class=xl36 align=right x:num><%= dt.Rows[ i][7]%></td>
  <td class=xl36 align=right x:num><%= dt.Rows[ i][8]%></td>
  <td class=xl36 align=right x:num><%= dt.Rows[ i][9]%></td>
  <td class=xl36 align=right x:num><%= dt.Rows[ i][10]%></td>
  <td class=xl36 align=right x:num><%= dt.Rows[ i][11]%></td>
  <td class=xl33 ><%= dt.Rows[ i][12]%>&nbsp;</td>
 </tr>
 <%
    }
 %>
  <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=50 style='width:38pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=191 style='width:143pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
