<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser("ec111");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
            string p_Pk = Request.QueryString["pk"];
            string p_TECPS_EXPENSE_REQ_PK = Request.QueryString["TECPS_EXPENSE_REQ_PK"];
            string p_Req_Dt = "";
            string p_Req_No = "";
            string p_Subject = "";
            string p_Project_Cd = "";
            string p_Project_Nm = "";
            string p_Bene_Nm = "";
            string p_Acc_No = "";
            string p_Bene_Bank = "";
            string p_Project_Pk = "";
            string p_Ccy = "";
           string SQL = "select to_char(to_date(a.REQ_DT,'YYYYMMDD'),'DD/MONTH/YYYY') REQ_DT, " + 
        "a.VOUCHER_NO, " +
        "a.DESCRIPTION , " +
        "b.projectcode                     , " +
        "b.projectname       , " +
        "I.BEDEFI_NM   , " +
        "I.ACCOUNT_NO, I.BEDEFI_BANK_NM, a.TECPS_PROJECTSUMM_PK, A.CCY  " +
        "from tecps_expense_pay a, " +
        "TECPS_PROJECTSUMM b, " +
        "acnt.TAC_BFBENEFICIARY i  " +
        "where a.del_if = 0 " +
        "and b.del_if(+) = 0 " +
        "and i.del_if(+) = 0 " +
        "and A.TECPS_PROJECTSUMM_PK = b.pk(+) " +
        "and A.TAC_BFBENEFICIARY_PK = i.pk(+) " +
        "and a.pk = '" + p_Pk + "' ";

            DataTable dt = ESysLib.TableReadOpen(SQL);
            if (dt.Rows.Count == 0)
            {
                Response.Write("There is no data to show");
                Response.End();
            }
            p_Req_Dt = dt.Rows[0][0].ToString();
            p_Req_No = dt.Rows[0][1].ToString();
            p_Subject = dt.Rows[0][2].ToString();
            p_Project_Cd = dt.Rows[0][3].ToString();
            p_Project_Nm = dt.Rows[0][4].ToString();
            p_Bene_Nm = dt.Rows[0][5].ToString();
            p_Acc_No = dt.Rows[0][6].ToString();
            p_Bene_Bank = dt.Rows[0][7].ToString();
            p_Project_Pk = dt.Rows[0][8].ToString();
            p_Ccy = dt.Rows[0][9].ToString();
            DataTable dt_Sign = ESysLib.TableReadOpenCursor("EC111.sp_sel_kpac1014", p_Project_Pk);
            string p_Prepared = "";
            string p_Checked = "";
            string p_Reviewed_1 = "";
            string p_Reviewed_2 = "";
            string p_Approved = "";
            if (dt_Sign.Rows.Count > 0)
            {
                p_Prepared = dt_Sign.Rows[0][2].ToString();
                p_Checked = dt_Sign.Rows[0][3].ToString();
                p_Reviewed_1 = dt_Sign.Rows[0][4].ToString();
                p_Reviewed_2 = dt_Sign.Rows[0][5].ToString();
                p_Approved = dt_Sign.Rows[0][6].ToString();
            }
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="print_415_files/filelist.xml">
<link rel=Edit-Time-Data href="print_415_files/editdata.mso">
<link rel=OLE-Object-Data href="print_415_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>linhtta</o:Author>
  <o:LastAuthor>kenzie</o:LastAuthor>
  <o:Created>2011-06-11T07:27:11Z</o:Created>
  <o:LastSaved>2011-06-14T03:43:48Z</o:LastSaved>
  <o:Company>VNG</o:Company>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .5in .5in .5in;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl47
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
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl49
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl50
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
.xl51
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl52
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
.xl53
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl54
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
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
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl58
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
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl60
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;}
.xl62
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:18.0pt;
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
.xl70
	{mso-style-parent:style0;
	font-size:18.0pt;
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
.xl71
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:18.0pt;
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
.xl74
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:18.0pt;
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
.xl76
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
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
.xl78
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
	border-left:.5pt solid black;}
.xl79
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
.xl80
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;}
.xl81
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl82
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
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
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl84
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
.xl85
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
.xl86
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
.xl87
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
	border-left:none;
	white-space:normal;}
