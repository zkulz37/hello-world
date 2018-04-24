<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
  
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

string p_seq = ""+Request["seq"];
string p_trans_date = "";
string p_voucher_no	 = "";
string p_company_name = "";
string p_dept_name = "";
string p_trans_type = "";
string p_trans_name = "";
string p_pro_by = "";
string p_sign_date = "";
string p_app_by = "";
string p_remark = "";
string p_remark2 = "";
string p_trans_ccy = "";
string p_total_bookamt = "";
string p_ex_bookrate = "";
string p_book_ccy = "";
String p_xls_ccy_format = "";
string p_total_debit = "0";
string p_total_credit = "0";
string p_company_pk = "";
string p_enclose = "";
String e1 = "";
String e2 = "";
String e3 = "";
String e4 = "";
String e5 = "";

String v1 = "";
String v2 = "";
String v3 = "";
String v4 = "";
String v5 = "";
string SQL = "SELECT H.VOUCHERNO, TO_CHAR(H.TR_DATE,'DD/MM/YYYY') TRANS_DATE,  " + 
        " D.org_NM,A.TR_TYPE,A.TR_TPNM,V1.FULL_NAME PRO_BY, " +
        "  h.SIGN_DATE ,V2.FULL_NAME APP_BY,  " +
        " REMARK,REMARK2,C.PARTNER_NAME,C.PK, H.TR_ENCLOSE" +
        " FROM TAC_HGTRH H,COMM.TCO_COMPANY C,COMM.TCO_org D,TAC_ABTRTYPE A,VCO_BSUSER V1, VCO_BSUSER V2 " +
        " WHERE H.DEL_IF =0 " +
        " AND C.DEL_IF =0  " +
        " AND H.TCO_org_PK = D.PK(+) " +
        " AND H.TAC_ABTRTYPE_PK = A.PK(+) " +
        " AND H.TCO_COMPANY_PK = C.PK " +
        " AND H.TCO_BSUSER_PK = V1.PK(+) " +
        " AND H.SIGN_MEMB = V2.USER_ID(+) " +
        " AND H.PK = "+ p_seq;

//Response.Write(SQL);
//Response.End(); 
		
DataTable dt = ESysLib.TableReadOpen(SQL);
if (dt.Rows.Count >0)
{
		p_voucher_no = dt.Rows[0][0].ToString();
		p_trans_date = dt.Rows[0][1].ToString();
		p_dept_name = dt.Rows[0][2].ToString();
		p_trans_type = dt.Rows[0][3].ToString();
		p_trans_name = dt.Rows[0][4].ToString();
		p_pro_by = dt.Rows[0][5].ToString();
		p_sign_date = dt.Rows[0][6].ToString();
		p_app_by = dt.Rows[0][7].ToString();
		p_remark = dt.Rows[0][8].ToString();
		p_remark2 = dt.Rows[0][9].ToString();
		p_company_name = dt.Rows[0][10].ToString();
		p_company_pk = dt.Rows[0][11].ToString();
        p_enclose = dt.Rows[0][12].ToString();
}
SQL = "SELECT   " +
            "    D.CODE, " +
            "    D.CHAR_1,  " +
            "    D.CHAR_2,  " +
            "    D.CHAR_3,  " +
            "    D.CHAR_4,  " +
            "    D.CHAR_5,  " +
            "    D.REMARK " +
            " FROM TAC_COMMCODE_DETAIL D, TAC_COMMCODE_MASTER M " +
            " WHERE D.DEL_IF=0 AND D.TAC_COMMCODE_MASTER_PK = M.PK " +
            " AND M.ID='EACAB035' " +
            " order by D.ORD ";
DataTable dt1 = ESysLib.TableReadOpen(SQL);


