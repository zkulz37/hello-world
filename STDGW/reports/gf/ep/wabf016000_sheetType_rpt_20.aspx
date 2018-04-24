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
string iBankPk = "", iPKArr = "";
iBankPk	= Request["bankPK"];
iPKArr	= Request["pk"];

string oBankUsd 		= "";
string oBankVnd 		= "" ;
string oMoneyAmt 		= "";
string oMoneyStr 		= "" ;
string oTCO_DCCUSTM_PK 	= "" ;
string oRemark 			= "";
string oCurrType 		= "";
string oDate 			= "" ;

string oBankAccount = "" ;
string oBenName = "" ;
string oBenBank = "";
string oBenBranch = "" ;

string oCompanyName = "" ;
string oCompanyAddr = "" ;
string oCompanyTel = "";
string oCompanyBAccount = "" ;

int oCountCustomer = 0;

string SQL
	= "SELECT ACCOUNT_NO FROM TAC_ABDEPOMT WHERE DEL_IF = 0 AND PK IN ( " + iBankPk + ") " ;
	DataTable rs = new DataTable();
	rs = ESysLib.TableReadOpen(SQL);	
	if(rs.Rows.Count > 0)
	{
		if(rs.Rows[0][0].ToString().Trim() != "")		
			oCompanyBAccount = rs.Rows[0][0].ToString().Trim();
		else
			oCompanyBAccount = "";
	}

 SQL
	= "SELECT PARTNER_LNAME, ADDR1, ADDR2, ADDR3, PHONE_NO FROM COMM.TCO_COMPANY WHERE DEL_IF = 0 AND ACTIVE_YN = 'Y'  " + 
        "AND PK IN  " +
        " (SELECT TCO_COMPANY_PK FROM TAC_ABDEPOMT WHERE DEL_IF = 0 AND PK IN ('" + iBankPk + "') ) " ;
	DataTable rs1 = new DataTable();
	rs1 = ESysLib.TableReadOpen(SQL);
if(rs1.Rows.Count > 0)
{
	if(rs1.Rows[0][0].ToString().Trim() != "")	
		oCompanyName = rs1.Rows[0][0].ToString().Trim();
	else
		oCompanyName = "";			
	if(rs1.Rows[0][1].ToString().Trim() != "")		
		oCompanyAddr = rs1.Rows[0][1].ToString().Trim() ;
	else
		oCompanyAddr = "";
	if(rs1.Rows[0][4].ToString().Trim() != "")		
		oCompanyTel = rs1.Rows[0][4].ToString().Trim() ;
	else
		oCompanyTel = "";
}
SQL
	= "SELECT TCO_BUSPARTNER_PK, SUM(bank_usd) USD, SUM (bank_vnd) VND  " + 
        " FROM  " +
        " (SELECT  " +
        " B.TCO_BUSPARTNER_PK  " +
        " , decode(A.PAY_TYPE, '03', DECODE(A.TR_CCY, 'USD', sum(B.PAY_FAMT), decode(C.VEN_TRADE_TYPE,'IM', sum(B.PAY_AMT),'')), '04', DECODE(A.TR_CCY, 'USD', sum(B.PAY_FAMT), decode(C.VEN_TRADE_TYPE, 'IM', sum(B.PAY_AMT),'')), '')  bank_usd  " +
        " , decode(A.PAY_TYPE, '03', DECODE(A.TR_CCY, 'USD', '', decode(C.VEN_TRADE_TYPE, 'IM', '', sum(B.PAY_FAMT) )), '04', DECODE(A.TR_CCY, 'USD','', decode(C.VEN_TRADE_TYPE, 'IM', '',  sum(B.PAY_FAMT))), '')  bank_vnd  " +
        " FROM TFN_EPPAYTR A,COMM.TCO_BUSPARTNER C, TFN_EPPAYTRD B, TFN_EPPAYTRH H " +
        "	WHERE A.DEL_IF = 0 " +
        "	AND B.DEL_IF = 0  " +
		"	AND H.DEL_IF = 0  " +
        " AND A.PK IN ('" + iPKArr + "') " +
        "	AND A.TFN_EPPAY_PK = B.TFN_EPPAY_PK	 " +
        " AND B.TCO_BUSPARTNER_PK = C.PK  " +
		" AND A.TFN_EPPAYTRH_PK = H.PK  " +
        " GROUP BY B.TCO_BUSPARTNER_PK, A.TR_CCY, B.PAY_FAMT, A.PAY_TYPE, C.VEN_TRADE_TYPE )  " +
        " GROUP BY TCO_BUSPARTNER_PK  " ;
