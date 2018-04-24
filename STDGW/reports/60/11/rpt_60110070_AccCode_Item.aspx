<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());%>
<% Response.ContentType = "application/vnd.ms-excel";
   Response.Charset = "utf-8"; 
   Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_company_pk = Request["tco_company_pk"];
    string l_tr_date_fr = Request["tr_date_fr"];
    string l_tr_date_to = Request["tr_date_to"];
    string l_tco_buspartner_pk = Request["tco_buspartner_pk"];
    string l_tr_status = Request["tr_status"];
    string l_tr_type = Request["tr_type"];
    string l_tac_hgtrh_pk = Request["tac_hgtrh_pk"];
    string l_voucherno = Request["voucherno"];
    string l_invoice_no = Request["invoice_no"];
	string SQL="";
	string l_From="";
	string l_To="";

    l_From = l_tr_date_fr.Substring(6, 2) + "-" + l_tr_date_fr.Substring(4, 2) + "-" + l_tr_date_fr.Substring(0,4);
    l_To = l_tr_date_to.Substring(6, 2) + "-" + l_tr_date_to.Substring(4, 2) + "-" + l_tr_date_to.Substring(0, 4);
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Acc_Item_files/filelist.xml">
<link rel=Edit-Time-Data href="Acc_Item_files/editdata.mso">
<link rel=OLE-Object-Data href="Acc_Item_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>KENZIE</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2012-04-21T06:17:10Z</o:LastPrinted>
  <o:Created>2012-04-21T06:16:22Z</o:Created>
  <o:LastSaved>2012-04-21T06:20:31Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-header-data:&R&D&T;
	mso-footer-data:"Page &P of &N";
	margin:.75in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style44
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl67
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl68
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022_-\;_-\@_-";
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style44;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022_-\;_-\@_-";
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022_-\;_-\@_-";}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>T.Khoan</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>18195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=T.Khoan!$5:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl66>