for (int k = 0; k < dt1.Rows.Count; k++)
{

    string strTmp = dt1.Rows[k][0].ToString();

    if (strTmp == "ENG")
    {
        e1 = dt1.Rows[k][1].ToString();
        e2 = dt1.Rows[k][2].ToString();
        e3 = dt1.Rows[k][3].ToString();
        e4 = dt1.Rows[k][4].ToString();
        e5 = dt1.Rows[k][5].ToString();
    }
    if (strTmp == "VIE")
    {
        v1 = dt1.Rows[k][1].ToString();
        v2 = dt1.Rows[k][2].ToString();
        v3 = dt1.Rows[k][3].ToString();
        v4 = dt1.Rows[k][4].ToString();
        v5 = dt1.Rows[k][5].ToString();
    }
   
}  
     
SQL = "SELECT CODE FROM TCO_ABCODE A, TCO_ABCODEGRP B WHERE A.TCO_ABCODEGRP_PK = b.pk and b.id ='ACBG0040' and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 and a.def_yn ='Y'";

dt = ESysLib.TableReadOpen(SQL);
if (dt.Rows.Count >0)
{
	p_book_ccy = dt.Rows[0][0].ToString();
}

SQL = "SELECT MAX(CCY), TO_CHAR(SUM(TR_BOOKAMT),DECODE('"+p_book_ccy+"','VND','9,999,999,999,990','9,999,999,999,990.99')) BOOK_AMT, TO_CHAR(MAX(BK_RATE),'9,999,999,999,990'), TO_CHAR(MAX(TR_RATE),'9,999,999,999,990') " + 
        " FROM TAC_HGTRD D  " +
        " WHERE D.DEL_IF = 0 " +
        " AND D.TAC_HGTRH_PK = "+ p_seq +
        " AND DRCR_TYPE ='D' " ;
