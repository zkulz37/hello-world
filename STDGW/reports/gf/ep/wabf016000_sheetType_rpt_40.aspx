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
string oMoneyAmt ="";
string oMoneyStr = "";
string oTCO_DCCUSTM_PK = "";
string oRemark ="";
string oCurrType = "";
string oDate = "";

string oBankAccount = "";
string oBenName = "";
string oBenBank = "";
string oBenBranch = "";

string oCompanyName = "";
string oCompanyAddr = "";
string oCompanyTel = "";
string oCompanyBAccount = "";
string[] oCompanyBAccountArr = new string[12];
	
string SQL = "SELECT ACCOUNT_NO FROM TAC_ABDEPOMT WHERE PK = '" + iBankPk + "'";
DataTable rs = new DataTable();
rs = ESysLib.TableReadOpen(SQL);
if(rs.Rows.Count > 0)
	oCompanyBAccount = rs.Rows[0][0].ToString();

SQL = "SELECT PARTNER_LNAME, ADDR1, ADDR2, ADDR3, PHONE_NO FROM COMM.TCO_COMPANY WHERE DEL_IF = 0 AND ACTIVE_YN = 'Y'  AND PK IN " +
 "(SELECT TCO_COMPANY_PK FROM TAC_ABDEPOMT WHERE PK = '" + iBankPk + "') ";
DataTable rs1 	= new DataTable();
rs1 			= ESysLib.TableReadOpen(SQL);	

if(rs1.Rows.Count > 0)
{
	if(rs1.Rows[0][0].ToString().Trim() != "")
		oCompanyName = rs1.Rows[0][0].ToString();
	else	
		oCompanyName = "";
	if(rs1.Rows[0][1].ToString().Trim() != "")	
		oCompanyAddr = rs1.Rows[0][1].ToString();
	else	
		oCompanyAddr = "";
	if(rs1.Rows[0][4].ToString().Trim() != "")	
		oCompanyTel  = rs1.Rows[0][4].ToString();
	else
		oCompanyTel  = "";	
}

 SQL
	= "select tco_buspartner_pk, sum(bank_usd) usd, sum (bank_vnd) vnd  " + 
        " from  " +
        " (select  " +
        " b.tco_buspartner_pk  " +
        " , decode(a.pay_type, '03', decode(a.tr_ccy, 'USD', sum(b.pay_famt), decode(c.ven_trade_type,'IM', sum(b.pay_amt),'')), '04', decode(a.tr_ccy, 'USD', sum(b.pay_famt), decode(c.ven_trade_type, 'IM', sum(b.pay_amt),'')), '')  bank_usd  " +
        " , decode(a.pay_type, '03', decode(a.tr_ccy, 'USD', '', decode(c.ven_trade_type, 'IM', '', sum(b.pay_famt) )), '04', decode(a.tr_ccy, 'USD','', decode(c.ven_trade_type, 'IM', '',  sum(b.pay_famt))), '')  bank_vnd  " +
        " from tfn_eppaytr a,comm.tco_buspartner c, tfn_eppaytrd b, tfn_eppaytrh h " +
        "	where a.del_if = 0 " +
        "	and b.del_if = 0  " +
		"	and h.del_if = 0  " +
        " and a.pk in ('" + iPKArr + "') " +
        "	and a.tfn_eppay_pk = b.tfn_eppay_pk	 " +
        " and b.tco_buspartner_pk = c.pk  " +
		" and a.tfn_eppaytrh_pk = h.pk  " +
        " group by b.tco_buspartner_pk, a.tr_ccy, b.pay_famt, a.pay_type, c.ven_trade_type )  " +
        " group by tco_buspartner_pk  " ;
DateTime l_today = DateTime.Today;
int oMonth	= l_today.Month;
int oDay	= l_today.Day;
int oYear	= l_today.Year;
string sMonth = "", sDay = "";
if(oMonth <= 9)
	sMonth = "0" + oMonth.ToString();
