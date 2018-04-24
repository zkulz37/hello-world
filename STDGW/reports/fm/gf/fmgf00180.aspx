<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%	
	string SQL = "";
	string ls_std_ym = Request["std_ym"];
	string ls_tco_company_pk = Request["tco_company_pk"];
	string ls_tin_warehouse_pk = Request["tin_warehouse_pk"];
	string ls_tac_abacctcode_pk = Request["tac_abacctcode_pk"];
	string ls_tco_item_pk = Request["tco_item_pk"];
	string ls_book_ccy = "";
	int i;
	decimal l_tot_norm_qty = 0, l_tot_norm_amt = 0, l_tot_to_mat_qty = 0, l_tot_to_mat_amt = 0;
	decimal l_tot_diff_qty = 0, l_tot_diff_amt = 0;
SQL
	= "	select tbl.mat_pk, tbl.mat_code, tbl.mat_name, tbl.mat_ac_cd, " + 
        "		   sum(tbl.norm_qty) norm_qty, SUM(tbl.norm_amt) norm_amt, SUM(tbl.to_mat_qty) to_mat_qty,  " +
        "		   SUM(tbl.to_mat_amt) to_mat_amt, SUM(NVL(tbl.norm_qty, 0) - NVL(tbl.to_mat_qty, 0)) diff_qty, " +
        "		   SUM(NVL(tbl.norm_amt, 0) - NVL(tbl.to_mat_amt, 0)) diff_amt, " +
        "		   w.wh_name " +
        "	from  " +
        "	( " +
        "	select b.item_pk mat_pk, d.item_code mat_code, d.item_name mat_name, e.ac_cd mat_ac_cd,  " +
        "		   sum(c.qty) norm_qty, sum(c.amt) norm_amt, 0 to_mat_qty, 0 to_mat_amt, c.tin_warehouse_pk " +
        "	from tac_stocknorm a, " +
        "		 tac_stocknormd b, " +
        "		 tac_stocktrnorm c, " +
        "		 comm.tco_item d, " +
        "		 tac_abacctcode e " +
        "		 where a.del_if = 0 " +
        "		 and b.del_if = 0 " +
        "		 and c.del_if = 0 " +
        "		 and a.pk = b.TAC_STOCKNORM_PK " +
        "		 and c.TAC_STOCKNORMD_PK = b.pk " +
        "		 and c.TCO_ITEM_PK = d.pk " +
        "		 and c.TAC_ABACCTCODE_PK = e.PK(+) " +
        "		 and SUBSTR(a.PROD_TAKEIN_DT, 1, 6) = '" + ls_std_ym + "' " +
        "		 and decode('" + ls_tin_warehouse_pk + "', 'ALL', 'ALL', c.TIN_WAREHOUSE_PK) = decode('" + ls_tin_warehouse_pk + "', 'ALL', 'ALL', '" + ls_tin_warehouse_pk + "') " +
        "		 and decode('" + ls_tac_abacctcode_pk + "', '', 'ALL', c.TAC_ABACCTCODE_PK)  = decode('" + ls_tac_abacctcode_pk + "', '', 'ALL', '" + ls_tac_abacctcode_pk + "') " +
        "		 and decode('" + ls_tco_item_pk + "', '', 'ALL', c.TCO_ITEM_PK) 			 = decode('" + ls_tco_item_pk + "', '', 'ALL', '" + ls_tco_item_pk + "') " +
        "		 GROUP BY b.item_pk, d.item_code, d.item_name, e.ac_cd, c.tin_warehouse_pk " +
        "	union all " +
        "	select b.tco_item_pk mat_pk, c.item_code mat_code, c.item_name mat_name, d.ac_cd mat_ac_cd,  " +
        "		   0 norm_qty, 0 norm_amt, sum(b.qty) to_mat_qty, sum(b.BOOKS_AMT) to_mat_amt, b.tin_warehouse_pk	        " +
        "	from tac_omcost_pricer a, " +
        "		 tac_omcost_pricerd b, " +
        "		 comm.tco_item c,  " +
        "		 tac_abacctcode d	  " +
        "		 where a.del_if = 0 " +
        "		 and b.del_if = 0 " +
        "		 and c.del_if = 0 " +
        "		 and a.PK = b.TAC_OMCOST_PRICER_PK " +
        "		 and b.CREDIT_ACCTCODE_PK = d.PK " +
        "		 and a.ACCOUNT_SEQ_NO IS NOT NULL " +
		"		 and a.tr_status IN ('2', '0') " +
		"		 and b.entered_yn = 'Y' " +
        "		 and SUBSTR(a.TRANS_DT, 1, 6) = '" + ls_std_ym + "' " +
        "		 and decode('" + ls_tin_warehouse_pk + "', 'ALL', 'ALL', b.tin_warehouse_pk) = decode('" + ls_tin_warehouse_pk + "', 'ALL', 'ALL', '" + ls_tin_warehouse_pk + "') " +
        "		 and decode('" + ls_tac_abacctcode_pk + "', '', 'ALL', b.credit_acctcode_pk) = decode('" + ls_tac_abacctcode_pk + "', '', 'ALL', '" + ls_tac_abacctcode_pk + "') " +
        "		 and decode('" + ls_tco_item_pk + "', '', 'ALL', b.tco_item_pk) = decode('" + ls_tco_item_pk + "', '', 'ALL', '" + ls_tco_item_pk + "') " +
        "	 	 GROUP BY b.tco_item_pk, c.item_code, c.item_name, d.ac_cd, b.tin_warehouse_pk " +
        "	) " +
        "	tbl,	 " +
        "	inv.tin_warehouse w " +
        "	where tbl.tin_warehouse_pk = w.pk(+) " +
        "	GROUP BY mat_pk, mat_code, mat_name, mat_ac_cd, wh_name " +
        "	ORDER BY mat_code asc " ;
	DataTable dtInq = new DataTable();
	dtInq = ESysLib.TableReadOpen(SQL) ;
	SQL = "select a.code from tac_commcode_detail a, tac_commcode_master b where a.del_if = 0 and b.del_if = 0 and a.tac_commcode_master_pk = b.pk and b.id = 'ACBG0040' and a.def_yn = 'Y' ";
	DataTable dtBookCCY = new DataTable();
	dtBookCCY = ESysLib.TableReadOpen(SQL) ;
	SQL
	= "select a.PARTNER_NAME, NVL(a.ADDR1, '') || NVL(a.ADDR2, ' ') || NVL(a.ADDR3, '') address, a.TAX_CODE  " + 
        "from comm.tco_company a " +
        "where a.del_if = 0 " +
        "and a.PK = '" + ls_tco_company_pk + "' " ;
	DataTable dtComp = new DataTable();
	dtComp = ESysLib.TableReadOpen(SQL) ;
