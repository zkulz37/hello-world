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
string oMoneyStr ="";
string oTCO_DCCUSTM_PK ="";
string oRemark ="";
string oCurrType = "" ;
string oDate = "";

string oBankAccount ="";
string oBenName = "";
string oBenBank = "";
string oBenBranch = "";

string oCompanyName = "";
string oCompanyAddr = "";
string oCompanyTel = "";
string oCompanyBAccount = "";
string[] oCompanyBAccountArr = new string[12];
string[] oBAccountArr = new string[18];

int oCountCustomer = 0;
string SQL = "";
SQL = "SELECT ACCOUNT_NO FROM TAC_ABDEPOMT WHERE PK = '" + iBankPk + "'";
DataTable rs = new DataTable();
rs = ESysLib.TableReadOpen(SQL);
	if(rs.Rows.Count > 0)
		oCompanyBAccount = rs.Rows[0][0].ToString();		
SQL
	= "SELECT PARTNER_LNAME, ADDR1, ADDR2, ADDR3, PHONE_NO FROM COMM.TCO_COMPANY WHERE DEL_IF = 0 AND ACTIVE_YN = 'Y'  AND PK IN  " + 
        "				 (SELECT TCO_COMPANY_PK FROM TAC_ABDEPOMT WHERE PK = '" + iBankPk + "') " ;
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
		oCompanyTel  = "";
}
SQL
	= "select tco_buspartner_pk, sum(bank_usd) usd, sum (bank_vnd) vnd   " + 
        " from   " +
        " (select   " +
        " b.tco_buspartner_pk   " +
        " , decode(a.pay_type, '03', decode(a.tr_ccy, 'USD', sum(b.pay_famt), decode(c.ven_trade_type,'IM', sum(b.pay_amt),'')), '04', decode(a.tr_ccy, 'USD', sum(b.pay_famt), decode(c.ven_trade_type, 'IM', sum(b.pay_amt),'')), '')  bank_usd   " +
        " , decode(a.pay_type, '03', decode(a.tr_ccy, 'USD', '', decode(c.ven_trade_type, 'IM', '', sum(b.pay_famt) )), '04', decode(a.tr_ccy, 'USD','', decode(c.ven_trade_type, 'IM', '',  sum(b.pay_famt))), '')  bank_vnd   " +
        " from tfn_eppaytr a,comm.tco_buspartner c, tfn_eppaytrd b, tfn_eppaytrh h " +
        "	where a.del_if = 0  " +
        "	and b.del_if = 0   " +
		"	and h.del_if = 0   " +
        " and a.pk in ('" + iPKArr + "')  " +
        "	and a.tfn_eppay_pk = b.tfn_eppay_pk	  " +
        " and b.tco_buspartner_pk = c.pk   " +
		" and a.tfn_eppaytrh_pk = h.pk   " +
        " group by b.tco_buspartner_pk, a.tr_ccy, b.pay_famt, a.pay_type, c.ven_trade_type )   " +
        " group by tco_buspartner_pk   " ;
DateTime l_today = new DateTime();
l_today = DateTime.Today ;
int oMonth	= l_today.Month;
int oDay	= l_today.Day;
int oYear	= l_today.Year;
string sMonth = "", sDay = "";
if(oMonth <= 9)
	sMonth = "0" + oMonth.ToString();
if(oDay <= 9)
	sDay = "0" + oDay.ToString();

oCompanyBAccount = oCompanyBAccount.Replace(" ","");
oCompanyBAccount = oCompanyBAccount.Replace(".","");
oCompanyBAccount = oCompanyBAccount.Replace("-","");
int istrBankAccLen = oCompanyBAccount.Length ;
int i;
if(istrBankAccLen < 12)
{
	for( i= istrBankAccLen; i < 12; i++)
	{
		oCompanyBAccountArr[i-istrBankAccLen] = " " ;
	}
}
	
for( i = 0; i < istrBankAccLen; i++)
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
 if(rs_count.Rows.Count > 0)
 {
	oCountCustomer = int.Parse(rs_count.Rows[0][0].ToString());
 }
