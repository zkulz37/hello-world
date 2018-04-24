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
string oTCO_DCCUSTM_PK = "";
string oRemark ="";
string oCurrType = "" ;
string oDate = "";

string oBankAccount ="";
string oBenName = "" ;
string oBenBank = "";
string oBenBranch = "";

string oCompanyName = "";
string oCompanyAddr = "";
string oCompanyTel = "";
string oCompanyBAccount = "";
string[] oCompanyBAccountArr = new string[12];
string SQL = "";	
string l_bank_usd_tp = Request["bank_usd_tp"];
string l_bank_vnd_tp = Request["bank_vnd_tp"];
string l_cash_usd_tp = Request["cash_usd_tp"];
string l_cash_vnd_tp = Request["cash_vnd_tp"];
SQL = "SELECT ACCOUNT_NO FROM TAC_ABDEPOMT WHERE PK = '" + iBankPk + "'" ;
DataTable rs = new DataTable();
rs			= ESysLib.TableReadOpen(SQL);
 if(rs.Rows.Count > 0) 
	oCompanyBAccount = rs.Rows[0][0].ToString();
SQL
	= "SELECT PARTNER_LNAME, ADDR1, ADDR2, ADDR3, PHONE_NO FROM COMM.TCO_COMPANY WHERE DEL_IF = 0 AND ACTIVE_YN = 'Y'  AND PK IN " + 
        " (SELECT TCO_COMPANY_PK FROM TAC_ABDEPOMT WHERE PK IN (" + iBankPk + ") )" ;
DataTable rs1 = new DataTable();
rs1 = ESysLib.TableReadOpen(SQL);
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
	= "SELECT   tco_buspartner_pk, SUM (bank_usd) usd , SUM (bank_vnd) vnd " + 
        "    FROM (SELECT   d.tco_buspartner_pk, " +
        "                   DECODE (a.pay_type, " +
        "                      '" + l_bank_usd_tp + "', DECODE (a.pay_ccy, " +
        "                      'USD', SUM (a.pay_famt), 0) 																					  " +
        "                    ) bank_usd, " +
        "                   DECODE (a.pay_type, " +
        "                     '" + l_bank_vnd_tp + "', DECODE (a.pay_ccy, " +
        "                     'VND', SUM (a.pay_famt), 0) 																					  " +
        "                     ) bank_vnd														 " +
        "              FROM tfn_eppaytr a, " +
        "                   comm.tco_buspartner c, " +
        "                   tfn_eppay b, " +
        "                   tfn_eppaytrh h,  " +
        "										 tac_hgtrd d " +
        "             WHERE a.del_if = 0 " +
        "               AND b.del_if = 0 " +
        "               AND h.del_if = 0 " +
        "               AND a.pk IN (" +
					iPKArr +
        "         ) " +
        "               AND a.tfn_eppay_pk = b.pk " +
        "               AND d.tco_buspartner_pk = c.pk " +
        "               AND a.tfn_eppaytrh_pk = h.pk " +
        "								 and d.pk = b.tac_hgtrd_pk " +
        "          GROUP BY d.tco_buspartner_pk, a.pay_type, a.pay_ccy " +
        ") " +
        "GROUP BY tco_buspartner_pk " ;
DateTime l_today = DateTime.Today;		
int oMonth	= l_today.Month ;
int oDay	= l_today.Day ;
int oYear	= l_today.Year;
string sMonth = "", sDay = "";
if(oMonth <= 9)
	sMonth = "0" + oMonth.ToString();
else
	oMonth.ToString();	

if(oDay <= 9)
	sDay = "0" + oDay.ToString();
else
	sDay = 	oDay.ToString();

oCompanyBAccount = oCompanyBAccount.Replace(" ","");
oCompanyBAccount = oCompanyBAccount.Replace(".","");
oCompanyBAccount = oCompanyBAccount.Replace("-","");
int istrBankAccLen = oCompanyBAccount.Length;
int i ;

