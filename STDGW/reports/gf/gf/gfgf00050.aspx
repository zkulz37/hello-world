<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_Master_pk = Request["Master_pk"];
	
	string p_Code = "";
	string p_Name = "";
	string p_LName = "";
	string p_Manufacturer = "";
	string p_Origin = "";
	string p_Specification = "";
	string p_Model = "";
	string p_EngineNo = "";
	string p_SerialNo = "";
	string p_ProductionYear = "";
	string p_Supplier = "";
	string p_Acc_cd = "";
	string p_Quantity = "";
	string p_InvoiceNo = "";
	string p_InvoiceDate = "";
	string p_BookValue = "";
	string p_TransactionValue = "";
	string p_LongLife = "";
	string p_Depreciation = "";
	string p_DisposalDate = "";
	string p_Accumulated = "";
	string p_Department = "";
	string p_CostCenter = "";
	string p_Status = "";
	string p_User = "";
	string p_Asset = "";
	string p_Group = "";
	string p_Location = "";
	string p_Month = "";
	string p_Status1 = "";
    string p_Voucher_No = "";
    string p_Date = "";
    DataTable dt = ESysLib.TableReadOpenCursor("ac_sel_gfgf00050_rpt", p_Master_pk);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data!!");
        Response.End();
    }
	 p_Code = dt.Rows[0][66].ToString();
	 p_Name = dt.Rows[0][4].ToString();
     p_LName = dt.Rows[0][5].ToString();
     p_Manufacturer = dt.Rows[0][74].ToString();
     p_Origin = dt.Rows[0][46].ToString();
     p_Specification = dt.Rows[0][50].ToString();
     p_Model = dt.Rows[0][67].ToString();
     p_EngineNo = dt.Rows[0][51].ToString();
     p_SerialNo = dt.Rows[0][47].ToString();
     p_ProductionYear = dt.Rows[0][37].ToString();
     p_Supplier = dt.Rows[0][73].ToString();
     p_Quantity = dt.Rows[0][8].ToString();
	 p_Acc_cd = dt.Rows[0][21].ToString();
	 p_InvoiceNo = dt.Rows[0][49].ToString();
     p_InvoiceDate = dt.Rows[0][48].ToString();
     p_BookValue = dt.Rows[0][34].ToString();
     p_TransactionValue = dt.Rows[0][33].ToString();
     p_LongLife = dt.Rows[0][53].ToString();
     p_Depreciation = dt.Rows[0][39].ToString();
     p_DisposalDate = dt.Rows[0][63].ToString();
     p_Accumulated = dt.Rows[0][41].ToString();
	 p_Department = dt.Rows[0][68].ToString();
	 p_CostCenter = dt.Rows[0][15].ToString();
	 p_Status = dt.Rows[0][70].ToString();
	 p_User =  dt.Rows[0][13].ToString();
	 p_Asset = dt.Rows[0][71].ToString();
	 p_Group = dt.Rows[0][7].ToString();
 	 p_Location = dt.Rows[0][72].ToString();
	 p_Month = dt.Rows[0][38].ToString();
	 p_Status1 = dt.Rows[0][17].ToString();
     p_Voucher_No = dt.Rows[0][54].ToString();
     p_Date = dt.Rows[0][31].ToString();
	// Response.Write(p_Asset);
