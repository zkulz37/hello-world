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
string oRemark = "";
string oCurrType = "" ;
string oBankAccount ="";
string oBenName = "" ;
string oBenBank = "";
string oBenBranch = "";
string oCompanyName = "";
string oCompanyAddr = "";
string oCompanyTel = "";
string oCompanyBAccount = "";
string SQL = "SELECT ACCOUNT_NO FROM TAC_ABDEPOMT WHERE PK = '" + iBankPk + "'";
	DataTable rs = new DataTable();
	rs = ESysLib.TableReadOpen(SQL);			

 if(rs.Rows.Count > 0)
	oCompanyBAccount = rs.Rows[0][0].ToString();

	SQL
	= "SELECT PARTNER_LNAME, ADDR1, ADDR2, ADDR3, PHONE_NO  FROM COMM.TCO_COMPANY WHERE DEL_IF = 0 AND ACTIVE_YN = 'Y'  AND PK =  " + 
        " (SELECT TCO_COMPANY_PK FROM TAC_ABDEPOMT WHERE PK = '" + iBankPk + "') " ;

//TableReadOpen rs, SQL
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
	= "SELECT  TCO_BUSPARTNER_PK, SUM(bank_usd) USD, SUM (bank_vnd) VND  " + 
        " FROM  " +
        " (SELECT  " +
        " A.TCO_BUSPARTNER_PK  " +
        " , decode(B.PAY_TYPE, '03', DECODE(B.TR_CCY, 'USD', sum(a.PAY_FAMT), decode(C.VEN_TRADE_TYPE,'IM', sum(a.PAY_FAMT),'')), '04', DECODE(B.TR_CCY, 'USD',  sum(a.PAY_AMT), decode(C.VEN_TRADE_TYPE,'IM',  sum(a.PAY_AMT),'')), '')  bank_usd  " +
        " , decode(B.PAY_TYPE, '03', DECODE(B.TR_CCY, 'USD', '', decode(C.VEN_TRADE_TYPE,'IM','', sum(a.PAY_FAMT) )), '04', DECODE(B.TR_CCY, 'USD','', decode(C.VEN_TRADE_TYPE,'IM','',  sum(a.PAY_FAMT))), '')  bank_vnd  " +
        " FROM TFN_EPPAYTRD A,COMM.TCO_BUSPARTNER C, TFN_EPPAYTR B, TFN_EPPAYTRH H   " +
        " WHERE A.DEL_IF =0 " +
        "	AND B.DEL_IF = 0  " +
		"	AND H.DEL_IF = 0  " +
        "	AND B.PK IN ( " + iPKArr + " ) " +
        " AND A.TCO_BUSPARTNER_PK = C.PK " +
        "	AND A.TFN_EPPAY_PK = B.TFN_EPPAY_PK  " +
		"	AND B.TFN_EPPAYTRH_PK = H.PK  " +
        " GROUP BY  A.TCO_BUSPARTNER_PK, B.TR_CCY, a.PAY_FAMT, B.PAY_TYPE, C.VEN_TRADE_TYPE )  " +
        " GROUP BY TCO_BUSPARTNER_PK  " ;
DateTime oDate = DateTime.Today;
string SQL_COUNT = "";
SQL_COUNT
	= "SELECT COUNT( DISTINCT TCO_BUSPARTNER_PK) NumCust FROM TFN_EPPAYTR A, TFN_EPPAYTRD B  " + 
        "WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TFN_EPPAY_PK = B.TFN_EPPAY_PK AND A.PK IN (" + iPKArr + ") " ;
	DataTable rs_count = new DataTable();
	rs_count = ESysLib.TableReadOpen(SQL_COUNT);					
	int oCountCustomer = 0;	
 if(rs_count.Rows.Count > 0)
 {
	oCountCustomer = int.Parse(rs_count.Rows[0][0].ToString());
 }		
int oNumberPrint = oCountCustomer * 2 - 1 ;
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
  <o:LastPrinted>2007-07-17T01:33:06Z</o:LastPrinted>
  <o:Created>2007-07-16T04:26:43Z</o:Created>
  <o:LastSaved>2010-01-06T06:09:37Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in 0in 0in .4in;
	mso-header-margin:.5in;
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
	font-size:7.0pt;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"Short Date";}
.xl27
	{mso-style-parent:style0;
	font-size:9.0pt;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:right;}
.xl28
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:justify;
	vertical-align:top;}
.xl29
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	text-align:left;}
.xl31
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:justify;}
.xl32
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	text-align:justify;}
.xl33
	{mso-style-parent:style0;
	text-align:left;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:top;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	text-align:right;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:left;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	vertical-align:top;}
.xl42
	{mso-style-parent:style0;
	font-size:7.0pt;
	vertical-align:middle;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	vertical-align:top;}
