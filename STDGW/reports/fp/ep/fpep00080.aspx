<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	ESysLib.SetUser("mafg");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string l_date = Request["p_date"];
    
    
    string l_parameter = "'" + l_date + "'";
    string l_00E_m = "", l_00E_Qty = "", l_00E_Gcapsule = "", l_00_m = "", l_00_Qty = "", l_00_Gcapsule = "",
        l_0E_m = "", l_0E_Qty = "", l_0E_Gcapsule = "",
            l_0_m = "", l_0_Qty = "", l_0_Gcapsule = "", l_1_m = "", l_1_Qty = "", l_1_Gcapsule = "", l_2_m = "",
            l_2_Qty = "", l_2_Gcapsule = "",
            l_2E_m = "", l_2E_Qty = "", l_2E_Gcapsule = "", l_3_m = "", l_3_Qty = "", l_3_Gcapsule = "",
            l_4_m = "", l_4_Qty = "", l_4_Gcapsule = "", daily_rate = "", monthly_qty = "", monthly_rate = "";
    DataTable dtDlStock = ESysLib.TableReadOpenCursor("MAFG.sp_sel_daily_stock", l_parameter);
    DataTable dtPriResult = ESysLib.TableReadOpenCursor("MAFG.sp_sel_printing_result", l_parameter);
    DataTable dtProductStock = ESysLib.TableReadOpenCursor("MAFG.sp_sel_product_stock", l_parameter);
    DataTable dtInOut = ESysLib.TableReadOpenCursor("MAFG.sp_sel_prod_inout_order", l_parameter);
    DataTable dtCapsuleStock = ESysLib.TableReadOpenCursor("MAFG.SP_SEL_PROD_CAPSULE_STOCK", l_parameter);
    
    l_date = l_date.Substring(0, 4) + "." + l_date.Substring(4, 2) + "." + l_date.Substring(6,2);
    string s = DateTime.Now.ToString("HH:mm:ss");
    string ymd = DateTime.Now.ToString("yyyyMMdd");
    ymd = ymd.Substring(0, 4) + "." + ymd.Substring(4, 2) + "." + ymd.Substring(6, 2);

    string yymmddHms = ymd + "  " + s;
    for (int i = 0; i < dtCapsuleStock.Rows.Count; i++)
    {
        daily_rate=dtCapsuleStock.Rows[0][4].ToString();
        monthly_qty= dtCapsuleStock.Rows[0][5].ToString();
        monthly_rate = dtCapsuleStock.Rows[0][6].ToString(); 
          
        if (dtCapsuleStock.Rows[i][0].ToString()=="00E")
        {
            l_00E_m = dtCapsuleStock.Rows[i][1].ToString();
            l_00E_Qty = dtCapsuleStock.Rows[i][2].ToString();
            l_00E_Gcapsule = dtCapsuleStock.Rows[i][3].ToString();
        }
        if (dtCapsuleStock.Rows[i][0].ToString() == "00")
        {
            l_00_m = dtCapsuleStock.Rows[i][1].ToString();
            l_00_Qty = dtCapsuleStock.Rows[i][2].ToString();
            l_00_Gcapsule = dtCapsuleStock.Rows[i][3].ToString();
        }
        if (dtCapsuleStock.Rows[i][0].ToString() == "0E")
         {
            l_0E_m = dtCapsuleStock.Rows[i][1].ToString();
            l_0E_Qty = dtCapsuleStock.Rows[i][2].ToString();
            l_0E_Gcapsule = dtCapsuleStock.Rows[i][3].ToString();
         }
         if (dtCapsuleStock.Rows[i][0].ToString() == "0")
         {
            l_0_m = dtCapsuleStock.Rows[i][1].ToString();
            l_0_Qty = dtCapsuleStock.Rows[i][2].ToString();
            l_0_Gcapsule = dtCapsuleStock.Rows[i][3].ToString();
         }
         if (dtCapsuleStock.Rows[i][0].ToString() == "1")
         {
            l_1_m = dtCapsuleStock.Rows[i][1].ToString();
            l_1_Qty = dtCapsuleStock.Rows[i][2].ToString();
            l_1_Gcapsule = dtCapsuleStock.Rows[i][3].ToString();
         }
         if (dtCapsuleStock.Rows[i][0].ToString() == "2")
         {
            l_2_m = dtCapsuleStock.Rows[i][1].ToString();
            l_2_Qty = dtCapsuleStock.Rows[i][2].ToString();
            l_2_Gcapsule = dtCapsuleStock.Rows[i][3].ToString();
         }
         if (dtCapsuleStock.Rows[i][0].ToString() == "2E")
         {
            l_2E_m = dtCapsuleStock.Rows[i][1].ToString();
            l_2E_Qty = dtCapsuleStock.Rows[i][2].ToString();
            l_2E_Gcapsule = dtCapsuleStock.Rows[i][3].ToString();
         }
         if (dtCapsuleStock.Rows[i][0].ToString() == "3")
         {
            l_3_m = dtCapsuleStock.Rows[i][1].ToString();
            l_3_Qty = dtCapsuleStock.Rows[i][2].ToString();
            l_3_Gcapsule = dtCapsuleStock.Rows[i][3].ToString();
         }
         if (dtCapsuleStock.Rows[i][0].ToString() == "4")
         {
            l_4_m = dtCapsuleStock.Rows[i][1].ToString();
            l_4_Qty = dtCapsuleStock.Rows[i][2].ToString();
            l_4_Gcapsule = dtCapsuleStock.Rows[i][3].ToString();
         }
    }

