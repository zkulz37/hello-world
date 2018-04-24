<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
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
    string p_Project_Pk = Request.QueryString["project_pk"];
    string p_Req_Dt = Request.QueryString["Req_dt"];
    string SQL = "SELECT a.VOUCHER_NO,   " +
        "       TO_CHAR (TO_DATE (a.REQ_DT, 'YYYYMMDD'), 'DD-MONTH-YYYY') req_dt,   " +
        "       a.DESCRIPTION,   " +
        "       B.PROJECTNAME,   " +
        "       a.TOTAL_FAMT, B.PROJECTCODE , c.ACCOUNT_NO, D.ORDERINGCONTTYPECODE||' - '||D.ORDERINGCONTTYPENAME  " +
        "  FROM tecps_expense_req a, TECPS_PROJECTSUMM b, TAC_BFBENEFICIARY c, TECPS_ORDERINGCONTTYPE d   " +
        " WHERE     a.del_if = 0   " +
        "       AND b.del_if = 0   " +
        "       and c.del_if(+) = 0  " +
        "       and d.del_if = 0 " +
        "       AND A.TECPS_PROJECTSUMM_PK = b.pk   " +
        "       and A.TAC_BFBENEFICIARY_PK = c.pk(+) " +
        "       and A.TECPS_ORDERINGCONTTYPE_PK = d.pk  " +
        "       AND a.pk = '" + p_Pk + "' ";


    DataTable dt = ESysLib.TableReadOpen(SQL);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    
        string p_Doc_No = "";
        string p_Date = "";
        string p_Subject = "";
        string p_Project_Nm = "";
        string p_Total_Amt = "";
        string p_Project_Cd = "";
        string p_Receiver = "";
        string p_Budget_Variety = "";
        p_Doc_No = dt.Rows[0][0].ToString();
        p_Date = dt.Rows[0][1].ToString();
        p_Subject = dt.Rows[0][2].ToString();
        p_Project_Nm = dt.Rows[0][3].ToString();
        p_Total_Amt = dt.Rows[0][4].ToString();
        p_Project_Cd = dt.Rows[0][5].ToString();
        p_Receiver = dt.Rows[0][6].ToString();
        p_Budget_Variety = dt.Rows[0][7].ToString();
		string l_parameter = "";
       l_parameter = "'" + p_Project_Pk + "','" + p_Req_Dt  + "'";
    //============================================================================================
    DataTable dt_Sign = ESysLib.TableReadOpenCursor("pm_rpt_61060050_PSforPL", l_parameter);
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
    
    //Response.Write(dt_Sign.Rows.Count);
    //Response.End();
%>
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book1_files/filelist.xml">
<link rel=Edit-Time-Data href="Book1_files/editdata.mso">
<link rel=OLE-Object-Data href="Book1_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>KENZIE</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:Created>2011-07-20T02:35:54Z</o:Created>
  <o:LastSaved>2011-07-20T02:54:49Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .4in .48in .38in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
.font5
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
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
.style16
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
.style17
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"Comma \[0\]";
	mso-style-id:6;}
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
	font-family:굴림체, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style20
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:굴림체, monospace;
	mso-font-charset:129;
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
	background:white;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:white;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl34
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl36
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:right;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl45
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl46
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl47
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl49
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl50
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl51
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:right;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style17;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:0%;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl61
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl62
	{mso-style-parent:style17;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;}
