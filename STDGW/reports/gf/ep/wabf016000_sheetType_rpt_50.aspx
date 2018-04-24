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

string iBankPk	= Request["bankPK"];
string iPKArr	= Request["pk"];

string oBankUsd = "";
string oBankVnd = "";
string oMoneyAmt = "";
string oMoneyStr ="";
string oTCO_DCCUSTM_PK ="";
string oRemark ="";
string oCurrType = "";
string oDate = "";

string oBankAccount ="";
string oBenName = "";
string oBenBank = "";
string oBenBranch = "";

string oCompanyName = "";
string oCompanyAddr = "";
string oCompanyTel = "";
int oCompanyBAccount = 0;

	int oCountCustomer = 0;
	string SQL = "";
	SQL = "SELECT ACCOUNT_NO FROM TAC_ABDEPOMT WHERE PK = '" + iBankPk + "'" ;
	DataTable rs = new DataTable();
	rs = ESysLib.TableReadOpen(SQL);
	if(rs.Rows.Count > 0)
		oCompanyBAccount = rs.Rows.Count ;
 SQL
	= "SELECT PARTNER_LNAME, ADDR1, ADDR2, ADDR3, PHONE_NO FROM COMM.TCO_COMPANY WHERE DEL_IF = 0 AND ACTIVE_YN = 'Y'  AND PK IN  " + 
        " (SELECT TCO_COMPANY_PK FROM TAC_ABDEPOMT WHERE PK = ' " + iBankPk + " ') " ;
    DataTable rs1 = new DataTable();
	rs1 = ESysLib.TableReadOpen(SQL);		
	if(rs1.Rows.Count > 0)
	{
		if(rs1.Rows[0][0].ToString().Trim() != "")
			oCompanyName = rs1.Rows[0][0].ToString().Trim();
		else
			oCompanyName = "";
		if(rs1.Rows[0][1].ToString().Trim() != "")	
			oCompanyAddr = rs1.Rows[0][1].ToString().Trim();
		else
			oCompanyAddr = "";
		if(rs1.Rows[0][4].ToString().Trim() != "")	
			oCompanyTel  = rs1.Rows[0][4].ToString().Trim();
		else
			oCompanyTel = "";
	}

 SQL
	= "select tco_buspartner_pk, sum(bank_usd) usd, sum (bank_vnd) vnd  " + 
        " from  " +
        " (select  " +
        " b.tco_buspartner_pk  " +
        " , decode(a.pay_type, '03', decode(a.tr_ccy, 'USD', sum(b.pay_famt), decode(c.ven_trade_type,'IM', sum(b.pay_amt),'')), '04', decode(a.tr_ccy, 'USD', sum(b.pay_famt), decode(c.ven_trade_type, 'IM', sum(b.pay_amt),'')), '')  bank_usd  " +
        " , decode(a.pay_type, '03', decode(a.tr_ccy, 'USD', '', decode(c.ven_trade_type, 'IM', '', sum(b.pay_famt) )), '04', decode(a.tr_ccy, 'USD','', decode(c.ven_trade_type, 'IM', '',  sum(b.pay_famt))), '')  bank_vnd  " +
        " from tfn_eppaytr a, comm.tco_buspartner c, tfn_eppaytrd b, tfn_eppaytrh h " +
        "	where a.del_if = 0 " +
        "	and b.del_if = 0  " +
		"	and h.del_if = 0  " +
        " and a.pk in ('" + iPKArr + "') " +
        "	and a.tfn_eppay_pk = b.tfn_eppay_pk	 " +
        " and b.tco_buspartner_pk = c.pk  " +
		" and a.tfn_eppaytrh_pk = h.pk  " +
        " group by b.tco_buspartner_pk, a.tr_ccy, b.pay_famt, a.pay_type, c.ven_trade_type )  " +
        " group by tco_buspartner_pk  " ;
	DateTime l_today = new DateTime() ;
	l_today = DateTime.Today;
	int oMonth	= l_today.Month;
	int oDay	= l_today.Day;
	int oYear	= l_today.Year;
	string sMonth = "", sDay = "";
	if(oMonth <= 9)
		sMonth = "0" + oMonth.ToString();
	if(oDay <= 9)
		sDay = "0" + oDay.ToString();
	string SQL_COUNT = "";
	SQL_COUNT
	= "SELECT COUNT( DISTINCT D.TCO_BUSPARTNER_PK) NumCust FROM TFN_EPPAYTR A, TFN_EPPAYTRD D  " + 
        "WHERE A.DEL_IF = 0  " +
        "AND D.DEL_IF = 0 " +
        "AND A.TFN_EPPAY_PK = D.TFN_EPPAY_PK " +
        "AND A.PK IN ('" + iPKArr + "') " ;
	DataTable rs_count = new DataTable();
	rs_count	= ESysLib.TableReadOpen(SQL_COUNT);
	if(rs_count.Rows.Count > 0)
		oCountCustomer = int.Parse(rs_count.Rows[0][0].ToString());