<table x:str border=0 cellpadding=0 cellspacing=0 width=645 style='border-collapse:
 collapse;table-layout:fixed;width:484pt'>
 <col class=xl66 width=136 style='mso-width-source:userset;mso-width-alt:4973; width:102pt'>
 <col class=xl66 width=132 style='mso-width-source:userset;mso-width-alt:4827; width:99pt'>
 <col class=xl66 width=44 style='mso-width-source:userset;mso-width-alt:1609; width:33pt'>
 <col class=xl66 width=109 style='mso-width-source:userset;mso-width-alt:3986; width:82pt'>
 <col class=xl66 width=112 span=2 style='mso-width-source:userset;mso-width-alt: 4096;width:84pt'>
 <col class=xl66 width=93 style='mso-width-source:userset;mso-width-alt:3401; width:70pt'>
 <tr class=xl65 height=19 style='height:14.25pt'>
  <td height=19 class=xl65 colspan=4 width=421 style='height:14.25pt;  mso-ignore:colspan;width:316pt'>TURNOVER REPORT IN GENERAL BY ACCOUNT</td>
  <td class=xl65 width=112 style='width:84pt'></td>
  <td class=xl65 width=112 style='width:84pt'></td>
 </tr>
 <tr class=xl65 height=19 style='height:14.25pt'>
  <td height=19 class=xl65 colspan=5 style='height:14.25pt;mso-ignore:colspan'>(BÁO CÁO DOANH THU BÁN HÀNG TỔNG HỢP THEO TÀI KHOẢN)</td>
  <td class=xl65></td>
 </tr>
 <tr class=xl65 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl65 colspan=3 style='height:17.25pt;mso-ignore:colspan'>FORM <%=l_From%> TO <%=l_To%></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=6 class=xl66 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=2 height=35 class=xl67 style='height:26.25pt'>DESCRIPTION</td>
  <td class=xl67 style='border-left:none'>UNIT</td>
  <td class=xl67 style='border-left:none'>QUANTITIES</td>
  <td class=xl67 style='border-left:none'>VND AMOUNT</td>
  <td class=xl67 style='border-left:none'>F.AMOUNT</td>
 </tr>
 <%
     string l_TD_Acc_Cd = "";
     string l_TD_Qty = "";
     string l_TD_Amt = "";
     string l_TD_FAmt = "";
     if (l_tr_type == "DO" || l_tr_type == "ALL")
     {
         SQL = "SELECT f1.ac_cd||' '||F1.AC_NM||' - '||F1.AC_LNM, sum(nvl(d.qty,0)), sum(nvl(d.net_bk_amt,0)), sum(nvl(d.net_tr_amt,0))  " +
         "  FROM tac_hgtrh h, " +
         "       tac_crca c, " +
         "       tac_crcad d, " +
         "       tac_abacctcode f1 " +
         " WHERE     h.del_if = 0 " +
         "       AND c.del_if = 0 " +
         "       AND d.del_if = 0 " +
         "       AND h.tr_tablenm = 'TAC_CRCA' " +
         "       AND h.tr_table_pk = c.pk " +
         "       AND c.pk = d.tac_crca_pk " +
         "       AND d.tac_abacctcode_pk = f1.pk(+) " +
         "       AND TO_CHAR (h.tr_date, 'yyyymmdd') BETWEEN '" + l_tr_date_fr + "' AND '" + l_tr_date_to + "' " +
         "       AND h.tr_status = '" + l_tr_status + "' " +
        "	       and h.pk like NVL('" + l_tac_hgtrh_pk + "', '%') " +
         "       AND c.tr_type = 'DO' and c.tco_company_pk = '" + l_company_pk + "' " +
         "        group by f1.ac_cd, AC_NM, AC_LNM ";
     
        //Response.Write(SQL);
        //Response.End();
		
		
		DataTable dt = ESysLib.TableReadOpen(SQL); 
		if(dt.Rows.Count > 0)
		{
			l_TD_Acc_Cd = dt.Rows[0][0].ToString();
			l_TD_Qty = dt.Rows[0][1].ToString();
			l_TD_Amt = dt.Rows[0][2].ToString();
			l_TD_FAmt = dt.Rows[0][3].ToString();
		}
     
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl68 colspan=6 style='height:15.0pt;mso-ignore:colspan'><%=l_TD_Acc_Cd%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=3 height=20 class=xl69 style='height:15.0pt'>TOTAL IN DOMESTIC</td>
  <td class=xl70 x:num><%=l_TD_Qty%></td>
  <td class=xl70 x:num><%=l_TD_Amt%></td>
  <td class=xl70 x:num></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'>ITEM CODE</td>
  <td colspan=5 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <%
}
     if (l_tr_type == "DO" || l_tr_type == "ALL")
     {
         SQL = "SELECT i.item_code, " +
            "       i.uom, " +
            "       sum(nvl(d.qty,0)), " +
            "       sum(nvl(d.net_bk_amt,0)), " +
            "       sum(nvl(d.net_tr_amt,0)) " +
            "  FROM tac_hgtrh h, " +
            "       tac_crca c, " +
            "       tac_crcad d, " +
            "       tco_buspartner e, " +
            "       tac_abacctcode f, " +
            "       tac_abacctcode f1, " +
            "       tac_abacctcode f2, " +
            "       tlg_it_item i " +
            " WHERE     h.del_if = 0 " +
            "       AND c.del_if = 0 " +
            "       AND d.del_if = 0 " +
            "       AND i.del_if(+) = 0 " +
            "       AND h.tr_tablenm = 'TAC_CRCA' " +
            "       AND h.tr_table_pk = c.pk " +
            "       AND c.pk = d.tac_crca_pk " +
            "       AND c.tco_buspartner_pk = e.pk(+) " +
            "       AND c.tac_abacctcode_pk = f.pk(+) " +
            "       AND d.tac_abacctcode_pk = f1.pk(+) " +
            "       AND d.tac_abacctcode_pk_vat = f2.pk(+) " +
            "       AND d.tco_item_pk = i.pk(+) " +
            "       AND TO_CHAR (h.tr_date, 'yyyymmdd') BETWEEN '" + l_tr_date_fr + "' AND '" + l_tr_date_to + "' " +
            "       AND (c.tco_buspartner_pk = '" + l_tco_buspartner_pk + "' OR '" + l_tco_buspartner_pk + "' IS NULL) " +
            "       AND h.tr_status = '" + l_tr_status + "' " +
            "       AND c.tr_type = 'DO' and c.tco_company_pk = '" + l_company_pk + "' " +
            "	   and h.pk like NVL('" + l_tac_hgtrh_pk + "', '%') " +
            "       AND (   '%' || UPPER (h.voucherno) || '%' LIKE '%' || UPPER ('" + l_voucherno + "') || '%' OR '" + l_voucherno + "' IS NULL) " +
            "       AND (   '%' || UPPER (c.invoice_no) || '%' LIKE '%' || UPPER ('" + l_invoice_no + "') || '%' OR '" + l_invoice_no + "' IS NULL) " +
            "       group by f1.ac_cd, I.ITEM_CODE, I.UOM order by I.ITEM_CODE ";
     
		
		DataTable dt1 = ESysLib.TableReadOpen(SQL);
		for(int i = 0; i < dt1.Rows.Count ; i++)
		{
 %>
 <tr height=20 style='height:15.0pt'>
  <td colspan='2' height=20 class=xl72 style='height:15.0pt'><%=dt1.Rows[i][0]%></td>
  <td class=xl72><%=dt1.Rows[i][1]%></td>
  <td class=xl73 x:num><%=dt1.Rows[i][2]%></td>
  <td class=xl73 x:num><%=dt1.Rows[i][3]%></td>
  <td class=xl73 x:num></td>
 </tr>
<%}
     }%>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <%
     string l_TO_Acc_Cd = "";
     string l_TO_Qty = "";
     string l_TO_Amt = "";
     string l_TO_FAmt = "";
     if (l_tr_type == "OS" || l_tr_type == "ALL")
     {
         SQL = "SELECT f1.ac_cd||' '||F1.AC_NM||' - '||F1.AC_LNM, sum(nvl(d.qty,0)), sum(nvl(d.net_bk_amt,0)), sum(nvl(d.net_tr_amt,0))  " +
            "  FROM tac_hgtrh h, " +
            "       tac_crca c, " +
            "       tac_crcad d, " +
            "       tac_abacctcode f1 " +
            " WHERE     h.del_if = 0 " +
            "       AND c.del_if = 0 " +
            "       AND d.del_if = 0 " +
            "       AND h.tr_tablenm = 'TAC_CRCA' " +
            "       AND h.tr_table_pk = c.pk " +
            "       AND c.pk = d.tac_crca_pk " +
            "       AND d.tac_abacctcode_pk = f1.pk(+) " +
            "       AND TO_CHAR (h.tr_date, 'yyyymmdd') BETWEEN '" + l_tr_date_fr + "' AND '" + l_tr_date_to + "' " +
            "       AND h.tr_status = '" + l_tr_status + "' " +
           "	       and h.pk like NVL('" + l_tac_hgtrh_pk + "', '%') " +
            "       AND c.tr_type = 'OS' and c.tco_company_pk = '" + l_company_pk + "' " +
            "        group by f1.ac_cd, AC_NM, AC_LNM ";
     
		
		DataTable dt2 = ESysLib.TableReadOpen(SQL); 
		if(dt2.Rows.Count > 0)
		{
			l_TO_Acc_Cd = dt2.Rows[0][0].ToString();
			l_TO_Qty = dt2.Rows[0][1].ToString();
			l_TO_Amt = dt2.Rows[0][2].ToString();
			l_TO_FAmt = dt2.Rows[0][3].ToString();
		}

     
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl68 colspan=6 style='height:15.0pt;mso-ignore:colspan'><%=l_TO_Acc_Cd%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl74 colspan=2 style='height:15.0pt;mso-ignore:colspan'>TOTAL IN OVERSEA</td>
  <td class=xl71>&nbsp;</td>
  <td class=xl70 x:num><%=l_TO_Qty%></td>
  <td class=xl70 x:num><%=l_TO_Amt%></td>
  <td class=xl70 x:num><%=l_TO_FAmt%></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'>ITEM CODE</td>
  <td colspan=5 class=xl66 style='mso-ignore:colspan'></td>
 </tr>
 <%
} 
     //Response.Write("aaaaaaa");
     //Response.End();
     if (l_tr_type == "OS" || l_tr_type == "ALL")
     {
         SQL = "SELECT i.item_code, " +
            "       i.uom, " +
            "       sum(nvl(d.qty,0)), " +
            "       sum(nvl(d.net_bk_amt,0)), " +
            "       sum(nvl(d.net_tr_amt,0)) " +
            "  FROM tac_hgtrh h, " +
            "       tac_crca c, " +
            "       tac_crcad d, " +
            "       tco_buspartner e, " +
            "       tac_abacctcode f, " +
            "       tac_abacctcode f1, " +
            "       tac_abacctcode f2, " +
            "       tlg_it_item i " +
            " WHERE     h.del_if = 0 " +
            "       AND c.del_if = 0 " +
            "       AND d.del_if = 0 " +
            "       AND i.del_if(+) = 0 " +
            "       AND h.tr_tablenm = 'TAC_CRCA' " +
            "       AND h.tr_table_pk = c.pk " +
            "       AND c.pk = d.tac_crca_pk " +
            "       AND c.tco_buspartner_pk = e.pk(+) " +
            "       AND c.tac_abacctcode_pk = f.pk(+) " +
            "       AND d.tac_abacctcode_pk = f1.pk(+) " +
            "       AND d.tac_abacctcode_pk_vat = f2.pk(+) " +
            "       AND d.tco_item_pk = i.pk(+) " +
            "       AND TO_CHAR (h.tr_date, 'yyyymmdd') BETWEEN '" + l_tr_date_fr + "' AND '" + l_tr_date_to + "' " +
            "       AND (c.tco_buspartner_pk = '" + l_tco_buspartner_pk + "' OR '" + l_tco_buspartner_pk + "' IS NULL) " +
            "       AND h.tr_status = '" + l_tr_status + "' " +
            "       AND c.tr_type = 'OS' and c.tco_company_pk = '" + l_company_pk + "' " +
            "	   and h.pk like NVL('" + l_tac_hgtrh_pk + "', '%') " +
            "       AND (   '%' || UPPER (h.voucherno) || '%' LIKE '%' || UPPER ('" + l_voucherno + "') || '%' OR '" + l_voucherno + "' IS NULL) " +
            "       AND (   '%' || UPPER (c.invoice_no) || '%' LIKE '%' || UPPER ('" + l_invoice_no + "') || '%' OR '" + l_invoice_no + "' IS NULL) " +
            "       group by f1.ac_cd, I.ITEM_CODE, I.UOM order by I.ITEM_CODE ";
     
		//Response.Write(SQL);
       // Response.End();
		DataTable dt3 = ESysLib.TableReadOpen(SQL);
		for(int j = 0; j < dt3.Rows.Count ; j++)
		{
 %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan='2' class=xl72 style='height:15.0pt'><%=dt3.Rows[j][0]%></td>
  <td class=xl72><%=dt3.Rows[j][1]%></td>
  <td class=xl73 x:num><%=dt3.Rows[j][2]%></td>
  <td class=xl73 x:num><%=dt3.Rows[j][3]%></td>
  <td class=xl73 x:num><%=dt3.Rows[j][4]%></td>
 </tr>
 <%}
     }%>
 
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl66 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <%
        decimal l_TOT_Qty = 0, l_TOT_Amt = 0, l_TOT_FAmt = 0, l_TD_Qty1 = 0, l_TO_Qty1 = 0, l_TD_Amt1 = 0, l_TO_Amt1 = 0, l_TO_FAmt1 = 0, l_TD_FAmt1=0;
        if (l_TD_Qty.ToString().Trim() != "")
        {
            l_TD_Qty1 = decimal.Parse(l_TD_Qty.ToString());
        }
        else
        {
            l_TD_Qty1 = 0;
        }

        if (l_TO_Qty.ToString().Trim() != "")
        {
            l_TO_Qty1 = decimal.Parse(l_TO_Qty.ToString());
        }
        else
        {
            l_TO_Qty1 = 0;
        }

        if (l_TD_Amt.ToString().Trim() != "")
        {
            l_TD_Amt1 = decimal.Parse(l_TD_Amt.ToString());
        }
        else
        {
            l_TD_Amt1 = 0;
        }

        if (l_TO_Amt.ToString().Trim() != "")
        {
            l_TO_Amt1 = decimal.Parse(l_TO_Amt.ToString());
        }
        else
        {
            l_TO_Amt1 = 0;
        }

        if (l_TD_FAmt.ToString().Trim() != "")
        {
            l_TD_FAmt1 = decimal.Parse(l_TD_FAmt.ToString());
        }
        else
        {
            l_TD_FAmt1 = 0;
        }

        if (l_TO_FAmt.ToString().Trim() != "")
        {
            l_TO_FAmt1 = decimal.Parse(l_TO_FAmt.ToString());
        }
        else
        {
            l_TO_FAmt1 = 0;
        }  
     
        l_TOT_Qty = l_TD_Qty1 + l_TO_Qty1;
        l_TOT_Amt = l_TD_Amt1 + l_TO_Amt1;
        l_TOT_FAmt = l_TO_FAmt1;
  %>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 colspan=3 style='height:15.0pt;mso-ignore:colspan'>GRAND TOTAL DOMESTIC + OVERSEA</td>
  <td class=xl75 x:num><%=l_TOT_Qty%></td>
  <td class=xl75 x:num><%=l_TOT_Amt%></td>
  <td class=xl75 x:num><%=l_TOT_FAmt%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=136 style='width:102pt'></td>
  <td width=132 style='width:99pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=109 style='width:82pt'></td>
  <td width=112 style='width:84pt'></td>
  <td width=112 style='width:84pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>


