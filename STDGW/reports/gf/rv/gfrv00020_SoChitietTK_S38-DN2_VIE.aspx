<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
    ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string com_pk = "" + Request["company_pk"];
    string ac_pk = "" + Request["account_pk"];
    string cust_pk = "" + Request["cust_pk"];
    string d_from = "" + Request["dtbFrom"];
    string d_to = "" + Request["dtbTo"];
    string ccy = "" + Request["bookccy"];
    string l_trans_ccy = ""+Request["transccy"];
    string p_book_ccy = ccy; 
    string status = "" + Request["status"];
    string from_date = d_from.Substring(6, 2) + "/" + d_from.Substring(4, 2) + "/" + d_from.Substring(0, 4);
    string to_date = d_to.Substring(6, 2) + "/" + d_to.Substring(4, 2) + "/" + d_to.Substring(0, 4);
    string name = "";
    string lname = "";
    string address = "";
    string tax_code = "";
    string ac_cd = "";
    string ac_nm = "";
    string drcr_type = "";
    string seq = "";
    string tr_date = "";
    string voucher = "";
    string acc_cor = "";
    string remark = "";
    string remark2 = "";
    
    double dr_openning = 0;
    double cr_openning = 0;
    double dr_closing = 0;
    double cr_closing = 0;
    double dr_amt = 0;
    double cr_amt = 0;
    double dr_sum = 0;
    double cr_sum = 0;
    double dr_end = 0;
    double cr_end = 0;
   
    double dr_fopenning = 0;
    double cr_fopenning = 0;
    double dr_fclosing = 0;
    double cr_fclosing = 0;
    double dr_famt = 0;
    double cr_famt = 0;
    double dr_fsum = 0;
    double cr_fsum = 0;
    double dr_fend = 0;
    double cr_fend = 0;

    string SQL = " SELECT pk, partner_name, partner_lname, addr2 address, tax_code ";
    SQL += "  FROM tco_company ";
    SQL += " WHERE del_if = 0 AND pk = '" + com_pk + "'";
    DataTable dtCom = ESysLib.TableReadOpen(SQL);
    if (dtCom.Rows.Count > 0)
    {
        name = dtCom.Rows[0][1].ToString();
        lname = dtCom.Rows[0][2].ToString();
        address = dtCom.Rows[0][3].ToString();
        tax_code = dtCom.Rows[0][4].ToString();
    }
    
    string SQLAC = "SELECT pk, ac_cd, ac_lnm, drcr_type  FROM tac_localcode ";
    SQLAC += " WHERE del_if = 0 and tco_company_pk ='" + com_pk + "' and pk ='" + ac_pk + "'";

    DataTable dtAcc = ESysLib.TableReadOpen(SQLAC);
    if (dtAcc.Rows.Count > 0)
    {
        ac_cd = dtAcc.Rows[0][1].ToString();
        ac_nm = dtAcc.Rows[0][2].ToString();
        drcr_type = dtAcc.Rows[0][3].ToString();
    }
   string SQLB = " SELECT SF_GET_DRCR_OPENBAL('" + com_pk + "','" + ac_pk + "','','" + d_from + "','" + status + "','D','TRANS') DR_TRANS, SF_GET_DRCR_OPENBAL('" + com_pk + "','" + ac_pk + "','','" + d_from + "','" + status + "','C','TRANS') CR_TRANS,SF_GET_DRCR_OPENBAL('" + com_pk + "','" + ac_pk + "','','" + d_from + "','" + status + "','D','BOOK') DR_BOOK, SF_GET_DRCR_OPENBAL('" + com_pk + "','" + ac_pk + "','','" + d_from + "','" + status + "','C','BOOK') CR_BOOK FROM DUAL ";
     
            DataTable dtB = ESysLib.TableReadOpen(SQLB);
            if (dtB.Rows.Count > 0)
            {
                if (drcr_type == "D")
                {
                    dr_fopenning = double.Parse(dtB.Rows[0][0].ToString()) - double.Parse(dtB.Rows[0][1].ToString());
                    cr_fopenning = 0;
                    dr_openning = double.Parse(dtB.Rows[0][2].ToString()) - double.Parse(dtB.Rows[0][3].ToString());
                    cr_openning = 0;
                }
                else 
                {
                    dr_fopenning = 0;
                    cr_fopenning = double.Parse(dtB.Rows[0][1].ToString()) - double.Parse(dtB.Rows[0][0].ToString());
                    dr_openning = 0;
                    cr_openning = double.Parse(dtB.Rows[0][3].ToString()) - double.Parse(dtB.Rows[0][2].ToString());
                    
                }
            }
            String p_xls_ccy_format_book = "";
            String p_xls_ccy_format_trans = "";

            if (p_book_ccy == "VND")
            {
                p_xls_ccy_format_book = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
            }
            else
            {
                p_xls_ccy_format_book = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
            } 
            if (l_trans_ccy == "VND")
            {
                p_xls_ccy_format_trans = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
            }
            else
            {
                p_xls_ccy_format_trans = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
            } 
            
            
   %> 