.xl44
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl45
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-style:italic;}
.xl46
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	vertical-align:top;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:Standard;
	text-align:left;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:9.0pt;
	text-align:center;
	vertical-align:top;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:7.0pt;
	text-align:center;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	text-align:center;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>180</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:TopRowVisible>45</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>81</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
     <x:PageBreaks>
     <x:RowBreaks>
		<% int i; for(i = 1; i <= oNumberPrint; i++) { %><x:RowBreak>
       <x:Row><%= i * 17 %></x:Row>
      </x:RowBreak><% } %>
       </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8070</x:WindowHeight>
  <x:WindowWidth>15180</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->

</head>

<body link=blue vlink=purple class=xl24>

<table border=0 cellpadding=0 cellspacing=0 width=662 style='border-collapse:
 collapse;table-layout:fixed;width:496pt'>
<%
 DataTable rs2 = new DataTable();
 rs2 = ESysLib.TableReadOpen(SQL);
 int j = 0, d = 0;
 string nguyen = "", phan = "";
 string SQL_BEN = "";
 while(j < rs2.Rows.Count)
 {
	if(rs2.Rows[j][1].ToString().Trim()!="")
		oBankUsd = rs2.Rows[j][1].ToString();
	else
		oBankUsd = "";
	if(rs2.Rows[j][2].ToString().Trim()!="")	
		oBankVnd = rs2.Rows[j][2].ToString();
	else
		oBankVnd = "";
	if(rs2.Rows[j][0].ToString().Trim()!="")
		oTCO_DCCUSTM_PK = rs2.Rows[j][0].ToString() ;
	else
		oTCO_DCCUSTM_PK = "";
	SQL_BEN = "SELECT BEDEFI_NM, BEDEFI_BANK_NM, BRANCH, ACCOUNT_NO FROM TAC_BFBENEFICIARY WHERE DEL_IF = 0 AND  TCO_DCCUST_PK = '" + oTCO_DCCUSTM_PK + "'" ;
	DataTable rs_ben = new DataTable();
	rs_ben = ESysLib.TableReadOpen(SQL_BEN);		
	if(rs_ben.Rows.Count > 0)
	{
		if(rs_ben.Rows[0][0].ToString().Trim() != "")
			oBenName		= rs_ben.Rows[0][0].ToString();
		else
			oBenName		= "";
		if(rs_ben.Rows[0][1].ToString().Trim() != "")	
			oBenBank		= rs_ben.Rows[0][1].ToString();
		else
			oBenBank		= "";
		if(rs_ben.Rows[0][2].ToString().Trim() != "")			
			oBenBranch		= rs_ben.Rows[0][2].ToString();
		else
			oBenBranch		= "";
		if(rs_ben.Rows[0][3].ToString().Trim() != "")	
			oBankAccount	= rs_ben.Rows[0][3].ToString();
		else
			oBankAccount	= "";
	}
	if(oBankUsd != "")
	{
			oCurrType="USD";
			oMoneyAmt = oBankUsd ;
			d = oBankUsd.IndexOf('.');
			//if(d==0)			
			oMoneyStr = CommondLib.Num2VNText(oBankUsd, oCurrType) + " đô la";
			/*else
			{
				nguyen = oBankUsd.Substring(0, d-1);
				phan = oBankUsd.Substring(d+1, oBankUsd.Length);
				oMoneyStr = Num2TextUSD(nguyen) + " đô la lẻ " + Num2TextUSD(phan);
			}*/
	}				
	else 
	{
		oCurrType="VND";
		oMoneyAmt = oBankVnd;
		oMoneyStr = CommondLib.Num2VNText(oBankVnd, oCurrType) + " đồng";
	}
 %>
  <col class=xl24 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl24 width=200 style='mso-width-source:userset;mso-width-alt:7314;
 width:150pt'>
 <col class=xl24 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=20 style='mso-width-source:userset;mso-width-alt:731;
 width:15pt'>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl24 width=101 style='height:27.75pt;width:76pt'></td>
  <td class=xl25 width=200 style='width:150pt'></td>
  <td class=xl25 width=15 style='width:11pt'></td>
  <td class=xl25 width=103 style='width:77pt'></td>
  <td class=xl25 width=19 style='width:14pt'></td>
  <td class=xl24 width=88 style='width:66pt'></td>
  <td class=xl24 width=61 style='width:46pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=20 style='width:15pt'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl24 style='height:5.25pt'></td>
  <r>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=2 class=xl24 style='height:23.25pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl27 x:num x:fmla="= TODAY()"></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=9 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl29 style='height:21.75pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29></td>
  <td class=xl30></td>
  <td class=xl31><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl47></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=3 class=xl30 style='height:6.0pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl35 style='height:21.75pt'></td>
  <td class=xl36><%= oCompanyBAccount%></td>
  <td class=xl24></td>
  <td class=xl37></td>
  <td colspan=2 class=xl48 <% if(oCurrType=="USD") %> style='mso-number-format:"\#\,\#\#0\.00";font-size:10.0pt;font-weight:700;'<% else %>style='font-size:10.0pt;font-weight:700;' x:num ><%= oMoneyAmt %></td>
  <td class=xl39><%= oCurrType %></td>
  <td class=xl40></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl41 style='height:18.75pt'></td>
  <td class=xl42><%=oCompanyName%></td>
  <td class=xl24></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td class=xl24></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl34 style='height:14.25pt'></td>
  <td class=xl24>KHU CÔNG NGHIỆP NHƠN TRẠCH</td>
  <td class=xl24></td>
  <td colspan=4 rowspan=2 class=xl49 width=271 style='width:203pt'><%= oMoneyStr %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl34 style='height:11.25pt'></td>
  <td class=xl38></td>
  <td class=xl24></td>
  <td class=xl44></td>
  <td class=xl24></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=2 height=18 class=xl50 style='height:13.5pt'>VIETCOMBANK - NHƠN
  TRẠCH ĐỒNG NAI</td>
  <td class=xl24></td>
  <td class=xl45><span style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl24 style='height:28.5pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl51 width=326 style='width:244pt'></td>
  <td class=xl38></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl41 style='height:25.5pt'></td>
  <td class=xl25><%= oBankAccount%></td>
  <td class=xl24></td>
  <td colspan=6 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl41 style='height:18.75pt'></td>
  <td class=xl38><%= oBenName %></td>
  <td class=xl24></td>
  <td colspan=5 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl34 style='height:14.25pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl45></td>
  <td class=xl24></td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl34 style='height:8.25pt'></td>
  <td class=xl38></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl50 style='height:12.75pt'><%= oBenBank%></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl24 style='height:27.75pt'></td>
  <td colspan=4 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td colspan=9 height=7 class=xl24 style='height:5.25pt'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=2 class=xl24 style='height:23.25pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl27 x:num="40184" x:fmla="= TODAY()"></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=9 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl29 style='height:21.75pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl29></td>
  <td class=xl30></td>
  <td class=xl31><span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl47></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=3 class=xl30 style='height:6.0pt;mso-ignore:colspan'></td>
  <td class=xl32></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl35 style='height:21.75pt'></td>
  <td class=xl36><%= oCompanyBAccount%></td>
  <td class=xl24></td>
  <td class=xl37></td>
  <td colspan=2 class=xl48 <% if(oCurrType=="USD") %>style='mso-number-format:"\#\,\#\#0\.00";font-size:10.0pt;font-weight:700;' <% else %> style='font-size:10.0pt;font-weight:700;' x:num ><%= oMoneyAmt %></td>
  <td class=xl39><%= oCurrType %></td>
  <td class=xl40></td>
  <td class=xl24></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl41 style='height:18.75pt'></td>
  <td class=xl42><%=oCompanyName%></td>
  <td class=xl24></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl43 style='mso-ignore:colspan'></td>
  <td class=xl40></td>
  <td class=xl24></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl34 style='height:14.25pt'></td>
  <td class=xl24>KHU CÔNG NGHIỆP NHƠN TRẠCH</td>
  <td class=xl24></td>
  <td colspan=4 rowspan=2 class=xl49 width=271 style='width:203pt'><%= oMoneyStr %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl34 style='height:11.25pt'></td>
  <td class=xl38></td>
  <td class=xl24></td>
  <td class=xl44></td>
  <td class=xl24></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=2 height=18 class=xl50 style='height:13.5pt'>VIETCOMBANK - NHƠN
  TRẠCH ĐỒNG NAI</td>
  <td class=xl24></td>
  <td class=xl45><span style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl24 style='height:28.5pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=5 class=xl51 width=326 style='width:244pt'></td>
  <td class=xl38></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl41 style='height:25.5pt'></td>
  <td class=xl25><%= oBankAccount%></td>
  <td class=xl24></td>
  <td colspan=6 class=xl38 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl41 style='height:18.75pt'></td>
  <td class=xl38><%= oBenName %></td>
  <td class=xl24></td>
  <td colspan=5 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl34 style='height:14.25pt'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl45></td>
  <td class=xl24></td>
  <td colspan=2 class=xl45 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 class=xl34 style='height:8.25pt'></td>
  <td class=xl38></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl50 style='height:12.75pt'><%= oBenBank%></td>
  <td class=xl24></td>
  <%
 	j += 1;
 }
 %>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=101 style='width:76pt'></td>
  <td width=200 style='width:150pt'></td>
  <td width=15 style='width:11pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=20 style='width:15pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
