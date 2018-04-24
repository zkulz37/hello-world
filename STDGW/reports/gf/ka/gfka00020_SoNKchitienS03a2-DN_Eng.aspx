<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company_pk = "" + Request["company_pk"];
	string l_account_pk = "" + Request["account_pk"];
	string l_date_from	= "" + Request["dtbFrom"];
	string l_date_to = "" + Request["dtbTo"];
	string l_ccy = "" + Request["ccy"];
	string l_status = "" + Request["status"];
	string l_book_ccy = "" + Request["bookccy"];
	
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_dt_from ="";
	string p_dt_to ="";
	string p_dt_today = "";
	string p_acc_type = "";
	string p_total_book_amt = "0";
    string p_acc_num = "";
	
	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }

    string SQL = " SELECT PARTNER_NAME,ADDR1, ADDR2, TAX_CODE FROM TCO_COMPANY WHERE PK = '" + l_company_pk + "' ";

    DataTable dt = ESysLib.TableReadOpen(SQL);

    if (dt.Rows.Count >0)
    {
        p_cmp_name = dt.Rows[0][0].ToString();
        p_cmp_add = dt.Rows[0][1].ToString();
        p_cmp_taxcode = dt.Rows[0][3].ToString();
    }


    SQL = " SELECT AC_CD,AC_NM, to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL += "to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date,INITCAP(To_char (sysdate, 'day, month dd  yyyy')),   DECODE(UPPER(a.DRCR_TYPE),'D','1','-1')   ";
	SQL += " FROM TAC_ABACCTCODE a WHERE a.pk = '" + l_account_pk + "' ";
	
	DataTable dt1 = ESysLib.TableReadOpen(SQL);
	if(dt1.Rows.Count>0)
	{
		p_acc_code = dt1.Rows[0][0].ToString();
	    p_acc_name = dt1.Rows[0][1].ToString();
	    p_dt_from = dt1.Rows[0][2].ToString();
		p_dt_to = dt1.Rows[0][3].ToString();
		p_dt_today = dt1.Rows[0][4].ToString();
		p_acc_type = dt1.Rows[0][5].ToString();
        p_acc_num = dt1.Rows[0][5].ToString();
	}
	
	SQL = " SELECT   TO_CHAR(SUM (NVL (ymd_crbooks, 0)), ac_SF_GET_FORMAT ('ACBG0040')) creditbookamount ";
	SQL += "    FROM tac_hgddbal a ";
    SQL += "   WHERE a.del_if = 0 AND a.tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')";
	SQL += "     AND a.tac_abacctcode_pk = " + l_account_pk ;
	SQL += "     AND a.tr_status = " + l_status ;
	SQL += "     AND a.std_ymd BETWEEN '" + l_date_from + "' AND '" + l_date_to + "' ";

	DataTable dt2 = ESysLib.TableReadOpen(SQL);
	if(dt.Rows.Count>0)
	{
		p_total_book_amt = dt2.Rows[0][0].ToString();
	}
	
	SQL = " SELECT h.voucherno, TO_CHAR (h.tr_date, 'DD/MM/YYYY'), r.remark2, r.remark, ";
	SQL += "       sf_a_get_accd (r.tac_abacctcode_pk_dr,"+l_company_pk+") dr_code, ";
	SQL += "       sf_a_get_accd (r.tac_abacctcode_pk_cr,"+l_company_pk+") cr_code, ";
	SQL += "       TO_CHAR (tr_bookamt, ac_SF_GET_FORMAT ('ACBG0040')) book_amt, h.pk,h.tr_date ";
	SQL += "  FROM tac_hgtrh h, tac_hgtrd_ref r ";
	SQL += " WHERE h.del_if = 0 ";
	SQL += "   AND h.pk = r.tac_hgtrh_pk ";
	SQL += "   AND h.tr_status IN (" + l_status + ",DECODE(" + l_status + ",2,0," + l_status + "),DECODE(" + l_status + ",2,4," + l_status + ")) ";
	SQL += "   AND r.del_if = 0 ";
	SQL += "   AND r.drcr_type = 'D' ";
	SQL += "   AND r.tac_abacctcode_pk_cr IN (SELECT     pk ";
	SQL += "                                        FROM tac_abacctcode ";
	SQL += "                                       WHERE del_if = 0 AND leaf_yn = 'Y' ";
	SQL += "                                  CONNECT BY pac_pk = PRIOR pk ";
	SQL += "                                  START WITH pk = " + l_account_pk + ") ";
	SQL += "   AND h.tr_date BETWEEN TO_DATE ('" + l_date_from + "', 'YYYYMMDD') AND TO_DATE ('" + l_date_to + "', 'YYYYMMDD') ";
    SQL += "   AND h.tco_company_pk like  DECODE ('" + l_company_pk + "', 0, '%%', '" + l_company_pk + "')";
	SQL += "  ORDER BY h.tr_date,h.voucherno,h.pk";
	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00020_SoNKchitienS03a2-DN_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00020_SoNKchitienS03a2-DN_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00020_SoNKchitienS03a2-DN_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Cuong</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-06-02T01:56:22Z</o:LastPrinted>
  <o:Created>2006-06-26T17:03:23Z</o:Created>
  <o:LastSaved>2008-06-02T01:56:24Z</o:LastSaved>
  <o:Company>abc</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&CTrang &P of &N";
	margin:.5in 0in .75in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;
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
	padding:0px;
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
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl25
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
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl28
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
	mso-text-control:shrinktofit;
	}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl36
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl40
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
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl47
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
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
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl60
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>S&#7893; NK chi ti&#7873;n(Mau so S03a2</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveCol>3</x:ActiveCol>
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
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; NK chi ti&#7873;n(Mau so S03a2'!$A$9:$I$9</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; NK chi ti&#7873;n(Mau so S03a2'!$7:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl46>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1175 style='border-collapse:
 collapse;table-layout:fixed;width:882pt'>
 <col class=xl46 width=89 span=3 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl46 width=299 span=2 style='mso-width-source:userset;mso-width-alt:
 10934;width:224pt'>
 <col class=xl46 width=68 span=2 style='mso-width-source:userset;mso-width-alt:
 2486;width:51pt'>
 <col class=xl46 width=110 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl46 width=64 style='width:48pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl45 colspan=4 width=566 style='height:15.75pt;
  mso-ignore:colspan;width:425pt'><%= p_cmp_name %></td>
  <td colspan=5 class=xl26 width=609 style='width:457pt'><span
  style='mso-spacerun:yes'> </span>Form number: S03a2</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl45 colspan=4 style='height:15.75pt;mso-ignore:colspan'><%= p_cmp_add %></td>
  <td colspan=5 class=xl33
  >(Issued with Decision No. 15/2006/QĐ-BTC<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl45 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Tax
  Code:&nbsp;&nbsp;<%= p_cmp_taxcode %></td>
  <td class=xl46></td>
  <td colspan=5 class=xl33>dated March 20, 2006 by Ministry) </td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td colspan=8 height=34 class=xl67 style='height:25.5pt'>PAYMENT JOURNAL</td>
  <td class=xl47></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=8 height=26 class=xl33 style='height:19.5pt'>From date<%= p_dt_from %> to date <%= p_dt_to %></td>
  <td class=xl45></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>Account code</td>
  <td class=xl49 x:num><%= p_acc_code %></td>
  <td class=xl50>Account name:</td>
  <td class=xl51><%= p_acc_name %></td>
  <td colspan=2 class=xl46 style='mso-ignore:colspan'></td>
  <td class=xl52></td>
  <td class=xl51>Unit: <%= l_book_ccy %></td>
  <td class=xl46></td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt' >Date<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl58 style='border-right:.5pt solid black;border-left:
  none'>Voucher</td>
  <td rowspan=2 class=xl25 style='border-top:none'>Local Description</td>
  <td class=xl25 style='border-left:none'>Description</td>
  <td rowspan=2 class=xl60 width=68 style='width:51pt'>Debit</td>
  <td rowspan=2 class=xl60 width=68 style='width:51pt'>Credit<span
  style='mso-spacerun:yes'>  </span>Account</td>
  <td class=xl25 style='border-top:none;border-left:none'>Amount</td>
  <td rowspan=2 class=xl68>Note</td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl24 style='height:15.75pt'>entered</td>
  <td class=xl41 >No.<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl41>Date</td>
  <td class=xl24 style='border-left:none'>&nbsp;</td>
  <td class=xl24 style='border-left:none'><%= l_book_ccy %></td>
 </tr>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl42 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$9:$I$9" style='height:15.75pt'>A</td>
  <td class=xl42 id="_x0000_s1026" x:autofilter="all" style='border-left:none'>B</td>
  <td class=xl42 id="_x0000_s1027" x:autofilter="all" style='border-left:none'>C</td>
  <td class=xl42 id="_x0000_s1028" x:autofilter="all" style='border-left:none'>D</td>
  <td class=xl42 id="_x0000_s1029" x:autofilter="all" style='border-left:none'>&nbsp;</td>
  <td class=xl43 id="_x0000_s1030" x:autofilter="all" width=68
  style='border-left:none;width:51pt'>F</td>
  <td class=xl43 id="_x0000_s1031" x:autofilter="all" width=68
  style='border-left:none;width:51pt'>G</td>
  <td class=xl42 id="_x0000_s1032" x:autofilter="all" style='border-left:none'
  x:num>1</td>
  <td class=xl42 id="_x0000_s1033" x:autofilter="all" style='border-left:none'>H</td>
 </tr>
 <%			
	DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	
	string strDate = "";
	string strDate_Dsp = "";
	
	int i =0;
	
	if (dt_detail.Rows.Count >0)
	{
		for(i=0;i<dt_detail.Rows.Count;i++)
		{
			if (strDate!= dt_detail.Rows[i][1].ToString())
			{
				strDate_Dsp = dt_detail.Rows[i][1].ToString();
				strDate = dt_detail.Rows[i][1].ToString();
			}
			else
			{
				strDate_Dsp = "";
			}
			
			if (i < dt_detail.Rows.Count)
			{
			//height=42 style='height:31.5pt'
 %>
 <tr class=xl45>
  <td class=xl27  x:num><%= strDate_Dsp %></td>
  <td class=xl28 style='white-space:nowrap;mso-text-control:shrinktofit;'><%= dt_detail.Rows[i][0].ToString() %></td>
  <td class=xl29 x:num><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl30 width=299 style='width:224pt'><%= dt_detail.Rows[i][2].ToString() %></td>
  <td class=xl30 width=299 style='width:224pt'><%= dt_detail.Rows[i][3].ToString() %></td>
  <td class=xl28 x:num><%= dt_detail.Rows[i][4].ToString() %></td>
  <td class=xl28 x:num><%= dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl36 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][6].ToString() %></td>
  <td class=xl53 style='border-left:none' x:num><%= dt_detail.Rows[i][7].ToString() %></td>
 </tr>
 <%
		}
		else
		{
		//height=21 style='height:15.75pt'
 %>
 <tr class=xl45 >
  <td class=xl27 ><%= strDate_Dsp %></td>
  <td class=xl28 style='white-space:nowrap;mso-text-control:shrinktofit;'><%= dt_detail.Rows[i][0].ToString() %></td>
  <td class=xl29 x:num><%= dt_detail.Rows[i][1].ToString() %></td>
  <td class=xl30 width=299 style='width:224pt'><%= dt_detail.Rows[i][2].ToString() %></td>
  <td class=xl30 width=299 style='width:224pt'><%= dt_detail.Rows[i][3].ToString() %></td>
  <td class=xl28 x:num><%= dt_detail.Rows[i][4].ToString() %></td>
  <td class=xl28 x:num><%= dt_detail.Rows[i][5].ToString() %></td>
  <td class=xl36 style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dt_detail.Rows[i][6].ToString() %></td>
  <td class=xl55 style='border-top:none;border-left:none' x:num><%= dt_detail.Rows[i][7].ToString() %></td>
 </tr>
 <%
		}
		}
	}
 %>
 <tr class=xl45 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=3 height=38 class=xl62 style='border-right:.5pt solid black;
  height:28.5pt'>&nbsp;</td>
  <td class=xl39 width=299 style='width:224pt'>Total Amount Incurred</td>
  <td class=xl40 width=299 style='width:224pt'>&nbsp;</td>
  <td colspan=2 class=xl65 style='border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl37 x:num style="mso-number-format:'<%= p_xls_ccy_format %>';"><%= p_total_book_amt%></td>
  <td class=xl56 style='border-left:none'>&nbsp;</td>
 </tr>
 <tr class=xl45 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=3 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl32 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl33 style='mso-ignore:colspan'></td>
  <td class=xl34></td>
  <td class=xl45></td>
 </tr>
 <tr class=xl57 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=8 height=23 class=xl31 style='height:17.25pt'>The book are…. page(s)
  , number from <span style='mso-spacerun:yes'>  </span>page 01
  to<span style='mso-spacerun:yes'>  </span>page……</td>
  <td class=xl45></td>
 </tr>
 <tr class=xl45 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=5 class=xl31 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl31>Date <%= l_date_to.Substring(6, 2) %>/<%= l_date_to.Substring(4, 2) %>/<%= l_date_to.Substring(0, 4) %></td>
  <td class=xl45></td>
 </tr>
