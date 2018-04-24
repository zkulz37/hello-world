<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string l_company_pk = ""+Request["p_company_pk"];
	string l_account_pk = ""+Request["p_acc_pk"];
	string l_date_from	= "" + Request["p_date_from"];
	string l_date_to = "" +Request["p_date_to"];
	string l_ccy = ""+ Request["p_ccy"];
	string l_status = ""+Request["p_status"];
    string l_openbal = "" + Request["p_openbal"];
	if (l_status=="")//Default status is confirm
	{
		l_status="2";
	}
    //string p_tax = "";
    //string p_tittle = "";
    //string p_row1 = "";
    //string p_row2 = "";
    //string p_row3 = "";
    //string p_from = "";
    //string p_to = "";
    //string p_acc = "";
    //string p_
    //if (l_lang == "ENG")
    //{
    //    p_tax = "Tax code";
    //    p_tittle = "GENERAL LEDGER";
    //    p_row1 = "Form number: S03b-DN";
    //    p_row2 = "(Issued with Decision No. 15/2006/QĐ-BTC";
    //    p_row3 = "dated March 20, 2006 by Ministry of Finance)";
    //    p_from = "To date";
    //    p_to = "from date";
    //    p_acc = "Account code"; 
    //}
    //else if(l_lang == "VIE")
    //{
    //    p_tax = "Mã số thuế";
    //    p_tittle = "SỔ CÁI";
    //    p_row1 = " Mẫu số S03b-DN";
    //    p_row2 = "(Ban hành theo Quyết định số 15/2006/QĐ-BTC ngày";
    //    p_row3 = "20 tháng 03 năm 2006 của Bộ trường Bộ Tài chính)";
    //    p_from = "Từ ngày";
    //    p_to = "Đến ngày";  
    //}
     
	string p_cmp_name = "";
	string p_cmp_add = "";
	string p_cmp_taxcode = "";
	string p_acc_code ="";
	string p_acc_name ="";
	string p_acc_type = "";
	string p_dt_from ="";
	string p_dt_to ="";

	string p_open_bal_dr_xls = "0";
	string p_open_bal_cr_xls = "0";
	string p_close_bal_dr_xls = "0";
	string p_close_bal_cr_xls = "0";
	string p_debit_xls ="0";
	string p_credit_xls ="0";
	string p_open_bal = "0";
	string p_acc_pk_arr ="";
    string p_acc_num = "";
	int i =0;

    string SQL2 = " SELECT AC_CD,AC_LNM,UPPER(a.DRCR_TYPE),  to_char(to_date('" + l_date_from + "','YYYYMMDD'),'DD/MM/YYYY') frm_date, ";
    SQL2 += " to_char(to_date('" + l_date_to + "','YYYYMMDD'),'DD/MM/YYYY') t_date ,DECODE(UPPER(a.DRCR_TYPE),'D','1','-1') ";
    SQL2 += " FROM TAC_LOCALCODE a WHERE a.pk = '" + l_account_pk + "' ";

    DataTable dt2 = ESysLib.TableReadOpen(SQL2);
    if (dt2.Rows.Count > 0)
    {
        p_acc_code = dt2.Rows[0][0].ToString();
        p_acc_name = dt2.Rows[0][1].ToString();
        p_acc_type = dt2.Rows[0][2].ToString();
        p_dt_from =  dt2.Rows[0][3].ToString();
        p_dt_to =    dt2.Rows[0][4].ToString();
        p_acc_num =  dt2.Rows[0][5].ToString();
    }
    
	String p_xls_ccy_format ="";
    String p_xls_ccy_format_usd = "";
    if (l_ccy == "VND")
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
    string l_parameter = "'" + l_company_pk + "','" + l_account_pk + "','" + l_date_from + "','" + l_date_to + "','" + l_status + "','" + l_ccy + "','" + l_openbal + "'";
    string l_parameterSum = "'" + l_company_pk + "','" + l_account_pk + "','" + l_date_from + "','" + l_date_to + "','" + l_status + "','" + l_ccy  + "'";
    //Response.Write(l_parameter);
    //Response.End();
    DataTable dtDetail = ESysLib.TableReadOpenCursor("ACNT.Sp_Sel_gfrv00020_2", l_parameter);//Data of Date,not voucher
    if (dtDetail.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }

    DataTable dtSum = ESysLib.TableReadOpenCursor("ACNT.Sp_Sel_gfrv00020_1", l_parameterSum);
    //Response.Write(dtSum.Rows[1][4].ToString());
    //    Response.End();
    if (dtSum.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
 
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00020_SocaiNKC_S03b-DN_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00020_SocaiNKC_S03b-DN_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00020_SocaiNKC_S03b-DN_files/oledata.mso">
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
  <o:LastPrinted>2008-05-05T07:32:53Z</o:LastPrinted>
  <o:Created>2006-06-28T09:24:54Z</o:Created>
  <o:LastSaved>2008-06-10T08:19:11Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl36
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl43
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl49
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl53
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
	mso-background-source:auto;
	mso-pattern:auto none;
	white-space:normal;}