DateTime l_today = DateTime.Today;
int oMonth	= l_today.Month;
int oDay	= l_today.Day;
int oYear	= l_today.Year;
string sDay = "", sMonth = "";
if(oMonth <= 9)
	sMonth = "0" + oMonth.ToString();
else
	sMonth = oMonth.ToString();
if(oDay <= 9)
	sDay = "0" + oDay.ToString();
else
	sDay = oDay.ToString();
string sToday = sDay + "/" + sMonth + "/" + oYear.ToString();
string SQL_COUNT
	= "SELECT COUNT( DISTINCT D.TCO_BUSPARTNER_PK) NumCust FROM TFN_EPPAYTR A, TFN_EPPAYTRD D  " + 
        "WHERE A.DEL_IF = 0  " +
        "AND D.DEL_IF = 0 " +
        "AND A.TFN_EPPAY_PK = D.TFN_EPPAY_PK " +
        "AND A.PK IN ('" + iPKArr + "')" ;
	DataTable rs_count = new DataTable();
	rs_count = ESysLib.TableReadOpen(SQL_COUNT);	
	if(rs_count.Rows.Count > 0)
		oCountCustomer = int.Parse(rs_count.Rows[0][0].ToString());
	int oNumberPrint = oCountCustomer - 1;
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
  <o:LastPrinted>2007-08-27T10:00:19Z</o:LastPrinted>
  <o:Created>2007-06-25T02:02:36Z</o:Created>
  <o:LastSaved>2010-01-07T02:09:28Z</o:LastSaved>
  <o:Company>VinaGenuWin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.2in .1in 0in .59in;
	mso-header-margin:.1in;
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
	font-size:9.0pt;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl29
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:7.5pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:9.0pt;
	vertical-align:top;}
.xl32
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;}
.xl33
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;}
.xl36
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;}
.xl41
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:"\#\,\#\#0";
	text-align:left;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	mso-number-format:Standard;
	text-align:left;}
.xl44
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;}
.xl45
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;}
.xl47
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:left;
	vertical-align:top;}
.xl50
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:163;
	text-align:left;}
