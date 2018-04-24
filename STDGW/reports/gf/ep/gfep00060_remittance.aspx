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
string l_datefr = "", l_dateto = "";
l_datefr = Request["sdt"];
l_dateto = Request["edt"];
DateTime l_today = DateTime.Today;
int oMonth	= l_today.Month;
int oDay	= l_today.Day;
int oYear	= l_today.Year;
string sMonth = "", sDay = "", sYear = oYear.ToString();
if(oMonth <= 9)
	sMonth = "0" + oMonth.ToString();	
if(oDay <= 9)
	sDay = "0" + oDay.ToString();
string sDate = sDay + "/" + sMonth + "/" + sYear ;
string SQL
	= "SELECT ACCOUNT_NO, CCY, PARTNER_LNAME from TAC_ABDEPOMT A, COMM.TCO_BUSPARTNER B  " + 
        "WHERE A.TCO_BUSPARTNER_PK = B.PK AND A.DEL_IF =0 AND B.DEL_IF =0 AND A.PK = " + iBankPk ;
DataTable rs = new DataTable();
rs = ESysLib.TableReadOpen(SQL);
string oCompanyBAccount = "", oCCy = "", oBankName = "";
if(rs.Rows.Count > 0)
{
	if(rs.Rows[0][0].ToString().Trim() != "")
		oCompanyBAccount = rs.Rows[0][0].ToString();
	else
		oCompanyBAccount = "";
	if(rs.Rows[0][1].ToString().Trim() != "")
		oCCy = rs.Rows[0][1].ToString().Trim();
	else
		oCCy = "";
	if(rs.Rows[0][2].ToString().Trim() != "" )		
		oBankName = rs.Rows[0][2].ToString();
	else
		oBankName = "";
}
	string p_xls_ccy_format="";
	 
    if (oCCy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
	
 SQL
	= "SELECT PARTNER_LNAME, ADDR1, ADDR2, ADDR3, PHONE_NO  FROM COMM.TCO_COMPANY WHERE DEL_IF = 0 AND ACTIVE_YN = 'Y'  AND PK IN " + 
        " (SELECT TCO_COMPANY_PK FROM TAC_ABDEPOMT WHERE PK =  " + iBankPk + " ) " ;
DataTable rs1 = new DataTable();
rs1 = ESysLib.TableReadOpen(SQL);
string oCompanyName = "", oCompanyAddr = "", oCompanyTel = "";
if(rs1.Rows.Count > 0)
{
	if(rs1.Rows[0][0].ToString().Trim() != "")
		oCompanyName = rs1.Rows[0][0].ToString();
	else	
		oCompanyName = "";
	if(rs1.Rows[0][1].ToString().Trim() != "")			
		oCompanyAddr = rs1.Rows[0][1].ToString().Trim();
	else
		oCompanyAddr = "";
	if(rs1.Rows[0][4].ToString().Trim() != "")			
		oCompanyTel = rs1.Rows[0][4].ToString().Trim();
	else
		oCompanyTel = "";
}
 /*SQL
	= " select sum(a.pay_famt) trans_amt " + 
        " from tfn_eppaytr a ,comm.tco_buspartner c      " +
        " where a.del_if = 0          " +
		" and c.del_if = 0          " +
        "    and a.tco_buspartner_pk = c.pk           " +
        "    and a.pay_date between '" + l_datefr + "' and '" + l_dateto + "' " +
        "    and a.tac_bfdepomt_pk in ( " + iBankPk + " ) " +
        "    and a.pay_type in ('03', '04', '21', '22') " ;
	DataTable rstotal = new DataTable();
	rstotal = ESysLib.TableReadOpen(SQL);	
decimal oTotal_Pay = 0;	
string l_ccy = "";
if(rstotal.Rows.Count > 0)
{
	if(rstotal.Rows[0][0].ToString().Trim() != "")
		oTotal_Pay = decimal.Parse(rstotal.Rows[0][0].ToString());		
}	*/
	DataTable rs2 = new DataTable();
	int i;
SQL
	= " select b.bedefi_nm, b.bedefi_bank_nm, b.branch, b.account_no , c.tco_buspartner_pk, nvl(c.pay_famt, 0) amt, c.partner_id, c.pay_ccy    " + 
        " from tac_bfbeneficiary b,( select a.tco_buspartner_pk, a.pay_ccy, c.partner_id, " +
         " sum(a.pay_famt) pay_famt   " +
         " from tfn_eppaytr a, comm.tco_buspartner c " +
          "  where a.del_if = 0 " +                                                        
           " and a.tac_bfdepomt_pk in ( " + iBankPk + " ) " +
            " and a.tco_buspartner_pk = c.pk " +
          "  and a.pay_type in ('03', '04', '21', '22')  " +
          "  and a.pay_date between '" + l_datefr + "' and '" + l_dateto + "' " +
         " group by a.tco_buspartner_pk, a.pay_ccy, c.partner_id  " +
        " ) c       " +
        "    where b.tco_dccust_pk = c.tco_buspartner_pk    " +        		
		"    and b.del_if = 0    " +	
        "    order by c.partner_id asc   " ;		
	rs2 = ESysLib.TableReadOpen(SQL);
decimal oTotal_Pay = 0;	
string l_ccy = "";
	
	for( i = 0; i < rs2.Rows.Count; i++)
	{
		if(rs2.Rows[i][5].ToString().Trim() != "")				
			oTotal_Pay += decimal.Parse(rs2.Rows[i][5].ToString());			
	}		
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Page_files/filelist.xml">
<style id="Page_189_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in 0in 1.0in 0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}	
.xl25189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl26189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl27189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl28189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl29189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl30189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl31189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl32189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl33189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl34189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl35189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl36189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl37189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl38189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl39189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl40189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl41189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl42189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;	
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl43189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl44189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:13.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl45189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl46189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl47189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;	
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";}
.xl48189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl49189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl50189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl51189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl52189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl53189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl54189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:top;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl55189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;
	}
