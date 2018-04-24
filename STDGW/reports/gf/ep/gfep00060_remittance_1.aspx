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
    string p_date_fr = "";
    string p_date_to = "";
    string p_compk = "";
    string p_credit_acpk = "";
    string p_bank_id = Request["bank_id"];
    p_date_fr = Request["date_fr"];
    p_date_to = Request["date_to"];
    p_compk = Request["compk"];
    p_credit_acpk = Request["credit_acpk"];
    string SQL
	= " select d.pay_famt, ( select n.bedefi_nm from tac_bfbeneficiary n where n.tco_dccust_pk = d.tco_buspartner_pk and n.del_if = 0) bedefi_nm, " + 
        "        ( select n.bedefi_bank_nm from tac_bfbeneficiary n where n.tco_dccust_pk = d.tco_buspartner_pk and n.del_if = 0) bedefi_bank_nm, " +
        "        ( select n.account_no from tac_bfbeneficiary n where n.tco_dccust_pk = d.tco_buspartner_pk and n.del_if = 0) bank_id, " +
        "       '' remark, d.ccy    " +
        " from tfn_eppaytrd d, tfn_eppaytrh h " +
        " where h.tr_date between '" + p_date_fr + "' and '" + p_date_to + "' " +
        " and h.del_if = 0 " +
        " and h.tr_status in ( '1', '2' ) " +
        " and h.tco_company_pk = '" + p_compk + "' " +
        " and h.pk = d.tfn_eppaytrh_pk " +
        " and d.del_if = 0 " +
        " and d.drcr_type = 'D' " +        
        " and ( exists(select 'X' from tfn_eppaytrd d1 where d1.tfn_eppaytrh_pk = h.pk and d1.del_if = 0 and d1.drcr_type = 'C' and d1.tac_abacctcode_pk like '" + p_credit_acpk + "') or '" + p_credit_acpk + "' is null ) " +
        " and exists(select 'Y' from tac_abdepomt b, tfn_eppaytr t where t.tfn_eppaytrh_pk = h.pk and t.del_if = 0 and t.TAC_BFDEPOMT_PK = b.pk and b.del_if = 0 and b.pk like '" + p_bank_id + "') " +
        " order by bank_id " ;
    DataTable dt = ESysLib.TableReadOpen(SQL);
    int i;
    decimal l_tot_amt = 0;
    string l_ccy = "", l_xls_ccy_format = "";
    string l_comp_nm = ""; 
    string l_account_no = "", l_bank_nm = "";
    SQL
	= "select partner_name from comm.tco_company where del_if = 0 and pk = '" + p_compk + "'" ;
	DataTable dtComp = ESysLib.TableReadOpen(SQL);
    if(dtComp.Rows.Count > 0)
    {
        l_comp_nm = dtComp.Rows[0][0].ToString();	
    }
    SQL = "select b.bank_id, c.partner_name from tac_abdepomt b, tco_buspartner c where b.del_if = 0 and b.pk like '" + p_bank_id + "' and b.tco_buspartner_pk = c.pk and c.del_if = 0 " ;
    DataTable dtBank = ESysLib.TableReadOpen(SQL);
    if(dtBank.Rows.Count > 0)
    {
        l_account_no = dtBank.Rows[0][0].ToString();
        l_bank_nm = dtBank.Rows[0][1].ToString();
    }
    string l_den_ngay = p_date_to.Substring(6, 2) + "/" + p_date_to.Substring(4, 2) + "/" + p_date_to.Substring(0, 4);
    
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Remittance%20Tien_files/filelist.xml">
<link rel=Edit-Time-Data href="Remittance%20Tien_files/editdata.mso">
<link rel=OLE-Object-Data href="Remittance%20Tien_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>GENU</o:Author>
  <o:LastAuthor>vanle</o:LastAuthor>
  <o:LastPrinted>2010-06-16T07:58:48Z</o:LastPrinted>
  <o:Created>2010-05-14T02:36:53Z</o:Created>
  <o:LastSaved>2010-06-16T10:48:15Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in 0in 1.0in .25in;
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
	mso-number-format:"Medium Date";}