.xl51
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
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
     <x:DefaultRowHeight>240</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>36</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>55</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <% int k; for(k = 1; k <= oNumberPrint; k++) { %><x:RowBreak>
       <x:Row><%= k*56 %></x:Row>
      </x:RowBreak><% } %>
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>15</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1752 style='border-collapse:
 collapse;table-layout:fixed;width:1317pt'>
 <%
 DataTable rs2 = new DataTable();
 rs2 = ESysLib.TableReadOpen(SQL);
 int j = 0; string SQL_BEN;
 while(j < rs2.Rows.Count )
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
				
	SQL_BEN = "SELECT BEDEFI_NM, BEDEFI_BANK_NM, BRANCH, ACCOUNT_NO FROM TAC_BFBENEFICIARY WHERE DEL_IF = 0 AND TCO_DCCUST_PK = '" + oTCO_DCCUSTM_PK + "'";
	DataTable rs_ben = new DataTable();	
	rs_ben = ESysLib.TableReadOpen(SQL_BEN);
	if(rs_ben.Rows.Count > 0)
	{
		if(rs_ben.Rows[0][0].ToString().Trim() != "")
			oBenName		= rs_ben.Rows[0][0].ToString();
		else
			oBenName		= "";
		if(rs_ben.Rows[0][1].ToString().Trim() != "")	
			oBenBank		= rs_ben.Rows[0][1].ToString().Trim();
		else
			oBenBank		= "";
		if(rs_ben.Rows[0][2].ToString().Trim() != "")			
			oBenBranch		= rs_ben.Rows[0][2].ToString();
		else
			oBenBranch 		= "";
		if(rs_ben.Rows[0][3].ToString().Trim() != "")	
			oBankAccount	= rs_ben.Rows[0][3].ToString().Trim();
		else
			oBankAccount 	= "";
	}	
	if(oBankUsd != "")
	{
		oCurrType = "USD";
		oMoneyAmt = oBankUsd;
		oMoneyStr = CommondLib.Num2VNText(oBankUsd, oCurrType);
	}				
	else 
	{
		oCurrType = "VND";
		oMoneyAmt = oBankVnd;
		oMoneyStr = CommondLib.Num2VNText(oBankVnd, oCurrType);
	}
 %>
 <col class=xl24 width=9 style='mso-width-source:userset;mso-width-alt:329;
 width:7pt'>
 <col class=xl24 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl24 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=32 style='mso-width-source:userset;mso-width-alt:1170;
 width:24pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col class=xl24 width=24 style='mso-width-source:userset;mso-width-alt:877;
 width:18pt'>
 <col class=xl24 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col class=xl24 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl24 width=9 style='mso-width-source:userset;mso-width-alt:329;
 width:7pt'>
 <col class=xl24 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl24 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col class=xl24 width=17 style='mso-width-source:userset;mso-width-alt:621;
 width:13pt'>
 <col class=xl24 width=24 style='mso-width-source:userset;mso-width-alt:877;
 width:18pt'>
 <col class=xl24 width=16 span=2 style='mso-width-source:userset;mso-width-alt:
 585;width:12pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=25 style='mso-width-source:userset;mso-width-alt:914;
 width:19pt'>
 <col class=xl24 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl24 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl24 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=156 style='mso-width-source:userset;mso-width-alt:5705;
 width:117pt'>
 <col class=xl24 width=128 style='mso-width-source:userset;mso-width-alt:4681;
 width:96pt'>
 <col class=xl24 width=251 style='mso-width-source:userset;mso-width-alt:9179;
 width:188pt'>
 <col class=xl24 width=64 span=7 style='width:48pt'>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl24 width=9 style='height:12.75pt;width:7pt'></td>
  <td class=xl24 width=15 style='width:11pt'></td>
  <td class=xl24 width=35 style='width:26pt'></td>
  <td class=xl24 width=53 style='width:40pt'></td>
  <td class=xl24 width=32 style='width:24pt'></td>
  <td class=xl24 width=12 style='width:9pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=24 style='width:18pt'></td>
  <td class=xl24 width=25 style='width:19pt'></td>
  <td class=xl24 width=17 style='width:13pt'></td>
  <td class=xl24 width=9 style='width:7pt'></td>
  <td class=xl24 width=17 style='width:13pt'></td>
  <td class=xl24 width=67 style='width:50pt'></td>
  <td class=xl24 width=12 style='width:9pt'></td>
  <td class=xl24 width=17 style='width:13pt'></td>
  <td class=xl24 width=33 style='width:25pt'></td>
  <td class=xl24 width=30 style='width:23pt'></td>
  <td colspan=4 class=xl37 width=80 style='width:60pt'></td>
  <td colspan=4 class=xl37 width=82 style='width:62pt'></td>
  <td colspan=3 class=xl37 width=79 style='width:60pt'></td>
  <td class=xl24 width=21 style='width:16pt'></td>
  <td class=xl24 width=75 style='width:56pt'></td>
  <td class=xl24 width=156 style='width:117pt'></td>
  <td class=xl24 width=128 style='width:96pt'></td>
  <td class=xl24 width=251 style='width:188pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl24 style='height:11.25pt'></td>
  <td colspan=13 rowspan=2 class=xl38 width=343 style='width:258pt'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl39></td>
  <td colspan=4 class=xl39></td>
  <td colspan=3 class=xl39></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 rowspan=2 class=xl37></td>
  <td colspan=4 rowspan=2 class=xl37></td>
  <td colspan=15 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td colspan=13 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl24></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=40 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=10 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl40><%= oDay%>/<%= oMonth%>/<%= oYear %></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl24>:</td>
  <td class=xl24></td>
  <td colspan=12 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=20 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=40 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td height=53 class=xl24 style='height:39.75pt'></td>
  <td colspan=26 class=xl41 width=648 style='width:489pt'></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=40 class=xl24 style='height:23.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl24 style='height:9.0pt'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28 x:str></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28 x:str></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28 x:str></td>
  <td class=xl28></td>
  <td colspan=15 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td colspan=4 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl26></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td colspan=18 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=40 class=xl24 style='height:6.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=8 class=xl24 style='height:22.5pt;mso-ignore:colspan'></td>
  <td colspan=17 class=xl42 <% if(oCurrType=="USD") %> style='mso-number-format:"\#\,\#\#0\.00";' <% else %> style='mso-number-format:"\#\,\#\#0";' x:num ><%= oMoneyAmt %></td>
  <td colspan=2 class=xl43><%= oCurrType %></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=4 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=33 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl24 style='height:13.5pt'></td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=19 class=xl44><%= oMoneyStr %></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=4 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=33 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 colspan=9 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
  <td colspan=18 class=xl45><%= oBenName %></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl24 style='height:18.0pt'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=18 class=xl44></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl26></td>
  <td colspan=38 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl26></td>
  <td colspan=38 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=40 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl24 style='height:18.75pt'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=18 class=xl46><%= oBenBank %></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl24 style='height:11.25pt'></td>
  <td class=xl26></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=18 rowspan=2 class=xl47><%= oBenBranch %></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 colspan=9 class=xl24 style='height:9.75pt;mso-ignore:colspan'></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 colspan=15 class=xl24 style='height:21.75pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl48><%= oBankAccount %></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=23 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'></td>
  <td class=xl26></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=23 class=xl49></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.95pt'>
  <td height=5 colspan=40 class=xl24 style='height:3.95pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl24 style='height:29.25pt'></td>
  <td colspan=6 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=33 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=12 style='mso-height-source:userset;height:9.0pt'>
  <td height=12 class=xl24 style='height:9.0pt'></td>
  <td class=xl26></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=16 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 colspan=40 class=xl24 style='height:7.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=10 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=17 class=xl50><%= oCompanyName  %></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=10 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=17 class=xl50><%= oCompanyBAccount %></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=10 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=17 class=xl50><%= oCompanyAddr %></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'></td>
  <td colspan=3 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=19 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl32><%= oCompanyTel %></td>
  <td colspan=3 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=14 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=13 class=xl44></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=14 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
  <td colspan=13 class=xl44></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=16 class=xl24 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=12 rowspan=2 class=xl51 width=271 style='width:205pt'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl24 style='height:17.25pt'></td>
  <td colspan=12 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=7 rowspan=3 class=xl52 width=138 style='width:104pt'></td>
  <td colspan=5 rowspan=3 class=xl37></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=16 class=xl24 style='height:5.25pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl33></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=16 class=xl24 style='height:10.5pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=16 class=xl24 style='height:6.0pt;mso-ignore:colspan'></td>
  <td colspan=7 rowspan=3 class=xl52 width=138 style='width:104pt'></td>
  <td colspan=5 rowspan=3 class=xl37></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=16 class=xl24 style='height:10.5pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=16 class=xl24 style='height:6.0pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=16 class=xl24 style='height:10.5pt;mso-ignore:colspan'></td>
  <td colspan=7 rowspan=2 class=xl52 width=138 style='width:104pt'></td>
  <td colspan=5 rowspan=2 class=xl37></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 colspan=16 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td class=xl34></td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=7 rowspan=2 class=xl52 width=138 style='width:104pt'></td>
  <td colspan=5 rowspan=2 class=xl37></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=16 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=16 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
  <td colspan=7 rowspan=2 class=xl52 width=138 style='width:104pt'></td>
  <td colspan=5 rowspan=2 class=xl37></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=16 class=xl24 style='height:11.25pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 colspan=16 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=7 rowspan=2 class=xl52 width=138 style='width:104pt'></td>
  <td colspan=5 rowspan=2 class=xl37></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=16 class=xl24 style='height:8.25pt;mso-ignore:colspan'></td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=16 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
  <td colspan=7 rowspan=2 class=xl52 width=138 style='width:104pt'></td>
  <td colspan=5 rowspan=2 class=xl37></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36></td>
  <td colspan=7 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24 style='height:12.0pt'></td>
  <td colspan=15 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl35></td>
  <%
  j += 1;
  }
 %>
  <td colspan=7 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=9 style='width:7pt'></td>
  <td width=15 style='width:11pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=32 style='width:24pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=17 style='width:13pt'></td>
  <td width=9 style='width:7pt'></td>
  <td width=17 style='width:13pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=17 style='width:13pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=17 style='width:13pt'></td>
  <td width=24 style='width:18pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=12 style='width:9pt'></td>
  <td width=25 style='width:19pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=34 style='width:26pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=156 style='width:117pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=251 style='width:188pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