if(istrBankAccLen < 12)
{
	for(i= istrBankAccLen; i < 12; i++)
	{
		oCompanyBAccountArr[i-istrBankAccLen] = " ";
	}
}
if(	istrBankAccLen < 12)
{
	for(i = 0 ; i < istrBankAccLen; i++)
	{
		oCompanyBAccountArr[11-istrBankAccLen + i] = oCompanyBAccount.Substring(i, 1);	
	}
}
string SQL_COUNT = "";
SQL_COUNT
	= "	SELECT COUNT( DISTINCT D.TCO_BUSPARTNER_PK) NumCust FROM TFN_EPPAYTR A, TFN_EPPAYTRD D " + 
        "	WHERE A.DEL_IF = 0 " +
        "	AND D.DEL_IF 	= 0 " +
        "	AND A.TFN_EPPAY_PK = D.TFN_EPPAY_PK  " +
        "	AND A.PK IN (" + iPKArr + ") " ;
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
  <o:Author>Administrator</o:Author>
  <o:LastAuthor>GENU</o:LastAuthor>
  <o:LastPrinted>2007-08-17T04:19:39Z</o:LastPrinted>
  <o:Created>2007-06-25T01:26:33Z</o:Created>
  <o:LastSaved>2010-01-07T02:25:33Z</o:LastSaved>
  <o:Company>VinaGenuWin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .1in .1in .2in;
	mso-header-margin:.1in;
	mso-footer-margin:.1in;}
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
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	mso-number-format:Standard;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:Standard;}
.xl30
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:top;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:left;}
.xl33
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-family:"Wingdings 2", serif;
	mso-font-charset:2;}
.xl36
	{mso-style-parent:style0;
	mso-number-format:"dd\/mm\/yyyy";}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl38
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;}
.xl41
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
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
     <x:TopRowVisible>33</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>52</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
