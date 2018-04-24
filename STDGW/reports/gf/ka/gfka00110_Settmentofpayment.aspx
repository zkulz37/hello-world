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
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    string l_company_pk = ""+Request["company_pk"];
    string l_emp_pk = ""+Request["emp_pk"];//ALL =''
    string l_from_date =""+Request["from_date"];
    string l_to_date = ""+Request["to_date"];
    string l_status =""+Request["status"];
    string l_acc_pk = "" + Request["acc_pk"];
    string l_trans_book =""+Request["Trans"];
    string l_ccy = "" + Request["CCy"];
    string l_book_ccy = "" + Request["BookCCy"]; 
    string SQL = "";
    string l_emp_id = "";
    String l_emp_name = "";
    String l_emp_addr = ""; 

    string l_cmp_name = "";
    string l_cmp_add = "";
    string l_cmp_taxcode = ""; 
    string l_rpt_date1 = "";
    string l_rpt_date2 = "";
    string l_rpt_date3 = "";
    string l_rpt_date4 = "";
    string l_rpt_date5 = "";
    string l_open_trans = "";
    string l_open_books = "";
    string l_total_income_trans = "";
    string l_total_income_book = "";
    string l_total_expense_trans = "";
    string l_total_expense_books = "";
    string l_total_close_trans = "";
    string l_total_close_book = "";     
    int i =0;
    double l_close_DR = 0;
    double l_close_CR = 0;
    double l_close_book = 0;  
      
    SQL = " SELECT partner_lname, addr2, tax_code,TO_CHAR(TO_DATE('" + l_from_date + "','YYYYMMDD'),'DD/MM/YYYY') DT1,TO_CHAR(TO_DATE('" + l_to_date + "','YYYYMMDD'),'DD/MM/YYYY') DT2, TO_CHAR(SYSDATE,'DD') DT3,TO_CHAR(SYSDATE,'MM') DT4,TO_CHAR(SYSDATE,'YYYY') DT5  FROM tco_company WHERE pk = " + l_company_pk;
    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        l_cmp_name = dt.Rows[0][0].ToString();
        l_cmp_add = dt.Rows[0][1].ToString();
        l_cmp_taxcode = dt.Rows[0][2].ToString();
        l_rpt_date1 = dt.Rows[0][3].ToString();
        l_rpt_date2 = dt.Rows[0][4].ToString();
        l_rpt_date3 = dt.Rows[0][5].ToString();
        l_rpt_date4 = dt.Rows[0][6].ToString();
        l_rpt_date5 = dt.Rows[0][7].ToString();
    }

    //SQL = "SELECT E.PK,E.EMP_ID,E.FULL_NAME,D.DEPT_NM,E.ADDR  FROM tac_employee_adv E,TCO_DEPT D  WHERE E.DEPT_PK=D.PK AND  E.PK =  " + l_emp_pk;
 SQL
	= "SELECT e.pk, e.emp_id, e.full_name, d.org_nm, a.present_addr addr  " + 
        "  FROM tac_employee_adv e, tco_org d, hr.thr_employee a  " +
        " WHERE e.tco_org_pk = d.pk(+) AND a.del_if(+) = 0 AND e.thr_employee_pk = a.pk(+)  " +
        "       AND e.pk =  '" + l_emp_pk + "' " ;

	//Response.Write(SQL);
	//Response.End();
    dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count > 0)
    {
        l_emp_id = dt.Rows[0][1].ToString();
        l_emp_name = dt.Rows[0][2].ToString();
        l_emp_addr = dt.Rows[0][3].ToString();
        
    }
  
    String p_xls_ccy_format_vnd = "";
    String p_xls_ccy_format_usd = "";
    p_xls_ccy_format_vnd = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    String p_xls_ccy_format_trans = "";
    String p_xls_ccy_format_books = ""; 
   %> 
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00110_Settmentofpayment_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00110_Settmentofpayment_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00110_Settmentofpayment_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Tuyen</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-12-03T02:13:17Z</o:LastPrinted>
  <o:Created>2006-10-29T04:26:21Z</o:Created>
  <o:LastSaved>2008-12-03T02:13:27Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.75in 0in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
