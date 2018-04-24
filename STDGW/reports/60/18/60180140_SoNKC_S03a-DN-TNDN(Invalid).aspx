<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session("APP_DBUSER"));
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company = Request["Company"];
	string l_date_from = Request["DateFrom"];
	string l_date_to = Request["DateTo"];
	string l_voucher = Request["Voucher"];
	string l_Seq = Request["Seq"];
	string l_Status = Request["Status"];
	string l_bookCcy = Request["BookCcy"];

	string l_bookformat = "";
	string l_date_fr2 = "";
	string l_date_to2 = "";
	string l_report_dd = "";
	string l_report_mm = "";
	string l_report_yy = "";
	string l_total_book_amt = "0";
	string l_row_height = "15";
	string l_cmp_name="";
	string l_cmp_add ="";
	string l_cmp_taxcode="";
    double l_total_ps = 0;
	
	string SQL = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company + "' ";
	
	DataTable dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
		l_cmp_name = dt.Rows[0][0].ToString();
		l_cmp_add = dt.Rows[0][1].ToString();
		l_cmp_taxcode = dt.Rows[0][3].ToString();
	}

	
SQL = " SELECT TO_CHAR(TO_DATE('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') DT_FR,  TO_CHAR(TO_DATE('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') DT_TO, ";
SQL = SQL + "ac_sf_get_format('ACBG0040'), TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'DD')  RP_DD,";
SQL = SQL + " TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'MM')  RP_MM, ";
SQL = SQL + " TO_CHAR(LAST_DAY(TO_DATE('" + l_date_to + "','YYYYMMDD')),'YYYY')  RP_YY, ";
SQL = SQL + " AC_SF_GET_FORMAT ('ACRP0010') ";
SQL = SQL + " FROM DUAL ";

	dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
	    l_date_fr2 = dt.Rows[0][0].ToString();
		l_date_to2 = dt.Rows[0][1].ToString();
		l_bookformat = dt.Rows[0][2].ToString();
		l_report_dd = dt.Rows[0][3].ToString();
		l_report_mm = dt.Rows[0][4].ToString();
		l_report_yy = dt.Rows[0][5].ToString();
		l_row_height = dt.Rows[0][6].ToString();
	}
	
	if (l_row_height == "")
	{
		l_row_height= "15";
	}

	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    if (l_bookCcy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
	
	/*
SQL = " SELECT H.PK, TO_CHAR(H.TR_DATE,ac_sf_get_format ('ACAB0300')) TR_DATE, H.VOUCHERNO, ";
SQL = SQL + "    SF_A_GET_ACCD(R.TAC_ABACCTCODE_PK_DR,"+l_company+"),  SF_A_GET_ACCD(R.TAC_ABACCTCODE_PK_CR,"+l_company+"), ";
SQL = SQL + "    SUM(R.TR_BOOKAMT), MAX(R.REMARK) , MAX(R.REMARK2),SF_GET_SEQ_PRINT_CONTROLITEM(H.PK)  ";
SQL = SQL + "    FROM TAC_HGTRH H,  TAC_HGTRD_REF R ";
SQL = SQL + "    WHERE H.DEL_IF = 0  ";
SQL = SQL + "    AND R.DEL_IF = 0 ";
SQL = SQL + "    AND H.PK = R.TAC_HGTRH_PK ";
SQL = SQL + "    AND R.DRCR_TYPE = 'D'  ";
SQL = SQL + "    AND H.TCO_COMPANY_PK =  " + l_company + " ";
SQL = SQL + "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '"+ l_date_from +"' AND '"+ l_date_to +"'   ";
SQL = SQL + "    AND H.TR_STATUS IN (DECODE ("+ l_Status +" , 2, 2, "+ l_Status +"),DECODE ("+ l_Status +", 2, 0, "+ l_Status +"), DECODE ("+ l_Status +", 2, 4, "+ l_Status +")) ";
SQL = SQL + "    AND ((TRIM('" + l_voucher +"') IS NULL) OR (UPPER (h.voucherno) LIKE'%' || UPPER (TRIM('" + l_voucher +"'))|| '%'))  ";
SQL = SQL + "    AND ((TRIM('" + l_Seq +"')  IS NULL) OR (h.pk = TRIM('" + l_Seq +"') ))  ";
SQL = SQL + "  GROUP BY H.PK, H.TR_DATE, H.VOUCHERNO, R.TAC_ABACCTCODE_PK_DR, R.TAC_ABACCTCODE_PK_CR ";
SQL = SQL + "  ORDER BY H.TR_DATE ASC,H.PK ";
*/
    SQL = " select pk, tr_date_fmt,voucherno, dracc,cracc,tr_bookamt,remark,remark2,'[Invalid]', tr_date  from(";
    SQL = SQL + "SELECT H.PK, TO_CHAR(H.TR_DATE,ac_sf_get_format ('ACAB0300')) tr_date_fmt, H.VOUCHERNO, ";
SQL = SQL + "    SF_A_GET_ACCD(R.TAC_ABACCTCODE_PK_DR," + l_company + ") dracc,  SF_A_GET_ACCD(R.TAC_ABACCTCODE_PK_CR," + l_company + ") cracc, ";
SQL = SQL + "    R.TR_BOOKAMT, R.REMARK , R.REMARK2 ,H.TR_DATE  ";
SQL = SQL + "    FROM TAC_HGTRH H,  TAC_HGTRD_REF R,TAC_HGTRDITEM a ";
SQL = SQL + "    WHERE H.DEL_IF = 0  ";
SQL = SQL + "    AND R.DEL_IF = 0 ";
SQL = SQL + "    AND H.PK = R.TAC_HGTRH_PK ";
SQL = SQL + "    AND R.DRCR_TYPE = 'D' AND A.DEL_IF =0 and a.TAC_HGTRD_PK = r.tac_hgtrd_pk AND UPPER(a.ITEM) = UPPER('INVALID') ";
SQL = SQL + "    AND H.TCO_COMPANY_PK =  " + l_company + " ";
SQL = SQL + "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'   ";
SQL = SQL + "    AND H.TR_STATUS IN (DECODE (" + l_Status + " , 2, 2, " + l_Status + "),DECODE (" + l_Status + ", 2, 0, " + l_Status + "), DECODE (" + l_Status + ", 2, 4, " + l_Status + ")) ";
SQL = SQL + "    AND ((TRIM('" + l_voucher + "') IS NULL) OR (UPPER (h.voucherno) LIKE'%' || UPPER (TRIM('" + l_voucher + "'))|| '%'))  ";
SQL = SQL + "    AND ((TRIM('" + l_Seq + "')  IS NULL) OR (h.pk = TRIM('" + l_Seq + "') ))  UNION  ";

SQL = SQL + "SELECT H.PK, TO_CHAR(H.TR_DATE,ac_sf_get_format ('ACAB0300')) TR_DATE_FMT, H.VOUCHERNO, ";
SQL = SQL + "    SF_A_GET_ACCD(R.TAC_ABACCTCODE_PK_CR," + l_company + ") DRACC,  SF_A_GET_ACCD(R.TAC_ABACCTCODE_PK_DR," + l_company + ") CRACC, ";
SQL = SQL + "    R.TR_BOOKAMT, R.REMARK , R.REMARK2 ,H.TR_DATE  ";
SQL = SQL + "    FROM TAC_HGTRH H,  TAC_HGTRD_REF R,TAC_HGTRDITEM a ";
SQL = SQL + "    WHERE H.DEL_IF = 0  ";
SQL = SQL + "    AND R.DEL_IF = 0 ";
SQL = SQL + "    AND H.PK = R.TAC_HGTRH_PK ";
SQL = SQL + "    AND R.DRCR_TYPE = 'C'  AND A.DEL_IF =0 and a.TAC_HGTRD_PK = r.tac_hgtrd_pk AND UPPER(a.ITEM) = UPPER('INVALID')";
SQL = SQL + "    AND H.TCO_COMPANY_PK =  " + l_company + " ";
SQL = SQL + "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '" + l_date_from + "' AND '" + l_date_to + "'   ";
SQL = SQL + "    AND H.TR_STATUS IN (DECODE (" + l_Status + " , 2, 2, " + l_Status + "),DECODE (" + l_Status + ", 2, 0, " + l_Status + "), DECODE (" + l_Status + ", 2, 4, " + l_Status + ")) ";
SQL = SQL + "    AND ((TRIM('" + l_voucher + "') IS NULL) OR (UPPER (h.voucherno) LIKE'%' || UPPER (TRIM('" + l_voucher + "'))|| '%'))  ";
SQL = SQL + "    AND ((TRIM('" + l_Seq + "')  IS NULL) OR (h.pk = TRIM('" + l_Seq + "') )))  ";
SQL = SQL + "  ORDER BY TR_DATE ASC,PK ";
//Response.Write(SQL);
//Response.End();
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="RP2_files/filelist.xml">
<link rel=Edit-Time-Data href="RP2_files/editdata.mso">
<link rel=OLE-Object-Data href="RP2_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tam</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-12-22T03:43:41Z</o:LastPrinted>
  <o:Created>2006-06-27T06:13:13Z</o:Created>
  <o:LastSaved>2008-12-22T03:54:54Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Trang &P \/ &N";
	margin:.5in 0in .5in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style16
	{mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl46
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>S&#7893; NKC (Mau so S03a-DN) (2)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>8</x:SplitHorizontal>
     <x:TopRowBottomPane>8</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>0</x:ActiveRow>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1545</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; NKC (Mau so S03a-DN) (2)'!$A$8:$L$12</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; NKC (Mau so S03a-DN) (2)'!$7:$8</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1323 style='border-collapse:
 collapse;table-layout:fixed;width:992pt'>
 <col class=xl24 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl24 width=285 span=2 style='mso-width-source:userset;mso-width-alt:
 10422;width:214pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:2560'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:1609'>
 <col class=xl24 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl24 width=143 span=2 style='mso-width-source:userset;mso-width-alt:
 5229;width:107pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl26 width=81 style='height:15.75pt;width:61pt'><%= l_cmp_name %></td>
  <td class=xl26 width=103 style='width:77pt'></td>
  <td class=xl24 width=83 style='width:62pt'></td>
  <td class=xl24 width=285 style='width:214pt'></td>
  <td class=xl24 width=285 style='width:214pt'></td>
  <td class=xl24 width=0></td>
  <td class=xl27 colspan=3 width=136 style='mso-ignore:colspan;width:102pt'>M&#7851;u
  s&#7889; S03a-DN</td>
  <td class=xl28 width=143 style='width:107pt'></td>
  <td class=xl28 width=143 style='width:107pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%= l_cmp_add %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29
  x:str="                 (Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày "><span
  style='mso-spacerun:yes'>                 </span>(Ban hành theo Quy&#7871;t
  &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl30></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl25 colspan=2 style='height:15.75pt;mso-ignore:colspan'>Mã
  s&#7889; thu&#7871;:<%= l_cmp_taxcode %></td>
  <td class=xl25></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;&nbsp;&nbsp;<span style='mso-spacerun:yes'>           
  </span>20 tháng 03 n&#259;m 2006 c&#7911;a B&#7897; tr&#432;&#7901;ng
  B&#7897; Tài chính)</td>
  <td class=xl30></td>
  <td colspan=4 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=12 height=30 class=xl54 style='height:22.5pt'>NH&#7852;T KÝ CHUNG</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=12 height=26 class=xl29 style='height:19.5pt'>T&#7915; ngày
  <%= l_date_fr2 %> -&gt; <%= l_date_to2 %></td>
 </tr>
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl25 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl31>&#272;&#417;n v&#7883; tính:</td>
  <td class=xl25><%= l_bookCcy%></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt' x:str="Ngày tháng ">Ngày
  tháng<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl55 style='border-right:.5pt solid black;border-left:
  none'>Ch&#7913;ng t&#7915;</td>
  <td class=xl34>Di&#7877;n gi&#7843;i</td>
  <td class=xl33>Description</td>
  <td class=xl35>&#272;ã ghi</td>
  <td colspan=3 class=xl55 style='border-left:none'>S&#7889; hi&#7879;u TK</td>
  <td class=xl33>S&#7889; phát sinh</td>
  <td class=xl33 style='border-left:none'>Chi phí</td>
  <td class=xl33 style='border-left:none'>Ghi chú</td>
 </tr>
 <tr class=xl32 height=21 style='height:15.75pt'>
  <td height=21 class=xl36 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$8:$L$12" style='height:15.75pt'>ghi s&#7893;</td>
  <td class=xl37 id="_x0000_s1026" x:autofilter="all">S&#7889; hi&#7879;u</td>
  <td class=xl37 id="_x0000_s1027" x:autofilter="all">Ngày</td>
  <td class=xl37 id="_x0000_s1028" x:autofilter="all">&nbsp;</td>
  <td class=xl37 id="_x0000_s1029" x:autofilter="all">&nbsp;</td>
  <td class=xl37 id="_x0000_s1030" x:autofilter="all">SC</td>
  <td class=xl37 id="_x0000_s1031" x:autofilter="all" x:str="N&#7907; ">N&#7907;<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl37 id="_x0000_s1032" x:autofilter="all">CS</td>
  <td class=xl48 id="_x0000_s1033" x:autofilter="all">Có</td>
  <td class=xl36 id="_x0000_s1034" x:autofilter="all"><span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl36 id="_x0000_s1037" x:autofilter="all" style='border-left:none'>&nbsp;</td>
  <td class=xl36 id="_x0000_s1036" x:autofilter="all" style='border-left:none'>Seq</td>
 </tr>
<%
	string trs_date = "";
	string trs_date_dsp = "";
	if (dt_detail.Rows.Count >0)
	{
	    for(int i=0;i<dt_detail.Rows.Count ;i++)
	    {
            if (dt_detail.Rows[i][8].ToString().Length > 0)
            {
                if (trs_date != dt_detail.Rows[i][1].ToString())
                {
                    trs_date_dsp = dt_detail.Rows[i][1].ToString();
                    trs_date = dt_detail.Rows[i][1].ToString();
                }
                else
                {
                    trs_date_dsp = "";
                }
                l_total_ps = l_total_ps + double.Parse(dt_detail.Rows[i][5].ToString());
%>  
 <tr class=xl25 height=<%= l_row_height %> style='mso-height-source:userset;'>
  <td height=20 class=xl38 x:str="<%=  trs_date_dsp%>" ><%= trs_date_dsp%></td>
  <td class=xl39><%= dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl39 x:str="<%=  dt_detail.Rows[i][1].ToString()%>" ><%= dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl40 width=285 style='width:214pt'><%= dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl40 width=285 style='width:214pt'><% = dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl39>X</td>
  <td class=xl39 x:num><%= dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl39>2&nbsp;</td>
  <td class=xl51 x:num><%= dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl52 x:num><%= dt_detail.Rows[i][5].ToString()%></td>
  <td class=xl52 style='border-left:none'><%= dt_detail.Rows[i][8].ToString()%></td>
  <td class=xl49 style='border-left:none' x:num><%= dt_detail.Rows[i][0].ToString()%></td>
 </tr>
<%
    }
            
	}//for
	}//if
	
SQL = "  SELECT  TO_CHAR(SUM(D.TR_BOOKAMT),'" + l_bookformat + "')    ";
SQL = SQL + "FROM TAC_HGTRH H, TAC_HGTRD D ";
SQL = SQL + "WHERE H.DEL_IF = 0   ";
SQL = SQL + "    AND D.DEL_IF = 0   ";
SQL = SQL + "    AND H.PK = D.TAC_HGTRH_PK    ";
SQL = SQL + "    AND H.TCO_COMPANY_PK = " + l_company + " ";
SQL = SQL + "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '"+ l_date_from +"' AND '"+ l_date_to +"'    ";
SQL = SQL + "    AND H.TR_STATUS IN (DECODE ("+ l_Status +" , 2, 2, "+ l_Status +"),DECODE ("+ l_Status +", 2, 0, "+ l_Status +"), DECODE ("+ l_Status +", 2, 4, "+ l_Status +")) ";
SQL = SQL + "    AND D.DRCR_TYPE = 'C' ";
SQL = SQL + "    AND (('" + l_voucher +"' IS NULL) OR (UPPER (h.voucherno) LIKE'%' || UPPER ('" + l_voucher +"')|| '%')) ";
SQL = SQL + "    AND (('" + l_Seq +"'  IS NULL) OR (h.pk = '" + l_Seq +"' )) ";

SQL = " SELECT  TO_CHAR(SUM(R.TR_BOOKAMT),'" + l_bookformat + "') ";
SQL = SQL + "    FROM TAC_HGTRH H,  TAC_HGTRD_REF R ";
SQL = SQL + "    WHERE H.DEL_IF = 0  ";
SQL = SQL + "    AND R.DEL_IF = 0 ";
SQL = SQL + "    AND H.PK = R.TAC_HGTRH_PK ";
SQL = SQL + "    AND R.DRCR_TYPE = 'D'  ";
SQL = SQL + "    AND H.TCO_COMPANY_PK =  " + l_company + " ";
SQL = SQL + "    AND TO_CHAR(H.TR_DATE,'YYYYMMDD') BETWEEN '"+ l_date_from +"' AND '"+ l_date_to +"'   ";
SQL = SQL + "    AND H.TR_STATUS IN (DECODE ("+ l_Status +" , 2, 2, "+ l_Status +"),DECODE ("+ l_Status +", 2, 0, "+ l_Status +"), DECODE ("+ l_Status +", 2, 4, "+ l_Status +")) ";
SQL = SQL + "    AND ((TRIM('" + l_voucher +"') IS NULL) OR (UPPER (h.voucherno) LIKE'%' || UPPER (TRIM('" + l_voucher +"'))|| '%'))  ";
SQL = SQL + "    AND ((TRIM('" + l_Seq +"')  IS NULL) OR (h.pk = '"+l_Seq+"' ))  ";
//SQL = SQL + "  GROUP BY H.PK, H.TR_DATE, H.VOUCHERNO, R.TAC_ABACCTCODE_PK_DR, R.TAC_ABACCTCODE_PK_CR  ";
SQL = SQL + "  ORDER BY H.TR_DATE ASC,H.PK ";

SQL = "SELECT TO_CHAR(TO_NUMBER(" + l_total_ps + "),'" + l_bookformat + "') FROM DUAL   ";
dt = ESysLib.TableReadOpen(SQL);
if (dt.Rows.Count >0)
{
    l_total_book_amt = dt.Rows[0][0].ToString();
}


%>  
 
 <tr class=xl25 height=21 style='height:15.75pt'>
  <td colspan=8 height=21 class=xl58 width=905 style='border-right:.5pt solid black;
  height:15.75pt;width:679pt'>T&#7893;ng c&#7897;ng s&#7889; phát sinh</td>
  <td class=xl41 width=68 style='border-top:.5pt solid black;width:51pt'>&nbsp;</td>
  <td class=xl46 style='border-top:.5pt solid black;' x:num><%= l_total_book_amt %></td>
  <td class=xl47 style='border-top:.5pt solid black;border-left:none'>&nbsp;</td>
  <td class=xl50 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl29 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=4 class=xl29>Ngày <%= l_report_dd %> tháng <%= l_report_mm %> n&#259;m <%= l_report_yy %></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl44 style='height:15.75pt'>Ng&#432;&#7901;i
  ghi s&#7893;</td>
  <td colspan=2 class=xl44>K&#7871; toán tr&#432;&#7903;ng</td>
  <td class=xl29></td>
  <td colspan=4 class=xl44>Giám &#273;&#7889;c</td>
  <td class=xl44></td>
  <td class=xl43></td>
 </tr>
 <tr class=xl29 height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl45 style='height:15.75pt'>( Ký, h&#7885; tên
  )</td>
  <td colspan=2 class=xl45>( Ký, h&#7885; tên )</td>
  <td class=xl29></td>
  <td colspan=4 class=xl45>( Ký, h&#7885; tên, &#273;óng d&#7845;u )</td>
  <td class=xl45></td>
  <td class=xl29></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=12 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=8 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=3 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td colspan=8 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=81 style='width:61pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=285 style='width:214pt'></td>
  <td width=285 style='width:214pt'></td>
  <td width=0></td>
  <td width=68 style='width:51pt'></td>
  <td width=0></td>
  <td width=68 style='width:51pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=143 style='width:107pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