<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00160_SoChitietTK_S38-DN2_files/filelist.xml">
<link rel=Edit-Time-Data href="gfka00160_SoChitietTK_S38-DN2_files/editdata.mso">
<link rel=OLE-Object-Data href="gfka00160_SoChitietTK_S38-DN2_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Acc</o:Author>
  <o:LastAuthor>Administrator</o:LastAuthor>
  <o:LastPrinted>2008-12-10T03:06:03Z</o:LastPrinted>
  <o:Created>2008-01-29T03:54:09Z</o:Created>
  <o:LastSaved>2008-12-10T03:06:17Z</o:LastSaved>
  <o:Company>Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.5in 0in .75in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl32
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
.xl33
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
	border-left:none;
	white-space:normal;}
.xl34
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
.xl35
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
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
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
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
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
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
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
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:normal;}
.xl52
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;\[Red\]_\(\\ \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl57
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl58
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl61
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl62
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl63
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	vertical-align:middle;}
.xl64
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;}
.xl65
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl68
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl69
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
.xl70
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
.xl71
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl72
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
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl74
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
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
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
.xl79
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
.xl80
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
.xl81
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
.xl82
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
	border-left:.5pt solid black;
	white-space:normal;}
.xl83
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
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:left;
	vertical-align:middle;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl88
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\\\/mm\\\/yyyy";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl89
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
.xl90
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>S&#7893; chi ti&#7871;t TK</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>402</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>70</x:Scale>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>12</x:SplitHorizontal>
     <x:TopRowBottomPane>12</x:TopRowBottomPane>
     <x:SplitVertical>3</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; chi ti&#7871;t TK'!$A$12:$K$12</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='S&#7893; chi ti&#7871;t TK'!$12:$12</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1036"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1393 style='border-collapse:
 collapse;table-layout:fixed;width:1046pt'>
 <col class=xl24 width=82 span=2 style='mso-width-source:userset;mso-width-alt:
 2998;width:62pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=264 span=2 style='mso-width-source:userset;mso-width-alt:
 9654;width:198pt'>
 <col class=xl24 width=61 style='mso-width-source:userset;mso-width-alt:2230;
 width:46pt'>
 <col class=xl24 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl24 width=107 span=2 style='mso-width-source:userset;mso-width-alt:
 3913;width:80pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl25 width=842 style='height:15.0pt;width:633pt'><%=name %></td>
  <td class=xl25 width=62 style='width:47pt'></td>
  <td colspan=4 class=xl26 width=426 style='width:319pt'>M&#7851;u s&#7889;
  S38-DN</td>
  <td class=xl24 width=63 style='width:47pt'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl25 style='height:15.0pt'><%=address %></td>
  <td class=xl25></td>
  <td colspan=4 class=xl66
  x:str="                 (Ban hành theo Quy&#7871;t &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày "><span
  style='mso-spacerun:yes'>                 </span>(Ban hành theo Quy&#7871;t
  &#273;&#7883;nh s&#7889; 15/2006/Q&#272;-BTC ngày<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl25 style='height:15.0pt'>TAX CODE: <%=tax_code %></td>
  <td class=xl25></td>
  <td colspan=4 class=xl66>&nbsp;&nbsp;&nbsp;<span
  style='mso-spacerun:yes'>            </span>20 tháng 03 n&#259;m 2006
  c&#7911;a B&#7897; tr&#432;&#7901;ng B&#7897; Tài chính)</td>
  <td class=xl24></td>
 </tr>
 <tr height=35 style='height:26.25pt'>
  <td colspan=11 height=35 class=xl67 style='height:26.25pt'>S&#7892; CHI
  TI&#7870;T TÀI KHO&#7842;N</td>
  <td class=xl24></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=11 height=27 class=xl68 style='height:20.25pt'>T&#7915; ngày
  <%=from_date%> &#272;&#7871;n ngày <%=to_date%></td>
  <td class=xl24></td>
 </tr>
 <tr class=xl27 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl28 style='height:18.75pt'>Tài kho&#7843;n:</td>
  <td class=xl29 ><%=ac_cd %></td>
  <td colspan=2 class=xl30>Tên tài kho&#7843;n:</td>
  <td colspan=7 class=xl29><%=ac_nm %></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&#272;&#7889;i
  t&#432;&#7907;ng:</td>
  <td colspan=3 class=xl28></td>
  <td colspan=5 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl30>&#272;&#417;n v&#7883; tính:</td>
  <td class=xl26><%= p_book_ccy %></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl31 style='height:15.75pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td colspan=5 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td rowspan=3 height=63 class=xl70 width=82 style='border-bottom:.5pt solid black;
  height:47.25pt;border-top:none;width:62pt'>Ngày tháng ghi s&#7893;</td>
  <td colspan=2 rowspan=2 class=xl72 width=171 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:129pt'>Ch&#7913;ng t&#7915;</td>
  <td rowspan=3 class=xl70 width=264 style='border-bottom:.5pt solid black;
  border-top:none;width:198pt'>Di&#7877;n gi&#7843;i</td>
  <td rowspan=3 class=xl70 width=264 style='border-bottom:.5pt solid black;
  border-top:none;width:198pt'>Description</td>
  <td rowspan=3 class=xl70 width=61 style='border-bottom:.5pt solid black;
  border-top:none;width:46pt'>TK &#273;&#7889;i &#7913;ng</td>
  <td rowspan=3 class=xl70 width=62 style='border-bottom:.5pt solid black;
  border-top:none;width:47pt'>T&#7927; giá</td>
  <td colspan=4 class=xl76 style='border-right:.5pt solid black;border-left:
  none'>S&#7889; ti&#7873;n</td>
  <td rowspan=2 class=xl78>Ghi Chú</td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl80 width=214 style='border-right:.5pt solid black;
  height:15.75pt;border-left:none;width:160pt'>N&#7907;</td>
  <td colspan=2 class=xl82 width=212 style='border-right:.5pt solid black;
  border-left:none;width:159pt'>Có</td>
 </tr>
 <tr class=xl27 height=21 style='height:15.75pt'>
  <td height=21 class=xl32 width=82 style='height:15.75pt;width:62pt'>S&#7889;
  hi&#7879;u</td>
  <td class=xl32 width=89 style='width:67pt'>Ngày, tháng</td>
  <td class=xl32 width=107 style='width:80pt'>Ngo&#7841;i t&#7879;</td>
  <td class=xl32 width=107 style='width:80pt'>Ghi s&#7893;</td>
  <td class=xl32 width=105 style='width:79pt'>Ngo&#7841;i t&#7879;</td>
  <td class=xl33 width=107 style='width:80pt'>Ghi s&#7893;</td>
  <td class=xl34>SEQ</td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl34 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$12:$K$12" style='height:20.1pt'>A</td>
  <td class=xl35 id="_x0000_s1026" x:autofilter="all">B</td>
  <td class=xl35 id="_x0000_s1027" x:autofilter="all">C</td>
  <td class=xl35 id="_x0000_s1028" x:autofilter="all">D</td>
  <td class=xl35 id="_x0000_s1029" x:autofilter="all">D</td>
  <td class=xl35 id="_x0000_s1030" x:autofilter="all">E</td>
  <td class=xl35 id="_x0000_s1035" x:autofilter="all">&nbsp;</td>
  <td class=xl35 id="_x0000_s1031" x:autofilter="all" x:num>1</td>
  <td class=xl35 id="_x0000_s1032" x:autofilter="all" x:num>2</td>
  <td class=xl35 id="_x0000_s1033" x:autofilter="all" x:num>3</td>
  <td class=xl35 id="_x0000_s1034" x:autofilter="all" x:num>4</td>
  <td class=xl35>G</td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl36 style='height:20.1pt'></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38 width=264 style='width:198pt'>S&#7888; D&#431; &#272;&#7846;U
  K&#7922;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40  x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_trans %>';"  ><%= dr_fopenning %></td>
  <td class=xl40 x:num  style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_book %>';"><%= dr_openning %></td>
  <td class=xl40 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_trans %>';"  ><%= cr_fopenning %></td>
  <td class=xl40  x:num  style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_book %>';"><%= cr_openning %></td>
  <td class=xl41>&nbsp;</td>
 </tr>
<%
string SQLD = "SELECT TO_CHAR(H.TR_DATE,'DD/MM/YYYY') TRANS_DATE, H.VOUCHERNO, " +
                "H.REMARK, H.REMARK2,SF_A_GET_ACCD1(DECODE(D.DRCR_TYPE,'D',DECODE(R.DRCR_TYPE,'C',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR), " +
                "DECODE(R.DRCR_TYPE,'D',R.TAC_ABACCTCODE_PK_DR,R.TAC_ABACCTCODE_PK_CR)),'" + com_pk +"') ACCT_CODE, D.TR_RATE, " +
                "DECODE(D.DRCR_TYPE,'D',R.TR_AMT,0) PS_FDEBIT,DECODE(D.DRCR_TYPE,'D',R.TR_BOOKAMT,0) PS_DEBIT, DECODE(D.DRCR_TYPE,'C',R.TR_AMT,0) PS_FCREDIT, DECODE(D.DRCR_TYPE,'C',R.TR_BOOKAMT,0) PS_CREDIT," +
                "H.PK " +
                "FROM TAC_HGTRH H, TAC_HGTRD D, TAC_HGTRD_REF R " +
                "WHERE H.DEL_IF =0 AND D.DEL_IF =0 AND R.DEL_IF = 0 " +
                "AND H.PK = D.TAC_HGTRH_PK " +
                "AND H.PK = R.TAC_HGTRH_PK " +
                "AND D.PK = R.TAC_HGTRD_PK " +
                "AND D.TAC_ABACCTCODE_PK IN (SELECT pk FROM tac_localcode  WHERE del_if = 0 AND leaf_yn = 'Y'  CONNECT BY pac_pk = PRIOR pk START WITH pk = " + ac_pk + ")  " +
                "AND H.TCO_COMPANY_PK = " + com_pk + 
                "AND H.TR_DATE BETWEEN TO_DATE('" + d_from + "','YYYYMMDD') AND TO_DATE('" + d_to + "','YYYYMMDD')  " +
                "AND H.TR_STATUS IN ('" + status + "',DECODE('" + status + "',2,0,'" + status + "'),DECODE('" + status + "',2,4,'" + status + "')) " +
                "ORDER BY H.TR_DATE,H.VOUCHERNO,H.PK,D.PK,R.PK ";
 
            DataTable dt = ESysLib.TableReadOpen(SQLD);

     string strdate0 = "";
     string strdate1 = "";
     if (dt.Rows.Count > 0)
     {
         dr_end = dr_openning;
         cr_end = cr_openning;
         dr_sum = 0;
         cr_sum = 0;
         dr_closing = 0;
         cr_closing = 0;
         dr_fend = dr_fopenning;
         cr_fend = cr_fopenning;
         dr_fsum = 0;
         cr_fsum = 0;
         dr_fclosing = 0;
         cr_fclosing = 0;
         
         for (int i = 0; i < dt.Rows.Count; i++)
         {
                tr_date = dt.Rows[i][0].ToString(); 
                voucher = dt.Rows[i][1].ToString();
                remark = dt.Rows[i][2].ToString();
                remark2 = dt.Rows[i][3].ToString();
                acc_cor = dt.Rows[i][4].ToString();
             seq = dt.Rows[i][10].ToString();
             dr_amt = double.Parse(dt.Rows[i][7].ToString());
             cr_amt = double.Parse(dt.Rows[i][9].ToString());
            dr_famt = double.Parse(dt.Rows[i][6].ToString());
             cr_famt = double.Parse(dt.Rows[i][8].ToString()); 
            
             dr_sum += dr_amt;
             cr_sum += cr_amt;
             dr_end += dr_amt;
             cr_end += cr_amt;
             
            dr_fsum += dr_famt;
             cr_fsum += cr_famt;
             dr_fend += dr_famt;
             cr_fend += cr_famt; 
             if (strdate0 != tr_date)
             {
                 strdate0 = tr_date;
                 strdate1 = tr_date;
             }
             else
             {
                 strdate1 = ""; 
             }     
 %> 
 <tr class=xl27 height=42 style='height:31.5pt'>
  <td height=42 class=xl42 style='height:31.5pt'><%=strdate1%></td>
  <td class=xl43><%=voucher%></td>
  <td class=xl44><%=tr_date%></td>
  <td class=xl45 width=264 style='width:198pt'><%=remark2%></td>
  <td class=xl46 width=264 style='width:198pt'><%=remark%></td>
  <td class=xl44 x:num><%=acc_cor%></td>
  <td class=xl47 x:num ><%= dt.Rows[i][5].ToString()%></td>
  <td class=xl48 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_trans %>';" ><%= dt.Rows[i][6].ToString()%></td>
  <td class=xl48 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_book %>';" ><%= dt.Rows[i][7].ToString()%></td>
  <td class=xl48 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_trans %>';" ><%= dt.Rows[i][8].ToString()%></td>
  <td class=xl48 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_book %>';" ><%= dt.Rows[i][9].ToString()%></td>
  <td class=xl49 x:num ><%=seq %></td>
 </tr>
<%
         }
         
     }
     if (drcr_type == "D")
     {
         dr_closing = dr_openning + dr_sum - cr_sum;
         cr_closing = 0;
         dr_fclosing = dr_fopenning + dr_fsum - cr_fsum;
         cr_fclosing = 0;
     }
     else
     {
         dr_closing = 0;
         cr_closing = cr_openning - dr_sum + cr_sum;
         dr_fclosing = 0;
         cr_fclosing = cr_fopenning - dr_fsum + cr_fsum;
     }
 %> 

 <tr class=xl27 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl88 style='height:20.1pt;border-top:none'>&nbsp;</td>
  <td class=xl88 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl89 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 width=264 style='width:198pt'>T&#7893;ng c&#7897;ng s&#7889;
  phát sinh</td>
  <td class=xl51 width=264 style='width:198pt'>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl52 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_trans %>';" ><%=dr_fsum %></td>
  <td class=xl52 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_book %>';" ><%=dr_sum %></td>
  <td class=xl52 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_trans %>';" ><%=cr_fsum %></td>
  <td class=xl52 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_book %>';" ><%=cr_sum %></td>
  <td class=xl53>&nbsp;</td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl90 style='height:20.1pt;border-top:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl90 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl32 width=264 style='width:198pt'>S&#7888; D&#431; CU&#7888;I
  K&#7922;</td>
  <td class=xl54>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl56 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_trans %>';" ><%=dr_fclosing %></td>
  <td class=xl56 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_book %>';" ><%=dr_closing %></td>
  <td class=xl56 x:num  style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_trans %>';" ><%=cr_fclosing %></td>
  <td class=xl56 x:num style="white-space:nowrap;mso-text-control:shrinktofit;mso-number-format:'<%= p_xls_ccy_format_book %>';" ><%=cr_closing %></td>
  <td class=xl57>&nbsp;</td>
 </tr>
 <tr class=xl27 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=11 class=xl27 style='height:20.1pt;mso-ignore:colspan'></td>
  <td class=xl58></td>
 </tr>
 <tr class=xl59 height=21 style='height:15.75pt'>
  <td colspan=9 height=21 class=xl84 style='height:15.75pt'>S&#7893; có…. Trang
  , &#273;ánh s&#7889; t&#7915;<span style='mso-spacerun:yes'>  </span>trang 01
  &#273;&#7871;n<span style='mso-spacerun:yes'>  </span>trang……</td>
  <td class=xl58></td>
  <td class=xl59></td>
  <td class=xl58></td>
 </tr>
 <tr class=xl59 height=21 style='height:15.75pt'>
  <td height=21 colspan=7 class=xl60 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl85>Ngày <%= d_to.Substring(6, 2)%> tháng <%= d_to.Substring(4, 2)%> năm <%= d_to.Substring(0, 4)%></td>
  <td class=xl61></td>
  <td class=xl58></td>
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
    DataTable dt1 = ESysLib.TableReadOpen(SQL);
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
 <tr class=xl59 height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl62 style='height:15.75pt'><%= v1 %></td>
  <td colspan=1 height=21 class=xl62 style='height:15.75pt'><%= v2 %></td>
  <td class=xl62><%= v3 %></td>
  <td colspan=2 class=xl62 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl86><%= v4 %></td>
  <td class=xl63></td>
  <td class=xl58></td>
 </tr>
 <tr class=xl59 height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl64 style='height:15.75pt'><%=g1 %></td>
  <td colspan=1 height=21 class=xl64 style='height:15.75pt'><%=g2 %></td>
  <td class=xl64><%=g3 %></td>
  <td colspan=2 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl87><%=g4 %></td>
  <td class=xl61></td>
  <td class=xl58></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=11 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=11 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=11 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
<tr height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=11 class=xl24 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 
  <tr class=xl59 height=21 style='height:15.75pt'>
  <td colspan=3 height=21 class=xl64 style='height:15.75pt'><%= n1 %></td>
  <td colspan=1 height=21 class=xl64 style='height:15.75pt'><%= n2 %></td>
  <td class=xl64><%= n3 %></td>
  <td colspan=2 class=xl64 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl87><%= n4 %></td>
  <td class=xl61></td>
  <td class=xl58></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=11 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 colspan=11 class=xl24 style='height:20.1pt;mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=82 style='width:62pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=264 style='width:198pt'></td>
  <td width=264 style='width:198pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=62 style='width:47pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=63 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