.xl88
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
.xl89
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
.xl90
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
.xl91
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
	border-left:.5pt solid windowtext;}
.xl92
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
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl94
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl95
	{mso-style-parent:style16;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl96
	{mso-style-parent:style16;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl97
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl98
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl99
	{mso-style-parent:style16;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl100
	{mso-style-parent:style16;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl101
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;}
.xl102
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;}
.xl104
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:163;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:163;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid black;}
.xl106
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:163;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style16;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl110
	{mso-style-parent:style16;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl111
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl112
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl113
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl114
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl115
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl116
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl117
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl118
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl119
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl120
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl121
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl122
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl123
	{mso-style-parent:style16;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl124
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl125
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl126
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl127
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
	border-left:none;}
.xl128
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl129
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
	border-left:none;}
.xl130
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl131
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl132
	{mso-style-parent:style16;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl133
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl134
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>REQUEST adv. FORM</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:StandardWidth>2304</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>67</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>33</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7620</x:WindowHeight>
  <x:WindowWidth>18495</x:WindowWidth>
  <x:WindowTopX>600</x:WindowTopX>
  <x:WindowTopY>555</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1034"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=963 style='border-collapse:
 collapse;table-layout:fixed;width:725pt'>
 <col class=xl24 width=11 style='mso-width-source:userset;mso-width-alt:402;
 width:8pt'>
 <col class=xl24 width=33 style='mso-width-source:userset;mso-width-alt:1206;
 width:25pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=129 style='mso-width-source:userset;mso-width-alt:4717;
 width:97pt'>
 <col class=xl24 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl24 width=61 span=8 style='mso-width-source:userset;mso-width-alt:
 2230;width:46pt'>
 <col class=xl24 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl24 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl24 width=10 style='mso-width-source:userset;mso-width-alt:365;
 width:8pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 width=11 style='height:15.0pt;width:8pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1027" type="#_x0000_t75"
   alt="newlogo.JPG" style='position:absolute;margin-left:6.75pt;margin-top:6pt;
   width:146.25pt;height:36pt;z-index:1;visibility:visible'>
   <v:imagedata src="print_415_files/image001.jpg" o:title="newlogo"/>
   <v:path arrowok="t"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:9px;margin-top:8px;width:195px;
  height:48px'><img width=195 height=48 src="print_415_files/image004.jpg"
  alt=newlogo.JPG v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl25 width=11 style='height:15.0pt;width:8pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl26 width=33 style='width:25pt'>&nbsp;</td>
  <td class=xl26 width=103 style='width:77pt'>&nbsp;</td>
  <td class=xl26 width=129 style='width:97pt'>&nbsp;</td>
  <td class=xl26 width=97 style='width:73pt'>&nbsp;</td>
  <td class=xl26 width=61 style='width:46pt'>&nbsp;</td>
  <td class=xl27 width=61 style='width:46pt'>&nbsp;</td>
  <td class=xl26 width=61 style='width:46pt'>&nbsp;</td>
  <td class=xl26 width=61 style='width:46pt'>&nbsp;</td>
  <td class=xl26 width=61 style='width:46pt'>&nbsp;</td>
  <td class=xl26 width=61 style='width:46pt'>&nbsp;</td>
  <td class=xl27 width=61 style='width:46pt'>&nbsp;</td>
  <td class=xl26 width=61 style='width:46pt'>&nbsp;</td>
  <td class=xl26 width=53 style='width:40pt'>&nbsp;</td>
  <td class=xl26 width=39 style='width:29pt'>&nbsp;</td>
  <td class=xl28 width=10 style='width:8pt'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'>&nbsp;</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td height=21 class=xl30 width=61 style='height:15.75pt;width:46pt'><!--[if gte vml 1]><v:shapetype
   id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="TextBox_x0020_2" o:spid="_x0000_s1028" type="#_x0000_t202"
   style='position:absolute;margin-left:14.25pt;margin-top:3.75pt;width:14.25pt;
   height:7.5pt;z-index:2;visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt" o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=17 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=23 height=14 src="print_415_files/image003.gif" v:shapes="TextBox_x0020_2"></td>
    <td width=21></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:15.75pt'></span><![endif]--></td>
  <td class=xl31>Date:</td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>: <%=p_Req_Dt %></td>
  <td class=xl24></td>
  <td height=21 class=xl30 width=61 style='height:15.75pt;width:46pt'><!--[if gte vml 1]><v:shape
   id="TextBox_x0020_5" o:spid="_x0000_s1031" type="#_x0000_t202" style='position:absolute;
   margin-left:11.25pt;margin-top:5.25pt;width:14.25pt;height:7.5pt;z-index:5;
   visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt" o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=13 height=5></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=23 height=14 src="print_415_files/image003.gif" v:shapes="TextBox_x0020_5"></td>
    <td width=25></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:15.75pt'></span><![endif]--></td>
  <td class=xl31>Routine</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'>&nbsp;</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td height=21 class=xl30 width=61 style='height:15.75pt;width:46pt'><!--[if gte vml 1]><v:shape
   id="TextBox_x0020_3" o:spid="_x0000_s1029" type="#_x0000_t202" style='position:absolute;
   margin-left:14.25pt;margin-top:3pt;width:14.25pt;height:7.5pt;z-index:3;
   visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt" o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=17 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=23 height=14 src="print_415_files/image003.gif" v:shapes="TextBox_x0020_3"></td>
    <td width=21></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:15.75pt'></span><![endif]--></td>
  <td class=xl31>Doc.No.</td>
  <td class=xl31>: <%=p_Req_No %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td height=21 class=xl30 width=61 style='height:15.75pt;width:46pt'><!--[if gte vml 1]><v:shape
   id="TextBox_x0020_6" o:spid="_x0000_s1032" type="#_x0000_t202" style='position:absolute;
   margin-left:12pt;margin-top:6.75pt;width:14.25pt;height:7.5pt;z-index:6;
   visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt" o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=14 height=7></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=23 height=14 src="print_415_files/image003.gif" v:shapes="TextBox_x0020_6"></td>
    <td width=24></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:15.75pt'></span><![endif]--></td>
  <td class=xl31>Urgent</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl29 style='height:15.75pt'>&nbsp;</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td height=21 class=xl30 width=61 style='height:15.75pt;width:46pt'><!--[if gte vml 1]><v:shape
   id="TextBox_x0020_4" o:spid="_x0000_s1030" type="#_x0000_t202" style='position:absolute;
   margin-left:14.25pt;margin-top:3.75pt;width:14.25pt;height:7.5pt;z-index:4;
   visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt" o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=17 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=23 height=14 src="print_415_files/image003.gif" v:shapes="TextBox_x0020_4"></td>
    <td width=21></td>
   </tr>
   <tr>
    <td height=4></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:15.75pt'></span><![endif]--></td>
  <td class=xl31>Ref.</td>
  <td class=xl31>:</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td height=21 class=xl30 width=61 style='height:15.75pt;width:46pt'><!--[if gte vml 1]><v:shape
   id="TextBox_x0020_7" o:spid="_x0000_s1033" type="#_x0000_t202" style='position:absolute;
   margin-left:12pt;margin-top:6.75pt;width:14.25pt;height:7.5pt;z-index:7;
   visibility:visible' fillcolor="window" strokecolor="windowText"
   strokeweight="2pt" o:insetmode="auto">
   <v:textbox style='mso-rotate-with-shape:t'/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=14 height=7></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=23 height=14 src="print_415_files/image003.gif" v:shapes="TextBox_x0020_7"></td>
    <td width=24></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:45.75pt;height:15.75pt'></span><![endif]--></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>Confidential</td>
  <td class=xl24></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl33 style='height:15.0pt'>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=3 rowspan=7 height=169 class=xl68 width=147 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:128.55pt;width:110pt'>PROPOSAL
  SHEET</td>
  <td colspan=2 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>Prepared by</td>
  <td colspan=3 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>Checked by</td>
  <td colspan=3 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>Review by</td>
  <td colspan=4 class=xl78 style='border-left:none'>Approved by</td>
  <td class=xl38>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'></td>
  <td class=xl40 width=97 style='width:73pt'>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl39 style='height:23.25pt'></td>
  <td class=xl40 width=97 style='width:73pt'>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl39 style='height:20.1pt'></td>
  <td class=xl40 width=97 style='width:73pt'>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl39 style='height:20.1pt'></td>
  <td class=xl40 width=97 style='width:73pt'>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl41 width=129 style='height:10.5pt;width:97pt'>&nbsp;</td>
  <td class=xl42 width=97 style='width:73pt'>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl35>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl43 style='height:20.1pt' colspan="2">Name: <%=p_Prepared%></td>
  <td class=xl43 colspan="3">Name: <%=p_Checked%></td>
  <td class=xl45 colspan="3">Name: <%=p_Reviewed_1 %></td>
  <td class=xl45 colspan="4">Name: <%=p_Approved %></td>
  <td class=xl36>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td colspan=16 height=26 class=xl80 style='border-right:1.0pt solid black;
  height:20.1pt'>Subject: <%=p_Subject%></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td class=xl31 colspan=6 style='mso-ignore:colspan'>I would like the BOD to
  consider and approve Site expense as follows:</td>
  <td colspan=8 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl46 style='height:11.25pt'>&nbsp;</td>
  <td colspan=14 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl31>1. Project code</td>
  <td class=xl31></td>
  <td class=xl31>: <%=p_Project_Cd %></td>
  <td colspan=10 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl31>2. Project name</td>
  <td class=xl31></td>
  <td class=xl31 colspan=4 style='mso-ignore:colspan'>: <%=p_Project_Nm %></td>
  <td colspan=7 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>3. Beneficiary name</td>
  <td class=xl31 colspan=3 style='mso-ignore:colspan'>:
  <%=p_Bene_Nm %></td>
  <td colspan=8 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl31>4. Account No.</td>
  <td class=xl31></td>
  <td class=xl31 colspan=3 style='mso-ignore:colspan'>:
  <%=p_Acc_No %></td>
  <td colspan=8 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>5. Beneficiary bank</td>
  <td class=xl31 colspan=2 style='mso-ignore:colspan'>: <%=p_Bene_Bank %></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
  <td  class=xl31 style='mso-ignore:colspan;font-style:italic'>(Currency: <%= p_Ccy%>)</td>
  <td  class=xl31 style='mso-ignore:colspan'></td>
  <td  class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl46 style='height:10.5pt'>&nbsp;</td>
  <td colspan=14 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td rowspan=2 class=xl83 style='border-bottom:.5pt solid black'>No.</td>
  <td colspan=3 class=xl85 style='border-right:.5pt solid black;border-left:
  none'>Account</td>
  <td colspan=6 class=xl78 style='border-right:.5pt solid black;border-left:
  none'>This month</td>
  <td colspan=2 rowspan=2 class=xl87 width=122 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:92pt'>Plan Next Month</td>
  <td colspan=2 rowspan=2 class=xl91 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Remark</td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td class=xl47 x:str="Code ">Code<span style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl85 style='border-right:.5pt solid black'>Name</td>
  <td colspan=2 class=xl78 style='border-right:.5pt solid black;border-left:  none'>Plan</td>
  <td colspan=2 class=xl78 style='border-right:.5pt solid black;border-left:  none'>Declare</td>
  <td colspan=2 class=xl78 style='border-right:.5pt solid black;border-left:  none'>Difference</td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <%
     decimal p_Plan = 0;
     decimal p_Declare = 0;
     decimal p_Difference = 0;
     decimal p_PlanNextMonth = 0;
     DataTable dt_SumDt = ESysLib.TableReadOpenCursor("EC111.sp_rpt_kpde416_amt_sum", p_Pk);
     if(dt_SumDt.Rows.Count>0)
     {
         p_Plan = decimal.Parse(dt_SumDt.Rows[0][0].ToString());
         p_Declare = decimal.Parse(dt_SumDt.Rows[0][1].ToString());
         p_Difference = decimal.Parse(dt_SumDt.Rows[0][2].ToString());
         p_PlanNextMonth = decimal.Parse(dt_SumDt.Rows[0][3].ToString());
     }
      %>
 <tr class=xl48 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl49 style='height:20.1pt'>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td class=xl50>I.</td>
  <td colspan=2 class=xl93 width=226 style='border-right:.5pt solid black;  border-left:none;width:170pt'>NET</td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_Plan%></td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_Declare%></td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_Difference %></td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_PlanNextMonth%></td>
  <td colspan=2 class=xl95 width=92 style='border-right:.5pt solid black;
  border-left:none;width:69pt'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
 </tr>
 <%
        int i =0;
        int k = 0;
        DataTable dt_detail = ESysLib.TableReadOpenCursor("EC111.sp_rpt_kpde416_amt", p_Pk);
        for(i=0;i<dt_detail.Rows.Count;i++)
        {
 %>
 <tr class=xl48 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl49 style='height:24.95pt'>&nbsp;</td>
  <td class=xl52 x:num><%=k+1%></td>
  <td class=xl52 ><%=dt_detail.Rows[i][0] %></td>
  <td colspan=2 class=xl97 style='border-right:.5pt solid black;border-left:  none;border-top:.5pt hairline windowtext'><%=dt_detail.Rows[i][1] %></td>
  <td colspan=2 class=xl99 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt;border-top:.5pt hairline windowtext' x:num><%=dt_detail.Rows[i][2] %></td>
  <td colspan=2 class=xl101 style='border-right:.5pt solid black;border-left:  none;border-top:.5pt hairline windowtext' x:num><%=dt_detail.Rows[i][3] %></td>
  <td colspan=2 class=xl101 style='border-right:.5pt solid black;border-left:  none;border-top:.5pt hairline windowtext' x:num><%=dt_detail.Rows[i][4] %></td>
  <td colspan=2 class=xl103 style='border-right:.5pt solid black;border-left:  none;border-top:.5pt hairline windowtext' x:num><%=dt_detail.Rows[i][5] %></td>
  <td colspan=2 class=xl105 style='border-right:.5pt solid black;border-left:  none;border-top:.5pt hairline windowtext'><%=dt_detail.Rows[i][6] %></td>
  <td class=xl51>&nbsp;</td>
 </tr>
 <%k += 1;
        } %>
 <%
     decimal p_Plan_VAT = 0;
     decimal p_Declare_VAT = 0;
     decimal p_Difference_VAT = 0;
     decimal p_PlanNextMonth_VAT = 0;
     DataTable dt_SumVAT = ESysLib.TableReadOpenCursor("EC111.sp_rpt_kpde416_vat_sum", p_Pk);
     if (dt_SumVAT.Rows.Count > 0)
     {
         p_Plan_VAT = decimal.Parse(dt_SumVAT.Rows[0][0].ToString());
         p_Declare_VAT = decimal.Parse(dt_SumVAT.Rows[0][1].ToString());
         p_Difference_VAT = decimal.Parse(dt_SumVAT.Rows[0][2].ToString());
         p_PlanNextMonth_VAT = decimal.Parse(dt_SumVAT.Rows[0][3].ToString());
     }
      %>
 <tr class=xl48 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl49 style='height:20.1pt'>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl58 style='border-top:.5pt solid black;border-bottom:.5pt solid black'>II.</td>
  <td colspan=2 class=xl93 width=226 style='border-right:.5pt solid black; border-left:none;width:170pt'>VAT</td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_Plan_VAT %></td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_Declare_VAT%></td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_Difference_VAT %></td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_PlanNextMonth_VAT%></td>
  <td colspan=2 class=xl95 width=92 style='border-right:.5pt solid black;  border-left:none;width:69pt'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
 </tr>
 <%
        int j = 0;
     int f=0;
        DataTable dt_VAT = ESysLib.TableReadOpenCursor("EC111.sp_rpt_kpde416_vat", p_Pk);
        for(j=0;j<dt_VAT.Rows.Count;j++)
        {
  %>
 <tr class=xl53 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl54 style='height:20.1pt'>&nbsp;</td>
  <td class=xl121 style='border-left:none;border-top:.5pt hairline windowtext;' x:num><%=f+1%></td>
  <td class=xl122 style='border-top:.5pt hairline windowtext;'><%=dt_VAT.Rows[j][0]%></td>
  <td colspan=2 class=xl97 style='border-right:.5pt solid black;border-left: none;border-top:.5pt hairline windowtext;'><%=dt_VAT.Rows[j][1]%></td>
  <td colspan=2 class=xl99 width=122 style='border-right:.5pt solid black; border-left:none;width:92pt;border-top:.5pt hairline windowtext;' x:num><%=dt_VAT.Rows[j][2]%></td>
  <td colspan=2 class=xl124 style='border-right:.5pt solid black;border-left: none;border-top:.5pt hairline windowtext;' x:num><%=dt_VAT.Rows[j][3]%></td>
  <td colspan=2 class=xl124 style='border-right:.5pt solid black;border-left: none;border-top:.5pt hairline windowtext;' x:num><%=dt_VAT.Rows[j][4]%></td>
  <td colspan=2 class=xl124 style='border-right:.5pt solid black;border-left: none;border-top:.5pt hairline windowtext;' x:num><%=dt_VAT.Rows[j][5]%></td>
  <td colspan=2 class=xl126 style='border-right:.5pt solid black;border-left: none;border-top:.5pt hairline windowtext;'><%=dt_VAT.Rows[j][6]%></td>
  <td class=xl56>&nbsp;</td>
 </tr>
  <%f += 1;
        } %>
 
 <tr class=xl48 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl49 style='height:20.1pt'>&nbsp;</td>
  <td class=xl50 style='border-top:.5pt solid black'>&nbsp;</td>
  <td colspan=3 class=xl85 style='border-right:.5pt solid black;border-left:none'>TOTAL</td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_Plan + p_Plan_VAT%></td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black; border-left:none;width:92pt' x:num><%=p_Declare + p_Declare_VAT %></td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_Difference + p_Difference_VAT %></td>
  <td colspan=2 class=xl95 width=122 style='border-right:.5pt solid black;  border-left:none;width:92pt' x:num><%=p_PlanNextMonth + p_PlanNextMonth_VAT%></td>
  <td colspan=2 class=xl95 width=92 style='border-right:.5pt solid black;  border-left:none;width:69pt'>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt'>&nbsp;</td>
  <td colspan=14 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt'>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl59>Advance status</td>
  <td colspan=11 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 class=xl46 style='height:6.0pt'>&nbsp;</td>
  <td colspan=14 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl85 style='border-right:.5pt solid black'>Description</td>
  <td colspan=3 class=xl85 style='border-right:.5pt solid black;border-left:  none'>Amount</td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl115 style='border-right:.5pt solid black'>Last time (A)</td>
  <td colspan=3 class=xl119 style='border-right:.5pt solid black;border-left:  none' x:num><%=p_Plan + p_Plan_VAT%></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl115 style='border-right:.5pt solid black'>Declare (B)</td>
  <td colspan=3 class=xl119 style='border-right:.5pt solid black;border-left:  none' x:num><%=p_Declare + p_Declare_VAT %></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl115 style='border-right:.5pt solid black'>Remain (C) = (A) - (B)</td>
  <td colspan=3 class=xl119 style='border-right:.5pt solid black;border-left: none' x:num><%=(p_Plan + p_Plan_VAT) - (p_Declare + p_Declare_VAT)%></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl115 style='border-right:.5pt solid black'>Plan next month (D)</td>
  <td colspan=3 class=xl119 style='border-right:.5pt solid black;border-left:  none' x:num><%=p_PlanNextMonth + p_PlanNextMonth_VAT %></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl46 style='height:20.1pt'>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl115 style='border-right:.5pt solid black'>Actual payment this time (E) = (D) - (C)</td>
  <td colspan=3 class=xl119 style='border-right:.5pt solid black;border-left:  none' x:num><%=(p_PlanNextMonth + p_PlanNextMonth_VAT) - ((p_Plan + p_Plan_VAT) - (p_Declare + p_Declare_VAT))%></td>
  <td colspan=6 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt'>&nbsp;</td>
  <td colspan=14 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl46 style='height:15.75pt'>&nbsp;</td>
  <td colspan=8 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl60>&nbsp;</td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl61 style='height:15.0pt'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl24></td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl63>POSCO ENGINEERING &amp; CONSTRUCTION VIETNAM CO.,LTD</td>
  <td class=xl64>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 style='height:15.75pt'>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=11 style='width:8pt'></td>
  <td width=33 style='width:25pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=129 style='width:97pt'></td>
  <td width=97 style='width:73pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=53 style='width:40pt'></td>
  <td width=39 style='width:29pt'></td>
  <td width=10 style='width:8pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
