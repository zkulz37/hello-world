<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
    ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_trans = Request["trans"];
   
    string p_company = Request["company"];
    string p_from = Request["from_dt"];
    string p_to = Request["to_dt"];
    string l_taxcode = "";
    string l_compa = "";
    string l_address = "";
    
    string SQL1 = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + p_company + "' ";
    DataTable dt_f = ESysLib.TableReadOpen(SQL1);
    if (dt_f.Rows.Count > 0)
    {
        l_compa = dt_f.Rows[0][0].ToString();
        l_address = dt_f.Rows[0][1].ToString();
        l_taxcode = dt_f.Rows[0][3].ToString();
    }
    
    string SQL = "select b.cust_nm,a.acnt_no,SETL_FRCT_SEQ_NO,a.amt,TO_CHAR (TO_DATE (e.tr_date, 'YYYYMMDD'), 'DD/MM/YYYY' ),e.voucherno, c.ac_cd, " +
        "             d.ac_cd,  e.pk, a.description " +
        "            ,trd_seq_no,f.dpo_bank_acc,f.cnte ,g.dpo_bank_acc,g.cnte " +
        "            from tac_seccashtrand a, AAA01M00@tycbv b,cwd01c00@tycbv f ,cwd01c00@tycbv g,tac_abacctcode c , tac_abacctcode d, tac_hgtrh e " +
        "           where a.del_if = 0 " +
        "                 and a.SETL_DT between   '" +p_from+ "' and  '" + p_to + "'" +
		"                 and  a.acnt_no = b.acnt_no " +
        "                 and a.dr_bank_acnt_no = f.dpo_bank_acc(+) " +
        "                 and a.cr_bank_acnt_no = g.dpo_bank_acc(+)  " +
        "                 and c.del_if = 0 " +
        "                 and a.tac_abacctcode_pk_dr = c.pk " +
        "                 and d.del_if = 0 " +
        "                 and a.tac_abacctcode_pk_cr = d.pk " +
        "                 and e.del_if(+)=0 " +
        "                 and a.pk = e.tr_table_pk(+) " +
        "                 and e.tr_tablenm(+) = 'TAC_SECCASHTRAN' " +
        "                 and e.tr_status(+) <> 3   order by  a.description " +
        "            ";
  // Response.Write(SQL);
   //  Response.End();
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data!!");
        Response.End();
    }

    string l_book_ccy = "";
    String p_xls_ccy_format = "";
    String p_xls_ccy_format_usd = "";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="aaaaaaaaaa_files/filelist.xml">