<%
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
            " AND M.ID='EACAB012' " +
            " order by D.ORD ";
    dt1 = ESysLib.TableReadOpen(SQL);
    String e1 = "";
    String e2 = "";
    String e3 = "";
    String e4 = "";
    String e5 = "";
    String e6 = "";
    String v1 = "";
    String v2 = "";
    String v3 = "";
    String v4 = "";
    String v5 = "";
    String v6 = "";
    String g1 = "";
    String g2 = "";
    String g3 = "";
    String g4 = "";
    String g5 = "";
    String g6 = "";
    String n1 = "";
    String n2 = "";
    String n3 = "";
    String n4 = "";
    String n5 = "";
    String n6 = "";

    for (int k = 0; k < dt1.Rows.Count; k++)
    {

        string strTmp = dt1.Rows[k][0].ToString();
        if (strTmp == "ENG")
        {
            e1 = "" + dt1.Rows[k][1].ToString();
            e2 = "" + dt1.Rows[k][2].ToString();
            e3 = "" + dt1.Rows[k][3].ToString();
            e4 = "" + dt1.Rows[k][4].ToString();
            e5 = "" + dt1.Rows[k][5].ToString();
            e6 = "" + dt1.Rows[k][6].ToString();
        }

        if (strTmp == "VIE")
        {
            v1 = dt1.Rows[k][1].ToString();
            v2 = dt1.Rows[k][2].ToString();
            v3 = dt1.Rows[k][3].ToString();
            v4 = dt1.Rows[k][4].ToString();
            v5 = dt1.Rows[k][5].ToString();
            v6 = dt1.Rows[k][6].ToString();
        }
        if (strTmp == "SIG")
        {
            g1 = dt1.Rows[k][1].ToString();
            g2 = dt1.Rows[k][2].ToString();
            g3 = dt1.Rows[k][3].ToString();
            g4 = dt1.Rows[k][4].ToString();
            g5 = dt1.Rows[k][5].ToString();
            g6 = dt1.Rows[k][6].ToString();
        }

        if (strTmp == "NAM")
        {
            n1 = dt1.Rows[k][1].ToString();
            n2 = dt1.Rows[k][2].ToString();
            n3 = dt1.Rows[k][3].ToString();
            n4 = dt1.Rows[k][4].ToString();
            n5 = dt1.Rows[k][5].ToString();
            n6 = dt1.Rows[k][6].ToString();
        }
    }


 %>    
 <tr class=xl45 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl35 style='height:17.25pt'><%= v4 %></td>
  <td class=xl35><%= v5 %></td>
  <td class=xl35></td>
  <td colspan=3 class=xl35><%= v6 %></td>
  <td class=xl45></td>
 </tr>
 <tr class=xl45 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl38 style='height:17.25pt'><%= g4 %></td>
  <td class=xl38><%= g5 %></td>
  <td class=xl38></td>
  <td colspan=3 class=xl38><%= g6 %></td>
  <td class=xl45></td>
 </tr>
  <tr class=xl45 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl38 style='height:17.25pt'></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td colspan=3 class=xl38></td>
  <td class=xl45></td>
 </tr>
 <tr class=xl45 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl38 style='height:17.25pt'></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td colspan=3 class=xl38></td>
  <td class=xl45></td>
 </tr>
 <tr class=xl45 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl38 style='height:17.25pt'></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td colspan=3 class=xl38></td>
  <td class=xl45></td>
 </tr>
 <tr class=xl45 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl38 style='height:17.25pt'></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td colspan=3 class=xl38></td>
  <td class=xl45></td>
 </tr>
 <tr class=xl45 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl38 style='height:17.25pt'></td>
  <td class=xl38></td>
  <td class=xl38></td>
  <td colspan=3 class=xl38></td>
  <td class=xl45></td>
 </tr>
      <tr class=xl45 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=3 height=23 class=xl35 style='height:17.25pt'><%= n4 %></td>
  <td class=xl35><%= n5 %></td>
  <td class=xl35></td>
  <td colspan=3 class=xl35><%= n6 %></td>
  <td class=xl45></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=299 style='width:224pt'></td>
  <td width=299 style='width:224pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
