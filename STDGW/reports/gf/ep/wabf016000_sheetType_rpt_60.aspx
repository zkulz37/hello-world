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
string iBankPk	= Request["bankPK"] ;
string iPKArr	= Request["pk"];

string oBankUsd = "";
string oBankVnd = "";
string oMoneyAmt = "";
string oMoneyStr = "";
string oTCO_DCCUSTM_PK = "";
string oRemark = "" ;
string oCurrType = "";
string oDate = "" ;

string oBankAccount = "";
string oBenName = "";
string oBenBank = "";
string oBenBranch = "";

string oCompanyName = "" ;
string oCompanyAddr = "";
string oCompanyTel = "";
string oCompanyBAccount = "";

int oCountCustomer = 0;
string SQL = "";
SQL = "SELECT ACCOUNT_NO FROM TAC_ABDEPOMT WHERE DEL_IF = 0 AND PK = '" + iBankPk + "'";
DataTable rs = new DataTable();
rs = ESysLib.TableReadOpen(SQL);
if(rs.Rows.Count > 0)
	oCompanyBAccount = rs.Rows[0][0].ToString();

SQL
	= "SELECT PARTNER_LNAME, ADDR1, ADDR2, ADDR3, PHONE_NO FROM COMM.TCO_COMPANY WHERE DEL_IF = 0 AND ACTIVE_YN = 'Y'  AND PK IN  " + 
        " (SELECT TCO_COMPANY_PK FROM TAC_ABDEPOMT WHERE PK = '" + iBankPk + "')  " ;
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
        "    and a.pk in ('" + iPKArr + "') " +
        "	and a.tfn_eppay_pk = b.tfn_eppay_pk	 " +		
        " and b.tco_buspartner_pk = c.pk  " +
		" and a.tfn_eppaytrh_pk = h.pk  " +
        " group by b.tco_buspartner_pk, a.tr_ccy, b.pay_famt, a.pay_type, c.ven_trade_type )  " +
        " group by tco_buspartner_pk  " ;
DateTime l_today = new DateTime();
l_today = DateTime.Today;
int oMonth	= l_today.Month;
int oDay	= l_today.Day;
int oYear	= l_today.Year;
string sMonth = "", sDay = "";
if(oMonth <= 9 )
	sMonth = "0" + oMonth.ToString();
if(oDay <= 9)
	sDay = "0" + oDay.ToString();
string SQL_COUNT
	= "SELECT COUNT( DISTINCT D.TCO_BUSPARTNER_PK) NumCust FROM TFN_EPPAYTR A, TFN_EPPAYTRD D  " + 
        "WHERE A.DEL_IF = 0  " +
        "AND D.DEL_IF = 0 " +
        "AND A.TFN_EPPAY_PK = D.TFN_EPPAY_PK " +
        "AND A.PK IN ('" + iPKArr + "') " ;
DataTable rs_count = new DataTable();
rs_count			= ESysLib.TableReadOpen(SQL_COUNT);
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
  <o:LastPrinted>2007-08-17T02:43:42Z</o:LastPrinted>
  <o:Created>2007-06-25T02:49:11Z</o:Created>
  <o:LastSaved>2010-01-08T05:56:04Z</o:LastSaved>
  <o:Company>VinaGenuWin</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.1in .1in .1in 1.0in;
	mso-header-margin:.1in;
	mso-footer-margin:.1in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
	{mso-number-format:Standard;
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
	mso-number-format:Standard;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;}