<link rel=Edit-Time-Data href="aaaaaaaaaa_files/editdata.mso">
<link rel=OLE-Object-Data href="aaaaaaaaaa_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:LastAuthor>Mr Long</o:LastAuthor>
  <o:Created>2009-01-07T08:14:43Z</o:Created>
  <o:LastSaved>2010-05-10T09:32:36Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
 <o:OfficeDocumentSettings>
  <o:Colors>
   <o:Color>
    <o:Index>39</o:Index>
    <o:RGB>#E3E3E3</o:RGB>
   </o:Color>
  </o:Colors>
 </o:OfficeDocumentSettings>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .15in .19in .5in;
	mso-header-margin:0in;
	mso-footer-margin:.19in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style43
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
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS Sans Serif";
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
	color:black;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"MS Sans Serif";
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
.xl65
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:11.05pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:14.05pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:9.95pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style0;
	font-size:8.95pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style0;
	font-size:9.95pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style43;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl77
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl78
	{mso-style-parent:style0;
	font-size:8.15pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\0022\/\0022mm\0022\/\0022yyyy";
	text-align:center;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>ReportGLAcctDaily.rpt</x:Name>
    <x:WorksheetOptions>
     <x:StandardWidth>2925</x:StandardWidth>
     <x:Print>
      <x:BlackAndWhite/>
      <x:PrintErrors>NA</x:PrintErrors>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>16</x:SplitHorizontal>
     <x:TopRowBottomPane>16</x:TopRowBottomPane>
     <x:SplitVertical>2</x:SplitVertical>
     <x:LeftColumnRightPane>2</x:LeftColumnRightPane>
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
       <x:ActiveRow>32</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>4140</x:WindowHeight>
  <x:WindowWidth>7485</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=ReportGLAcctDaily.rpt!$A$16:$J$7208</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl67>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1418 style='border-collapse:
 collapse;table-layout:fixed;width:1064pt'>
 <col class=xl67 width=80 span=3 style='width:60pt'>
 <col class=xl67 width=575 style='mso-width-source:userset;mso-width-alt:21028;
 width:431pt'>
 <col class=xl67 width=80 span=2 style='width:60pt'>
 <col class=xl67 width=138 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <col class=xl67 width=80 span=2 style='width:60pt'>
 <col class=xl67 width=145 style='mso-width-source:userset;mso-width-alt:5302;
 width:109pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl67 width=80 style='height:12.75pt;width:60pt'></td>
  <td class=xl67 width=80 style='width:60pt'></td>
  <td class=xl67 width=80 style='width:60pt'></td>
  <td class=xl67 width=575 style='width:431pt'></td>
  <td class=xl67 width=80 style='width:60pt'></td>
  <td class=xl67 width=80 style='width:60pt'></td>
  <td class=xl67 width=138 style='width:104pt'></td>
  <td class=xl67 width=80 style='width:60pt'></td>
  <td class=xl67 width=80 style='width:60pt'></td>
  <td class=xl67 width=145 style='width:109pt'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 class=xl66 colspan=3 style='height:14.25pt;mso-ignore:colspan'><%=l_compa%></td>
  <td colspan=7 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl67 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl68 colspan=2 style='height:12.75pt;mso-ignore:colspan'><%=l_address%></td>
  <td colspan=8 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl68 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Email:
  info@cbv.vn</td>
  <td colspan=8 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl67 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl67 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=5 class=xl67 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl69>Sổ nhật ký chung</td>
  <td colspan=4 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl67 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl67 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=5 class=xl67 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td colspan=4 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl67 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=10 class=xl67 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl71 style='height:12.75pt'>Chứng từ</td>
  <td colspan=5 class=xl67 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl72 align=center style='mso-ignore:colspan'>Tài khoản</td>
  <td class=xl67></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl73 style='height:12.75pt'>Ngày</td>
  <td colspan=9 class=xl67 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl73 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$16:$J$7208" style='height:12.75pt'></td>
  <td class=xl73 id="_x0000_s1026" x:autofilter="all"></td>
  <td class=xl73 id="_x0000_s1027" x:autofilter="all">TKKH</td>
  <td class=xl74 id="_x0000_s1028" x:autofilter="all">Diễn giải</td>
  <td class=xl73 id="_x0000_s1029" x:autofilter="all"></td>
  <td class=xl73 id="_x0000_s1030" x:autofilter="all"></td>
  <td class=xl75 id="_x0000_s1031" x:autofilter="all">Nợ</td>
  <td class=xl73 id="_x0000_s1032" x:autofilter="all"></td>
  <td class=xl75 id="_x0000_s1033" x:autofilter="all">Có</td>
  <td class=xl75 id="_x0000_s1034" x:autofilter="all">Số tiền</td>
 </tr>
 <%
     for (int i = 0; i < dt.Rows.Count; i++)
     {
      %>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl78 style='height:15.75pt' ><%=dt.Rows[i][4]%></td>
  <td class=xl67></td>
  <td class=xl65></td>
  <td class=xl65><%=dt.Rows[i][9]%></td>
  <td class=xl67></td>
  <td class=xl67></td>
  <td class=xl65><%=dt.Rows[i][6]%></td>
  <td class=xl67></td>
  <td class=xl65><%=dt.Rows[i][7]%></td>
  <td class=xl76 align=right style="mso-number-format:'<%= p_xls_ccy_format %>'" x:num><%=dt.Rows[i][3]%></td>
 </tr>
 <%} %>
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=575 style='width:431pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=80 style='width:60pt'></td>
  <td width=145 style='width:109pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