int oNumberPrint = oCountCustomer * 2 - 1;
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1258">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="SHB_Domestic_70_files/filelist.xml">
<link rel=Edit-Time-Data href="SHB_Domestic_70_files/editdata.mso">
<link rel=OLE-Object-Data href="SHB_Domestic_70_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>kiet</o:Author>
  <o:LastAuthor>dt</o:LastAuthor>
  <o:LastPrinted>2007-08-25T07:28:30Z</o:LastPrinted>
  <o:Created>2007-07-16T08:45:53Z</o:Created>
  <o:LastSaved>2007-08-25T07:29:11Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.45in 0in 0in 0in;
	mso-header-margin:.25in;
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
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:right;
	vertical-align:top;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:top;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	vertical-align:bottom;
	}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;
	vertical-align:top;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:top;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;}
.xl33
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:right;
	vertical-align:bottom;
	}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:bottom;
	}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;
	vertical-align:bottom;
	}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;
	vertical-align:top;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;
	vertical-align:bottom;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>225</x:DefaultRowHeight>
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
       <x:Row><%= k*21 %></x:Row>
      </x:RowBreak><% } %>
       </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8580</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>
<body link=blue vlink=purple class=xl24>
<table x:str border=0 cellpadding=0 cellspacing=0 width=717 style='border-collapse:
 collapse;table-layout:fixed;width:538pt'>
 <col class=xl24 width=65 style='mso-width-source:userset;mso-width-alt:2377;
 width:49pt'>
 <col class=xl24 width=20 style='mso-width-source:userset;mso-width-alt:731;
 width:15pt'>
 <col class=xl24 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col class=xl24 width=19 span=3 style='mso-width-source:userset;mso-width-alt:
 694;width:14pt'>
 <col class=xl24 width=22 span=3 style='mso-width-source:userset;mso-width-alt:
 804;width:17pt'>
 <col class=xl24 width=4 style='mso-width-source:userset;mso-width-alt:146;
 width:3pt'>
 <col class=xl24 width=23 span=2 style='mso-width-source:userset;mso-width-alt:
 841;width:17pt'>
 <col class=xl24 width=22 style='mso-width-source:userset;mso-width-alt:804;
 width:17pt'>
 <col class=xl24 width=4 style='mso-width-source:userset;mso-width-alt:146;
 width:3pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl24 width=19 span=5 style='mso-width-source:userset;mso-width-alt:
 694;width:14pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=21 span=2 style='mso-width-source:userset;mso-width-alt:
 768;width:16pt'>
 <col class=xl24 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl24 width=3 style='mso-width-source:userset;mso-width-alt:109;
 width:2pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl24 width=20 style='mso-width-source:userset;mso-width-alt:731;
 width:15pt'>
 <col class=xl24 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl24 width=3 style='mso-width-source:userset;mso-width-alt:109;
 width:2pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=5 style='mso-width-source:userset;mso-width-alt:182;
 width:4pt'>
 <col class=xl24 width=6 style='mso-width-source:userset;mso-width-alt:219;
 width:5pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=19 span=3 style='mso-width-source:userset;mso-width-alt:
 694;width:14pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <%
 DataTable rs2 = new DataTable();
 rs2 = ESysLib.TableReadOpen(SQL);
 string SQL_BEN = "";
 int j = 0; 
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
		oCurrType="USD";
		oMoneyAmt = oBankUsd;		
		oMoneyStr = CommondLib.Num2VNText(oMoneyAmt, oCurrType) ;
	}				
	else 
	{
		oCurrType="VND";
		oMoneyAmt = oBankVnd;
		oMoneyStr = CommondLib.Num2VNText(oMoneyAmt, oCurrType) ;
	}

	oBankAccount = oBankAccount.Replace(" ", "");
	oBankAccount = oBankAccount.Replace(".", "");
	oBankAccount = oBankAccount.Replace("-", "");
	istrBankAccLen = oBankAccount.Length;
	
	if(istrBankAccLen < 12)
	{
		for(i= istrBankAccLen; i < 12; i++)
		{
			oBAccountArr[i - istrBankAccLen ] = " ";
		}
	}		
	for(i = 0; i < istrBankAccLen; i++)
	{
		oBAccountArr[11-istrBankAccLen + i] =oBankAccount.Substring(i, 1);
	}
 
 %>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl24 width=65 style='height:10.5pt;width:49pt'>&nbsp;</td>
  <td class=xl24 width=20 style='width:15pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=4 style='width:3pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=4 style='width:3pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=20 style='width:15pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
  <td class=xl24 width=12 style='width:9pt'></td>
  <td colspan=2 class=xl25 width=11 style='width:9pt'></td>
  <td class=xl24 width=12 style='width:9pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 colspan=37 class=xl24 style='height:4.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=30 class=xl24 style='height:9.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=37 class=xl24 style='height:3.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=30 class=xl24 style='height:9.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=105 style='mso-height-source:userset;height:78.75pt'>
  <td height=105 colspan=30 class=xl24 style='height:78.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=24 style='mso-height-source:userset;height:18.0pt;vertical-align:top;'>
  <td colspan=2 height=24 class=xl30 style='height:18.0pt'></td>
  <td colspan=4 class=xl31></td>
  <td class=xl27 x:str><%= oCompanyBAccountArr[0] %></td>
  <td class=xl27 x:str><%= oCompanyBAccountArr[1] %></td>
  <td class=xl27 x:str><%= oCompanyBAccountArr[2] %></td>
  <td class=xl28></td>
  <td colspan=3 class=xl38 x:str><%=oCompanyBAccountArr[3] %><%= oCompanyBAccountArr[4] %><%= oCompanyBAccountArr[5] %></td>
  <td class=xl28></td>
  <td colspan=6 class=xl38><%=oCompanyBAccountArr[6] %><%= oCompanyBAccountArr[7] %><%= oCompanyBAccountArr[8] %><%= oCompanyBAccountArr[9] %><%=oCompanyBAccountArr[10] %><%= oCompanyBAccountArr[11] %></td>
  <td class=xl26></td>
  <td colspan=16 class=xl27><%= oBAccountArr[0] %><%= oBAccountArr[1] %><%= oBAccountArr[2] %><%= oBAccountArr[3] %><%= oBAccountArr[4] %><%= oBAccountArr[5] %><%= oBAccountArr[6] %><%= oBAccountArr[7] %><%= oBAccountArr[8] %><%= oBAccountArr[9] %><%= oBAccountArr[10] %><%= oBAccountArr[11] %></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt;vertical-align:bottom;'>
  <td colspan=2 height=19 class=xl32 style='height:14.25pt'></td>
  <td class=xl29></td>
  <td colspan=6 class=xl39></td>
  <td colspan=3 class=xl37><%= oCurrType %></td>
  <td colspan=8 class=xl34 <% if(oCurrType=="VND") %> style='mso-number-format:"\#\,\#\#0";' x:num><%= oMoneyAmt %></td>
  <td class=xl24></td>
  <td colspan=3 class=xl33><%= oCurrType %></td>
  <td class=xl24></td>
  <td colspan=12 class=xl34 <% if(oCurrType=="VND") %> style='mso-number-format:"\#\,\#\#0";' x:num><%= oMoneyAmt %></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td colspan=2 height=6 class=xl32 style='height:4.5pt'></td>
  <td colspan=35 class=xl32></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=35 class=xl32></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl24 style='height:3.75pt'></td>
  <td colspan=11 class=xl32></td>
  <td colspan=8 class=xl25></td>
  <td colspan=2 class=xl25></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl24 colspan=11 style='mso-ignore:colspan'><%=	oCompanyName%></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl24 style='height:22.5pt'></td>
  <td colspan=11 class=xl32>&nbsp;&nbsp;&nbsp;<%= oCompanyTel %></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl24 style='height:23.25pt'></td>
  <td class=xl24 colspan=9 style='mso-ignore:colspan'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=16 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=57 style='mso-height-source:userset;height:42.75pt'>
  <td height=57 colspan=16 class=xl24 style='height:42.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=64 style='mso-height-source:userset;height:48.0pt'>
  <td height=64 class=xl24 style='height:48.0pt'></td>
  <td colspan=18 class=xl36><%= sDay %>/<%= sMonth %>/<%= oYear %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=20 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32></td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 colspan=21 class=xl24 style='height:21.75pt;mso-ignore:colspan'></td>
  <td colspan=16 rowspan=2 class=xl35  style='text-align:center;' width=240 style='width:180pt'><%= oBenName %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=21 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=37 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl24 width=65 style='height:10.5pt;width:49pt'>&nbsp;</td>
  <td class=xl24 width=20 style='width:15pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=4 style='width:3pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=22 style='width:17pt'></td>
  <td class=xl24 width=4 style='width:3pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=20 style='width:15pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=3 style='width:2pt'></td>
  <td class=xl24 width=12 style='width:9pt'></td>
  <td colspan=2 class=xl25 width=11 style='width:9pt'></td>
  <td class=xl24 width=12 style='width:9pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=19 style='width:14pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 colspan=37 class=xl24 style='height:4.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=30 class=xl24 style='height:9.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=37 class=xl24 style='height:3.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=30 class=xl24 style='height:9.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=105 style='mso-height-source:userset;height:78.75pt'>
  <td height=105 colspan=30 class=xl24 style='height:78.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=24 style='mso-height-source:userset;height:18.0pt;vertical-align:top;'>
  <td colspan=2 height=24 class=xl30 style='height:18.0pt'></td>
  <td colspan=4 class=xl31></td>
  <td class=xl27 x:str><%= oCompanyBAccountArr[0] %></td>
  <td class=xl27 x:str><%= oCompanyBAccountArr[1] %></td>
  <td class=xl27 x:str><%= oCompanyBAccountArr[2] %></td>
  <td class=xl28></td>
  <td colspan=3 class=xl38><%= oCompanyBAccountArr[3] %><%= oCompanyBAccountArr[4] %><%= oCompanyBAccountArr[5] %></td>
  <td class=xl28></td>
  <td colspan=6 class=xl38><%= oCompanyBAccountArr[6] %><%= oCompanyBAccountArr[7] %><%= oCompanyBAccountArr[8] %><%= oCompanyBAccountArr[9] %><%= oCompanyBAccountArr[10] %><%= oCompanyBAccountArr[11] %></td>
  <td class=xl26></td>
  <td colspan=16 class=xl27><%= oBAccountArr[0] %><%= oBAccountArr[1] %><%= oBAccountArr[2] %><%= oBAccountArr[3] %><%= oBAccountArr[4] %><%= oBAccountArr[5] %><%= oBAccountArr[6] %><%= oBAccountArr[7] %><%= oBAccountArr[8] %><%= oBAccountArr[9] %><%= oBAccountArr[10] %><%= oBAccountArr[11] %></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt;vertical-align:bottom;'>
  <td colspan=2 height=19 class=xl32 style='height:14.25pt'></td>
  <td class=xl29></td>
  <td colspan=6 class=xl39></td>
  <td colspan=3 class=xl37><%= oCurrType %></td>
  <td colspan=8 class=xl34 <% if(oCurrType=="VND") %> style='mso-number-format:"\#\,\#\#0";' x:num><%= oMoneyAmt %></td>
  <td class=xl24></td>
  <td colspan=3 class=xl33><%= oCurrType %></td>
  <td class=xl24></td>
  <td colspan=12 class=xl34 <% if(oCurrType=="VND") %> style='mso-number-format:"\#\,\#\#0";' x:num><%= oMoneyAmt %></td>
 </tr>
 <tr height=6 style='mso-height-source:userset;height:4.5pt'>
  <td colspan=2 height=6 class=xl32 style='height:4.5pt'></td>
  <td colspan=35 class=xl32></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 colspan=2 class=xl24 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=35 class=xl32></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl24 style='height:3.75pt'></td>
  <td colspan=11 class=xl32></td>
  <td colspan=8 class=xl25></td>
  <td colspan=2 class=xl25></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'></td>
  <td class=xl24 colspan=11 style='mso-ignore:colspan'><%=	oCompanyName%></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl25></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl24 style='height:22.5pt'></td>
  <td colspan=11 class=xl32>&nbsp;&nbsp;&nbsp;<%= oCompanyTel %></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl24 style='height:23.25pt'></td>
  <td class=xl24 colspan=9 style='mso-ignore:colspan'>KHU CÔNG NGHIỆP NHƠN TRẠCH</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=16 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=57 style='mso-height-source:userset;height:42.75pt'>
  <td height=57 colspan=16 class=xl24 style='height:42.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=64 style='mso-height-source:userset;height:48.0pt'>
  <td height=64 class=xl24 style='height:48.0pt'></td>
  <td colspan=18 class=xl36><%= sDay %>/<%= sMonth %>/<%= oYear %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=11 class=xl25></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 colspan=20 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl32></td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 colspan=21 class=xl24 style='height:21.75pt;mso-ignore:colspan'></td>
  <td colspan=16 rowspan=2 class=xl35  style='text-align:center;' width=240 style='width:180pt'><%= oBenName %></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=21 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=37 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <%
 j += 1;	
 }
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=65 style='width:49pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=4 style='width:3pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=4 style='width:3pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=3 style='width:2pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=5 style='width:4pt'></td>
  <td width=6 style='width:5pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=21 style='width:16pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