if(oDay <= 9)
	sDay = "0" + oDay.ToString();

oCompanyBAccount = oCompanyBAccount.Replace(" ", "");
oCompanyBAccount = oCompanyBAccount.Replace(".", "");
oCompanyBAccount = oCompanyBAccount.Replace("-", "");
int istrBankAccLen = oCompanyBAccount.Length;
int i;
if(istrBankAccLen < 12)
{
	for(i= istrBankAccLen; i < 12; i++)
	{
		oCompanyBAccountArr[i-istrBankAccLen] = " ";
	}
}
	
for(i = 0 ; i < istrBankAccLen; i++)
{
	oCompanyBAccountArr[11-istrBankAccLen + i] = oCompanyBAccount.Substring(i, 1);	
}

string SQL_COUNT = "";
SQL_COUNT
	= "	SELECT COUNT( DISTINCT D.TCO_BUSPARTNER_PK) NumCust FROM TFN_EPPAYTR A, TFN_EPPAYTRD D " + 
        "	WHERE A.DEL_IF = 0 " +
        "	AND D.DEL_IF 	= 0 " +
        "	AND A.TFN_EPPAY_PK = D.TFN_EPPAY_PK  " +
        "	AND A.PK IN ('" + iPKArr + "') " ;
DataTable rs_count = new DataTable();
rs_count = ESysLib.TableReadOpen(SQL_COUNT);
int oCountCustomer = 0;
	if(rs_count.Rows.Count > 0)
	{
		oCountCustomer = int.Parse(rs_count.Rows[0][0].ToString());
	}
int oNumberPrint = oCountCustomer * 2 - 1;
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
  <o:Author>kiet</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:Created>2007-08-15T07:32:13Z</o:Created>
  <o:LastSaved>2010-01-07T06:40:31Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in 0in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
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
	font-size:11.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;}
.xl26
	{mso-style-parent:style0;
	color:black;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	color:red;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:top;}
.xl34
	{mso-style-parent:style0;
	text-align:left;}
.xl35
	{mso-style-parent:style0;
	mso-number-format:"Short Date";}
.xl36
	{mso-style-parent:style0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\;\@";}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\;\@";}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:top;}
.xl41
	{mso-style-parent:style0;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;}
.xl42
	{mso-style-parent:style0;
	mso-number-format:"\[ENG\]\[$-409\]d\\-mmm\\-yyyy\;\@";
	text-align:right;}
.xl43
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;}
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
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
	 <x:PageBreaks>
     <x:RowBreaks>