%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="aa_files/filelist.xml">
<link rel=Edit-Time-Data href="aa_files/editdata.mso">
<link rel=OLE-Object-Data href="aa_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Nguyen Van Thai</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-08-26T12:56:21Z</o:LastPrinted>
  <o:Created>2009-08-26T11:28:05Z</o:Created>
  <o:LastSaved>2009-09-18T01:43:14Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .2in .28in .2in;
	mso-header-margin:.17in;
	mso-footer-margin:.17in;
	mso-page-orientation:landscape;}
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
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl25
	{mso-style-parent:style0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	text-align:center;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl27
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl32
	{mso-style-parent:style0;
	font-size:20.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl33
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl37
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl38
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl39
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl40
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl41
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl42
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl43
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl44
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl47
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl48
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl49
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl50
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl51
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl52
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl53
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl54
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl55
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl56
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl57
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl58
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl59
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl60
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl61
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl62
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl70
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl71
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl73
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl74
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl75
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl77
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl78
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl79
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl80
	{mso-style-parent:style0;
	mso-number-format:"\#\,\#\#0";
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:yellow;
	mso-pattern:auto none;}
.xl81
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl82
	{mso-style-parent:style0;
	mso-number-format:Standard;
	text-align:right;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl83
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl84
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl85
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl86
	{mso-style-parent:style0;
	text-align:center;}
.xl87
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl88
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl89
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl90
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl91
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl92
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;}
.xl95
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl96
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl98
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl99
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl100
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl101
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl102
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl103
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl104
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;}
.xl105
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl106
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl107
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl108
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl109
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl110
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl111
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl112
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl113
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>2</x:LeftColumnVisible>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>8</x:ActiveCol>
       <x:RangeSelection>$I$16:$J$19</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8400</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1935</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1026"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1024 style='border-collapse:
 collapse;table-layout:fixed;width:768pt'>
 <col width=64 span=16 style='width:48pt'>
 <tr height=48 style='mso-height-source:userset;height:36.2pt'>
  <td colspan=16 height=48 class=xl32 width=1024 style='height:36.2pt;
  width:768pt'>Daily Report</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=6 rowspan=2 height=34 class=xl113 style='height:25.5pt'></td>
  <td colspan=4 rowspan=2 class=xl111>Operation date:&nbsp;<%=l_date%></td>
  <td colspan=6 rowspan=2 class=xl112>Print date:&nbsp;<%=yymmddHms %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=5 height=17 class=xl33 style='height:12.75pt'>&lt;Product
  Take-in/Take Out and Order &gt;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl34>(Unit:1000 pcs)</td>
  <td></td>
  <td colspan=2 class=xl33>&lt;Material Stock&gt;</td>
  <td class=xl24></td>
  <td colspan=2 class=xl35>(Unit: Kg)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 rowspan=2 height=34 class=xl36 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:25.5pt'>Section</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Daily</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Monthly Total</td>
  <td colspan=4 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Comparision monthly result with target</td>
  <td></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>Section</td>
  <td colspan=3 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Quantity</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Gelatin Capsule</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Gelatin Capsule</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Target(G.Capsule)</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Comparision(%)</td>
  <td></td>
  <td rowspan=3 class=xl42 style='border-bottom:.5pt solid black;border-top:
  none'>Gelatin</td>
  <td class=xl25>Type A</td>
  <td colspan=3 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][0].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt'>Take In</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][0].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][1].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][2].ToString()%></td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][3].ToString()%></td>
  <td></td>
  <td class=xl25>Type B</td>
  <td colspan=3 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][1].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=3 height=51 class=xl42 style='border-bottom:.5pt solid black;
  height:38.25pt;border-top:none'>Take Out</td>
  <td class=xl25>Domestic</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][4].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][5].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][6].ToString()%></td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][7].ToString()%></td>
  <td></td>
  <td class=xl26 style='border-top:none;border-left:none'>Total</td>
  <td colspan=3 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][2].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>Export</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][8].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][9].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][10].ToString()%></td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][11].ToString()%></td>
  <td colspan=6 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl26 style='height:12.75pt;border-top:none;border-left:
  none'>Total</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][12].ToString()%></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][13].ToString()%></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][14].ToString()%></td>
  <td colspan=2 class=xl55 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][15].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl33>&lt;Printing Result&gt;</td>
  <td colspan=3 class=xl34>(Unit : 1000 pcs)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=3 height=51 class=xl42 style='border-bottom:.5pt solid black;
  height:38.25pt;border-top:none'>Order</td>
  <td class=xl25>Domestic</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][16].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][17].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][18].ToString()%></td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][19].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>Section</td>
  <td colspan=3 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Quantity</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 style='height:12.75pt'>Export</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][20].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][21].ToString()%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][22].ToString()%></td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][23].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>Printing Qty
  Daily</td>
  <td colspan=3 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtPriResult.Rows[0][0].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt;border-left:none'>Total</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][24].ToString()%></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][25].ToString()%></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][26].ToString()%></td>
  <td colspan=2 class=xl55 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtInOut.Rows[0][27].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>Printing Qty
  Monthly</td>
  <td colspan=3 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtPriResult.Rows[0][1].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 height=17 class=xl33 style='height:12.75pt'>&lt;Printed Product
  and WIP&gt;</td>
  <td colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl34>(Unit : 1000 pcs)</td>
  <td></td>
  <td colspan=5 class=xl33>&lt;Production Result / Tranparent Capsule Stock&gt;</td>
  <td></td>
  <td colspan=2 class=xl34>(Unit : 1000 pcs)</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=3 rowspan=2 height=34 class=xl36 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:25.5pt'>Section</td>
  <td colspan=2 rowspan=2 class=xl36 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Target</td>
  <td colspan=2 rowspan=2 class=xl36 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Result</td>
  <td></td>
  <td colspan=2 rowspan=4 class=xl36 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>Section</td>
  <td colspan=4 rowspan=2 class=xl61 width=256 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:192pt'>Equipment operation according to
  type of Product/Production Result</td>
  <td colspan=2 rowspan=2 class=xl61 width=128 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:96pt'>Unprinting stock of transparent
  Capsule</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=4 height=68 class=xl70 style='border-bottom:.5pt solid black;
  height:51.0pt;border-top:none'>WIP</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Unprinting</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][3].ToString()%></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][4].ToString()%></td>
  <td></td>
  <td colspan=6 class=xl72 style='border-right:.5pt solid black;border-left:
  none'>Gelatin Capsule</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Waiting for Printing</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][5].ToString()%></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][6].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black;border-left:
  none'>Running Machine</td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black;border-left:
  none'>Product Qty Daily</td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black;border-left:
  none'>Unprinting Qty</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Printing</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][7].ToString()%></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][8].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black'>#00E</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_00E_m%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_00E_Qty%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_00E_Gcapsule%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Waiting for Packing</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][9].ToString()%></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtDlStock.Rows[0][10].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black'>#00</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_00_m%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_00_Qty%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_00_Gcapsule%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black'>#0E</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_0E_m%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_0E_Qty%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_0E_Gcapsule%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl33 style='height:12.75pt'>&lt;Product
  Stock&gt;</td>
  <td colspan=3 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl34>(Unit : 1000 pcs)</td>
  <td></td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black'>#0</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_0_m%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_0_Qty%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_0_Gcapsule%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=4 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt'>Section</td>
  <td class=xl28>Domestic</td>
  <td class=xl29>Export</td>
  <td class=xl29>Total</td>
  <td></td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black'>#1</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_1_m%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_1_Qty%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_1_Gcapsule%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 rowspan=10 height=170 class=xl36 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:127.5pt'>Finished Product</td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'>Printed</td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][0].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][1].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][2].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black'>#2</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_2_m%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_2_Qty%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_2_Gcapsule%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Unprinting</td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][3].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][4].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][5].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black'>#2E</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_2E_m%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_2E_Qty%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_2E_Gcapsule%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl78 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Total</td>
  <td class=xl31 style='border-left:none' x:num><%= dtProductStock.Rows[0][6].ToString()%></td>
  <td class=xl31 style='border-left:none' x:num><%= dtProductStock.Rows[0][7].ToString()%></td>
  <td class=xl31 style='border-left:none' x:num><%= dtProductStock.Rows[0][8].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black'>#3</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_3_m%></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_3_Qty%></td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_3_Gcapsule%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Transparent</td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][9].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][10].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][11].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl72 style='border-right:.5pt solid black'>#4</td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_4_m%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_4_Qty%></td>
  <td colspan=2 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:num><%= l_4_Gcapsule%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Opaque</td>
  <td class=xl30 style='border-left:none' x:num><%= dtProductStock.Rows[0][12].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][13].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][14].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl78 style='border-right:.5pt solid black'>Total</td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=SUM(K20:L28)"></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=SUM(M20:N28)"></td>
  <td colspan=2 class=xl52 style='border-right:.5pt solid black;border-left:
  none' x:num x:fmla="=SUM(O20:P28)"></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl78 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Total</td>
  <td class=xl31 style='border-left:none' x:num><%= dtProductStock.Rows[0][15].ToString()%></td>
  <td class=xl31 style='border-left:none' x:num><%= dtProductStock.Rows[0][16].ToString()%></td>
  <td class=xl31 style='border-left:none' x:num><%= dtProductStock.Rows[0][17].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>Daily Rate(%)</td>
  <td colspan=2 class=xl81 style='border-right:.5pt solid black;border-left:none' x:num><%= dtCapsuleStock.Rows[0][4].ToString()%></td>
  <td colspan=4 rowspan=3 class=xl84 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Type A</td>
  <td class=xl30 style='border-left:none' x:num><%= dtProductStock.Rows[0][18].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][19].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][20].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>Monthly Qty</td>
  <td colspan=2 class=xl45 style='border-right:.5pt solid black;border-left:
  none' x:num><%= dtCapsuleStock.Rows[0][5].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Type B</td>
  <td class=xl30 style='border-left:none'><%= dtProductStock.Rows[0][21].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][22].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][23].ToString()%></td>
  <td></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black'>Monthly Rate(%)</td>
  <td colspan=2 class=xl81 style='border-right:.5pt solid black;border-left:none' x:num><%= dtCapsuleStock.Rows[0][6].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl40 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Blending</td>
  <td class=xl30 style='border-left:none' x:num><%= dtProductStock.Rows[0][24].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][25].ToString()%></td>
  <td class=xl30 align=right style='border-left:none' x:num><%= dtProductStock.Rows[0][26].ToString()%></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 height=17 class=xl78 style='border-right:.5pt solid black;
  height:12.75pt;border-left:none'>Total</td>
  <td class=xl31 style='border-left:none' x:num><%= dtProductStock.Rows[0][27].ToString()%></td>
  <td class=xl31 style='border-left:none' x:num><%= dtProductStock.Rows[0][28].ToString()%></td>
  <td class=xl31 style='border-left:none' x:num><%= dtProductStock.Rows[0][29].ToString()%></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=11 rowspan=4 height=68 class=xl90 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:51.0pt'>Remark:</td>
  <td rowspan=4 class=xl99 width=64 style='border-bottom:.5pt solid black;
  width:48pt'>Approved by</td>
  <td colspan=2 class=xl102 style='border-right:.5pt solid black;border-left:
  none'>Manager</td>
  <td colspan=2 class=xl104 style='border-right:.5pt solid black;border-left:
  none'>Plant Director</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=2 rowspan=3 height=51 class=xl83 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:38.25pt'>&nbsp;</td>
  <td colspan=2 rowspan=3 class=xl83 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 colspan=6 style='height:20.25pt;mso-ignore:colspan'></td>
  <td rowspan=2 height=44 width=64 style='mso-ignore:colspan-rowspan;
  height:33.0pt;width:48pt'><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" alt="" style='position:absolute;
   margin-left:14;margin-top:-11;width:30pt;height:32pt;z-index:1'>
   <v:imagedata src="http://20.20.1.11/esys/reports/fp/ep/sh_logo.bmp"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=40 height=40
    src="http://20.20.1.11/esys/reports/fp/ep/sh_logo.bmp" v:shapes="_x0000_s1025"></td>
    <td width=24></td>
   </tr>
   <tr>
    <td height=14></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:33.0pt'></span><![endif]--></td>
  <td colspan=9 class=xl110>Suheung Vietnam Co., Ltd</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=6 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=9 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