<% int k; for(k = 1; k <= oNumberPrint; k++) { %><x:RowBreak>
       <x:Row><%= k * 52 %></x:Row>
      </x:RowBreak><% } %>
       </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=907 style='border-collapse:
 collapse;table-layout:fixed;width:683pt'>
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
		oBankVnd = rs2.Rows[j][2].ToString();
	else
		oBankVnd = "";
		
	oTCO_DCCUSTM_PK = rs2.Rows[j][0].ToString();		
	
	SQL_BEN
	= "SELECT BEDEFI_NM, BEDEFI_BANK_NM, BRANCH, ACCOUNT_NO FROM TAC_BFBENEFICIARY WHERE DEL_IF = 0 AND TCO_DCCUST_PK = '" + oTCO_DCCUSTM_PK + "' " ;
	DataTable rs_ben = new DataTable();
	rs_ben = ESysLib.TableReadOpen(SQL_BEN);	
	if(rs_ben.Rows.Count > 0)	
	{
		if(rs_ben.Rows[0][0].ToString().Trim() != "")
			oBenName		= rs_ben.Rows[0][0].ToString().Trim() ;
		else
			oBenName		= "" ;
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
		oMoneyStr = CommondLib.Num2VNText(oBankUsd, oCurrType) ;
	}	
	else 
	{
		oCurrType = "VND";
		oMoneyAmt = oBankVnd;
		oMoneyStr = CommondLib.Num2VNText(oBankVnd, oCurrType);
	} 
 %>
 <col width=12 style='mso-width-source:userset;mso-width-alt:438;width:9pt'>
 <col width=68 style='mso-width-source:userset;mso-width-alt:2486;width:51pt'>
 <col width=19 style='mso-width-source:userset;mso-width-alt:694;width:14pt'>
 <col width=23 span=3 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col width=2 style='mso-width-source:userset;mso-width-alt:73;width:2pt'>
 <col width=23 style='mso-width-source:userset;mso-width-alt:841;width:17pt'>
 <col width=22 span=2 style='mso-width-source:userset;mso-width-alt:804;
 width:17pt'>
 <col width=2 style='mso-width-source:userset;mso-width-alt:73;width:2pt'>
 <col width=17 style='mso-width-source:userset;mso-width-alt:621;width:13pt'>
 <col width=23 span=5 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col width=25 span=2 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col width=12 style='mso-width-source:userset;mso-width-alt:438;width:9pt'>
 <col width=27 style='mso-width-source:userset;mso-width-alt:987;width:20pt'>
 <col width=54 style='mso-width-source:userset;mso-width-alt:1974;width:41pt'>
 <col width=20 style='mso-width-source:userset;mso-width-alt:731;width:15pt'>
 <col width=73 style='mso-width-source:userset;mso-width-alt:2669;width:55pt'>
 <col width=25 style='mso-width-source:userset;mso-width-alt:914;width:19pt'>
 <col width=41 style='mso-width-source:userset;mso-width-alt:1499;width:31pt'>
 <col width=8 style='mso-width-source:userset;mso-width-alt:292;width:6pt'>
 <col width=66 style='mso-width-source:userset;mso-width-alt:2413;width:50pt'>
 <col width=74 style='mso-width-source:userset;mso-width-alt:2706;width:56pt'>
 <col width=86 style='mso-width-source:userset;mso-width-alt:3145;width:65pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 width=12 style='height:15.0pt;width:9pt'></td>
  <td colspan=19 rowspan=5 class=xl24 width=421 style='width:316pt'></td>
  <td width=27 style='width:20pt'></td>
  <td colspan=2 class=xl25 width=74 style='width:56pt'></td>
  <td class=xl25 width=73 style='width:55pt'></td>
  <td colspan=3 class=xl25 width=74 style='width:56pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=86 style='width:65pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.85pt'>
  <td height=19 style='height:14.85pt'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='height:19.5pt'>
  <td height=26 style='height:19.5pt'></td>
  <td colspan=19 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=10 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 colspan=30 style='height:21.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td colspan=12 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl36 x:str><%=oDay %>/<%= sMonth %>/<%= oYear %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=30 style='height:3.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt'></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
  <td colspan=12 class=xl37 <% if(oCurrType=="USD") { %> style='mso-number-format:\#\,\#\#0\.00;'
  <% } %> x:num ><%= oMoneyAmt %></td>
  <td class=xl29><%= oCurrType %></td>
  <td colspan=4 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=9 style='height:17.1pt;mso-ignore:colspan'></td>
  <td colspan=17 class=xl38><%= oMoneyStr %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=30 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
  <td colspan=9 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=20 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=10 style='height:17.1pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl39><%= oBenName %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=10 style='height:20.1pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl40></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=10 style='height:20.1pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl40></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=30 style='height:6.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 style='height:22.5pt'></td>
  <td colspan=15 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=14 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 colspan=10 style='height:21.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=12 class=xl40><%= oBenBank %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=10 style='height:20.1pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=12 class=xl40><%= oBankAccount %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=10 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=12 class=xl40><%= oBenBranch %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=10 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=16 class=xl40></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.7pt'>
  <td height=14 colspan=30 style='height:10.7pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 style='height:17.1pt'></td>
  <td colspan=21 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=8 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 colspan=30 style='height:9.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.85pt'>
  <td height=23 colspan=2 style='height:17.85pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl41 x:str></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl41 x:str></td>
  <td colspan=12 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=30 style='height:3.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 style='height:17.25pt'></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 style='height:22.5pt'></td>
  <td class=xl26></td>
  <td colspan=24 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=2 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=24 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=24 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=30 style='height:5.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=89 style='mso-height-source:userset;height:67.35pt'>
  <td height=89 style='height:67.35pt'></td>
  <td colspan=25 class=xl42 width=661 style='width:497pt'></td>
  <td colspan=4 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=4 style='mso-height-source:userset;height:3.0pt'>
  <td height=4 colspan=30 style='height:3.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=3 style='height:18.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=18 class=xl32></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 colspan=11 style='height:24.95pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=14 class=xl40><%= oCompanyName %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 colspan=12 style='height:24.95pt;mso-ignore:colspan'></td>
  <td colspan=14 class=xl40><%= oCompanyTel %></td>
  <td colspan=4 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=34 style='height:25.5pt;mso-xlrowspan:2'>
  <td height=34 colspan=30 style='height:25.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.7pt'>
  <td height=18 colspan=30 style='height:13.7pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=30 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.85pt'>
  <td height=19 colspan=30 style='height:14.85pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 colspan=30 style='height:18.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=30 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 style='height:20.1pt'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34><%= oCompanyBAccountArr[6] %></td>
  <td class=xl34><%= oCompanyBAccountArr[7] %></td>
  <td class=xl34><%= oCompanyBAccountArr[8] %></td>
  <td class=xl34><%= oCompanyBAccountArr[9] %></td>
  <td class=xl34><%= oCompanyBAccountArr[10] %></td>
  <td class=xl34><%= oCompanyBAccountArr[11] %></td>
  <td colspan=10 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=2 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=29 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl35></td>
 </tr>
 <%
	j += 1;
	}
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=12 style='width:9pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=2 style='width:2pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=2 style='width:2pt'></td>
  <td width=17 style='width:13pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=8 style='width:6pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=86 style='width:65pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