//	 Response.End();
	/*string l_book_ccy = "";
    String p_xls_ccy_format = "";
    String p_xls_ccy_format_usd = "";
    if (l_contract_ccy == "VND")
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
    else
    {
        p_xls_ccy_format = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
        p_xls_ccy_format_usd = "_\\(* \\#\\,\\#\\#0\\.00_\\)\\;\\[Red\\]_\\(\\\\ \\\\\\(\\#\\,\\#\\#0\\.00\\\\\\)\\;_\\(* \\0022-\\0022??_\\)\\;_\\(\\@_\\)";
    }
                */
                
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfgf00050_files/filelist.xml">
<link rel=Edit-Time-Data href="gfgf00050_files/editdata.mso">
<link rel=OLE-Object-Data href="gfgf00050_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>genuwin</o:Author>
  <o:LastAuthor>ISA_SERVER</o:LastAuthor>
  <o:LastPrinted>2011-01-24T02:17:29Z</o:LastPrinted>
  <o:Created>2009-03-10T08:42:16Z</o:Created>
  <o:LastSaved>2011-01-27T05:47:13Z</o:LastSaved>
  <o:Company>company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl29
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
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
	color:#3366FF;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl34
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl35
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:13.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:13.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:13.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl40
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:13.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl41
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl42
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	color:blue;
	font-size:13.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl44
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:13.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:13.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl46
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl47
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl48
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl49
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:12.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl51
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl52
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl53
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl54
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl55
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:13.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl60
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:13.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl63
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	color:#3366FF;
	font-style:italic;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl65
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl69
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl70
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl72
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl73
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	color:blue;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl75
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl76
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl79
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl80
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl81
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl82
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl85
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl87
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl92
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl95
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl97
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl98
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl100
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl101
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl102
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl104
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl107
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl108
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl109
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl110
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl111
	{mso-style-parent:style0;
	color:#3366FF;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl112
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl113
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl114
	{mso-style-parent:style16;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00_\)\;\[Red\]\\\(\#\,\#\#0\.00\\\)";
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl115
	{mso-style-parent:style16;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	//mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl116
	{mso-style-parent:style0;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl117
	{mso-style-parent:style16;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl118
	{mso-style-parent:style16;
	color:#3366FF;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
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
    <x:Name>ASSETCARD</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>77</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:TabColorIndex>33</x:TabColorIndex>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:TopRowVisible>6</x:TopRowVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>20</x:ActiveRow>
       <x:ActiveCol>9</x:ActiveCol>
       <x:RangeSelection>$J$21:$S$21</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>540</x:WindowTopY>
  <x:TabRatio>446</x:TabRatio>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="8241"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="8"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=878 style='border-collapse:
 collapse;table-layout:fixed;width:659pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl24 width=44 span=5 style='mso-width-source:userset;mso-width-alt:
 1609;width:33pt'>
 <col class=xl24 width=40 span=2 style='mso-width-source:userset;mso-width-alt:
 1462;width:30pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl24 width=47 style='mso-width-source:userset;mso-width-alt:1718;
 width:35pt'>
 <col class=xl24 width=46 style='mso-width-source:userset;mso-width-alt:1682;
 width:35pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=44 span=3 style='mso-width-source:userset;mso-width-alt:
 1609;width:33pt'>
 <col class=xl24 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl24 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <tr height=10 style='mso-height-source:userset;height:7.5pt'>
  <td height=10 class=xl25 width=12 style='height:7.5pt;width:9pt'>&nbsp;</td>
  <td class=xl26 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl26 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl26 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl26 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl26 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl26 width=40 style='width:30pt'>&nbsp;</td>
  <td class=xl26 width=40 style='width:30pt'>&nbsp;</td>
  <td class=xl26 width=45 style='width:34pt'>&nbsp;</td>
  <td class=xl26 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl26 width=60 style='width:45pt'>&nbsp;</td>
  <td class=xl26 width=52 style='width:39pt'>&nbsp;</td>
  <td class=xl26 width=47 style='width:35pt'>&nbsp;</td>
  <td class=xl26 width=46 style='width:35pt'>&nbsp;</td>
  <td class=xl26 width=71 style='width:53pt'>&nbsp;</td>
  <td class=xl26 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl26 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl26 width=44 style='width:33pt'>&nbsp;</td>
  <td class=xl26 width=30 style='width:23pt'>&nbsp;</td>
  <td class=xl27 width=12 style='width:9pt'>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_12" o:spid="_x0000_s8240" type="#_x0000_t75"
   alt="E&amp;C-VIETNAM" style='position:absolute;margin-left:0;margin-top:0;
   width:100.5pt;height:42pt;z-index:1;visibility:visible'>
   <v:imagedata src="gfgf00050_files/image001.jpg" o:title="E&amp;C-VIETNAM"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:0px;width:134px;
  height:56px'><img width=134 height=56 src="gfgf00050_files/image002.jpg"
  alt="E&amp;C-VIETNAM" v:shapes="Picture_x0020_12"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=21 class=xl24 width=44 style='height:15.75pt;width:33pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=15 class=xl74>Form ACC - 0001 - POS</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td class=xl24></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td colspan=15 class=xl74>FIXED ASSET CARD</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr class=xl32 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl33 style='height:20.1pt'>&nbsp;</td>
  <td colspan=2 class=xl75 style='border-right:.5pt solid black'>Type:</td>
  <td class=xl34 colspan=2 style='mso-ignore:colspan'>Fixed asset</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl37 colspan=2 style='mso-ignore:colspan;border-right:.5pt solid black'><%if(p_Asset != "A"){%>¨<%}else{%>þ<%}%></td>
  <td class=xl36>Tools</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39><%if(p_Asset != "T"){%>¨<%}else{%>þ<%}%></td>
  <td class=xl40>&nbsp;</td>
  <td class=xl36>Other</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl36>&nbsp;</td>
  <td class=xl39>¨</td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td colspan=18 class=xl77>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr class=xl32 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl33 style='height:20.1pt'>&nbsp;</td>
  <td colspan=2 class=xl75 style='border-right:.5pt solid black'>Group:</td>
  <td class=xl34 colspan=5 style='mso-ignore:colspan'>House, building,
  construction</td>
  <td class=xl43><%if(p_Group != "BD"){%>¨<%}else {%>þ<%}%></td>
  <td class=xl36>Machinery</td>
  <td class=xl44><%if(p_Group != "ME"){%>¨<%}else{%>þ<%}%></td>
  <td class=xl36>Vehicle</td>
  <td class=xl45><%if(p_Group != "TF"){%>¨<%}else{%>þ<%}%></td>
  <td class=xl34 colspan=2 style='mso-ignore:colspan'>Office equipment</td>
  <td class=xl45><%if(p_Group != "FO"){%>¨<%}else{%>þ<%}%></td>
  <td class=xl36>Other</td>
  <td class=xl39><%if(p_Group != "OT"){%>¨<%}else{%>þ<%}%></td>
  <td class=xl41>&nbsp;</td>
  <td class=xl42>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl78>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl79 style='border-right:.5pt solid black'>No:</td>
  <td colspan=7 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Code: <%=p_Code%></td>
  <td colspan=6 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Manufacturer: <%=p_Manufacturer%></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl79 style='border-right:.5pt solid black'>Date: <%=p_Date%></td>
  <td colspan=7 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Name: <%=p_Name%></td>
  <td colspan=6 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Origin: <%=p_Origin%></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl79 style='border-right:.5pt solid black'>Seq(voucher): <%=p_Voucher_No%></td>
  <td colspan=7 class=xl84 style='border-right:.5pt solid black;border-left:
  none'>Local name: <%=p_LName%></td>
  <td colspan=6 class=xl84 style='border-right:.5pt solid black;border-left:
  none'>Specification: <%=p_Specification%></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=20 style='height:15.0pt'>
  <td height=20 class=xl51 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl83>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl79 style='border-right:.5pt solid black'>Model: <%=p_Model%></td>
  <td colspan=7 class=xl84 style='border-right:.5pt solid black;border-left:
  none'>Production year: <%=p_ProductionYear%></td>
  <td colspan=6 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Account code: <%=p_Acc_cd%></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl79 style='border-right:.5pt solid black'>Engine No.: <%=p_EngineNo%></td>
  <td colspan=7 class=xl84 style='border-right:.5pt solid black;border-left:
  none'>Supplier: <%=p_Supplier%></td>
  <td colspan=6 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Invoice No.: <%=p_InvoiceNo%></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl79 style='border-right:.5pt solid black'>Serial No.: <%=p_SerialNo%></td>
  <td colspan=7 class=xl84 style='border-right:.5pt solid black;border-left:
  none'>Quantity: <%=p_Quantity%></td>
  <td colspan=6 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Invoice date.: <%=p_InvoiceDate%></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=20 style='height:15.0pt'>
  <td height=20 class=xl51 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl83>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=20 style='height:15.0pt'>
  <td height=20 class=xl51 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl85>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=3 class=xl79 >Book value:</td>
  <td colspan=4 class=xl114 style='border-right:none;text-align:right;border-bottom:.5pt solid black;vertical-align:middle' x:num><%=p_BookValue%> </td>
  <td  class=xl114 style='border-right:.5pt solid black;border-bottom:.5pt solid black;vertical-align:middle;text-align:left' > USD</td>
  <td colspan=10 class=xl82 style='border-right:.5pt solid black;border-left: none'>Long life : <%=p_Month%> month</td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=3 class=xl112 style="text-align:left">Transaction value:</td>
  <td colspan=4 class=xl115 style='border-right:none;vertical-align:middle;text-align:right;'  x:num><%=p_TransactionValue%></td>
  <td  class=xl114 style='border-right:.5pt solid black;border-bottom:.5pt solid black;vertical-align:middle;text-align:left' > VND</td>
  <td colspan=3 class=xl116 style='border-left:none;text-align:left'>Depreciation per month :</td>
  <td colspan=7 class=xl117 style='border-right:.5pt solid black;text-align:right' x:num><%=p_Depreciation%></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=20 style='height:15.0pt'>
  <td height=20 class=xl51 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl85>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=8 class=xl75 style='border-right:.5pt solid black'>Disposal date: <%=p_DisposalDate%></td>
  <td colspan=6 class=xl84 style='border-left:none'>Accumulated depreciation at disposal date: </td>
  <td colspan=4 class=xl114 style='border-right:.5pt solid black' x:num><%if(p_Status1 == "U" || p_Status1 == "D"){%><%=p_Accumulated%><%}else{%><%}%></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl86>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl87>Adjusting on upward - downward revaluation:</td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=50 style='mso-height-source:userset;height:37.5pt'>
  <td height=50 class=xl48 style='height:37.5pt'>&nbsp;</td>
  <td class=xl55 width=44 style='width:33pt'>No.</td>
  <td colspan=2 class=xl89 width=88 style='border-right:.5pt solid black;
  border-left:none;width:66pt'>Date</td>
  <td colspan=2 class=xl91 width=88 style='border-right:.5pt solid black;
  border-left:none;width:66pt'>Ref No.</td>
  <td colspan=5 class=xl91 width=256 style='border-right:.5pt solid black;
  border-left:none;width:192pt'>Descriptions</td>
  <td colspan=2 class=xl91 width=99 style='border-right:.5pt solid black;
  border-left:none;width:74pt'>Added value</td>
  <td colspan=2 class=xl91 width=117 style='border-right:.5pt solid black;
  border-left:none;width:88pt'>Depreciation date</td>
  <td class=xl56 width=44 style='width:33pt' x:str="Long life ">Long life<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=3 class=xl89 width=118 style='border-right:.5pt solid black;
  border-left:none;width:89pt'>Added depreciation permonth</td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <%
 			decimal Longlife  = 0;
			decimal AddedValue = 0;
			decimal depreciation = 0;
 			int j ;
			int k = 0;
 			DataTable dt_detail = ESysLib.TableReadOpenCursor("ac_sel_gfgf00050_5", p_Master_pk);
			
			for(j = 0 ; j < dt_detail.Rows.Count;j++)
			{
				
					if ((dt_detail.Rows[j][5].ToString().Trim() != "" ) && (decimal.Parse(dt_detail.Rows[j][5].ToString().Trim()) != 0))
					{
							Longlife = decimal.Parse(dt_detail.Rows[j][5].ToString());
					}
					else
					{
							Longlife = 0;
					}
					if ((dt_detail.Rows[j][3].ToString().Trim() != "")  && (decimal.Parse(dt_detail.Rows[j][3].ToString().Trim()) != 0))
					{
							AddedValue = decimal.Parse(dt_detail.Rows[j][3].ToString());
							depreciation = Longlife /  AddedValue;
					}
					else
					{
							depreciation = 0;
					}
					
					
					
 %>
 <tr class=xl46 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl48 style='height:20.1pt'>&nbsp;</td>
  <td class=xl57><%=k+1%>&nbsp;</td>
  <td colspan=2 class=xl93 style='border-right:.5pt solid black;border-left:  none'><%=dt_detail.Rows[j][0]%>&nbsp;</td>
  <td colspan=2 class=xl96 style='border-right:.5pt solid black;border-left:none'><%=dt_detail.Rows[j][1]%>&nbsp;</td>
  <td colspan=5 class=xl96 style='border-right:.5pt solid black;border-left:  none'><%=dt_detail.Rows[j][6]%>&nbsp;</td>
  <td colspan=2 class=xl99 style='border-right:.5pt solid black;border-left:  none' x:num><%=dt_detail.Rows[j][3]%>&nbsp;</td>
  <td colspan=2 class=xl101 style='border-right:.5pt solid black;border-left:  none'><%=dt_detail.Rows[j][8]%>&nbsp;</td>
  <td class=xl58 x:num><%=dt_detail.Rows[j][5]%>&nbsp;</td>
  <td colspan=3 class=xl102 style='border-right:.5pt solid black;border-left:  none' x:num><%=depreciation%>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
 </tr>

 <%
k+=1;
} 
  %>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl86>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl87>Locaion:</td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=3 class=xl79 x:str="FACTORY: ">FACTORY:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl59><%if(p_Location != "FACTORY"){%>¨<%}else{%>þ<%}%></td>
  <td class=xl60>&nbsp;</td>
  <td colspan=4 class=xl79 style='border-left:none'>HCMO</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl59><%if(p_Location != "HCMO"){%>¨<%}else{%>þ<%}%></td>
  <td class=xl60>&nbsp;</td>
  <td class=xl61>SITE</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl61>&nbsp;</td>
  <td class=xl62><%if(p_Location != "SITE"){%>¨<%}else{%>þ<%}%></td>
  <td class=xl60>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl79 style='border-right:.5pt solid black'>Department: <%=p_Department%></td>
  <td colspan=7 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Cost center: <%=p_CostCenter%></td>
  <td colspan=6 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Status: <%=p_Status%></td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl79 style='border-right:.5pt solid black'>User: <%=p_User%></td>
  <td colspan=7 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Signature:</td>
  <td colspan=6 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl50 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl51 style='height:20.1pt'>&nbsp;</td>
  <td colspan=5 class=xl79 style='border-right:.5pt solid black'>Controler:</td>
  <td colspan=7 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>Signature:</td>
  <td colspan=6 class=xl82 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl52>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl53 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl53 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl87>Division changing:</td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl32 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl33 style='height:24.95pt'>&nbsp;</td>
  <td class=xl63>No.</td>
  <td colspan=3 class=xl104 style='border-right:.5pt solid black;border-left:
  none'>Movement date</td>
  <td colspan=3 class=xl106 style='border-right:.5pt solid black;border-left:
  none'>Ref. to</td>
  <td colspan=3 class=xl106 style='border-right:.5pt solid black;border-left:
  none'>Leaving division</td>
  <td colspan=3 class=xl106 style='border-right:.5pt solid black;border-left:
  none'>Arrival Division</td>
  <td colspan=5 class=xl106 style='border-right:.5pt solid black;border-left:
  none'>Comments</td>
  <td class=xl42>&nbsp;</td>
 </tr>
 <tr class=xl46 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl48 style='height:20.1pt'>&nbsp;</td>
  <td class=xl57>&nbsp;</td>
  <td colspan=3 class=xl93 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl107 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl107 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=3 class=xl107 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=5 class=xl107 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl54>Notes:</td>
  <td class=xl64 colspan=9 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>- User can not change/move/ or transfer
  without authority permission</td>
  <td class=xl64></td>
  <td colspan=6 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl64 colspan=12 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>- User have to keep in good condition, if
  have any problem, inform to the controler of asset</td>
  <td class=xl64></td>
  <td colspan=3 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl64></td>
  <td colspan=15 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'>Purchasing dept.</td>
  <td colspan=6 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'>Accounting dept.</td>
  <td colspan=5 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td class=xl47></td>
  <td colspan=2 class=xl109 style='border-right:.5pt solid black'>Prepared by</td>
  <td colspan=2 class=xl111 style='border-right:.5pt solid black;border-left:
  none'>Reviewed by</td>
  <td colspan=2 class=xl111 style='border-right:.5pt solid black;border-left:
  none'>Approved by</td>
  <td colspan=3 class=xl47 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl109 style='border-right:.5pt solid black'>Prepared by</td>
  <td colspan=2 class=xl111 style='border-right:.5pt solid black;border-left:
  none'>Reviewed by</td>
  <td colspan=2 class=xl111 style='border-right:.5pt solid black;border-left:
  none'>Approved by</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl66>&nbsp;</td>
  <td class=xl67>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td class=xl47></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl66>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl69>&nbsp;</td>
  <td class=xl68>&nbsp;</td>
  <td class=xl70>&nbsp;</td>
  <td colspan=2 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr class=xl46 height=20 style='height:15.0pt'>
  <td height=20 class=xl48 style='height:15.0pt'>&nbsp;</td>
  <td colspan=18 class=xl47 style='mso-ignore:colspan'></td>
  <td class=xl49>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td colspan=18 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl30>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl71 style='height:16.5pt'>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl72>&nbsp;</td>
  <td class=xl73>&nbsp;</td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=20 class=xl24 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=12 style='width:9pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=47 style='width:35pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=30 style='width:23pt'></td>
  <td width=12 style='width:9pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
