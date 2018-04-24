<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string SQL = "";
	SQL = "";
	// get int param
	string ls_compk = Request["company_pk"];
	string ls_accpk = Request["acctcode_pk"];
	string ls_custpk = Request["cust_pk"];
	string ls_from_dt = Request["from_dt"];
	string ls_to_dt = Request["to_dt"];
	//Company	
	string p_cmp_name = "", p_cmp_add = "", p_cmp_tax = "";
	SQL = "select PARTNER_NAME, ADDR1 || ' ' || ADDR2 || ' ' || ADDR3 cmp_add, tax_code from comm.tco_company where del_if = 0 and pk = '" + ls_compk + "' ";
	DataTable dtComp = ESysLib.TableReadOpen(SQL);	
	if(dtComp.Rows.Count > 0)
	{		
		p_cmp_name = dtComp.Rows[0][0].ToString();
		p_cmp_add = dtComp.Rows[0][1].ToString();
		p_cmp_tax = dtComp.Rows[0][2].ToString();
	}
	// main recordset
	string ls_params = "";
	ls_params = "'" + ls_compk + "', '" + ls_accpk + "', '" + ls_custpk + "', '" + ls_from_dt + "', '" + ls_to_dt + "'";
	DataTable dt = new DataTable();
	dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfep00080", ls_params);	
	
	// account code
	string p_ac_cd = "", p_ac_nm = "";
	SQL = "select ac_cd, ac_nm from tac_abacctcode where del_if = 0 and pk = '" + ls_accpk + "' ";
	DataTable dtAcc = ESysLib.TableReadOpen(SQL);	
	if(	dtAcc.Rows.Count > 0)
	{
		p_ac_cd = dtAcc.Rows[0][0].ToString();
		p_ac_nm = dtAcc.Rows[0][1].ToString();
	}
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Payable_AP%20List_files/filelist.xml">
<style id="Payable_AP List_123_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl24123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl25123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:right;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl26123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl27123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl28123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl29123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFCC;
	mso-pattern:auto none;
	white-space:normal;}