.xl54
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl57
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
.xl58
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
.xl59
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl63
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl65
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";
	}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl67
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
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl72
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
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
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
.xl74
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
.xl75
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
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl77
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
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>So cai NKC (Mau so S03b-DN)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>10</x:SplitHorizontal>
     <x:TopRowBottomPane>10</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$8:$D$9</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8490</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>2325</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='So cai NKC (Mau so S03b-DN)'!$A$9:$I$9</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='So cai NKC (Mau so S03b-DN)'!$8:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1217 style='border-collapse:
 collapse;table-layout:fixed;width:913pt'>
 <col class=xl25 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl25 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:75pt'>
 <col class=xl25 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl25 width=292 span=2 style='mso-width-source:userset;mso-width-alt:
 10678;width:219pt'>
 <col class=xl25 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl25 width=123 span=2 style='mso-width-source:userset;mso-width-alt:
 4498;width:92pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl68 width=552 style='height:14.25pt;
  width:415pt'><%= p_cmp_name %></td>
  <td class=xl24 width=292 style='width:219pt'></td>
  <td colspan=4 class=xl33 width=373 style='width:279pt'><span
  style='mso-spacerun:yes'> </span>M&#7851;u s&#7889; S03b-DN</td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=4 height=19 class=xl69 width=552 style='height:14.25pt;
  width:415pt'><%= p_cmp_add %></td>
  <td class=xl26></td>
  <td class=xl31 colspan=4 align=left style='mso-ignore:colspan'
  x:str="(Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày ">(Ban
  hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=4 height=21 class=xl68 style='height:15.75pt'>Mã s&#7889;
  thu&#7871;:<%= p_cmp_taxcode %></td>
  <td class=xl24></td>
  <td class=xl31 colspan=4 align=left style='mso-ignore:colspan'>20 tháng 03
  n&#259;m 2006 c&#7911;a B&#7897; tr&#432;&#7901;ng B&#7897; Tài chính)</td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td colspan=8 height=30 class=xl70 style='height:22.5pt' x:str="S&#7892; CÁI ">S&#7892;
  CÁI<span style='mso-spacerun:yes'> </span></td>
  <td class=xl25></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=8 height=26 class=xl71 style='height:19.5pt'>T&#7915; ngày <%= p_dt_from %>
  &#272;&#7871;n ngày <%= p_dt_to %></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl31 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl32 colspan=2 style='height:19.5pt;mso-ignore:colspan'>S&#7889;
  hi&#7879;u tài kho&#7843;n:</td>
  <td class=xl33 ><%= p_acc_code %></td>
  <td colspan=5 class=xl32><%= p_acc_name %></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 colspan=6 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl34>&#272;&#417;n v&#7883; tính:</td>
  <td class=xl35><%= l_ccy%></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl33 height=21 style='height:15.75pt'>
  <td rowspan=2 height=42 class=xl72 width=74 style='border-bottom:.5pt solid black;
  height:31.5pt;width:56pt'>Ngày tháng ghi s&#7893;</td>
  <td colspan=2 class=xl74 style='border-right:.5pt solid black;border-left:
  none'>Chứng từ</td>
  <td rowspan=2 class=xl36 style='border-bottom:.5pt solid black'>Di&#7877;n
  gi&#7843;i</td>
  <td rowspan=2 class=xl36 style='border-bottom:.5pt solid black'>Diễn giải</td>
  <td rowspan=2 class=xl72 width=63 style='border-bottom:.5pt solid black;
  width:47pt'>S&#7889; hi&#7879;u TK &#273;&#7889;i &#7913;ng</td>
  <td colspan=2 class=xl74 style='border-left:none'>S&#7889; ti&#7873;n</td>
  <td class=xl36>Ghi chú</td>
 </tr>
 <tr class=xl33 height=21 style='height:15.75pt'>
  <td height=21 class=xl37 id="_x0000_s1026" x:autofilter="all"
  style='height:15.75pt'>S&#7889;</td>
  <td class=xl38 id="_x0000_s1027" x:autofilter="all" width=86
  style='width:65pt'>Ngày tháng</td>
  <td class=xl37 id="_x0000_s1031" x:autofilter="all">N&#7907;</td>
  <td class=xl58 id="_x0000_s1032" x:autofilter="all" style='border-right:.5pt solid windowtext;'>Có</td>
  <td class=xl67 id="_x0000_s1033" x:autofilter="all">STT</td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl39 style='height:15.75pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42 width=292 style='width:219pt'>S&#7888; D&#431; &#272;&#7846;U
  K&#7922;</td>
  <td class=xl42 width=292 style='width:219pt'>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl43 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= p_open_bal_dr_xls%></td>
  <td class=xl59 style="mso-number-format:'<%= p_xls_ccy_format %>';border-right:.5pt solid windowtext;mso-text-control:shrinktofit;" x:num><%= p_open_bal_cr_xls%></td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
 </tr>
  <%
      //Response.Write(SQL);
      //Response.End();  
	//DataTable dt_detail = ESysLib.TableReadOpen(SQL);
	string strDate = "";
	string strDate_Dsp = "";

    if (dtDetail.Rows.Count > 0)
	{
        for (i = 1; i < dtDetail.Rows.Count; i++)
		{
            if (strDate != dtDetail.Rows[i][2].ToString())
			{
                strDate_Dsp = dtDetail.Rows[i][2].ToString();
                strDate = dtDetail.Rows[i][2].ToString();
			}
			else
			{
				strDate_Dsp = "";
			}

            if (i < dtDetail.Rows.Count)
			{
			//height=42 style='height:31.5pt'
 %>
 <tr class=xl31 >
  <td class=xl28 ><%= strDate_Dsp %></td>
  <td class=xl29 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%= dtDetail.Rows[i][1].ToString()%></td>
  <td class=xl28 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;' ><%=dtDetail.Rows[i][2].ToString()%></td>
  <td class=xl56 align=left width=292 style='border-left:none;width:219pt'><%=dtDetail.Rows[i][13].ToString()%></td>
  <td class=xl56 align=left width=292 style='border-left:none;width:219pt'><%=dtDetail.Rows[i][12].ToString()%></td>
  <td class=xl44 ><%=dtDetail.Rows[i][15].ToString()%></td>
  <td class=xl45 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dtDetail.Rows[i][8].ToString()%></td>
  <td class=xl63 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dtDetail.Rows[i][9].ToString()%></td>
  <td class=xl64 style='border-top:none;border-left:none' x:num><%= dtDetail.Rows[i][0].ToString()%></td>
 </tr>
 <% }
 else
{ %>
 <tr class=xl31>
  <td class=xl30 style='border-top:none'><%= strDate_Dsp %></td>
  <td class=xl29 style='border-top:none;border-left:none'><%=dtDetail.Rows[i][1].ToString()%></td>
  <td class=xl28 style='border-top:none;border-left:none'><%=dtDetail.Rows[i][2].ToString()%></td>
  <td class=xl57 align=left width=292 style='width:219pt'><%=dtDetail.Rows[i][13].ToString()%></td>
  <td class=xl57 align=left width=292 style='width:219pt'><%=dtDetail.Rows[i][12].ToString()%></td>
  <td class=xl44 ><%=dtDetail.Rows[i][16].ToString()%></td>
  <td class=xl45  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dtDetail.Rows[i][8].ToString()%></td>
  <td class=xl65 style='border-top:none;border-left:none'  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dtDetail.Rows[i][9].ToString()%></td>
  <td class=xl66 style='border-top:none;border-left:none' x:num><%= dtDetail.Rows[i][0].ToString()%></td>
 </tr>
 <%
			}
		}
	}
 %>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt'>&nbsp;</td>
  <td class=xl47>&nbsp;</td>
  <td class=xl48>&nbsp;</td>
  <td class=xl49 x:str="T&#7893;ng c&#7897;ng s&#7889; phát sinh"><span
  style='mso-spacerun:yes'> </span>T&#7893;ng c&#7897;ng s&#7889; phát
  sinh<span style='mso-spacerun:yes'> </span></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
  <td class=xl49 style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dtSum.Rows[1][2].ToString()%></td>
  <td class=xl60 style='border-top:.5pt solid windowtext;border-right:.5pt solid windowtext;mso-text-control:shrinktofit;' style="mso-number-format:'<%= p_xls_ccy_format %>';" x:num><%= dtSum.Rows[1][3].ToString()%></td>
  <td class=xl62 >&nbsp;</td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 class=xl50 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
  <td class=xl53 width=292 style='width:219pt'>S&#7888; D&#431; CU&#7888;I
  K&#7922;</td>
  <td class=xl53 width=292 style='width:219pt'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl54  style="mso-number-format:'<%= p_xls_ccy_format %>';mso-text-control:shrinktofit;" x:num><%= dtSum.Rows[1][4].ToString()%></td>
  <td class=xl61  style="mso-number-format:'<%= p_xls_ccy_format %>';border-right:.5pt solid windowtext;mso-text-control:shrinktofit;" x:num><%= dtSum.Rows[1][5].ToString()%></td>
  <td class=xl62 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 colspan=8 class=xl27 style='height:24.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=8 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl31 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl31 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl71>Ngày <%= l_date_to.Substring(6, 2) %> tháng <%= l_date_to.Substring(4, 2) %> năm <%= l_date_to.Substring(0, 4) %></td>
  <td class=xl31></td>
 </tr>
<%
    string SQL1 = "SELECT   " +
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
    DataTable dt1 = ESysLib.TableReadOpen(SQL1);
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
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'></td>
  <td class=xl33><%= v1 %></td>
  <td class=xl31></td>
  <td class=xl33><%= v2%></td>
  <td class=xl33></td>
  <td colspan=3 class=xl33><%= v3 %></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'></td>
  <td class=xl55><span style='mso-spacerun:yes'> </span><%= g1 %></td>
  <td class=xl31></td>
  <td class=xl55><%= g2 %></td>
  <td class=xl55></td>
  <td colspan=3 class=xl55><%= g3 %></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 colspan=9 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 colspan=9 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 colspan=9 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 colspan=9 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 colspan=9 class=xl31 style='height:17.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='height:17.25pt'>
  <td height=23 class=xl31 style='height:17.25pt'></td>
  <td class=xl33><%= n1 %></td>
  <td class=xl31></td>
  <td class=xl33><%= n2%></td>
  <td class=xl33></td>
  <td colspan=3 class=xl33><%= n3 %></td>
  <td class=xl31></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=74 style='width:56pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=292 style='width:219pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=123 style='width:92pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>