int oNumberPrint = oCountCustomer -1 ;
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Van_files/filelist.xml">
<link rel=Edit-Time-Data href="Van_files/editdata.mso">
<link rel=OLE-Object-Data href="Van_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2007-08-25T07:43:18Z</o:LastPrinted>
  <o:Created>2007-06-25T02:56:20Z</o:Created>
  <o:LastSaved>2010-01-07T09:57:06Z</o:LastSaved>
  <o:Company>VinaGenuWin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in 0in 0in .2in;
	mso-header-margin:0in;
	mso-footer-margin:0in;}
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
	font-size:8.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:Standard;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:Standard;}
.xl34
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:Standard;
	text-align:left;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	text-align:left;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
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
<x:TopRowVisible>12</x:TopRowVisible>
     <x:LeftColumnVisible>1</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>17</x:ActiveCol>
       <x:RangeSelection>$R$14:$T$14</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
<% int k; for(k = 1; k <= oNumberPrint; k++) { %><x:RowBreak>
       <x:Row><%= k * 37 %></x:Row>
      </x:RowBreak><% } %>
       </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=684 style='border-collapse:
 collapse;table-layout:fixed;width:515pt'>
 <%
 DataTable rs2 = new DataTable();
 rs2 = ESysLib.TableReadOpen(SQL);
 int j = 0;
 string SQL_BEN = "";
 while(j < rs2.Rows.Count)
 {
	if(rs2.Rows[j][1].ToString().Trim() != "")
		oBankUsd = rs2.Rows[j][1].ToString();
	else
		oBankUsd = "";	
	if(rs2.Rows[j][2].ToString().Trim() != "")		
		oBankVnd = rs2.Rows[j][2].ToString().Trim();
	else
		oBankVnd = "";		
	if(rs2.Rows[j][0].ToString().Trim() != "")				
		oTCO_DCCUSTM_PK = rs2.Rows[j][0].ToString().Trim();
	else
		oTCO_DCCUSTM_PK = "";
		
 SQL_BEN
	= "SELECT BEDEFI_NM, BEDEFI_BANK_NM, BRANCH, ACCOUNT_NO FROM TAC_BFBENEFICIARY WHERE DEL_IF = 0 AND TCO_DCCUST_PK = '" + oTCO_DCCUSTM_PK + "' " ;
	DataTable rs_ben = new DataTable();
	rs_ben	= ESysLib.TableReadOpen(SQL_BEN);	
	if(rs_ben.Rows.Count > 0)
	{
		if(rs_ben.Rows[0][0].ToString().Trim() != "")
			oBenName		= rs_ben.Rows[0][0].ToString();
		else
			oBenName		= "";
		if(rs_ben.Rows[0][1].ToString().Trim() != "")	
			oBenBank		= rs_ben.Rows[0][1].ToString();
		if(rs_ben.Rows[0][2].ToString().Trim() != "")	
			oBenBranch		= rs_ben.Rows[0][2].ToString().Trim();
		else	
			oBenBranch		= "";
		if(rs_ben.Rows[0][3].ToString().Trim() != "")				
			oBankAccount	= rs_ben.Rows[0][3].ToString().Trim() ;
		else
			oBankAccount	= "";
	}
	if(oBankUsd != "") 
	{
		oCurrType="USD";
		oMoneyAmt = oBankUsd;
		oMoneyStr = CommondLib.Num2VNText(oBankUsd, oCurrType) ;
	}				
	else 
	{
		oCurrType="VND";
		oMoneyAmt = oBankVnd;
		oMoneyStr = CommondLib.Num2VNText(oBankUsd, oCurrType) ;
	}
 %>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:438'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=12 style='mso-width-source:userset;mso-width-alt:438;width:9pt'>
 <col width=25 style='mso-width-source:userset;mso-width-alt:914;width:19pt'>
 <col width=18 style='mso-width-source:userset;mso-width-alt:658;width:14pt'>
 <col width=25 style='mso-width-source:userset;mso-width-alt:914;width:19pt'>
 <col width=55 style='mso-width-source:userset;mso-width-alt:2011;width:41pt'>
 <col width=19 style='mso-width-source:userset;mso-width-alt:694;width:14pt'>
 <col width=22 style='mso-width-source:userset;mso-width-alt:804;width:17pt'>
 <col width=37 style='mso-width-source:userset;mso-width-alt:1353;width:28pt'>
 <col width=25 style='mso-width-source:userset;mso-width-alt:914;width:19pt'>
 <col width=58 style='mso-width-source:userset;mso-width-alt:2121;width:44pt'>
 <col width=12 style='mso-width-source:userset;mso-width-alt:438;width:9pt'>
 <col width=20 style='mso-width-source:userset;mso-width-alt:731;width:15pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=19 style='mso-width-source:userset;mso-width-alt:694;width:14pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=25 style='mso-width-source:userset;mso-width-alt:914;width:19pt'>
 <col width=33 style='mso-width-source:userset;mso-width-alt:1206;width:25pt'>
 <col width=56 style='mso-width-source:userset;mso-width-alt:2048;width:42pt'>
 <col width=25 style='mso-width-source:userset;mso-width-alt:914;width:19pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:877;width:18pt'>
 <col width=25 span=5 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col width=23 style='mso-width-source:userset;mso-width-alt:841;width:17pt'>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 width=0 style='height:9.95pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=19 style='width:14pt'></td>
  <td class=xl25 width=65 style='width:49pt'></td>
  <td class=xl25 width=25 style='width:19pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=56 style='width:42pt'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.95pt'>
  <td height=13 style='height:9.95pt'></td>
  <td colspan=3 rowspan=2 class=xl26></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 style='height:8.25pt'></td>
  <td colspan=19 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=19 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=11 rowspan=2 class=xl27 x:str=""></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 style='height:22.5pt'></td>
  <td></td>
  <td class=xl28></td>
  <td colspan=17 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 style='height:3.0pt'></td>
  <td></td>
  <td colspan=8 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=19 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=19 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=19 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 style='height:7.5pt'></td>
  <td colspan=19 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
  <td colspan=5 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl37><%= sDay%>/<%= sMonth %>/<%= oYear %></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=19 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=61 style='mso-height-source:userset;height:45.75pt'>
  <td height=61 style='height:45.75pt'></td>
  <td colspan=18 class=xl38 width=628 style='width:473pt'></td>
  <td></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 style='height:18.0pt'></td>
  <td class=xl30></td>
  <td colspan=18 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 style='height:29.25pt'></td>
  <td class=xl31></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=7 class=xl39 <% if(oCurrType=="VND") %> style='mso-number-format:&quot;\#\,\#\#0;'
  x:num ><%= oMoneyAmt%></td>
  <td class=xl33><%= oCurrType %></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 style='height:9.75pt'></td>
  <td class=xl34></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=16 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl30></td>
  <td colspan=18 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl31></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
  <td class=xl35 colspan=2 style='mso-ignore:colspan' x:str><span style='mso-spacerun:yes'> </span><%=oCompanyName%></td>
  <td colspan=6 class=xl35 style='mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 style='height:12.0pt'></td>
  <td class=xl34></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 style='height:15.75pt'></td>
  <td class=xl30></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl40><%= oCompanyTel %></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 style='height:22.5pt'></td>
  <td class=xl30></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl40>KHU CÔNG NGHIỆP NHƠN TRẠCH</td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 style='height:24.75pt'></td>
  <td class=xl30></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl41><%= oCompanyBAccount%></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl42 x:num></td>
  <td class=xl26></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 style='height:11.25pt'></td>
  <td class=xl30></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 style='height:18.0pt'></td>
  <td class=xl31></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl40><%= oBenName %></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 style='height:23.1pt'></td>
  <td class=xl34></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl26></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 style='height:22.5pt'></td>
  <td class=xl30></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl26></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 style='height:21.0pt'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl40><%= oBenBank%></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 style='height:21.0pt'></td>
  <td class=xl34></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl40><%= oBenBranch %></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
  <td class=xl30></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
  <td colspan=10 class=xl26></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 style='height:21.75pt'></td>
  <td class=xl30></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl41><%= oBankAccount %></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 style='height:13.5pt'></td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=15 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 style='height:13.5pt'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=17 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt'></td>
  <td class=xl31></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
  <td><% 
  //PAYMENT FOR BUYING BARCODE SYSTEM(FOR WAREHOUSE)
  %></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl30></td>
  <td></td>
  <%
  j += 1;
  }
 %>
  <td colspan=17 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=0></td>
  <td width=131 style='width:98pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=58 style='width:44pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=56 style='width:42pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