.font10
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
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
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl30
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
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
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl65
	{mso-style-parent:style0;
	color:black;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl71
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
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
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>M&#7851;u s&#7889;  04TT</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>85</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>9</x:SplitHorizontal>
     <x:TopRowBottomPane>9</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveCol>1</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>21</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
       <x:RangeSelection>$D$22:$E$22</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='M&#7851;u s&#7889;  04TT'!$8:$9</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1114 style='border-collapse:
 collapse;table-layout:fixed;width:836pt'>
 <col class=xl25 width=84 style='mso-width-source:userset;mso-width-alt:3072;
 width:63pt'>
 <col class=xl25 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl25 width=250 span=2 style='mso-width-source:userset;mso-width-alt:
 9142;width:188pt'>
 <col class=xl25 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl25 width=150 style='mso-width-source:userset;mso-width-alt:4022;
 width:83pt'>
 <col class=xl25 width=103 span=2 style='mso-width-source:userset;mso-width-alt:
 3766;width:77pt'>
 <col class=xl25 width=75 style='mso-width-source:userset;mso-width-alt:2742;
 width:56pt'>
 <tr height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl24 width=406 style='height:15.75pt;
  width:305pt'><%= l_cmp_name %></td>
  <td class=xl25 width=250 style='width:188pt'></td>
  <td class=xl25 width=67 style='width:50pt'></td>
  <td colspan=4 class=xl69 width=391 style='width:293pt'>M&#7851;u s&#7889;:
  04-TT</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td colspan=3 height=20 class=xl24 style='height:15.0pt'>Accouting Department</td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl70
  x:str="(Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày ">(Ban
  hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl25 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl70>20 tháng 03 n&#259;m 2006 c&#7911;a B&#7897;
  tr&#432;&#7901;ng B&#7897; Tài chính)</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=9 height=27 class=xl66 width=1114 style='height:20.25pt;
  width:836pt'>GI&#7844;Y THANH TOÁN TI&#7872;N T&#7840;M &#7912;NG</td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=9 height=25 class=xl67 width=1114 style='height:18.75pt;
  width:836pt'>( SETTLEMENT OF PAYMENT )</td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td colspan=9 height=20 class=xl68 style='height:15.0pt'>T&#7915;
  ngày <%= l_rpt_date1 %> &#273;&#7871;n ngày <%= l_rpt_date2 %> &nbsp;</td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td colspan=9 height=20 class=xl27 width=1114 style='height:15.0pt;
  width:836pt'>H&#7885; tên ng&#432;&#7901;i thanh toán/Employee Name :<font
  class="font10"><%= l_emp_id%>     <%= l_emp_name%></font></td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td colspan=2 height=20 class=xl26 width=156 style='height:15.0pt;width:117pt'>B&#7897;
  ph&#7853;n (ho&#7863;c &#273;&#7883;a ch&#7881;) :</td>
  <td colspan=7 class=xl26 style='mso-ignore:colspan'><%= l_emp_addr %></td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td colspan=3 height=20 class=xl27 width=406 style='height:15.0pt;width:305pt'>S&#7889;
  ti&#7873;n t&#7841;m &#7913;ng &#273;&#432;&#7907;c thanh toán theo
  b&#7843;ng d&#432;&#7899;i &#273;ây:</td>
  <td colspan=6 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl64 style='height:15.0pt'>Ch&#7913;ng
  t&#7915;/ Voucher</td>
  <td rowspan=2 class=xl71 width=250 style='width:188pt'>Di&#7877;n gi&#7843;i</td>
  <td rowspan=2 class=xl71 width=250 style='width:188pt'>Description</td>
  <td rowspan=2 class=xl73 width=150 style='width:80pt'>S&#7889; hi&#7879;u TK
  &#273;&#7889;i &#7913;ng</td>
  <td class=xl28 width=110 style='width:83pt'>N&#7907;</td>
  <td class=xl28 width=103 style='width:77pt'>Có</td>
  <td class=xl28 width=103 style='width:77pt'>Ghi s&#7893;</td>
  <td rowspan=2 class=xl71 width=75 style='width:56pt'>Remark</td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt;border-top:none'>S&#7889;/ No</td>
  <td class=xl65 style='border-top:none;border-left:none'>Ngày/ Date</td>
  <td class=xl29 width=110 style='width:83pt'>(Debit)</td>
  <td class=xl29 width=103 style='width:77pt'>(Credit)</td>
  <td class=xl29 width=103 style='width:77pt'>(Book)</td>
 </tr>
<%
    /*
    SQL = " SELECT TO_CHAR((ac_get_EMP_BAL('" + l_company_pk + "'," + l_emp_pk + ",'" + l_ccy + "','" + l_from_date + "','" + l_status + "','D','TRANS') - ac_get_EMP_BAL('" + l_company_pk + "'," + l_emp_pk + ",'" + l_ccy + "','" + l_from_date + "','" + l_status + "','C','TRANS') )*TO_NUMBER(DECODE( ac_get_DRCRTYPE(" + l_company_pk + "," + l_acc_pk + "),'D','1','-1')),'9,999,999,999,999,990.99') OPEN_TRANS, TO_CHAR((ac_get_EMP_BAL('" + l_company_pk + "'," + l_emp_pk + ",'" + l_ccy + "','" + l_from_date + "','" + l_status + "','D','BOOKS') - ac_get_EMP_BAL('" + l_company_pk + "'," + l_emp_pk + ",'" + l_ccy + "','" + l_from_date + "','" + l_status + "','C','BOOKS') )*TO_NUMBER(DECODE( ac_get_DRCRTYPE(" + l_company_pk + "," + l_acc_pk + "),'D','1','-1')),'9,999,999,999,999,990.99')   OPEN_BOOKS FROM DUAL";

     */
    SQL = "SELECT TO_NUMBER(DECODE(ac_get_DRCRTYPE('" + l_company_pk + "'," + l_acc_pk + "),'D','1','C','-1','1'))*(ac_get_EMP_OPENBAL('" + l_company_pk + "'," + l_acc_pk + ",'" + l_emp_pk + "','" + l_ccy + "','" + l_from_date + "','" + l_status + "','D','TRANS') - ac_get_EMP_OPENBAL('" + l_company_pk + "'," + l_acc_pk + ",'" + l_emp_pk + "','" + l_ccy + "','" + l_from_date + "','" + l_status + "','C','TRANS')) ,TO_NUMBER(DECODE(ac_get_DRCRTYPE('" + l_company_pk + "'," + l_acc_pk + "),'D','1','C','-1','1'))*(ac_get_EMP_OPENBAL('" + l_company_pk + "'," + l_acc_pk + ",'" + l_emp_pk + "','" + l_book_ccy + "','" + l_from_date + "','" + l_status + "','D','BOOK') - ac_get_EMP_OPENBAL('" + l_company_pk + "'," + l_acc_pk + ",'" + l_emp_pk + "','" + l_book_ccy + "','" + l_from_date + "','" + l_status + "','C','BOOK'))  " +
        "    FROM DUAL ";
   DataTable dt_detail = ESysLib.TableReadOpen(SQL);
   if(dt_detail.Rows.Count > 0)
   {
	   
		l_open_trans = dt_detail.Rows[0][0].ToString();
		l_open_books = dt_detail.Rows[0][1].ToString();
	   if(l_open_trans != "")
			l_close_DR = double.Parse(l_open_trans);
		else
			l_close_DR = 0;
		if(l_open_books != "")			
			l_close_book = double.Parse(l_open_books);
		else
			l_close_book = 0;
	}
    else
	{
		l_open_trans = "0";
		l_open_books = "0";
		l_close_DR = 0;
		l_close_book = 0;
	}	
   if (l_ccy == "VND")
    {
        p_xls_ccy_format_trans = p_xls_ccy_format_vnd;
    }
    else
    {
        p_xls_ccy_format_trans = p_xls_ccy_format_usd;
    }

    if (l_book_ccy == "VND")
    {
        p_xls_ccy_format_books = p_xls_ccy_format_vnd;
    }
    else
    {
        p_xls_ccy_format_books = p_xls_ccy_format_usd;
    }

    SQL = "        SELECT  " +
        "        NVL(SUM(DECODE(D.DRCR_TYPE,'D',D.TR_AMT,0)),0),NVL(SUM(DECODE(D.DRCR_TYPE,'D',D.TR_BOOKAMT,0)),0),  " +
        "        NVL(SUM(DECODE(D.DRCR_TYPE,'C',D.TR_AMT,0)),0),NVL(SUM(DECODE(D.DRCR_TYPE,'C',D.TR_BOOKAMT,0)),0) " +
        "        FROM TAC_HGTRH H, TAC_HGTRD D,TAC_HGTRDITEM I, TAC_ABACCTITEM A " +
        "        WHERE H.DEL_IF= 0 " +
        "        AND D.DEL_IF = 0 " +
        "        AND A.DEL_IF = 0 " +
        "        AND H.PK = D.TAC_HGTRH_PK " +
        "        AND D.PK = I.TAC_HGTRD_PK " +
        "        AND I.TAC_ABACCTITEM_PK = A.PK " +
        "        AND (('" + l_acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + l_acc_pk + "')) " +
        "        AND (('EMPLOYEE NAME' IS NULL) OR (UPPER(A.TAC_ABITEM_ALIAS) = UPPER('EMPLOYEE NAME'))) " +
        "        AND H.TR_STATUS IN ('" + l_status + "',DECODE('" + l_status + "',2,0,'" + l_status + "'),DECODE('" + l_status + "',2,4,'" + l_status + "'))  " +
        "        AND H.TCO_COMPANY_PK ='" + l_company_pk + "' " +
        "        AND (('" + l_emp_pk + "' IS NULL) OR (I.ITEM_TABLE_PK = '" + l_emp_pk + "')) " +
        "        AND DECODE('" + l_ccy + "','ALL','1',D.CCY) = DECODE('" + l_ccy + "','ALL','1','" + l_ccy + "')  " +
        "        AND H.TR_DATE BETWEEN TO_DATE('" + l_from_date + "','YYYYMMDD') AND TO_DATE('" + l_to_date + "','YYYYMMDD') ";

   dt_detail = ESysLib.TableReadOpen(SQL);
    l_total_income_trans = dt_detail.Rows[0][0].ToString();
    l_total_income_book = dt_detail.Rows[0][1].ToString();
    l_total_expense_trans = dt_detail.Rows[0][2].ToString();
    l_total_expense_books = dt_detail.Rows[0][3].ToString();

    l_close_DR = l_close_DR + double.Parse(l_total_income_trans) - double.Parse(l_total_expense_trans);
    l_close_book = l_close_book + double.Parse(l_total_income_book) - double.Parse(l_total_expense_books);
 %> 
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 class=xl60 width=84 style='height:15.0pt;border-top:none;
  width:63pt'>&nbsp;</td>
  <td class=xl61 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl60 width=250 style='border-left:none;width:188pt'>S&#7889;
  ti&#7873;n k&#7923; tr&#432;&#7899;c ch&#432;a chi h&#7871;t</td>
  <td class=xl60 width=250 style='border-left:none;width:188pt'>Openning</td>
  <td class=xl60 width=67 style='border-top:none;border-left:none;width:50pt'>&nbsp;</td>
  <td class=xl37 style='border-left:none' style="mso-number-format:'<%= p_xls_ccy_format_trans %>';"  x:num ><%= l_open_trans %></td>
  <td class=xl60 width=103 style='border-left:none;width:77pt'>&nbsp;</td>
  <td class=xl37 style='border-left:none' style="mso-number-format:'<%= p_xls_ccy_format_books %>';"  x:num><%= l_open_books %></td>
  <td class=xl60 width=75 style='border-left:none;width:56pt'>&nbsp;</td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 class=xl54 width=84 style='height:15.0pt;width:63pt'>&nbsp;</td>
  <td class=xl55 width=72 style='border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl56 width=250 style='border-left:none;width:188pt'>I.<span
  style='mso-spacerun:yes'>  </span>S&#7889; ti&#7873;n t&#7841;m &#7913;ng</td>
  <td class=xl56 width=250 style='border-left:none;width:188pt'><span
  style='mso-spacerun:yes'> </span>I.<span style='mso-spacerun:yes'> 
  </span>INCOME SOURCE</td>
  <td class=xl62 style='border-left:none'>&nbsp;</td>
  <td class=xl57 style='border-left:none' style="mso-number-format:'<%= p_xls_ccy_format_trans %>';"  x:num><%= l_total_income_trans %></td>
  <td class=xl57 style='border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl58 style='border-left:none' style="mso-number-format:'<%= p_xls_ccy_format_books %>';"  x:num><%= l_total_income_book %></td>
  <td class=xl59 width=75 style='border-left:none;width:56pt'>&nbsp;</td>
 </tr>
<%
    
    SQL = "        SELECT   H.VOUCHERNO,TO_CHAR(H.TR_DATE,'DD/MM/YYYY'),D.REMARK,D.REMARK2,ac_get_ACCD(DECODE(R.DRCR_TYPE,'C',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR),'" + l_company_pk + "')," +
           "        TO_CHAR(DECODE(D.DRCR_TYPE,'D',R.TR_AMT,0),'9,999,999,999,999,990.99'), TO_CHAR(DECODE(D.DRCR_TYPE,'C',R.TR_AMT,0),'9,999,999,999,999,990.99') ,TO_CHAR(R.TR_BOOKAMT,'9,999,999,999,999,990.99'),  H.PK,D.CCY " +
           "        FROM TAC_HGTRH H, TAC_HGTRD D,TAC_HGTRD_REF R,TAC_HGTRDITEM I, TAC_ABACCTITEM A " +
           "        WHERE H.DEL_IF= 0 " +
           "        AND D.DEL_IF = 0 " +
           "        AND A.DEL_IF = 0 " +
           "        AND D.DRCR_TYPE = 'D' " +
           "        AND R.DEL_IF = 0 " +
           "        AND D.PK = R.TAC_HGTRD_PK " +
           "        AND H.PK = D.TAC_HGTRH_PK " +
           "        AND D.PK = I.TAC_HGTRD_PK " +
           "        AND I.TAC_ABACCTITEM_PK = A.PK " +
           "        AND (('" + l_acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + l_acc_pk + "')) " +
           "        AND (('EMPLOYEE NAME' IS NULL) OR (UPPER(A.TAC_ABITEM_ALIAS) = UPPER('EMPLOYEE NAME'))) " +
           "        AND H.TR_STATUS IN ('" + l_status + "',DECODE('" + l_status + "',2,0,'" + l_status + "'),DECODE('" + l_status + "',2,4,'" + l_status + "'))  " +
           "        AND H.TCO_COMPANY_PK ='" + l_company_pk + "' " +
           "        AND (('" + l_emp_pk + "' IS NULL) OR (I.ITEM_TABLE_PK = '" + l_emp_pk + "')) " +
           "        AND DECODE('" + l_ccy + "','ALL','1',D.CCY) = DECODE('" + l_ccy + "','ALL','1','" + l_ccy + "')  " +
           "        AND H.TR_DATE BETWEEN TO_DATE('" + l_from_date + "','YYYYMMDD') AND TO_DATE('" + l_to_date + "','YYYYMMDD') " +
           "  ORDER BY H.TR_DATE,H.VOUCHERNO,D.CCY";
     
    dt_detail = ESysLib.TableReadOpen(SQL);
    for (i = 0; i < dt_detail.Rows.Count; i++)
    {
        if (dt_detail.Rows[i][9].ToString() == "VND")
        {
            p_xls_ccy_format_trans = p_xls_ccy_format_vnd;
        }
        else
        {
            p_xls_ccy_format_trans = p_xls_ccy_format_usd;
        }
    
 %>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl44 style='height:15.75pt;border-top:none'><%= dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl39 width=250 style='border-top:none;border-left:none;width:188pt'><%= dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl39 width=250 style='border-top:none;border-left:none;width:188pt'><%= dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl39 width=250><%= dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl46 style='border-top:none;border-left:none'  style="mso-number-format:'<%= p_xls_ccy_format_trans %>';"  x:num><%= dt_detail.Rows[i][5].ToString()%></td>
  <td class=xl46 style='border-top:none;border-left:none'  style="mso-number-format:'<%= p_xls_ccy_format_trans %>';"  x:num><%= dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl47 style='border-top:none;border-left:none'  style="mso-number-format:'<%= p_xls_ccy_format_books %>';" x:num><%= dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl43 width=75 style='border-top:none;border-left:none;width:56pt'
  x:num><%= dt_detail.Rows[i][8].ToString()%></td>
 </tr>
<%
}
 %> 
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 class=xl44 style='height:15.0pt;border-top:none'></td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl40 width=250 style='border-top:none;border-left:none;width:188pt'>II.
  S&#7889; ti&#7873;n &#273;ã chi</td>
  <td class=xl40 width=250 style='border-top:none;border-left:none;width:188pt'>II.<span
  style='mso-spacerun:yes'>  </span>EXPENSE</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl41 style='border-top:none;border-left:none' x:num="0"><span
  style='mso-spacerun:yes'> </span>-<span style='mso-spacerun:yes'>   </span></td>
  <td class=xl41 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format_trans %>';"  x:num><%= l_total_expense_trans%></td>
  <td class=xl42 style='border-top:none;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format_books %>';"  x:num><%=  l_total_expense_books%></td>
  <td class=xl43 width=75 style='border-top:none;border-left:none;width:56pt'>&nbsp;</td>
 </tr>
<%
    SQL = "        SELECT   H.VOUCHERNO,TO_CHAR(H.TR_DATE,'DD/MM/YYYY'),D.REMARK,D.REMARK2,ac_get_ACCD(DECODE(R.DRCR_TYPE,'D',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR),'" + l_company_pk + "')," +
           "        TO_CHAR(DECODE(D.DRCR_TYPE,'D',R.TR_AMT,0),'9,999,999,999,999,990.99'), TO_CHAR(DECODE(D.DRCR_TYPE,'C',R.TR_AMT,0),'9,999,999,999,999,990.99') ,TO_CHAR(R.TR_BOOKAMT,'9,999,999,999,999,990.99'),  H.PK,D.CCY " +
           "        FROM TAC_HGTRH H, TAC_HGTRD D,TAC_HGTRD_REF R,TAC_HGTRDITEM I, TAC_ABACCTITEM A " +
           "        WHERE H.DEL_IF= 0 " +
           "        AND D.DEL_IF = 0 " +
           "        AND A.DEL_IF = 0 " +
           "        AND D.DRCR_TYPE = 'C' " +
           "        AND R.DEL_IF = 0 " +
           "        AND D.PK = R.TAC_HGTRD_PK " +
           "        AND H.PK = D.TAC_HGTRH_PK " +
           "        AND D.PK = I.TAC_HGTRD_PK " +
           "        AND I.TAC_ABACCTITEM_PK = A.PK " +
           "        AND (('" + l_acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + l_acc_pk + "')) " +
           "        AND (('EMPLOYEE NAME' IS NULL) OR (UPPER(A.TAC_ABITEM_ALIAS) = UPPER('EMPLOYEE NAME'))) " +
 "        AND H.TR_STATUS IN ('" + l_status + "',DECODE('" + l_status + "',2,0,'" + l_status + "'),DECODE('" + l_status + "',2,4,'" + l_status + "'))  " +
           "        AND H.TCO_COMPANY_PK ='" + l_company_pk + "' " +
           "        AND (('" + l_emp_pk + "' IS NULL) OR (I.ITEM_TABLE_PK = '" + l_emp_pk + "')) " +
           "        AND DECODE('" + l_ccy + "','ALL','1',D.CCY) = DECODE('" + l_ccy + "','ALL','1','" + l_ccy + "')  " +
           "        AND H.TR_DATE BETWEEN TO_DATE('" + l_from_date + "','YYYYMMDD') AND TO_DATE('" + l_to_date + "','YYYYMMDD') "+
           "  ORDER BY H.TR_DATE,H.VOUCHERNO,D.CCY";
    /*
SQL = "        SELECT   H.VOUCHERNO,TO_CHAR(H.TR_DATE,'DD/MM/YYYY'),H.REMARK,H.REMARK2,ac_get_ACCD(R.TAC_ABACCTCODE_PK_CR,'" + l_company_pk + "')," +
           "        TO_CHAR(DECODE(R.DRCR_TYPE,'D',R.TR_AMT,0),'9,999,999,999,999,990.99'), TO_CHAR(DECODE(R.DRCR_TYPE,'C',R.TR_AMT,0),'9,999,999,999,999,990.99') ,TO_CHAR(DECODE(R.DRCR_TYPE,'D',R.TR_BOOKAMT,0),'9,999,999,999,999,990.99'),  H.PK,D.CCY " +
           "        FROM TAC_HGTRH H, TAC_HGTRD D,TAC_HGTRD_REF R,TAC_HGTRDITEM I, TAC_ABACCTITEM A " +
           "        WHERE H.DEL_IF= 0 " +
           "        AND D.DEL_IF = 0 " +
           "        AND A.DEL_IF = 0 " +
           "        AND D.DRCR_TYPE = 'C' "+
            "       AND R.DRCR_TYPE = 'C' " +
           "        AND R.DEL_IF = 0 " +
           "        AND D.PK = R.TAC_HGTRD_PK " +
           "        AND H.PK = D.TAC_HGTRH_PK " +
           "        AND D.PK = I.TAC_HGTRD_PK " +
           "        AND I.TAC_ABACCTITEM_PK = A.PK " +
           "        AND R.TAC_ABACCTCODE_PK_CR = " + l_acc_pk + 
           "        AND (('" + l_acc_pk + "' IS NULL) OR (D.TAC_ABACCTCODE_PK = '" + l_acc_pk + "')) " +
           "        AND (R.TAC_ABACCTCODE_PK_DR = '" + l_acc_pk + "') " +
           "        AND (('EMPLOYEE NAME' IS NULL) OR (UPPER(A.TAC_ABITEM_ALIAS) = UPPER('EMPLOYEE NAME'))) " +
           "        AND H.TR_STATUS IN ('" + l_status + "',DECODE('" + l_status + "',2,0,'" + l_status + "'),DECODE('" + l_status + "',2,4,'" + l_status + "'))  " +
           "        AND H.TCO_COMPANY_PK ='" + l_company_pk + "' " +
           "        AND (('" + l_emp_pk + "' IS NULL) OR (I.ITEM_TABLE_PK = '" + l_emp_pk + "')) " +
           "        AND DECODE('" + l_ccy + "','ALL','1',D.CCY) = DECODE('" + l_ccy + "','ALL','1','" + l_ccy + "')  " +
           "        AND H.TR_DATE BETWEEN TO_DATE('" + l_from_date + "','YYYYMMDD') AND TO_DATE('" + l_to_date + "','YYYYMMDD') ";
      */
dt_detail = ESysLib.TableReadOpen(SQL);
    for (i = 0; i < dt_detail.Rows.Count; i++)
    {
        if (dt_detail.Rows[i][9].ToString() == "VND")
        {
            p_xls_ccy_format_trans = p_xls_ccy_format_vnd;
        }
        else
        {
            p_xls_ccy_format_trans = p_xls_ccy_format_usd;
        }
    
 %>
 <tr class=xl26 height=21 style='height:15.75pt'>
  <td height=21 class=xl44 style='height:15.75pt;border-top:none'><%= dt_detail.Rows[i][0].ToString()%></td>
  <td class=xl45 style='border-top:none;border-left:none'><%= dt_detail.Rows[i][1].ToString()%></td>
  <td class=xl39 width=250 style='border-top:none;border-left:none;width:188pt'><%= dt_detail.Rows[i][2].ToString()%></td>
  <td class=xl39 width=250 style='border-top:none;border-left:none;width:188pt'><%= dt_detail.Rows[i][3].ToString()%></td>
  <td class=xl39 ><%= dt_detail.Rows[i][4].ToString()%></td>
  <td class=xl46 style='border-top:none;border-left:none'  style="mso-number-format:'<%= p_xls_ccy_format_trans %>';"  x:num><%= dt_detail.Rows[i][5].ToString()%></td>
  <td class=xl46 style='border-top:none;border-left:none'  style="mso-number-format:'<%= p_xls_ccy_format_trans %>';"  x:num><%= dt_detail.Rows[i][6].ToString()%></td>
  <td class=xl47 style='border-top:none;border-left:none'  style="mso-number-format:'<%= p_xls_ccy_format_books %>';" x:num><%= dt_detail.Rows[i][7].ToString()%></td>
  <td class=xl43 width=75 style='border-top:none;border-left:none;width:56pt'
  x:num><%= dt_detail.Rows[i][8].ToString()%></td>
 </tr>
<%
}
 %>  
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 class=xl33 width=84 style='height:15.0pt;border-top:.5pt solid windowtext;;
  width:63pt'>&nbsp;</td>
  <td class=xl34 width=72 style='border-top:.5pt solid windowtext;;border-left:none;width:54pt'>&nbsp;</td>
  <td class=xl35 width=250 style='border-top:.5pt solid windowtext;;border-left:none;width:188pt'>S&#7889;
  ti&#7873;n còn l&#7841;i</td>
  <td class=xl35 width=250 style='border-top:.5pt solid windowtext;border-left:none;width:188pt'>Closing</td>
  <td class=xl35 width=67 style='border-left:none;width:50pt'>&nbsp;</td>
  <td class=xl36 style='border-top:.5pt solid windowtext;;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format_trans %>';"   x:num><%= l_close_DR%></td>
  <td class=xl37 style='border-top:.5pt solid windowtext;;border-left:none'>&nbsp;</td>
  <td class=xl36 style='border-top:.5pt solid windowtext;;border-left:none' style="mso-number-format:'<%= p_xls_ccy_format_books %>';"  x:num><%= l_close_book %></td>
  <td class=xl38 width=75 style='border-top:.5pt solid windowtext;;border-left:none;width:56pt'>&nbsp;</td>
 </tr>
 <tr class=xl26 height=20 style='height:15.0pt'>
  <td height=20 colspan=9 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl32 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=2 height=19 class=xl31 width=156 style='height:14.25pt;
  width:117pt'>T&#7893;ng Giám &#273;&#7889;c</td>
  <td class=xl31 width=250 style='width:188pt'>K&#7871; toán tr&#432;&#7903;ng</td>
  <td colspan=2 class=xl31 width=317 style='width:238pt'>K&#7871; toán thanh
  toán</td>
  <td colspan=3 class=xl31 width=316 style='width:237pt'>Ng&#432;&#7901;i
  &#273;&#7873; ngh&#7883; thanh toán</td>
  <td class=xl32></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td colspan=2 height=17 class=xl30 width=156 style='height:12.75pt;
  width:117pt'>(Ký, h&#7885; tên)</td>
  <td class=xl30 width=250 style='width:188pt'>(Ký, h&#7885; tên)</td>
  <td colspan=2 class=xl30 width=317 style='width:238pt'>(Ký, h&#7885; tên)</td>
  <td colspan=3 class=xl30 width=316 style='width:237pt'>(Ký, h&#7885; tên)</td>
  <td class=xl25></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=84 style='width:63pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=250 style='width:188pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=75 style='width:56pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