dt = ESysLib.TableReadOpen(SQL);
	if (dt.Rows.Count >0)
	{
		p_trans_ccy = dt.Rows[0][0].ToString();
		p_total_bookamt = dt.Rows[0][1].ToString();
		p_ex_bookrate = dt.Rows[0][2].ToString();
	}		

	if (p_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
	else
	{
		p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
	}
	

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="60080010_envn_files/filelist.xml">
<link rel=Edit-Time-Data href="60080010_envn_files/editdata.mso">
<link rel=OLE-Object-Data href="60080010_envn_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>binh</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-09-15T02:24:29Z</o:LastPrinted>
  <o:Created>2004-08-05T18:56:06Z</o:Created>
  <o:LastSaved>2008-09-15T02:25:37Z</o:LastSaved>
  <o:Company>GENUWIN</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in 0in .25in .25in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-horizontal-page-align:center;}
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
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl43
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid black;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid black;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl60
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl63
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl66
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl67
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl68
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;}
.xl71
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl74
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl88
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl95
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl96
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
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
.xl109
	{mso-style-parent:style0;
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
.xl110
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl111
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl115
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl116
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl122
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl125
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl126
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;}
.xl127
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl128
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;}
.xl129
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl130
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl131
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl132
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl133
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;}
.xl134
	{mso-style-parent:style16;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl135
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl136
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl137
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;}
.xl138
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl139
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl140
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl141
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl142
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl143
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl144
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl145
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl146
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"m\/d\/yyyy\;\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl147
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl148
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl149
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl150
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl151
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl152
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl153
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl154
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl155
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	white-space:normal;}
.xl156
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl157
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl158
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl159
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl160
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl161
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl162
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl163
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl164
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl165
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl166
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl167
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl168
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl169
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl170
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl171
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl172
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl173
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl174
	{mso-style-parent:style0;
	font-size:8.0pt;
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
.xl175
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl176
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl177
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Phi&#7871;u k&#7871; toán</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>9</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$10:$E$10</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8460</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2355</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Phi&#7871;u k&#7871; toán'!$16:$16</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl31>

<table x:str border=0 cellpadding=0 cellspacing=0 width=720 style='border-collapse:
 collapse;table-layout:fixed;width:541pt'>
 <col class=xl31 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl31 width=64 style='width:48pt'>
 <col class=xl31 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <col class=xl31 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl31 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <col class=xl31 width=33 span=6 style='mso-width-source:userset;mso-width-alt:
 1206;width:25pt'>
 <col class=xl31 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl31 width=26 span=2 style='mso-width-source:userset;mso-width-alt:
 950;width:20pt'>
 <col class=xl31 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl31 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <tr class=xl24 height=18 style='height:13.5pt'>
  <td height=18 class=xl24 width=19 style='height:13.5pt;width:14pt'></td>
  <td class=xl25 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl25 width=75 style='width:56pt'>&nbsp;</td>
  <td class=xl25 width=103 style='width:77pt'>&nbsp;</td>
  <td class=xl25 width=96 style='width:72pt'>&nbsp;</td>
  <td colspan=6 class=xl165 width=198 style='width:150pt'>Voucher Approval No :</td>
  <td colspan=5 class=xl166 width=165 style='width:124pt'
  x:str="                                               "><span
  style='mso-spacerun:yes'>                                               </span></td>
 </tr>
 <tr class=xl24 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl26 style='height:24.95pt'>&nbsp;</td>
  <td colspan=14 class=xl167>ACCOUNTING SLIP/PHI&#7870;U K&#7870; TOÁN</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl28 style='height:30.0pt'>&nbsp;</td>
  <td colspan=3 rowspan=3 class=xl159 width=242 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:181pt'>Transaction Approval/ <br>
    Ký duy&#7879;t</td>
  <td class=xl29 width=96 style='width:72pt'>Date/ <br>
    Ngày</td>
  <td colspan=2 class=xl173 width=66 style='border-right:.5pt solid black;
  border-left:none;width:50pt'><%= e1 %><br>
    <%=v1 %></td>
  <td colspan=2 class=xl175 width=66 style='border-right:.5pt solid black;
  border-left:none;width:50pt'><%= e2 %><br>
    <%=v2 %></td>
  <td colspan=2 class=xl175 width=66 style='border-right:.5pt solid black;
  border-left:none;width:50pt'><%=e3 %><br>
    <%=v3 %></td>
  <td colspan=2 class=xl175 width=73 style='border-right:.5pt solid black;
  border-left:none;width:55pt'><%=e4 %><br>
    <%=v4 %></td>
  <td colspan=2 class=xl175 width=73 style='border-right:.5pt solid black;
  border-left:none;width:55pt'><%=e5 %><br>
    <%=v5 %></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl28 style='height:18.0pt'>&nbsp;</td>
  <td rowspan=2 class=xl176 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl159 width=66 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:50pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl159 width=66 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:50pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl159 width=66 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:50pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl147 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl147 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl28 style='height:18.0pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=14 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl28 style='height:24.0pt'>&nbsp;</td>
  <td colspan=2 class=xl151>Company/ Tên công ty:</td>
  <td colspan=2 class=xl153 width=199 style='border-right:.5pt solid black;
  width:149pt'><%= p_company_name %></td>
  <td colspan=4 class=xl155 width=132 style='border-left:none;width:100pt'>Voucher
  No / (Seq)/ S&#7889; ch&#7913;ng t&#7915; :</td>
  <td colspan=6 class=xl157 style='border-right:.5pt solid black'><%= p_voucher_no %>/(<%= p_seq %>)</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 class=xl28 style='height:24.0pt'>&nbsp;</td>
  <td colspan=2 class=xl140>Department/ B&#7897; ph&#7853;n:</td>
  <td colspan=2 class=xl142 style='border-right:.5pt solid black'><%= p_dept_name %></td>
  <td colspan=4 class=xl144 style='border-left:none'>Date/ Ngày:</td>
  <td colspan=6 class=xl145 style='border-right:.5pt solid black' x:str="<%= p_trans_date%>"><%= p_trans_date%></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=13 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr class=xl24 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl33 style='height:24.95pt'>&nbsp;</td>
  <td colspan=2 class=xl131 width=139 style='border-right:.5pt solid black;
  width:104pt'>Amount/ S&#7889; ti&#7873;n</td>
  <td colspan=2 class=xl126 style='border-right:.5pt solid black;border-top:.5pt solid black;border-left:none;'><%= p_total_bookamt %></td>
  <td colspan=4 class=xl135 width=132 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>Proposed By/<br>
    Ng&#432;&#7901;i l&#7853;p</td>
  <td colspan=6 class=xl137 style='border-right:.5pt solid black;border-left:
  none'><%= p_pro_by%></td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <tr class=xl24 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl33 style='height:24.95pt'>&nbsp;</td>
  <td colspan=2 class=xl118 width=139 style='border-right:.5pt solid black;
  width:104pt'>Booking Currency/ <br>
    Ti&#7873;n ghi s&#7893;</td>
  <td colspan=2 class=xl126 style='border-right:.5pt solid black;border-left:
  none'><%= p_book_ccy %></td>
  <td colspan=4 class=xl122 width=132 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>Approved Date/<br>
    Ngày duy&#7879;t</td>
  <td colspan=6 class=xl128 style='border-right:.5pt solid black;border-left:
  none'><%= p_sign_date %></td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <tr class=xl24 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl33 style='height:24.95pt'>&nbsp;</td>
  <td colspan=2 class=xl118 width=139 style='border-right:.5pt solid black;
  width:104pt'>Exchange Rate/ T&#7927; giá</td>
  <td colspan=2 class=xl126 style='border-right:.5pt solid black;border-left:
  none;' ><%= p_ex_bookrate%></td>
  <td colspan=4 class=xl122 width=132 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>Approved By/<br>
    Ng&#432;&#7901;i duy&#7879;t</td>
  <td colspan=6 class=xl120 style='border-right:.5pt solid black;border-left:
  none'><%= p_app_by %></td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <tr class=xl24 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl33 style='height:24.95pt'>&nbsp;</td>
  <td colspan=2 class=xl118 width=139 style='border-right:.5pt solid black;
  width:104pt'>Transaction Code/<br>
    Mã nghi&#7879;p v&#7909;</td>
  <td colspan=2 class=xl126 style='border-right:.5pt solid black;border-left:
  none'><%= p_trans_type %></td>
  <td colspan=4 class=xl122 width=132 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>Transaction Name/<br>
    Tên nghi&#7879;p v&#7909;</td>
  <td colspan=6 class=xl120 style='border-right:.5pt solid black;border-left:
  none'><%= p_trans_name %></td>
  <td class=xl34>&nbsp;</td>
 </tr>

<tr class=xl24 height=46 style='mso-height-source:userset;height:35.1pt'>
  <td height=46 class=xl33 style='height:35.1pt'>&nbsp;</td>
  <td colspan=2 class=xl118 width=139 style='border-right:.5pt solid black;
  width:104pt'>Description/<br>
    Di&#7877;n gi&#7843;i</td>
  <td colspan=2 class=xl120 style='border-right:.5pt solid black;border-left:
  none'><%= p_remark %></td>
  <td colspan=4 class=xl122 width=132 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>Local Description/<br>
    Di&#7877;n gi&#7843;i</td>
  <td colspan=6 class=xl120 style='border-right:.5pt solid black;border-left:
  none'><%= p_remark2 %></td>
  <td class=xl34>&nbsp;</td>
 </tr>

 
 <tr height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl35 style='height:24.95pt'>&nbsp;</td>
  <td colspan=2 class=xl111 width=139 style='border-right:.5pt solid black;
  width:104pt'>Enclose/<br />Chứng từ đính kèm</td>
  <td colspan=12 class=xl113 width=199 style='border-right:.5pt solid black;
  border-left:none;width:149pt'><%= p_enclose %></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=14 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl28 style='height:20.1pt'>&nbsp;</td>
  <td colspan=14 class=xl104 style='border-right:.5pt solid black'>TRANSACTION
  DETAILS/ CHI TII&#7870;T</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=40 style='mso-height-source:userset;height:30.0pt'>
  <td height=40 class=xl28 style='height:30.0pt'>&nbsp;</td>
  <td colspan=2 class=xl104 style='border-right:.5pt solid black'>Account/ Tên
  TK</td>
  <td colspan=2 class=xl107 width=199 style='border-right:.5pt solid black;
  border-left:none;width:149pt'>Description/<br>
    Di&#7877;n gi&#7843;i</td>
  <td colspan=4 class=xl107 width=132 style='border-right:.5pt solid black;
  border-left:none;width:100pt'>Control Items/ Ghi chú</td>
  <td colspan=3 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Debit/ N&#7907;</td>
  <td colspan=3 class=xl110 style='border-right:.5pt solid black;border-left:
  none'>Credit/ Có</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <%
 SQL = "SELECT SF_A_GET_ACCD(D.TAC_ABACCTCODE_PK,"+p_company_pk+") ACCD, SF_A_GET_ACNM(D.TAC_ABACCTCODE_PK,"+p_company_pk+", 'ENG'),REMARK,REMARK2,SF_A_GET_AGTRITEM(D.PK), " +  "DECODE(DRCR_TYPE,'D',TO_CHAR(TR_BOOKAMT,DECODE('"+p_book_ccy+"','VND','9,999,999,999,990','9,999,999,999,990.99')),'') DEBIT_AMT, " +        "DECODE(DRCR_TYPE,'D','',TO_CHAR(TR_BOOKAMT,DECODE('"+p_book_ccy+"','VND','9,999,999,999,990','9,999,999,999,990.99'))) CREDIT_AMT, SF_A_GET_ACCD_LOCAL((SELECT TAC_LOCALCODE_PK FROM TAC_ABACCTCODE WHERE PK = D.TAC_ABACCTCODE_PK AND DEL_IF = 0),'1') ACCD_LC" +
        " FROM TAC_HGTRD D " +
        " WHERE D.DEL_IF = 0 " +
        " AND D.TAC_HGTRH_PK =  " + p_seq +
        " ORDER BY DRCR_TYPE DESC, DRCR_ORD ASC,TYPE_REF " ;
		
    //Response.Write(SQL);
	//Response.End();
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	
	for(int i=0;i<dt_detail.Rows.Count;i++)
	{
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl90 style='border-right:.5pt solid black' x:str><B><%= dt_detail.Rows[i][7].ToString() %>/</B><%= dt_detail.Rows[i][0].ToString() %></td>
  <td colspan=2 rowspan=2 class=xl92 width=199 style='border-right:.5pt solid black;
  width:149pt'><%= dt_detail.Rows[i][2].ToString() %></td>
  <td colspan=4 rowspan=4 class=xl95 width=132 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:100pt'><%= dt_detail.Rows[i][4].ToString() %></td>
  <td colspan=3 rowspan=4 class=xl67 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;mso-number-format:"<%= p_xls_ccy_format %>";' x:num><%= dt_detail.Rows[i][5].ToString() %></td>
  <td colspan=3 rowspan=4 class=xl67 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;mso-number-format:"<%= p_xls_ccy_format %>";' x:num><%= dt_detail.Rows[i][6].ToString() %></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 rowspan=3 class=xl76 width=139 style='border-bottom:.5pt solid black;
  width:104pt'><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl80 width=199 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:149pt'><%= dt_detail.Rows[i][3].ToString() %></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <%
	}
	SQL = "SELECT " + 
        " TO_CHAR(SUM(DECODE(DRCR_TYPE,'D',TR_BOOKAMT,0)),DECODE('"+p_book_ccy+"','VND','9,999,999,999,990','9,999,999,999,990.99')) SUM_DEBIT, " +
        " TO_CHAR(SUM(DECODE(DRCR_TYPE,'C',TR_BOOKAMT,0)),DECODE('"+p_book_ccy+"','VND','9,999,999,999,990','9,999,999,999,990.99')) SUM_CREDIT " +
        " FROM TAC_HGTRD D " +
        " WHERE D.DEL_IF = 0 " +
        " AND D.TAC_HGTRH_PK = " + p_seq ;
		
		//Response.Write(SQL);
		//Response.End();
	DataTable dt_total = ESysLib.TableReadOpen(SQL);
	if(dt_total.Rows.Count >0)
	{
		p_total_debit = dt_total.Rows[0][0].ToString();
		p_total_credit = dt_total.Rows[0][1].ToString();
	}
 %>
 <tr class=xl24 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl36 style='height:20.1pt'>&nbsp;</td>
  <td colspan=8 class=xl84 style='border-right:.5pt solid black'>Total/
  T&#7893;ng c&#7897;ng</td>
  <td colspan=3 class=xl87 style='border-left:none;border-right:.5pt solid black;mso-number-format:"<%= p_xls_ccy_format %>"' x:num><%= p_total_debit %></td>
  <td colspan=3 class=xl88 style='border-right:.5pt solid black;mso-number-format:"<%= p_xls_ccy_format %>"' x:num><%= p_total_credit %></td>
  <td class=xl34>&nbsp;</td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 class=xl37 style='height:14.1pt'>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
 </tr>

 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl40>Trans Currency</td>
  <td colspan=3 class=xl59 style='border-right:.5pt solid black;border-left:
  none'>Debit</td>
  <td colspan=3 class=xl62 style='border-right:.5pt solid black;border-left:
  none'>Credit</td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <%
	SQL = "SELECT CCY, " + " TO_CHAR(SUM(DECODE(DRCR_TYPE,'D',TR_AMT,0)),DECODE(CCY,'VND','9,999,999,999,990','9,999,999,999,990.99')) SUM_DEBIT, " +" TO_CHAR(SUM(DECODE(DRCR_TYPE,'C',TR_AMT,0)),DECODE(CCY,'VND','9,999,999,999,990','9,999,999,999,990.99')) SUM_CREDIT " +
        " FROM TAC_HGTRD D " +
        " WHERE D.DEL_IF = 0 " +
        " AND D.TAC_HGTRH_PK = " + p_seq +
        " GROUP BY CCY " ;
		
		//Response.Write(SQL);
		//Response.End();
	dt = ESysLib.TableReadOpen(SQL);
	string p_ccy_tmp = "";
	for(int i=0;i<dt.Rows.Count;i++)
	{
		p_ccy_tmp = dt.Rows[i][0].ToString();
		if (p_ccy_tmp=="VND")
		{
			p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
		}
		else
		{
			p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
		}
 %>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl41><%= dt.Rows[i][0].ToString() %></td>
  <td colspan=3 class=xl63 style='border-right:.5pt solid black;border-left:none; mso-number-format:"<%= p_xls_ccy_format %>"' x:num><%= dt.Rows[i][1].ToString() %></td>
  <td colspan=3 class=xl66 style='border-right:.5pt solid black;border-left:none; mso-number-format:"<%= p_xls_ccy_format %>"' x:num><%= dt.Rows[i][2].ToString() %></td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <%
 }
 %>

 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=16 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=16 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl42 colspan=2 style='mso-ignore:colspan'>Accounting section</td>
  <td colspan=10 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl43 width=96 style='width:72pt'>Date</td>
  <td colspan=3 class=xl44 width=99 style='border-right:.5pt solid black;
  border-left:none;width:75pt'>Checked by</td>
  <td colspan=3 class=xl44 width=99 style='border-right:.5pt solid black;
  border-left:none;width:75pt'>Reviewed by</td>
  <td colspan=3 class=xl44 width=99 style='border-right:.5pt solid black;
  border-left:none;width:75pt'>Approved</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl42 style='height:15.0pt;mso-ignore:colspan'></td>
  <td rowspan=4 class=xl47 width=96 style='border-bottom:.5pt solid black;
  border-top:none;width:72pt'>&nbsp;</td>
  <td colspan=3 rowspan=4 class=xl50 width=99 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:75pt'>&nbsp;</td>
  <td colspan=3 rowspan=4 class=xl50 width=99 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:75pt'>&nbsp;</td>
  <td colspan=3 rowspan=4 class=xl50 width=99 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:75pt'>&nbsp;</td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl31 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=19 style='width:14pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=75 style='width:56pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=96 style='width:72pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=19 style='width:14pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