.xl25
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Remittance</x:Name>
    <x:WorksheetOptions>
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
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8535</x:WindowHeight>
  <x:WindowWidth>11385</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=699 style='border-collapse:
 collapse;table-layout:fixed;width:525pt'>
 <col width=30 style='mso-width-source:userset;mso-width-alt:1097;width:23pt'>
 <col width=136 style='mso-width-source:userset;mso-width-alt:4973;width:102pt'>
 <col width=161 style='mso-width-source:userset;mso-width-alt:5888;width:121pt'>
 <col width=154 style='mso-width-source:userset;mso-width-alt:5632;width:116pt'>
 <col width=115 style='mso-width-source:userset;mso-width-alt:4205;width:86pt'>
 <col width=103 style='mso-width-source:userset;mso-width-alt:3766;width:77pt'>
 <tr height=27 style='height:20.25pt'>
  <td height=27 width=30 style='height:20.25pt;width:23pt'></td>
  <td width=136 style='width:102pt'></td>
  <td class=xl25 colspan=4 width=533 style='mso-ignore:colspan;width:400pt'>APPLICATION
  FOR REMITTANCE / GIẤY CHUYỂN TIỀN</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl24 align=right x:str><%=l_den_ngay%></td>
 </tr>
 <tr class=xl31 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl30 style='height:18.0pt'>STT</td>
  <td class=xl30 style='border-left:none'>SỐ TIỀN</td>
  <td class=xl30 style='border-left:none'>NGƯỜI THỤ HƯỞNG</td>
  <td class=xl30 style='border-left:none'>NGÂN HÀNG</td>
  <td class=xl30 style='border-left:none'>SỐ TK</td>
  <td class=xl30 style='border-left:none'>GHI CHÚ</td>
 </tr>
 <%     
    for(i = 0; i < dt.Rows.Count; i++)
    {
        l_ccy = dt.Rows[i][5].ToString();
        if(dt.Rows[i][0].ToString() != "" )
        {
            l_tot_amt += decimal.Parse(dt.Rows[i][0].ToString());
        }    
        if(l_ccy == "VND")        
            l_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        else
            l_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";            
 %>
 <tr class=xl38 height=41 style='mso-height-source:userset;height:30.75pt'>
  <td height=41 class=xl26 style='height:30.75pt;border-top:none'><%=i + 1 %></td>
  <td class=xl40 style="border-top:none;border-left:none;mso-number-format:<%=l_xls_ccy_format%>;" x:num><%=dt.Rows[i][0] %> </td>
  <td class=xl27 width=161 style='border-top:none;border-left:none;width:121pt'><%=dt.Rows[i][1] %></td>
  <td class=xl27 width=154 style='border-top:none;border-left:none;width:116pt'><%=dt.Rows[i][2] %></td>
  <td class=xl26 style='border-top:none;border-left:none'><%=dt.Rows[i][3] %></td>
  <td class=xl28 style='border-top:none;border-left:none' x:str>-</td>
 </tr>
 <% 
    }
 %>
 <tr class=xl31 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt;border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl34 width=161 style='border-top:none;border-left:none;width:121pt'>&nbsp;</td>
  <td class=xl34 width=154 style='border-top:none;border-left:none;width:116pt'>&nbsp;</td>
  <td class=xl32 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl35 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 style='height:15.75pt'></td>
  <td class=xl37 style="mso-number-format:<%=l_xls_ccy_format%>" x:num><%=l_tot_amt %> </td>
  <td colspan=4 class=xl36 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl36 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 colspan=6 style='height:15.75pt;mso-ignore:colspan'
  x:str="Đề nghị Ngân hàng chuyển tiền cho chúng tôi theo nội dung trên đây, chúng tôi cam kết chịu trách nhiệm cũng ">Đề
  nghị Ngân hàng chuyển tiền cho chúng tôi theo nội dung trên đây, chúng tôi
  cam kết chịu trách nhiệm cũng<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 colspan=5 style='height:15.75pt;mso-ignore:colspan'>cũng
  như tuân theo các qui chế về chuyển tiền của Nhà nước và quy định của Ngân
  hàng.</td>
  <td class=xl36></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl29 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl29 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=3 style='height:15.0pt;mso-ignore:colspan'>Đề
  nghị NH trích số tiền từ TK sau:</td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=3 style='height:15.0pt;mso-ignore:colspan'>ĐƠN
  VỊ CHUYỂN TIỀN: <%=l_comp_nm %></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=3 style='height:15.0pt;mso-ignore:colspan'>SỐ
  TK: <%=l_account_no %></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=2 style='height:15.0pt;mso-ignore:colspan'>SỐ
  BÍ MẬT: </td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl29 colspan=2 style='height:15.0pt;mso-ignore:colspan'>TẠI
  NH: <%=l_bank_nm %></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl29 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=6 class=xl29 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=2 height=21 class=xl39 style='height:15.75pt'>KẾ TOÁN TRƯỞNG</td>
  <td colspan=2 class=xl39>P. TỔNG GIÁM ĐỐC</td>
  <td class=xl36 colspan=2 style='mso-ignore:colspan'>TỔNG GIÁM ĐỐC</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=30 style='width:23pt'></td>
  <td width=136 style='width:102pt'></td>
  <td width=161 style='width:121pt'></td>
  <td width=154 style='width:116pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=103 style='width:77pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