%>
		
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Consumption%20Inquiry_files/filelist.xml">
<link rel=Edit-Time-Data href="Consumption%20Inquiry_files/editdata.mso">
<link rel=OLE-Object-Data href="Consumption%20Inquiry_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2009-04-17T04:20:39Z</o:LastPrinted>
  <o:Created>2009-04-17T03:48:28Z</o:Created>
  <o:LastSaved>2009-04-17T04:21:23Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .25in .75in .3in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
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
	text-align:left;}
.xl25
	{mso-style-parent:style0;
	color:blue;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
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
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl35
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	text-align:left;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Consumption Inquiry</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>75</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1289 style='border-collapse:
 collapse;table-layout:fixed;width:968pt'>
 <col width=104 style='mso-width-source:userset;mso-width-alt:3803;width:78pt'>
 <col width=243 style='mso-width-source:userset;mso-width-alt:8886;width:182pt'>
 <col width=93 style='mso-width-source:userset;mso-width-alt:3401;width:70pt'>
 <col width=99 style='mso-width-source:userset;mso-width-alt:3620;width:74pt'>
 <col width=137 style='mso-width-source:userset;mso-width-alt:5010;width:103pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=102 style='mso-width-source:userset;mso-width-alt:3730;width:77pt'>
 <col width=95 style='mso-width-source:userset;mso-width-alt:3474;width:71pt'>
 <col width=89 style='mso-width-source:userset;mso-width-alt:3254;width:67pt'>
 <col width=237 style='mso-width-source:userset;mso-width-alt:8667;width:178pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 width=104 style='height:12.75pt;width:78pt'><%=dtComp.Rows[0][0]%></td>
  <td width=243 style='width:182pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=237 style='width:178pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'><%=dtComp.Rows[0][1]%></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'><%=dtComp.Rows[0][2]%></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 colspan=4 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl25 colspan=2 style='mso-ignore:colspan'>Consumption Inquiry</td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl26 style='height:25.5pt'>Item code</td>
  <td rowspan=2 class=xl27 width=243 style='width:182pt'>Item Name</td>
  <td rowspan=2 class=xl27 width=93 style='width:70pt'>Account code</td>
  <td colspan=2 class=xl30 style='border-right:.5pt solid black;border-left:
  none'>Norm Production (a)</td>
  <td colspan=2 class=xl30 style='border-right:.5pt solid black;border-left:
  none'>T/O Material (b)</td>
  <td colspan=2 class=xl29 style='border-left:none'>Diff(a) - (b)</td>
  <td rowspan=2 class=xl33 width=237 style='width:178pt'>WH Name</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl32 style='height:12.75pt;border-left:none'>Q'ty</td>
  <td class=xl29 style='border-top:none;border-left:none'>Book Amount</td>
  <td class=xl29 style='border-top:none;border-left:none'>Q'ty</td>
  <td class=xl29 style='border-top:none;border-left:none'>Book Amount</td>
  <td class=xl29 style='border-top:none;border-left:none'>Q'ty</td>
  <td class=xl28 style='border-top:none;border-left:none'>Book Amount</td>
 </tr>
 <%
	for(i = 0; i < dtInq.Rows.Count; i++)
	{
		if(dtInq.Rows[i][4].ToString() != "")
			l_tot_norm_qty += Decimal.Parse(dtInq.Rows[i][4].ToString());
		if(dtInq.Rows[i][5].ToString() != "")
			l_tot_norm_amt += Decimal.Parse(dtInq.Rows[i][5].ToString());
		if(dtInq.Rows[i][6].ToString() != "")
			l_tot_to_mat_qty += Decimal.Parse(dtInq.Rows[i][6].ToString());
		if(dtInq.Rows[i][7].ToString() != "")
			l_tot_to_mat_amt += Decimal.Parse(dtInq.Rows[i][7].ToString());
		if(dtInq.Rows[i][8].ToString() != "")
			l_tot_diff_qty += Decimal.Parse(dtInq.Rows[i][8].ToString());
		if(dtInq.Rows[i][9].ToString() != "")
			l_tot_diff_amt += Decimal.Parse(dtInq.Rows[i][9].ToString());			
 %>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl35 style='height:25.5pt;border-top:none'><span
  style='display:none'><%=dtInq.Rows[i][1]%></span></td>
  <td class=xl36 width=243 style='border-top:none;border-left:none;width:182pt'><%=dtInq.Rows[i][2]%></td>
  <td class=xl34 style='border-top:none;border-left:none'><%=dtInq.Rows[i][3]%></td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=dtInq.Rows[i][4]%></td>
  <%
	if(dtBookCCY.Rows[0][0].ToString().Trim() == "VND")
	{
  %>
	  <td class=xl38 style='border-top:none;border-left:none'
	  x:num><%=dtInq.Rows[i][5]%></td>
<%
	}
	else
	{
%>	
	  <td class=xl37 style='border-top:none;border-left:none'
	  x:num><%=dtInq.Rows[i][5]%></td>	
<%	  
	}
%>	
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=dtInq.Rows[i][6]%></td>
  <%
	if(dtBookCCY.Rows[0][0].ToString().Trim() == "VND")
	{
  %>  
		<td class=xl38 style='border-top:none;border-left:none' x:num><%=dtInq.Rows[i][7]%></td>
<%
	}
	else
	{	
%>
		<td class=xl37 style='border-top:none;border-left:none' x:num><%=dtInq.Rows[i][7]%></td>
	<%
	}	
	%>	
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=dtInq.Rows[i][8]%></td>
  <%
	if(dtBookCCY.Rows[0][0].ToString().Trim() == "VND")
	{
  %>    
	<td class=xl38 style='border-top:none;border-left:none' x:num><%=dtInq.Rows[i][9]%></td>
<%
	}
	else
	{
%>	
	<td class=xl37 style='border-top:none;border-left:none' x:num><%=dtInq.Rows[i][9]%></td>
<%
	}
%>	
  <td class=xl35 style='border-top:none;border-left:none'><span
  style='display:none'><%=dtInq.Rows[i][10]%></span></td>
 </tr>
 <%
	}
 %>
<tr height=34 style='height:25.5pt'>
  <td height=34 class=xl35 style='height:25.5pt;border-top:none'><span
  style='display:none'>TOTAL</span></td>
  <td class=xl36 width=243 style='border-top:none;border-left:none;width:182pt'>&nbsp;</td>
  <td class=xl34 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=l_tot_norm_qty%></td>
<%
	if(dtBookCCY.Rows[0][0].ToString().Trim() == "VND")
	{
%>	
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=l_tot_norm_amt%></td>
<%
	}
	else
	{
%> 
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=l_tot_norm_amt%></td>  
<%
	}
%>  
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=l_tot_to_mat_qty%></td>
<%
	if(dtBookCCY.Rows[0][0].ToString().Trim() == "VND")
	{
%>	
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=l_tot_to_mat_amt%></td>
<%
	}
	else
	{
%> 
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=l_tot_to_mat_amt%></td>  
<%
	}
%>    
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=l_tot_diff_qty%></td>
<%
	if(dtBookCCY.Rows[0][0].ToString().Trim() == "VND")
	{
%>	
  <td class=xl38 style='border-top:none;border-left:none' x:num><%=l_tot_diff_amt%></td>
<%
	}
	else
	{
%> 
  <td class=xl37 style='border-top:none;border-left:none' x:num><%=l_tot_diff_amt%></td>    
  <%
	}
  %>
  <td class=xl35 style='border-top:none;border-left:none'><span style='display:none'>&nbsp;</span></td>
 </tr>  
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=104 style='width:78pt'></td>
  <td width=243 style='width:182pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=99 style='width:74pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=95 style='width:71pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=237 style='width:178pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