.xl39
	{mso-style-parent:style0;
	font-size:17.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]dd\\ mmmm\\ \\ yyyy";
	text-align:left;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl61
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;}
.xl66
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
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
       <x:Row><%= k * 31 %></x:Row>
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

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1745 style='border-collapse:
 collapse;table-layout:fixed;width:1309pt'>
 <%
 DataTable rs2 = new DataTable();
 rs2 = ESysLib.TableReadOpen(SQL);
 int j = 0; string SQL_BEN = "";
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
		oMoneyStr = CommondLib.Num2VNText(oMoneyAmt, oCurrType ) ;
	}			
	else 
	{
		oCurrType="VND";
		oMoneyAmt = oBankVnd;
		oMoneyStr = CommondLib.Num2VNText(oMoneyAmt, oCurrType ) ;
	} 
 %>
 <col class=xl24 width=15 style='mso-width-source:userset;mso-width-alt:548;
 width:11pt'>
 <col class=xl24 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl24 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl24 width=137 style='mso-width-source:userset;mso-width-alt:5010;
 width:103pt'>
 <col class=xl24 width=18 style='mso-width-source:userset;mso-width-alt:658;
 width:14pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=192 style='mso-width-source:userset;mso-width-alt:7021;
 width:144pt'>
 <col class=xl24 width=64 span=18 style='width:48pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 width=15 style='height:15.0pt;width:11pt'></td>
  <td class=xl25 width=75 style='width:56pt'></td>
  <td class=xl25 width=92 style='width:69pt'></td>
  <td class=xl25 width=137 style='width:103pt'></td>
  <td class=xl25 width=18 style='width:14pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=192 style='width:144pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl25 style='height:25.5pt'></td>
  <td colspan=6 class=xl39>Ho Chi Minh City Rep.Office</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl26 colspan=3 style='mso-ignore:colspan'>Diamond Plaza, Unit
  502,5th floor</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl26>Tel :84-8-827-4273</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl26 colspan=3 style='mso-ignore:colspan'>34 le Duan st., Dist 1 Ho
  Chi Minh City</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl26>Fax : 84-8-827-4273</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl26>Number of Pages :</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td colspan=5 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl26>(including this cover)</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 colspan=25 class=xl25 style='height:11.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl25 style='height:20.25pt'></td>
  <td class=xl27>DATE :</td>
  <td colspan=2 class=xl40><%= sDay %>/<%= sMonth%>/<%= oYear %></td>
  <td class=xl28>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl25 style='height:27.75pt'></td>
  <td class=xl30>TO :</td>
  <td colspan=2 class=xl41 style='border-right:1.0pt solid black'>&nbsp;</td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>FM :</td>
  <td class=xl32><%= Session["USER_ID"] %></td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=25 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl33 colspan=6 style='mso-ignore:colspan'>(TEL NO: 00-84-4-771-6800
  FAX NO : 00-84-4-771-6784 or 8171)</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <td class=xl34></td>
  <td colspan=23 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl35 colspan=3 style='mso-ignore:colspan'>Subject : Request for
  Transfer</td>
  <td colspan=21 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=42 style='mso-height-source:userset;height:31.5pt'>
  <td height=42 class=xl25 style='height:31.5pt'></td>
  <td colspan=6 class=xl43 width=578 style='width:434pt'>In accordance with our
  facsimile transaction Agreement, I/ We would like to request you to transfer
  money as follows :</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=25 class=xl25 style='height:17.1pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl25 style='height:30.0pt'></td>
  <td class=xl36 colspan=2 style='mso-ignore:colspan'>&lt;Beneficiary&gt;</td>
  <td colspan=4 class=xl44>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl25 style='height:30.0pt'></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black'>Bank's Name</td>
  <td colspan=4 class=xl48 style='border-right:1.0pt solid black;border-left:
  none'><%= oBenBank %>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 class=xl25 style='height:22.5pt'></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black'>Account Number</td>
  <td colspan=4 class=xl48 style='border-right:1.0pt solid black;border-left:
  none'><%= oBankAccount%>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl25 style='height:30.0pt'></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black'>Beneficiary's
  Name</td>
  <td colspan=4 class=xl48 style='border-right:1.0pt solid black;border-left:
  none'><%= oBenName%>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl25 style='height:26.25pt'></td>
  <td colspan=2 class=xl50 style='border-right:.5pt solid black'>Amount in
  Figures</td>
  <td colspan=3 class=xl53 style='border-left:none' <% if(oCurrType=="VND") %> style='mso-number-format:\#\,\#\#0;'
  x:num ><%= oMoneyAmt%></td>
  <td class=xl37><%= oCurrType%>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl25 style='height:27.0pt'></td>
  <td colspan=2 class=xl54 style='border-right:.5pt solid black'>(in words)</td>
  <td colspan=4 class=xl57 width=411 style='border-right:1.0pt solid black; border-left:none;width:309pt' ><%=  oMoneyStr%>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=3 class=xl25 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl25 style='height:17.1pt'></td>
  <td class=xl36 colspan=2 style='mso-ignore:colspan'>&lt;Applicant&gt;</td>
  <td colspan=4 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl25 style='height:30.0pt'></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black'>Applicant's
  Name</td>
  <td colspan=4 class=xl60 style='border-right:1.0pt solid black;border-left:
  none'><%= oCompanyName%>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=38 style='mso-height-source:userset;height:28.5pt'>
  <td height=38 class=xl25 style='height:28.5pt'></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black'>Account Number</td>
  <td colspan=4 class=xl60 style='border-right:1.0pt solid black;border-left:
  none'><%= oCompanyBAccount%>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl25 style='height:30.0pt'></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black'>Secret Code</td>
  <td colspan=4 class=xl60 style='border-right:1.0pt solid black;border-left:
  none' x:num>3025</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=78 style='mso-height-source:userset;height:58.5pt'>
  <td height=78 class=xl25 style='height:58.5pt'></td>
  <td colspan=2 class=xl62 style='border-right:.5pt solid black'>Details of
  Payment</td>
  <td colspan=4 class=xl65 style='border-right:1.0pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'></td>
  <td colspan=2 class=xl38 style='mso-ignore:colspan'></td>
  <td colspan=22 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl25 style='height:23.25pt'></td>
  <td colspan=3 class=xl67 style='border-right:.5pt solid black'>Signature</td>
  <td colspan=3 class=xl70 style='border-right:.5pt solid black;border-left:
  none'>Seal</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=140 style='mso-height-source:userset;height:105.0pt'>
  <td height=140 class=xl25 style='height:105.0pt'></td>
  <td colspan=3 class=xl71 style='border-right:.5pt solid black'>&nbsp;</td>
  <td colspan=3 class=xl74 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=18 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl25 style='height:15.0pt'></td>
  <%
  j += 1;
  }
 %>
  <td colspan=24 class=xl25 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=15 style='width:11pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=18 style='width:14pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=192 style='width:144pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
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