.xl30123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl31123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl32123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl33123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl34123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl35123
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:left;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
-->
</style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="Payable_AP List_123" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1112 class=xl24123
 style='border-collapse:collapse;table-layout:fixed;width:836pt'>
 <col class=xl24123 width=77 style='mso-width-source:userset;mso-width-alt:
 2816;width:58pt'>
 <col class=xl24123 width=282 style='mso-width-source:userset;mso-width-alt:
 10313;width:212pt'>
 <col class=xl24123 width=117 span=4 style='mso-width-source:userset;
 mso-width-alt:4278;width:88pt'>
 <col class=xl24123 width=118 style='mso-width-source:userset;mso-width-alt:
 4315;width:89pt'>
 <col class=xl24123 width=115 style='mso-width-source:userset;mso-width-alt:
 4205;width:86pt'>
 <col class=xl24123 width=52 style='mso-width-source:userset;mso-width-alt:
 1901;width:39pt'>
 <tr height=16 style='height:12.0pt'>
  <td colspan=4 height=16 class=xl35123 width=593 style='height:12.0pt;
  width:446pt'><%=p_cmp_name%></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=118 style='width:89pt'></td>
  <td class=xl24123 width=115 style='width:86pt'></td>
  <td class=xl24123 width=52 style='width:39pt'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24123 width=77 style='height:12.0pt;width:58pt'><%=p_cmp_add%></td>
  <td class=xl24123 width=282 style='width:212pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=118 style='width:89pt'></td>
  <td class=xl24123 width=115 style='width:86pt'></td>
  <td class=xl24123 width=52 style='width:39pt'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24123 width=77 style='height:12.0pt;width:58pt'>as at….</td>
  <td class=xl24123 width=282 style='width:212pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=118 style='width:89pt'></td>
  <td class=xl24123 width=115 style='width:86pt'></td>
  <td class=xl24123 width=52 style='width:39pt'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24123 width=77 style='height:12.0pt;width:58pt'></td>
  <td class=xl25123 width=282 style='width:212pt'>Account code</td>
  <td class=xl26123 width=117 style='width:88pt' x:str><%=p_ac_cd%></td>
  <td colspan=3 class=xl26123 width=351 style='width:264pt'><%=p_ac_nm%></td>
  <td class=xl24123 width=118 style='width:89pt'></td>
  <td class=xl24123 width=115 style='width:86pt'></td>
  <td class=xl24123 width=52 style='width:39pt'></td>
 </tr>
 <tr height=16 style='height:12.0pt'>
  <td height=16 class=xl24123 width=77 style='height:12.0pt;width:58pt'></td>
  <td class=xl24123 width=282 style='width:212pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=117 style='width:88pt'></td>
  <td class=xl24123 width=118 style='width:89pt'></td>
  <td class=xl24123 width=115 style='width:86pt'></td>
  <td class=xl24123 width=52 style='width:39pt'></td>
 </tr>
 <tr class=xl27123 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl28123 width=77 style='height:20.25pt;width:58pt'>Customer
  ID</td>
  <td class=xl29123 width=282 style='width:212pt'>Customer Name</td>
  <td class=xl29123 width=117 style='width:88pt'>A/P</td>
  <td class=xl29123 width=117 style='width:88pt'>Payable List</td>
  <td class=xl29123 width=117 style='width:88pt'>Diff Amount</td>
  <td class=xl29123 width=117 style='width:88pt'>A/P(Trans)</td>
  <td class=xl29123 width=118 style='width:89pt'>Payable List(Trans)</td>
  <td class=xl29123 width=115 style='width:86pt'>Diff Amount(Trans)</td>
  <td class=xl29123 width=52 style='width:39pt'>Remark</td>
 </tr>
 <%
	int i;
	decimal l_ap_bal = 0, l_payable_bal = 0, l_diff_amt = 0, l_ap_fbal = 0, l_payable_fbal = 0, l_diff_famt = 0;
	for(i = 0; i < dt.Rows.Count; i++)
	{
		if(dt.Rows[i][3].ToString() != "")
		{
			l_ap_bal += decimal.Parse(dt.Rows[i][3].ToString());
		}
		if(dt.Rows[i][4].ToString() != "")
		{
			l_payable_bal += decimal.Parse(dt.Rows[i][4].ToString());
		}
		if(dt.Rows[i][5].ToString() != "")
		{
			l_diff_amt += decimal.Parse(dt.Rows[i][5].ToString());
		}
		if(dt.Rows[i][6].ToString() != "")
		{
			l_ap_fbal += decimal.Parse(dt.Rows[i][6].ToString());
		}
		if(dt.Rows[i][7].ToString() != "")
		{
			l_payable_fbal += decimal.Parse(dt.Rows[i][7].ToString());
		}
		if(dt.Rows[i][8].ToString() != "")
		{
			l_diff_famt += decimal.Parse(dt.Rows[i][8].ToString());
		}
		
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30123 width=77 style='height:15.0pt;width:58pt'><%=dt.Rows[i][1]%></td>
  <td class=xl31123 width=282 style='width:212pt'><%=dt.Rows[i][2]%></td>
  <td class=xl32123 width=117 style='width:88pt' x:num><%=dt.Rows[i][3]%> </td>
  <td class=xl32123 width=117 style='width:88pt' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl32123 width=117 style='width:88pt' x:num><%=dt.Rows[i][5]%> </td>
  <td class=xl32123 width=117 style='width:88pt' x:num><%=dt.Rows[i][6]%> </td>
  <td class=xl32123 width=118 style='width:89pt' x:num><%=dt.Rows[i][7]%></td>
  <td class=xl32123 width=115 style='width:86pt' x:num><%=dt.Rows[i][8]%> </td>
  <td class=xl31123 width=52 style='width:39pt'>&nbsp;</td>
 </tr>
 <%
	}
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl33123 width=77 style='height:15.0pt;width:58pt'>TOTAL</td>
  <td class=xl31123 width=282 style='width:212pt'>&nbsp;</td>
  <td class=xl34123 width=117 style='width:88pt' x:num><%=l_ap_bal%> </td>
  <td class=xl34123 width=117 style='width:88pt' x:num><%=l_payable_bal%> </td>
  <td class=xl34123 width=117 style='width:88pt' x:num><%=l_diff_amt%> </td>
  <td class=xl34123 width=117 style='width:88pt' x:num><%=l_ap_fbal%> </td>
  <td class=xl34123 width=118 style='width:89pt' x:num><%=l_payable_fbal%> </td>
  <td class=xl34123 width=115 style='width:86pt' x:num><%=l_diff_famt%> </td>
  <td class=xl31123 width=52 style='width:39pt'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=77 style='width:58pt'></td>
  <td width=282 style='width:212pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=117 style='width:88pt'></td>
  <td width=118 style='width:89pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=52 style='width:39pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>