.xl63
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl65
	{mso-style-parent:style16;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl68
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid windowtext;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl69
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.0_\)\;_\(* \\\(\#\,\#\#0\.0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	background:white;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0";
	background:white;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl85
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl86
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl87
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl88
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl89
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl90
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl93
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl94
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
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl95
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
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl96
	{mso-style-parent:style16;
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
.xl97
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl98
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl99
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl103
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl104
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl105
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl106
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	mso-diagonal-up:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl107
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	mso-diagonal-up:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-diagonal-up:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-diagonal-up:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl111
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl112
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl113
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl114
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl115
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl116
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl117
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl118
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl119
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl120
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl121
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl122
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-\0022₩\0022* \#\,\#\#0_-\;\\-\0022₩\0022* \#\,\#\#0_-\;_-\0022₩\0022* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl123
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-\0022₩\0022* \#\,\#\#0_-\;\\-\0022₩\0022* \#\,\#\#0_-\;_-\0022₩\0022* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl124
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-\0022₩\0022* \#\,\#\#0_-\;\\-\0022₩\0022* \#\,\#\#0_-\;_-\0022₩\0022* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl125
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-\0022₩\0022* \#\,\#\#0_-\;\\-\0022₩\0022* \#\,\#\#0_-\;_-\0022₩\0022* \0022-\0022_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl126
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl127
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl128
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl129
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:1.0pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl130
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl131
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl132
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl133
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:1.0pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl134
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:1.0pt solid black;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl135
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl136
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl137
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl138
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl139
	{mso-style-parent:style16;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl140
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl141
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;}
.xl142
	{mso-style-parent:style16;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl143
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl144
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl145
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl146
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl147
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	background:white;
	mso-pattern:auto none;}
.xl148
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl149
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl150
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl151
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl152
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl153
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl154
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl155
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl156
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl157
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl158
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl159
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl160
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl161
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl162
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0_\)\;\\\(\[$VND\]\\ \#\,\#\#0\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl163
	{mso-style-parent:style20;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl164
	{mso-style-parent:style20;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Percent;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl165
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022US$\0022\#\,\#\#0\.00";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl166
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\0022US$\0022\#\,\#\#0\.00";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl167
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl168
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:1.0pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Proposal</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>360</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:StandardWidth>2413</x:StandardWidth>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>96</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:TopRowVisible>9</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>6</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:ColBreaks>
      <x:ColBreak>
       <x:Column>11</x:Column>
      </x:ColBreak>
     </x:ColBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9780</x:WindowHeight>
  <x:WindowWidth>18195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path>A:\C-Trinh\ONTENDER\AkzoNobel\Boq-AkzoNobel.XLS</x:Path>
  <x:SheetName>Final-Sum</x:SheetName>
  <x:SheetName>AkzoNobel</x:SheetName>
  <x:SheetName>MATERIAL</x:SheetName>
  <x:SheetName>Specification</x:SheetName>
  <x:SheetName>SA-HQ07-04</x:SheetName>
  <x:SheetName>SUM</x:SheetName>
  <x:SheetName>DEPT.</x:SheetName>
  <x:SheetName>DSalary </x:SheetName>
  <x:SheetName>Vacine _ Jul 04</x:SheetName>
  <x:SheetName>Vacine Mar 04</x:SheetName>
  <x:SheetName>Thoui viec BV</x:SheetName>
  <x:SheetName>Thoiu viec - Thai</x:SheetName>
  <x:SheetName>Thoi Viec - Dien</x:SheetName>
  <x:SheetName>THOIVIEC 6-04</x:SheetName>
  <x:SheetName>BHXH 7 04</x:SheetName>
  <x:SheetName>Nop - No dong 03</x:SheetName>
  <x:SheetName>Nop Thue 7-04</x:SheetName>
  <x:SheetName>Sheet1</x:SheetName>
  <x:SheetName>THUE-IN</x:SheetName>
  <x:SheetName>XL4Poppy</x:SheetName>
  <x:SheetName>CNV - Theo DS</x:SheetName>
  <x:SheetName>Over Additional 8-3 difference</x:SheetName>
  <x:SheetName>Over - Additional 8-2</x:SheetName>
  <x:SheetName>Over - Additional 8-1</x:SheetName>
  <x:SheetName>Over 8-04</x:SheetName>
  <x:SheetName>Over 7-04</x:SheetName>
  <x:SheetName>Over 6-04</x:SheetName>
  <x:SheetName>Poisionus 6-04</x:SheetName>
  <x:SheetName>Posionous 8-04</x:SheetName>
  <x:SheetName>Bao Ve Nghi</x:SheetName>
  <x:SheetName>Daily 8-04</x:SheetName>
  <x:SheetName>Daily 7-04</x:SheetName>
  <x:SheetName>Daily 6-04</x:SheetName>
  <x:SheetName>Phicongtrinh7-04</x:SheetName>
  <x:SheetName>Tienna 8-04</x:SheetName>
  <x:SheetName>Phuncat 8-04</x:SheetName>
  <x:SheetName>phuncat Time sheet 8</x:SheetName>
  <x:SheetName>C leaner 8_04</x:SheetName>
  <x:SheetName>00000000</x:SheetName>
  <x:SheetName>10000000</x:SheetName>
  <x:SheetName>20000000</x:SheetName>
  <x:SheetName>30000000</x:SheetName>
  <x:SheetName>40000000</x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>1</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>2</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>6</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>7</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>8</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>9</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>10</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>11</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>12</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>13</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>14</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>15</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>16</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>17</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>18</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>19</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>20</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>21</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>22</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>23</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>24</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>25</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>26</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>27</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>28</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>29</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>30</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>31</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>32</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>33</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>34</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>35</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>36</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>37</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>38</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>39</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>40</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>41</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>42</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
 <x:SupBook>
  <x:Path>A:\C_TRINH\ONTENDER\OPV\OPV-P2\Quotation-OPVPack2.xls</x:Path>
  <x:SheetName>FINAL-2</x:SheetName>
  <x:SheetName>Pack-2</x:SheetName>
  <x:SheetName>QUOTATION</x:SheetName>
  <x:SheetName>MATERIAL</x:SheetName>
  <x:SheetName>Pack-3</x:SheetName>
  <x:SheetName>FINAL-3</x:SheetName>
  <x:SheetName>QUOTATION (2)</x:SheetName>
  <x:SheetName>MATERIAL (2)</x:SheetName>
  <x:SheetName>Dondep</x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>0</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>1</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>49</x:Count>
   <x:SheetIndex>2</x:SheetIndex>
   <x:Crn>
    <x:Row>20</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>5280</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>22</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>17050</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>24</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>2035</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>25</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>123200.00000000001</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>28</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>336253.99999999994</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>32</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>458701.9</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>35</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>571592.5</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>37</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>577400</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>38</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>577400</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>40</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>603400</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>41</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>614400</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>42</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>614400.00000000012</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>43</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>603400</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>44</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>627875</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>45</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>614400</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>46</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>614400.00000000012</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>47</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>619900</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>48</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>619900</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>52</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>69800</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>53</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>24300</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>55</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>27589.999999999996</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>56</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>46790</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>58</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>4684930.0000000009</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>59</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>4845000</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>60</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>4739930</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>61</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>4899999.9999999991</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>64</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>27945.5</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>66</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>64454.399999999994</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>74</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>906500</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>81</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>33700</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>82</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>34140</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>88</x:Row>
    <x:ColFirst>11</x:ColFirst>
    <x:ColLast>11</x:ColLast>
    <x:Number>17600</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>90</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>163160</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>93</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>22000</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>96</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>396923.07692307699</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>100</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>55000.000000000007</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>107</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>11430.920000000002</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>109</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>17436.37</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>110</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>15627.880000000001</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>116</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>398711.5</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>117</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>101087.29999999997</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>120</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>118176.36</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>123</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>405533.386</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>125</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>110312.5</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>128</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>37540.909090909088</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>129</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>27222.727272727272</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>130</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>97840</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>136</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>88640</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>137</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>355000</x:Number>
   </x:Crn>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>3</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>6</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
   <x:Crn>
    <x:Row>669</x:Row>
    <x:ColFirst>4</x:ColFirst>
    <x:ColLast>4</x:ColLast>
    <x:Number>22040.35</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>673</x:Row>
    <x:ColFirst>4</x:ColFirst>
    <x:ColLast>4</x:ColLast>
    <x:Number>45599.7</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>684</x:Row>
    <x:ColFirst>4</x:ColFirst>
    <x:ColLast>4</x:ColLast>
    <x:Number>104347.28999999998</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>686</x:Row>
    <x:ColFirst>4</x:ColFirst>
    <x:ColLast>4</x:ColLast>
    <x:Number>39119.375</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>707</x:Row>
    <x:ColFirst>4</x:ColFirst>
    <x:ColLast>4</x:ColLast>
    <x:Number>18800.187499999996</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>773</x:Row>
    <x:ColFirst>4</x:ColFirst>
    <x:ColLast>4</x:ColLast>
    <x:Number>15393.424999999999</x:Number>
   </x:Crn>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>2</x:Count>
   <x:SheetIndex>6</x:SheetIndex>
   <x:Crn>
    <x:Row>600</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>11000</x:Number>
   </x:Crn>
   <x:Crn>
    <x:Row>626</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>65300</x:Number>
   </x:Crn>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>7</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>8</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
 <x:SupBook>
  <x:Path>A:\Quo-OPV2Rev3.xls</x:Path>
  <x:SheetName>FINAL-2</x:SheetName>
  <x:SheetName>Pack-2</x:SheetName>
  <x:SheetName>QUOTATION</x:SheetName>
  <x:SheetName>MATERIAL</x:SheetName>
  <x:SheetName>Pack-3</x:SheetName>
  <x:SheetName>FINAL-3</x:SheetName>
  <x:SheetName>Dondep</x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>0</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>1</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>1</x:Count>
   <x:SheetIndex>2</x:SheetIndex>
   <x:Crn>
    <x:Row>46</x:Row>
    <x:ColFirst>7</x:ColFirst>
    <x:ColLast>7</x:ColLast>
    <x:Number>65000.200100000002</x:Number>
   </x:Crn>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>3</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>6</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
 <x:ExcelName>
  <x:Name>_Fill</x:Name>
  <x:Hidden/>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>addi_wrk</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>ALU</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CA</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Car</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Caùp_ñoàng_traàn_75mm2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>CONC2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Dondep</x:Name>
  <x:Macro>Command</x:Macro>
  <x:FunctionGroup>12</x:FunctionGroup>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>DOOR</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Dor</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>EARTH</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>EXCA</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Fen</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Fil</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>FLOOR</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>FRAME</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Gen</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Item</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LT1010</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]Pack-3'!$E$774</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LT1015</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]Pack-3'!$E$708</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LT1020</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]Pack-3'!$E$670</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LT1520</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]Pack-3'!$E$687</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LT1536</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LT2020</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]Pack-3'!$E$674</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LT2030</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LT3036</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]Pack-3'!$E$685</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Mai</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>MASON</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>METAL</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Mol</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Ncceil</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$L$89</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Ncdoor</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$101</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Ncwind</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$94</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Nur</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Pac</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PAVE</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PLAST</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Pon</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Precast</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Area</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Proposal!$A$1:$K$38</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PROOF</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>q10f2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>q10fl2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>q10fr2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>q10rs2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>q12f2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>q12fl2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>q12fr2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>q12rs2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qbeam21</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qbeam22</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qbemass2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qfnm21</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qfnm22</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qfnm23</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qfnm24</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qfwt21</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qfwt22</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qfwt23</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qgbmass2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qhandrail2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qinsu1</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qinsu2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qinsu3</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qinsu4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qlt10102</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qlt10152</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qlt10202</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qlt15202</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qlt15362</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qlt20202</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qlt20302</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Qlt30362</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qplastceil2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qshutter2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qslab21</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qslab22</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qwall21</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>qwall22</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sea</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqbar102</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqbar10gs2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqbar122</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqbar12gs2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqbeam2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqcef2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqcesk2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqcew2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqcew5202</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqdoor2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqemul2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqepox2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqexca2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqfnm2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqfoot2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqfwt2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqgranfl2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqgransk2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqgsl2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqinsu2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqiso2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqlean2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqltbar2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqltconc2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqluxa2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqmastic2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqplast202</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqplastbeam2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqradcon2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqsilicon2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqslab2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqstair2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqterfl2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqterst2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqwall102</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqwall2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqwall202</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqwearther2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqweather2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sqwind2</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STALU</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stcar</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STCEIL</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STCONC</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stcoo</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stdor</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STEXCA</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stfen</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stfla</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stgen</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STHARD</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stlpg</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STMASON</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STMETAL</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stmol</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STPAINT</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STPAVE</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stpile</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STPLAST</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STPR</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>STPROOF</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sttoi</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sttow</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sttre</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Sttru</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stwas</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Stwor</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tcar</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tdor</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tfen</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tfil</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tgen</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tmai</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tmol</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tnur</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Toi</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tow</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tpac</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tpon</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tru</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Tsea</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Ttoi</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Ttow</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Ttru</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Twas</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Twor</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URbar10</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$61</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URbar10gf</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$59</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URbar12</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$62</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URbar12gf</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$60</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URbeamconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$46</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urbemass</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$38</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urbitum</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urbrass</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION (2)'!$H$601</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URCeW520</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$121</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URcolconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$45</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URconc150</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URdispo</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$21</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urdownspout</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$137</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URemul</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$130</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urepoxy</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$131</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URexca</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$23</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URFlgran</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$117</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URFlinsu</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$82</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URflterazo</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$118</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URfootconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$41</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URform</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$56</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urformst</x:Name>
  <x:Formula>='A:\[Quo-OPV2Rev3.xls]QUOTATION'!$H$47</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urformwt</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$57</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URGbconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$43</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urgbmass</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$33</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URgraskirt</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$124</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URgrfconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$44</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URGypsum</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urhandrail</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$75</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URlean</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$29</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URlevel</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URlintconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$36</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URluxalon</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$91</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URmastic</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$53</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>UrMBT</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION (2)'!$H$627</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URpedesconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$42</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URplast15</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URplast20</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$108</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URplastbeam</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$110</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URplastcei</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$111</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URplastdoor</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URproof</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$25</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URradcon</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$26</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URshutter</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$97</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URsilicon</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$54</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urskeleton</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URslabconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$47</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URstairconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$49</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urstrainer</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$138</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URStterazo</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$126</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Urtopflconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$39</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URwall10</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$65</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URwall20</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$67</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URWallconc</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$48</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URweather</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$129</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>URWinsu</x:Name>
  <x:Formula>='A:\C_TRINH\ONTENDER\OPV\OPV-P2\[Quotation-OPVPack2.xls]QUOTATION'!$H$83</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>usd</x:Name>
  <x:Formula>=15000</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Was</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Wor</x:Name>
  <x:Formula>='A:\C-Trinh\ONTENDER\AkzoNobel\[Boq-AkzoNobel.XLS]AkzoNobel'!#REF!</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1028"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1441 style='border-collapse:
 collapse;table-layout:fixed;width:1087pt'>
 <col class=xl24 width=22 style='mso-width-source:userset;mso-width-alt:804;
 width:17pt'>
 <col class=xl24 width=54 style='mso-width-source:userset;mso-width-alt:1974;
 width:41pt'>
 <col class=xl24 width=138 style='mso-width-source:userset;mso-width-alt:5046;
 width:104pt'>
 <col class=xl24 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl24 width=88 style='mso-width-source:userset;mso-width-alt:3218;
 width:66pt'>
 <col class=xl24 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <col class=xl24 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl24 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <col class=xl25 width=26 style='mso-width-source:userset;mso-width-alt:950;
 width:20pt'>
 <col class=xl24 width=66 style='width:50pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=66 style='width:50pt'>
 <col class=xl24 width=67 style='mso-width-source:userset;mso-width-alt:2450;
 width:50pt'>
 <col class=xl24 width=66 span=6 style='width:50pt'>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=5 rowspan=3 height=80 class=xl71 width=355 style='border-right:
  .5pt solid black;height:60.0pt;width:268pt'><a name="Print_Area">PROPOSAL
  SHEET<br>
    (<%=p_Project_Cd%>)</a></td>
  <td colspan=2 rowspan=3 class=xl77 width=140 style='border-right:.5pt solid black;border-bottom:.5pt solid black;width:105pt'>Doc.No.<br><%=p_Doc_No%></td>
  <td colspan=2 rowspan=3 class=xl77 width=140 style='border-right:.5pt solid black;border-bottom:.5pt solid black;width:105pt'>Date:<font class="font5"><br><br><%=p_Date%></font></td>
  <td colspan=2 height=24 width=140 style='border-right:1.0pt solid black;
  height:18.0pt;width:106pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_1" o:spid="_x0000_s1025" style='position:absolute;
   margin-left:7.5pt;margin-top:5.25pt;width:7.5pt;height:6pt;z-index:1;
   visibility:visible'>
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:1;margin-left:9px;margin-top:6px;width:12px;height:10px'><img
  width=12 height=10 src="Book1_files/image001.gif" v:shapes="Rectangle_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=24 class=xl85 width=140 style='border-right:1.0pt solid black;
    height:18.0pt;border-left:none;width:106pt' x:str="     Routine"><span
    style='mso-spacerun:yes'>      </span>Routine<span
    style='mso-spacerun:yes'> </span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=66 style='width:50pt'>&nbsp;</td>
  <td class=xl24 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl24 width=66 style='width:50pt'>&nbsp;</td>
  <td class=xl24 width=67 style='width:50pt'>&nbsp;</td>
  <td class=xl24 width=66 style='width:50pt'>&nbsp;</td>
  <td class=xl24 width=66 style='width:50pt'>&nbsp;</td>
  <td class=xl24 width=66 style='width:50pt'>&nbsp;</td>
  <td class=xl24 width=66 style='width:50pt'>&nbsp;</td>
  <td class=xl24 width=66 style='width:50pt'>&nbsp;</td>
  <td class=xl24 width=66 style='width:50pt'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 width=140 style='border-right:1.0pt solid black;
  height:18.0pt;width:106pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_2" o:spid="_x0000_s1026" style='position:absolute;
   margin-left:7.5pt;margin-top:3.75pt;width:7.5pt;height:6.75pt;z-index:2;
   visibility:visible' fillcolor="black">
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:2;margin-left:9px;margin-top:4px;width:12px;height:11px'><img
  width=12 height=11 src="Book1_files/image002.gif" v:shapes="Rectangle_x0020_2"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=24 class=xl87 width=140 style='border-right:1.0pt solid black;
    height:18.0pt;border-left:none;width:106pt' x:str="     Urgent"><span
    style='mso-spacerun:yes'>      </span>Urgent<span
    style='mso-spacerun:yes'> </span></td>
   </tr>
  </table>
  </span></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=2 height=32 width=140 style='border-right:1.0pt solid black;
  height:24.0pt;width:106pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="Rectangle_x0020_3" o:spid="_x0000_s1027" style='position:absolute;
   margin-left:7.5pt;margin-top:4.5pt;width:7.5pt;height:7.5pt;z-index:3;
   visibility:visible'>
   <v:textbox style='mso-direction-alt:auto;mso-rotate-with-shape:t'>
    <div style='text-align:left'></div>
   </v:textbox>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:3;margin-left:9px;margin-top:5px;width:12px;height:12px'><img
  width=12 height=12 src="Book1_files/image003.gif" v:shapes="Rectangle_x0020_3"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=2 height=32 class=xl89 width=140 style='border-right:1.0pt solid black;
    height:24.0pt;border-left:none;width:106pt' x:str="     Confidential"><span
    style='mso-spacerun:yes'>      </span>Confidential<span
    style='mso-spacerun:yes'> </span></td>
   </tr>
  </table>
  </span></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 height=24 class=xl91 width=76 style='border-right:.5pt solid black;
  height:18.0pt;width:58pt'>&nbsp;</td>
  <td class=xl28 width=138 style='width:104pt'>Prepared</td>
  <td colspan=2 class=xl93 width=141 style='border-right:.5pt solid black;
  border-left:none;width:106pt'>Checked</td>
  <td colspan=2 class=xl95 width=140 style='border-right:.5pt solid black;
  border-left:none;width:105pt'>Reviewed</td>
  <td colspan=2 class=xl95 width=140 style='border-right:.5pt solid black;
  border-left:none;width:105pt'>Reviewed</td>
  <td colspan=2 class=xl96 width=140 style='border-right:1.0pt solid black;
  border-left:none;width:106pt' x:str="Approved"><span
  style='mso-spacerun:yes'> </span>Approved<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=65 style='mso-height-source:userset;height:48.75pt'>
  <td colspan=2 height=65 class=xl98 width=76 style='border-right:.5pt solid black;
  height:48.75pt;width:58pt'>Office</td>
  <td class=xl29 width=138 style='border-left:none;width:104pt'>&nbsp;</td>
  <td colspan=2 class=xl100 width=141 style='border-right:.5pt solid black;
  border-left:none;width:106pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl102 width=140 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:105pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl106 width=140 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:105pt'>&nbsp;</td>
  <td colspan=2 class=xl110 width=140 style='border-right:1.0pt solid black;
  border-left:none;width:106pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td colspan=2 class=xl26 width=137 style='width:103pt'>&nbsp;</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=65 style='mso-height-source:userset;height:48.75pt'>
  <td colspan=2 height=65 class=xl112 width=76 style='border-right:.5pt solid black;
  height:48.75pt;width:58pt'>Signature</td>
  <td class=xl29 width=138 style='border-left:none;width:104pt'>&nbsp;</td>
  <td colspan=2 class=xl113 width=141 style='border-right:.5pt solid black;
  border-left:none;width:106pt'>&nbsp;</td>
  <td colspan=2 class=xl115 width=140 style='border-right:1.0pt solid black;
  border-left:none;width:106pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:auto;height:20.0pt'>
  <td colspan=2 height=24 class=xl117 width=76 style='border-right:.5pt solid black;
  height:18.0pt;width:58pt'>Name</td>
  <td class=xl32 width=138 style='border-left:none;width:104pt'><%=p_Prepared%></td>
  <td colspan=2 class=xl120 width=141 style='border-right:.5pt solid black;
  border-left:none;width:106pt'><%=p_Checked%></td>
  <td colspan=2 class=xl120 width=140 style='border-right:.5pt solid black;
  border-left:none;width:105pt'><%=p_Reviewed_1%></td>
  <td colspan=2 class=xl120 width=140 style='border-right:.5pt solid black;
  border-left:none;width:105pt'><%=p_Reviewed_2%></td>
  <td colspan=2 class=xl120 width=140 style='border-right:.5pt solid black;
  border-left:none;width:106pt'><%=p_Approved%></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=2 rowspan=2 height=48 class=xl122 width=76 style='border-bottom:
  1.0pt solid black;height:36.0pt;width:58pt' x:str="Subject:"><span
  style='mso-spacerun:yes'> </span>Subject:<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=9 rowspan=2 class=xl126 width=699 style='border-right:1.0pt solid black;border-bottom:1.0pt solid black;width:526pt'><%=p_Subject%></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=11 height=24 class=xl130 width=775 style='border-right:1.0pt solid black;
  height:18.0pt;width:584pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=46 style='mso-height-source:userset;height:34.5pt'>
  <td colspan=11 height=46 class=xl133 width=775 style='border-right:1.0pt solid black;
  height:34.5pt;width:584pt'
 >We
  would like the leader to consider <%=p_Subject%><br>
    <span style='mso-spacerun:yes'> </span></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl30 width=22 style='height:21.95pt;width:17pt'>&nbsp;</td>
  <td colspan=9 class=xl26 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl34 width=26 style='width:20pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl35 style='height:21.95pt'>&nbsp;</td>
  <td class=xl36>1.</td>
  <td class=xl37>Project Name:</td>
  <td class=xl38 colspan=3 style='mso-ignore:colspan' ><%=p_Project_Nm%></td>
  <td class=xl37>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl35 style='height:21.95pt'>&nbsp;</td>
  <td class=xl36>2.</td>
  <td class=xl37>Budget Variety :</td>
  <td class=xl38><%=p_Budget_Variety%></td>
  <td class=xl38>&nbsp;</td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl35 style='height:21.95pt'>&nbsp;</td>
  <td class=xl36>3.</td>
  <td class=xl37>Content :</td>
  <td class=xl37 colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl37 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl35 style='height:21.95pt'>&nbsp;</td>
  <td class=xl36>4.</td>
  <td class=xl40 x:str="Receiver : ">Receiver :</td>
  <td class=xl37><%=p_Receiver%></td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl35 style='height:21.95pt'>&nbsp;</td>
  <td class=xl36 x:str="'5.">5.</td>
  <td class=xl37>This Month :</td>
  <td class=xl41 x:num><%=p_Total_Amt%></td>
  <td class=xl37 colspan=2 style='mso-ignore:colspan'>(VND)</td>
  <td class=xl37>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl35 style='height:21.95pt'>&nbsp;</td>
  <td class=xl36>6.</td>
  <td class=xl40>Detail:</td>
  <td class=xl38>As Below (VND)</td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl35 style='height:21.95pt'>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td class=xl43>No.</td>
  <td colspan=4 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>Description</td>
  <td class=xl45>TOTAL(1)</td>
  <td class=xl45>PIT/VAT(2)</td>
  <td colspan=2 class=xl136 style='border-right:.5pt solid black;border-left:
  none'>NET=(1)-(2)</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td colspan=7 class=xl46 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <%
    
	 
     DataTable dt1 = new DataTable();
     dt1 = ESysLib.TableReadOpenCursor("pm_rpt_61060050_detail", p_Pk);
     int i = 0;
     decimal _Total = 0;
     
     for (i = 0; i < dt1.Rows.Count; i++)
     {
         if (dt1.Rows[i][2].ToString().Trim() != "")
         {
             _Total += decimal.Parse(dt1.Rows[i][2].ToString());
         }
         else
         {
             _Total += 0;
         }
      %>
 <tr height=29 style='mso-height-source:userset;height:30pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td class=xl48 x:num><%=dt1.Rows[i][0]%></td>
  <td colspan=4 class=xl120 width=331 style='border-right:.5pt solid black;border-left:none;width:249pt'><%=dt1.Rows[i][1]%></td>
  <td class=xl49 x:num><%=dt1.Rows[i][2]%></td>
  <td class=xl49 x:num><%=dt1.Rows[i][3]%></td>
  <td colspan=2 class=xl138 style='border-right:.5pt solid black;border-left:none' x:num><%=dt1.Rows[i][4]%></td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td colspan=4 class=xl46 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl50>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <%} %>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td colspan=5 class=xl136 style='border-right:.5pt solid black'>Total Amount</td>
  <td  class=xl141 style='border-right:.5pt solid black;border-left:.5pt solid black;text-align:right' x:num><%=_Total%></td>
  <td colspan=3 class=xl39 width=26 style='width:20pt;border-bottom:.5pt solid black;border-right:.5pt solid black'>&nbsp;</td>
  <td class=xl24 style="border-right:1.0pt solid windowtext">&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=3 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td class=xl36>7.</td>
  <td class=xl37>Working Budget</td>
  <td colspan=7 class=xl38 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td colspan=8 class=xl38 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl56>(Currency: VND)</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td colspan=2 rowspan=2 class=xl143 style='border-right:.5pt solid black;  border-bottom:.5pt solid black'>Budget</td>
  <td colspan=2 class=xl147 style='border-right:.5pt solid black;border-left:  none'>Acc.Previous</td>
  <td colspan=2 class=xl147 style='border-right:.5pt solid black;border-left:  none'>This time</td>
  <td colspan=2 class=xl147 style='border-right:.5pt solid black;border-left:  none'>Accum</td>
  <td rowspan=2 class=xl101 width=114 style='border-bottom:.5pt solid black;  width:86pt'>Remarks (Accum./Budget)</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td colspan=2 class=xl147 style='border-right:.5pt solid black;border-left:  none'>Amount</td>
  <td colspan=2 class=xl147 style='border-right:.5pt solid black;border-left:  none'>Amount</td>
  <td colspan=2 class=xl147 style='border-right:.5pt solid black;border-left:  none'>Amount</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <%
     DataTable dt2 = new DataTable();
     dt2 = ESysLib.TableReadOpenCursor("pm_rpt_61060050_2", p_Pk);	
     string p_Budget_VND = "";
     string p_Budget_USD = "";
     string p_Pre = "";
     string p_This = "";
     string p_Accum = "";
     string p_Desc = "";
     string p_Ccy = "";
     
     string ccy1 = "";
     string ccy2 = "";
     string ccy3 = "";
     string ccy4 = "";
     if (dt2.Rows.Count > 0)
     {
         p_Budget_VND = dt2.Rows[0][0].ToString();
         p_Budget_USD = dt2.Rows[0][1].ToString();
         p_Pre = dt2.Rows[0][2].ToString();
         p_This = dt2.Rows[0][3].ToString();
         p_Accum = dt2.Rows[0][4].ToString();
         p_Desc = dt2.Rows[0][5].ToString();
         p_Ccy = dt2.Rows[0][6].ToString();
     }
     if (p_Budget_VND == "" || p_Budget_VND == "0")
     {
         ccy1 = "";
     }
     else
     {
         ccy1 = "VND";
     }
     if (p_Pre == "" || p_Budget_VND == "0")
     {
         ccy2 = "";
     }
     else
     {
         ccy2 = "VND";
     }
     if (p_This == "" || p_Budget_VND == "0")
     {
         ccy3 = "";
     }
     else
     {
         ccy3 = "VND";
     }
     if (p_Accum == "" || p_Budget_VND == "0")
     {
         ccy4 = "";
     }
     else
     {
         ccy4 = "VND";
     }
     %>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td colspan=2 class=xl150 style='border-right:.5pt solid black'><%=p_Ccy%> <%=p_Budget_VND%></td>
  <td colspan=2 rowspan=2 class=xl152 style='border-right:.5pt solid black; border-bottom:.5pt solid black'> <%=p_Pre%></td>
  <td colspan=2 rowspan=2 class=xl156 style='border-right:.5pt solid black; border-bottom:.5pt solid black'> <%=p_This%></td>
  <td colspan=2 rowspan=2 class=xl149 style='border-right:.5pt solid black; border-bottom:.5pt solid black'> <%=p_Accum%></td>
  <td rowspan=2 class=xl163 style='border-bottom:.5pt solid black;border-top: none' x:num><%=p_Desc%>%</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td colspan=2 class=xl165 style='border-right:.5pt solid black'>USD <%=p_Budget_USD%></td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td colspan=9 class=xl38 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl55 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td class=xl37 colspan=3 style='mso-ignore:colspan'>We would like to get your
  approval.</td>
  <td class=xl57>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td colspan=3 class=xl57 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl59>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl55>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=6 class=xl57 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl58>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl60>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>

 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl44 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl62 x:str="'-The End-"><span style='mso-spacerun:yes'> </span>-The
  End-<span style='mso-spacerun:yes'> </span></td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.95pt'>
  <td height=29 class=xl42 style='height:21.95pt'>&nbsp;</td>
  <td colspan=2 class=xl40 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=3 class=xl44 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl62>&nbsp;</td>
  <td class=xl39 width=26 style='width:20pt'>&nbsp;</td>
  <td class=xl24>&nbsp;</td>
  <td class=xl44>&nbsp;</td>
  <td class=xl51>&nbsp;</td>
  <td colspan=2 class=xl31 style='mso-ignore:colspan'>&nbsp;</td>
  <td colspan=2 class=xl52 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl53>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl54>&nbsp;</td>
 </tr>
 <tr height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl63 width=22 style='height:10.5pt;width:17pt'>&nbsp;</td>
  <td colspan=9 class=xl64 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl65 width=26 style='width:20pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl66 width=22 style='height:18.0pt;width:17pt'>&nbsp;</td>
  <td class=xl67 width=54 style='width:41pt'>&nbsp;</td>
  <td class=xl67 width=138 style='width:104pt'>&nbsp;</td>
  <td class=xl67 width=103 style='width:77pt'>&nbsp;</td>
  <td class=xl67 width=38 style='width:29pt'>&nbsp;</td>
  <td class=xl67 width=52 style='width:39pt'>&nbsp;</td>
  <td class=xl67 width=88 style='width:66pt'>&nbsp;</td>
  <td class=xl67 width=89 style='width:67pt'>&nbsp;</td>
  <td class=xl67 width=51 style='width:38pt'>&nbsp;</td>
  <td class=xl67 width=114 style='width:86pt'>&nbsp;</td>
  <td class=xl68 width=26 style='width:20pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td colspan=6 height=24 class=xl167 width=407 style='height:18.0pt;
  width:307pt' x:str="Posco engineering &amp; construction-Vietnam ">Posco
  engineering &amp; construction-Vietnam<span style='mso-spacerun:yes'> </span></td>
  <td class=xl33>&nbsp;</td>
  <td colspan=4 class=xl168 width=280 style='width:211pt'>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=10 class=xl27 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 colspan=10 class=xl24 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl24 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl24 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl24 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl24 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl24 style='height:18.0pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=22 style='width:17pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=138 style='width:104pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=89 style='width:67pt'></td>
  <td width=51 style='width:38pt'></td>
  <td width=114 style='width:86pt'></td>
  <td width=26 style='width:20pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=66 style='width:50pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