<% int k; for(k = 1; k <= oNumberPrint; k++) { %><x:RowBreak>
       <x:Row><%= k * 12 %></x:Row>
      </x:RowBreak><% } %>
       </x:RowBreaks>
    </x:PageBreaks>	
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8985</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1530</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=772 style='border-collapse:
 collapse;table-layout:fixed;width:586pt'>
 <%
 DataTable rs2 = new DataTable();
 rs2 = ESysLib.TableReadOpen(SQL);
 int j = 0; string SQL_BEN = ""; 
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
	rs_ben = ESysLib.TableReadOpen(SQL_BEN);			
	if(rs_ben.Rows.Count > 0)
	{
		if(rs_ben.Rows[0][0].ToString().Trim() != "")
			oBenName		= rs_ben.Rows[0][0].ToString().Trim();
		else
			oBenName		= "";
		if(rs_ben.Rows[0][1].ToString().Trim() != "")	
			oBenBank		= rs_ben.Rows[0][1].ToString().Trim();
		else
			oBenBank		= "";
		if(rs_ben.Rows[0][2].ToString().Trim() != "")	
			oBenBranch		= rs_ben.Rows[0][2].ToString().Trim();
		else
			oBenBranch		= "";
		if(rs_ben.Rows[0][3].ToString().Trim() != "")	
			oBankAccount	= rs_ben.Rows[0][3].ToString().Trim();
		else
			oBankAccount	= "";
	}

	if(oBankUsd != "") 
	{
		oCurrType = "USD";
		oMoneyAmt = oBankUsd;
		oMoneyStr = CommondLib.Num2VNText(oBankUsd, oCurrType);	
	}			
	else 
	{
		oCurrType="VND";
		oMoneyAmt = oBankVnd;
		oMoneyStr = CommondLib.Num2VNText(oBankVnd, oCurrType) ;
	} 
 %>
 <col width=53 style='mso-width-source:userset;mso-width-alt:1938;width:40pt'>
 <col width=26 span=8 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col width=21 style='mso-width-source:userset;mso-width-alt:768;width:16pt'>
 <col width=24 style='mso-width-source:userset;mso-width-alt:877;width:18pt'>
 <col width=26 style='mso-width-source:userset;mso-width-alt:950;width:20pt'>
 <col width=31 style='mso-width-source:userset;mso-width-alt:1133;width:23pt'>
 <col width=41 span=2 style='mso-width-source:userset;mso-width-alt:1499;
 width:31pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=16 style='mso-width-source:userset;mso-width-alt:585;width:12pt'>
 <col width=26 span=4 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col width=64 span=2 style='width:48pt'>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 width=53 style='height:16.5pt;width:40pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl24 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl24 style='height:20.1pt'></td>
  <td class=xl25 colspan=4 style='mso-ignore:colspan;'></td>
  <td class=xl26 style='mso-ignore:colspan;>D D A 9 1 2</td>
  <td class=xl25 style='></td>
  <td class=xl26 style=' mso-ignore:colspan;><%= oCompanyBAccountArr[6] %></td>
  <td class=xl25><%= oCompanyBAccountArr[7] %></td>
  <td class=xl26><%= oCompanyBAccountArr[8] %></td>
  <td class=xl25><%= oCompanyBAccountArr[9] %></td>
  <td class=xl25><%= oCompanyBAccountArr[10] %></td>
  <td class=xl25><%= oCompanyBAccountArr[11] %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td></td>
  <td class=xl27></td>
  <td class=xl28 x:num>1</td>
  <td class=xl28 x:num>2</td>
  <td class=xl28 x:num>3</td>
  <td class=xl28 x:num>4</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl24 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl24 style='height:10.5pt'></td>
  <td colspan=8 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl30></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=4 class=xl31 style='height:14.25pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td class=xl29></td>
  <td colspan=6 class=xl40 <% if(oCurrType=="USD") %> style='mso-number-format:"\#\,\#\#0\.00";text-align:center;' <% else %> style='text-align:center;' x:num ><%= oMoneyAmt %></td>
  <td class=xl29></td>
  <td class=xl33><%= oCurrType %></td>
  <td colspan=9 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=3 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=18 class=xl41><%= oMoneyStr %></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=13 class=xl34 style='mso-ignore:colspan'></td>
  <td colspan=7 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=23 style='height:23.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=0 style='display:none'>
  <td height=0 colspan=23 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=49 style='mso-height-source:userset;height:36.75pt'>
  <td height=49 colspan=2 style='height:36.75pt;mso-ignore:colspan'></td>
  <td><%= oBenBank %></td>
  <td colspan=20 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 colspan=2 style='height:26.25pt;mso-ignore:colspan'></td>
  <td><%= oBenName %></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <td colspan=4 class=xl42><%= sDay %>/<%= sMonth %>/<%= oYear %></td>
  <td class=xl36></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td class=xl38></td>
  <td class=xl39><%= oBankAccount%></td>
  <td colspan=4 class=xl39 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
<td colspan=8 class=xl43 <% if(oCurrType=="USD") %> style='mso-number-format:"\#\,\#\#0\.00";' x:num><%= oMoneyAmt %></td>  
<td style='mso-ignore:colspan'><%= oCurrType %></td>
  <td></td>
  <td></td>
  <td colspan=11 style='mso-ignore:colspan'></td>
 </tr>
   <%
	j += 1;
 }
 %>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=53 style='width:40pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