.xl56189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl58189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl59189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid black;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl62189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl63189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl64189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl65189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl66189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl67189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl68189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl69189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl70189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl71189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl72189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl73189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:bottom;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl74189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl75189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl76189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid black;
	border-left:1.0pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl77189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl78189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl79189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl80189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl81189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl82189
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}

-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>wabf016000_transfer</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>78</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12390</x:WindowHeight>
  <x:WindowWidth>19200</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>255</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>
<body>
<div id="Page_189" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1550 class=xl25189
 style='border-collapse:collapse;table-layout:fixed;width:1164pt'>
 <col class=xl25189 width=37 style='mso-width-source:userset;mso-width-alt:
 1353;width:28pt'>
 <col class=xl25189 width=328 style='mso-width-source:userset;mso-width-alt:
 11995;width:246pt'>
 <col class=xl25189 width=21 style='mso-width-source:userset;mso-width-alt:
 768;width:16pt'>
 <col class=xl25189 width=189 style='mso-width-source:userset;mso-width-alt:
 6912;width:142pt'>
 <col class=xl25189 width=21 style='mso-width-source:userset;mso-width-alt:
 768;width:16pt'>
 <col class=xl25189 width=306 style='mso-width-source:userset;mso-width-alt:
 11190;width:230pt'>
 <col class=xl25189 width=163 style='mso-width-source:userset;mso-width-alt:
 5961;width:122pt'>
 <col class=xl25189 width=165 style='mso-width-source:userset;mso-width-alt:
 6034;width:124pt'>
 <col class=xl25189 width=64 span=5 style='width:48pt'>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=6 rowspan=2 height=35 class=xl26189 width=902 style='height:26.25pt;
  width:678pt'><%=oCompanyName%></td>
  <td class=xl26189 width=163 style='width:122pt'></td>
  <td class=xl27189 width=165 style='width:124pt'></td>
  <td class=xl25189 width=64 style='width:48pt'></td>
  <td class=xl25189 width=64 style='width:48pt'></td>
  <td class=xl25189 width=64 style='width:48pt'></td>
  <td class=xl25189 width=64 style='width:48pt'></td>
  <td class=xl25189 width=64 style='width:48pt'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 class=xl26189 style='height:13.5pt'></td>
  <td class=xl28189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl29189 style='height:14.25pt'></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl30189></td>
  <td class=xl30189></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl29189 style='height:16.5pt'></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td colspan=2 class=xl31189>Date:</td>
  <td class=xl31189><%=sDate%></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:16.35pt'>
  <td height=21 class=xl29189 colspan=6 style='height:16.35pt'>We apply for
  remittance beating any responsibility<span style='mso-spacerun:yes'> 
  </span>under this remittance<span style='mso-spacerun:yes'>  </span>and also
  agreeing that</td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:16.35pt'>
  <td height=21 class=xl29189 colspan=5 style='height:16.35pt'>is subject to
  the bank's terms and conditions and the Government 's law as well</td>
  <td class=xl25189></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:16.35pt'>
  <td height=21 class=xl29189 colspan=6 style='height:16.35pt'>Đề nghị Ngân
  hàng chuyển tiền cho chúng tôi theo nội dung dưới đây,chúng tôi cam kết chịu
  trách nhiệm</td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:16.35pt'>
  <td height=21 class=xl29189 colspan=6 style='height:16.35pt'>cũng như tuân
  theo các quy chế về chuyển tiền của nhà nước và quy định của Ngân hàng</td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:16.35pt'>
  <td height=21 class=xl29189 style='height:16.35pt'></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl25189></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:16.35pt'>
  <td height=21 class=xl32189 align=right style='height:16.35pt' x:num>1</td>
  <td class=xl29189>Applicant:</td>
  <td class=xl29189></td>
  <td class=xl29189>Name:</td>
  <td class=xl34189><%=oCompanyName%></td>
  <td class=xl34189></td>
  <td class=xl34189></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:16.35pt'>
  <td height=21 class=xl29189 style='height:16.35pt'></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl29189>Tel.No:</td>
  <td colspan=2 class=xl35189><%= oCompanyTel %></td>
  <td class=xl35189></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:16.35pt'>
  <td height=21 class=xl29189 style='height:16.35pt'></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl29189>Address:</td>
  <td class=xl34189><%= oCompanyAddr %></td>
  <td class=xl34189></td>
  <td class=xl25189></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl29189 style='height:16.5pt'></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl29189 x:str>Bank Name:</td>
  <td class=xl33189><%=oBankName%></td>
  <td class=xl33189></td>
  <td class=xl25189></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl29189 style='height:17.25pt'></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl29189>Debit Account:</td>
  <td class=xl33189><%= oCompanyBAccount %></td>
  <td class=xl33189></td>
  <td class=xl25189></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl32189 style='height:17.25pt'></td>
  <td class=xl29189>Reason</td>
  <td class=xl29189></td>
  <td class=xl29189>Payment for suppliers</td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl29189></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl36189 style='height:15.75pt'></td>
  <td class=xl27189></td>
  <td class=xl27189></td>
  <td class=xl27189></td>
  <td class=xl27189></td>
  <td class=xl27189></td>
  <td class=xl27189></td>
  <td class=xl27189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr class=xl37189 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td rowspan=3 height=78 class=xl74189 style='border-bottom:1.0pt solid black;
  height:58.5pt'>No</td>
  <td rowspan=3 class=xl63189 style='border-bottom:1.0pt solid black'>Beneficiary</td>
  <td colspan=2 rowspan=3 class=xl77189 style='border-right:.5pt solid black;
  border-bottom:1.0pt solid black'>Account Number</td>
  <td colspan=2 rowspan=3 class=xl77189 style='border-right:.5pt solid black;
  border-bottom:1.0pt solid black'>Bank</td>
  <td rowspan=3 class=xl63189 style='border-bottom:1.0pt solid black'>Branch</td>
  <td rowspan=3 class=xl66189 style='border-bottom:1.0pt solid black'>Amount
  (transfer)</td>
  <td rowspan=3 class=xl69189 style='border-bottom:1.0pt solid black'>Remarks</td>
  <td class=xl37189></td>
  <td class=xl37189></td>
  <td class=xl37189></td>
  <td class=xl37189></td>
 </tr>
 <tr class=xl37189 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl37189 style='height:19.5pt'></td>
  <td class=xl37189></td>
  <td class=xl37189></td>
  <td class=xl37189></td>
 </tr>
 <tr class=xl37189 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl37189 style='height:19.5pt'></td>
  <td class=xl37189></td>
  <td class=xl37189></td>
  <td class=xl37189></td>
 </tr>
 <tr class=xl38189 height=26 style='height:19.5pt'>
  <td height=26 class=xl39189 style='height:19.5pt'>&nbsp;</td>
  <td class=xl40189>TOTAL</td>
  <td colspan=2 class=xl72189><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td colspan=2 class=xl73189>&nbsp;</td>
  <td class=xl41189>&nbsp;</td>
  <% if(oCCy=="VND") { %>
  <td class=xl48189 x:num><%= oTotal_Pay %></td>
  <% } else { %>
  <td class=xl47189 x:num><%= oTotal_Pay %></td>
  <% } %>
  <td class=xl43189><u style='visibility:hidden;mso-ignore:visibility'>&nbsp;</u></td>
  <td class=xl38189></td>
  <td class=xl38189></td>
  <td class=xl38189></td>
  <td class=xl38189></td>
 </tr>
  <%
	if( rs2.Rows.Count > 0 )
	{
		for(i = 0; i < rs2.Rows.Count; i++)
		{
		if(i != rs2.Rows.Count - 1)
		{	
%>
 <tr class=xl30189 height=75 style='mso-height-source:userset;height:56.25pt'>
  <td height=75 class=xl55189 width=37 style='height:56.25pt;width:28pt'><%= i + 1 %></td>
  <td class=xl55189 width=328 style='width:246pt;border-right:.5pt solid windowtext;'><%= rs2.Rows[i][0] %></td>
  <td colspan=2 class=xl55189 style='border-right:.5pt solid black;border-left:
  none'><%= rs2.Rows[i][3] %></td>
  <td colspan=2 class=xl55189 width=327 style='border-right:.5pt solid black;
  border-left:none;width:246pt'><%= rs2.Rows[i][1] %></td>
  <td class=xl55189 width=163 style='width:122pt'><%= rs2.Rows[i][2] %></td>
  <% if(oCCy == "VND") { %>
  <td class=xl48189 width=165 x:num style='width:124pt;text-align:right; ' ><%= rs2.Rows[i][5] %></td>
  <% } else { %>
  <td class=xl47189 width=165 x:num style='width:124pt;text-align:right; ' ><%= rs2.Rows[i][5] %></td>
  <% } %>  
  <td class=xl55189 width=64 style='width:48pt; border-right:1pt solid black'>&nbsp;</td>
  <td class=xl30189></td>
  <td class=xl30189></td>
  <td class=xl30189></td>
  <td class=xl30189></td>
 </tr>
 <% 	}
		else
		{
%>
<tr class=xl30189 height=75 style='mso-height-source:userset;height:56.25pt'>
  <td height=75 class=xl44189 width=37 style='height:56.25pt;width:28pt'><%= i + 1 %></td>
  <td class=xl45189 width=328 style='width:246pt; border-right:.5pt solid windowtext;'><%= rs2.Rows[i][0] %></td>
  <td colspan=2 class=xl59189 style='border-right:.5pt solid black;border-left:
  none'><%= rs2.Rows[i][3] %></td>
  <td colspan=2 class=xl61189 width=327 style='border-right:.5pt solid black;
  border-left:none;width:246pt'><%= rs2.Rows[i][1] %></td>
  <td class=xl46189 width=163 style='width:122pt'><%= rs2.Rows[i][2] %></td>
  <% if(oCCy == "VND") { %>
  <td class=xl48189 width=165 x:num style='width:124pt;text-align:right; ' ><%= rs2.Rows[i][5] %></td>
  <% } else { %>
  <td class=xl47189 width=165 x:num style='width:124pt;text-align:right; ' ><%= rs2.Rows[i][5] %></td>
  <% } %>  
  <td class=xl48189 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl30189></td>
  <td class=xl30189></td>
  <td class=xl30189></td>
  <td class=xl30189></td>
 </tr>
 <%
		}	
	} 
 }
 %>
 <tr height=25 style='height:18.75pt'>
  <td height=25 class=xl49189 style='height:18.75pt'>&nbsp;</td>
  <td class=xl49189>&nbsp;</td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl49189>&nbsp;</td>
  <td class=xl49189>&nbsp;</td>
  <td class=xl49189>&nbsp;</td>
  <td class=xl30189></td>
  <td class=xl30189></td>
  <td class=xl30189></td>
  <td class=xl30189></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25189 style='height:15.0pt'></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl25189 style='height:14.25pt'></td>
  <td rowspan=2 class=xl54189
  x:str="Charge:                                                                      ">Charge:<span
  style='mso-spacerun:yes'>                                                                      </span></td>
  <td class=xl50189>&nbsp;</td>
  <td class=xl25189><span style='mso-spacerun:yes'> </span>Beneficiary</td>
  <td class=xl50189>&nbsp;</td>
  <td class=xl25189><span style='mso-spacerun:yes'> </span>Application</td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25189 style='height:15.75pt'></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl51189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl25189 style='height:14.25pt'></td>
  <td rowspan=2 class=xl54189>Other bank's charge:</td>
  <td class=xl50189>&nbsp;</td>
  <td class=xl25189><span style='mso-spacerun:yes'> </span>Beneficiary</td>
  <td class=xl52189>&nbsp;</td>
  <td class=xl25189><span style='mso-spacerun:yes'> </span>Application</td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td height=34 class=xl25189 style='height:25.5pt'></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl53189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25189 style='height:15.0pt'></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25189 style='height:15.0pt'></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25189 style='height:15.0pt'></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25189 style='height:15.0pt'></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25189 style='height:15.0pt'></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl25189 style='height:15.0pt'></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189>Signed &amp; Stamped</td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
  <td class=xl25189></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=37 style='width:28pt'></td>
  <td width=328 style='width:246pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=189 style='width:142pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=306 style='width:230pt'></td>
  <td width=163 style='width:122pt'></td>
  <td width=165 style='width:124pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
